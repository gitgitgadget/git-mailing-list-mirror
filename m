Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411A156E4
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058550; cv=none; b=DapMfDkCo1c9goAIuSA+LRRzBdRKrtDPTq9Y/PvAQ6r+L0/6Rwx5ZezFT9mcmi4eFZAgmABIeTwAjpkR/beCLUn77Z4Ux4qVwtCwhhKYZ1+rfIRhdCVjfitJLR+Il5kA1yud2t3R6KVFwehhBshn9gbhtCJnGuyxymXJpNdqI5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058550; c=relaxed/simple;
	bh=AHHWkt2+TjTQiBS1cN24JWNM/CcFvN66SWXLD6KUQq4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QHh66sqjRZhRsUcnUiXwiNOcldX9cmPfdUGnL1qxF07a/QoB+DYsaeFZPXXRSeKeqGkHVPduWPixS7rJw2YHRVhhSPtrJu37JMVY3b0F23ykr35IqCRr1piL5R24CAppyddRygahwlGqhXepmx/XBLMd1xT8K2ckuQJaGOGQyPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=bm5BDVVw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E9VdX6lo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="bm5BDVVw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E9VdX6lo"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A690D1380084;
	Wed, 16 Oct 2024 02:02:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 16 Oct 2024 02:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729058547;
	 x=1729144947; bh=AHHWkt2+TjTQiBS1cN24JWNM/CcFvN66SWXLD6KUQq4=; b=
	bm5BDVVwPw6cz8EL2NetZeFOJd1sH78INOfaMOEtbe12+xuMe9Og2Hac/yrQ+ExU
	adhLl8reFAEBIHfwAecQeCtFUbCvxkC9eVowTQgA3rQiTAPEFiXI/4P69eT1MvNa
	NsvlUltDKI8F0ooP0YXD5xMGK9qZVLdz8N+i+YCKet/AbpWZ02wLx/tdM9gmfTru
	65yf+JT6/q1jCF1eNW5rTAwBWDwAGPK3+BosMZSStjUhhMg/tYRHNOJOhfbkx0so
	1ox5/NjTpTNn7BjP4a3XbMsJFZTMB/nDlvfxFQx1XoeZlp+W6MMn+XsIONcgPTG5
	vWe7Y7CrjvI5F1KtDR1bvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729058547; x=
	1729144947; bh=AHHWkt2+TjTQiBS1cN24JWNM/CcFvN66SWXLD6KUQq4=; b=E
	9VdX6loqi6ChIAwmddpDPqm4Q0MStokKhy/CsE90ZaS3653NJBcT3ohJrrBKdSIb
	ElKi8o/kJN+3UW4M2RyAUD4AmR8Cxzd7WzvEqJcOXWaOd3HYoWxdJm14Tl9HSIjJ
	QOsXEZMizfbI8cHmmW9jKYPfH0qikp8Xjin4O4DrUMWZJ3FbezgRVKqeA/M95GHv
	1/4mHhp4PA03ExCmqCtoSAC+DBsrB50VbL0EOYhUwtoz85O7jfgn1EgsNv+ke8mC
	lw41XykLQC8t1ehzQJ3e1enCjqls/QKUXC1irm6I2iM/UL8RddYad0QRaJinxG/s
	ZMn0rcmVIEH056FoqKpVg==
X-ME-Sender: <xms:81YPZ-wQWmIp-5Vd179B2Q3Uum07zYRxz4NhSqNvFrgopZ3PBfGxDw>
    <xme:81YPZ6RYE1Wnw669Fvcvu4T5fCUr9CeI3tjSDLftBOFmEZhR7Dw7awVd4iAUFhqoK
    f4i4XbJJ8Elj_aImQ>
X-ME-Received: <xmr:81YPZwVucIHYAAn6hVVxYVNIxIF4mTbshti25xBH0dYGBvaM6xRlU8ZJQUEv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
    jeenucfhrhhomhepfdflrghmvghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuh
    drihhoqeenucggtffrrghtthgvrhhnpeffueektdeigfejhfehhfegleeigeduvdevueej
    jefhgedtvdeihfejtedukeejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjrghmvghssehjrghmvghslhhiuhdrihhopdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:81YPZ0jCNid8rHLiSa2JNdfNNc-kUIjLSDRSdLo5H70WVHfmxPn_ig>
    <xmx:81YPZwAtgaunQsoOSMvc1uRJUHAa-fF5U5_srWl8qg_Dfeb7VZ17Xg>
    <xmx:81YPZ1LFVBHyGYCtsBDpjBW2cOcTrKbeErxGWpLwlu8wYi0pNLklBA>
    <xmx:81YPZ3BBlQB6HS4iZhfZTSiWIIwvSvlpXBlMvEPix13SEGlpRgBx4A>
    <xmx:81YPZz-OAyHRIcz3Y-T6RGcEIXtk2kdflKKAq_Ow-GTbLy4zMZYdU96P>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 02:02:25 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 17:02:24 +1100
Message-Id: <D4X03LIWX1C0.1RGNH9U3SMF51@jamesliu.io>
Cc: "Taylor Blau" <me@ttaylorr.com>, "Eric Sunshine"
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 06/10] t3404: work around platform-specific behaviour
 on macOS 10.15
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
 <1daadd82766a59577580dc386b91a942b0df6e15.1728992306.git.ps@pks.im>
In-Reply-To: <1daadd82766a59577580dc386b91a942b0df6e15.1728992306.git.ps@pks.im>

On Tue Oct 15, 2024 at 10:45 PM AEDT, Patrick Steinhardt wrote:
> Two of our tests in t3404 use indented HERE docs where leading tabs on
> some of the lines are actually relevant. The tabs do get removed though,
> and we try to fix this up by using sed(1) to replace leading tabs in the
> actual output, as well. But macOS 10.15 uses an oldish version of sed(1)
> that has BSD lineage, which does not understand "\t", and thus we fail
> to strip those leading tabs and fail the test.

The subtle differences in BSD and GNU-sed have caused me some headache
in the past. I always work around the problem locally by installing the
`gnu-sed` package via Homebrew, but it's better to change the test here.


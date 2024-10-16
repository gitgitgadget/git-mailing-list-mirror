Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE95221
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058316; cv=none; b=gsyd+WBghhN6puAH6gvJOflWcKBeHDO/S8qbn1I+X6bTa33V84P94DlyH2GMUFpv3keZLdO/rA2CsghikGazRsg9iF0j2dIFsotu6pEJ6tD+juZdWHMkwzws0d7xStgNDFqu0Eh3dgZK3oOp1zSeBAaPLtxYX8vEJUjH4oFq2bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058316; c=relaxed/simple;
	bh=03biJJtTFyB+dPqKdop6XGQc+RbuxMBxp03dY8C/W38=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Me046917jjSVP/9JnQmqQrw/OQgAS8F8hYstlf8b3R/vYP8qlUs4MfRZ3AxctO5Jnin084RzyDcCSI+a6TL4iUcn6nmLnj6N0n3PyMBVODdFqmYfcdftYmS+OKF7p/FITO6+fURtVv0AHuxn4VclGgiS8/P/MhzFWuJETWiwuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=ax/8LbrY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQAhXt3D; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="ax/8LbrY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQAhXt3D"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D7E5613801D4;
	Wed, 16 Oct 2024 01:58:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 16 Oct 2024 01:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729058312;
	 x=1729144712; bh=03biJJtTFyB+dPqKdop6XGQc+RbuxMBxp03dY8C/W38=; b=
	ax/8LbrYoqJzjHWbo6z/b1KF+InYFtd9prg4dv4p4MYPd1ArEC1XGYbG3iu9SS9T
	I1vrFSzjv0dVzvz4q0AQK0M0KHKrc7sv0z/4cc6s5+IcQSI/sDRawtoRmBDXWxDv
	LGj1FRtTAyI0GSDPU8P2k9QEfLLVePoejdtnwLUvKfNJwPGsM7/ruMK3B0VZt3Bc
	CDIlba0rgSENc4WFqJj18xrG298ffFIKTwzAZlJiwxBWMbb+Mh39+eO4JMO45N3H
	B2LDaAQn1sGOOyzaQJ9RliyvyU8rai/0pHkDNf8SmBFykLZ6EIuF5Dm6iwj3Ah4h
	yjPpyCcbDuZ/EiQfraBokw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729058312; x=
	1729144712; bh=03biJJtTFyB+dPqKdop6XGQc+RbuxMBxp03dY8C/W38=; b=D
	QAhXt3DVY6AZK5b5PaI/MFskzgC8kaiCUTy3vZ9ieA8O4wafDQ64DVtHn/tTg/X+
	LGcptDlvAiF6lf9XbhT//OmnMmz3np6csdDQuf4VtXyj+gl7FeYsK4nnhh2fZdxX
	d8erRBlUOA6UrTDIMCZVt7UBPG0fLz5V+lG687uQ/O/ZK5g0FDXc9wf7TB40ksGe
	J0vInHowzPlrFZeV2fuNUmfXeQAx5o8h4o2OWORK/ft9BcMT3DNPmaLb1qck2csb
	dlvZGILWi0/E7cAn/pWzlN55D6ZlJsNOyYzwEED2YV+0YNsRyPQy86Tqsk35Nf+A
	hxlXLEiAYm4HfE8xUTc5w==
X-ME-Sender: <xms:CFYPZ2z8aU4HkSUeqLC4QPqExUjpCe4kCIjnLRdZXB4gWy81UQvC1A>
    <xme:CFYPZySebz9p3MRlFVuSI13LIQUlPV1pnosidaJVGlgw7Se_pANLQW-8EADsiY7uF
    32iH1HhytkOKteORg>
X-ME-Received: <xmr:CFYPZ4UFK0OtZgrotP1hXA1gg5Wl_l6sUHg2D-YwfzvBtgnjEmQzkumU9jkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvfevuffhofhfjgesthhqredtredt
    jeenucfhrhhomhepfdflrghmvghsucfnihhufdcuoehjrghmvghssehjrghmvghslhhiuh
    drihhoqeenucggtffrrghtthgvrhhnpeeiuedvkeeuvdffieefjeeuhedtvdehffekvedv
    ueduteehudeiffffhfffhfduudenucffohhmrghinhepmhhitghrohhsohhfthdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrghm
    vghssehjrghmvghslhhiuhdrihhopdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:CFYPZ8hDxvFWT014B1b1lpbV_77fu3BGe2rxrXPV_Y81JtambC9Z3A>
    <xmx:CFYPZ4BQ9Dqd8XtUSETbFpPgUtc0fc7OEMco4bvc-e521oFlB_LQrg>
    <xmx:CFYPZ9LiP1Geg8XgLo6HvguZNMkR5IxEX5rX7aQiON1DM2G261n1gw>
    <xmx:CFYPZ_DQMaZITcKCZkt6wIYY9DirFttY0vkwcE7ADq57YXIXIGVFzQ>
    <xmx:CFYPZ7-N0vTM6qsqppY_6dlA8ddPpROZ70u9orkxmjm19S4LxL22RObq>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 01:58:30 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 16:58:29 +1100
Message-Id: <D4X00LKYK3TS.3DS67LXPIT9GU@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
Cc: "Taylor Blau" <me@ttaylorr.com>, "Eric Sunshine"
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 05/10] t1401: make invocation of tar(1) work with
 Win32-provided one
From: "James Liu" <james@jamesliu.io>
X-Mailer: aerc 0.18.2
References: <cover.1728906490.git.ps@pks.im>
 <cover.1728992306.git.ps@pks.im>
 <58691dd652b23f2c630eba71bb9b93700ab66a09.1728992306.git.ps@pks.im>
In-Reply-To: <58691dd652b23f2c630eba71bb9b93700ab66a09.1728992306.git.ps@pks.im>

On Tue Oct 15, 2024 at 10:45 PM AEDT, Patrick Steinhardt wrote:
> Windows nowadays provides a tar(1) binary in "C:\Windows\system32". This
> version of tar(1) doesn't seem to handle the case where directory paths
> end with a trailing forward slash. And as we do that in t1401 the result
> is that the test fails.

Native explorer.exe support for .tar (and a bunch of other archive
formats) was added as part of KB5031455 [1] not too long ago. It just
uses libarchive under the hood, and was a huge QoL improvement for me
when I was running Windows full-time at home!

[1] https://support.microsoft.com/en-us/topic/october-31-2023-kb5031455-os-=
builds-22621-2506-and-22631-2506-preview-6513c5ec-c5a2-4aaf-97f5-44c13d29e0=
d4

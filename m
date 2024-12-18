Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E29154C07
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734501402; cv=none; b=t/1vWYroT10cVbVQtXKMv1gWA7ICA2ZNgYHz+ii8ncmbwpesKG2zEgZtACerPgUIXVFnKnh/ABGyavs7M6Yy35+N12kSxnfh02bWJ9Msl/Ztb5K3I8/dIL4Sxy7PjT+1vb4He8wQ2mAvzKP7fAA8rBLyU5I2zofQYgEgRsQIkQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734501402; c=relaxed/simple;
	bh=+k+DPUxBipm2SL1IG7oUKL6xIaPUnmcmwBrh0RgdFbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxFm7Tr0Iy3dL+JXizMP3SmelnjSH3e3yfQUW+GoLynVVW1uwrWJLeNlDzCYEUGwbHM4mv2I4AC7dHEVXAMzOGknW3nIpMMFLKozMHrAV5PqtQJSS5muagfZF2T/YKAQMaH7eu1uiPY1PiS/dlyoKfrqBNaD3xbBsxl9ER/gkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gJ34OD9o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=STwCJ84P; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gJ34OD9o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STwCJ84P"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 88E0F13801E8;
	Wed, 18 Dec 2024 00:56:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 18 Dec 2024 00:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734501399; x=1734587799; bh=wMjg6m7tvR
	3C4oMaSe2tkaIdXTswKFJq6b6c+iEX/Nw=; b=gJ34OD9orVCmxS87H2A7jKiSUD
	4Cuy+PRk1EOQZNOF//D6astoe3okej1ijj15A3BUsFEGE56xScHtzqt/EJvwbVJm
	Owjjz5gnSH4h2F3+APD24yqAF2of7sTp9L8OI7EbNsVwuI/IloFw+zFSNRSi5UGI
	CBvUO3OiNL7vVOR3B+j2b38DH20zuUiYcIpgXbmqwniQaeDqs1gCuAsxDQ96/uCp
	TsWhAYTWgPEHPSYkd4eS8tlzb9hja4UoVnbUUgJ3cOSfEIGmT7qx47x0QwrNonmF
	6KxM4Zoe2+sTG1yu13RlMKrJ5hnW61Fi4uvmDHzwejNBLvU8Zps1LJUSysLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734501399; x=1734587799; bh=wMjg6m7tvR3C4oMaSe2tkaIdXTswKFJq6b6
	c+iEX/Nw=; b=STwCJ84PVVZQDkV7Li/PKfA6yU3L3Jyl1iq3n37X9V5ex/urojb
	bgE53u+i2EUEBdZHqTWtRzI7IC0dkKIQd6A54KFvII+s0REh6sFS42UUe3aT4Dc8
	n2ThfVGnwkRP4KT/1avrn8bWa9TJrtO3HarTqXf3TnthvaP6yXmL1y/wlH0b8fNU
	cCfQHx6fi96nLGEZFdXMJi/8szCP5cEn7gdda++VEdGkVv3x52+r/X+xP37nEEY/
	BX4PoCHZSRBPKzt0qiU9Wf8mktKrU85GxW3WFGeGyN7GP+pcgpOyH8H+mWXSlhdb
	Zm+WTsVLIN4JI+C+Hxi7zsV33sIdmjW6F7g==
X-ME-Sender: <xms:F2RiZ1xvzotfxYL-oshiMOKMGdMC3NLmoTL6uPyBRaNEyBYOg_YsLg>
    <xme:F2RiZ1QuuLfx7Tgzd8TqYE4Jbx8O3CWVUpKYE-cbIY52YueM8feF1JlFSZ2V4uVZw
    aCTXD3rKteGJDUTPw>
X-ME-Received: <xmr:F2RiZ_WJ2zcGQCN-h030EanRpdkCe6LZhHP7lT4U87Ydb1FzgeTKlm7_RcPb6cor1agwJjVCWLzrSwi-FXrojqjfG1gnqrsqDoHJa6lBt2gc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleejgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:F2RiZ3hHK-8tpcQ3yH5Ycm5TG-cISxW7vObi4899O6SGn0uIugyCsA>
    <xmx:F2RiZ3ACh-bK2yBuDU3qgxM1z85eP8Yt-CfkJQKdsSpzw_KllJDCoA>
    <xmx:F2RiZwJG01OKg_WVQ1hONARRfgsF7qWOORqjbpQZgftG8Y_7lbRArA>
    <xmx:F2RiZ2AsUDq_-hFZaqoBGUUf8ufovE1QHp29GxpiJXrfIgWVEPp76w>
    <xmx:F2RiZy_ntq553sMjQVTACQA7S1pY0Q9YGzISNZ_Hz8EkfJror_s5PbwN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 00:56:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7cf31f27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Dec 2024 05:54:52 +0000 (UTC)
Date: Wed, 18 Dec 2024 06:56:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] GitHub ci(windows): speed up initializing Git for
 Windows' minimal SDK again
Message-ID: <Z2JkBv87zXik5QJa@pks.im>
References: <pull.1841.git.1734447458896.gitgitgadget@gmail.com>
 <xmqqldweyrqx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldweyrqx.fsf@gitster.g>

On Tue, Dec 17, 2024 at 12:33:10PM -0800, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > This commit partially reverts 91839a88277 (ci: create script to set up
> > Git for Windows SDK, 2024-10-09).
> 
> Thanks, will queue.

Okay. Too bad that things regressed this badly with the change. I agree
that reverting is the right thing to do for now. I may revisit this
again in the next release cycle to investigate whether we can get it up
to par with the GitHub Actions. It would be great if the build infra was
shared between our CIs, so I think there's some value in it. But if the
answer is "no" then I guess that's ultimately fine, as well.

Thanks!

Patrick

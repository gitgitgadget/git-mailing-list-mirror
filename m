Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B2915CD41
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 09:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316187; cv=none; b=t/p+u74eKvpEU1vrFA1c6bDN1119nNgxD/DKyAudodf8mIFWumLOtQWicjRCJ4ruFUgjeX8WVb4bvfmj+/2DdiYpEWo6KX9de3yWQMOAy25n6duEQLlw3XbS6Mzp6UdPRaFlD0J+pkAW196f//yYPP0tHU7CAKFzr4W9fcSnxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316187; c=relaxed/simple;
	bh=2uCe5l0P2YZZDrwSa3JxmANzuDZv5/q7bLT6Fs+S2IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA06OpHd22GDS53PfMdU6vc2NcXtnYFgABoY/D/fpV6jXF1OIxCkodzgPEtlxmKBTLZAB9fq+trzxCiLkq3V9HvFbBpdtWtldZDDchFfYhiSceYVcG+zkGncHI3dFZZC6cWC0PBwjS0wifMXPtClPGTS0vAFSTxE5yo6YWleBQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V3/YVdMO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NgDB9duu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V3/YVdMO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NgDB9duu"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFF621140152;
	Mon, 11 Nov 2024 04:09:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 11 Nov 2024 04:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731316184;
	 x=1731402584; bh=/lEDD5SyUk+YLSw6fbO/wZZAoVttI7Ty72S0tgaQ5e8=; b=
	V3/YVdMOqCyV30x0/ZRDn7RbD2RYERaUxfRpaBHnTvkIgpZfdC2EmWU7cjYY4IIp
	nScR69sbCaO8Cg9th3u/GKbhREKWOIgZfrJe7yXijA9bXtwutHtEOIj3WBBhM+tY
	k08VplRSd824KMzeBVCTV4uLRVscvrTj745+Q3flYgzbxv42QTyr0Xvp7xW6g6Zn
	7I/lo7dbRLo8zkwc9CQ2EL2jjjrH1H8ce14/aWDnvFMjXLAR8Msb5+zcaDJMkyuD
	p1+3o6Swc0LeExkqSLLwMMOnrQR5v34z5ep1foywHD//GFegvoBmEp7QQwNpkEw1
	kvBnd+xZ7s7js9Jofq7jsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731316184; x=
	1731402584; bh=/lEDD5SyUk+YLSw6fbO/wZZAoVttI7Ty72S0tgaQ5e8=; b=N
	gDB9duu+ZqHhBGqUJNFb+InyncD/GsTN5xRU0LiOCzFCb4aJSDCm017Ic1S7tbhs
	Hq36+wkgdOmPtdRKIwCrIU8xoNd20KchpWXoDKNESBs50Ewsce7knDrSB2kX2RKh
	mREFgTgQ+UrO3Qv6xaYnePw9jAgP2gvD4mTqWiEZJ6Yks/oyE0EQDcSpIHuu1wAn
	eJHAhqGRT/BrL/5NFcZVJtnw6gMBF8CsILmD5xugJ0WjNtIFYuDauUgD9Y7yjAEn
	uGd/LKKMZ+bM4X2mCx3YBJWM8lBEbE5mgKGfuNm4bPUZ5kSNNB8CMXLflDsiIDkn
	xegV+fKmT/UD3hPF1qPag==
X-ME-Sender: <xms:2MkxZzsjIKtRebcIqrpF9WCOOpFlsS13RrNUxnM2Bsk-fBzBHc3J6g>
    <xme:2MkxZ0cesKhVBgOWuqtNMcB9bgcgiUxGzJfJGIinDLTasZQTnrt47BwyV0wYj7Fpj
    AeVU_xDvhlUWfhFLg>
X-ME-Received: <xmr:2MkxZ2wGBYHnAZot7umrF6Oo5RmbvDwb-pYwC_N04hl8k_JBpKEQ5d12TwSS8HRVx8SGbUOtuw39siI9strQEC3LW6AUrjsOGwQK4C8op2_t7jp3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfurfetoffk
    rfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculd
    dquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveev
    jeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprhhjuhhsthhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2MkxZyMwXEujRYioybCzV-gLyAY1RnJsIS70CrsYjix_ebmYunKdaw>
    <xmx:2MkxZz-1B-C5JjjYnA4uKMyIqSWfJUzjQNWw5_rfVu24nUKxXYBp8g>
    <xmx:2MkxZyViGYkMg83wV5Gb9CzGjNAU2puFS1OX2zyII0fAMe2e13x9IQ>
    <xmx:2MkxZ0eZtTCG7v6NfX5gE3-JavBiI-JOQFO4Yzv6P87lFJM3sd_niA>
    <xmx:2MkxZ1KLdrqSls0BanGLbYgHYp5qiFQn2rjw5KWLRI6tphb8NT5OSPDr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 04:09:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 696bffdf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 09:09:10 +0000 (UTC)
Date: Mon, 11 Nov 2024 10:09:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 21/26] git-compat-util: drop `UNLEAK()` annotation
Message-ID: <ZzHJz_E2lEiAHr45@pks.im>
References: <cover.1730901926.git.ps@pks.im>
 <2d64a941d511a88a25c1f8258b5c5682089fdae9.1730901926.git.ps@pks.im>
 <f3c10656-94a1-42b2-94bf-253978c278ab@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3c10656-94a1-42b2-94bf-253978c278ab@gmail.com>

On Sun, Nov 10, 2024 at 10:47:58PM +0100, Rubén Justo wrote:
> On Wed, Nov 06, 2024 at 04:11:21PM +0100, Patrick Steinhardt wrote:
> > There are two users of `UNLEAK()` left in our codebase:
> > 
> >   - In "builtin/clone.c", annotating the `repo` variable. That leak has
> >     already been fixed though as you can see in the context, where we do
> >     know to free `repo_to_free`.
> > 
> >   - In "builtin/diff.c", to unleak entries of the `blob[]` array. That
> >     leak has also been fixed, because the entries we assign to that
> >     array come from `rev.pending.objects`, and we do eventually release
> >     `rev`.
> > 
> > This neatly demonstrates one of the issues with `UNLEAK()`: it is quite
> > easy for the annotation to become stale. A second issue is that its
> > whole intent is to paper over leaks. And while that has been a necessary
> > evil in the past, because Git was leaking left and right, it isn't
> > really much of an issue nowadays where our test suite has no known leaks
> > anymore.
> > 
> > Remove the last two users
> 
> OK.
> 
> > and drop the now-unused `UNLEAK()` annotation.
> 
> Perhaps it would be convenient to do this as a separate commit.
> 
> Just for reference we have this annotation since 0e5bba53af (add
> UNLEAK annotation for reducing leak false positives, 2017-09-08).

Makes sense, will do.

Patrick

Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2231F9BF
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113028; cv=none; b=sVsS6Z/GgN+0Uf8JVGZDAI0aicHeksA344ZZ+xSZoXrHcutsujkR7EZ8CyXHPjvg1zGfPGZbCMsFBE8LVFX1H83eajlcFiVJMY+ybFbAaiDNnJDHtocj/XDhEdAPYiMUiyeSF7AWpA9uoyFNok/JJYQIVbs4rhwubMY2DrqXGVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113028; c=relaxed/simple;
	bh=r+Altr02hGPDgCvDYXGTTUMnbXHwo1i+ha6vrkX+7AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzJ7AUsZTYuOIy8/MaMNslTqe3rModxESfp5QfVBW1CS2lVahxqJ5L9xsF3dM4XTQsp2wdV4lJR9B+rThaqqDsPUdhhKHVbzbKCniBueR30Oq33L7TbLIVz+/qOpl8Ay8DDAzUwRKaUEOizUK+b15HMNChzVTeXkQrvi7l7yjqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mD2m8sou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sQGT1hsQ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mD2m8sou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sQGT1hsQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 14AE87A0398;
	Thu,  2 Apr 2026 02:57:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Apr 2026 02:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775113025; x=1775199425; bh=jItXaeGbl5
	VyLr2tbMMMSJTMY8kkUL6dPS3IVU7x1+M=; b=mD2m8sou/1FthgUNycibjG9e7r
	rZq7eY8oXGZboxe5ASofnpsKeux6ySaAxwwkjuEeFXZkFc5YmeEFcbeQP3Q33Kbp
	wrUvhFtinIBv01d8kyC3Z/thQFLWO82J0bDrq5Xp47PLEBzaqnzt4tb8wydDG56n
	ZbiR1nBm2iPtdtwyVI7LAZ3SNmFTXATnyGQmeqeRUX+zlRdTeGJcI5GfVj29swY+
	3JNfYdLcmkmnec7vXWcG6cP501vZAvv73lbeltjLbDaxGhUiepaiLIZLpWMbOvxr
	k1pGqJfR4EL589iMmRVwgBrxMb8DSenvKhEiBAT7p/MYic29zyYLh1lsLqCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775113025; x=1775199425; bh=jItXaeGbl5VyLr2tbMMMSJTMY8kkUL6dPS3
	IVU7x1+M=; b=sQGT1hsQSmlMmXAHN9ietTQUjXcyNChdSHEQInfeV3PDYndmVBN
	S5hs2TKOTNAoMlRD5aCi91564CVVkM3w0AsfGNILGXO9XxoXjyNzKGdCA7ha+nbH
	h2zyjTRnai7sEkdGf/gsOfy+vskAHDSJnb/UIMok3sKCAL1+RNWofScJzszEgXTM
	AwkA4gR/rQwWd0Xgix0CBeZkLMo/Q+6UEnFL0sr9s+Ptfh9fa139BMX6ejpmiMvW
	7E1+RhR9mih2UHhnZ1iZUDX/kSPbzXLJbnnsqeTW5CWhnCr6AAPiRKYeE4PT10Nm
	E/G5cT0fahQ7My+i/vt3xtp27XLxd48zv7w==
X-ME-Sender: <xms:QRPOaSAnnvhUqwlydp7IIwgA6qQ7mJttt1EQpDdjMpJMsuRors-zng>
    <xme:QRPOaSgIkZzwaKFax8NRJO7VNT_2xgMj0Hk995mnnq-uPTnWn2uiZgPfriFKXTE-X
    _tqN0L9_ZbJ_UaXYDyA7o9cgdN5c35KYOyH8o01ytSJitxVx_fn0Ks>
X-ME-Received: <xmr:QRPOaTNfPWB673U_TStZOPgS6D97-_X36wuj0LrXRSCyN2AnpFRZ3C7TOxeTa4R_hGN8VMZsVfC1qBmtJBkQAk1S_5hbwxn_m82eARDvrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgf
    eugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QRPOab6jh0Kn9pZgpKc6Da9KtxmhyH_iP_Auju6IXp8_jPbnLBdmfQ>
    <xmx:QRPOaZ3py9GkiPP0vCBBmQHfLThpCmKJP3BSnQ8XqVYse4y55XAg0Q>
    <xmx:QRPOaUZxCai57BgT-IHuiXiQGHuUZZbum_8o2dA5YbleXsJY3q_Rrw>
    <xmx:QRPOaZDR5gP9WIX-QWXPsL93FkQyffwZ2nmmm98A_aijuf6HC42lEw>
    <xmx:QRPOaVZFtcFE6ZXFVes5irhEsfUNGRfm9UpUM-QOm1TbEGtNgIu0c2fv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 02:57:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74540ae5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 06:57:03 +0000 (UTC)
Date: Thu, 2 Apr 2026 08:57:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2026, #01)
Message-ID: <ac4TPLj3tItmR_P-@pks.im>
References: <xmqqikaatfhp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikaatfhp.fsf@gitster.g>

On Wed, Apr 01, 2026 at 04:42:10PM -0700, Junio C Hamano wrote:
> * ps/reftable-portability (2026-03-31) 6 commits
>  - reftable: introduce "reftable-system.h" header
>  - reftable/system: add abstraction to mmap files
>  - reftable/system: add abstraction to retrieve time in milliseconds
>  - reftable/fsck: use REFTABLE_UNUSED instead of UNUSED
>  - reftable/stack: don't call fsync(3p) unless provided
>  - reftable/system: provide `REFTABLE_INLINE()` macro
> 
>  Update reftable library part with what is used in libgit2 to improve
>  portability to different target codebases and platforms.
> 
>  Will merge to 'next'?
>  source: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>

Not yet, please, as I plan to send a second version of this series
today.

> * ps/odb-cleanup (2026-03-31) 7 commits
>  - odb: drop unneeded headers and forward decls
>  - odb: rename `odb_has_object()` flags
>  - odb: use enum for `odb_write_object` flags
>  - odb: rename `odb_write_object()` flags
>  - treewide: use enum for `odb_for_each_object()` flags
>  - CodingGuidelines: document our style for flags
>  - Merge branch 'ps/odb-generic-object-name-handling' into ps/odb-cleanup
>  (this branch uses ps/odb-generic-object-name-handling.)
> 
>  Various code clean-up around odb subsystem.
> 
>  Will merge to 'next'?
>  source: <20260401-pks-odb-cleanups-v1-0-89adba9ada68@pks.im>

No concerns here. It's a rather boring and unexciting patch series that
doesn't do much anyway, other than following through with what we've
discussed over the last couple weeks with regards to flags.

Thanks!

Patrick

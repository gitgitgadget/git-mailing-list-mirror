Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E9A2AE99
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519894; cv=none; b=TI7u5daAm9zTIy3ChKSOQJMP2+fJuTiqgvg/bVo69GGp/5qW/Wy1X45GpABqBpl41wfmf1f8o8QVuabd/lVtX7eW/Ty1JLZ9t3/xVEuaqERoS7LE0Me1Ss1zYdXSWHVIRKoYiA6OVtW7GLCnmU/vY9FvdnQWD6LPWXELz2l+93I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519894; c=relaxed/simple;
	bh=w8MTpvlvBJ1kLTgyfsAqBGpNk9CUDyFPmyFpdnkR2gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj7xu63cnR9ErkiIZIR1vmfi3SaU7BevLatNpO4n8mcfCzpg+imWcftlhQoKhJC2aiwt1iSX0Ueg6qtvpxSH5sdhsmrHNELe5whebRZdb16ft6WpOP09G3LoIY+Zz0xU3PC2LknKZueF9DNzLhJbJmucHyVQdSuQRsN9wV+b4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fsi4CQgr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQK+0AHv; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fsi4CQgr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQK+0AHv"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6BEAB1D00116;
	Thu,  3 Jul 2025 01:18:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 03 Jul 2025 01:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751519891; x=1751606291; bh=3D/x4PP/OJ
	KqPJjfOqPV3cnQYtFxcxfCjypMDqFomgM=; b=fsi4CQgrRf9pgzQUKOEFzf9C4b
	p/kOP+0dJflJRYFsNeg/wDkTcCPC093yKcuHwS5o/rUCJAKVAeGybwJ6cI3cYA0F
	kH2dDWfxYWKOoslVSYgaiAVbC6KAr/9fqoGeMq3Gmpd72BqGYfIyWZ8LwawQoMwX
	cwwR+bU2FxiqpYk9tfNw46fbuhzo4+bj/odDkJOOM/uUwzpH38wTwa0d+7A9Ow/M
	o8EToyINSB7tnGuXCmFG8ZSqK49EMQufWAIsRBWdmVEVFCH2Gq5Za+syQa7ddWeg
	17CIsyzRtaYuBV+KnP0yXSd20drbnCI1HvaweLf8C7C4zGVhDuuWS4Z3JU5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751519891; x=1751606291; bh=3D/x4PP/OJKqPJjfOqPV3cnQYtFxcxfCjyp
	MDqFomgM=; b=AQK+0AHvaeApEitbxBc1GqZz8ASN89bIcmO+YZTySZeD2f9vjD6
	POTrLmji7bGqhb2aHejVTwVnRwsdD7G1j2ZAej+oxnEWUpDlIHc/U47b4vDjqXj3
	LbGzKVMFf6QqSXrbEtmaRMufDZOtD/QtrDuqpWgg8z/DP3IY6+zYx6lod6hTWydd
	74F7iPvpdi5FmyaHCdAvZ5dSD3IVFI9i6mhTHFlV+RW6mKCmtpzZrOcOmGGCz+yL
	kCAtL78zMcDRdn1dtx03wEwsghc/OVyeoz15Lf8/JrYU13hCfSfkZUu14Htv/Irf
	nLYmNRYweDFG15fUyezYcCurgn5PiDYx/1g==
X-ME-Sender: <xms:khJmaEmfgAiZGkweB3E9C-Hwwhfbmfn1S13dBWxLiXH9fXVeaufGyA>
    <xme:khJmaD2EIZsg28qw-hieWQfrkRriyMXbup8MOWKfx0QuqeFpk9ES89tbSVmdsXKOU
    xD2D0gDXfVdzf2Fug>
X-ME-Received: <xmr:khJmaCp0sO9f9DfcbP-CBd9iCNPu9VpSKxNzGMd6tUJB8BB4KbcMf6fZa4-5fbowf5HDiqMfajwbZXXwKVzBlGp_qiOWovk1sSMUOkwdvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhouges
    ughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:khJmaAmeGl5uk5p3gcovT0QQKDKadeP_s8wUs25-5PNCIN296dz-XQ>
    <xmx:khJmaC0k4bXIys5-KZW_hE_suEGHB16xmh_yFwLNv02jGW9m3WK9jQ>
    <xmx:khJmaHtxv5d2OrLNyd0JRQKBGyNfUwdWw9CEVK43Z88ibKK-QCfSbg>
    <xmx:khJmaOVkeVYR8syR5pxC3Ir-5s15gTTBmnulGKaRGyJoW6fxzJ_A6g>
    <xmx:kxJmaPMZeUibdd3ANUQp-mKccG77fRhU8ipFItFckmzwaVIgARqLBTkn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 01:18:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78f890b7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 05:18:08 +0000 (UTC)
Date: Thu, 3 Jul 2025 07:18:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH 0/4] for-each-ref: introduce seeking functionality via
 '--skip-until'
Message-ID: <aGYSjf5H_ZBaVVJm@pks.im>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <5e9b3ef1-931b-4b70-8275-5aed5da3d6f3@gmail.com>
 <CAOLa=ZTwvOiCnYK18GTEUkcW0-YLHkJ=MBggdzOYsbTT+OHPwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTwvOiCnYK18GTEUkcW0-YLHkJ=MBggdzOYsbTT+OHPwQ@mail.gmail.com>

On Wed, Jul 02, 2025 at 03:33:47PM -0500, Karthik Nayak wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> Hello Phillip,
> 
> > Hi Karthik
> >
> > On 01/07/2025 16:03, Karthik Nayak wrote:
> >>
> >> This enables efficient pagination workflows like:
> >>      git for-each-ref --count=100
> >>      git for-each-ref --count=100 --skip-until=refs/heads/branch-100
> >>      git for-each-ref --count=100 --skip-until=refs/heads/branch-200
> >
> > Doesn't that require you to know the name of the ref after the last one
> > returned by the previous batch? If the use case here is pagination then
> > being able to provide a numeric offset might be a better fit. For example
> >
> 
> It does require that you know the last ref from the previous batch.
> 
> The reason for picking a reference offset is mostly for performance
> optimization. Our reference backends are built with prefix matching in
> mind, in short they do a binary search through the reference namespace
> to find the required prefix. By using a reference offset we can utilize
> this binary search mechanism to arrive at offset.
> 
> Using a count offset would require iteration to reach the desired
> offset (basically a O(N) operation). This wouldn't really matter in
> repositories with ~10^3 refs, but in larger repositories with around
> ~10^6 refs this starts to make a large difference.

Even more importantly though, a numeric offset would be invalidated by a
concurrent write in case that write ends up inserting a ref in the range
of commits you intend to skip now.

Patrick

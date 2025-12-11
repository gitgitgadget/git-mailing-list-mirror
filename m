Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB81ACEDE
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765432032; cv=none; b=NzdZk7Z37Ii5bU0rObhfSObIjrPLMiMtlfGip6BtYC2hYAj1NBLPqu+1CxjAcoKtATJXIk0izkRziCsLEhwDmjJaA49WUS9w2l+ioCSxOofxlyrCUWrqPhQUO3ksoD7wWjk/f4pnAXx0oY/mjEodJ4Adk8VB7W5c2FgNFkZFmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765432032; c=relaxed/simple;
	bh=PQtxanPXktbXb+j0Mx3s/Cdnf3Uq/LS8lse6uSVfQPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVf4cDTDsCFzikT55GEsEZKzmW3ebN3bCvROac8D/9hPmesztuVeUzYvZASLK+w4MJu0C8NCzBZiQ6EOWtWAimjBv+i6NMd3XedOdV/8HGsFVlvpJtOgBgl/FhDsjQbwoI6Icu5uZHsMCPLs+vye2mAm6+kBUjq9Bo57PfWayCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FXKyRjSk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=apWW/ilD; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FXKyRjSk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="apWW/ilD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2870C1D000C3;
	Thu, 11 Dec 2025 00:47:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 11 Dec 2025 00:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765432029; x=1765518429; bh=CHmrbQuw/Q
	vfZS1YyGDqO+0GEg5xGgdr3JSX4TiyrpM=; b=FXKyRjSkRM0ONQgKtG08KdOQnk
	ytjcgmhfSXGVfclPS1h8r7lzJ1TJNiZnxEUcPBJskZbpBk2FfGUI265nNV7dkfFG
	sb0DMHhcKY7GS/XM8sIAxYD5G3BoRbUiaM7BuLXk2CP2+t8PWuSuOL42WDw+lddQ
	I4pco7Pu0xJGooV5MYSBBGgdxdOzCnORzpyGlC9zEBiRX1R+5//J0lMZc7+aMAXn
	afJG/jmJen34LsMkvZM3pEIPxNekF2F9yZLeTY4c8ZFvwm19z/JAhoOsvYVnycLJ
	aOr26wsUuCDPcBHBvWLvjs31JCA0wJLZQCtjFE8BOGYVzLdV0Z3ORKlJ1mwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765432029; x=1765518429; bh=CHmrbQuw/QvfZS1YyGDqO+0GEg5xGgdr3JS
	X4TiyrpM=; b=apWW/ilDlDAeBFbwe9VM86+yubU2E4qMk3ChJKahjg9SSVsSevw
	WLrUP+7AtzVIbeL0qR+wR6kUZGE5He1zfjxnZUg/c+O4HshnaYi+Bmhi8Ah90kfY
	a6GilBI/fI9Ea1mc1HwDH64pv31afPyQUAv5PFz/d5ZuSD4TkeGGcH1Z6vV051gz
	6WOLK+90CCVj+43Ko8GOigi/dvRkq29cysLbMl8Uu1bWDgBjGasNbTLIiBFLIwiB
	e4ACgHE4G9mzH3WfpgugTtUWRqfBD24/F8Wx4akdOPxhmu2ZgiIHCdLE/g94sTJC
	mwtalcFYl/JCv8KmLHiYbHBTKJqiUlNhnyA==
X-ME-Sender: <xms:3Fo6aX0CVPHyQOZ4aD5EvXjwmBmyp1U2WeOHPPtGdTLlOmNytUTnSg>
    <xme:3Fo6acH80MRzQ5TOgIEicQLg71n2KUNwlK8dlFHjb2CpyDwhwRp995v8CtDgaka_9
    ecWf4uoog47y7Zd1mSAZ78cZimRmsbzGf3_5icPuv9-TbzwlOK9Yg>
X-ME-Received: <xmr:3Fo6aVj6RSR141g_unLNlZUo_KRdlZcVdv-5ZMFfWyNFUXu5LrP7wgIEV0tp7ZAQLATjsKPGigIMwKTsXFYZ95PLgoh3jP9FSAmzRAeiifxP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3Fo6aX_wsJG6652u2COvcQ4gpxmWE_InFO5vH2XWjlx1pT9eb7WL-w>
    <xmx:3Fo6acr9QsG2-Iy00A3tgbvgDyuFE8tI_LH3Eb8U1K_iH_wECXXzEA>
    <xmx:3Fo6aW92WTnfqAJ67obn7YDjyx9CXuGuTb45blmo-jNzL6CkZejbYQ>
    <xmx:3Fo6aQXaZxeIDjDmWeVKEkpmIdZtDohFFl71pGOUP1AUE0jVuusa3Q>
    <xmx:3Vo6aUkd7gRVMrkS9TCufgHCseqzAr0H466UUO_qsV27SG9eCFVwRZYi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 00:47:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0d3ee13a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 05:47:06 +0000 (UTC)
Date: Thu, 11 Dec 2025 06:46:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] builtin/repack: fix geometric repacks with promisor
 remotes
Message-ID: <aTpa0XLKPL53LaR-@pks.im>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
 <20251205-odb-related-fixes-v1-1-ef4250abb584@pks.im>
 <pva24p5jl2wjnwtdysmiqy4ljcfxtarss2cudqf5k7so36c5b3@6xkb6o2tgx5j>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pva24p5jl2wjnwtdysmiqy4ljcfxtarss2cudqf5k7so36c5b3@6xkb6o2tgx5j>

On Wed, Dec 10, 2025 at 01:31:44PM -0600, Justin Tobler wrote:
> On 25/12/05 09:19AM, Patrick Steinhardt wrote:
> > But there is one case where git-repack(1) decides to pass both options:
> > when performing a geometric repack we always pass "--stdin-packs" to
> > identify the packs that should be merged. So if one performs a geometric
> > repack in a partial clone we'll end up with both options, and that
> > causes the repack to fail.
> > 
> > Fix this issue by never passing "--exclude-promisor-objects" when we
> > have a geometric split factor. We don't need the option anyway when
> > doing a geometric repack as we will only ever pack loose objects or
> > merge multiple packs. And neither of those cases can yield a promisor
> > object.
> 
> I'm not sure I fully understand why --exclude-promisor-objects would not
> be needed for geometric repacks. To clarify, do geometric repacks
> already exclude promisor packfiles when merging? If so, then this change
> makes sense.

Okay, I had a deeper look now, and turns out my claim was completely
wrong. We _do_ try to perform geometric repacking with promisor remotes,
but we don't know to handle them in any capacity:

  - git-pack-objects(1) just dies right away.

  - Even if it didn't, we would need to learn how to merge promisor
    packs.

I'll drop this patch for now, thanks for prompting!

Patrick

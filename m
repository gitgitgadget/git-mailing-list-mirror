Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B64225765
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012890; cv=none; b=CehSYVL4Yt+t9aLQgZMIpidW31TBrUhk42a2ZMoIWqTgwdYdzNYs5yemP3u5xrw1wJLLGBLoy7T7AOTe1C192vC+KVeoKNsIwp2rU0KcOZMDWamncV8acODkdPuFEytpcV3ilONNnf8yEQzHGhwCf6X99jNzEBZOPbO1jryudYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012890; c=relaxed/simple;
	bh=SK+ROSMn+4u3Y1fBX3oda0QyBHdZpYdDb1QDtz2EtCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OceBqHKHOpeEvSGLXGQPFxq4Z3MM4NUGKNWsJAB6Ibm1hY1VZqvILuRCA4m5NXDOWSuR4Wr5ttGKSZXbZc+x6DnGidJe36lLMCm/N6MFUNvBTIm+Unz9iArvUyI0anuRz9a19RwobLl3ZqIGkQ4H3o9vf0MbcjVhwJXrN/1Dkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ITvVTiOY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QH15h479; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ITvVTiOY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QH15h479"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87B0511401B6;
	Mon,  7 Apr 2025 04:01:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 07 Apr 2025 04:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744012887; x=1744099287; bh=taM49wP6J6
	YsUHrUMpj22C0nIz/5bLW7iFwJ5MuLyhU=; b=ITvVTiOYFsrRwXOD/hAIHBk55J
	T8fAYz4rFS9b+7xSBPYJ8LtOBuH5VIWbjCEjwmU8X1h4YFYtjMSQNDgez23ocOpU
	rEkrNJ81O1/CFMHVhCOm0QEvoclCoxnV/qhQOlA54JiKXGhghpAkfSJILq6cuyDO
	JPCmpUfLPLLuYMaLGeAVIel2iCQ0Dk5jaYVMsVob3beYwJl8tKD25mSSDNM4Q4ty
	KlV2skheI1HFDKx9g3my2+fQIuwSW005xFuY99LH0uNIjLOjHKs2mwp/oj4tq/r1
	Lj4w/ba4XnY+k8MhrKRrPWfMSUvDQGNmsH84FxU//aayWrYd3kqJ7LsbUZTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744012887; x=1744099287; bh=taM49wP6J6YsUHrUMpj22C0nIz/5bLW7iFw
	J5MuLyhU=; b=QH15h4797xyiw9pEgg8EUIM88cdQfmSHjwR7uDkBSYPPD4nKIoA
	vKoI8aZQea6bDRDdJyo9dxUfE0+zOCxnK2NJxx1ET2guLtIoT/X8e/9eCSPP8/m2
	Ce+eGNrwnshvuHN9+kfmBPzpcMjdW8HaVI7DE2h+urupQZgSlHOQl2y3P5bQ88MG
	6dS0ZIk2T64Xj1R0RzK+f1ntJivzvzCSPIkkOutlMsSPO3xgEZJa8/JY85/m45x7
	rsqI1M2NsUOmfHNLDIK8zXwLjChLho91pcg46GkhNe5oUlCWHCyNFkpK/Y8IsPtd
	Ju7ft+bnHsHrwKA5HdpgBBxLv/padHf5aog==
X-ME-Sender: <xms:V4bzZ8NDWz04Y7cZi2C3I9P1uz4QC14w-pF1KpiNji710Abazi-daA>
    <xme:V4bzZy8od_iRt5tuPrmNh0ORvg_fQJ8laayPCsG3vsQFrFVtchj8g77szSGnRO5p7
    a6S_kQhUjs-RORiDA>
X-ME-Received: <xmr:V4bzZzSuip2avvWWZ0iZZJEWtrqTHEwrdMjl2S0z1ATn73xAZvgTp-G5QWFws6F5NRaOsq18gHS-ShW9iF2BUIEw3lAmJwgzqmjzrx7j1M8xyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtmhii
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhsthhsodhgihhtsegrkhhshhgrhidrihhs
X-ME-Proxy: <xmx:V4bzZ0tQYqHCXbCuOfpqRuli2VXWHG7siT7UeAS_u79QE9JDsAjj4g>
    <xmx:V4bzZ0dWZ1aF8MCjS-jn_eajqO3RLE9NC90wneyemjS7UvAuKpcX5w>
    <xmx:V4bzZ40i3j02c-NaTCPB5wt4WLNy9gnqiwGLTu7lu3MvoO7VT81gBw>
    <xmx:V4bzZ4_1OH2Fnrk14_0JIwB9kki-f_viajTwxP0SE0ZgZ2Y06n2AYw>
    <xmx:V4bzZwT6YgLB05OPdPVnwTkzjf4HiRoQlKPP1vuzPal349yq82XRfSzQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 04:01:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4891c6e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 08:01:25 +0000 (UTC)
Date: Mon, 7 Apr 2025 10:01:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Todd Zullinger <tmz@pobox.com>
Cc: Akshay Hegde <lists+git@akshay.is>, git@vger.kernel.org
Subject: Re: meson: Installing completions
Message-ID: <Z_OGVDZ9cMwavfR8@pks.im>
References: <Z-uLqQd7QHZq-tB7@akshay.is>
 <Z-u42Sm613hMj1Ft@pks.im>
 <Z-wltqWraESmb-Lm@akshay.is>
 <Z-yLvgkJnGm0CkG3@teonanacatl.net>
 <Z-0gpxXBmt8G72Z9@pks.im>
 <Z-1EJo8xHpA9qM0-@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-1EJo8xHpA9qM0-@teonanacatl.net>

On Wed, Apr 02, 2025 at 10:05:26AM -0400, Todd Zullinger wrote:
> Patrick Steinhardt wrote:
> > On Tue, Apr 01, 2025 at 08:58:38PM -0400, Todd Zullinger wrote:
> [...]
> > One of the questions is whether we gain a lot by making this an option.
> > If packagers have to manually adapt the location they could just as well
> > copy the file by hand as there is no build step involved in the first
> > place. I also think that for Bash and zsh the locations are somewhat
> > stable across distros these days, so ideally we could just build on that
> > and not even provide an option in the first place?
> > 
> > I'm mostly trying to avoid to eventually end up with tons of build
> > options. Ideally, we should just do the right thing and install the
> > completion scripts into the correct location in the specified prefix.
> > 
> > At least if we can get away with it. It seems like the default location
> > would work alright for you on Fedora, and I assume that it would work
> > alright for most of the other distros. So I'd refrain from introducing
> > an option now, but if we eventually figure out that this is problematic
> > on some distro then we can still introduce the option at a later point
> > in time.
> 
> Yeah, if the locations are the same across all of the
> systems we aim to support are consistent, then I agree
> there's not a lot of point making it configurable.
> 
> Whether that turns out to be the case or not will be
> interesting.  It seems like there are almost always a few
> systems that do things differently for one reason or
> another.  With luck, this is an exception.
> 
> >> For reference, here are the locations for bash, fish, and
> >> zsh which Fedora uses.  This might be helpful in determining
> >> reasonable defaults (after comparing to other distributions,
> >> of course):
> >> 
> >>     bash /usr/share/bash-completion/completions
> >>     fish /usr/share/fish/vendor_completions.d
> >>     zsh  /usr/share/zsh/site-functions
> > 
> > We don't have completions for the Fish shell, right? Just making sure
> > that I don't miss the obvious.
> 
> Heh, we don't -- as far as I know either. :)
> 
> Those three just happen to be the shells which have a
> packaging macro for the path in Fedora.
> 
> Cheers,

I've sent a patch via [1] now. Thanks!

Patrick

[1]: <20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im>

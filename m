Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE4355055
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274746; cv=none; b=tZ2EkVKHM/XdIqbIaqSVL4nHRBeTIGDOAMorj+xMOUJm8UvQlb4T7ojmb8Mf4w5YOrck1ehzFP5tVCqKnybmLsbYW6I9wu5yGP0cI8VKyyb+r9a606klMvOLhWmykG9psSFHAPErSasMlAy40vMyIGfp1sBgzrJlkyxa3peqzsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274746; c=relaxed/simple;
	bh=H1O+/Be4+nqL5GpaEr3yIGLNVc4qZEFmScUjZjWuReE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llbhEU+M4dQzmJLuULULvksKXKsCCQxsOiJns1ZvX5nmVQNgPkG/60jsAkzK49oPuJEYjmpuP/sZWt9G3kG8kuRO/XRY4ufzR0W++kfIRK9ZRW592ewiOP4EI1brj4WTKUlS8fos65MFiu1OQqi3ISURRewab4ExxPILG9bm/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lb7Iq8mW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aG/rmamq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lb7Iq8mW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aG/rmamq"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF42114001A3;
	Thu,  5 Feb 2026 01:59:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 05 Feb 2026 01:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770274744; x=1770361144; bh=FnxBqC5V9t
	MQAnNazOv/VYeJGbRceYZmjXyg4OqvpfU=; b=Lb7Iq8mW7cnNgfhzWHv6HJPf64
	jSS7GRnUESuASvqMiVfPCboodF6E3GI42nXCYFLw8M3Cy5RjTKIfzcI3wgHL62gf
	yPuzaa/8Ve9uaGDHP6gpisuhAnTNl87JqTBBiWkDrQurxxqAmyudIWd4rLKv8KQq
	v5NLcxIrBTG+33ZSXJLtbLTTSY4vG570VjSU7YOiOmHVl+dKkRWkqjnwXuRTL9Lm
	YRTAh2krd6gQMUyyUzfAkWRG7vh8JoOaXaybsfLJ7vS4M/yPEMjmTEl3RD+mGPkh
	oM3AUi93+oyZWJYIlzNq2v5o6eAtcWxGuA8OaSO84x3tAMxZluuDdSGhNv0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770274744; x=1770361144; bh=FnxBqC5V9tMQAnNazOv/VYeJGbRceYZmjXy
	g4OqvpfU=; b=aG/rmamqBmN22a2ALoAnIlomc0jU2Tc4/YWxKMWWFht0wubETJh
	kfD0GG4aJ2snF7ayuTCkPgVIK/jJ0uBRWVULgp45N2MHY+W1ivM5w4WlQD1nbiSA
	hbfvd0m+s1xoVXkZvlNiO5wZVDw/IQP6601CZedd5noQUWyyVib4f+Qh0V2a0uLg
	lwxu1aXQ7Kw+Qiird4kOnoPlwP/64GeEXArLWxPa2Ps43JZGrJClSv5oJ09h84fR
	Ve+giu26DbofR8XMyS5mWi91apjdca05Q3nfZVmtfYJV73ykWFpuZJVUrEbItSVF
	gaYtT2Whsg/+AXKSxfL07uucYXhlfrNgdpg==
X-ME-Sender: <xms:uD-EaZ9czelbDO1v7BGtZpHATnx6Qa-Le9Ag4L6CxrcmKRb9dxHn7Q>
    <xme:uD-EaVJBDQRLq1-uZbkOh2dzQ-2P3Ez5h9FuIyXi-VNI7LVxsT9WZifTGXaBH2czX
    FzTrpNMIakC_I9eoz1T8DkdM8pSB1TVHBVjMvOX8RT3ThqDOjE9Z2I>
X-ME-Received: <xmr:uD-EaUaEaip1CJbXuNbcn-5UjI-7tfVcGUT5CGmGddPRMXIu4yPacGCDprs8fhgjcQELIM5O7LxoBQh41Q94TcorKkwldWwN-7z0rHkIOiSx8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeegieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:uD-EaXK5g08awZJXPkwR6xTZj_AKfyW_Gikt8EbLgVjBch4X9XSUmw>
    <xmx:uD-EaSDdK28ghGGu4OWtr8pX3ZXdguHxHqOhf_qnTmazjhjSPF2f_g>
    <xmx:uD-EacpnaWKzvlukKXvafk8ZyRoYdAkTLPpxfRY8KCLhcDN8buR8Bg>
    <xmx:uD-Eadi2K-Ktt0SNU-KbSBAwh8rz4vj2nOra8fAel3tc8nxoxVUh5A>
    <xmx:uD-EaX3fO9hKtOLLxVoNHw0caj2NEUs4_7YIaDxWvMRtbzmUZxj49-t9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 01:59:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15573348 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Feb 2026 06:59:01 +0000 (UTC)
Date: Thu, 5 Feb 2026 07:58:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] meson: wire up gitk and git-gui
Message-ID: <aYQ_sk7bWv1dFo09@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
 <xmqqa4xopf95.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4xopf95.fsf@gitster.g>

On Wed, Feb 04, 2026 at 09:53:10AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Wire up both gitk and git-gui in Meson as subprojects. These two
> > programs should be the last missing pieces for feature compatibility
> > with our Makefile for distributors.
> >
> > Note that Meson expects subprojects to live in the "subprojects/"
> > directory. Create symlinks to fulfill this requirement.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > Hi,
> >
> > I have upstreamed support for Meson into both gitk [1] and git-gui [2].
> > This small patch series wires up support in Git.
> >
> > Changes in v2:
> >   - Use symlinks instead of moving both gitk and git-gui into the
> >     "subprojects/" directory.
> 
> Just being curious (as I cannot offer an alternative if the answer
> turns out to be "oops, no"), but is Windows, which has been symlink
> challenged for quite some time, happy with this?

I think the answer is "it depends". Modern Windows does have native
symlink support enabled in case Developer Mode is turned on to the best
of my knowledge, but not by default. Solutions like Cygwin or MSYS2 know
to emulate symlink support -- in the case of Cygwin they look and behave
like symlinks for most of the part, in MSYS2 they use a deep copy.

So I expect that it should work in those cases, but I have not tested on
Windows.

Patrick

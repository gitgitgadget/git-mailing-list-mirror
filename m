Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FE82CCC0
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756051374; cv=none; b=CXQO6ExHJZ0eRRhBrpryfXDqL+iLyiKydSLdpi4xSbB00YvXe+U4zDrzy8F62MhcUz+5kgFynVN8Ih+bgDAps34iq54V7OGzH0OhKI1MEtQy+n4vBfXDeGiVXHeM0GlxSFjPexpPOYPtsMykIBTsApCQdNPSdiOQpd2oFulsQMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756051374; c=relaxed/simple;
	bh=LvyNtfvtK5CuQSrhM0qksHq90or1ACz3JJtXjIGrwn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCSOr9+CIMcN+oDOEchbXKqP9pLYRnVxIj891NJo941D8BnQwrLfeyT8Xq6zyrPP5hU170gfiZfuHBteVIpIi5YuP5adUHgEyhNrqJiEioHuxWl/G42UrqWcKQfXAAcBaOwUBrGHWRTYNJDWa21G2iYtJ+agBzP+97Dk0q5CEIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DOG2eWmS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=megq3ivS; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DOG2eWmS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="megq3ivS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2928F7A00B9;
	Sun, 24 Aug 2025 12:02:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 24 Aug 2025 12:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756051370;
	 x=1756137770; bh=vX2o6SesTPrYdntHeljExGQkTXSq+1xo6zjbjYwKeKE=; b=
	DOG2eWmS+pWymtzl7VrBOM3NwJcAl+3Jz2JfpEozbcx0KAZ4yJKdnsFHzd3D9mkQ
	V/OrVMlWJJQN/dkER33oW+VYLhn6Wz2yv94DdLp4UNEqaCql0n46vvQtHKjC1CFE
	L6ES7nkrMnIbecyaC1FOlK8DrNqioZrPqpyEZ1d+WniQYi3fzo3XapGt0fa9MJTO
	xzV/ODahTfjsrzU+UhE3T9KMUiJ3jGFv442Xz7FllOi3fbB5kOt+gyNkPrvBIDq/
	fVCivwWam93DiQqstY3623sHtEYtOA8cNPAO4R69P2YsvCxj2HIYtipzY6GDEyPl
	YUOkWPACXl1ffZk+8CATSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756051370; x=
	1756137770; bh=vX2o6SesTPrYdntHeljExGQkTXSq+1xo6zjbjYwKeKE=; b=m
	egq3ivSMMI+TWgRuLkG+RuNeuuwale6spy/ljIafejG3q9hiOvGHJvxQkh3Wg1uo
	/JnkFtarPCAoNrT5GOMT8tVwCZegoX4TL3pJv1Bkl3d0A8rpyexOUw4IPxOWeRjN
	E7vwXwNQhfWKm0CQjzccs4Y+iMCqAWzl4IPqc5BDFfO5kr/7UQSQLcwjgfJ2pD9G
	BdZgTcBt1wkHeLgZ01IB0Ze/rHXSaZBqBuFirjfkyqQc+sYjHmGLh0SAYDZ891EQ
	AivsMekP7ATaZRota7lSCGgIeh/ck7UAvOGBlt5AU/Mg+BVgWPujvdYk1e+RpH6L
	N/BjY/tWE/54axKkKxACQ==
X-ME-Sender: <xms:qTeraH-ymdNhhjXg0P24zIB2MPbjCfE64sc4O6QsT1MXRJJazAeCLA>
    <xme:qTeraD4QLBKdX_kHoOAWB5DVL0rTuRjtpq8LY6cDfj8oMS48I8-MAaGZYr92p9sS6
    LqUSdA-FNKkJOu1Qg>
X-ME-Received: <xmr:qTeraG3nXDiC67YIIIW4xME1AYrnVg2TPeTin-n26zo15VQyxuH8YUFDphW0qTJYacknX_uSrr1unt5sAJrhygHSy8zPLt9dLRQNUnOh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qTeraCD1vD8NPaz4Cu1Fs1pFTpV7C1KrBqAIQa9P2paelmpfOZ2huw>
    <xmx:qTeraA0Kxz4ALEJmjfIfmC-2H4awOK71uDj6CDabjf5XKbscPO8gvA>
    <xmx:qTeraEuoV_NaODfWI_LYR5_XeBZ-HLnEiBFnzUlpZmPyTHGXgbKBJg>
    <xmx:qTeraI4BfD4Kp9Uwq7Sr8ImUtzloO_5HI27Ki-FTsU_gxAxabDhwaQ>
    <xmx:qTeraKjZqCVqo_p62ASmBDhGErkHFyOHSRMmLP9ZY5WLM7LseGh__zB1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 12:02:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5582b85 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 16:02:47 +0000 (UTC)
Date: Sun, 24 Aug 2025 18:02:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 05/11] builtin/history: implement "drop" subcommand
Message-ID: <aKs3myBRRAiyIvpS@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250819-b4-pks-history-builtin-v1-5-9b77c32688fe@pks.im>
 <3005363.e9J7NaK4W3@cayenne>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3005363.e9J7NaK4W3@cayenne>

On Sat, Aug 23, 2025 at 06:15:08PM +0200, Jean-Noël AVILA wrote:
> On Tuesday, 19 August 2025 12:56:01 CEST Patrick Steinhardt wrote:
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > index 9dafb8fc16..3012445ddc 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -8,7 +8,7 @@ git-history - Rewrite history of the current branch
> >  SYNOPSIS
> >  --------
> >  [synopsis]
> > -git history [<options>]
> > +git history drop [<options>] <revision>
> > 
> 
> Grepping through the documentation for the <revision> placeholder does not 
> yield a lot of matches. Can <revision> be replaced by <commit> or <commit-ish>  
> in this context; these ones seem widely used.

Yup, makes sense.

> >  DESCRIPTION
> >  -----------
> > @@ -31,6 +31,31 @@ COMMANDS
> >  This command requires a subcommand. Several subcommands are available to
> >  rewrite history in different ways.
> > 
> > +drop <revision>::
> 
> My linting patch series[1] does not catch this kind of synopsis miss, but 
> here, backticks are missing because this is a part of synopsis:
> 
> `drop <revision>`::

Okay.

> > +	Drop a commit from the history and reapply all children of that
> > +	commit on top of the commit's parent. The commit that is to be
> > +	dropped must be reachable from the current `HEAD` commit.
> > ++
> > +Dropping the root commit converts the child of that commit into the new
> > +root commit. It is invalid to drop a root commit that does not have any
> > +child commits, as that would lead to an empty branch.
> > +
> > +EXAMPLES
> > +--------
> > +
> > +* Drop a commit from history.
> > ++
> 
> As the examples are quite long, it would make sense to declare each example as 
> a sub-section:
> 
> Drop a commit from history
> ~~~~~~~~~~~~~~~~~~~~~~~~~~

Makes sense.

Thanks by the way for caring about our documentation and trying to make
sure that we're being more consistent. I really appreciate this kind of
work!

Patrick

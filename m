Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC66F073
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072092; cv=none; b=gWHfW21MgVTu4XlsjfgxTxHYdrbOp9RW/6BpRpQn5/3OsZrobzFQkP951EyBs27ISjlSPweXHlLjkqOSF50kJT8eul5mDzaewvhVGSEbTIF/mv0tm8g1kC8UHftUg5rfaHAH5r3rXv5MXb86dkwiwRnOv0rDpDvgXjFgqJ50x5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072092; c=relaxed/simple;
	bh=XLn0uyIyf+zwSLydYeWLpFErYzkfs1nyxlMjogjjarA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmI0XJX1zBnDEPl4w0k3PbLxbpm07lNQfhfwZpM/Rtf1qCQR2CoW8Ti6Wl0hq3N/JQT0PG5cdF6A0pJBqTwp0/TIoFrpWl6vYzDxGYqL6lHHhn7HY6yQj/3qHv6X0AA/KXCHqIzV4bsu0cdCl83HYOgBDGQc7yfheOlJhlrnaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HoRLHo8x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sPzQyDqO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HoRLHo8x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sPzQyDqO"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 403E8114021B;
	Tue,  4 Mar 2025 02:08:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 04 Mar 2025 02:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741072089; x=1741158489; bh=btBhT1YpPN
	3FA5rEXeICiIswPzV+/xwqpX59WhnZnI4=; b=HoRLHo8xY6XbgGdWy6DYTKcC7X
	sBXvdRmFeI7Cqr5ZcSt/IOwQQ3vxwWvjt8gCSSb7/WhBgxQUd94F+pKTf5TrQT0s
	zq1YnUK1iC7HSfgt+bYiHs8czaW2AEeswiwlE9OzZXbVkGfZVEpLWW9JFlqugBda
	YnlYeOT3nHGyDr6mgvfArV12xFTBRkw84NHgDKt5tFLOWM+CvDC+F/aNyDp8z+RS
	U7QFSZE8GBrphTK4Bzsrknol4Jzd1qR8GjJyqnUyZkPgJdhhGLkKfriHGjtM+y/N
	MNyFvcXNF9GhAo7ZC5ssPQGoqaccXDFDjEUamj2nk8jClk9+mwVR0Rby9VOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741072089; x=1741158489; bh=btBhT1YpPN3FA5rEXeICiIswPzV+/xwqpX5
	9WhnZnI4=; b=sPzQyDqO5YLed+XBTYuIoe6+d+hy97lPQXSwZ7LXgHyU6JWXmuD
	jRACodNgKrLEuw0nUZqe0TO6yM10vcauoxAhd8LOMDrGu59i8DalEGpV6ADUxD29
	MKAVKVRnDZryIfShVoEwDKA7YccyGpItyypHQDbmt2PR0S02HKJcNCOBHx+HgKyG
	/1axroh9lNTKFNvCSLiIcDjxJXO1BJxmF9vCCq1BaEKVizmsnn1jvIy7ret2wkh9
	/53zvTEAF8Dei5yVKzcdy3zUAi5ZaO1JU/A1Wy6wOwwdCzjnLsJuX3GcOWP4ZSqm
	biKgiV5hPEJ46TFzR9/Qdqs5o7OFd1spIjw==
X-ME-Sender: <xms:2KbGZ0G-Bads3rRnmRr8Af1afSFYpYUpnoffmx_1QlM9fPLQCTwv6w>
    <xme:2KbGZ9WDQlCWnovLF6n_v85v73t-dTp6iysDIdjozf1CPRKLfglx4NzXqQmmO2MuS
    RaKTVph5oTasK-2tQ>
X-ME-Received: <xmr:2KbGZ-LXfyTn4e2ZPGe3muez_xsZHaIaP5ak7BPGxYXx7Q59wehpv9QqMwnDjzOKakvWm8BMRDBwJ4oWIRZbo4-0eOjQtGwR-uNkElFYcOenPwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddufeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeuudegjefhvedtudfftdegffdvheetheeffeeigeeh
    ueejvdeggefhudduheegleenucffohhmrghinheptghruhigrdhnuhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghffhgvnhesshgurgho
    uggvnhdrvghu
X-ME-Proxy: <xmx:2KbGZ2Fjn6vp8-U7IRouqqu_nzKZOwezZsBhhNn3iM16N5iWnwMroA>
    <xmx:2KbGZ6U61j3mckk10yGg81XXr7pdtMi9xFHW-JPIskUuYPMDgLRACQ>
    <xmx:2KbGZ5PS6XOvXUBGp6U6K5_IP042NmbayebGcyYZpMgNetSvIO5iuQ>
    <xmx:2KbGZx1M4HnUWFlK0nJJzqjg4KKPKtL4puX5_kv8c7QOEpOoKRCU6Q>
    <xmx:2abGZ3gXrrimMzNiMcxE2Ri1xQcIuAYN1RUBlrhlBcxt5EBfqXF5xsk3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 02:08:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d9d6416 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Mar 2025 07:08:05 +0000 (UTC)
Date: Tue, 4 Mar 2025 08:08:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: meson build: datadir missing?
Message-ID: <Z8am0ZmkJ7QD13_g@pks.im>
References: <20250303203320.lP10PHC5@steffen%sdaoden.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303203320.lP10PHC5@steffen%sdaoden.eu>

On Mon, Mar 03, 2025 at 09:33:20PM +0100, Steffen Nurpmeso wrote:
> Hello again after a long time.
> 
> I opened
> 
>   https://git.crux.nu/ports/opt/issues/18
> 
> at my linux distro ([ports/opt] git: creates incomplete repos),
> because hook etc directories were missing:
> 
>   warning: templates not found in /share/git-core/templates

Okay.

>   hi. thanks, i see now (after looking around). it is a fallout of switching to meson, that build system seems incomplete
> 
>   master:meson.build: '-DDEFAULT_GIT_TEMPLATE_DIR="' + get_option('datadir') / 'git-core/templates' + '"',
> 
>   but that "datadir" does not happen to be set at all it seems; is this known upstream? (Hamano does not like me either, so i will not do that..)

"datadir" is set, as it is a default option provided by Meson itself,
and can be configured with `meson setup --datadir`. I've also
double-checked the logic how we set the template directory path, but it
does seem to be correct: our Makefile sets up a path relative to the
prefix, and we do the exact same here. Double-checking on my machine
also confirmed that this works as expected:

    $ meson setup /tmp/build --prefix=/tmp/prefix
    $ meson install -C /tmp/build
    $ touch /tmp/prefix/share/git-core/templates/foobar
    $ /tmp/prefix/bin/git git init /tmp/repo
    $ ls /tmp/repo/.git
    config  description  foobar  HEAD  hooks  info  objects  refs  reftable

So I had a closer look at the recipe that Crux uses for building Git
[1]. As it turns out, the issue isn't the prefix or datadir, but that
Crux enables `-Druntime_prefix=true`:

    $ meson setup /tmp/build --prefix=/tmp/prefix -Druntime_prefix=true
    $ meson install -C /tmp/build
    $ /tmp/prefix/bin/git git init /tmp/repo
    warning: templates not found in /share/git-core/templates

This is a bug that has already been fixed via bd262d07b65 (meson: fix
exec path with enabled runtime prefix, 2025-02-26). I'd recommend to
backport this fix or disable the runtime prefix.

>   Only wondering why this happens at all, and is not covered by its tests, really.

Things like this are somewhat hard to test for as they require a proper
installation.

[1]: https://git.crux.nu/ports/opt/src/branch/3.7/git/Pkgfile

Patrick

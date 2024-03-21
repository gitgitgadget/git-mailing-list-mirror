Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E211E534
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032512; cv=none; b=r/QOvGTMRGUu303B0L8sMvoUpEIxhzeJAmN0FqqBF4//pgUVRvEN/Gku226bSuAyPFLAahYGtu1sQUpqZUmC/7+GOINLVyYrYEhkNF2AsQEprvZAknsyKLk4Kwdu5ZsotNdbEjHBZDJuV9W0WteyA0OrZ1p6zD1fP/qzINKGf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032512; c=relaxed/simple;
	bh=qGVhbDy9hWabK/TyJN3cZAbx8azHwAkBOEdBFndyTNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pKHVyV29o6Esg0qe91n1cxHd8PDy29kgAnpYSLqLa033OHJ2PAfwSX6S55R4q3j2mG6FT28To3hlMlFvnuKiJVkjMqK9DWmJtHvEKNIf3f78qE6rAVBReeJ7hz5Fm6D2bc0beFlk4reCDnDaQL2m6kkoG40rSYE0q2x2UJhewno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=hXRt6wSV; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="hXRt6wSV"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:a24:f690:de50:c41e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 6F70060358;
	Thu, 21 Mar 2024 15:48:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711032506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=W0rxEqxF4ntO+bXzG1lXqq6Yng89y6QWT2e+1NVmEa8=;
	b=hXRt6wSVsIt0Y98IMxkI/Yt+sJD5VLAsw30k3fP7ZewoTbhbGk+jsYnocZJj06+LJiOgQ/
	0rByfqtl9WIml5sM/0DdZopjYW1fxKghv7wJsJ9QQ5aVgEJs79hvq0FWry15mEU8s5iUMY
	zhkH/2ttGHS2Kj8byFB3JA0tGX7YdBIg45BhgfNTQj92vqq3Iog9jsEkdLD8QwCHqkzZt7
	bIvUZ43yD9Gwh6Srhbryj8zgBXIc0YNE2mpculSVQakwfTVzw3ePY+w9ebSM7UZGabSN3Z
	SWNOTJ3pgzaGCa7vhd0xoN1qyCh8bfeziNbCAl4SjmUyE0/rst7YivwWZ84rqA==
Date: Thu, 21 Mar 2024 15:48:26 +0100
From: Max Gautier <mg@max.gautier.name>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [RFC PATCH 1/5] maintenance: package systemd units
Message-ID: <ZfxIungwqHdGCZlv@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfw4XNJdZqgZhvOv@framework>

On Thu, Mar 21, 2024 at 02:38:36PM +0100, Max Gautier wrote:
> On Thu, Mar 21, 2024 at 01:37:30PM +0100, Patrick Steinhardt wrote:
> > On Mon, Mar 18, 2024 at 04:31:15PM +0100, Max Gautier wrote:
> > 
> > It would be great to document _why_ we want to package the systemd units
> > alongside with Git.
> > 
> > > Signed-off-by: Max Gautier <mg@max.gautier.name>
> > > ---
> > >  Makefile                              |  4 ++++
> > >  systemd/user/git-maintenance@.service | 16 ++++++++++++++++
> > >  systemd/user/git-maintenance@.timer   |  9 +++++++++
> > >  3 files changed, 29 insertions(+)
> > >  create mode 100644 systemd/user/git-maintenance@.service
> > >  create mode 100644 systemd/user/git-maintenance@.timer
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index 4e255c81f2..276b4373c6 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -619,6 +619,7 @@ htmldir = $(prefix)/share/doc/git-doc
> > >  ETC_GITCONFIG = $(sysconfdir)/gitconfig
> > >  ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
> > >  lib = lib
> > > +libdir = $(prefix)/lib
> > >  # DESTDIR =
> > >  pathsep = :
> > >  
> > > @@ -1328,6 +1329,8 @@ BUILTIN_OBJS += builtin/verify-tag.o
> > >  BUILTIN_OBJS += builtin/worktree.o
> > >  BUILTIN_OBJS += builtin/write-tree.o
> > >  
> > > +SYSTEMD_USER_UNITS := $(wildcard systemd/user/*)
> > > +
> > >  # THIRD_PARTY_SOURCES is a list of patterns compatible with the
> > >  # $(filter) and $(filter-out) family of functions. They specify source
> > >  # files which are taken from some third-party source where we want to be
> > > @@ -3469,6 +3472,7 @@ install: all
> > >  	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > >  	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
> > >  	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
> > > +	$(INSTALL) -Dm 644 -t '$(DESTDIR_SQ)$(libdir)/systemd/user' $(SYSTEMD_USER_UNITS)
> > 
> > I wonder whether we want to unconditionally install those units. Many of
> > the platforms that we support don't even have systemd available, so
> > certainly it wouldn't make any sense to install it on those platforms.
> > 
> > Assuming that this is something we want in the first place I thus think
> > that we should at least make this conditional and add some platform
> > specific quirk to "config.mak.uname".
> > 
> 
> We probably want that (conditional install) but I'm not sure where that
> should go ; I'm not super familiar with autoconf. 
> 
> I just noticed than man 7 daemon (shipped by systemd) propose the
> following snippet for installing systemd system services (should be easy
> enough to adapt for user ervices, I think):
> 
> PKG_PROG_PKG_CONFIG()
> AC_ARG_WITH([systemdsystemunitdir],
>     [AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [Directory for systemd service files])],,
>     [with_systemdsystemunitdir=auto])
> AS_IF([test "x$with_systemdsystemunitdir" = "xyes" -o "x$with_systemdsystemunitdir" = "xauto"], [
>     def_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)
> 
>     AS_IF([test "x$def_systemdsystemunitdir" = "x"],
>   [AS_IF([test "x$with_systemdsystemunitdir" = "xyes"],
>    [AC_MSG_ERROR([systemd support requested but pkg-config unable to query systemd package])])
>    with_systemdsystemunitdir=no],
>   [with_systemdsystemunitdir="$def_systemdsystemunitdir"])])
> AS_IF([test "x$with_systemdsystemunitdir" != "xno"],
>      [AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])])
> AM_CONDITIONAL([HAVE_SYSTEMD], [test "x$with_systemdsystemunitdir" != "xno"])
> 
> Would something like that work ?

Ugh, that snippet apparently requires that I delete aclocal.m4, execute
`autoreconf --install`, then concat together the previous aclocal.m4 and
the newly generated one.

I'm adding the last authors on aclocal.m4 to the discussion, maybe they
have some lights ? (Though they don't have commits in the last ten
years, so it might be a very long shot ...)

-- 
Max Gautier

Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455D83CD8
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028321; cv=none; b=NQcOK3WHbwOrTppRte2j/trOPqvv5yvQKLQ+5VWOp+5iepoSjlKQDo9M5YCt11L+WW/yah5bT1rmQDZi/siCw9C6pbfCBQ9IST7FAab2ncZQeI+MaGpJrwvrj/05W+YSzKKc+OfxzUqjNgqeNlUDB8tdakxi+EvRtpBggiI3jh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028321; c=relaxed/simple;
	bh=fCOz5/eeqVeD01QAFFfpY3Qsd3xoGyWtKvksOwbgeHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEnlDEzpKYCoQsuLj4p8/ywuW5di0M7z6JKZRrNF4uUQ0wQfNt7vyD9i1syqZuBs65vS8l1+/MviMag0GQgbGbKhoD64Ar649fBdIzZCozOqagnKZYWk5CToxN3ffGoshfck7cs1I16jOIWtsxn+YgjNITA/77J9JEnJzzWdiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=hJeamatf; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="hJeamatf"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:a24:f690:de50:c41e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 6F82F60354;
	Thu, 21 Mar 2024 14:38:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711028316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyCecYCmZPrmgGUfOqMR5faC75tzjWiNXCTDKyPOOV0=;
	b=hJeamatfeqPFGfj//jDi2Oj6vid+ouidb2k5leuTgoS/gTZptUfo1WM8UCPSCif+FO4Nki
	f3H4l6ssdYyGwaHdO9SfJUs4BpuNwKw67Dt7xyrbojmf3Oqa403OOZpCw+E2GpnOwjsJA1
	9uLf1u7zyfZ+WItY8exkcJGU/abSPOUyyttAssOLrcQlW0dXryFdGCo5Q86r64sWxe+i8M
	35WNqDYFExruJBASghKgINUiNMsMChek2q6Okw9QD1D63p0YTB5uWMsnGvKyrHcsqNV3s+
	SmFKot/WfH0DNOKUK6ZQpvT1u02uboLIx54Azx8kI6A5QSOMN6F3SZwwzNUZwg==
Date: Thu, 21 Mar 2024 14:38:36 +0100
From: Max Gautier <mg@max.gautier.name>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 1/5] maintenance: package systemd units
Message-ID: <Zfw4XNJdZqgZhvOv@framework>
References: <20240318153257.27451-1-mg@max.gautier.name>
 <20240318153257.27451-2-mg@max.gautier.name>
 <ZfwqCv889UdI0mU6@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfwqCv889UdI0mU6@tanuki>

On Thu, Mar 21, 2024 at 01:37:30PM +0100, Patrick Steinhardt wrote:
> On Mon, Mar 18, 2024 at 04:31:15PM +0100, Max Gautier wrote:
> 
> It would be great to document _why_ we want to package the systemd units
> alongside with Git.
> 
> > Signed-off-by: Max Gautier <mg@max.gautier.name>
> > ---
> >  Makefile                              |  4 ++++
> >  systemd/user/git-maintenance@.service | 16 ++++++++++++++++
> >  systemd/user/git-maintenance@.timer   |  9 +++++++++
> >  3 files changed, 29 insertions(+)
> >  create mode 100644 systemd/user/git-maintenance@.service
> >  create mode 100644 systemd/user/git-maintenance@.timer
> > 
> > diff --git a/Makefile b/Makefile
> > index 4e255c81f2..276b4373c6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -619,6 +619,7 @@ htmldir = $(prefix)/share/doc/git-doc
> >  ETC_GITCONFIG = $(sysconfdir)/gitconfig
> >  ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
> >  lib = lib
> > +libdir = $(prefix)/lib
> >  # DESTDIR =
> >  pathsep = :
> >  
> > @@ -1328,6 +1329,8 @@ BUILTIN_OBJS += builtin/verify-tag.o
> >  BUILTIN_OBJS += builtin/worktree.o
> >  BUILTIN_OBJS += builtin/write-tree.o
> >  
> > +SYSTEMD_USER_UNITS := $(wildcard systemd/user/*)
> > +
> >  # THIRD_PARTY_SOURCES is a list of patterns compatible with the
> >  # $(filter) and $(filter-out) family of functions. They specify source
> >  # files which are taken from some third-party source where we want to be
> > @@ -3469,6 +3472,7 @@ install: all
> >  	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> >  	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
> >  	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
> > +	$(INSTALL) -Dm 644 -t '$(DESTDIR_SQ)$(libdir)/systemd/user' $(SYSTEMD_USER_UNITS)
> 
> I wonder whether we want to unconditionally install those units. Many of
> the platforms that we support don't even have systemd available, so
> certainly it wouldn't make any sense to install it on those platforms.
> 
> Assuming that this is something we want in the first place I thus think
> that we should at least make this conditional and add some platform
> specific quirk to "config.mak.uname".
> 

We probably want that (conditional install) but I'm not sure where that
should go ; I'm not super familiar with autoconf. 

I just noticed than man 7 daemon (shipped by systemd) propose the
following snippet for installing systemd system services (should be easy
enough to adapt for user ervices, I think):

PKG_PROG_PKG_CONFIG()
AC_ARG_WITH([systemdsystemunitdir],
    [AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [Directory for systemd service files])],,
    [with_systemdsystemunitdir=auto])
AS_IF([test "x$with_systemdsystemunitdir" = "xyes" -o "x$with_systemdsystemunitdir" = "xauto"], [
    def_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)

    AS_IF([test "x$def_systemdsystemunitdir" = "x"],
  [AS_IF([test "x$with_systemdsystemunitdir" = "xyes"],
   [AC_MSG_ERROR([systemd support requested but pkg-config unable to query systemd package])])
   with_systemdsystemunitdir=no],
  [with_systemdsystemunitdir="$def_systemdsystemunitdir"])])
AS_IF([test "x$with_systemdsystemunitdir" != "xno"],
     [AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])])
AM_CONDITIONAL([HAVE_SYSTEMD], [test "x$with_systemdsystemunitdir" != "xno"])

Would something like that work ?

-- 
Max Gautier

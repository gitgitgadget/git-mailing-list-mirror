From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] git-pasky spec file
Date: Fri, 22 Apr 2005 04:40:10 +0200
Message-ID: <20050422024010.GE7443@pasky.ji.cz>
References: <20050422015521.GK493@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 04:36:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOo1N-0005yR-IM
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 04:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVDVCkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 22:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVDVCkW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 22:40:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13967 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261922AbVDVCkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 22:40:16 -0400
Received: (qmail 10604 invoked by uid 2001); 22 Apr 2005 02:40:10 -0000
To: Chris Wright <chrisw@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050422015521.GK493@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 03:55:21AM CEST, I got a letter
where Chris Wright <chrisw@osdl.org> told me that...
> Here's a simple spec file to do rpm builds.  It's against the
> latest Makefile (which has the s/BINDIR/bindir/ change).  I've used
> DESTDIR, although it's not clear it's meant to stay in the Makefile.
> For now, there's no dynamic (git.spec.in, for example) update to the
> Version, so it's set against 0.6.3 (expecting it to be forthcoming
> shortly).  It installs to /usr/local/bin, and expects the tarball to be
> named git-pasky-0.6.3.tar.bz2.  Creates a package named git, which seems
> fine since Linus' isn't likely to be packaged directly.  Enjoy.

Thanks, applied. I'll gladly yet you maintain this file, but...

> --- /dev/null	1969-12-31 16:00:00.000000000 -0800
> +++ git-pasky-0.6.3/git.spec	2005-04-21 18:42:18.000000000 -0700
> @@ -0,0 +1,43 @@
> +%install
> +rm -rf $RPM_BUILD_ROOT
> +make DESTDIR=$RPM_BUILD_ROOT/usr/local/ bindir=bin/ install

I doubt this is actually what you want. I suppose you want

make DESTDIR=$RPM_BUILD_ROOT prefix=/usr/local install

instead. This may not matter now, but might well in future when we stuff
some of the helper/library scripts to some lib/ or share/ directory, and
will actually rewrite some paths somewhere based on $prefix during make
install.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

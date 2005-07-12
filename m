From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] remove Obsoletes from cogito.spec.in
Date: Tue, 12 Jul 2005 11:17:10 -0700
Message-ID: <20050712181710.GW19052@shell0.pdx.osdl.net>
References: <20050712003345.GO19052@shell0.pdx.osdl.net> <20050712073022.GB6363@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 20:21:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsPN2-0007k0-ES
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 20:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVGLST6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 14:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVGLSR4
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 14:17:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61589 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261946AbVGLSRX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 14:17:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6CIHAjA018884
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 12 Jul 2005 11:17:11 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6CIHAbt025777;
	Tue, 12 Jul 2005 11:17:10 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j6CIHADg025776;
	Tue, 12 Jul 2005 11:17:10 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050712073022.GB6363@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Petr Baudis (pasky@suse.cz) wrote:
> where Chris Wright <chrisw@osdl.org> told me that...
> > This is leftover from early naming, and is no longer relevant.
> > 
> > Signed-off-by: Chris Wright <chrisw@osdl.org>
> 
> Thanks, applied. BTW, Josh Boyer of Fedora suggested having the
> 
> 	Provides: git
> 
> line in cogito.spec.in as long as it comes with git bundled (which will
> be so until git stabilizes, doesn't break backwards compatibility once
> in a while, and gets into some regular and reasonably frequent release
> cycle). What do you think?

Hmm, in an ideal world all of those stipulations are right around the
corner.  Also, if the split is done, then cogito can depend on a specific
version of git-core, to help isolate against those upstream changes.
The main thing then is getting any local changes you have pushed to
Linus' git tree (if there are still any).

Adding Provides is probably only useful if there's some other package
that's relying on git being there (i.e. gitweb perhaps).  I guess we
can add that, and remove it when there's proper dependencies in order.
May as well do git-core as is now done in git.

thanks,
-chris
--



Mark cogito rpm package as providing git-core, since it currently does.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

diff --git a/cogito.spec.in b/cogito.spec.in
--- a/cogito.spec.in
+++ b/cogito.spec.in
@@ -10,6 +10,7 @@ Source: 	http://kernel.org/pub/software/
 BuildRequires:	zlib-devel, openssl-devel, curl-devel
 BuildRoot:	%{_tmppath}/%{name}-%{version}-root
 Prereq: 	sh-utils, diffutils, rsync, rcs, mktemp >= 1.5
+Provides:	git-core
 
 %description
 GIT comes in two layers. The bottom layer is merely an extremely fast

From: Chris Wright <chrisw@osdl.org>
Subject: [PATCH] cogito: Fix rpm build for 64bit platforms
Date: Sun, 18 Sep 2005 10:32:29 -0700
Message-ID: <20050918173229.GR7762@shell0.pdx.osdl.net>
References: <20050916154631.GJ8041@shell0.pdx.osdl.net> <200509161944.j8GJijY3019186@inti.inf.utfsm.cl> <20050916201901.GF7762@shell0.pdx.osdl.net> <20050917214807.GA3590@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 19:32:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH31s-0003nr-F9
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 19:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVIRRce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 13:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVIRRce
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 13:32:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30110 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932135AbVIRRcd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 13:32:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8IHWTBo006485
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Sep 2005 10:32:29 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8IHWThT022768;
	Sun, 18 Sep 2005 10:32:29 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j8IHWTb9022767;
	Sun, 18 Sep 2005 10:32:29 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050917214807.GA3590@pasky.or.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8792>

When building last update on 64bit machine, I realized the _libdir
change breaks the rpm build there.  This fixes up the issue by ensuring
the libdir %install target is same as %files target.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 cogito.spec.in |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/cogito.spec.in b/cogito.spec.in
--- a/cogito.spec.in
+++ b/cogito.spec.in
@@ -25,7 +25,7 @@ make
 
 %install
 rm -rf $RPM_BUILD_ROOT
-make DESTDIR=$RPM_BUILD_ROOT prefix=%{_prefix} install
+make DESTDIR=$RPM_BUILD_ROOT prefix=%{_prefix} libdir=%{_libdir}/cogito install
 
 %clean
 rm -rf $RPM_BUILD_ROOT
@@ -38,6 +38,9 @@ rm -rf $RPM_BUILD_ROOT
 %doc README COPYING Documentation/*
 
 %changelog
+* Fri Sep 16 2005 Chris Wright <chrisw@osdl.org> 0.14.1-2
+- fix _libdir breakage on 64-bit, the irony...
+
 * Thu Sep 15 2005 Chris Wright <chrisw@osdl.org> 0.14.1-1
 - Update to 0.14.1
 

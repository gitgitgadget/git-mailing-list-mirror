From: walt <wa1ter@myrealbox.com>
Subject: [PATCH] Building git on NetBSD
Date: Sat, 12 Nov 2005 07:12:59 -0800
Organization: git
Message-ID: <Pine.LNX.4.64.0511120649430.2695@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Nov 12 16:16:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eax6t-0005HU-4U
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 16:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVKLPQD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 10:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVKLPQD
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 10:16:03 -0500
Received: from main.gmane.org ([80.91.229.2]:5767 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932374AbVKLPQC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 10:16:02 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Eax5M-0004tG-79
	for git@vger.kernel.org; Sat, 12 Nov 2005 16:14:32 +0100
Received: from adsl-69-234-191-211.dsl.irvnca.pacbell.net ([69.234.191.211])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Nov 2005 16:14:32 +0100
Received: from wa1ter by adsl-69-234-191-211.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 12 Nov 2005 16:14:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-191-211.dsl.irvnca.pacbell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11689>

This gets git going on NetBSD:

--- Makefile.orig	2005-11-12 05:06:55.000000000 -0800
+++ Makefile
@@ -212,6 +212,10 @@ ifeq ($(uname_S),OpenBSD)
 	NEEDS_LIBICONV = YesPlease
 	ALL_CFLAGS += -I/usr/local/include -L/usr/local/lib
 endif
+ifeq ($(uname_S),NetBSD)
+	NEEDS_LIBICONV = YesPlease
+	ALL_CFLAGS += -I/usr/pkg/include -L/usr/pkg/lib -Wl,-rpath,/usr/pkg/lib
+endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 endif

I'm no software developer so I'm not sure about the syntax of the -rpath
flag.  It does what I wanted, but it results in lots of warnings about
not being used because no linking is taking place.  Should this maybe
go in LDFLAGS instead of CFLAGS?  Dunno.

Anyway, I actually used cg-clone on NetBSD to clone the git repository,
and I'll try to get the pkgsrc guys interested in creating packages for
cogito and git.

Oh, one person was concerned about the cogito scripts running on the
NetBSD version of sh, which isn't bash.  So far I've tried cg-clone,
cg-update, and gitk, and all worked just like on linux.  Any chance
that some of the other scripts may not work as well on a non-bash sh?

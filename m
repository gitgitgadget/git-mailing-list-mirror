From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] Teach Makefile to respect external variables: CFLAGS and others.
Date: Wed, 13 Jun 2007 09:42:30 +0400
Message-ID: <20070613054229.GM86872@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 08:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyLvp-0003G3-45
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 08:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbXFMGCA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 02:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754095AbXFMGCA
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 02:02:00 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:60021 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbXFMGB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 02:01:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Message-ID:MIME-Version:Content-Type:Content-Disposition:Sender:X-Spam-Status:Subject;
	b=do/BSVuQ63s9CfL43za3bnMtSolOzoP5NybxGwxbKhaRusQbmswaLuUhkebtkIByR4831/b39p0sA7TR00hEDG6wiRiio84TeIbcwrMx5eKG/hure8SGrsrrUlZeRvem/lQl9NslWS/Fpm9jALr4xFQEP45iR/r5LoWyAm/9THk=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HyLco-000CZb-8i for git@vger.kernel.org; Wed, 13 Jun 2007 09:42:34 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50019>

If one is not using the configure script, then there is no way to
redefine variables CFLAGS, LFLAGS, CC, AR, TAR, INSTALL, RPMBUILD,
TCL_PATCH and TCLTK_PATH.  This shouldn't be so, since these variables
can be manually set by user and we should respect them.

The patch originates from the FreeBSD port and was originally made
by Ed Schouten, ed at fxq dot nl.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 Makefile |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 30a4052..6cd9ea2 100644
--- a/Makefile
+++ b/Makefile
@@ -135,8 +135,8 @@ uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -g -O2 -Wall
-LDFLAGS =
+CFLAGS ?= -g -O2 -Wall
+LDFLAGS ?=
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
@@ -172,13 +172,13 @@ GITWEB_SITE_FOOTER =
 
 export prefix bindir gitexecdir sharedir template_dir sysconfdir
 
-CC = gcc
-AR = ar
-TAR = tar
-INSTALL = install
-RPMBUILD = rpmbuild
-TCL_PATH = tclsh
-TCLTK_PATH = wish
+CC ?= gcc
+AR ?= ar
+TAR ?= tar
+INSTALL ?= install
+RPMBUILD ?= rpmbuild
+TCL_PATH ?= tclsh
+TCLTK_PATH ?= wish
 
 export TCL_PATH TCLTK_PATH
 
-- 
1.5.2.1

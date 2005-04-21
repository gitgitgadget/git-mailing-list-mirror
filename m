From: Klaus Robert Suetterlin <robert@mpe.mpg.de>
Subject: HOWTO: PATCH: don't hardcode path-to-bash, use sys/limits.h
Date: Thu, 21 Apr 2005 12:23:26 +0200
Message-ID: <20050421102326.GA22541@xdt04.mpe-garching.mpg.de>
References: <426734DE.3040606@timesys.com> <426736AF.7000900@timesys.com> <4267387A.6040602@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 12:20:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOYmF-0005TY-GQ
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 12:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVDUKXk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 06:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVDUKXk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 06:23:40 -0400
Received: from mpehp1.mpe-garching.mpg.de ([130.183.70.10]:40198 "EHLO
	mpehp1.mpe-garching.mpg.de") by vger.kernel.org with ESMTP
	id S261250AbVDUKXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 06:23:32 -0400
Received: from xdt04.mpe-garching.mpg.de (xdt04.mpe-garching.mpg.de [130.183.136.164])
	by mpehp1.mpe-garching.mpg.de (8.9.3 (PHNE_25183+JAGae58098)/8.9.3) with ESMTP id MAA22438;
	Thu, 21 Apr 2005 12:23:28 +0200 (METDST)
Received: (from krs@localhost)
	by xdt04.mpe-garching.mpg.de (8.13.3/8.13.1/Submit) id j3LANQ3V039668;
	Thu, 21 Apr 2005 12:23:26 +0200 (CEST)
	(envelope-from krs)
To: Mike Taht <mike.taht@timesys.com>
Content-Disposition: inline
In-Reply-To: <4267387A.6040602@timesys.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I supply a patch that dehardcodes the path to bash (which is not /bin on all computers) and adds sys/limits.h to provide ULONG_MAX.

If this is not the right way to supply patches, or if this email misses some crucial point please tell me so, and supply explanation.

-- 
Robert Suetterlin (robert@mpe.mpg.de)
phone: (+49)89 / 30000-3546   fax: (+49)89 / 30000-3950

commit 5f6caff82b1f3b5931d92aaff99be6d8dbad10ca
tree d7ea8aeefbbc2ab63cb5acd41b647b1b5f11fb83
parent cd1c034369b73da7503da365fa556aab27004814
author Klaus Robert Suetterlin <krs@xdt04.mpe-garching.mpg.de> 1114078431 +0200
committer Klaus Robert Suetterlin <krs@xdt04.mpe-garching.mpg.de> 1114078431 +0200

Don't hardcode the path-to-bash please.

Index: commit.c
===================================================================
--- c0260bfb82da04aeff4e598ced5295d6ae2e262d/commit.c  (mode:100644 sha1:eda45d7e15358ed6f2cd0502de2a08987307fc98)
+++ d7ea8aeefbbc2ab63cb5acd41b647b1b5f11fb83/commit.c  (mode:100644 sha1:cfe9a8ddf6ee2702e3923cb22240f9f9ed1bd04c)
@@ -1,3 +1,4 @@
+#include <sys/limits.h>
 #include "commit.h"
 #include "cache.h"
 #include <string.h>
Index: gitdiff-do
===================================================================
--- c0260bfb82da04aeff4e598ced5295d6ae2e262d/gitdiff-do  (mode:100755 sha1:afed4e40b259a61b0f12979ba7326f26743bc553)
+++ d7ea8aeefbbc2ab63cb5acd41b647b1b5f11fb83/gitdiff-do  (mode:100755 sha1:218dfabeb4a5dcbd2cf58bd6f672f385690ec397)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Make a diff between two GIT trees.
 # Copyright (c) Petr Baudis, 2005
Index: gitlog.sh
===================================================================
--- c0260bfb82da04aeff4e598ced5295d6ae2e262d/gitlog.sh  (mode:100755 sha1:a496a864f9586e47a4d7bd3ae0af0b3e07b7deb8)
+++ d7ea8aeefbbc2ab63cb5acd41b647b1b5f11fb83/gitlog.sh  (mode:100755 sha1:7b3aa8a89bc64273c648920ccd1686859754803e)
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 #
 # Make a log of changes in a GIT branch.
 #

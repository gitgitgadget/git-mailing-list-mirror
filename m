From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Ensure 'make dist' compiles git-archive.exe on Cygwin
Date: Sun, 24 Feb 2008 00:38:04 -0500
Message-ID: <20080224053804.GA22150@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 06:38:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT9ZX-0003d5-Bj
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 06:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbYBXFiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 00:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbYBXFiK
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 00:38:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42594 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbYBXFiI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 00:38:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JT9Ys-00007w-MJ; Sun, 24 Feb 2008 00:38:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DEE6D20FBAE; Sun, 24 Feb 2008 00:38:04 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74902>

On Cygwin we have to use git-archive.exe as the target, otherwise
running 'make dist' does not compile git-archive in the current
directory.  That may cause 'make dist' to fail on a clean source
tree that has never been built before.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 4d53898..86ef951 100644
--- a/Makefile
+++ b/Makefile
@@ -1103,7 +1103,7 @@ git.spec: git.spec.in
 	mv $@+ $@
 
 GIT_TARNAME=git-$(GIT_VERSION)
-dist: git.spec git-archive configure
+dist: git.spec git-archive$(X) configure
 	./git-archive --format=tar \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
 	@mkdir -p $(GIT_TARNAME)
-- 
1.5.4.3.295.g6b554

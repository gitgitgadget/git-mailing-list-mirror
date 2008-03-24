From: Damien Diederen <dash@foobox.net>
Subject: [PATCH 2/7] cvsserver: Only print the file part of the filename in status header
Date: Mon, 24 Mar 2008 23:49:07 +0100
Message-ID: <42e48b57a0e94ca07e9dea28da2fa1f8d8a074c2.1206393086.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:49:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdvUI-0002Uj-Os
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbYCXWtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbYCXWtM
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:49:12 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:42768 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753772AbYCXWtL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 18:49:11 -0400
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 5B50B20917E;
	Mon, 24 Mar 2008 23:49:10 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 466752540A3;
	Mon, 24 Mar 2008 23:49:10 +0100 (CET)
Received: from keem.bcc (dslb-084-057-018-240.pools.arcor-ip.net [84.57.18.240])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id B9CC38C465;
	Mon, 24 Mar 2008 23:49:07 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: 42e48b57a0e94ca07e9dea28da2fa1f8d8a074c2 Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6378/Mon Mar 24 22:24:31 2008 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78116>


The "File:" header of CVS status output only includes the basename of
the file, even when generating a recursive listing; do the same.

Signed-off-by: Damien Diederen <dash@foobox.net>
---
 git-cvsserver.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 33d30c5..9101eef 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -1466,8 +1466,10 @@ sub req_status
 
         $status ||= "Unknown";
 
+        my ($filepart) = filenamesplit($filename);
+
         print "M ===================================================================\n";
-        print "M File: $filename\tStatus: $status\n";
+        print "M File: $filepart\tStatus: $status\n";
         if ( defined($state->{entries}{$filename}{revision}) )
         {
             print "M Working revision:\t" . $state->{entries}{$filename}{revision} . "\n";
-- 
1.5.5.rc1.6.gd183

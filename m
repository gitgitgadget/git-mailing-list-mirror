From: Damien Diederen <dash@foobox.net>
Subject: [PATCH 1/7] cvsserver: Respond to the 'editors' command
Date: Mon, 24 Mar 2008 23:48:52 +0100
Message-ID: <8cb3f0ef415bdfe8a25f89fdac3d14d3b8360dcf.1206393086.git.dash@foobox.net>
References: <cover.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin@catalyst.net.nz>,
	Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:49:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdvU1-0002Py-Ox
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 23:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbYCXWsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 18:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753759AbYCXWsz
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 18:48:55 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:55724 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753571AbYCXWsy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 18:48:54 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id C0E171E4F8A;
	Mon, 24 Mar 2008 23:48:53 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id A71D223D3FA;
	Mon, 24 Mar 2008 23:48:53 +0100 (CET)
Received: from keem.bcc (dslb-084-057-018-240.pools.arcor-ip.net [84.57.18.240])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 293A88C465;
	Mon, 24 Mar 2008 23:48:52 +0100 (CET)
In-Reply-To: <cover.1206393086.git.dash@foobox.net>
X-From-Line: 8cb3f0ef415bdfe8a25f89fdac3d14d3b8360dcf Mon Sep 17 00:00:00 2001
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6378/Mon Mar 24 22:24:31 2008 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78115>


"Cvs editors" lists the users currently working on watched (locked)
files.  This trivial implementation always returns an empty response,
since git-cvsserver does not implement file locking.

Without this, TkCVS hangs at startup, waiting forever for a response.

Signed-off-by: Damien Diederen <dash@foobox.net>
---
 git-cvsserver.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 7f632af..33d30c5 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -74,7 +74,7 @@ my $methods = {
     'admin'           => \&req_CATCHALL,
     'history'         => \&req_CATCHALL,
     'watchers'        => \&req_CATCHALL,
-    'editors'         => \&req_CATCHALL,
+    'editors'         => \&req_editors,
     'annotate'        => \&req_annotate,
     'Global_option'   => \&req_Globaloption,
     #'annotate'        => \&req_CATCHALL,
@@ -1489,6 +1489,11 @@ sub req_status
     print "ok\n";
 }
 
+sub req_editors
+{
+    print "ok\n";
+}
+
 sub req_diff
 {
     my ( $cmd, $data ) = @_;
-- 
1.5.5.rc1.6.gd183

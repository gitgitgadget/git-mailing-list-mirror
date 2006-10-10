From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] cvsserver: fix "cvs diff" in a subdirectory
Date: Wed, 11 Oct 2006 00:33:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610110032560.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 00:33:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXQAM-0001cF-2R
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 00:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030604AbWJJWde (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 18:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030603AbWJJWde
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 18:33:34 -0400
Received: from mail.gmx.de ([213.165.64.20]:41914 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030602AbWJJWdd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 18:33:33 -0400
Received: (qmail invoked by alias); 10 Oct 2006 22:33:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 11 Oct 2006 00:33:31 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martyn Smith <martyn@catalyst.net.nz>,
	Martin Langhoff <martin@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28682>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git-cvsserver.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 7260f32..da00432 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -277,7 +277,7 @@ sub req_Directory
     $state->{directory} = "" if ( $state->{directory} eq "." );
     $state->{directory} .= "/" if ( $state->{directory} =~ /\S/ );
 
-    if ( not defined($state->{prependdir}) and $state->{localdir} eq "." and $state->{path} =~ /\S/ )
+    if ( (not defined($state->{prependdir}) or $state->{prependdir} eq '') and $state->{localdir} eq "." and $state->{path} =~ /\S/ )
     {
         $log->info("Setting prepend to '$state->{path}'");
         $state->{prependdir} = $state->{path};
-- 
1.4.3.rc2.g55b2-dirty

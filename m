From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/4] merge-one-file: use 'wc' more portably
Date: Wed, 24 Jan 2007 02:13:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701240213330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jan 24 02:14:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Wi8-0006KH-7x
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 02:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965482AbXAXBN5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 20:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965486AbXAXBN5
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 20:13:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:34263 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965482AbXAXBN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 20:13:56 -0500
Received: (qmail invoked by alias); 24 Jan 2007 01:13:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 24 Jan 2007 02:13:55 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37585>


Some wc prefix the number by a tab. Be prepared for this.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 git-merge-one-file.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 7d62d79..bc7c5ef 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -87,9 +87,9 @@ case "${1:-.}${2:-.}${3:-.}" in
 		# This extracts OUR file in $orig, and uses git-apply to
 		# remove lines that are unique to ours.
 		orig=`git-unpack-file $2`
-		sz0=`wc -c <"$orig"`
+		sz0=`wc -c <"$orig" | tr -dc 0-9`
 		diff -u -La/$orig -Lb/$orig $orig $src2 | git-apply --no-add 
-		sz1=`wc -c <"$orig"`
+		sz1=`wc -c <"$orig" | tr -dc 0-9`
 
 		# If we do not have enough common material, it is not
 		# worth trying two-file merge using common subsections.
-- 
1.5.0.rc2.gc5868-dirty

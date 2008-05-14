From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] cvsexportcommit: chomp only removes trailing
 whitespace
Date: Wed, 14 May 2008 15:27:05 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141526160.30431@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 16:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwHxY-00035c-KG
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 16:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592AbYENO1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 10:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755884AbYENO1J
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 10:27:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:57977 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755870AbYENO1G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 10:27:06 -0400
Received: (qmail invoked by alias); 14 May 2008 14:27:03 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp008) with SMTP; 14 May 2008 16:27:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tzQ4gQvvtMfiEvULOu2S3riJFLgsA+ngYDn5Bsm
	fTymArVLW3oBnx
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82102>


In commit fef3a7cc(cvsexportcommit: be graceful when "cvs status"
reorders the arguments), caution was taken to get the status even
for files with leading or trailing whitespace.

However, the author of that commit missed that chomp() removes only
trailing whitespace.  But the author realized his mistake.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Really my fault.

 git-cvsexportcommit.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index b6036bd..3b20bd1 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -211,6 +211,7 @@ if (@canstatusfiles) {
 
 	$basename = "no file " . $basename if (exists($added{$basename}));
 	chomp($basename);
+	$basename =~ s/^\s+//;
 
 	if (!exists($fullname{$basename})) {
 	  $fullname{$basename} = $name;
-- 
1.5.5.1.375.g1becb

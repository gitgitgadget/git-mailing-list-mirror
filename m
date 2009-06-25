From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [JGIT PATCH] make_jgit.sh: do not fail with untagged repository
Date: Thu, 25 Jun 2009 17:40:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906251740020.8908@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Brantley <jsbmsu@gmail.com>
To: spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 17:41:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJr4T-000780-JC
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 17:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbZFYPkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 11:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758708AbZFYPke
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 11:40:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:41508 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758121AbZFYPke (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 11:40:34 -0400
Received: (qmail invoked by alias); 25 Jun 2009 15:40:35 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp034) with SMTP; 25 Jun 2009 17:40:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jFJ18Ls9juFZxWqjrcDdj/HOtfP/6IoTVNN4D2S
	SXTGXcjzXei4ND
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122214>


With a repository lacking tags, make_jgit.sh would produce an
invalid jgit.jar.  So use the fake tag "untagged" in that case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 make_jgit.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/make_jgit.sh b/make_jgit.sh
index 2969e6e..027a074 100755
--- a/make_jgit.sh
+++ b/make_jgit.sh
@@ -56,7 +56,7 @@ if [ -n "`git diff-index --name-only HEAD --`" ]
 then
 	VN="$VN-dirty"
 fi
-VN=`echo "$VN" | sed -e s/-/./g`
+VN=${VN:-untagged}`echo "$VN" | sed -e s/-/./g`
 
 CLASSPATH=
 for j in $JARS
-- 
1.6.3.284.g6fecc

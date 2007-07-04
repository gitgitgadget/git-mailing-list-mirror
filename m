From: Sean <seanlkml@sympatico.ca>
Subject: Alter git-checkout reflog message to include "from" branch
Date: Wed, 4 Jul 2007 04:33:36 -0400
Message-ID: <20070704043336.0cfa4d8a.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 10:33:48 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I60J2-0006iy-9l
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 10:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901AbXGDIdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 04:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbXGDIdq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 04:33:46 -0400
Received: from bay0-omc2-s20.bay0.hotmail.com ([65.54.246.156]:64178 "EHLO
	bay0-omc2-s20.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755659AbXGDIdp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2007 04:33:45 -0400
Received: from BAYC1-PASMTP01.CEZ.ICE ([65.54.191.161]) by bay0-omc2-s20.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Wed, 4 Jul 2007 01:33:45 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP01.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Wed, 4 Jul 2007 01:33:44 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1I60Ix-0003FF-MH
	for git@vger.kernel.org; Wed, 04 Jul 2007 04:33:43 -0400
X-Mailer: Sylpheed 2.4.1 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 04 Jul 2007 08:33:44.0953 (UTC) FILETIME=[08CC8E90:01C7BE16]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51580>


    
    As suggested by Junio, adding the current branch name to the
    reflog message for git-checkout would be helpful.  For example:
    
       "checkout: moving from next to master"
    
    Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

diff --git a/git-checkout.sh b/git-checkout.sh
index e00b697..17f4392 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -259,7 +259,8 @@ if [ "$?" -eq 0 ]; then
 	fi
 	if test -n "$branch"
 	then
-		GIT_DIR="$GIT_DIR" git symbolic-ref -m "checkout: moving to $branch" HEAD "refs/heads/$branch"
+		old_branch_name=`expr "z$oldbranch" : 'zrefs/heads/\(.*\)'`
+		GIT_DIR="$GIT_DIR" git symbolic-ref -m "checkout: moving from $old_branch_name to $branch" HEAD "refs/heads/$branch"
 		if test -n "$quiet"
 		then
 			true	# nothing

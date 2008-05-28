From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [PATCH] Completion: Hint whether amend is the right thing to do.
Date: Wed, 28 May 2008 16:08:01 +0200
Message-ID: <200805281608.02000.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 16:15:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1MN1-0008U1-Kk
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 16:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbYE1OKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 10:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbYE1OKR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 10:10:17 -0400
Received: from [83.140.172.130] ([83.140.172.130]:28069 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbYE1OKP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 10:10:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A76C21434D37;
	Wed, 28 May 2008 16:10:12 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cx9u8MUecY3c; Wed, 28 May 2008 16:10:12 +0200 (CEST)
Received: from [10.9.0.9] (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 257451434D36;
	Wed, 28 May 2008 16:10:12 +0200 (CEST)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83091>

When you get a conflict during interactive rebase the next
thing to do is not to amend, but to continue the rebase.
With this change you get a reminder in the prompt.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 contrib/completion/git-completion.bash |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

I got a couple of broken rebases. Hence this fix.

-- robin

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1698463..a606328 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -82,7 +82,12 @@ __git_ps1 ()
 			b="$(git symbolic-ref HEAD 2>/dev/null)"
 		elif [ -f "$g/.dotest-merge/interactive" ]
 		then
-			r="|REBASE-i"
+			if [ -f "$g/.dotest-merge/amend" ]
+			then
+				r="|REBASE-i-amend"
+			else
+				r="|REBASE-i-continue"
+			fi
 			b="$(cat "$g/.dotest-merge/head-name")"
 		elif [ -d "$g/.dotest-merge" ]
 		then
-- 
1.5.5.1.178.g1f811

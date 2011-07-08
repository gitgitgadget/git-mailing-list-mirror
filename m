From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2] git-rebase.txt: clarify that --abort checks out <branch>
Date: Thu,  7 Jul 2011 22:27:49 -0400
Message-ID: <1310092069-19708-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1309574324-6833-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 04:28:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qf0ny-0001XU-5X
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 04:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab1GHC21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 22:28:27 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52926 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab1GHC20 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 22:28:26 -0400
Received: by vxb39 with SMTP id 39so1107126vxb.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=c3XL25PEchZvxDxp0ebyszKzQFP7LSdLokkxCSRnlng=;
        b=JlZuGMQwqYilyCoLRmuZVzhXqUgH2PVKbNXQ5PgdGs5f5C9V4ICxrTbCl/D1it6TAm
         oQxim4Z5XZ0wJ2EZyxVY033hc53iatk7dGaZWuMHXa8eItPuLlVokHGd8JVcDqRCSVIL
         IxiJsjzAOS9eOLscpbHrgrtHQmkCsw8aGEZlM=
Received: by 10.52.169.1 with SMTP id aa1mr2131499vdc.143.1310092105613;
        Thu, 07 Jul 2011 19:28:25 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id l18sm5860475vby.14.2011.07.07.19.28.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jul 2011 19:28:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.51.g07e0e
In-Reply-To: <1309574324-6833-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176796>

The description for 'git rebase --abort' currently says:

    Restore the original branch and abort the rebase operation.

The "restore" can be misinterpreted to imply that the original branch
was somehow in a broken state during the rebase operation. It is also
not completely clear what "the original branch" is --- is it the
branch that was checked out before the rebase operation was called or
is the the branch that is being rebased (it is the latter)? Although
both issues are made clear in the DESCRIPTION section, let us also
make the entry in the OPTIONS secion more clear.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 Documentation/git-rebase.txt |    6 +++++-
 git-rebase.sh                |    2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a9e0e50..d2f2cd9 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -232,7 +232,11 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	Restart the rebasing process after having resolved a merge conflict.
 
 --abort::
-	Restore the original branch and abort the rebase operation.
+	Abort the rebase operation and reset HEAD to the original
+	branch. If <branch> was provided when the rebase operation was
+	started, then HEAD will be reset to <branch>. Otherwise HEAD
+	will be reset to where it was when the rebase operation was
+	started.
 
 --skip::
 	Restart the rebasing process by skipping the current patch.
diff --git a/git-rebase.sh b/git-rebase.sh
index d7855ea..f2d4c72 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -58,7 +58,7 @@ ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
  Actions:
 continue!          continue rebasing process
-abort!             abort rebasing process and restore original branch
+abort!             abort rebasing process and reset HEAD to <branch>
 skip!              skip current patch and continue rebasing process
 "
 . git-sh-setup
-- 
1.7.6.51.g07e0e

From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/2] push: avoid suggesting "merging" remote changes
Date: Sun,  7 Jul 2013 20:02:14 +0100
Message-ID: <2a6f4a3c31e667aa03b06ce63ae5319a25beaca0.1373223663.git.john@keeping.me.uk>
References: <cover.1373223663.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 21:02:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvuEZ-0001Hg-Fa
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 21:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045Ab3GGTCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 15:02:48 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:52633 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab3GGTCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 15:02:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 79A7C6064D7;
	Sun,  7 Jul 2013 20:02:41 +0100 (BST)
X-Quarantine-ID: <u27HPfsJxjDK>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u27HPfsJxjDK; Sun,  7 Jul 2013 20:02:40 +0100 (BST)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 89D0C6064E4;
	Sun,  7 Jul 2013 20:02:30 +0100 (BST)
X-Mailer: git-send-email 1.8.3.2.855.gbc9faed
In-Reply-To: <cover.1373223663.git.john@keeping.me.uk>
In-Reply-To: <cover.1373223663.git.john@keeping.me.uk>
References: <cover.1373223663.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229799>

With some workflows, it is more suitable to rebase on top of remote
changes when a push does not fast-forward.  Change the advice messages
in git-push to suggest that a user "integrate the remote changes"
instead of "merge the remote changes" to make this slightly clearer.

Also change the suggested 'git pull' to 'git pull ...' to hint to users
that they may want to add other parameters.

Suggested-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/push.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 2d84d10..44e53cd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -211,8 +211,8 @@ static void setup_default_push_refspecs(struct remote *remote)
 
 static const char message_advice_pull_before_push[] =
 	N_("Updates were rejected because the tip of your current branch is behind\n"
-	   "its remote counterpart. Merge the remote changes (e.g. 'git pull')\n"
-	   "before pushing again.\n"
+	   "its remote counterpart. Integrate the remote changes (e.g.\n"
+	   "'git pull ...') before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_use_upstream[] =
@@ -223,15 +223,15 @@ static const char message_advice_use_upstream[] =
 
 static const char message_advice_checkout_pull_push[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
-	   "counterpart. Check out this branch and merge the remote changes\n"
-	   "(e.g. 'git pull') before pushing again.\n"
+	   "counterpart. Check out this branch and integrate the remote changes\n"
+	   "(e.g. 'git pull ...') before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_ref_fetch_first[] =
 	N_("Updates were rejected because the remote contains work that you do\n"
 	   "not have locally. This is usually caused by another repository pushing\n"
-	   "to the same ref. You may want to first merge the remote changes (e.g.,\n"
-	   "'git pull') before pushing again.\n"
+	   "to the same ref. You may want to first integrate the remote changes\n"
+	   "(e.g., 'git pull ...') before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
 static const char message_advice_ref_already_exists[] =
-- 
1.8.3.2.855.gbc9faed

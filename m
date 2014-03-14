From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 1/3] wt-status: Make status messages more consistent with others
Date: Fri, 14 Mar 2014 00:37:50 -0400
Message-ID: <1394771872-25940-2-git-send-email-andrew.kw.w@gmail.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 05:39:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOJu9-0002wf-It
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 05:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbaCNEjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 00:39:11 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35771 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbaCNEjD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 00:39:03 -0400
Received: by mail-ie0-f173.google.com with SMTP id rl12so2069887iec.4
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 21:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3VXU10sbxOQC8MsKO0YaidHmo3ebMDpFQGhzLzmRLlI=;
        b=jwGl4ljlBZZsjrYCV372DFemFvUyH+kfnRXdgd1rGk//gKGNfIX5OeTMkXQARoFlWv
         5QF7OjGXcQOzCQX03+hFVFiHeGxa2SkPUJH+xiP0Xwe0GZ2IBJLWTMd166OUgMnVXduY
         R4MQvjLD2g/qP3U9cA58oIuRcXJ63/ak3zlVWRIOGxiXs0ETUvVElnCs4YrbvW0d+8no
         /GmQj8aZyhJWXdK+CKHK8MM6tSONylvkR0AncaNs2WWTS53cztFExhQrX03Vosumpwe2
         EaznCU9SuaCXTist31TLRHG0fYMsEBulS5DypAqCB9AMvKYwmQolt1LgkCJVPEjVdTwp
         /kqA==
X-Received: by 10.50.137.100 with SMTP id qh4mr5744304igb.4.1394771942174;
        Thu, 13 Mar 2014 21:39:02 -0700 (PDT)
Received: from dresden.sidefx.com (nat.sidefx.com. [38.104.156.10])
        by mx.google.com with ESMTPSA id ji9sm2293656igb.1.2014.03.13.21.39.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Mar 2014 21:39:01 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.175.gb69385f
In-Reply-To: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244076>

This is mainly changing messages that say:
    run "git foo --bar"
to
    use "git foo --bar" to baz

Although the commands and flags are usually self-explanatory, this is
more consistent with other status messages, and gives some sort of
explanation to the user.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 wt-status.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index a452407..9f2358a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -899,13 +899,13 @@ static void show_merge_in_progress(struct wt_status *s,
 		status_printf_ln(s, color, _("You have unmerged paths."));
 		if (s->hints)
 			status_printf_ln(s, color,
-				_("  (fix conflicts and run \"git commit\")"));
+				_("  (fix conflicts and use \"git commit\" to conclude the merge)"));
 	} else {
 		status_printf_ln(s, color,
 			_("All conflicts fixed but you are still merging."));
 		if (s->hints)
 			status_printf_ln(s, color,
-				_("  (use \"git commit\" to conclude merge)"));
+				_("  (use \"git commit\" to conclude the merge)"));
 	}
 	wt_status_print_trailer(s);
 }
@@ -922,7 +922,7 @@ static void show_am_in_progress(struct wt_status *s,
 	if (s->hints) {
 		if (!state->am_empty_patch)
 			status_printf_ln(s, color,
-				_("  (fix conflicts and then run \"git am --continue\")"));
+				_("  (fix conflicts and then use \"git am --continue\" to continue)"));
 		status_printf_ln(s, color,
 			_("  (use \"git am --skip\" to skip this patch)"));
 		status_printf_ln(s, color,
@@ -994,7 +994,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 					 _("You are currently rebasing."));
 		if (s->hints) {
 			status_printf_ln(s, color,
-				_("  (fix conflicts and then run \"git rebase --continue\")"));
+				_("  (fix conflicts and then use \"git rebase --continue\" to continue)"));
 			status_printf_ln(s, color,
 				_("  (use \"git rebase --skip\" to skip this patch)"));
 			status_printf_ln(s, color,
@@ -1011,7 +1011,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 					 _("You are currently rebasing."));
 		if (s->hints)
 			status_printf_ln(s, color,
-				_("  (all conflicts fixed: run \"git rebase --continue\")"));
+				_("  (all conflicts fixed: use \"git rebase --continue\" to continue)"));
 	} else if (split_commit_in_progress(s)) {
 		if (state->branch)
 			status_printf_ln(s, color,
@@ -1023,7 +1023,7 @@ static void show_rebase_in_progress(struct wt_status *s,
 					 _("You are currently splitting a commit during a rebase."));
 		if (s->hints)
 			status_printf_ln(s, color,
-				_("  (Once your working directory is clean, run \"git rebase --continue\")"));
+				_("  (Once your working directory is clean, use \"git rebase --continue\" to continue)"));
 	} else {
 		if (state->branch)
 			status_printf_ln(s, color,
@@ -1052,10 +1052,10 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
-				_("  (fix conflicts and run \"git cherry-pick --continue\")"));
+				_("  (fix conflicts and use \"git cherry-pick --continue\" to continue)"));
 		else
 			status_printf_ln(s, color,
-				_("  (all conflicts fixed: run \"git cherry-pick --continue\")"));
+				_("  (all conflicts fixed: use \"git cherry-pick --continue\" to continue)"));
 		status_printf_ln(s, color,
 			_("  (use \"git cherry-pick --abort\" to cancel the cherry-pick operation)"));
 	}
@@ -1071,10 +1071,10 @@ static void show_revert_in_progress(struct wt_status *s,
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
-				_("  (fix conflicts and run \"git revert --continue\")"));
+				_("  (fix conflicts and use \"git revert --continue\" to continue)"));
 		else
 			status_printf_ln(s, color,
-				_("  (all conflicts fixed: run \"git revert --continue\")"));
+				_("  (all conflicts fixed: use \"git revert --continue\" to continue)"));
 		status_printf_ln(s, color,
 			_("  (use \"git revert --abort\" to cancel the revert operation)"));
 	}
-- 
1.9.0.174.g6f75b8f

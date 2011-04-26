From: Henrik Hautakoski <henrik@fiktivkod.org>
Subject: [PATCH v2] wt-status.c: Increase code readability.
Date: Tue, 26 Apr 2011 13:26:38 +0200
Message-ID: <1303817198-23347-1-git-send-email-henrik@fiktivkod.org>
Cc: Henrik Hautakoski <henrik@fiktivkod.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 13:27:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEgQf-0000PQ-L8
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 13:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab1DZL1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 07:27:36 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57230 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab1DZL1f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 07:27:35 -0400
Received: by eyx24 with SMTP id 24so150849eyx.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 04:27:34 -0700 (PDT)
Received: by 10.213.15.141 with SMTP id k13mr1726011eba.144.1303817252205;
        Tue, 26 Apr 2011 04:27:32 -0700 (PDT)
Received: from localhost.localdomain (h-76-221.A259.priv.bahnhof.se [94.254.76.221])
        by mx.google.com with ESMTPS id k57sm2964700eei.10.2011.04.26.04.27.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 04:27:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172085>

Some if/else statements has braces on only some branches. Be consistent and make
all branches have braces.

Signed-off-by: Henrik Hautakoski <henrik@fiktivkod.org>
---
 wt-status.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 9f4e0ba..722987b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -448,9 +448,9 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 		if (ce_stage(ce)) {
 			d->index_status = DIFF_STATUS_UNMERGED;
 			d->stagemask |= (1 << (ce_stage(ce) - 1));
-		}
-		else
+		} else {
 			d->index_status = DIFF_STATUS_ADDED;
+		}
 	}
 	free_pathspec(&pathspec);
 }
@@ -745,35 +745,37 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_other(s, &s->untracked, _("Untracked"), "add");
 		if (s->show_ignored_files)
 			wt_status_print_other(s, &s->ignored, _("Ignored"), "add -f");
-	} else if (s->commitable)
+	} else if (s->commitable) {
 		status_printf_ln(s, GIT_COLOR_NORMAL, _("Untracked files not listed%s"),
 			advice_status_hints
 			? _(" (use -u option to show untracked files)") : "");
+	}
 
 	if (s->verbose)
 		wt_status_print_verbose(s);
 	if (!s->commitable) {
-		if (s->amend)
+		if (s->amend) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, _("No changes"));
-		else if (s->nowarn)
+		} else if (s->nowarn) {
 			; /* nothing */
-		else if (s->workdir_dirty)
+		} else if (s->workdir_dirty) {
 			printf(_("no changes added to commit%s\n"),
 				advice_status_hints
 				? _(" (use \"git add\" and/or \"git commit -a\")") : "");
-		else if (s->untracked.nr)
+		} else if (s->untracked.nr) {
 			printf(_("nothing added to commit but untracked files present%s\n"),
 				advice_status_hints
 				? _(" (use \"git add\" to track)") : "");
-		else if (s->is_initial)
+		} else if (s->is_initial) {
 			printf(_("nothing to commit%s\n"), advice_status_hints
 				? _(" (create/copy files and use \"git add\" to track)") : "");
-		else if (!s->show_untracked_files)
+		} else if (!s->show_untracked_files) {
 			printf(_("nothing to commit%s\n"), advice_status_hints
 				? _(" (use -u to show untracked files)") : "");
-		else
+		} else {
 			printf(_("nothing to commit%s\n"), advice_status_hints
 				? _(" (working directory clean)") : "");
+		}
 	}
 }
 
@@ -878,9 +880,9 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		return;
 	branch_name = s->branch;
 
-	if (!prefixcmp(branch_name, "refs/heads/"))
+	if (!prefixcmp(branch_name, "refs/heads/")) {
 		branch_name += 11;
-	else if (!strcmp(branch_name, "HEAD")) {
+	} else if (!strcmp(branch_name, "HEAD")) {
 		branch_name = _("HEAD (no branch)");
 		branch_color_local = color(WT_STATUS_NOBRANCH, s);
 	}
-- 
1.7.3.4

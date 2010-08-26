From: prouleau72@gmail.com
Subject: [PATCH] Colorize the branch's name in the status' output
Date: Wed, 25 Aug 2010 20:09:09 -0400
Message-ID: <1282781349-1899-1-git-send-email-prouleau72@gmail.com>
Content-Transfer-Encoding: 7BIT
Cc: Patryck Rouleau <PRouleau72@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 02:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoQ32-0002tc-Tj
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 02:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab0HZAKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 20:10:16 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24547 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab0HZAKP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 20:10:15 -0400
Received: from localhost.localdomain ([173.176.80.243])
 by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L7Q00JVHGGW67K0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Aug 2010 20:10:08 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154498>

From: Patryck Rouleau <PRouleau72@gmail.com>

When we are not on a branch, the message "Not currently on any branch." is
show in red. This patch makes the branch's name more visible by showing it
in green (the color of local branch).
---
 wt-status.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 54b6b03..5497ef3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -629,7 +629,7 @@ static void wt_status_print_tracking(struct wt_status *s)
 
 void wt_status_print(struct wt_status *s)
 {
-	const char *branch_color = color(WT_STATUS_HEADER, s);
+	const char *status_color = color(WT_STATUS_HEADER, s);
 
 	if (s->branch) {
 		const char *on_what = "On branch ";
@@ -638,11 +638,12 @@ void wt_status_print(struct wt_status *s)
 			branch_name += 11;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_name = "";
-			branch_color = color(WT_STATUS_NOBRANCH, s);
+			status_color = color(WT_STATUS_NOBRANCH, s);
 			on_what = "Not currently on any branch.";
 		}
 		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "# ");
-		color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
+		color_fprintf(s->fp, status_color, "%s", on_what);
+		color_fprintf_ln(s->fp, color(WT_STATUS_LOCAL_BRANCH, s), "%s", branch_name);
 		if (!s->is_initial)
 			wt_status_print_tracking(s);
 	}
-- 
1.7.1

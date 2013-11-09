From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 47/86] builtin/branch: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:40 +0100
Message-ID: <20131109070720.18178.39137.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:10:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2gP-00044O-F9
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933329Ab3KIHJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:09:59 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:36394 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933282Ab3KIHIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:40 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 6BC03A3;
	Sat,  9 Nov 2013 08:08:39 +0100 (CET)
X-git-sha1: 2b8cab1f828f4bc41333d88edf62a2623c2aa2f3 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237509>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ad0f86d..c4cb81c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -81,13 +81,13 @@ static int parse_branch_color_slot(const char *var, int ofs)
 
 static int git_branch_config(const char *var, const char *value, void *cb)
 {
-	if (!prefixcmp(var, "column."))
+	if (has_prefix(var, "column."))
 		return git_column_config(var, value, "branch", &colopts);
 	if (!strcmp(var, "color.branch")) {
 		branch_use_color = git_config_colorbool(var, value);
 		return 0;
 	}
-	if (!prefixcmp(var, "color.branch.")) {
+	if (has_prefix(var, "color.branch.")) {
 		int slot = parse_branch_color_slot(var, 13);
 		if (slot < 0)
 			return 0;
@@ -862,7 +862,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (!strcmp(head, "HEAD")) {
 		detached = 1;
 	} else {
-		if (prefixcmp(head, "refs/heads/"))
+		if (!has_prefix(head, "refs/heads/"))
 			die(_("HEAD not found below refs/heads!"));
 		head += 11;
 	}
-- 
1.8.4.1.566.geca833c

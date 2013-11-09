From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 60/86] builtin/help: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:53 +0100
Message-ID: <20131109070720.18178.6476.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:16:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2mI-0002Wp-MH
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758658Ab3KIHQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:16:13 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:37675 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758638Ab3KIHOP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:14:15 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id E2E0953;
	Sat,  9 Nov 2013 08:14:13 +0100 (CET)
X-git-sha1: fe08de42ddaabc9b44b7db1aa6338770fbe5d68d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237569>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/help.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index f1e236b..2478e9a 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -100,7 +100,7 @@ static int check_emacsclient_version(void)
 	 */
 	finish_command(&ec_process);
 
-	if (prefixcmp(buffer.buf, "emacsclient")) {
+	if (!has_prefix(buffer.buf, "emacsclient")) {
 		strbuf_release(&buffer);
 		return error(_("Failed to parse emacsclient version."));
 	}
@@ -258,7 +258,7 @@ static int add_man_viewer_info(const char *var, const char *value)
 
 static int git_help_config(const char *var, const char *value, void *cb)
 {
-	if (!prefixcmp(var, "column."))
+	if (has_prefix(var, "column."))
 		return git_column_config(var, value, "help", &colopts);
 	if (!strcmp(var, "help.format")) {
 		if (!value)
@@ -278,7 +278,7 @@ static int git_help_config(const char *var, const char *value, void *cb)
 		add_man_viewer(value);
 		return 0;
 	}
-	if (!prefixcmp(var, "man."))
+	if (has_prefix(var, "man."))
 		return add_man_viewer_info(var, value);
 
 	return git_default_config(var, value, cb);
@@ -306,7 +306,7 @@ static const char *cmd_to_page(const char *git_cmd)
 {
 	if (!git_cmd)
 		return "git";
-	else if (!prefixcmp(git_cmd, "git"))
+	else if (has_prefix(git_cmd, "git"))
 		return git_cmd;
 	else if (is_git_command(git_cmd))
 		return prepend("git-", git_cmd);
-- 
1.8.4.1.566.geca833c

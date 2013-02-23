From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH 04/13] Help.c add --guide option
Date: Sat, 23 Feb 2013 23:05:52 +0000
Message-ID: <1361660761-1932-5-git-send-email-philipoakley@iee.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:06:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9OAY-0002d7-Q7
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 00:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759363Ab3BWXFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 18:05:40 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:58408 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758808Ab3BWXFf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2013 18:05:35 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAJhKKVFZ8rke/2dsb2JhbABFwVGBCBdzgiABBVYzCEk5HgYTiBe+fo8Vg0ADpyKDBw
X-IronPort-AV: E=Sophos;i="4.84,724,1355097600"; 
   d="scan'208";a="420142111"
Received: from host-89-242-185-30.as13285.net (HELO localhost) ([89.242.185.30])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 23 Feb 2013 23:05:33 +0000
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216927>

Logic, but no actions, included.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 builtin/help.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index d10cbed..699e679 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -36,10 +36,12 @@ enum help_format {
 static const char *html_path;
 
 static int show_all = 0;
+static int show_guides = 0;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static struct option builtin_help_options[] = {
 	OPT_COUNTUP('a', "all", &show_all, N_("print all available commands")),
+	OPT_COUNTUP('g', "guides", &show_guides, N_("print all available guides")),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
@@ -49,7 +51,7 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	N_("git help [--all] [--man|--web|--info] [command]"),
+	N_("git help [--all] [--guides] [--man|--web|--info] [command]"),
 	NULL
 };
 
@@ -429,9 +431,11 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_commands(colopts, &main_cmds, &other_cmds);
 		printf("%s\n", _(git_more_info_string));
+		if (!show_guides) return 0;
+	}
+	if (show_guides) {
 		return 0;
 	}
-
 	if (!argv[0]) {
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_common_cmds_help();
-- 
1.8.1.msysgit.1

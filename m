From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH V3 3/5] Help.c add --guide option
Date: Tue,  2 Apr 2013 23:39:50 +0100
Message-ID: <1364942392-576-4-git-send-email-philipoakley@iee.org>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 00:40:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN9sC-0002tS-NL
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 00:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933744Ab3DBWjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 18:39:44 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:56359 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933636Ab3DBWjm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 18:39:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmwJALVdW1FOl3a6/2dsb2JhbABDgweCbb1XBAGBBBd0giABBVYjEAhJOR4GE4gYsWuQE418gR0Hg0ADp3aDDDs
X-IronPort-AV: E=Sophos;i="4.87,396,1363132800"; 
   d="scan'208";a="414347083"
Received: from host-78-151-118-186.as13285.net (HELO localhost) ([78.151.118.186])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 02 Apr 2013 23:39:40 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1364942392-576-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219895>

Logic, but no actions, included.

The --all commands option, if given, will display first.
The --guide option's list will then be displayed.

The common commands list is only displayed if neither option,
nor a command or guide name, is given.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 builtin/help.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 8969d3b..03d432b 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -36,10 +36,12 @@ enum help_format {
 static const char *html_path;
 
 static int show_all = 0;
+static int show_guides = 0;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static struct option builtin_help_options[] = {
 	OPT_BOOL('a', "all", &show_all, N_("print all available commands")),
+	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
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
 
@@ -430,7 +432,11 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		list_commands(colopts, &main_cmds, &other_cmds);
 	}
 
-	if (show_all) {
+	if (show_guides) {
+		/* do action - next patch */
+	}
+
+	if (show_all || show_guides) {
 		printf("%s\n", _(git_more_info_string));
 		/*
 		* We're done. Ignore any remaining args
-- 
1.8.1.msysgit.1

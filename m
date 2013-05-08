From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 10/10] git-clean: change clean flags in interactive mode
Date: Wed,  8 May 2013 19:38:55 +0800
Message-ID: <24a8a0f11acdf881b4ab9057e91273b9de306016.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
 <ad26375dece854339d64dcb82c17f19f8edccf48.1368011946.git.worldhello.net@gmail.com>
 <6a7931a0bb14f8c71479e16175812bedb6b826cb.1368011946.git.worldhello.net@gmail.com>
 <d7302adabb4269dd94698090fb20c739f723f00a.1368011946.git.worldhello.net@gmail.com>
 <e7cf5d7ffd83e238078b4585ac4bef4ec9a48e21.1368011946.git.worldhello.net@gmail.com>
 <ae69a75fa1bbad9827ef3891a33c3bfa6685d914.1368011946.git.worldhello.net@gmail.com>
 <95c019e293fcea899e5e227c35338f696f99525f.1368011946.git.worldhello.net@gmail.com>
 <187bf672e3795601f929f15b102746e5083471c5.1368011946.git.worldhello.net@gmail.com>
 <e9af9f5886217f99dedbb7e830bcebece892c891.1368011946.git.worldhello.net@gmail.com>
 <ebfb3ccf679c26734af655878cf84fff170c96c5.1368011946.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 08 13:39:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua2iz-0001aU-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab3EHLjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:39:45 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35640 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab3EHLjo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 07:39:44 -0400
Received: by mail-pd0-f174.google.com with SMTP id u10so1179219pdi.33
        for <git@vger.kernel.org>; Wed, 08 May 2013 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=BNQwZevoxaPVK5XJgkmcfDISmetBn/i/D98PtPh3b6E=;
        b=u9oCc8J2GfRpCskT5tzeNqp9AX7TIsMQOd75Ebq30g4lkloKb+A02cn/qz2Bmwbxhh
         Z8DqchbegVJmEkHnxA7rQ2/qVGvfIx+ciYhLyW834rTJ0u3z917N4Khy38jx3JHlEFDk
         UcJ1P3YG7dS3RX1URlBxUBmjvmEmjXHzu6/yDrewGRvpNmJmXdsL/nIwwJ5QSiYmOji1
         qLrlmi3pt4LehfdRYhS5F/JBEqc1E3KVWxWXcvFZBoUdDW/GmHVhu3QjpysNYnHrVmKI
         Hhcd2N+RUQcEf4hj1AjfXiVlr2nCQV+/aaS4u6kOEdqoE8So7cejWpHlyu5IA1lGchsm
         /Ysg==
X-Received: by 10.68.252.227 with SMTP id zv3mr7265743pbc.14.1368013183932;
        Wed, 08 May 2013 04:39:43 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id gc5sm32287860pbb.19.2013.05.08.04.39.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 04:39:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g1c24ab7
In-Reply-To: <ebfb3ccf679c26734af655878cf84fff170c96c5.1368011946.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368011946.git.worldhello.net@gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223667>

Add new action in the interactive mode, so that the user can change
git-clean flags, such as -x/-X/-d/-ff, and refresh the cleaning
candidates list.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Documentation/git-clean.txt |  11 +++--
 builtin/clean.c             | 117 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 108 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 47e8e..c7885 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -82,14 +82,14 @@ and type return, like this:
 
 ------------
     *** Commands ***
-      1: clean             2: edit by patterns   3: edit by numbers
-      4. rm -i             5. quit               6. help
+      1: clean               2: edit by patterns    3: edit by numbers     4: rm -i
+      5: flags: none         6: quit                7: help
     What now> 2
 ------------
 
 You also could say `c` or `clean` above as long as the choice is unique.
 
-The main command loop has 6 subcommands.
+The main command loop has 7 subcommands.
 
 clean::
 
@@ -122,6 +122,11 @@ rm -i::
   by one in order to delete items. This action is not as efficient
   as the above two actions.
 
+flags::
+
+  This lets you change the flags for git-clean, such as -x/-X/-d/-ff,
+  and refresh the cleaning candidates list automatically.
+
 quit::
 
   This lets you quit without do cleaning.
diff --git a/builtin/clean.c b/builtin/clean.c
index 0d8561..b2941 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -850,6 +850,66 @@ static int rm_i_cmd()
 	return MENU_RETURN_NO_LOOP;
 }
 
+static int flags_cmd()
+{
+	struct menu_opts menu_opts;
+	struct menu_stuff menu_stuff;
+	struct menu_item menus[] = {
+		{'d', "(-d) remove directories",
+			clean_flags & CLEAN_OPTS_REMOVE_DIRECTORIES,	NULL},
+		{'x', "(-x) show ignored",
+			clean_flags & CLEAN_OPTS_SHOW_IGNORED,		NULL},
+		{'X', "(-X) ignored only",
+			clean_flags & CLEAN_OPTS_IGNORED_ONLY,		NULL},
+		{'f', "(-ff) remove nested.git",
+			clean_flags & CLEAN_OPTS_REMOVE_NESTED_GIT,	NULL},
+	};
+	int new_flags = 0;
+	int *chosen;
+	int i;
+
+	menu_opts.header = NULL;
+	menu_opts.prompt = "Change flags";
+	menu_opts.flag = 0;
+
+	menu_stuff.type = MENU_STUFF_TYPE_MENU_ITEM;
+	menu_stuff.stuff = menus;
+	menu_stuff.nr = sizeof(menus) / sizeof(struct menu_item);
+
+	chosen = list_and_choose(&menu_opts, &menu_stuff);
+
+	for (i = 0; chosen[i] != EOF; i++) {
+		switch (chosen[i]) {
+		case 0:
+			new_flags |= CLEAN_OPTS_REMOVE_DIRECTORIES;
+			break;
+		case 1:
+			new_flags |= CLEAN_OPTS_SHOW_IGNORED;
+			break;
+		case 2:
+			new_flags |= CLEAN_OPTS_IGNORED_ONLY;
+			break;
+		case 3:
+			new_flags |= CLEAN_OPTS_REMOVE_NESTED_GIT;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (new_flags & CLEAN_OPTS_IGNORED_ONLY &&
+	    new_flags & CLEAN_OPTS_SHOW_IGNORED) {
+		clean_print_color(CLEAN_COLOR_ERROR);
+		printf_ln(_("-x and -X cannot be used together"));
+		clean_print_color(CLEAN_COLOR_RESET);
+	} else {
+		clean_flags = new_flags;
+	}
+
+	free(chosen);
+	return 0;
+}
+
 static int quit_cmd()
 {
 	string_list_clear(&del_list, 0);
@@ -865,6 +925,7 @@ static int help_cmd(int x)
 		    "edit by patterns - exclude items from deletion\n"
 		    "edit by numbers  - select items to be deleted by numbers\n"
 		    "rm -i            - delete items one by one, like \"rm -i\"\n"
+		    "flags            - change git-clean flags and update the cleaning candidates\n"
 		    "quit             - stop cleaning\n"
 		    "help             - this screen\n"
 		    "?                - help for prompt selection"
@@ -873,10 +934,13 @@ static int help_cmd(int x)
 	return 0;
 }
 
-static void interactive_main_loop()
+static void interactive_main_loop(const char **pathspec, struct string_list exclude_list)
 {
+	int cached_clean_flags = clean_flags;
+	char flags_title[20];
+
 	/* dels list may become empty after return back from edit mode */
-	while (del_list.nr) {
+	while (1) {
 		struct menu_opts menu_opts;
 		struct menu_stuff menu_stuff;
 		struct menu_item menus[] = {
@@ -884,11 +948,24 @@ static void interactive_main_loop()
 			{'p', "edit by patterns",	0, edit_by_patterns_cmd},
 			{'n', "edit by numbers",	0, edit_by_numbers_cmd},
 			{'i', "rm -i",			0, rm_i_cmd},
+			{'f', flags_title,		0, flags_cmd},
 			{'q', "quit",			0, quit_cmd},
 			{'h', "help",			0, help_cmd},
 		};
 		int *chosen;
 
+		if (!clean_flags) {
+			strncpy(flags_title, "flags: none", sizeof(flags_title)/sizeof(char));
+		} else {
+			snprintf(flags_title, sizeof(flags_title)/sizeof(char),
+				 "flags: -%s%s%s%s",
+				 clean_flags & CLEAN_OPTS_REMOVE_DIRECTORIES ? "d" : "",
+				 clean_flags & CLEAN_OPTS_SHOW_IGNORED ? "x" : "",
+				 clean_flags & CLEAN_OPTS_IGNORED_ONLY ? "X" : "",
+				 clean_flags & CLEAN_OPTS_REMOVE_NESTED_GIT ? "ff" : ""
+				);
+		}
+
 		menu_opts.header = _("*** Commands ***");
 		menu_opts.prompt = "What now";
 		menu_opts.flag = MENU_OPTS_SINGLETON;
@@ -897,14 +974,26 @@ static void interactive_main_loop()
 		menu_stuff.stuff = menus;
 		menu_stuff.nr = sizeof(menus) / sizeof(struct menu_item);
 
-		clean_print_color(CLEAN_COLOR_HEADER);
-		printf_ln(Q_("Would remove the following item:",
-			     "Would remove the following items:",
-			     del_list.nr));
-		clean_print_color(CLEAN_COLOR_RESET);
+		if (cached_clean_flags != clean_flags) {
+			scan_clean_candidates(pathspec, exclude_list);
+			cached_clean_flags = clean_flags;
+		}
 
-		/* display dels in columns */
-		pretty_print_dels();
+		if (del_list.nr) {
+			clean_print_color(CLEAN_COLOR_HEADER);
+			printf_ln(Q_("Would remove the following item:",
+				     "Would remove the following items:",
+				     del_list.nr));
+			clean_print_color(CLEAN_COLOR_RESET);
+
+			/* display dels in columns */
+			pretty_print_dels();
+		} else {
+			clean_print_color(CLEAN_COLOR_HEADER);
+			printf_ln(_("NOTE: No more files to clean. Press \"f\" can change the flags."));
+			putchar('\n');
+			clean_print_color(CLEAN_COLOR_RESET);
+		}
 
 		/* main menu */
 		chosen = list_and_choose(&menu_opts, &menu_stuff);
@@ -915,12 +1004,6 @@ static void interactive_main_loop()
 			if (ret != MENU_RETURN_NO_LOOP) {
 				free(chosen);
 				chosen = NULL;
-				if (!del_list.nr) {
-					clean_print_color(CLEAN_COLOR_ERROR);
-					printf_ln(_("No more files to clean, exiting."));
-					clean_print_color(CLEAN_COLOR_RESET);
-					break;
-				}
 				continue;
 			}
 		} else {
@@ -999,8 +1082,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 
 	scan_clean_candidates(pathspec, exclude_list);
 
-	if (interactive && !dry_run && del_list.nr > 0)
-		interactive_main_loop();
+	if (interactive && !dry_run)
+		interactive_main_loop(pathspec, exclude_list);
 
 	for_each_string_list_item(item, &del_list) {
 		struct stat st;
-- 
1.8.3.rc1.341.g1c24ab7

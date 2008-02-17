From: "Santi Bejar" <sbejar@gmail.com>
Subject: [PATCH] git help: sort commands by topi
Date: Sun, 17 Feb 2008 15:48:21 +0100
Message-ID: <87hcg77i6i.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 15:49:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQkps-0004j8-2F
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 15:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127AbYBQOtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 09:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755933AbYBQOtH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 09:49:07 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:60493 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756070AbYBQOtG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 09:49:06 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1152857fga.17
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 06:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:message-id:user-agent:mime-version:content-type;
        bh=x60gHQOgpIS8WbYWr9Y6a9FCQBkj0Eat3lboxFm9AFU=;
        b=ppPVJKY1bMeVdTmRA/dZTCZ3dTeysuBkfyx/0oB59mRyP1LOJWQTToE5nILszC+hrPj8P98djlipmEt1/4n3ApU7/ggJmfwdYWHTMpVlfl5e13VZMpdG449MWZxzm626aY1F5ZB4d85d8XgeZrmHouPGpjNmocsX0ahzr5zUDXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:user-agent:mime-version:content-type;
        b=l/AJKvgXJFJChPCiZR1/60Vt5K0jUsN6MzoncqrknGNfdSOQ/JYczuIG8KxT83Fn/sK1iNoFJyjE56WIBVWOtySrdDQW1NqGCbgbSZNP4r5WprLSc5DZ//+eGQ3VXCTRxBciyRATl+zqgmBUZRL0AOTNS5IszcUZASSrwRpvV1o=
Received: by 10.86.70.8 with SMTP id s8mr4877337fga.29.1203259719659;
        Sun, 17 Feb 2008 06:48:39 -0800 (PST)
Received: from bela ( [91.13.66.117])
        by mx.google.com with ESMTPS id 3sm8918992fge.7.2008.02.17.06.48.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Feb 2008 06:48:38 -0800 (PST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74134>

--=-=-=

Hi *,

 here is a patch that I've sent a lot of times to the list and it has not
arrived, I suppose because the spam filtering, but I've look the filter
applied and I do not find anything. I've also compared this with other
mails I've sent and I don't see anything relevant. I'm sending the
the patch as an attachment.

Santi

P.D: Does anyone know how can I know the reason for the drops?


--=-=-=
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
 filename=0001-git-help-t-topic-lists-all-the-commands-classifi.patch
Content-Transfer-Encoding: 8bit

>From 3379f6e84035748fc9d1a14fbfcbc31b20a3582c Mon Sep 17 00:00:00 2001
From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Date: Sun, 27 Jan 2008 01:34:57 +0100
Subject: [PATCH] git help -t|--topic: lists all the commands classified by topic
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Additionally shows a hint to get the long list when listing the common commands.

Signed-off-by: Santi Béjar <sbejar@gmail.com>
---
 Documentation/git-help.txt |    8 +++++-
 Makefile                   |    2 +-
 generate-cmdlist.sh        |   28 ++++++++++++++++++------
 help.c                     |   51 ++++++++++++++++++++++++++++++++++++-------
 topic-list.txt             |   12 ++++++++++
 5 files changed, 82 insertions(+), 19 deletions(-)
 create mode 100644 topic-list.txt

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 0926dc1..26998c5 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -7,7 +7,7 @@ git-help - display help information about git
 
 SYNOPSIS
 --------
-'git help' [-a|--all|-i|--info|-m|--man|-w|--web] [COMMAND]
+'git help' [-a|--all|-i|--info|-m|--man|-t|--topic|-w|--web] [COMMAND]
 
 DESCRIPTION
 -----------
@@ -17,7 +17,8 @@ command and a list of the most commonly used git commands are printed
 on the standard output.
 
 If the option '--all' or '-a' is given, then all available commands are
-printed on the standard output.
+printed on the standard output. For a list of all git commands classified by
+topic use '--topic' of '-t'.
 
 If a git command is named, a manual page for that command is brought
 up. The 'man' program is used by default for this purpose, but this
@@ -41,6 +42,9 @@ OPTIONS
 	used to override a value set in the 'help.format'
 	configuration variable.
 
+-t|--topic::
+	Prints all the commands classified by topic.
+
 -w|--web::
 	Use a web browser to display the HTML manual page, instead of
 	the 'man' program that is used by default.
diff --git a/Makefile b/Makefile
index 83c359a..64ca31a 100644
--- a/Makefile
+++ b/Makefile
@@ -837,7 +837,7 @@ git-merge-subtree$X: git-merge-recursive$X
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && ln git$X $@
 
-common-cmds.h: ./generate-cmdlist.sh command-list.txt
+common-cmds.h: ./generate-cmdlist.sh command-list.txt topic-list.txt
 
 common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index a2913c2..ec623dd 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -3,22 +3,36 @@
 echo "/* Automatically generated by $0 */
 struct cmdname_help
 {
-    char name[16];
+    char name[23];
     char help[80];
+    char topic[22];
+    char subtopic[10];
 };
 
-static struct cmdname_help common_cmds[] = {"
+struct topicname_help
+{
+    char name[23];
+    char subtopic[10];
+    char help[80];
+};
 
-sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
-sort |
-while read cmd
+static struct cmdname_help cmd_list[] = {"
+
+sed -n -e 's/^git-\([^ 	]*\)\(.*\)$/\1\2/p' command-list.txt |
+grep -v deprecated | sort |
+while read cmd topic subtopic
 do
      sed -n '
-     /NAME/,/git-'"$cmd"'/H
+     /^NAME$/,/git-'"$cmd"'/H
      ${
             x
-            s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
+            s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1",/
 	    p
      }' "Documentation/git-$cmd.txt"
+     echo  "\"$topic\", \"$subtopic\" },"
 done
 echo "};"
+
+echo "static struct topicname_help topic_list[] = {"
+sed -n -e 's/^topic-\([^ ]*\)	\(common\|\)	\(.*\)$/{\"\1\", \"\2\", \"\3\"},/p' topic-list.txt
+echo "};"
diff --git a/help.c b/help.c
index 6e28ad9..0e3a350 100644
--- a/help.c
+++ b/help.c
@@ -262,20 +262,48 @@ static void list_commands(void)
 	}
 }
 
-void list_common_cmds_help(void)
+void list_topic_cmds_help(const char *topic, const char *subtopic)
 {
 	int i, longest = 0;
 
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		if (longest < strlen(common_cmds[i].name))
-			longest = strlen(common_cmds[i].name);
+	for (i = 0; i < ARRAY_SIZE(topic_list); i++) {
+		if (!strcmp(topic_list[i].name, topic) &&
+		    !strcmp(topic_list[i].subtopic, subtopic)) {
+			printf("%s:\n",topic_list[i].help);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cmd_list); i++) {
+		if (strcmp(cmd_list[i].topic, topic)) continue;
+		if (!strcmp(topic_list[i].subtopic,"") &&
+		    strcmp(cmd_list[i].subtopic, subtopic)) continue;
+		if (longest < strlen(cmd_list[i].name))
+			longest = strlen(cmd_list[i].name);
 	}
 
-	puts("The most commonly used git commands are:");
-	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %s   ", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(common_cmds[i].help);
+	for (i = 0; i < ARRAY_SIZE(cmd_list); i++) {
+		if (strcmp(cmd_list[i].topic, topic)) continue;
+		if (!strcmp(topic_list[i].subtopic,"") &&
+		    strcmp(cmd_list[i].subtopic, subtopic)) continue;
+			printf("   %s   ", cmd_list[i].name);
+			mput_char(' ', longest - strlen(cmd_list[i].name));
+			puts(cmd_list[i].help);
+	}
+	putchar('\n');
+}
+
+void list_common_cmds_help(void)
+{
+	list_topic_cmds_help("mainporcelain","common");
+	puts("(use 'git help -t' to get a longer list)");
+}
+
+void list_topics_help()
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(topic_list); i++) {
+		if(strcmp(topic_list[i].subtopic,"")) continue;
+		list_topic_cmds_help(topic_list[i].name,"");
 	}
 }
 
@@ -391,6 +419,11 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		show_man_page(argc > 2 ? argv[2] : NULL);
 	}
 
+	else if (!strcmp(help_cmd, "--topic") || !strcmp(help_cmd, "-t")) {
+		setup_pager();
+		list_topics_help();
+	}
+
 	else {
 		int nongit;
 
diff --git a/topic-list.txt b/topic-list.txt
new file mode 100644
index 0000000..2ba11a9
--- /dev/null
+++ b/topic-list.txt
@@ -0,0 +1,12 @@
+# List of known git topics.
+# topic name				help
+common                                  The most commonly used commands
+mainporcelain                           Main porcelain commands
+ancillarymanipulators			Interrogators commands
+ancillaryinterrogators			Manipulators commands
+foreignscminterface 			Commands dealing with foreing SCM
+plumbingmanipulators			Low-level manipulation commands
+plumbinginterrogators			Low-level Interrogation commands
+synchingrepositories			Synching repositories
+synchelpers				Synching helper commands
+purehelpers				Internal helper commands
-- 
1.5.4.1219.g65b9


--=-=-=--

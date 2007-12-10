From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: git help -t <topic>: list the help of the commands in a given topic
Date: Mon, 10 Dec 2007 16:03:41 +0100
Message-ID: <1197299021-28463-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 15:57:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1k4D-0000wc-Bb
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 15:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbXLJO43 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Dec 2007 09:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbXLJO43
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 09:56:29 -0500
Received: from mail.mppmu.mpg.de ([134.107.24.11]:33581 "EHLO
	mail.mppmu.mpg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbXLJO41 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 09:56:27 -0500
Received: by mail.mppmu.mpg.de (Postfix, from userid 998)
	id BCC4F1204F; Mon, 10 Dec 2007 15:56:25 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on mail.mppmu.mpg.de
X-Spam-Status: No, score=-4.4 required=6.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.1.7
X-Spam-Level: 
Received: from localhost.localdomain (sn3dhcp15.mppmu.mpg.de [134.107.3.155])
	by mail.mppmu.mpg.de (Postfix) with ESMTP id 005BB1204B;
	Mon, 10 Dec 2007 15:56:14 +0100 (CET)
X-Mailer: git-send-email 1.5.3.7.2094.gff6c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67719>

With 'git help -t' lists the available topics.

Show a hint to get a longer list when listing the common commands.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 To apply on top of cc/help

 Documentation/git-help.txt |   41 +++++++++++++++++++++++++++++-
 command-list.txt           |   12 +++++++++
 generate-cmdlist.sh        |   37 ++++++++++++++++++++++-----
 help.c                     |   59 ++++++++++++++++++++++++++++++++++++=
+------
 4 files changed, 132 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index ac9e15d..bb010f0 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -7,7 +7,7 @@ git-help - display help information about git
=20
 SYNOPSIS
 --------
-'git help' [-a|--all|-i|--info|-w|--web] [COMMAND]
+'git help' [-a|--all|-i|--info|-w|--web|-t [topic]] [COMMAND]
=20
 DESCRIPTION
 -----------
@@ -16,6 +16,9 @@ With no options and no COMMAND given, the synopsis of=
 the 'git'
 command and a list of the most commonly used git commands are printed
 on the standard output.
=20
+If the option '-t <topic>' is given, then all the commands on a given
+topic are printed, and without a <topic> to get a list of topics.
+
 If the option '--all' or '-a' is given, then all available commands ar=
e
 printed on the standard output.
=20
@@ -54,6 +57,42 @@ is available in PATH.
 Note that the script tries, as much as possible, to display the HTML
 page in a new tab on an already opened browser.
=20
+-t <topic>::
+	Prints all the commands on a given topic, or all the topics.
+
+TOPICS
+------
+
+common::
+	The most commonly used commands.
+
+main::
+	The main commands.
+
+interrogators::
+	The interrogators commands.
+
+manipulators::
+	The manipulators commands.
+
+synching::
+	The commands to synchronize repositories.
+
+foreignscm::
+	The commands dealing with foreign SCM.
+
+plumbinginterrogators::
+	The low-level interrogators commands.
+
+plumbingmanipulators::
+	The low-level manipulators commands.
+
+purehelpers::
+	The helpers commands.
+
+synchelpers::
+	The helpers commands to synchronize repositories.
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com> and the git-list
diff --git a/command-list.txt b/command-list.txt
index 28342da..cbfb3d2 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -128,3 +128,15 @@ git-verify-pack                         plumbingin=
terrogators
 git-verify-tag                          ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators
 git-write-tree                          plumbingmanipulators
+# List of known git topics.
+# topic name				category [common]
+topic-common                            mainporcelain common
+topic-main                              mainporcelain
+topic-interrogators                     ancillaryinterrogators
+topic-manipulators                      ancillarymanipulators
+topic-synching                          synchingrepositories
+topic-foreignscm                        foreignscminterface
+topic-plumbinginterrogators             plumbinginterrogators
+topic-plumbingmanipulators              plumbingmanipulators
+topic-purehelpers                       purehelpers
+topic-synchelpers                       synchelpers
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index a2913c2..9371e9d 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -1,24 +1,47 @@
 #!/bin/sh
=20
 echo "/* Automatically generated by $0 */
+#define COMMON	(1<<1)
+
 struct cmdname_help
 {
-    char name[16];
+    char name[23];
     char help[80];
+    char category[22];
+    int option;
 };
=20
-static struct cmdname_help common_cmds[] =3D {"
+static struct cmdname_help cmd_list[] =3D {"
=20
-sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
-sort |
-while read cmd
+sed -n -e 's/^git-\([^ 	]*\)\(.*\)$/\1\2/p' command-list.txt |
+grep -v deprecated | sort |
+while read cmd topic flag
 do
+     flag=3D$(echo $flag | tr '[a-z]' '[A-Z]')
+     [ -z "$flag" ] && flag=3D"0"
      sed -n '
-     /NAME/,/git-'"$cmd"'/H
+     /^NAME$/,/git-'"$cmd"'/H
      ${
             x
-            s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
+            s/.*git-'"$cmd"' - \(.*\)/ {"'"$cmd"'", "\1",/
 	    p
      }' "Documentation/git-$cmd.txt"
+     echo  "\"$topic\", $flag },"
+done
+echo "};"
+
+echo "static struct cmdname_help topic_list[] =3D {"
+sed -n -e 's/^topic-\([^ 	]*\)\(.*\)$/\1\2/p' command-list.txt |
+while read topic category flag
+do
+     flag=3D$(echo $flag | tr '[a-z]' '[A-Z]')
+     [ -z "$flag" ] && flag=3D"0"
+     sed -n '
+     /^'$topic'::$/{
+		n
+		s/^[ 	]*\(.*\)./  {"'"$topic"'", "\1",/
+		p
+     }' "Documentation/git-help.txt"
+     echo  "\"$category\", $flag },"
 done
 echo "};"
diff --git a/help.c b/help.c
index c96b167..4249d2a 100644
--- a/help.c
+++ b/help.c
@@ -222,20 +222,54 @@ static void list_commands(void)
 	}
 }
=20
+void list_cmds_help(const char *topic)
+{
+	int i, longest =3D 0, option =3D 0;
+	const char *category =3D topic;
+
+	for (i =3D 0; i < ARRAY_SIZE(topic_list); i++) {
+		if (!strcmp(topic_list[i].name, topic)) {
+			category =3D topic_list[i].category;
+			option =3D topic_list[i].option;
+			printf("%s:\n",topic_list[i].help);
+		}
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(cmd_list); i++) {
+		if (strcmp(cmd_list[i].category, category)) continue;
+		if (longest < strlen(cmd_list[i].name))
+			longest =3D strlen(cmd_list[i].name);
+	}
+
+	for (i =3D 0; i < ARRAY_SIZE(cmd_list); i++) {
+		if (strcmp(cmd_list[i].category, category)) continue;
+		if ((option =3D=3D 0) || (cmd_list[i].option & option)){
+			printf("   %s   ", cmd_list[i].name);
+			mput_char(' ', longest - strlen(cmd_list[i].name));
+			puts(cmd_list[i].help);
+		}
+	}
+}
+
 void list_common_cmds_help(void)
 {
-	int i, longest =3D 0;
+	list_cmds_help("common");
+	puts("(use 'git help -t main' to get a longer list)");
+}
=20
-	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
-		if (longest < strlen(common_cmds[i].name))
-			longest =3D strlen(common_cmds[i].name);
+void list_topics_help()
+{
+	printf("The topics:\n");
+	int i, longest =3D 0;
+	for (i =3D 0; i < ARRAY_SIZE(topic_list); i++) {
+		if (longest < strlen(topic_list[i].name))
+			longest =3D strlen(topic_list[i].name);
 	}
=20
-	puts("The most commonly used git commands are:");
-	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %s   ", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(common_cmds[i].help);
+	for (i =3D 0; i < ARRAY_SIZE(topic_list); i++) {
+		printf("   %s   ", topic_list[i].name);
+		mput_char(' ', longest - strlen(topic_list[i].name));
+		puts(topic_list[i].help);
 	}
 }
=20
@@ -331,6 +365,13 @@ int cmd_help(int argc, const char **argv, const ch=
ar *prefix)
 		show_info_page(argc > 2 ? argv[2] : NULL);
 	}
=20
+	else if (!strcmp(help_cmd, "-t")) {
+		const char *topic =3D NULL;
+		topic =3D argc > 2 ? argv[2] : NULL;
+		if (!topic) list_topics_help();
+		else list_cmds_help(topic);
+	}
+
 	else
 		show_man_page(help_cmd);
=20
--=20
1.5.3.7.2094.gff6c

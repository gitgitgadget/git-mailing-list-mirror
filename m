From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] help --standard: list standard commands
Date: Sat, 19 Jan 2013 00:02:13 -0800
Message-ID: <7vk3r9ob22.fsf_-_@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <7v8v7qsagd.fsf@alter.siamese.dyndns.org>
 <7vmww6qmck.fsf@alter.siamese.dyndns.org>
 <201301182323.55378.avila.jn@gmail.com> <50FA316E.8060807@web.de>
 <7vwqv9obie.fsf_-_@alter.siamese.dyndns.org>
 <7vpq11ob4w.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	=?utf-8?Q?Jean?= =?utf-8?Q?-No=C3=ABl?= AVILA 
	<avila.jn@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 09:02:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwTNt-0004e8-Nb
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 09:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531Ab3ASICR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 03:02:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472Ab3ASICQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 03:02:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA62C97B3;
	Sat, 19 Jan 2013 03:02:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sDWyxLyYik7nj/N4x0bz9xQksls=; b=JDe3zb
	uZAbIO2ieMbe/mDN2UiqDYFdVroyg0ii7pyMcm9qFjtFmAdqUtyuotiYX+ySQUJ0
	KZdYoZH+jl5/wae1vsL99x4n8cdfjhaQsUXBHwJDmInkeSabREdfepBatcOAg8wr
	QMs7XBwnleg2lqkWLMzbexYkf7tj2FrqRs7HI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QQ51rgSvQWrCY9YsA2uLUAs21P9DiS7F
	/U1LHqsHkL3z4CewACGsXTsTRfkcSHpsRJG7hddDwRq3YbXAACG7E0UowLoWgIGl
	wkSj9f0DYBpyx/Jmj/QqfmV9P5Feh7VgA10Ck2t9YiNKzNBEolbyAPraGpwQyEJe
	6Kr6Hq76oKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A035B97B1;
	Sat, 19 Jan 2013 03:02:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A46B097A9; Sat, 19 Jan 2013
 03:02:14 -0500 (EST)
In-Reply-To: <7vpq11ob4w.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 19 Jan 2013 00:00:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89487C58-620E-11E2-A06B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213964>

If you run "make" on a branch that adds "git check-ignore", checkout
an older branch that did not know about the command without "make clean",
and the run t9902 test, the completion script fails to exclude the
"check-ignore" command from candidates to complete "check".

This is because the completion script asks "git help -a" to show
every executable that begins with "git-" in the GIT_EXEC_PATH, and
because we run tests with GIT_EXEC_PATH set to the top of the
working tree, that has the executable we just built, in order to
test these before installing.  Leftover "git check-ignore" that we
did not build for the current version gets in the way.

One way to solve this is to restrict the completion to only the
commands we know about.

Note that this will make the completion useless in real life for
some people, as they do want to get their custom commands on their
$PATH to be included in the completion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is not a real patch, for the reasons stated.

 builtin/help.c                         | 17 ++++++++++++++---
 command-list.txt                       |  4 ++--
 contrib/completion/git-completion.bash | 14 +-------------
 generate-cmdlist.sh                    | 13 ++++++++++++-
 help.c                                 | 30 ++++++++++++++++++++++++++++--
 help.h                                 |  1 +
 6 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 6067a61..32e7d64 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -35,11 +35,16 @@ enum help_format {
 
 static const char *html_path;
 
-static int show_all = 0;
+#define HELP_SHOW_ALL 1
+#define HELP_SHOW_STANDARD 2
+static int show_what;
 static unsigned int colopts;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static struct option builtin_help_options[] = {
-	OPT_BOOLEAN('a', "all", &show_all, N_("print all available commands")),
+	OPT_SET_INT('a', "all", &show_what, N_("print all available commands"),
+		HELP_SHOW_ALL),
+	OPT_SET_INT(0, "standard", &show_what, N_("print all available commands"),
+		HELP_SHOW_STANDARD),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
@@ -424,12 +429,18 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 			builtin_help_usage, 0);
 	parsed_help_format = help_format;
 
-	if (show_all) {
+	if (show_what == HELP_SHOW_ALL) {
 		git_config(git_help_config, NULL);
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_commands(colopts, &main_cmds, &other_cmds);
 		printf("%s\n", _(git_more_info_string));
 		return 0;
+	} else if (show_what == HELP_SHOW_STANDARD) {
+		int i;
+		limit_to_standard(&main_cmds);
+		for (i = 0; i < main_cmds.cnt; i++)
+			printf("%s\n", main_cmds.names[i]->name);
+		return 0;
 	}
 
 	if (!argv[0]) {
diff --git a/command-list.txt b/command-list.txt
index 7e8cfec..94ce8ec 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -116,8 +116,8 @@ git-show                                mainporcelain common
 git-show-branch                         ancillaryinterrogators
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
-git-sh-i18n                             purehelpers
-git-sh-setup                            purehelpers
+git-sh-i18n                             purehelpers nocomplete
+git-sh-setup                            purehelpers nocomplete
 git-stash                               mainporcelain
 git-status                              mainporcelain common
 git-stripspace                          purehelpers
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a4c48e1..46f22af 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -531,23 +531,11 @@ __git_complete_strategy ()
 	return 1
 }
 
-__git_list_all_commands ()
-{
-	local i IFS=" "$'\n'
-	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
-	do
-		case $i in
-		*--*)             : helper pattern;;
-		*) echo $i;;
-		esac
-	done
-}
-
 __git_all_commands=
 __git_compute_all_commands ()
 {
 	test -n "$__git_all_commands" ||
-	__git_all_commands=$(__git_list_all_commands)
+	__git_all_commands=$(git help --standard)
 }
 
 __git_list_porcelain_commands ()
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 9a4c9b9..7800af3 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -9,7 +9,7 @@ struct cmdname_help {
 static struct cmdname_help common_cmds[] = {"
 
 sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
-sort |
+LC_ALL=C LANG=C sort |
 while read cmd
 do
      sed -n '
@@ -20,4 +20,15 @@ do
 	    p
      }' "Documentation/git-$cmd.txt"
 done
+echo "};
+
+static const char *standard_cmd[] = {"
+
+LC_ALL=C LANG=C sort command-list.txt |
+sed -n -e '
+	/^git-[^ 	]*[ 	].* deprecated.*/d
+	/^git-[^ 	]*[ 	].* nocomplete.*/d
+	s/^git-\([^ 	]*\)[ 	].*/  "\1",/p
+'
+
 echo "};"
diff --git a/help.c b/help.c
index 1dfa0b0..2ad10db 100644
--- a/help.c
+++ b/help.c
@@ -182,7 +182,7 @@ void load_command_list(const char *prefix,
 		uniq(main_cmds);
 	}
 
-	if (env_path) {
+	if (env_path && other_cmds) {
 		char *paths, *path, *colon;
 		path = paths = xstrdup(env_path);
 		while (1) {
@@ -201,7 +201,33 @@ void load_command_list(const char *prefix,
 		      sizeof(*other_cmds->names), cmdname_compare);
 		uniq(other_cmds);
 	}
-	exclude_cmds(other_cmds, main_cmds);
+
+	if (other_cmds)
+		exclude_cmds(other_cmds, main_cmds);
+}
+
+void limit_to_standard(struct cmdnames *cmds)
+{
+	int src = 0, dst = 0, ref = 0;
+
+	while (src < cmds->cnt && ref < ARRAY_SIZE(standard_cmd)) {
+		int cmp = strcmp(cmds->names[src]->name, standard_cmd[ref]);
+		if (cmp < 0) {
+			src++; /* not a standard command */
+		} else if (!cmp) {
+			if (dst != src) {
+				free(cmds->names[dst]);
+				cmds->names[dst] = cmds->names[src];
+			}
+			ref++;
+			dst++;
+		} else {
+			ref++; /* uninstalled standard command */
+		}
+	}
+	for (src = dst; src < cmds->cnt; src++)
+		free(cmds->names[src]);
+	cmds->cnt = dst;
 }
 
 void list_commands(unsigned int colopts,
diff --git a/help.h b/help.h
index 0ae5a12..ce0d2a5 100644
--- a/help.h
+++ b/help.h
@@ -21,6 +21,7 @@ extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
 			      struct cmdnames *other_cmds);
+extern void limit_to_standard(struct cmdnames *);
 extern void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 /* Here we require that excludes is a sorted list. */
 extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
-- 
1.8.1.1.454.g48d39c0

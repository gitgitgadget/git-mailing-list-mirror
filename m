From: Junio C Hamano <gitster@pobox.com>
Subject: Re* t9902 fails
Date: Fri, 18 Jan 2013 23:52:25 -0800
Message-ID: <7vwqv9obie.fsf_-_@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <7v8v7qsagd.fsf@alter.siamese.dyndns.org>
 <7vmww6qmck.fsf@alter.siamese.dyndns.org>
 <201301182323.55378.avila.jn@gmail.com> <50FA316E.8060807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 19 08:53:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwTEs-0003xU-3Q
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 08:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445Ab3ASHwa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 02:52:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439Ab3ASHw3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 02:52:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA31BBD00;
	Sat, 19 Jan 2013 02:52:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nS2YSHA7bvZ5
	hY1CP61JtCjpLkM=; b=AQo2zSP2yRss7A1yMV9ClxKzkoZ9IHd9ylRLDntl9utz
	3/1TnIofqXu8YjURa5Y7G7lK4qIrPN/gziFVCFxAWrg7bQzN0zujh1Kmueur3fzK
	8Bf5a2H/QCz+Cp2dkGTcPaUmZ3rf4K3T+4s+L3EMuWvKsNVLtqViARJRAuTSgmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kk5F3L
	knuRQnBd6gNXB2T8xSmxrvnR+62EbRN7bFJ87LWBGc8Y9kNkwyM0/BiHbKI2y/OD
	lYbpDyrlw9BEjElC0E4gkcOAORRzuZ0aFim5GKaINCyDwIQyUGJIUqPxnzaFQDZr
	sPPlb9k7cLqhZ5P427F6ijn9VvyiAo3qv8bcg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBD0BBCFE;
	Sat, 19 Jan 2013 02:52:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA326BCEF; Sat, 19 Jan 2013
 02:52:26 -0500 (EST)
In-Reply-To: <50FA316E.8060807@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Sat, 19 Jan 2013 06:38:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B7F6BBE-620D-11E2-8691-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213961>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> would it be possible to run
> "git status"
> and share the result with us?
>
> And did you try Jonathans patch?

It may hide the immediate issue, but I am afraid Jonathan's patch
does not fix anything fundamental.  If you do this:

	git checkout next
        make
        git checkout master ;# without 'make clean'
        make && cd t && sh ./t9902-*.sh

then the completion machinery will see the leftover git-check-ignore
at the top of the working tree (which is the $GIT_EXEC_PATH) and the
test that expects "check" to expand only to "checkout" will fail,
because 'master' does not have exclusion definition for check-ignore,
even though it knows check-attr, check-ref-format and checkout-index
are to be excluded as "plumbing".

So if you come up with a brilliant idea to add "git cherry-pack"
command and did this:

	git checkout -b tb/cherry-pack
        edit Makefile builtin/cherry-pack.c builtin.h git.c ...
        git add builtin/cherry-pack.c
        make test
        git commit -a -m "cherry-pack: new command"
        git checkout master ;# without 'make clean'
        make && cd t && sh ./t9902-*.sh

the test will break exactly the same way.

If we really wanted to exclude random build artifacts that the
current checkout did not build, you have to do one of these things:

 (1) at the beginning of t9902, "rm -fr" a temporary location,
     install the built product with a custom DESTDIR set to that
     temporary location that we now know is empty, and point
     GIT_EXEC_PATH to the libexec/git-core directory in that
     temporary location, so that "git help -a" run in the completion
     script will find _only_ the executable we would install; or

 (2) instead of being inclusive, collecting all executable in
     GIT_EXEC_PATH that happens to be named "git-", add a mode to
     "git help" that lists those that we know to be standard
     commands that the users may want to complete from the command
     line.

An outline to do (2) would look like this patch, but I didn't check
other consumers of command-list.txt, so this may be breaking them in
unplanned ways.

 builtin/help.c                         | 35 ++++++++++---------------
 command-list.txt                       |  4 +--
 contrib/completion/git-completion.bash | 14 +---------
 generate-cmdlist.sh                    | 13 +++++++++-
 help.c                                 | 47 ++++++++++++++++++++++++++=
++++++--
 help.h                                 |  1 +
 6 files changed, 75 insertions(+), 39 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index bd86253..32e7d64 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -6,7 +6,6 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
-#include "common-cmds.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "column.h"
@@ -36,11 +35,16 @@ enum help_format {
=20
 static const char *html_path;
=20
-static int show_all =3D 0;
+#define HELP_SHOW_ALL 1
+#define HELP_SHOW_STANDARD 2
+static int show_what;
 static unsigned int colopts;
 static enum help_format help_format =3D HELP_FORMAT_NONE;
 static struct option builtin_help_options[] =3D {
-	OPT_BOOLEAN('a', "all", &show_all, N_("print all available commands")=
),
+	OPT_SET_INT('a', "all", &show_what, N_("print all available commands"=
),
+		HELP_SHOW_ALL),
+	OPT_SET_INT(0, "standard", &show_what, N_("print all available comman=
ds"),
+		HELP_SHOW_STANDARD),
 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMA=
T_MAN),
 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"=
),
 			HELP_FORMAT_WEB),
@@ -287,23 +291,6 @@ static int git_help_config(const char *var, const =
char *value, void *cb)
=20
 static struct cmdnames main_cmds, other_cmds;
=20
-void list_common_cmds_help(void)
-{
-	int i, longest =3D 0;
-
-	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
-		if (longest < strlen(common_cmds[i].name))
-			longest =3D strlen(common_cmds[i].name);
-	}
-
-	puts(_("The most commonly used git commands are:"));
-	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("   %s   ", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name));
-		puts(_(common_cmds[i].help));
-	}
-}
-
 static int is_git_command(const char *s)
 {
 	return is_in_cmdlist(&main_cmds, s) ||
@@ -442,12 +429,18 @@ int cmd_help(int argc, const char **argv, const c=
har *prefix)
 			builtin_help_usage, 0);
 	parsed_help_format =3D help_format;
=20
-	if (show_all) {
+	if (show_what =3D=3D HELP_SHOW_ALL) {
 		git_config(git_help_config, NULL);
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_commands(colopts, &main_cmds, &other_cmds);
 		printf("%s\n", _(git_more_info_string));
 		return 0;
+	} else if (show_what =3D=3D HELP_SHOW_STANDARD) {
+		int i;
+		limit_to_standard(&main_cmds);
+		for (i =3D 0; i < main_cmds.cnt; i++)
+			printf("%s\n", main_cmds.names[i]->name);
+		return 0;
 	}
=20
 	if (!argv[0]) {
diff --git a/command-list.txt b/command-list.txt
index 7e8cfec..94ce8ec 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -116,8 +116,8 @@ git-show                                mainporcela=
in common
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
diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index a4c48e1..46f22af 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -531,23 +531,11 @@ __git_complete_strategy ()
 	return 1
 }
=20
-__git_list_all_commands ()
-{
-	local i IFS=3D" "$'\n'
-	for i in $(git help -a|egrep '^  [a-zA-Z0-9]')
-	do
-		case $i in
-		*--*)             : helper pattern;;
-		*) echo $i;;
-		esac
-	done
-}
-
 __git_all_commands=3D
 __git_compute_all_commands ()
 {
 	test -n "$__git_all_commands" ||
-	__git_all_commands=3D$(__git_list_all_commands)
+	__git_all_commands=3D$(git help --standard)
 }
=20
 __git_list_porcelain_commands ()
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 9a4c9b9..7800af3 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -9,7 +9,7 @@ struct cmdname_help {
 static struct cmdname_help common_cmds[] =3D {"
=20
 sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
-sort |
+LC_ALL=3DC LANG=3DC sort |
 while read cmd
 do
      sed -n '
@@ -20,4 +20,15 @@ do
 	    p
      }' "Documentation/git-$cmd.txt"
 done
+echo "};
+
+static const char *standard_cmd[] =3D {"
+
+LC_ALL=3DC LANG=3DC sort command-list.txt |
+sed -n -e '
+	/^git-[^ 	]*[ 	].* deprecated.*/d
+	/^git-[^ 	]*[ 	].* nocomplete.*/d
+	s/^git-\([^ 	]*\)[ 	].*/  "\1",/p
+'
+
 echo "};"
diff --git a/help.c b/help.c
index 2a42ec6..2ad10db 100644
--- a/help.c
+++ b/help.c
@@ -182,7 +182,7 @@ void load_command_list(const char *prefix,
 		uniq(main_cmds);
 	}
=20
-	if (env_path) {
+	if (env_path && other_cmds) {
 		char *paths, *path, *colon;
 		path =3D paths =3D xstrdup(env_path);
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
+	int src =3D 0, dst =3D 0, ref =3D 0;
+
+	while (src < cmds->cnt && ref < ARRAY_SIZE(standard_cmd)) {
+		int cmp =3D strcmp(cmds->names[src]->name, standard_cmd[ref]);
+		if (cmp < 0) {
+			src++; /* not a standard command */
+		} else if (!cmp) {
+			if (dst !=3D src) {
+				free(cmds->names[dst]);
+				cmds->names[dst] =3D cmds->names[src];
+			}
+			ref++;
+			dst++;
+		} else {
+			ref++; /* uninstalled standard command */
+		}
+	}
+	for (src =3D dst; src < cmds->cnt; src++)
+		free(cmds->names[src]);
+	cmds->cnt =3D dst;
 }
=20
 void list_commands(unsigned int colopts,
@@ -223,6 +249,23 @@ void list_commands(unsigned int colopts,
 	}
 }
=20
+void list_common_cmds_help(void)
+{
+	int i, longest =3D 0;
+
+	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
+		if (longest < strlen(common_cmds[i].name))
+			longest =3D strlen(common_cmds[i].name);
+	}
+
+	puts(_("The most commonly used git commands are:"));
+	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
+		printf("   %s   ", common_cmds[i].name);
+		mput_char(' ', longest - strlen(common_cmds[i].name));
+		puts(_(common_cmds[i].help));
+	}
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index 0ae5a12..ce0d2a5 100644
--- a/help.h
+++ b/help.h
@@ -21,6 +21,7 @@ extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
 			      struct cmdnames *other_cmds);
+extern void limit_to_standard(struct cmdnames *);
 extern void add_cmdname(struct cmdnames *cmds, const char *name, int l=
en);
 /* Here we require that excludes is a sorted list. */
 extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *exclu=
des);

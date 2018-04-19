Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA41F1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeDSMYJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:24:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:55487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752700AbeDSMYI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:24:08 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvhC4-1eLcU83yH6-017W96; Thu, 19
 Apr 2018 14:24:01 +0200
Date:   Thu, 19 Apr 2018 14:23:44 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v7 15/17] pull: accept --rebase=merges to recreate the branch
 topology
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <21d4f142b5f07e33f1f98a5d328981eb8a64afc9.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I73V4CoW5hIi3q+wXFUVhvJXjd+7GBq7PkVWU34uiK6BUOL8vat
 CX/gQV5F+IUCRJk6AAyi7LbHU/iTq0AtpxwJ4WIobBegSYy/4DtNfgBzPRPzTmU4neOgENU
 6S45erkste0TrAESm5Ki2fazRQL14s4fRX+WPkbJ8g79uwDrAX20v3KFlnY4uBHvVWSFg+s
 8ET9m+Gl9iG2Y79gCy6Wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yAIiG1WdPiI=:l363jNzbrpUlcLl2mZfaUA
 sNdG6Hxx0uXJUWMJd2qSri117a2rZDGp+CBRixvTMKrpwfOhaWz1pC9v4kBDqk9ANrOQgRPNK
 BlsztO4JIzqvS7rB3tBteLtSxfO6JDLks5Rx3Bgb0O86UsrNKPVko04PLOP4nfVkw1TDLLE43
 27v9lmf4yqriTwa58Hqt9TnDRwH8qCW4X6n51JiFaJbYfKAtMdSCwkg9547wVYtBUq4dy8Amh
 Mq9weV4r77ovrI0Q9I+QZiumVmYtudTi1sMaG9A4YnVqkatZz7pJ1WCTyf+Z5K6G2jOpZUAM1
 GZ17MoakU4loiwfEl36zP10zQT205TIVoTRdbi7fWJMHa8w4bJs9z4k8YG9tGnl+fbFl8+edj
 +y3bH2/FNEYezAw4yaa5zXXt+x5PzJcemGQcMrD4zYrUDCL8N4x3mzkE/IhAaC/OebmdOyQQx
 PUDnn2pNrpHvLnj4AOJJnFU1S8PeHK+GcDaeG4+um+x+8q0OqHpQ9fegH0i2jKaxuJqpA7/ea
 tKUGvjUXAG1RAAnUYRf9I2VVUALD4+ylOTBSx40YznuEW+pa7iYoN/eIVom3KtScmYgbEpi0x
 n3usNgVQ/Uq0aaGp+i1JYepsyC4zQkB/LVR+b8N4z6TrpfZwDLqsNqbT5U2exZ8iFRCXDLq3f
 omElPjoH1/rTyml/02lPytrqPoSfCZxBuPnZgMim62fkxrS6ybIPl0Bh5SXkoLLU61jYKLz/v
 Oyfk0ZuRaBNCwTB2QD6rU4eCrCICAfl8h55P6AFBdWb8r/Iqk2ekoNAoPzTT1J7TKcbYXxJV6
 Qxa+74MdqnI/EjZV6smEQ3/Zf4jP6dwYcxchakHxIOCGOmcF6k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the `preserve` mode simply passing the `--preserve-merges`
option to the `rebase` command, the `merges` mode simply passes the
`--rebase-merges` option.

This will allow users to conveniently rebase non-trivial commit
topologies when pulling new commits, without flattening them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt               |  8 ++++++++
 Documentation/git-pull.txt             |  5 ++++-
 builtin/pull.c                         | 14 ++++++++++----
 builtin/remote.c                       | 18 ++++++++++++++----
 contrib/completion/git-completion.bash |  2 +-
 5 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb37..da46f154bb3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1058,6 +1058,10 @@ branch.<name>.rebase::
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
 +
+When `merges`, pass the `--rebase-merges` option to 'git rebase'
+so that locally committed merge commits will not be flattened
+by running 'git pull'.
++
 When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
 by running 'git pull'.
@@ -2617,6 +2621,10 @@ pull.rebase::
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
 +
+When `merges`, pass the `--rebase-merges` option to 'git rebase'
+so that locally committed merge commits will not be flattened
+by running 'git pull'.
++
 When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
 by running 'git pull'.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ce05b7a5b13..6f76d815dd3 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -101,13 +101,16 @@ Options related to merging
 include::merge-options.txt[]
 
 -r::
---rebase[=false|true|preserve|interactive]::
+--rebase[=false|true|merges|preserve|interactive]::
 	When true, rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
 	was rebased since last fetched, the rebase uses that information
 	to avoid rebasing non-local changes.
 +
+When set to `merges`, rebase using `git rebase --rebase-merges` so that
+locally created merge commits will not be flattened.
++
 When set to preserve, rebase with the `--preserve-merges` option passed
 to `git rebase` so that locally created merge commits will not be flattened.
 +
diff --git a/builtin/pull.c b/builtin/pull.c
index e32d6cd5b4c..70b44146ce4 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,14 +27,16 @@ enum rebase_type {
 	REBASE_FALSE = 0,
 	REBASE_TRUE,
 	REBASE_PRESERVE,
+	REBASE_MERGES,
 	REBASE_INTERACTIVE
 };
 
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
- * "preserve", returns REBASE_PRESERVE. If value is a invalid value, dies with
- * a fatal error if fatal is true, otherwise returns REBASE_INVALID.
+ * "merges", returns REBASE_MERGES. If value is "preserve", returns
+ * REBASE_PRESERVE. If value is a invalid value, dies with a fatal error if
+ * fatal is true, otherwise returns REBASE_INVALID.
  */
 static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		int fatal)
@@ -47,6 +49,8 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		return REBASE_TRUE;
 	else if (!strcmp(value, "preserve"))
 		return REBASE_PRESERVE;
+	else if (!strcmp(value, "merges"))
+		return REBASE_MERGES;
 	else if (!strcmp(value, "interactive"))
 		return REBASE_INTERACTIVE;
 
@@ -130,7 +134,7 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
-	  "false|true|preserve|interactive",
+	  "false|true|merges|preserve|interactive",
 	  N_("incorporate changes by rebasing rather than merging"),
 	  PARSE_OPT_OPTARG, parse_opt_rebase },
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
@@ -800,7 +804,9 @@ static int run_rebase(const struct object_id *curr_head,
 	argv_push_verbosity(&args);
 
 	/* Options passed to git-rebase */
-	if (opt_rebase == REBASE_PRESERVE)
+	if (opt_rebase == REBASE_MERGES)
+		argv_array_push(&args, "--rebase-merges");
+	else if (opt_rebase == REBASE_PRESERVE)
 		argv_array_push(&args, "--preserve-merges");
 	else if (opt_rebase == REBASE_INTERACTIVE)
 		argv_array_push(&args, "--interactive");
diff --git a/builtin/remote.c b/builtin/remote.c
index 805ffc05cdb..45c9219e07a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -245,7 +245,9 @@ static int add(int argc, const char **argv)
 struct branch_info {
 	char *remote_name;
 	struct string_list merge;
-	enum { NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE } rebase;
+	enum {
+		NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE, REBASE_MERGES
+	} rebase;
 };
 
 static struct string_list branch_list = STRING_LIST_INIT_NODUP;
@@ -306,6 +308,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				info->rebase = v;
 			else if (!strcmp(value, "preserve"))
 				info->rebase = NORMAL_REBASE;
+			else if (!strcmp(value, "merges"))
+				info->rebase = REBASE_MERGES;
 			else if (!strcmp(value, "interactive"))
 				info->rebase = INTERACTIVE_REBASE;
 		}
@@ -963,9 +967,15 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 
 	printf("    %-*s ", show_info->width, item->string);
 	if (branch_info->rebase) {
-		printf_ln(branch_info->rebase == INTERACTIVE_REBASE
-			  ? _("rebases interactively onto remote %s")
-			  : _("rebases onto remote %s"), merge->items[0].string);
+		const char *msg;
+		if (branch_info->rebase == INTERACTIVE_REBASE)
+			msg = _("rebases interactively onto remote %s");
+		else if (branch_info->rebase == REBASE_MERGES)
+			msg = _("rebases interactively (with merges) onto "
+				"remote %s");
+		else
+			msg = _("rebases onto remote %s");
+		printf_ln(msg, merge->items[0].string);
 		return 0;
 	} else if (show_info->any_rebase) {
 		printf_ln(_(" merges with remote %s"), merge->items[0].string);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d4c0a995c39..6af65155c59 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2120,7 +2120,7 @@ _git_config ()
 		return
 		;;
 	branch.*.rebase)
-		__gitcomp "false true preserve interactive"
+		__gitcomp "false true merges preserve interactive"
 		return
 		;;
 	remote.pushdefault)
-- 
2.17.0.windows.1.4.g7e4058d72e3



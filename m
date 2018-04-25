Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852081F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754019AbeDYM34 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:29:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:56743 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753253AbeDYM3r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:29:47 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MCL6r-1f2kxp030L-009Cuj; Wed, 25 Apr 2018 14:29:40 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v9 15/17] pull: accept --rebase=merges to recreate the branch topology
Date:   Wed, 25 Apr 2018 14:29:38 +0200
Message-Id: <c2034fcd4cd8c161a4310167423ea530ad144f6b.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:J1sggpv9dOrWOezINjWPF/41tkm4M/vlaaGB2dkLsJKC1HClfKs
 QZVaNcfs5e6YcFbNlP6j5xpiiVeg1JuXD2voMkcz1F4Kj1fC7yyilvcKyEglodvQtj5I2b3
 XcTYnM9Vw+LMInkJh8vmtfwSeipcGmAaUo5GwIeJliUEV7QA8+svQhuEgaExn9jFRppZkhX
 9H0otg3auAiH9EVr7D4yQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x0/IGF71CAE=:FoeWoF6HjQxIsd60us1gB+
 VTdAF+dU9WgyW3PdYXxphalcoeLJJ3e3dGtMayqkgjVb7ftPK9JsHbTMVZ6suNFUNhhTYX60n
 Oe3RSR0vD3g1ijtiH/v8qXD4y0avtOmxmkEhYc5Ir/xYni7AUYfsHP5nHoeoMvJdVR/erpkQh
 flZaziRWSItXbBv5kbPZ2pBu7cZHbzhLUSh86u7NyRYSQxQY5mUL2JvqlPKguoTH904CiYA/j
 msI2GN2rdF6BndxMfszqArFC4RDHDxHz4nfiTyKX5A85xNrSXA8ciLhB+uKgoJPGsDDzWFxIC
 PIILhthPDuErgoHTBoijJQ1yv5hF8MviJNpEitxEkqL9H4VG1QB+VIIf+EZxIHkLpOtujEhas
 S/R9x7CN4GS0zQfmvLT8EpwjLvJg1xGi7gQnEqTVvdkHVF590qfl6emCIAvkjvPfS5rdaVlbq
 x+cY1zJ3Kbdia5ttc2hxOwoZz67mvxHttUinWB14o73XO+OND8T+a/mY6OC66cj0xE2I+ZmwF
 VwiYcHBo0hjYAc4DldkftIjkBsO5grTAUkc1fQOIwYxcmTx0lEy2Aq//bo5AVGwc0adsZHOqQ
 p649p93Uq4d5nil4cmCYB9yWCt3RDpES9Hjj+zwjwL9zSUd8uqF6KZ0pku+Q5/pP8t2EmE1uP
 RwVPV7cIBpcgArzI3P/l7snI/kIcG4xJR9yX+FmJfy6P9a/n2HscYbmSf5hiflZwRrMHopkKP
 XnkdIC2YplCOPVxOkg+wYw9kNdtyT7waRyaXOIEJ408IVOqe8ltKlTApnJp0bFEsYEifIVDUO
 sfdiSaSO4idv3DOtd/SF8PsENU41khpmq6DZYoY1x+U/H2RyrWzHyvYvr1LDGu/kYqcc53p
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
 Documentation/git-pull.txt             |  6 +++++-
 builtin/pull.c                         | 14 ++++++++++----
 builtin/remote.c                       | 18 ++++++++++++++----
 contrib/completion/git-completion.bash |  2 +-
 5 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb37..d6bcb5dcb67 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1058,6 +1058,10 @@ branch.<name>.rebase::
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
 +
+When `merges`, pass the `--rebase-merges` option to 'git rebase'
+so that the local merge commits are included in the rebase (see
+linkgit:git-rebase[1] for details).
++
 When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
 by running 'git pull'.
@@ -2617,6 +2621,10 @@ pull.rebase::
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
 +
+When `merges`, pass the `--rebase-merges` option to 'git rebase'
+so that the local merge commits are included in the rebase (see
+linkgit:git-rebase[1] for details).
++
 When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
 by running 'git pull'.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ce05b7a5b13..4e0ad6fd8e0 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -101,13 +101,17 @@ Options related to merging
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
+the local merge commits are included in the rebase (see
+linkgit:git-rebase[1] for details).
++
 When set to preserve, rebase with the `--preserve-merges` option passed
 to `git rebase` so that locally created merge commits will not be flattened.
 +
diff --git a/builtin/pull.c b/builtin/pull.c
index 71aac5005e0..c719a4f9d73 100644
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
index e6469004099..7fe2e213d1d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2115,7 +2115,7 @@ _git_config ()
 		return
 		;;
 	branch.*.rebase)
-		__gitcomp "false true preserve interactive"
+		__gitcomp "false true merges preserve interactive"
 		return
 		;;
 	remote.pushdefault)
-- 
2.17.0.windows.1.33.gfcbb1fa0445



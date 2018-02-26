Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16A8F1FAE2
	for <e@80x24.org>; Mon, 26 Feb 2018 21:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeBZVaH (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 16:30:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:41339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbeBZVaA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 16:30:00 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LcBin-1ePIjn24hx-00jWz9; Mon, 26
 Feb 2018 22:29:54 +0100
Date:   Mon, 26 Feb 2018 22:29:53 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 11/12] pull: accept --rebase=recreate to recreate the
 branch topology
In-Reply-To: <cover.1519680483.git.johannes.schindelin@gmx.de>
Message-ID: <f475b92b9ae8ef946512841cc539f7881372b63d.1519680483.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de> <cover.1519680483.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Qaae7mkJYAFtksl5DzCORnUHU9nPY8czo11FMtg+mZlZoRkz5qR
 o7dY5iIRu5dqZYkz5u78ReDtA8rl5fo/77D+7CNVKof4eFgll51Qxgm/Y7QWw8nDGj+gQWQ
 5DpVI89jZR96WlzoWtP7WfTi3bH8Og1Vz8LtkGC7ZSieIGPU+zr6Y7YXDi4PwK/bru4YyVZ
 +PXQfdte1emlKpyNG0zyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5JpMfSTnIFM=:n8Q75ZuaAsTEOgH/aTb1tg
 clPqYU/ePR4vwsD8dU+2yAB5L05oqNnU6HHLYnS+lmSvmSno+wZScBC06W39wqO7C7WcFGUs3
 0y/7fq68tx7GwDr7pXeYJj4YWBlc+Q/LSKiUHU8+j92501auabu0aNXNXgsG3dRq+K83VoOod
 NNP0bRUUL9Vq39U7fSd3gzAIZb7Bu55M6Fa0EqqWsf7wUVDv1Bgfe1h40ZFimcS/KooJvma9j
 BSQ8gCM4oM78BT8RlHmfEJJbHqN+LATCdikGxuIyBFDr3aBvaE4wLuLWthTfg4FWoda8/fjOK
 AFTPRlSkoXsYEYRkmvJ1HMMsORVXaOs3t8c8MDPr4TJAnDIm7+gF53u49pgtQ8GaOXjSo5QAQ
 4zfu2ql3xXtE4P4y+MPGots1i+8L3DIFi16QlUzqxIoJu27ORo/6bkApzJ6Ftthse6Nl+r+o2
 ZTtP5U+qbBmTvsLm8WSQlZz+f1IULo0EeqYe2CU+9IsiYCS4lk80h3Q70fiLEY+1guReB8sw3
 9xggP66sO0AliRiNLY4xyE0IwQRRTUmwlXBj3T5/zu/OT9RlyGlOMFT+KBL5yR8m/KuB7IEE6
 bin3Do/76QRz+M3fhx2KQgD/w/dGT9ozlXxFpS17FWzKCuYFjwka8422lbRMOSAfDBFI4TIqr
 tALSFF8q7feKrBRJ6G4klOS4tsYm5HdWwcq7BdFikVs5vq0+Xb5YmxKw9e3p+g+UuJa7rAr7f
 IzEFSu5wc4GTguPfQktWIqrg1GWNeGU5B31RWb5shTI5+8uI+b9b6KYuk+bwSXiAwwTmWST3B
 jeWuNrQrsfywUWz1wlOaXhYsSu+4+GkK01J1yQfs4cviFJ3vjLQWbQeWMvPCxPs3Wo05K9z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the `preserve` mode simply passing the `--preserve-merges`
option to the `rebase` command, the `recreate` mode simply passes the
`--recreate-merges` option.

This will allow users to conveniently rebase non-trivial commit
topologies when pulling new commits, without flattening them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt               |  8 ++++++++
 Documentation/git-pull.txt             |  5 ++++-
 builtin/pull.c                         | 14 ++++++++++----
 builtin/remote.c                       |  2 ++
 contrib/completion/git-completion.bash |  2 +-
 5 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f57e9cf10ca..8c9adea0d0c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1058,6 +1058,10 @@ branch.<name>.rebase::
 	"git pull" is run. See "pull.rebase" for doing this in a non
 	branch-specific manner.
 +
+When recreate, also pass `--recreate-merges` along to 'git rebase'
+so that locally committed merge commits will not be flattened
+by running 'git pull'.
++
 When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
 by running 'git pull'.
@@ -2607,6 +2611,10 @@ pull.rebase::
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
 +
+When recreate, also pass `--recreate-merges` along to 'git rebase'
+so that locally committed merge commits will not be flattened
+by running 'git pull'.
++
 When preserve, also pass `--preserve-merges` along to 'git rebase'
 so that locally committed merge commits will not be flattened
 by running 'git pull'.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ce05b7a5b13..b4f9f057ea9 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -101,13 +101,16 @@ Options related to merging
 include::merge-options.txt[]
 
 -r::
---rebase[=false|true|preserve|interactive]::
+--rebase[=false|true|recreate|preserve|interactive]::
 	When true, rebase the current branch on top of the upstream
 	branch after fetching. If there is a remote-tracking branch
 	corresponding to the upstream branch and the upstream branch
 	was rebased since last fetched, the rebase uses that information
 	to avoid rebasing non-local changes.
 +
+When set to recreate, rebase with the `--recreate-merges` option passed
+to `git rebase` so that locally created merge commits will not be flattened.
++
 When set to preserve, rebase with the `--preserve-merges` option passed
 to `git rebase` so that locally created merge commits will not be flattened.
 +
diff --git a/builtin/pull.c b/builtin/pull.c
index 1876271af94..9da2cfa0bd3 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -27,14 +27,16 @@ enum rebase_type {
 	REBASE_FALSE = 0,
 	REBASE_TRUE,
 	REBASE_PRESERVE,
+	REBASE_RECREATE,
 	REBASE_INTERACTIVE
 };
 
 /**
  * Parses the value of --rebase. If value is a false value, returns
  * REBASE_FALSE. If value is a true value, returns REBASE_TRUE. If value is
- * "preserve", returns REBASE_PRESERVE. If value is a invalid value, dies with
- * a fatal error if fatal is true, otherwise returns REBASE_INVALID.
+ * "recreate", returns REBASE_RECREATE. If value is "preserve", returns
+ * REBASE_PRESERVE. If value is a invalid value, dies with a fatal error if
+ * fatal is true, otherwise returns REBASE_INVALID.
  */
 static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		int fatal)
@@ -47,6 +49,8 @@ static enum rebase_type parse_config_rebase(const char *key, const char *value,
 		return REBASE_TRUE;
 	else if (!strcmp(value, "preserve"))
 		return REBASE_PRESERVE;
+	else if (!strcmp(value, "recreate"))
+		return REBASE_RECREATE;
 	else if (!strcmp(value, "interactive"))
 		return REBASE_INTERACTIVE;
 
@@ -130,7 +134,7 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
-	  "false|true|preserve|interactive",
+	  "false|true|recreate|preserve|interactive",
 	  N_("incorporate changes by rebasing rather than merging"),
 	  PARSE_OPT_OPTARG, parse_opt_rebase },
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
@@ -800,7 +804,9 @@ static int run_rebase(const struct object_id *curr_head,
 	argv_push_verbosity(&args);
 
 	/* Options passed to git-rebase */
-	if (opt_rebase == REBASE_PRESERVE)
+	if (opt_rebase == REBASE_RECREATE)
+		argv_array_push(&args, "--recreate-merges");
+	else if (opt_rebase == REBASE_PRESERVE)
 		argv_array_push(&args, "--preserve-merges");
 	else if (opt_rebase == REBASE_INTERACTIVE)
 		argv_array_push(&args, "--interactive");
diff --git a/builtin/remote.c b/builtin/remote.c
index d95bf904c3b..b7d0f7ce596 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -306,6 +306,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				info->rebase = v;
 			else if (!strcmp(value, "preserve"))
 				info->rebase = NORMAL_REBASE;
+			else if (!strcmp(value, "recreate"))
+				info->rebase = NORMAL_REBASE;
 			else if (!strcmp(value, "interactive"))
 				info->rebase = INTERACTIVE_REBASE;
 		}
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 38bba3835c6..3d44cb6890c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2182,7 +2182,7 @@ _git_config ()
 		return
 		;;
 	branch.*.rebase)
-		__gitcomp "false true preserve interactive"
+		__gitcomp "false true recreate preserve interactive"
 		return
 		;;
 	remote.pushdefault)
-- 
2.16.1.windows.4



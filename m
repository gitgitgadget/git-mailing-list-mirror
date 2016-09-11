Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4633207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755751AbcIKKyv (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:54:51 -0400
Received: from mout.gmx.net ([212.227.17.22]:52003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755034AbcIKKyu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:54:50 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M1zFf-1auvWu08uR-00u5cz; Sun, 11 Sep 2016 12:54:47
 +0200
Date:   Sun, 11 Sep 2016 12:54:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 15/25] sequencer: prepare for rebase -i's GPG settings
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <fa4ea9fdacaa91454361de66a5a6cd7f94f66518.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2f0n+1zHuHkw67P6unOJCat5xRMpbgetcST9HTq8HCqKQXNF6kp
 2aXfnMmCm5SRxaFYSgkHr719D5FDjlbX/Pwh6ozVC/nVZDp3FtQNlyuMKLHzHmom6o4MtCg
 2xwJPrm7dO0WeJ7F7lSIWtYl/OXWsFPVXgeaiDNV9/KbZ+e2sueznYX7EVus91T1Sex+mr6
 UDOkYQHqUH4Za3z16N2dQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iJYjibTE15A=:LbUJvUt34PTr1NHoSAfj+h
 lTgynlbycAD1Pu/oyiD1DOHMXDbjW/1cPlJI3Kv0zVXzTJfeX7v87n6EidLqh6pHZaaJKFbQw
 Y0zZJgjRvpNN3em3H8mjHc6DZKpO6Xj0hCmlgS3Aqbyt3itE3IgWqw1aAAfs4t9ErDxN4cbnJ
 FB4GMO7TAUTuxtxiPbRJ5wT3W0ycFsilt4/Qi7S8Ov0HNmTrCOKt9V/ceLkLTS2vUBz/qiVFv
 sJ/DQjifxSaijtltd6/DNpQCwtHxJsXtfyDA2RflF1kMoS/+Cx2uBI1j7DfKdx7F/dG3ziqtW
 0HzNbsZJ6ivv38IXGbpcoXi7AHMkU5+Ry/Ro6NswCwWzhHezKsWsAb/c22F5ZuqTSzKISiVfb
 WZOCYZOTGIJ2Rf4enkQLG/a1BuAxPQo5gn+BctXVGlgJh39nLLN7Ta9sHvTNVTSOsP+l6Lu5h
 YyM8YkD0zXzX+jnrnnDRzo54+936weFJQLQDqT8bIJ1xpTHPAI1WZFj1As0TD78ayelmLp9Rl
 Ut51OSRJeO9Lir0RzwxwC2yGh7y4O8K28GbUl7JXHq6QKE7UIElhl6v/b7a+tpAunUtzzrKO3
 4F0fohi0+Msg405o8m+Tm/d8Uw38b3A/mg+2C3k8HGp7ED//1bk0hHggCh80uegwlVVWi477v
 A4zXOnpwryKOwU549NWNU8H0Ajqe2w/0Tdz+juL0HxQ+5TgYy9FPv9WXTz2bGDY4Lb52+nIF2
 cjhK7hWHp6zbU0rzdxXN3/L0TD14DKxgTnHi9ioAFSSpMBJ3Lg9Evj2fn2BfzeGdnpM3qPZU9
 FPzt/Im
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rebase command sports a `--gpg-sign` option that is heeded by the
interactive rebase.

This patch teaches the sequencer that trick, as part of the bigger
effort to make the sequencer the work horse of the interactive rebase.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 086cd0b..bf02565 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -15,6 +15,7 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "argv-array.h"
+#include "quote.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -33,6 +34,11 @@ static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
  * being rebased.
  */
 static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
+/*
+ * The following files are written by git-rebase just after parsing the
+ * command-line (and are only consumed, not modified, by the sequencer).
+ */
+static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 
 /* We will introduce the 'interactive rebase' mode later */
 static inline int is_rebase_i(const struct replay_opts *opts)
@@ -132,6 +138,16 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	return 1;
 }
 
+static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
+{
+	static struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+	if (opts->gpg_sign)
+		sq_quotef(&buf, "-S%s", opts->gpg_sign);
+	return buf.buf;
+}
+
 void *sequencer_entrust(struct replay_opts *opts, void *to_free)
 {
 	ALLOC_GROW(opts->owned, opts->owned_nr + 1, opts->owned_alloc);
@@ -478,17 +494,20 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 
 	if (is_rebase_i(opts)) {
 		env = read_author_script();
-		if (!env)
+		if (!env) {
+			const char *gpg_opt = gpg_sign_opt_quoted(opts);
+
 			return error("You have staged changes in your working "
 				"tree. If these changes are meant to be\n"
 				"squashed into the previous commit, run:\n\n"
-				"  git commit --amend $gpg_sign_opt_quoted\n\n"
+				"  git commit --amend %s\n\n"
 				"If they are meant to go into a new commit, "
 				"run:\n\n"
-				"  git commit $gpg_sign_opt_quoted\n\n"
+				"  git commit %s\n\n"
 				"In both cases, once you're done, continue "
 				"with:\n\n"
-				"  git rebase --continue\n");
+				"  git rebase --continue\n", gpg_opt, gpg_opt);
+		}
 	}
 
 	argv_array_init(&array);
@@ -980,8 +999,21 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 static int read_populate_opts(struct replay_opts *opts)
 {
-	if (is_rebase_i(opts))
+	if (is_rebase_i(opts)) {
+		struct strbuf buf = STRBUF_INIT;
+
+		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
+			if (!starts_with(buf.buf, "-S"))
+				strbuf_reset(&buf);
+			else {
+				opts->gpg_sign = buf.buf + 2;
+				sequencer_entrust(opts,
+					strbuf_detach(&buf, NULL));
+			}
+		}
+
 		return 0;
+	}
 
 	if (!file_exists(git_path_opts_file()))
 		return 0;
-- 
2.10.0.windows.1.10.g803177d



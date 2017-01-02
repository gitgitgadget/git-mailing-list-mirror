Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 663ED205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932983AbdABPfl (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:35:41 -0500
Received: from mout.gmx.net ([212.227.17.21]:63165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932874AbdABPfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:35:40 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MACmL-1cDK5C2Q3N-00BL6R; Mon, 02
 Jan 2017 16:35:31 +0100
Date:   Mon, 2 Jan 2017 16:35:29 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 32/38] sequencer: use run_command() directly
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <fe7fcd26ae2a37e189a6e34e325d308c8fa11ca2.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZW8+0XfckyMKfdXluXfpfKFvU6ozsqELhyRdrUsi6ZCOE8ntd8I
 8RkI6XKdATcFc7rHoGX+GnO595nMjEAgpc+0n5wWjasdJJtcN/Sw0VZ4Uuwj45hfhiqTQlV
 ol7ZWeih1NCFHTJGr/QyylF+eqBsD3xuj2GBP/MJjI8ZrJoAg/6qb9HcdYIKw470Ho025o+
 MvAW1FbyAA6eJum6OZgvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rXB04L5bnU8=:D6AxrdRsy4ls3CLcyU24l2
 DDCvEg6kgLD/GiNwHaNtxLpa/GJN5xdKxjjP9o2L+J4nV5N0O37i55zuMkvmZokABnDbhGxwJ
 KSHUY+v0MAYuBLI21UjvrUmduXKVD7Js5eG8rqxM7R5tgF7FzyCadJPit/HgOfvzAARpYEL+w
 JxqWbZQU9DIz+noBTKzNNA6TQVKAxA1faNP9cr1GCTELwhLgbTRF/nlnV1WxS5pTTvbUyW4T6
 EIa6FGQkSW00ZCW+wec2XqOznp+B06wuOVPA2340+lQkdGSxPGTz6T44YwPlo4HBbdRO7whLl
 jgySmds8jjOxwfhUf5bEl9SSAXBSNKZfwybEvjJ37yqqwE8AuBMtr+z5GchrYTLByeClL8kgG
 kyldnaO5rI6plHjM3KI8FGn/8kvzW2T6HicGyjTIhV5EXF3WEd7JaUzGBPLP5AylcKlLj909d
 qYh/Lf7lYimBBfXSA+n/Ho0lrLwH+QO/z2Z3PeZ7Lcpwn3llZrcjpEerlGGw1MWTKqeMxuQxj
 kv4MrKQxVPlaW/iNx7CO4hgFUFnOu6MimqBRXJWeDo4OW+8tbq6iBvT6EjbwVh/wYGqe6nLCK
 psNN5xTD7qL6BpHuMeShWnCS7TGxCstNfKX8uu9B/YCxzHIKL9Ylrohe5XFW0Q0yjwbBuxryh
 5smEFo49s+fWeW8nFnPfxRuwh7/9cwRgfU5XqkZ8KaLbwl2alhiaZKGvZV75LHlUWPSKrQjdN
 aIWcQL2FBqBOegINYOtFHDaznlEcSFX7ZV4X0OsJV9RlLExDpvhUtrB1DBEA2qrbOR0UE0eiH
 sqo8WYEluTIhKlyxlR/tGu6cGeKs3FmZ14eC+7BqxnRwWaw0hOwvuI1Kfva0A84Hyx6zSnouT
 QURBJ1guk9HlxM4zlWIX9Fn8v3WP+vvZaeobtI1u09faLlY1fnlx3uRfc+pNDLQ3B+gO+tJe3
 O3J0wwBiGuu8V7OGGq3jYWXSrIZhyPr19vIiZsrBZwLHEyB9mVob4dnmUke8TXsPMo1ei4bOv
 lfRLD7R08EIDW5aVSY8qNucCOpAMH8HagLbXVZ4F6/bkaJpexSEKgR1Mw5xDIampzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using the convenience function run_command_v_opt_cd_env(), we
now use the run_command() function. The former function is simply a
wrapper of the latter, trying to make it more convenient to use.

However, we already have to construct the argv and the env parameters,
and we will need even finer control e.g. over the output of the command,
so let's just stop using the convenience function.

Based on patches and suggestions by Johannes Sixt and Jeff King.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a0d0aaeaf8..c7dc5a2ad4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -604,12 +604,13 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 			  int allow_empty, int edit, int amend,
 			  int cleanup_commit_message)
 {
-	struct argv_array env = ARGV_ARRAY_INIT, array;
-	int rc;
+	struct child_process cmd = CHILD_PROCESS_INIT;
 	const char *value;
 
+	cmd.git_cmd = 1;
+
 	if (is_rebase_i(opts)) {
-		if (!read_env_script(&env)) {
+		if (read_env_script(&cmd.env_array)) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
 			return error(_(staged_changes_advice),
@@ -617,39 +618,34 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		}
 	}
 
-	argv_array_init(&array);
-	argv_array_push(&array, "commit");
-	argv_array_push(&array, "-n");
+	argv_array_push(&cmd.args, "commit");
+	argv_array_push(&cmd.args, "-n");
 
 	if (amend)
-		argv_array_push(&array, "--amend");
+		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
-		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
+		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
 	if (opts->signoff)
-		argv_array_push(&array, "-s");
+		argv_array_push(&cmd.args, "-s");
 	if (defmsg)
-		argv_array_pushl(&array, "-F", defmsg, NULL);
+		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	if (cleanup_commit_message)
-		argv_array_push(&array, "--cleanup=strip");
+		argv_array_push(&cmd.args, "--cleanup=strip");
 	if (edit)
-		argv_array_push(&array, "-e");
+		argv_array_push(&cmd.args, "-e");
 	else if (!cleanup_commit_message &&
 		 !opts->signoff && !opts->record_origin &&
 		 git_config_get_value("commit.cleanup", &value))
-		argv_array_push(&array, "--cleanup=verbatim");
+		argv_array_push(&cmd.args, "--cleanup=verbatim");
 
 	if (allow_empty)
-		argv_array_push(&array, "--allow-empty");
+		argv_array_push(&cmd.args, "--allow-empty");
 
 	if (opts->allow_empty_message)
-		argv_array_push(&array, "--allow-empty-message");
+		argv_array_push(&cmd.args, "--allow-empty-message");
 
-	rc = run_command_v_opt_cd_env(array.argv, RUN_GIT_CMD, NULL,
-			(const char *const *)env.argv);
-	argv_array_clear(&array);
-	argv_array_clear(&env);
 
-	return rc;
+	return run_command(&cmd);
 }
 
 static int is_original_commit_empty(struct commit *commit)
-- 
2.11.0.rc3.windows.1



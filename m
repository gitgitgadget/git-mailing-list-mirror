Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CA1C7618B
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 15:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjCOPPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 11:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjCOPPh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 11:15:37 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00411A954
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 08:15:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p16so12800874wmq.5
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 08:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678893334;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6W/s9RGNic/3VFmjO0Wvh8nW993S8mFHJDfRzcB4y1U=;
        b=TSr1Y/OXysIduw/NtxFnhe+dN1vr+Q3LVsBB+YCCFQp2XO+RBqnbFbOL8aQk4qur94
         hfvk/+f6i+Cw0HlUSIv+NelaDgf38UkOsbbRY0msKK0YVvpR+FOEy0rWl6UJu3sJRkv5
         h6NZXmv2VaeoVt0tPdoaCYgqEmjYL5+qEL3wgxUJ2HSMsTDwfRuWzXaIY5rJ0lHJXTyn
         ggT3qf7OG60SaNOUFJCXUwtZiqXGQ09wqc6sqcIg5488rVeSdDC1f0xLMggHp9o1dtFH
         TLHoSuhGKZXimAUe13TcFpO4hkvJXDi6vxbyLwlo6GPeAMr9m4FAGuZVwSjfN0/VB6RU
         npsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893334;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6W/s9RGNic/3VFmjO0Wvh8nW993S8mFHJDfRzcB4y1U=;
        b=nvz9hsWKFVSM3QbH8wAzYB0gkkJGCC6s0vpAdswT9lrgq5feAeSymp5K1XHj0x4Qga
         sF371Hwms2o/G4XdqRh4SZieDC5/jFJ0pw1LuaA7YmCuHKlHLiyq+2qpnWemqbUa+0JK
         +KkQWyyva2YfwJWcPSj+cbP8TCjx009Lg5glKFXkYzG5noU/iETkZx8eYGx4h58F8Qu4
         Tn2h4K2xfFgHkVrZZzVbEbi17qoGvfR3kqOOtqp42TSID/rZxzndclNhqp+/I47HvIrk
         Ow/kTkgCmJslboEb9FtRXVMl56Nu+/Ji7iW0mx+l/FzjSaw+F+vCALoXTEhtC2IVsxWK
         AbRA==
X-Gm-Message-State: AO0yUKWDazHnI0zEpD/WngF16HnY3T5KXl1xRF+7m3g3HDXHtVSQ8HnI
        GQhC/UbGn/Y0WHSF+64L65CD45Ze7QQ=
X-Google-Smtp-Source: AK7set9SnVfGz3Nq/SIwZS94rMOuHNIhMZrG8epbmFmS36ZxS0xbDbLDF9XyWn1bAMmhm/Ee3S8tww==
X-Received: by 2002:a05:600c:510a:b0:3ed:307f:1663 with SMTP id o10-20020a05600c510a00b003ed307f1663mr3891173wms.15.1678893334060;
        Wed, 15 Mar 2023 08:15:34 -0700 (PDT)
Received: from localhost.localdomain ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b002c706c754fesm4783191wrv.32.2023.03.15.08.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 08:15:33 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/4] rebase -m: cleanup --strategy-option handling
Date:   Wed, 15 Mar 2023 15:14:57 +0000
Message-Id: <a01b182644f4ad3b4cf30cf1895dc9ea1e9fa197.1678893298.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When handling "--strategy-option" rebase collects the commands into a
struct string_list, then concatenates them into a string, prepending "--"
to each one before splitting the string and removing the "--" prefix.
This is an artifact of the scripted rebase and the need to support
"rebase --preserve-merges". Now that "--preserve-merges" no-longer
exists we can cleanup the way the argument is handled.

The tests for a bad strategy option are adjusted now that
parse_strategy_opts() is no-longer called when starting a rebase. The
fact that it only errors out when running "git rebase --continue" is a
mixed blessing but the next commit will fix the root cause of the
parsing problem so lets not worry about that here.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c               | 36 +++++++++++++++-------------------
 sequencer.c                    |  2 +-
 sequencer.h                    |  1 -
 t/t3436-rebase-more-options.sh | 10 ++++++++--
 4 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 516ad1b12a..5194d64c24 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -116,7 +116,8 @@ struct rebase_options {
 	struct string_list exec;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
-	char *strategy, *strategy_opts;
+	char *strategy;
+	struct string_list strategy_opts;
 	struct strbuf git_format_patch_opt;
 	int reschedule_failed_exec;
 	int reapply_cherry_picks;
@@ -142,6 +143,7 @@ struct rebase_options {
 		.config_autosquash = -1,                \
 		.update_refs = -1,                      \
 		.config_update_refs = -1,               \
+		.strategy_opts = STRING_LIST_INIT_NODUP	\
 	}
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
@@ -175,8 +177,14 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 		replay.default_strategy = NULL;
 	}
 
-	if (opts->strategy_opts)
-		parse_strategy_opts(&replay, opts->strategy_opts);
+	if (opts->strategy_opts.nr) {
+		ALLOC_ARRAY(replay.xopts, opts->strategy_opts.nr);
+		replay.xopts_nr = opts->strategy_opts.nr;
+		replay.xopts_alloc = opts->strategy_opts.nr;
+		for (size_t i = 0; i < opts->strategy_opts.nr; i++)
+			replay.xopts[i] =
+				xstrdup(opts->strategy_opts.items[i].string);
+	}
 
 	if (opts->squash_onto) {
 		oidcpy(&replay.squash_onto, opts->squash_onto);
@@ -1012,7 +1020,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	int ignore_whitespace = 0;
 	const char *gpg_sign = NULL;
 	const char *rebase_merges = NULL;
-	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
 	struct object_id squash_onto;
 	char *squash_onto_name = NULL;
 	char *keep_base_onto_name = NULL;
@@ -1121,7 +1128,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
 			   N_("strategy"), N_("use the given merge strategy")),
-		OPT_STRING_LIST('X', "strategy-option", &strategy_options,
+		OPT_STRING_LIST('X', "strategy-option", &options.strategy_opts,
 				N_("option"),
 				N_("pass the argument through to the merge "
 				   "strategy")),
@@ -1435,23 +1442,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else {
 		/* REBASE_MERGE */
 		if (ignore_whitespace) {
-			string_list_append(&strategy_options,
+			string_list_append(&options.strategy_opts,
 					   "ignore-space-change");
 		}
 	}
 
-	if (strategy_options.nr) {
-		int i;
-
-		if (!options.strategy)
-			options.strategy = "ort";
-
-		strbuf_reset(&buf);
-		for (i = 0; i < strategy_options.nr; i++)
-			strbuf_addf(&buf, " --%s",
-				    strategy_options.items[i].string);
-		options.strategy_opts = xstrdup(buf.buf);
-	}
+	if (options.strategy_opts.nr && !options.strategy)
+		options.strategy = "ort";
 
 	if (options.strategy) {
 		options.strategy = xstrdup(options.strategy);
@@ -1826,10 +1823,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	free(options.gpg_sign_opt);
 	string_list_clear(&options.exec, 0);
 	free(options.strategy);
-	free(options.strategy_opts);
+	string_list_clear(&options.strategy_opts, 0);
 	strbuf_release(&options.git_format_patch_opt);
 	free(squash_onto_name);
 	free(keep_base_onto_name);
-	string_list_clear(&strategy_options, 0);
 	return !!ret;
 }
diff --git a/sequencer.c b/sequencer.c
index 55b3ba3a51..83ea1016ae 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2918,7 +2918,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	return 0;
 }
 
-void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
+static void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
 {
 	int i;
 	int count;
diff --git a/sequencer.h b/sequencer.h
index 3bcdfa1b58..5de5cfa664 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -247,7 +247,6 @@ int read_oneliner(struct strbuf *buf,
 	const char *path, unsigned flags);
 int read_author_script(const char *path, char **name, char **email, char **date,
 		       int allow_missing);
-void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      struct commit *onto, const struct object_id *orig_head);
 void sequencer_post_commit_cleanup(struct repository *r, int verbose);
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index c3184c9ade..3adf42f47d 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -41,19 +41,25 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'bad -X <strategy-option> arguments: unclosed quote' '
+	test_when_finished "test_might_fail git rebase --abort" &&
 	cat >expect <<-\EOF &&
 	fatal: could not split '\''--bad'\'': unclosed quote
 	EOF
-	test_expect_code 128 git rebase -X"bad argument\"" side main >out 2>actual &&
+	GIT_SEQUENCE_EDITOR="echo break >" \
+		git rebase -i -X"bad argument\"" side main &&
+	test_expect_code 128 git rebase --continue >out 2>actual &&
 	test_must_be_empty out &&
 	test_cmp expect actual
 '
 
 test_expect_success 'bad -X <strategy-option> arguments: bad escape' '
+	test_when_finished "test_might_fail git rebase --abort" &&
 	cat >expect <<-\EOF &&
 	fatal: could not split '\''--bad'\'': cmdline ends with \
 	EOF
-	test_expect_code 128 git rebase -X"bad escape \\" side main >out 2>actual &&
+	GIT_SEQUENCE_EDITOR="echo break >" \
+		git rebase -i -X"bad escape \\" side main &&
+	test_expect_code 128 git rebase --continue >out 2>actual &&
 	test_must_be_empty out &&
 	test_cmp expect actual
 '
-- 
2.39.2


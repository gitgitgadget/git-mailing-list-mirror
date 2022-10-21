Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B7AC43217
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJUJWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiJUJWH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:22:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28D32565F0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:22:00 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bv10so3907159wrb.4
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCtQUYDJQX3GAiniLMUYw+pLQXAUjLsw2bX/8F0aMls=;
        b=dxGJ5DeVFUadG+AQbOPn455WieEVGgGa3+xPa4/O4tNFzT58ELCLJIG+cTI+8eflEG
         EDS7zdGNxcSSa+/2IXZ/S6HDjSxutmXpOKRB8Yw1+SoGxFVjH5AWuM/OjsURDHYGucGq
         csrCn8wv74MH8lhzxDVNEnL0Wt+cbtrDfntKOQLMpcUQKKOo0YQVELWt2/ziDbChGOOr
         4XKELxuTY0EtAhVKvU1IHhKm4NzITYKOQTyoDq4bSKG43BZOjpdNcEqU8+DSQLqxEWsH
         lGtxiL9hwN01uVD5yKjZsFpR6wt6K5qMxhaGdGrR9OyWluyJpv6PS1o7eXq5n8XrqIHc
         bnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCtQUYDJQX3GAiniLMUYw+pLQXAUjLsw2bX/8F0aMls=;
        b=hXZ6mok+fYHhYAuKQ9F9XChvCz9DbfYQSD2kmotye+SyXPiUrkkc1bRrHCr/5t4TsD
         MN0Yc9CxbiqbdGo90w0zJF3TvNhGHnwXRWXgVKPlCEK1nGTTwK4L7nqMWy8fGluCo8Oy
         r0Omjq1nI57VjFxrRobuApOtJzrsm+8fCnSOqaOQ6V8U2/IQgnZmg2Ra3PNTp4Kqjl/t
         hb7mM5I92vfjVXuTjhbQOnhUa1xsPyK6//exJaHKeGwqGYqBsuIAlohhShceL05GTyTg
         +afSsANHUnIGW7iLypjeFi/wgWEMS07/HfMAv74N3KVQzr3BV5iQTNWQN4812DELIGKO
         B07g==
X-Gm-Message-State: ACrzQf08xGS7f3pBuz/L1B7U9QP5vFvvZWejB+EgDi454C3KndyOrKuu
        FP5GJMYW8UUdLpYsJpCQX6DymSs+OgA=
X-Google-Smtp-Source: AMsMyM726bcOmfovmqnZ0byYQ76LOmGeSGURn5BW7t3ydSoFrVUvtPhDgJFg8ZzMGCQHjwbcctrOxQ==
X-Received: by 2002:adf:d1c4:0:b0:230:7771:f618 with SMTP id b4-20020adfd1c4000000b002307771f618mr10774147wrd.203.1666344118411;
        Fri, 21 Oct 2022 02:21:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d6d45000000b0022e57e66824sm21702181wri.99.2022.10.21.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:21:57 -0700 (PDT)
Message-Id: <c8fa57f129dd61fd4925e1c29ca78b89364dc62b.1666344108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 09:21:47 +0000
Subject: [PATCH v4 7/8] rebase --abort: improve reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When aborting a rebase the reflog message looks like

	rebase (abort): updating HEAD

which is not very informative. Improve the message by mentioning the
branch that we are returning to as we do at the end of a successful
rebase so it looks like.

	rebase (abort): returning to refs/heads/topic

If GIT_REFLOG_ACTION is set in the environment we no longer omit
"(abort)" from the reflog message. We don't omit "(start)" and
"(finish)" when starting and finishing a rebase in that case so we
shouldn't omit "(abort)".

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 28 ++++++---------------
 t/t3406-rebase-message.sh | 51 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5253ba66861..d63d77757e8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1001,23 +1001,6 @@ static void NORETURN error_on_missing_default_upstream(void)
 	exit(1);
 }
 
-static void set_reflog_action(struct rebase_options *options)
-{
-	const char *env;
-	struct strbuf buf = STRBUF_INIT;
-
-	if (!is_merge(options))
-		return;
-
-	env = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
-	if (env && strcmp("rebase", env))
-		return; /* only override it if it is "rebase" */
-
-	strbuf_addf(&buf, "rebase (%s)", options->action);
-	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, buf.buf, 1);
-	strbuf_release(&buf);
-}
-
 static int check_exec_cmd(const char *cmd)
 {
 	if (strchr(cmd, '\n'))
@@ -1311,18 +1294,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 	case ACTION_ABORT: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
-		options.action = "abort";
-		set_reflog_action(&options);
+		struct strbuf head_msg = STRBUF_INIT;
 
+		options.action = "abort";
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
 
 		if (read_basic_state(&options))
 			exit(1);
+
+		strbuf_addf(&head_msg, "%s (abort): returning to %s",
+			    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
+			    options.head_name ? options.head_name
+					      : oid_to_hex(&options.orig_head->object.oid));
 		ropts.oid = &options.orig_head->object.oid;
+		ropts.head_msg = head_msg.buf;
 		ropts.branch = options.head_name;
 		ropts.flags = RESET_HEAD_HARD;
-		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
 		if (reset_head(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head->object.oid));
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 5c6cd9af3bc..ceca1600053 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -187,6 +187,57 @@ test_reflog () {
 	EOF
 	test_cmp expect actual
 	'
+
+	test_expect_success "rebase $mode --abort reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout conflicts &&
+	test_when_finished "git reset --hard Q" &&
+
+	git log -g -1 conflicts >branch-expect &&
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		test_must_fail git rebase $mode main &&
+		git rebase --abort
+	) &&
+
+	git log -g --format=%gs -3 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (abort): returning to refs/heads/conflicts
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
+	EOF
+	test_cmp expect actual &&
+
+	# check branch reflog is unchanged
+	git log -g -1 conflicts >branch-actual &&
+	test_cmp branch-expect branch-actual
+	'
+
+	test_expect_success "rebase $mode --abort detached HEAD reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout Q &&
+	test_when_finished "git reset --hard Q" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		test_must_fail git rebase $mode main &&
+		git rebase --abort
+	) &&
+
+	git log -g --format=%gs -3 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (abort): returning to $(git rev-parse Q)
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
+	EOF
+	test_cmp expect actual
+	'
 }
 
 test_reflog --merge
-- 
gitgitgadget


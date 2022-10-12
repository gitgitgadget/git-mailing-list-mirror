Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E47C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiJLJgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJLJfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:35:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4BE537F0
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so843367wmq.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fowo9SAEGEk8jvA9tSepjAFsyJTa5RUMorcFYWRqTNw=;
        b=SQ4JpRfrzE7SehRlTaEVHgsU3974E87VDeRvcLPlQyQNsrko6WkCknpa9g1/tkt0sw
         LGY2DYUbfGgebqdnmtn9jkP3u0bWJfiH7Zuf6/E+h5z4pf1bzyT8t99DVUCsAuAhuUNk
         UGpwwMAlicpeiw7RSJ9bQ2hk9FbGyaZzW2SsQ8f9VF1Rgtkkm0e5cyy2IvKauGal8Y2n
         NyqQ5uHgl9ULofgkRzEJupdavcvZa36X3jKfnNZIQXR7AvYYlb7sxRXEH5eUi2352IUb
         a/xSLNctJ17rjKBMSM/eTUw1FQVRpn8FXaP+nt1oQlBKiN/ohMFL1CyPg/qIUrsXxeTy
         xlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fowo9SAEGEk8jvA9tSepjAFsyJTa5RUMorcFYWRqTNw=;
        b=CIB0OjXirxBRHPCpw/PlYf1SJzKLBwDvwMA+qAoEkxDgLaiXpP0eJAhpRn4o3ntkNT
         onv/S7EE/Js6l87cOz8uL3sOXjdI070jRR7AJmMsDsn/apRmRsADgfwJSpAMRUWH6whD
         xLAR9i8d2NV/knjbyP4a6aD25BLQdthqKZV31rqFCMEtnq3dDhV5KSZKZE8ecjxzfGqb
         AVoZgEO92i22XUboSTDkxSHxCyL63tfbDTpvP/99QA+aJFuq/u6VzQZnUaZLCPCys1Dj
         BCyLPNtF1qdSk7uVK2/yrRcscoyiJZ6AV2/dUYFms1qE4NakreCsi41lG6NJ32/lQaBf
         z+lQ==
X-Gm-Message-State: ACrzQf3YCW0I6A3BkgN1C0ackZi0yexPVnQTKhYhS5itTiQa9/hwxFrn
        1n94Io7AUvTp/8Dyl9en5DWNutwZVtc=
X-Google-Smtp-Source: AMsMyM7leN2U1Wg6AJ8xpqnGupj3/td5Cn9hc6an7at7jwnadN8ztkYXO+uYRlk5ASMnXrhZxwGb+g==
X-Received: by 2002:a05:600c:4e52:b0:3b4:a828:1d84 with SMTP id e18-20020a05600c4e5200b003b4a8281d84mr1996268wmq.143.1665567320865;
        Wed, 12 Oct 2022 02:35:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14-20020adfe28e000000b00231ed902a4esm1507935wri.5.2022.10.12.02.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:35:20 -0700 (PDT)
Message-Id: <aa808725fb88f21122d9b0466d9185740e540126.1665567312.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 09:35:11 +0000
Subject: [PATCH v3 7/8] rebase --abort: improve reflog message
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
index ed612c2d0c3..e4620935129 100644
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


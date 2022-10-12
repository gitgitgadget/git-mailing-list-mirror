Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86CCC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiJLJfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJLJfT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:35:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE0533E0C
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w18so25380912wro.7
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vz48/RSPFOJlzJ3tJY1CkSjfI97YkEq4vzNOy46Tkig=;
        b=NwjcA7SCToCMWKSP5jmttqcTKCX9QAhE6LCRTXGFpjxs6z65URUGMldLDLKIreAdJm
         D7pKkMaxLwrFcBo5xZjgQd0N+rm5bVnN95yvofhUqoJGLJ2ZzuMI6Vm5FtrN6tqELOtA
         RZ0DWAzfI9Y01XcUA0asFDhl/3QqUyZN/TbTU7rK5slJjrFn7iyLf5kj0uX4cBSowE98
         itZmb7jfwVHjB7pWIGAkf28T4bhsqx98Xk6LV0F3r9d81NQVSTgkOsryx5MjfYpKaO7i
         kaQENSd17AiZ+QT6BeEqOVp00OXGXDLQOvNolfoeN+PAY2Vb7Mlvqi1zNwfVxBTI0+dU
         ypaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vz48/RSPFOJlzJ3tJY1CkSjfI97YkEq4vzNOy46Tkig=;
        b=yzwoS4zvaiZ7I+xa+4iV0XAVgkz4f65i4qJic2il/iAaYMVi57BMHY1EIHJZfK79T4
         DV7c4RwUePvpfN+Mqx+qaN3gAv8OJEHVU9AwDsvQu7upy6y9HTiMa1j76vX2Z10jvBL0
         fUZicX6OKxnAqc6IGHmOys8HCP+xlMWKUEqckBhcnyHO5AJpq/qPtpVg256XZKL7+ygT
         xT7O5AUrsEIvrxnUxJaj6jsbgrnK/ORjm2UJ7M5ebSmMGXmAgfGoB6myYRfGAqKqpNcq
         as9P+wSSEhjxQaoLcyKAUrJTpOHosEz4kC6fd4Bs2MaRVFbC7fx62Wo0gQaP27buHEfp
         nrXQ==
X-Gm-Message-State: ACrzQf0DVQxeA4QOQ2bJVGGkwPXKH58Z3A0g0/x24n4pF6NXdHjTwLsm
        mKHuQFnYY6NsYnRvkxkT88C70CiGxtM=
X-Google-Smtp-Source: AMsMyM7P49bRrMZAAM2U1FhNTE034cuyEPRSOLGDVdqrnG+wUHzF69DfJm/2M/ptM77aL8N3+oKDGw==
X-Received: by 2002:adf:f591:0:b0:22e:504e:fe76 with SMTP id f17-20020adff591000000b0022e504efe76mr17584789wro.553.1665567316193;
        Wed, 12 Oct 2022 02:35:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10-20020a056000104a00b0022917d58603sm13248177wrx.32.2022.10.12.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:35:15 -0700 (PDT)
Message-Id: <b9255ad35d2590df81c4b7629a00002c82fc9bf4.1665567312.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 09:35:06 +0000
Subject: [PATCH v3 2/8] t3406: rework rebase reflog tests
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

Refactor the tests in preparation for adding more tests in the next
few commits. The reworked tests use the same function for testing both
the "merge" and "apply" backends. The test coverage for the "apply"
backend now includes setting GIT_REFLOG_ACTION.

Note that rebasing the "conflicts" branch does not create any
conflicts yet. A commit to do that will be added in the next commit
and the diff ends up smaller if we have don't rename the branch when
it is added.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3406-rebase-message.sh | 115 +++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 39 deletions(-)

diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index d17b450e811..5253dd1551d 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -10,10 +10,15 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 test_expect_success 'setup' '
 	test_commit O fileO &&
 	test_commit X fileX &&
+	git branch fast-forward &&
 	test_commit A fileA &&
 	test_commit B fileB &&
 	test_commit Y fileY &&
 
+	git checkout -b conflicts O &&
+	test_commit P &&
+	test_commit Q &&
+
 	git checkout -b topic O &&
 	git cherry-pick A B &&
 	test_commit Z fileZ &&
@@ -79,54 +84,86 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 	test_i18ngrep "Invalid whitespace option" err
 '
 
-test_expect_success 'GIT_REFLOG_ACTION' '
-	git checkout start &&
-	test_commit reflog-onto &&
-	git checkout -b reflog-topic start &&
-	test_commit reflog-to-rebase &&
-
-	git rebase reflog-onto &&
-	git log -g --format=%gs -3 >actual &&
-	cat >expect <<-\EOF &&
-	rebase (finish): returning to refs/heads/reflog-topic
-	rebase (pick): reflog-to-rebase
-	rebase (start): checkout reflog-onto
+write_reflog_expect () {
+	if test $mode = --apply
+	then
+		sed 's/.*(finish)/rebase finished/; s/ ([^)]*)//'
+	else
+		cat
+	fi >expect
+}
+
+test_reflog () {
+	mode=$1
+	reflog_action="$2"
+
+	test_expect_success "rebase $mode reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout conflicts &&
+	test_when_finished "git reset --hard Q" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		git rebase $mode main
+	) &&
+
+	git log -g --format=%gs -4 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): returning to refs/heads/conflicts
+	${reflog_action:-rebase} (pick): Q
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
 	EOF
 	test_cmp expect actual &&
 
-	git checkout -b reflog-prefix reflog-to-rebase &&
-	GIT_REFLOG_ACTION=change-the-reflog git rebase reflog-onto &&
-	git log -g --format=%gs -3 >actual &&
-	cat >expect <<-\EOF &&
-	change-the-reflog (finish): returning to refs/heads/reflog-prefix
-	change-the-reflog (pick): reflog-to-rebase
-	change-the-reflog (start): checkout reflog-onto
+	git log -g --format=%gs -1 conflicts >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): refs/heads/conflicts onto $(git rev-parse main)
 	EOF
-	test_cmp expect actual
-'
-
-test_expect_success 'rebase --apply reflog' '
-	git checkout -b reflog-apply start &&
-	old_head_reflog="$(git log -g --format=%gs -1 HEAD)" &&
-
-	git rebase --apply Y &&
+	test_cmp expect actual &&
 
-	git log -g --format=%gs -4 HEAD >actual &&
-	cat >expect <<-EOF &&
-	rebase finished: returning to refs/heads/reflog-apply
-	rebase: Z
-	rebase: checkout Y
-	$old_head_reflog
+	# check there is only one new entry in the branch reflog
+	test_cmp_rev conflicts@{1} Q
+	'
+
+	test_expect_success "rebase $mode fast-forward reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout fast-forward &&
+	test_when_finished "git reset --hard X" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		git rebase $mode main
+	) &&
+
+	git log -g --format=%gs -2 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): returning to refs/heads/fast-forward
+	${reflog_action:-rebase} (start): checkout main
 	EOF
 	test_cmp expect actual &&
 
-	git log -g --format=%gs -2 reflog-apply >actual &&
-	cat >expect <<-EOF &&
-	rebase finished: refs/heads/reflog-apply onto $(git rev-parse Y)
-	branch: Created from start
+	git log -g --format=%gs -1 fast-forward >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): refs/heads/fast-forward onto $(git rev-parse main)
 	EOF
-	test_cmp expect actual
-'
+	test_cmp expect actual &&
+
+	# check there is only one new entry in the branch reflog
+	test_cmp_rev fast-forward@{1} X
+	'
+}
+
+test_reflog --merge
+test_reflog --merge my-reflog-action
+test_reflog --apply
+test_reflog --apply my-reflog-action
 
 test_expect_success 'rebase -i onto unrelated history' '
 	git init unrelated &&
-- 
gitgitgadget


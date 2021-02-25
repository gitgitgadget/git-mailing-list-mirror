Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955D2C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FCF64EC8
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 10:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbhBYKWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 05:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbhBYKS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 05:18:59 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F5FC0611C0
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:17:03 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id j12so3276903pfj.12
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 02:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxVQpLeQIoUTjSC6mfswR0n250T0r5hvcHK8KX8PM8g=;
        b=NBjQ5n5mfmqECwtq1sBhWahrM6NdI6/9RcbelxhdqTWItrou3nOdcIv3cjsN09hbWM
         PgN7cTkhKBDZ+2IrW46AMhIXWpBClNE6b/JN/3q903n1Dzqcr4B0ACSxNn7VMeP6Yvmn
         3a4KjCEuEoQiIj3quIFgia0EdC8x4/s+LRD3T5lQEO7KcLr0uj8XnqO1EWeG3wmy77Ee
         grsyi1t++buY18BkxCtSoC/ksF7gAKrfI9VaRrEC8IGPHQaF3u8lWuPyWSD2z3DRYyn9
         LdP3PH7nzO2xH2Qw/9v2DdonLcGOIMq0SJJnCVYSS8SP2swNJ2NjeAr5YeKTNnJDEwIX
         ADyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxVQpLeQIoUTjSC6mfswR0n250T0r5hvcHK8KX8PM8g=;
        b=FAEPIbM9NqeF38Wtf2A4n26LebvadGpNoQFGrwYu2IzRysHFCfS6qFmBCgWXLTM2Lj
         U3SKFMJsVihk4hrFmectPz85o2jOOgC1PMWrOvugfBwKV32/vXPl6caPO9vzAvvPmuGP
         w4Iq6DjE7wvXY/kh/DXLE99JqjYTuB6RpNbC9HsbY7wWJVt78jhy1seGQA5HbCyHM2cO
         xn3+jOmAf/DMWxTHqsNguBM4vC0XFJJA+fLkW7gBLXrqAuVVZZy6uR2Ih+sxt8/Brfim
         qsqZ4n11OtnIQFMfBv/JDfaPXbyc7sFxV1H4aq/1+WWm8y8AONcAMnCd2V3cpy/EhRx1
         lBDA==
X-Gm-Message-State: AOAM533MYF9BX/4TixZJR/O7baFYj0ke63KM/fL9Gk57QQhn5A/zMpDb
        E6bHmbGhA0NDkhGAuEoOqKY3XtNiHkAcaw==
X-Google-Smtp-Source: ABdhPJw90w+7mClLAJvu0rjpvFjMkqWCWR2+4GB/9rN0ZHEpQqU8jP2zajIMkL5wLv9GrAT6pM+ciQ==
X-Received: by 2002:a62:8606:0:b029:1ed:55db:22b7 with SMTP id x6-20020a6286060000b02901ed55db22b7mr2536854pfd.75.1614248222457;
        Thu, 25 Feb 2021 02:17:02 -0800 (PST)
Received: from localhost.localdomain ([223.233.90.42])
        by smtp.googlemail.com with ESMTPSA id 67sm5941188pfb.43.2021.02.25.02.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:17:02 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 4/6] t7500: add tests for --fixup=[amend|reword] options
Date:   Thu, 25 Feb 2021 15:39:00 +0530
Message-Id: <20210225100855.25530-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210217072904.16257-1-charvi077@gmail.com>
References: <20210217072904.16257-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7500-commit-template-squash-signoff.sh | 135 ++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 6d19ece05d..3b3a39fcaf 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -9,6 +9,8 @@ Tests for template, signoff, squash and -F functions.'
 
 . ./test-lib.sh
 
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
 commit_msg_is () {
 	expect=commit_msg_is.expect
 	actual=commit_msg_is.actual
@@ -279,6 +281,139 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '
 
 extra"
 '
+get_commit_msg () {
+	rev="$1" &&
+	git log -1 --pretty=format:"%B" "$rev"
+}
+
+test_expect_success 'commit --fixup=amend: creates amend! commit' '
+	commit_for_rebase_autosquash_setup &&
+	cat >expected <<-EOF &&
+	amend! $(git log -1 --format=%s HEAD~)
+
+	$(get_commit_msg HEAD~)
+
+	edited
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND="edited" \
+			git commit --fixup=amend:HEAD~
+	) &&
+	get_commit_msg HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--fixup=reword: does not commit staged changes' '
+	commit_for_rebase_autosquash_setup &&
+	cat >expected <<-EOF &&
+	amend! $(git log -1 --format=%s HEAD~)
+
+	$(get_commit_msg HEAD~)
+
+	edited
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND="edited" \
+			git commit --fixup=reword:HEAD~
+	) &&
+	get_commit_msg HEAD >actual &&
+	test_cmp expected actual &&
+	test_cmp_rev HEAD@{1}^{tree} HEAD^{tree} &&
+	test_cmp_rev HEAD@{1} HEAD^ &&
+	test_expect_code 1 git diff --cached --exit-code &&
+	git cat-file blob :foo >actual &&
+	test_cmp foo actual
+'
+
+test_expect_success '--fixup=reword: error out with -m option' '
+	commit_for_rebase_autosquash_setup &&
+	echo "fatal: cannot combine -m with --fixup:reword" >expect &&
+	test_must_fail git commit --fixup=reword:HEAD~ -m "reword commit message" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--fixup=amend: error out with -m option' '
+	commit_for_rebase_autosquash_setup &&
+	echo "fatal: cannot combine -m with --fixup:amend" >expect &&
+	test_must_fail git commit --fixup=amend:HEAD~ -m "amend commit message" 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'consecutive amend! commits remove amend! line from commit msg body' '
+	commit_for_rebase_autosquash_setup &&
+	cat >expected <<-EOF &&
+	amend! amend! $(git log -1 --format=%s HEAD~)
+
+	$(get_commit_msg HEAD~)
+
+	edited 1
+
+	edited 2
+	EOF
+	echo "reword new commit message" >actual &&
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_AMEND="edited 1" \
+			git commit --fixup=reword:HEAD~ &&
+		FAKE_COMMIT_AMEND="edited 2" \
+			git commit --fixup=reword:HEAD
+	) &&
+	get_commit_msg HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'deny to create amend! commit if its commit msg body is empty' '
+	commit_for_rebase_autosquash_setup &&
+	echo "Aborting commit due to empty commit message body." >expected &&
+	(
+		set_fake_editor &&
+		test_must_fail env FAKE_COMMIT_MESSAGE="amend! target message subject line" \
+			git commit --fixup=amend:HEAD~ 2>actual
+	) &&
+	test_cmp expected actual
+'
+
+test_expect_success 'amend! commit allows empty commit msg body with --allow-empty-message' '
+	commit_for_rebase_autosquash_setup &&
+	cat >expected <<-EOF &&
+	amend! $(git log -1 --format=%s HEAD~)
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_COMMIT_MESSAGE="amend! target message subject line" \
+			git commit --fixup=amend:HEAD~ --allow-empty-message &&
+		get_commit_msg HEAD >actual
+	) &&
+	test_cmp expected actual
+'
+
+test_fixup_reword_opt () {
+	test_expect_success C_LOCALE_OUTPUT "--fixup=reword: incompatible with $1" "
+		echo 'fatal: cannot combine reword option of --fixup with $1' >expect &&
+		test_must_fail git commit --fixup=reword:HEAD~ $1 2>actual &&
+		test_cmp expect actual
+	"
+}
+
+for opt in --all --include --only --interactive --patch
+do
+	test_fixup_reword_opt $opt
+done
+
+test_expect_success '--fixup=reword: give error with pathsec' '
+	commit_for_rebase_autosquash_setup &&
+	echo "fatal: cannot combine reword option of --fixup with paths" >expect &&
+	test_must_fail git commit --fixup=reword:HEAD~ -- foo 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--fixup=reword: -F give error message' '
+	echo "fatal: Only one of -c/-C/-F/--fixup can be used." >expect &&
+	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
+	test_cmp expect actual
+'
 
 test_expect_success 'commit --squash works with -F' '
 	commit_for_rebase_autosquash_setup &&
-- 
2.29.0.rc1


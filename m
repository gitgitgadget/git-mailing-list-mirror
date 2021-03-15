Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40C1C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD70D64E49
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 07:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCOH40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 03:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhCOH4B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 03:56:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15B6C061574
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:56:00 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x21so4737301pfa.3
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=edTsZ60Zi8Uq977DHpqX32yiQmjeakSoKWVWgEQLZWg=;
        b=rgjOEU2JU5yxOIzdkJ2KwD4f95Ow9OR+zewdjx46XT0Iweo1lSdQzyUG0yHU+y2m5X
         gMeLj/3wzIgOrGdCLC5bs6Lf9Y2/Y13aG4EQ8dc04WzK7FZ2RBdxMChMTGj17/nJNJNR
         Z7QNb5E5prGF1DdhviMlKEMEHhb7MQmxqBG+/TTUjh48SbAemPUR7as4noqgy24X4y8r
         oDPeqBJbnW/3zLk3y4HuP8b8ZPq6TLX8pSF7mclScDW01qQycuy3grkczY3nwXeT3qMh
         XaluytqiRn/cXX816LDbNhp3Re0YHD6Pi9a6AawRKVvD5luk76Tw92RlkL7VZUNznzK1
         HmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edTsZ60Zi8Uq977DHpqX32yiQmjeakSoKWVWgEQLZWg=;
        b=tZogKdAT3aUQQSNqIFdW4ehAWcy8ZWREUhfsN+5ovTrp/840j59D8QjGv/mFZ+mdF8
         TODvdo0mwdYV9d3JFJoFAEWOn1llH8/QP6UH10vdwWVnynE/zMqJ1bP/WUVsexMlc6pt
         OF3C69IdUhRtYkVWUOG+4Iaj7CT9QOQNhN83bkrDEXD3rOsHQYDnanaG7So6PNxcrSHV
         POJI5ME1tzkFAdxfvyOHRMy4lNcKguCsTuSO+lSlZALT02b2fOtlLqBJswJspXT2abja
         ky+nO7hYyW0TGJPt3/iV65mHK9p1uGxe0gspbkXJ0BLLYfnH9TdPhJUaLil8onIBo71i
         gtVw==
X-Gm-Message-State: AOAM531l4J2rXQauJoQlr4ufPpSZhAjGWSG2oP2UesfbVzkbIsWpwujF
        xlrVCvVfJ4anjz5dVjBCcp58zG0Acenbhw==
X-Google-Smtp-Source: ABdhPJzIjLBzsNEjSv0HtVZdP5DOXQ2nSXEsGUa+JD2h8CPMCICtsSxp3Vu4dQntDtH2wegDouILMg==
X-Received: by 2002:a62:1b01:0:b029:1f2:561e:e588 with SMTP id b1-20020a621b010000b02901f2561ee588mr9150626pfb.55.1615794960235;
        Mon, 15 Mar 2021 00:56:00 -0700 (PDT)
Received: from localhost.localdomain ([223.233.99.139])
        by smtp.googlemail.com with ESMTPSA id fs9sm9350911pjb.40.2021.03.15.00.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 00:56:00 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v6 4/6] t7500: add tests for --fixup=[amend|reword] options
Date:   Mon, 15 Mar 2021 13:24:34 +0530
Message-Id: <20210315075435.18229-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210310194306.32565-1-charvi077@gmail.com>
References: <20210310194306.32565-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7500-commit-template-squash-signoff.sh | 159 ++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 6d19ece05d..05e43a31d3 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -9,6 +9,8 @@ Tests for template, signoff, squash and -F functions.'
 
 . ./test-lib.sh
 
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
 commit_msg_is () {
 	expect=commit_msg_is.expect
 	actual=commit_msg_is.actual
@@ -279,6 +281,163 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '
 
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
+test_expect_success '--fixup=amend: --only ignores staged changes' '
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
+			git commit --fixup=amend:HEAD~ --only
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
+test_expect_success '--fixup=reword: ignores staged changes' '
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
+		echo 'fatal: reword option of --fixup is mutually exclusive with'\
+			'--patch/--interactive/--all/--include/--only' >expect &&
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
+	echo "fatal: cannot combine reword option of --fixup with path '\''foo'\''" >expect &&
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


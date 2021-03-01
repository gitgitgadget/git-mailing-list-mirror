Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C4EC433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A7264DF2
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 08:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhCAIts (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 03:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbhCAIrk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 03:47:40 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1131C06121E
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 00:46:49 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id l2so11091738pgb.1
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 00:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=5fAbtlR263x+jVai0ez7OLPSNnNsRFJly2JTIe69cYo=;
        b=HXAFyBPLN/SIuHaWmgBIJfBjHQ2tM+kb5u5+ulsiibKSrodC6LZnSBWq4JqPGdCQYN
         VFwmjIX64hCl8gOZ2Coi8wZybUELqHoBiAd3AP6P0M4A2Val8jR0u8BM5xQUlAcLW0Z0
         DE2EoZfvbixzSPdVs8Gu7l80CiF9LUdxU73YjZgrRuSXSNpeC0wJwu1xLKnETMAkoIc2
         2VRCJ8jATnqGnANFzZS2OwWPIdUkQXnX7eudUymYJgnLUyEQx09xAMZr9Ldwq4Nn0v6n
         DAjR0+vKOwXkVza1UVYv4F0f45I4k2vHRpdjIX9lH8ARz+TgMBDo+t6/UsgkGmBEJ/zQ
         40uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=5fAbtlR263x+jVai0ez7OLPSNnNsRFJly2JTIe69cYo=;
        b=BOKmUTgp2lPY4XhXnCnGsIFko9zy3Bct/lRTteJxZLHqmsIf3DojaeF4cq+fRwDeK5
         Vz+SeSL7bUpk2YsCd8SxY+c6Z9a+hdkNJ4rEbNkERhrfnTQfGmjJAK6vO3S6ilJsXGJu
         gFOe/TeInEYSn6eIhi/mIuTJVFcenEt8zP2cdFuWXzcgHtnUa54ewR0RcpthMIIub+Fr
         L8I+KmpTsq6EMqhQ5R5MY8CDn9tMVcB+CmoE9JNNmyYm0nkEUvKzfSwgrCZ4bvC+EuCx
         6a8zfN1iMDdL5+NPUgXbtvp4LU/vi23rU/Cyjh7zQdyQhJXiiQP1b2ekPqOz+8EGVS9X
         +IdA==
X-Gm-Message-State: AOAM531KLHYCd/M4QG1S8dyaFw3pFDdyr+EboLsr8zC56dkss46mYFes
        6gxYvcBccUDS//NiEsiMA/YFvycknJfvAA==
X-Google-Smtp-Source: ABdhPJyzpPg4+J017laNdE1xgW35BRpD5/ruEETY5R0VRTQXhZNhe44YSLpXNndA2cIOpm5GuZfjcw==
X-Received: by 2002:aa7:84d4:0:b029:1ee:44a4:d29c with SMTP id x20-20020aa784d40000b02901ee44a4d29cmr12391185pfn.81.1614588409250;
        Mon, 01 Mar 2021 00:46:49 -0800 (PST)
Received: from localhost.localdomain ([2405:204:302d:d8af:c047:a272:aff7:4de6])
        by smtp.googlemail.com with ESMTPSA id b34sm16781426pgl.63.2021.03.01.00.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 00:46:48 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 4/6] t7500: add tests for --fixup=[amend|reword] options
Date:   Mon,  1 Mar 2021 14:15:12 +0530
Message-Id: <20210301084512.27170-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210301084512.27170-1-charvi077@gmail.com>
References: <20210301084512.27170-1-charvi077@gmail.com>
Reply-To: 20210217072904.16257-1-charvi077@gmail.com
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
index 6d19ece05d..e62b7fbc1a 100755
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
+	echo "fatal: cannot combine reword option of --fixup with path foo" >expect &&
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


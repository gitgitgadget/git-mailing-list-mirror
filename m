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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C287C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0808D64E04
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 07:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhBQHkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 02:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhBQHjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 02:39:25 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60036C061786
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:38:45 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z68so7981090pgz.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 23:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVBZn3zIAcGTQv5oIPrUkQjGfVoY3iuQXa7woV14EOE=;
        b=Di0IWl/f/MGF8IiVVvwzdylG9EV4X+DqxlmFzupYbR5a1o+h7K691Dkn1ySMUqx4LC
         8SGsAsVZ1BrPQE2NOhJMI3nZ+n4qydqWbjZWlyisb0++mk3p82OL5s5xhLoKorJ+e1Io
         jo/X2ZwuMAjdNtm0NAqB+WRXls6qOLqOJZg/HMDTHouFEUdT/us7x4ngYBQZU0vMJs0L
         /4X7igek1ZoKAB/kf/wxXk9tZiFzeb8FwYFHOQ3RAAuDth6kqLD6A1tUGWqR5l+pjkc/
         IrJYK1OOG6zaqkUNG9LWCiScpixGXXvJ8vnNv+Os/a8zAdK+QotisghfBmCsraSPNpN2
         Fitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVBZn3zIAcGTQv5oIPrUkQjGfVoY3iuQXa7woV14EOE=;
        b=feFdrY5peoEh7H5am1jEVdachIEeThydZlxgJtR9S7g0Bbjbtja/IuEZWZBt5bq6Pb
         DrXs86HyLyMJ7cBVn2ic7N3Gs9PfHGe4e/SlqppReNAS3N+UzP6thY8jbzFRR/Y4Zp6S
         Mf5UPsFCEXcDebK7+ZP/n/bXC2QgVS5y1TtwAFb+sVBkDxw6mFp06v3oPaHTuBbtGRXB
         lLaQBj4xjEPsFT2Gt0xOimYT+TaP/cAXi8MByEkd6w3LrFm/CUE0fVqGTPsGxfhHchPu
         Y6Gtf23GKLQ0bFQwJ1QUAGXtNQuVnV5xMLEhBpAlHo7v6N4SZGCH+eRReeCwSlFy0o5P
         nvmA==
X-Gm-Message-State: AOAM5312y2RnnI9FE4hx79Ji7GRqFk9WkJzyKKFC3YXmLLDV6CgB26OZ
        Ql6Jrl2ftGh+RJ5lzjYZVRPiUiaK/zCH5w==
X-Google-Smtp-Source: ABdhPJyJoF6sCcMdxB7p7TJ7somntyb6rmHrLkodJvmpSB2HsSlrOCpsfbHwZx11G6VrVP0tSH1wCQ==
X-Received: by 2002:a62:b410:0:b029:1a4:7868:7e4e with SMTP id h16-20020a62b4100000b02901a478687e4emr1626986pfn.62.1613547524745;
        Tue, 16 Feb 2021 23:38:44 -0800 (PST)
Received: from localhost.localdomain ([106.201.18.198])
        by smtp.googlemail.com with ESMTPSA id b3sm1352615pgd.48.2021.02.16.23.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 23:38:44 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 4/6] t7500: add tests for --fixup[amend|reword] options
Date:   Wed, 17 Feb 2021 13:07:23 +0530
Message-Id: <20210217073725.16656-4-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210217073725.16656-1-charvi077@gmail.com>
References: <20210217072904.16257-1-charvi077@gmail.com>
 <20210217073725.16656-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7500-commit-template-squash-signoff.sh | 118 ++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 6d19ece05d..d2c34019c0 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -9,6 +9,8 @@ Tests for template, signoff, squash and -F functions.'
 
 . ./test-lib.sh
 
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
 commit_msg_is () {
 	expect=commit_msg_is.expect
 	actual=commit_msg_is.actual
@@ -279,6 +281,122 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '
 
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
+test_expect_success '--fixup=reword: works with -m option' '
+	commit_for_rebase_autosquash_setup &&
+	cat >expected <<-EOF &&
+	amend! target message subject line
+
+	reword commit message
+	EOF
+	git commit --fixup=reword:HEAD~ -m "reword commit message" &&
+	get_commit_msg HEAD >actual &&
+	test_cmp expected actual
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
+	test_must_fail git commit --fixup=amend:HEAD~ -m " " 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'amend! commit allows empty commit msg body with --allow-empty-message' '
+	commit_for_rebase_autosquash_setup &&
+	cat >expected <<-EOF &&
+	amend! $(git log -1 --format=%s HEAD~)
+	EOF
+	git commit --fixup=amend:HEAD~ -m " " --allow-empty-message &&
+	get_commit_msg HEAD >actual &&
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
+for opt in --all --include --only
+do
+	test_fixup_reword_opt $opt
+done
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


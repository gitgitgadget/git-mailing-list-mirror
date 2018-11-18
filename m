Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_BLACK,URIBL_DBL_SPAM shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE201F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 13:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeKSAFA (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 19:05:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34689 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeKSAFA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 19:05:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so893348wrw.1
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 05:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8Qk5TxfpjxricpaOmVaatdRpR8XdgQqTCqyhEjjd6I=;
        b=sunj/XULFUcI4Cm523ItMmeSoqpg4gNC6jORdr7fjXLWZ7g4r8Bch/yozdMtFT0bKD
         HCCrg2mHsrA7D3UV2reO47kDzDil6HBL8RkmZVfigQevIHNU80rggmusDv4MDnHmSgkh
         ZJ7UiFnhMGdFBEQyfySXUYAAm98rAciPxA0bypdllyaVoCCjfPp9zZVkeZwThCh2crg9
         ZZ56m5TSkL8dClimH+ve0WrUtYhZMZJD51vjooqNJKfGT35xbJLzqG2bLQ6+ZfuILxcD
         H+o8mQIr6/ssO1UMMz63Qo7yEB4QSf5+M0X6EIk9w5f6hzIa85wAMbNLidR1PD/m7odX
         mLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8Qk5TxfpjxricpaOmVaatdRpR8XdgQqTCqyhEjjd6I=;
        b=L1CgtCfG+gt+Y0L0i6a18fCw1WAowrmd96QvspllaTP7JOZfi2PehPF08BztqOxtml
         93vhIVttCngErGvEGnrAgkFeog9geHSngPCoeAGdHpqBfsiLgZnx2ojIsPT/iyXeAE12
         F7OmV7XU47jBcJEO00MtqKnRVZkFeykL2lrnTuqAD8N7l/8mmUAcOjWkZKyPtg7ImV8Q
         fVfAS/m172WJN2k36VqAjKE/heY5Lb86axsPC01L/tUJlZQsWxwVRyGyLYsnpaVwc523
         xOAf+bCWt7p9HTEPb3P+TVwUcMjqyQe8JeqDZO7ALFd8V+u9HGqVT5O0nGS02IfaXvO9
         JbAg==
X-Gm-Message-State: AGRZ1gIWO0j4xjRJzcCjGq/xL29ENRF9DwIpOOUzsxVw02/cp8cdzL0Q
        Xf0UXseBNMSOFNS+2nSU5Gk=
X-Google-Smtp-Source: AJdET5cUiilyNwup/jSFDVL5VRgjPjYFI/ic+lz5uVqcq3FrczObzlOSvM2dUtKCNre1J3Rj/6v1Fg==
X-Received: by 2002:a05:6000:8a:: with SMTP id m10mr14709388wrx.79.1542548677238;
        Sun, 18 Nov 2018 05:44:37 -0800 (PST)
Received: from localhost.localdomain ([31.223.156.141])
        by smtp.gmail.com with ESMTPSA id a12sm18160848wro.18.2018.11.18.05.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 05:44:36 -0800 (PST)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/1 v3] stash: tolerate missing user identity
Date:   Sun, 18 Nov 2018 14:44:07 +0100
Message-Id: <20181118134407.11196-1-slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.1052.gd166e6afe
In-Reply-To: <20181118132915.9336-1-slawica92@hotmail.com>
References: <20181118132915.9336-1-slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git stash" command insists on having a usable user identity to
the same degree as the "git commit-tree" and "git commit" commands
do, because it uses the same codepath that creates commit objects
as these commands.

It is not strictly necesary to do so. Check if we will barf before
creating commit objects and then supply fake identity to please the
machinery that creates commits.
Add test to document that stash executes correctly both with and
without valid ident.

This is not that much of usability improvement, as the users who run
"git stash" would eventually want to record their changes that are
temporarily stored in the stashes in a more permanent history by
committing, and they must do "git config user.{name,email}" at that
point anyway, so arguably this change is only delaying a step that
is necessary to work in the repository.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 git-stash.sh     | 17 +++++++++++++++++
 t/t3903-stash.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index 94793c1a9..789ce2f41 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -55,6 +55,20 @@ untracked_files () {
 	git ls-files -o $z $excl_opt -- "$@"
 }
 
+prepare_fallback_ident () {
+	if ! git -c user.useconfigonly=yes var GIT_COMMITTER_IDENT >/dev/null 2>&1
+	then
+		GIT_AUTHOR_NAME="git stash"
+		GIT_AUTHOR_EMAIL=git@stash
+		GIT_COMMITTER_NAME="git stash"
+		GIT_COMMITTER_EMAIL=git@stash
+		export GIT_AUTHOR_NAME
+		export GIT_AUTHOR_EMAIL
+		export GIT_COMMITTER_NAME
+		export GIT_COMMITTER_EMAIL
+	fi
+}
+
 clear_stash () {
 	if test $# != 0
 	then
@@ -67,6 +81,9 @@ clear_stash () {
 }
 
 create_stash () {
+
+	prepare_fallback_ident
+
 	stash_msg=
 	untracked=
 	while test $# != 0
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index cd216655b..5f8272b6f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1096,4 +1096,32 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
+test_expect_success 'stash works when user.name and user.email are not set' '
+	git reset &&
+	>1 &&
+	git add 1 &&
+	echo "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >expect &&
+	git stash &&
+	git show -s --format="%an <%ae>" refs/stash >actual &&
+	test_cmp expect actual &&
+	>2 &&
+	git add 2 &&
+	test_config user.useconfigonly true &&
+	test_config stash.usebuiltin true &&
+	(
+		sane_unset GIT_AUTHOR_NAME &&
+		sane_unset GIT_AUTHOR_EMAIL &&
+		sane_unset GIT_COMMITTER_NAME &&
+		sane_unset GIT_COMMITTER_EMAIL &&
+		test_unconfig user.email &&
+		test_unconfig user.name &&
+		test_must_fail git commit -m "should fail" &&
+		echo "git stash <git@stash>" >expect &&
+		>2 &&
+		git stash &&
+		git show -s --format="%an <%ae>" refs/stash >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.19.1.1052.gd166e6afe


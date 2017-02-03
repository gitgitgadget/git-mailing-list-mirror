Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BC6E1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbdBCCuJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:50:09 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33861 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbdBCCtU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:20 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so1187513wmi.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKb96PvwvzFumBzgKPrHqoPT0WEiGwTYAmci2yPCvKw=;
        b=tCK7T++tUhZ7wZv+zoeurW+xOLwFmGevb3unMnIygEWExowIYUjWpv8MWr1/VG3Ebk
         N0KwrtnuwU/b5i4zDlf/jQ8i858Sd6NHh4jpePhtjChORqZSLJwakyQ4zg0FykxlDeAz
         dgzAgv/DMdBRCyVapOWgWV4+SXme54GxTDuTJEBDIv4k4BHaP6IXk0IRJEUIdi1Z+JNi
         TmR7MD362VPPEFdLp4LEmqprsN+ujQ66tbttn18Mdo6/XGCVgdrI9rIdWSS6jNQIog2C
         /qOiKhxrqiH7XjAUkfw68aSlVBpFLto+bq6+oX3Dbc0iB9h+/ZQBXXdDOHPNr19vUuL7
         ylXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKb96PvwvzFumBzgKPrHqoPT0WEiGwTYAmci2yPCvKw=;
        b=kMLnhymf7DvVoPCPAceDZZYH3gFzoJv2gmldEyxmlr28jYf2z1dTtEssjNmkzsS24j
         tjMHmhhyFWxFz/iJgMtivaxo/PL+m2Ou7IrknsEWW7FMKFowLhC1W1At2zllQ8CKiaFO
         VYBb4VuoZFbND3GQm3LcLGx0UB6pX9tH87UZlTIfFuJjRySMGNiT1gLpWrloFKN0F/OI
         WcZcJtCOzK0y+X+vHeO0geQ7mEgefn7bxph2Rc35YOznmPt/UDxpo8DAb+AcLuC0V/OB
         WBrv2YHZyZt9WH2aSrvfYML7ZOLXbfLbdbXfuZof82hNhwGyegrmjNDx4D2k/EMr/2mV
         XX4w==
X-Gm-Message-State: AIkVDXKVdu/Ex4SUs7UtHtm1GIdPpMDJn0Wbun2VX+EMCC50bSA8Bwuc6KXFyIX6FJEYMA==
X-Received: by 10.223.170.70 with SMTP id q6mr10132664wrd.103.1486090159085;
        Thu, 02 Feb 2017 18:49:19 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:18 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 06/21] completion tests: add tests for the __git_refs() helper function
Date:   Fri,  3 Feb 2017 03:48:14 +0100
Message-Id: <20170203024829.8071-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Check how __git_refs() lists refs in different scenarios, i.e.

  - short and full refs,
  - from a local or from a remote repository,
  - remote specified via path, name or URL,
  - with or without a repository specified on the command line,
  - non-existing remote,
  - unique remote branches for 'git checkout's tracking DWIMery,
  - not in a git repository, and
  - interesting combinations of the above.

Seven of these tests expect failure, mostly demonstrating bugs related
to listing refs from a remote repository:

  - ignoring the repository specified on the command line (2 tests),
  - listing refs from the wrong place when the name of a configured
    remote happens to match a directory,
  - listing only 'HEAD' but no short refs from a remote given as URL,
  - listing 'HEAD' even from non-existing remotes (2 tests), and
  - listing 'HEAD' when not in a repository.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9902-completion.sh | 265 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 264 insertions(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f7f7d49fb..7956cb9b1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -365,6 +365,269 @@ test_expect_success '__git_remotes - list remotes from $GIT_DIR/remotes and from
 	test_cmp expect actual
 '
 
+test_expect_success 'setup for ref completion' '
+	git commit --allow-empty -m initial &&
+	git branch matching-branch &&
+	git tag matching-tag &&
+	(
+		cd otherrepo &&
+		git commit --allow-empty -m initial &&
+		git branch -m master master-in-other &&
+		git branch branch-in-other &&
+		git tag tag-in-other
+	) &&
+	git remote add other "$ROOT/otherrepo/.git" &&
+	git fetch --no-tags other &&
+	rm -f .git/FETCH_HEAD &&
+	git init thirdrepo
+'
+
+test_expect_success '__git_refs - simple' '
+	cat >expected <<-EOF &&
+	HEAD
+	master
+	matching-branch
+	other/branch-in-other
+	other/master-in-other
+	matching-tag
+	EOF
+	(
+		cur= &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - full refs' '
+	cat >expected <<-EOF &&
+	refs/heads/master
+	refs/heads/matching-branch
+	EOF
+	(
+		cur=refs/heads/ &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - repo given on the command line' '
+	cat >expected <<-EOF &&
+	HEAD
+	branch-in-other
+	master-in-other
+	tag-in-other
+	EOF
+	(
+		__git_dir="$ROOT/otherrepo/.git" &&
+		cur= &&
+		__git_refs >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - remote on local file system' '
+	cat >expected <<-EOF &&
+	HEAD
+	branch-in-other
+	master-in-other
+	tag-in-other
+	EOF
+	(
+		cur= &&
+		__git_refs otherrepo >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - remote on local file system - full refs' '
+	cat >expected <<-EOF &&
+	refs/heads/branch-in-other
+	refs/heads/master-in-other
+	refs/tags/tag-in-other
+	EOF
+	(
+		cur=refs/ &&
+		__git_refs otherrepo >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - configured remote' '
+	cat >expected <<-EOF &&
+	HEAD
+	branch-in-other
+	master-in-other
+	EOF
+	(
+		cur= &&
+		__git_refs other >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - configured remote - full refs' '
+	cat >expected <<-EOF &&
+	refs/heads/branch-in-other
+	refs/heads/master-in-other
+	refs/tags/tag-in-other
+	EOF
+	(
+		cur=refs/ &&
+		__git_refs other >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure '__git_refs - configured remote - repo given on the command line' '
+	cat >expected <<-EOF &&
+	HEAD
+	branch-in-other
+	master-in-other
+	EOF
+	(
+		cd thirdrepo &&
+		__git_dir="$ROOT/.git" &&
+		cur= &&
+		__git_refs other >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure '__git_refs - configured remote - full refs - repo given on the command line' '
+	cat >expected <<-EOF &&
+	refs/heads/branch-in-other
+	refs/heads/master-in-other
+	refs/tags/tag-in-other
+	EOF
+	(
+		cd thirdrepo &&
+		__git_dir="$ROOT/.git" &&
+		cur=refs/ &&
+		__git_refs other >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure '__git_refs - configured remote - remote name matches a directory' '
+	cat >expected <<-EOF &&
+	HEAD
+	branch-in-other
+	master-in-other
+	EOF
+	mkdir other &&
+	test_when_finished "rm -rf other" &&
+	(
+		cur= &&
+		__git_refs other >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure '__git_refs - URL remote' '
+	cat >expected <<-EOF &&
+	HEAD
+	branch-in-other
+	master-in-other
+	tag-in-other
+	EOF
+	(
+		cur= &&
+		__git_refs "file://$ROOT/otherrepo/.git" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success '__git_refs - URL remote - full refs' '
+	cat >expected <<-EOF &&
+	refs/heads/branch-in-other
+	refs/heads/master-in-other
+	refs/tags/tag-in-other
+	EOF
+	(
+		cur=refs/ &&
+		__git_refs "file://$ROOT/otherrepo/.git" >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_failure '__git_refs - non-existing remote' '
+	(
+		cur= &&
+		__git_refs non-existing >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
+test_expect_success '__git_refs - non-existing remote - full refs' '
+	(
+		cur=refs/ &&
+		__git_refs non-existing >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
+test_expect_failure '__git_refs - non-existing URL remote' '
+	(
+		cur= &&
+		__git_refs "file://$ROOT/non-existing" >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
+test_expect_success '__git_refs - non-existing URL remote - full refs' '
+	(
+		cur=refs/ &&
+		__git_refs "file://$ROOT/non-existing" >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
+test_expect_failure '__git_refs - not in a git repository' '
+	(
+		GIT_CEILING_DIRECTORIES="$ROOT" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd subdir &&
+		cur= &&
+		__git_refs >"$actual"
+	) &&
+	test_must_be_empty "$actual"
+'
+
+test_expect_success '__git_refs - unique remote branches for git checkout DWIMery' '
+	cat >expected <<-EOF &&
+	HEAD
+	master
+	matching-branch
+	other/ambiguous
+	other/branch-in-other
+	other/master-in-other
+	remote/ambiguous
+	remote/branch-in-remote
+	matching-tag
+	branch-in-other
+	branch-in-remote
+	master-in-other
+	EOF
+	for remote_ref in refs/remotes/other/ambiguous \
+		refs/remotes/remote/ambiguous \
+		refs/remotes/remote/branch-in-remote
+	do
+		git update-ref $remote_ref master &&
+		test_when_finished "git update-ref -d $remote_ref"
+	done &&
+	(
+		cur= &&
+		__git_refs "" 1 >"$actual"
+	) &&
+	test_cmp expected "$actual"
+'
+
+test_expect_success 'teardown after ref completion' '
+	git branch -d matching-branch &&
+	git tag -d matching-tag &&
+	git remote remove other
+'
+
 test_expect_success '__git_get_config_variables' '
 	cat >expect <<-EOF &&
 	name-1
@@ -483,7 +746,7 @@ test_expect_success 'git --help completion' '
 	test_completion "git --help core" "core-tutorial "
 '
 
-test_expect_success 'setup for ref completion' '
+test_expect_success 'setup for integration tests' '
 	echo content >file1 &&
 	echo more >file2 &&
 	git add file1 file2 &&
-- 
2.11.0.555.g967c1bcb3


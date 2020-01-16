Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1D8C33CB3
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52B82081E
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQfydVPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgAPGOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:53 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52360 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbgAPGOo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:44 -0500
Received: by mail-wm1-f46.google.com with SMTP id p9so2449041wmc.2
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QDbhLq+anCcBMZ0842z90xgm8GuAOJH2crkKX3N2XTU=;
        b=qQfydVPuDjNjLWBP627xgSKFENAdfLLnn1HTf57wDw1I6hFLZphLYhXw/IMB8AKl0m
         +qOs8X+8IyEYhOdwZBrIu/WjFfcb2R6JNPTH1rDwhn7yvz7XhCKWv5uAdRyQJDkXmMbf
         vbQUSXWn9Has91vsTC41I+drTM3V7nhLKm15vr5HS0QWV66sev2RfO6449TDBTpCIyQ7
         B3lT7XmSS3edVW6E1HreAfOz8zMwDmXOC5PaZNI9Q1xgOg7iJnKPIx+5b6S2BxYUUe2F
         ZRVa6mVp7bgdvnhnSlqyKoa5XaYSCJUwdOT+vOr5SEC4cCRFqsInZMToEw5JKZCnqPjb
         Nzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QDbhLq+anCcBMZ0842z90xgm8GuAOJH2crkKX3N2XTU=;
        b=sze3AvcPg4NIVZusQjchhBAGPZvZgVMyyEEy5aVn4z9Yk9IjzGTvwiL3FYdHgGbpu1
         gZWExdB1Sng7AykxCgzypZMLpsw9TbdMNbaq+b8vzL2W9yruq/0sLTLKtOPqnvxTLh44
         OOkmT/D315zb99gd2CiqDiAqVELhtO9id/2ycGOvn0WFVttrHv90IHP7+knxcZxRra5g
         9Zr31nKsHZkT+TzsUWsbmxSVC5Bpeaz/HlRwGlGL1MrFyyxxKZwgfTgW/hV9BUeBYWi0
         E1OzP8yXhXxI6N33ucd+8r68dk3pP0iaY5INq8se12bZ0bAHYrz6WwbWdstNnUAN78jT
         WWOw==
X-Gm-Message-State: APjAAAWvG1hznPmk1I93FLmWMvhO8mLbzz4Bsbn3g+6LBcAg2Dq4NO4g
        tjFRyR6WxSv9b1bzIh45INMDbMa6
X-Google-Smtp-Source: APXvYqx6gsdjsKth6i9HRas4y8+3zorPHZZRXV2nxPc7WN2+HmNifam0l5rCKXmlpbJRiyERzMOk3Q==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr3975879wmb.76.1579155282370;
        Wed, 15 Jan 2020 22:14:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r62sm3550797wma.32.2020.01.15.22.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:41 -0800 (PST)
Message-Id: <8c5b5b5133097de0b932a3bbfe1dc4709e3c49c7.1579155273.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:23 +0000
Subject: [PATCH v4 09/19] t3432: make these tests work with either am or merge
 backends
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

t3432 had several stress tests for can_fast_forward(), whose intent was
to ensure we were using the optimization of just fast forwarding when
possible.  However, these tests verified that fast forwards had happened
based on the output that rebase printed to the terminal.  We can instead
test more directly that we actually fast-forwarded by checking the
reflog, which also has the side effect of making the tests applicable
for the merge/interactive backend.

This change does lose the distinction between "noop" and "noop-force",
but as stated in commit c9efc216830f ("t3432: test for --no-ff's
interaction with fast-forward", 2019-08-27) which introduced that
distinction: "These tests aren't supposed to endorse the status quo,
just test for what we're currently doing.".

This change does not actually run these tests with the merge/interactive
backend; instead this is just a preparatory commit.  A subsequent commit
which fixes can_fast_forward() to work with that backend will then also
change t3432 to add tests of that backend as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3432-rebase-fast-forward.sh | 48 ++++++++++++++++------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 92f95b57da..7432c0e241 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -44,19 +44,15 @@ test_rebase_same_head_ () {
 	test_expect_$status "git rebase$flag $* with $changes is $what with $cmp HEAD" "
 		oldhead=\$(git rev-parse HEAD) &&
 		test_when_finished 'git reset --hard \$oldhead' &&
+		cp .git/logs/HEAD expect &&
 		git rebase$flag $* >stdout &&
 		if test $what = work
 		then
-			# Must check this case first, for 'is up to
-			# date, rebase forced[...]rewinding head' cases
-			test_i18ngrep 'rewinding head' stdout
+			old=\$(wc -l <expect) &&
+			test_line_count '-gt' \$old .git/logs/HEAD
 		elif test $what = noop
 		then
-			test_i18ngrep 'is up to date' stdout &&
-			test_i18ngrep ! 'rebase forced' stdout
-		elif test $what = noop-force
-		then
-			test_i18ngrep 'is up to date, rebase forced' stdout
+			test_cmp expect .git/logs/HEAD
 		fi &&
 		newhead=\$(git rev-parse HEAD) &&
 		if test $cmp = same
@@ -71,14 +67,14 @@ test_rebase_same_head_ () {
 
 changes='no changes'
 test_rebase_same_head success noop same success work same
-test_rebase_same_head success noop same success noop-force same master
-test_rebase_same_head success noop same success noop-force diff --onto B B
-test_rebase_same_head success noop same success noop-force diff --onto B... B
-test_rebase_same_head success noop same success noop-force same --onto master... master
-test_rebase_same_head success noop same success noop-force same --keep-base master
-test_rebase_same_head success noop same success noop-force same --keep-base
-test_rebase_same_head success noop same success noop-force same --no-fork-point
-test_rebase_same_head success noop same success noop-force same --keep-base --no-fork-point
+test_rebase_same_head success noop same success work same master
+test_rebase_same_head success noop same success work diff --onto B B
+test_rebase_same_head success noop same success work diff --onto B... B
+test_rebase_same_head success noop same success work same --onto master... master
+test_rebase_same_head success noop same success work same --keep-base master
+test_rebase_same_head success noop same success work same --keep-base
+test_rebase_same_head success noop same success work same --no-fork-point
+test_rebase_same_head success noop same success work same --keep-base --no-fork-point
 test_rebase_same_head success noop same success work same --fork-point master
 test_rebase_same_head success noop same success work diff --fork-point --onto B B
 test_rebase_same_head success noop same success work diff --fork-point --onto B... B
@@ -91,14 +87,14 @@ test_expect_success 'add work same to side' '
 
 changes='our changes'
 test_rebase_same_head success noop same success work same
-test_rebase_same_head success noop same success noop-force same master
-test_rebase_same_head success noop same success noop-force diff --onto B B
-test_rebase_same_head success noop same success noop-force diff --onto B... B
-test_rebase_same_head success noop same success noop-force same --onto master... master
-test_rebase_same_head success noop same success noop-force same --keep-base master
-test_rebase_same_head success noop same success noop-force same --keep-base
-test_rebase_same_head success noop same success noop-force same --no-fork-point
-test_rebase_same_head success noop same success noop-force same --keep-base --no-fork-point
+test_rebase_same_head success noop same success work same master
+test_rebase_same_head success noop same success work diff --onto B B
+test_rebase_same_head success noop same success work diff --onto B... B
+test_rebase_same_head success noop same success work same --onto master... master
+test_rebase_same_head success noop same success work same --keep-base master
+test_rebase_same_head success noop same success work same --keep-base
+test_rebase_same_head success noop same success work same --no-fork-point
+test_rebase_same_head success noop same success work same --keep-base --no-fork-point
 test_rebase_same_head success noop same success work same --fork-point master
 test_rebase_same_head success noop same success work diff --fork-point --onto B B
 test_rebase_same_head success noop same success work diff --fork-point --onto B... B
@@ -112,8 +108,8 @@ test_expect_success 'add work same to upstream' '
 '
 
 changes='our and their changes'
-test_rebase_same_head success noop same success noop-force diff --onto B B
-test_rebase_same_head success noop same success noop-force diff --onto B... B
+test_rebase_same_head success noop same success work diff --onto B B
+test_rebase_same_head success noop same success work diff --onto B... B
 test_rebase_same_head success noop same success work diff --onto master... master
 test_rebase_same_head success noop same success work diff --keep-base master
 test_rebase_same_head success noop same success work diff --keep-base
-- 
gitgitgadget


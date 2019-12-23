Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688AAC2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D39D206CB
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKFveGNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfLWSuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:12 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:34027 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfLWSuH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:07 -0500
Received: by mail-ed1-f51.google.com with SMTP id l8so16132791edw.1
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QDbhLq+anCcBMZ0842z90xgm8GuAOJH2crkKX3N2XTU=;
        b=kKFveGNxd1RHG9BFDhnBc8L4Ap5A0umwHmsRenkk+Z7tAj/vYsGx12ockb2g73As+c
         dN1Aneqfp/fcsSlESObCqD5ilozJHU5PMujxmsTP5xUaDbLZBB4gwK/H/YkukkM+2H1w
         JxIg6JR8rZvFXTCXWHRBY5VSqJ/q3UFD9GSl39OOWSdQr8CYFcVcRHtOszoSLWVqizK6
         6r1amOFDd+zCBPRBcOsWqVuLu2BVBso4dgJmFYsJ2iU7is0awaghmfLlX537kHzX5MGr
         91q9kNtD1F7Rx3bsD7wqc/7W1z7Bes3CQ7M3B9ASVRw+aODOJKNX/sTK6ETXmvF+lBVy
         uGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QDbhLq+anCcBMZ0842z90xgm8GuAOJH2crkKX3N2XTU=;
        b=GeIkkjAcV982SuB/XQWR65NP7rXcPuFNeJiog18Q0YzDY1jxriwRJtCCzod3uk1JAe
         +nJ6sbC0p4Kj7Rmc8N6+fGQi1WkbDVOHDACXaUxnsiaShuX24sVt5nO1/gQqTX6f+k+0
         aq42Q0tCxjD3F326WGDorp6Cqs1BLQ+TODzbo9DgPKh/GHxqtRzdWSMdm5wz6+I/WChJ
         0PngjN4psQV4Gn5a1XZX4b90cZihhueeLbc8dxfrQDBvLHVh8A7DRb3M+u45lpIgixWx
         9b1XJmN3J07e44J2Vcx4LdenvgoSBACEmk1wUGMvEs3LtweMoQYZzqxt2jzyPStp3YqB
         r49g==
X-Gm-Message-State: APjAAAXJsseM2C7OEd48xSz6jZ+lDq9OVjBtuiq7TIAp3nu+x3/xaIRj
        KEYaUuofEXwHXXoD24iatIscpnfG
X-Google-Smtp-Source: APXvYqyMv1im42C+aEoxWCNu274rqJiwNDwKmE+iQ37WEH4426WHTgdR48ZTRmXfXRPM+PXhbQhu6Q==
X-Received: by 2002:a17:906:27d5:: with SMTP id k21mr33323086ejc.328.1577127005554;
        Mon, 23 Dec 2019 10:50:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20sm2320882edd.62.2019.12.23.10.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:05 -0800 (PST)
Message-Id: <34a69def330c2d0fc00f34b0897604c55bed1514.1577127000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:50 +0000
Subject: [PATCH v2 06/15] t3432: make these tests work with either am or merge
 backends
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
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


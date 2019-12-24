Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03966C2D0D2
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFBB206CB
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7nL0eHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfLXTzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:08 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:37708 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfLXTzH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:07 -0500
Received: by mail-ed1-f46.google.com with SMTP id cy15so18683762edb.4
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QDbhLq+anCcBMZ0842z90xgm8GuAOJH2crkKX3N2XTU=;
        b=r7nL0eHbYmEfljbRbnQjoaOHMV2YdvhoSxPi/tOV32LWD296V9JXYhLBGkE8cDpvbs
         +gSbLujrpOeRSYb6eiTe0vT1c7DVXKQj8p+grNlqjNHJwDxfy2YtJZ6e8QDN/ymr5DJu
         qMGJ3bxkcPtOfkqiacqviH7KJfsRH6vCkAKwq13c7+e2J2xwOow3it4d+96hm4e1vMlf
         eWiwm4sa34VDTG+L5Fz/KnnVMLQQWmFqnesO1zhHnZ28GHNbCYz7EVu8BY4F0Zed1tw4
         t+gykuRBjNcHrEJmlN3QdGWS5YqlUU++hqpytqAlDN3S5r23NabuCkf69BngGUI5+sU+
         xbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QDbhLq+anCcBMZ0842z90xgm8GuAOJH2crkKX3N2XTU=;
        b=TBm6QrYMEVz/t26iEgaOW6Ewq31z/uqNULX7RpMMS48o4m1hFRVnajSB0J0UVGrytE
         skZoOLa0Gx5NNQ/re1pUr2oxm4ZH/7iCw5Y2KbqO1A8XDPOE1YfBt4EwF5htF1ahUXK3
         1ZWBGoZAai3amippPmX2frj9gJ1wlVY0EkCTF6RaAKNMjPmfC0oOrtBNALnqjbfoboEI
         ru0g3c8O74g43chSoCkLujVqj4hdqcd9bD613lcHcmFbM7mGw0BPJej4GvWhn4cTzsfM
         oXnI4/GdNoMao0IM59BSrAniByJqJx6hI5XQwPcBnyVKuYJ7bL6UYGY1tYwrtFcTgFyS
         VmIA==
X-Gm-Message-State: APjAAAV/RJMcGidKdbS7cZ0weJYTHHHxEGUjC16YI+JoFJ//mZZoYpRr
        Iu28XwWDkwhRnz98CkGKp2UFyamu
X-Google-Smtp-Source: APXvYqy2IQbzLXn229piccPrx9Tqsn7eIlv5A9lNtHP5d4FUeePsF4SXj70/avUNXvwAoIZqE6xTFQ==
X-Received: by 2002:aa7:df09:: with SMTP id c9mr41034425edy.133.1577217305709;
        Tue, 24 Dec 2019 11:55:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m24sm2797153edr.83.2019.12.24.11.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:05 -0800 (PST)
Message-Id: <34a69def330c2d0fc00f34b0897604c55bed1514.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:50 +0000
Subject: [PATCH v3 06/15] t3432: make these tests work with either am or merge
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


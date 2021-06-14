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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2E6C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD3861241
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhFNRU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhFNRU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:20:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621DAC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:18:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l2so15391699wrw.6
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXDA/8Z0zzxn4DL43A0Gqmzqj/8i+ylUq11Lj7yXx7g=;
        b=TuDv4WaDRZAC5s0lII5oq/i3B50aK2EjTfsblUbjCI5dCTeVa04Gd2MBI9OtTURqp4
         ldPdOkBpsZ4FsN3t/WOUtIMsuKYnfM3Z17C2ALfB/awkxXLHPd66DmiCEo4Yp1TZO0nV
         xWL2FyWD5B67SuLVNKDrz2jKd7pRFzPaZNNkAcRUxZGIDwn/n2az9Rn8CJ/WMtNMYUft
         tQCrkVcyMV+4XrcY+y0nYZk0zmqNMtQB2QfLY5s8KHspJJOZ7kkPdMBrPrGfbyb2iGus
         t3ay/VXiNvoBILRLzDpX6S+od12XqyhGtLoJg6TKcm15uzeXZOaabFuuXjwEOHCzLRiB
         fqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXDA/8Z0zzxn4DL43A0Gqmzqj/8i+ylUq11Lj7yXx7g=;
        b=cLbEk0QV2SD6LruIzZEk8/pPBCNHbDNvqe8FbpPh+JoaHSmjCx9QsrJJkd5hhFcPWK
         oivALeTyxBezEtiqxMjXxMQxUS6sYD+yXZZ6s5afK9rVAPycsvzt8U/0C45Tr3yfOK2j
         Iv5ooctWFrkb1L5QISEuGM0fgfj7Ng7suCr08tT+aIGCXS0UOPZcE0M2IYvvvp79sYby
         B4pHQCkbSkVNz3cqdOzOdPEOP/Gavv7oA9pFS+3JuaOhQTH3F2yTVX94ZemZY48A1Ftl
         4+0YTZZz44UH60gyivxDUU7fVEWIJ/ChaX5mh6F6vzWm9Uiwk+/VrQCOXN+gqGtZaKqA
         p93g==
X-Gm-Message-State: AOAM530PbRX0J7EkwO0BQgIpPew46N4ODnvUAt1HhNfx+8cpZxY6cJ3r
        Xc6ixRkGbZJYLwpW27cBWqjBsqpftEKF3g==
X-Google-Smtp-Source: ABdhPJwM0xblj0nhPI74airihH1LKytR1g3hxwH0eGcvUys6Jgu/BRiD9let42PyjxM8MPPdLOwjJA==
X-Received: by 2002:a5d:5987:: with SMTP id n7mr19940912wri.293.1623691096531;
        Mon, 14 Jun 2021 10:18:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i6sm83816wmb.15.2021.06.14.10.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:18:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] show-branch tests: add missing tests
Date:   Mon, 14 Jun 2021 19:18:10 +0200
Message-Id: <patch-4.4-c54c6a7b205-20210614T171626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing tests for --remotes, --list and --merge-base. These are
not exhaustive, but better than the nothing we have now.

There were some tests for this command added in f76412ed6db ([PATCH]
Add 'git show-branch'., 2005-08-21) has never been properly tested,
namely for the --all option in t6432-merge-recursive-space-options.sh,
and some of --merge-base and --independent in t6010-merge-base.sh.

This fixes a few more blind spots, but there's still a lot of behavior
that's not tested for.

These new tests show the add (and possibly unintentional) behavior of
--merge-base with one argument, and how its output is the same as "git
merge-base" with N bases in this particular case. See the test added
in f621a8454d1 (git-merge-base/git-show-branch --merge-base:
Documentation and test, 2009-08-05) for a case where the two aren't
the same.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3202-show-branch.sh | 61 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 54025f03379..ad9902a06b9 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -85,4 +85,65 @@ test_expect_success 'show-branch --color output' '
 	test_cmp expect actual
 '
 
+test_expect_success 'show branch --remotes' '
+	cat >expect.err <<-\EOF &&
+	No revs to be shown.
+	EOF
+	git show-branch -r 2>actual.err >actual.out &&
+	test_cmp expect.err actual.err &&
+	test_must_be_empty actual.out
+'
+
+test_expect_success 'setup show branch --list' '
+	sed "s/^> //" >expect <<-\EOF
+	>   [branch1] branch1
+	>   [branch2] branch2
+	>   [branch3] branch3
+	>   [branch4] branch4
+	>   [branch5] branch5
+	>   [branch6] branch6
+	>   [branch7] branch7
+	>   [branch8] branch8
+	>   [branch9] branch9
+	> * [branch10] branch10
+	EOF
+'
+
+test_expect_success 'show branch --list' '
+	git show-branch --list $(cat branches.sorted) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show branch --list has no --color output' '
+	git show-branch --color=always --list $(cat branches.sorted) >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show branch --merge-base with one argument' '
+	for branch in $(cat branches.sorted)
+	do
+		git rev-parse $branch >expect &&
+		git show-branch --merge-base $branch >actual &&
+		test_cmp expect actual
+	done
+'
+
+test_expect_success 'show branch --merge-base with two arguments' '
+	for branch in $(cat branches.sorted)
+	do
+		git rev-parse initial >expect &&
+		git show-branch --merge-base initial $branch >actual &&
+		test_cmp expect actual
+	done
+'
+
+test_expect_success 'show branch --merge-base with N arguments' '
+	git rev-parse initial >expect &&
+	git show-branch --merge-base $(cat branches.sorted) >actual &&
+	test_cmp expect actual &&
+
+	git merge-base $(cat branches.sorted) >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.32.0.555.g0268d380f7b


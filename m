Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D47FC433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 18:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbiCQSKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbiCQSKP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 14:10:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E741162B6
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:08:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h23so7864908wrb.8
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mPzeHTxtjNDX8hKe4aAPusU/5qxdMnJz7oOxDlBn3aw=;
        b=Js82yHjX/gVoQ+6iagT3FskrIT+ehTQrpGXMOiS9LnCIsTaqI58FyBqaUfkQTz2ytK
         jQnMaGEcnNw/oBKYfgFkxmdN/X4Ucx/5va6RnyA4OMOQu7dRSA6CWdswC7sbMKDOCqb2
         b+94GAe3JxoWuEInEyEa84tE09SHHxHv0F+gpcz6qTTO43WIVS6mH1FqobskmO2CmLyB
         gIutapkKNlc7GCBF7V8pzvALgolZtAP6VJahZwgwSYIxyZanM3W+mJil9q9sGbfYMzeW
         f/Ih2QECW6jxeEVpqORkSdCOdffbUSsp2WfeR+BUHhOymJCZvcniZU6H8oz5Lh0QjFyh
         PF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPzeHTxtjNDX8hKe4aAPusU/5qxdMnJz7oOxDlBn3aw=;
        b=sbUqdRRI09Z70jNTLkm71D6FH8v5e0BmANUBN80sPCNOijp7X4hn8Lk+Oe8oSFkljP
         W4pcC51499V+qu45NpXGNGCADLzvhKhdY4sHL5ABDuDHU+5BVevC6Qs374wFy7soOvRW
         7rhriQxuj/6LDPQxSIYJFZnsMDy+81bC94U93ECSx2IBuYLPz/jLdeoUmYKKAZLz3vki
         bDpZerz/n6XB1+40O7XSNerWS0ffvn9zG+fhhQT+NSGewyTPutZh54H9rsgNzHlTzOcX
         +GbLnfadmzxYRdUKwaxivpIecWRvEFiL/wGg4n1cZ76dsHhFna44VzG7M6AzrtD2WQ8T
         psbQ==
X-Gm-Message-State: AOAM5332BcTDnfust2nrf1XN/c1BSASrFgpqLzbLiOIqnsnmF7xc37IS
        7kLwk18TZPSo/76eIGDiCBm5Jzf1m/qoQA==
X-Google-Smtp-Source: ABdhPJz4WiCev2S5atikv4tGohB1QyJNDzkqr02iYzD1DUhA069QqyOzYJDkpgq+Rl4kbExwlR63jQ==
X-Received: by 2002:a5d:5849:0:b0:1ef:f98a:5406 with SMTP id i9-20020a5d5849000000b001eff98a5406mr5265468wrf.8.1647540537316;
        Thu, 17 Mar 2022 11:08:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm4756253wri.105.2022.03.17.11.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 11:08:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/8] reflog tests: add missing "git reflog exists" tests
Date:   Thu, 17 Mar 2022 19:08:35 +0100
Message-Id: <patch-3.8-5d6500efb55-20220317T180439Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were a few "git reflog exists" tests scattered over the test
suite, but let's consolidate the testing of the main functionality
into a new test file. This makes it easier to run just these tests
during development.

To do that amend and extend an existing test added in
afcb2e7a3b8 (git-reflog: add exists command, 2015-07-21). Let's use
"test_must_fail" instead of "!" (in case it segfaults), and test for
basic usage, an unknown option etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1411-reflog-show.sh   |  5 -----
 t/t1418-reflog-exists.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)
 create mode 100755 t/t1418-reflog-exists.sh

diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 0bb319b944a..975c4ea83a8 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -169,9 +169,4 @@ test_expect_success 'git log -g -p shows diffs vs. parents' '
 	test_cmp expect actual
 '
 
-test_expect_success 'reflog exists works' '
-	git reflog exists refs/heads/main &&
-	! git reflog exists refs/heads/nonexistent
-'
-
 test_done
diff --git a/t/t1418-reflog-exists.sh b/t/t1418-reflog-exists.sh
new file mode 100755
index 00000000000..60c6411ce3c
--- /dev/null
+++ b/t/t1418-reflog-exists.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='Test reflog display routines'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit A
+'
+
+test_expect_success 'usage' '
+	test_expect_code 129 git reflog exists &&
+	test_expect_code 129 git reflog exists -h
+'
+
+test_expect_success 'usage: unknown option' '
+	test_expect_code 129 git reflog exists --unknown-option
+'
+
+test_expect_success 'reflog exists works' '
+	git reflog exists refs/heads/main &&
+	test_must_fail git reflog exists refs/heads/nonexistent
+'
+
+test_expect_success 'reflog exists works with a "--" delimiter' '
+	git reflog exists -- refs/heads/main &&
+	test_must_fail git reflog exists -- refs/heads/nonexistent
+'
+
+test_done
-- 
2.35.1.1384.g7d2906948a1


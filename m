Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D73C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FD26117A
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 09:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbhJFJwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 05:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbhJFJwf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 05:52:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC778C061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 02:50:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b8so7721566edk.2
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vKQP2IqB6oZcJdawp7guNiVnFtCAT/Tv/AtohKR4Exw=;
        b=eCYmVtUte0jYOtS+PhFIVBk1vqcvgTQm0WAagLDN4DvX9nMFLXW6SMaBYgd3DfqSUz
         72KXg1iH+49236y1/Aoae60Z2+CWd9FHae2YBZWtd+iUVznFj4PEK4do7BH4VK2AHFR2
         wEWN0NV/vOQ5Y8vzSHnj/hAWjaHs5hGBpnw34M/PoXkzrHbJcZo0YjJhdBbfGXwXRBQJ
         kfku+yyH3sjjXcNDDKP/QCJ1jbtCZWtV4ilKS5h8mhkuAvu+kSEDE65Oi0p1ygfdlBx5
         nH0P6AZqVloKumzOL1ENzjFx0DOYoWUhBQ3Fre88EnIbEhousPI0AdiK4J9OytmC3ffC
         Kycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vKQP2IqB6oZcJdawp7guNiVnFtCAT/Tv/AtohKR4Exw=;
        b=Me6BeCKT6CcWYpQ2MXhzEQy+pMg+BLwZ9OnGHfXLlzLaFLk6E5M7kYahbLltUG+VbD
         rKX0Hh3EzHEerELMk9/LXKWuFRMFl9E6UHAbtIbQ8H0einte4HfTw/tH6M41SZ0omv4x
         3BQLnSiz4F4grvI/GSGB9xI4o8bJSNx+BEyh4bbyIupDBczr0cFiyjVqFsHtKEF9qKa7
         T72KQgH1LecawPVMSvjgXWn/KgVvA4eBZqSbA/OSyxb3PT4dkhcKP8tdRlPLjCQ0OFZJ
         6PDMhB6kNzosybId0ABbLD8fnm+bj8RpTl42kV35dlp1+m7p/qAiQQxTK41xblsKbGNo
         m/Mg==
X-Gm-Message-State: AOAM530fbMHsfXSgs9B9RO5nxESZ3G0PHVSNE3NDieVeZumSiKZl0sMn
        smfQj/bOu1dw5JDIrmN6xqUQX/CisClTjQ==
X-Google-Smtp-Source: ABdhPJyktzNK76xvNWIumbFpEOg+MQgcGiUJkIFgea8ua1GZUZWmrMPDHftMgqjE5osDfMC1cwitoQ==
X-Received: by 2002:a05:6402:2682:: with SMTP id w2mr1297092edd.185.1633513842291;
        Wed, 06 Oct 2021 02:50:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2sm9886243edu.48.2021.10.06.02.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 02:50:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] leak tests: mark all ls-tree tests as passing with SANITIZE=leak
Date:   Wed,  6 Oct 2021 11:50:31 +0200
Message-Id: <patch-04.10-e18b5093a52-20211006T094705Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211006T094705Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark those tests that match "*ls-tree*" as passing when git is
compiled with SANITIZE=leak. They'll now be whitelisted as running
under the "GIT_TEST_PASSING_SANITIZE_LEAK=true" test mode (the
"linux-leaks" CI target).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3100-ls-tree-restrict.sh  | 2 ++
 t/t3101-ls-tree-dirname.sh   | 2 ++
 t/t3102-ls-tree-wildcards.sh | 1 +
 t/t3103-ls-tree-misc.sh      | 1 +
 4 files changed, 6 insertions(+)

diff --git a/t/t3100-ls-tree-restrict.sh b/t/t3100-ls-tree-restrict.sh
index 18baf49a49c..436de44971e 100755
--- a/t/t3100-ls-tree-restrict.sh
+++ b/t/t3100-ls-tree-restrict.sh
@@ -16,6 +16,8 @@ This test runs git ls-tree with the following in a tree.
 The new path restriction code should do the right thing for path2 and
 path2/baz.  Also path0/ should snow nothing.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success \
diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 12bf31022a8..05fde642259 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -19,6 +19,8 @@ This test runs git ls-tree with the following in a tree.
 Test the handling of multiple directories which have matching file
 entries.  Also test odd filename and missing entries handling.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.sh
index 1e16c6b8ea6..3942db22900 100755
--- a/t/t3102-ls-tree-wildcards.sh
+++ b/t/t3102-ls-tree-wildcards.sh
@@ -2,6 +2,7 @@
 
 test_description='ls-tree with(out) globs'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index 14520913afc..d18ba1bd84b 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -7,6 +7,7 @@ Miscellaneous tests for git ls-tree.
 
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.33.0.1441.gbbcdb4c3c66


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF56C433E0
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BC864E6B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 02:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbhCPCOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhCPCNq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 22:13:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2153C06175F
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:45 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so528301wml.2
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 19:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0vk+9uNAFEBEw7bNKK0/kJW1iilCi4rZz4KGMkpIqg=;
        b=lrQthKBjboWhQQiWR28pIaik3fljNk7+1l/Nx0jSxH0otTMZTohcENBUzlY6WnTGdL
         uSowML8K8yqFE6+nsYi/otCiC/5SFSNv2uMZrcrjN56zL3Ejy3YkoA3Nr8/oOcN7Wand
         L3nB8lsknUryh2dRDEnf3Zn+UZ09dId+EDLjPi+1vEy7UuHAUMoKw7r4mZTHV8LmZIXp
         sBHe2kuv/fmPN9dvNB1j5O2HIhU5HBIGFeiD3P7hreOZ2MiFPDdN7TlUKkVc8zSkjrhd
         QV7ib0XvBZQdYOoSXexr5hPU2vteunHUTEKD5pIla7Zt7rl4Woyy+J+Hn6G7gcZrSMZa
         hMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0vk+9uNAFEBEw7bNKK0/kJW1iilCi4rZz4KGMkpIqg=;
        b=YZRlGqYXgKiBzvGNmb/su/0fq6rFlNVfd+CBf5yeCkA+kUz6VR5ardl3kU3UvpIFoY
         KNQPEKFJEZHoNKY1BgWyuTVtMyJG8M1FGgWHhmeYCJJlc8Q+BRzcEmI4M2kxEJOU7UtR
         PejiU0/vt57WhzGgUi9iXB37E4194ooKGh21dFPvHSy1WaAxobGqN09ZyME4rFlD1Fxn
         qGvM6vGaeorGdDFvQnk+cx5Oha2OTr0CBlbivrew6xuQGs4cbRZS5bOaOGo9fnCV3w0n
         Ab5MJdMFb9f8LpWE94z0xRuxEGkjfI3R5OuJQl3w6tMgzgCRIiFkQl8W9INJM+QjyAXu
         gcSw==
X-Gm-Message-State: AOAM533XQzYfWREfWaldgFfVblJNFj/zz4kdRfQEIgRs8bWshOH+JTMO
        4i1JrzbnbsePSs9dsqW60bTIFDtUkZn3Pg==
X-Google-Smtp-Source: ABdhPJyL36jVDyelL56QdgiioIVJJIRtg1z9Z2/78c9FATBZaUkmehU2UaMUw8sqhGQ+8Um5IGdDpQ==
X-Received: by 2002:a1c:2857:: with SMTP id o84mr2199496wmo.181.1615860824216;
        Mon, 15 Mar 2021 19:13:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i8sm21092494wrx.43.2021.03.15.19.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 19:13:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/29] merge-tree tests: test for the mode comparison in same_entry()
Date:   Tue, 16 Mar 2021 03:12:58 +0100
Message-Id: <20210316021312.13927-16-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308150650.18626-1-avarab@gmail.com>
References: <20210308150650.18626-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test to stress the "a->mode == b->mode" comparison in
merge-tree.c's same_entry().

That code was initially added by Linus in 33deb63a36f (Add
"merge-tree" helper program. Maybe it's retarded, maybe it's helpful.,
2005-04-14), and then again in its current form in
492e0759bfe (Handling large files with GIT, 2006-02-14).

However, nothing was testing that we handled this case
correctly. Simply removing the mode comparison left all tests passing,
but as seen here it's important that we don't think a path with the
same content but different modes is the same_entry().

The rest of this series will touch code that's relevant to this, but
won't change its behavior. This test is just something I came up with
in testing whether the mode test in same_entry() was needed at all.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4300-merge-tree.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
index e59601e5fe9..f783d784d02 100755
--- a/t/t4300-merge-tree.sh
+++ b/t/t4300-merge-tree.sh
@@ -40,6 +40,25 @@ test_expect_success 'file add A, B (same)' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'file add A, B (different mode)' '
+	git reset --hard initial &&
+	test_commit "add-a-b-same-diff-mode-A" "ONE" "AAA" &&
+	git reset --hard initial &&
+	echo AAA >ONE &&
+	test_chmod +x ONE &&
+	test_tick &&
+	git commit -m"add-a-b-same-diff-mode-B" &&
+	git tag "add-a-b-same-diff-mode-B" HEAD &&
+	git merge-tree initial add-a-b-same-diff-mode-A add-a-b-same-diff-mode-B >actual &&
+	cat >expected <<EXPECTED &&
+added in both
+  our    100644 $(git rev-parse add-a-b-same-diff-mode-A:ONE) ONE
+  their  100755 $(git rev-parse add-a-b-same-diff-mode-B:ONE) ONE
+EXPECTED
+
+	test_cmp expected actual
+'
+
 test_expect_success 'file add A, B (different)' '
 	git reset --hard initial &&
 	test_commit "add-a-b-diff-A" "ONE" "AAA" &&
@@ -61,6 +80,31 @@ EXPECTED
 	test_cmp expected actual
 '
 
+test_expect_success 'file add A, B (different and different mode)' '
+	git reset --hard initial &&
+	test_commit "add-a-b-diff-diff-mode-A" "ONE" "AAA" &&
+	git reset --hard initial &&
+	echo BBB >ONE &&
+	test_chmod +x ONE &&
+	test_tick &&
+	git commit -m"add-a-b-diff-diff-mode-B" &&
+	git tag "add-a-b-diff-diff-mode-B" &&
+	git merge-tree initial add-a-b-diff-diff-mode-A add-a-b-diff-diff-mode-B >actual &&
+	cat >expected <<EXPECTED &&
+added in both
+  our    100644 $(git rev-parse add-a-b-diff-diff-mode-A:ONE) ONE
+  their  100755 $(git rev-parse add-a-b-diff-diff-mode-B:ONE) ONE
+@@ -1 +1,5 @@
++<<<<<<< .our
+ AAA
++=======
++BBB
++>>>>>>> .their
+EXPECTED
+
+	test_cmp expected actual
+'
+
 test_expect_success 'file change A, !B' '
 	git reset --hard initial &&
 	test_commit "change-a-not-b" "initial-file" "BBB" &&
-- 
2.31.0.rc2.211.g1d0b8788b3


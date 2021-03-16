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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189F5C43332
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E3864F5D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbhCPP7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbhCPP6u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203CFC0613D8
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so4069001wmq.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/4L8O9YmcWj5RHNeBTo+tK864N38EhgNEqW34pysjc=;
        b=BdFRr+/AAXJG6bG9RijhXeQmb1LpJcxUWzgcQBctZoFv0A/7L4n3HlToCMvbO2mamo
         Axte4oMo7KZ3YSRvL5WDYfdHtNcjUlcTkJGVDdUyiCgheFvGOdMmnvT1X0mW+GfGjA2c
         9fO6FUzPp82fopwHrt3VocHAJUgkfhJBjy9ODUpvfaveVnsh2O3VWujHsoKEUloo9ckx
         kVrz8FZrldcYmmzlO8teMuroE9TEotEPMO5zh7zU3GpA2uxZgosOJDL4wW7u1MUa8opy
         a1ciQTxL4TvqXBQpeEgSDUl33NSy/tdEc9sqFoiO2R8bafU3OGkURpdmTogmkvHAf4KV
         YPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/4L8O9YmcWj5RHNeBTo+tK864N38EhgNEqW34pysjc=;
        b=DJiUSepRgWtm5VksUjvMXmm1NwtDg2B6aTFhMNq+NnydTuAdSwYSo5/93AAcFmYETc
         FV4OvP2c42ns6m/4PuWRB6V7hzQnnQeGfa+Ixo13A/Fb5xO5k9GVC7//5sIhFcLh4mVL
         e1bfUuLyGTxiUYWzWRZiY3oLi9pfKzGBUBFk+j8j2BOoTGjWLBgIa7pIHhOkeMWWYkVK
         KY/iU1sHdhf89o8LxsPmtnV0/r+t/p0pLuoIS8oJiCO2AOakW8wX92GOSTu4Vi/uWl6R
         dI2Y4sRc+e52W2sEXKTfYpSyVGm92HVlD2cQDfyZArdokhnsIQ/4zfvEDXsM58wLYRJl
         Y07g==
X-Gm-Message-State: AOAM532YXz5kVVMuFqH6homYHYBDHp/Xtt3SDJqhBR3NNAGxGLfbljR8
        fCRxjD3q5mFDPirazto+WOSuJ48x7d2Xlg==
X-Google-Smtp-Source: ABdhPJzxnQCPZQp5Vd7/FUnZUTT3VdcyaPnPp1yElzLn2iAGlB9B+Y5dMVbUEYMwkXGfnCpDN668Kg==
X-Received: by 2002:a1c:6a12:: with SMTP id f18mr309076wmc.31.1615910324601;
        Tue, 16 Mar 2021 08:58:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:44 -0700 (PDT)
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
Subject: [PATCH v3 08/32] diff tests: test that "mode" is passed when sorting
Date:   Tue, 16 Mar 2021 16:58:05 +0100
Message-Id: <20210316155829.31242-9-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Piggy-back on the recently added fsck tests for mode comparisons in
mktree and assert that diff-tree also does the right thing in this
implausible scenario.

As with the other tests I've added in preceding commits, these tests
will fail if the mode is the same or reversed, respectively.

The diff-tree code being tested here was originally added back in
.9174026cfe (Add "diff-tree" program to show which files have changed
between two trees., 2005-04-09).

Unlike the other tests I've added there are existing tests for both of
these scenarios. Breaking that function as described above will make
tests in t4002-diff-basic.sh, t6409-merge-subtree.sh and
t4037-diff-r-t-dirs.sh fail.

I think it's good to have tests for this regardless, so let's add
these.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 46125190b4..5dd842bb82 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -362,6 +362,28 @@ test_expect_success 'tree entry with duplicate type mismatching objects' '
 	)
 '
 
+test_expect_success 'diff-tree stressing tree-diff.c::tree_entry_pathcmp(), not the same type' '
+	zero=$(test_oid zero) &&
+	git -C duplicate-entry diff-tree broken-commit-1 broken-commit-2 >1-to-2 &&
+	grep "$zero" 1-to-2 >lines &&
+	test_line_count = 2 lines &&
+
+	git -C duplicate-entry diff-tree broken-commit-2 broken-commit-1 >2-to-1 &&
+	grep "$zero" 2-to-1 >lines &&
+	test_line_count = 2 lines
+'
+
+test_expect_success 'diff-tree stressing tree-diff.c::tree_entry_pathcmp(), types not reversed' '
+	blob_ok=$(git -C duplicate-entry rev-parse broken-commit-2:A) &&
+	git -C duplicate-entry diff-tree --diff-filter=A broken-commit-1 broken-commit-2 >1-to-2 &&
+	grep "$blob_ok" 1-to-2 &&
+	test_line_count = 1 1-to-2 &&
+
+	git -C duplicate-entry diff-tree --diff-filter=A broken-commit-2 broken-commit-1 >2-to-1 &&
+	grep "$blob_ok" 2-to-1 &&
+	test_line_count = 1 2-to-1
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	badoid=$(test_oid deadbeef) &&
 	cat >invalid-tag <<-EOF &&
-- 
2.31.0.256.gf0ddda3145


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810DCC433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658CB61073
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244028AbhJPJl6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbhJPJlu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADCEC06176A
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e12so30737677wra.4
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UTih+V2Ab8OqP972inaXkIY0GUhGzIH24cMpcgVplDI=;
        b=DIX5uZWWqqnlRGlf2sjIWUD+1VJPLilnjWv8ZCgkrr5vkhRFF2eQgtyOFXuro1sPWV
         3XRSTidVGsb4uXEtl4scH2JapawlHa9My9emWI5JlsC1epLbxToCeggZEG+DEuEpocvx
         xO/DbAmdngDvb4VqpiVfgVQq6ShwlD1kEI2uP2fT+Kjca2OajHEosOVHR8ZyLpq1IzzP
         BSzXGRcGonrhdIdJrAT/LeeDz28jFhVoH4altmi2DlwhNROXL8ywRZg2/ZsBTwiCoctR
         f6mil+XtmHIfA6fWtESRNeP1ycqY6hAL0lR9LlTgIARIhmPTMc5sNZplcRFmbSz1IpRh
         xj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UTih+V2Ab8OqP972inaXkIY0GUhGzIH24cMpcgVplDI=;
        b=vUBiVex52uZwT+lP1z9JKshClRBOfCwPCucO3F8eKKkAg2HgjDj4ACitlZrvE3Tf+t
         YiSI6JeS+M1ow8DHL60LFGFiBN0Z3a5hPqEfHvwVRb3IRhHE9gokd0yNuDtrqYbH9UeZ
         ErBdg90vAJ5MhRYwAC2fId2geNIcoSERf2ov42xQTOB31FrOk0YsL8gCrsc5SvWXuhha
         CSUnrlbzxcxFtxsfoiy4JRx+OA6iEuGLMTXx0qqbGjeClMPXLhCDUdLZfYZWfQvX29if
         YaKopetvskkMBYRNXG4FC45sWjErW/0uknzOiMlXF5fOndv6aH0rmAu+lZVWXhUg5v6m
         MkuQ==
X-Gm-Message-State: AOAM530iXUu8i1WMGmZPxAQ6BVLRfXzyQ673TRVRcpOxVku2tclM9Mwy
        60SsX7m5a31Imh/Usnoyx+GcxQUD/EF38g==
X-Google-Smtp-Source: ABdhPJzAQxHoj9cOYFbER/uyCj0/SUzruKh92l680ccQXKKyzY8n3VaN0ToOP5l7jerOOrlszf8rDw==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr20459194wrs.190.1634377170878;
        Sat, 16 Oct 2021 02:39:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/21] branch tests: test for errno propagating on failing read
Date:   Sat, 16 Oct 2021 11:39:07 +0200
Message-Id: <patch-v2-01.21-1863c597c98-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Add a test for "git branch" to cover the case where .git/refs is
symlinked. To check availability, refs_verify_refname_available() will
run refs_read_raw_ref() on each prefix, leading to a read() from
.git/refs (which is a directory).

It would probably be more robust to re-issue the lstat() as a normal
stat(), in which case, we would fall back to the directory case, but
for now let's just test for the existing behavior as-is. This test
covers a regression in a commit that only ever made it to "next", see
[1].

1. http://lore.kernel.org/git/pull.1068.git.git.1629203489546.gitgitgadget@gmail.com

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3200-branch.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e575ffb4ffb..53e0d094bb4 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -731,6 +731,28 @@ test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for
 	test_must_fail git branch -m u v
 '
 
+test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
+	test_when_finished "rm -rf subdir" &&
+	git init --bare subdir &&
+
+	rm -rfv subdir/refs subdir/objects subdir/packed-refs &&
+	ln -s ../.git/refs subdir/refs &&
+	ln -s ../.git/objects subdir/objects &&
+	ln -s ../.git/packed-refs subdir/packed-refs &&
+
+	git -C subdir rev-parse --absolute-git-dir >subdir.dir &&
+	git rev-parse --absolute-git-dir >our.dir &&
+	! test_cmp subdir.dir our.dir &&
+
+	git -C subdir log &&
+	git -C subdir branch rename-src &&
+	git rev-parse rename-src >expect &&
+	git -C subdir branch -m rename-src rename-dest &&
+	git rev-parse rename-dest >actual &&
+	test_cmp expect actual &&
+	git branch -D rename-dest
+'
+
 test_expect_success 'test tracking setup via --track' '
 	git config remote.local.url . &&
 	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
-- 
2.33.1.1338.g20da966911a


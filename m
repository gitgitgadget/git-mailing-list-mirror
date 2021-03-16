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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A00C4332D
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC8E46510C
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbhCPQAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbhCPP7I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:59:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F8CC06175F
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo1758162wmq.4
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QO7Nw6hn0oXyq6j/dhhKBZG7mNHUkHMclnG26PsWXqM=;
        b=GKoCMFzwNSej1RsQoRiabbcahEv8XpnBpqb4fut35MqI6oA7gXa3K0Lsy0fGpojAKb
         ojL2pkslkSmXKzGKX+cIs9m/HvWv40xSauVnv4fc06TIF4yM+87Xbn2xjm+CXbCwLglO
         gqG6XFrOSa0SFkKselUfxOz9tQGy+Blc1OjdL1x/Ts3+Wu74pUVbV+5wlzq789dXgHsX
         uJfjzjed8juVnwH/tIr+rBCVMHl+67xXjP1C46+oia2VThFk29o9Bm/xtnU8JgQpXPHd
         GmB/I9EBiIrCEHsn5ptrkBX1i75qUVC580CUINbjHdvGTea0ipUYBqRp/6Hf33RfV7T9
         Ut0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QO7Nw6hn0oXyq6j/dhhKBZG7mNHUkHMclnG26PsWXqM=;
        b=qzJ//CVZVzJQfajQvfzMWR2r4jrj7N0KQqJwef2/LprG5yBmaFUVu2yvWdTVr4kMVp
         TylwxHbSycEKB0hytm5Qv4RtWzLsCHh1e4Gx4Igrph3ujHgMbanavHZOdUZ5aYRyNClm
         zjhL2p3TU37ZeE8Z1UtHxYz4umNByHWNyQobDr1Iq4IqjoeEvoc1oGGryMT5+J0oVMqe
         g1Sw0ClFiyi9kwoObytovfG/YV8mwquoOI1oVa9AVoGnQLXQR0xVIO92BVsyvx7zetR8
         eux5S3+UO6BD26ZvfQhJpOqWCLssOp76uCoCLpok834kTEvICb57BvAFuxbJh7Qjnmoq
         awpA==
X-Gm-Message-State: AOAM5312PMGUCUdePh16iYhteVtIK0Hs3qd6hSQ9zTdlk/yaCkaC3qNA
        1Fi9kHvCxCNLsZlVLk8aaApWo7yUAcjDzw==
X-Google-Smtp-Source: ABdhPJyFVp5Oe6r9uINFHBG9Oy3da8iKIdnlxDY5Ct07p01Zt4pMXUWfqcaIgi2tVHdRkFJnivRzuQ==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr283614wmc.103.1615910345402;
        Tue, 16 Mar 2021 08:59:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:59:04 -0700 (PDT)
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
Subject: [PATCH v3 31/32] blame: emit a better error on 'git blame directory'
Date:   Tue, 16 Mar 2021 16:58:28 +0100
Message-Id: <20210316155829.31242-32-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an early check for non-blobs in verify_working_tree_path() to
let any such objects pass, and instead die shortly thereafter in the
fake_working_tree_commit() caller's type check.

Now e.g. doing "git blame t" in git.git emits:

    fatal: unsupported file type t

Instead of:

    fatal: no such path 't' in HEAD

The main point of this test is to assert that we're not doing
something uniquely bad when in a conflicted merge. See
cd8ae20195 (git-blame shouldn't crash if run in an unmerged tree,
2007-10-18) and 9aeaab6811 (blame: allow "blame file" in the middle of
a conflicted merge, 2012-09-11) for the bug the t8004 test was
originally meant to address.

But when extending it let's grep out the specific error message for
good measure. Having to change it in the future (e.g. as part of my
parallel series to improve such 'OID does not match type' messages) is
a small price for ensuring it doesn't regress.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 blame.c                         |  8 ++------
 t/t8004-blame-with-conflicts.sh | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/blame.c b/blame.c
index 9e0543e13d..7da162cd58 100644
--- a/blame.c
+++ b/blame.c
@@ -100,12 +100,8 @@ static void verify_working_tree_path(struct repository *r,
 
 	for (parents = work_tree->parents; parents; parents = parents->next) {
 		const struct object_id *commit_oid = &parents->item->object.oid;
-		struct object_id blob_oid;
-		unsigned short mode;
-		int ret = get_tree_entry_mode(r, commit_oid, path, &blob_oid,
-					      &mode);
-
-		if (!ret && oid_object_info(r, &blob_oid, NULL) == OBJ_BLOB)
+		struct object_id oid;
+		if (!get_tree_entry_path(r, commit_oid, path, &oid))
 			return;
 	}
 
diff --git a/t/t8004-blame-with-conflicts.sh b/t/t8004-blame-with-conflicts.sh
index 35414a5336..5e3dea35a5 100755
--- a/t/t8004-blame-with-conflicts.sh
+++ b/t/t8004-blame-with-conflicts.sh
@@ -73,4 +73,25 @@ test_expect_success 'blame does not crash with conflicted file in stages 1,3' '
 	git blame file1
 '
 
+test_expect_success 'setup second case' '
+	git merge --abort
+'
+
+test_expect_success 'blame on directory/file conflict' '
+	mkdir d &&
+	test_commit second &&
+	test_commit d/file &&
+	test_must_fail git blame d 2>expected &&
+	grep "unsupported file type d" expected &&
+
+	git reset --hard second &&
+	>d &&
+	git add d &&
+	git commit -m"a not-a-dir" &&
+	test_must_fail git merge d/file &&
+
+	test_must_fail git blame d 2>actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.31.0.256.gf0ddda3145


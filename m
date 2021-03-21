Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8CEC43461
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A624601FE
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCUACf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCUABt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:49 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7995DC061762
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so9288414wml.2
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCid5IWtc0NNyD68WbH2bXdMV8cxF/t/ndDFxq8M+QE=;
        b=JYgTPwc8wXFlV63EIy6B3/+ULvXeqPO9i+Nm6fFwMLKmTyzYRlvGyURePsgOv0UrzX
         EI8y1LdAwj+ljPgBLCFlCtaSq45t/+xuUz2FCrCleYMBWb5NEi7usdu/c9RjLIkZ/Fjp
         YlUPdNMvWDYDF15OlufJtm2QNPTWT74tQKFf5xcom1Q7vLQrNI27ERhKsPVN7BG2SExg
         d4raLrMGJZC/lkGWxz4yOLcTx38K02MKxDrHDySKN1Zg/DWyaC4493v4j1Wy5OcF+A4W
         XLBHE5/Xs0ANdFABagqran0+M/Jwt4/LEhAw7BKCP5jvnvPDLTZ0iw0MyJyFSAwgTycX
         TfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCid5IWtc0NNyD68WbH2bXdMV8cxF/t/ndDFxq8M+QE=;
        b=K89F7xF3jjtEi/iMKgjZq6wPw8mRt7DvOAFRUlv9pmXR7aHgM25+dlnJ12eNIPr/dg
         oh6qhF5xpjGwYMP6olRlnUMsZCo55qaeBYPW/hWeIQNR6JUlCLqKml0bu7N9ezpCFeY6
         uK5bQ7ufEaSYjEs9Q1i/k0zc6wklnOVP/RU1G9bQdzwVdU5kPGBFDc+kkr4ArdkMEHqP
         vjkZ7h4NqwgpZnAvsIzQbBb0uMHiCrEZ7gI0KHhvAUPvEFO2X0MVyc1+B53+zx6wo99/
         HIm/35QitUqRWZsd32jRDJoTqQQUO2hhpPa5tPZMHTCQJnkujnSmFnFISZE49CYoKFJ/
         VXbw==
X-Gm-Message-State: AOAM532tOVsVjSAVMp/igWe1oQYaLi68AiE54b9gtdHEgZAnEHCJ+B4M
        mYyTbx1jKQ0OVwSZOXxK9CYtdpg6G7l+qA==
X-Google-Smtp-Source: ABdhPJwFWXiy4QoehPL1WUc7Ku+l5GZcvvLX+M8Yinw1jcVdgXbVXc4IVncXC0+XPL6H3X2wVh16NQ==
X-Received: by 2002:a05:600c:358c:: with SMTP id p12mr9843564wmq.159.1616284908036;
        Sat, 20 Mar 2021 17:01:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:47 -0700 (PDT)
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
Subject: [PATCH v4 28/29] blame: emit a better error on 'git blame directory'
Date:   Sun, 21 Mar 2021 01:01:01 +0100
Message-Id: <81da54902217891f8115cbad9194c88535615d65.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
index 13825b86e65..3c3cb2f8f96 100644
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
index 35414a53363..5e3dea35a50 100755
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
2.31.0.286.gc175f2cb894


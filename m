Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CACC433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 17:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbiCQR2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiCQR2x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 13:28:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCFD1CAF18
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:27:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j26so8359987wrb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 10:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HbfShQNUk4uT4v86CLRxZMgCp7S/RZXTYzFMLzgaoto=;
        b=EqtGWy/7oaDvxqmrJ/XmpAfnuZGB8j7UcRR24E3NMEuHwA2VCnasm3ghu0ceVT6w95
         6HR6bd2fFJOdwuivnBH0JlsS+ZclMKOEdqO2QWGnGog319E/mP6HdWcNqD19nX0rTU6p
         MoaJgCrCfpTGr8Pi0CDwKil36+BlNClKKlmgEqt3HMJ0VOvEmd+jdVRtH09oZxMmoSrn
         i9UakBQfTEHcAmout57jeEuFd4T8PMp+uXVZFMPHuFlMZeRglypAuI3hzyylzLzyLYFO
         LaUv64bue0TGx7ik/RYlPhqjvPpt6uavzKSz+sEquR7UgbURnVDviTelltvPtqO8ezkW
         Ud8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbfShQNUk4uT4v86CLRxZMgCp7S/RZXTYzFMLzgaoto=;
        b=YSbfk/NXwxF17bxqCqz9BtwtcqiNUU0HEPxXD3QT3Fjd7XafbIzbSqAioPrQEjh/7j
         bcx05k9RoUfz4RzjDKrad7sVnP4mxAvn0h8sQap5Y0XXxEfYy94WPcTqI1P87eJw9Alr
         YMi1WUktGZ50RxoO37mckaF6NO1OYKViXP9L8mkxiPcWLUxT3lKBFpfX57Vek5SK9KaR
         9z4L/WqpLPeU9jAnLDIFZRTcAclc7tJJrWWNKdC05yaff7M+S19mYpJ+XEw0i8YuwV5+
         WTM2ckye21T8/NVN28Ivz9S+BdeUC+011y7mYZ8e/5XROGr0x4VRmcjA45srOw7104M3
         kc/w==
X-Gm-Message-State: AOAM530y8hBpKvyskh0RLlXuZuYMJJKvFCHD82HEbmXQGeY1cpRzX/p0
        KEFoVTlPhXWGNxi+INa/3dqIURtXwUdKtw==
X-Google-Smtp-Source: ABdhPJw3YeOZNLIJvjHgVwLufUWnUXuAiTt1nh2AQo1IZOn3maAfRD/RZUfBh1k9K4GcPm485esV4g==
X-Received: by 2002:a05:6000:178c:b0:203:8b24:42b7 with SMTP id e12-20020a056000178c00b002038b2442b7mr4879478wrg.352.1647538054631;
        Thu, 17 Mar 2022 10:27:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm4690693wrw.91.2022.03.17.10.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:27:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] refs: use designated initializers for "struct ref_storage_be"
Date:   Thu, 17 Mar 2022 18:27:15 +0100
Message-Id: <patch-1.5-a5dcca0b41d-20220317T171618Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the definition of the three refs backends we currently carry to
use designated initializers.

The "= NULL" assignments being retained here are redundant, and could
be removed, but let's keep them for clarity. All of these backends
define almost all fields, so we're not saving much in terms of line
count by omitting these, but e.g. for "refs_be_debug" it's immediately
apparent that we're omitting "init" when comparing its assignment to
the others.

This is a follow-up to similar work merged in bd4232fac33 (Merge
branch 'ab/struct-init', 2021-07-16), a4b9fb6a5cf (Merge branch
'ab/designated-initializers-more', 2021-10-18) and a30321b9eae (Merge
branch 'ab/designated-initializers' into
ab/designated-initializers-more, 2021-09-27).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/debug.c          | 52 +++++++++++++++++++++----------------------
 refs/files-backend.c  | 52 +++++++++++++++++++++----------------------
 refs/packed-backend.c | 52 +++++++++++++++++++++----------------------
 3 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/refs/debug.c b/refs/debug.c
index c590d377200..b03a83258be 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -418,30 +418,30 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 }
 
 struct ref_storage_be refs_be_debug = {
-	NULL,
-	"debug",
-	NULL,
-	debug_init_db,
-	debug_transaction_prepare,
-	debug_transaction_finish,
-	debug_transaction_abort,
-	debug_initial_transaction_commit,
-
-	debug_pack_refs,
-	debug_create_symref,
-	debug_delete_refs,
-	debug_rename_ref,
-	debug_copy_ref,
-
-	debug_ref_iterator_begin,
-	debug_read_raw_ref,
-	NULL,
-
-	debug_reflog_iterator_begin,
-	debug_for_each_reflog_ent,
-	debug_for_each_reflog_ent_reverse,
-	debug_reflog_exists,
-	debug_create_reflog,
-	debug_delete_reflog,
-	debug_reflog_expire,
+	.next = NULL,
+	.name = "debug",
+	.init = NULL,
+	.init_db = debug_init_db,
+	.transaction_prepare = debug_transaction_prepare,
+	.transaction_finish = debug_transaction_finish,
+	.transaction_abort = debug_transaction_abort,
+	.initial_transaction_commit = debug_initial_transaction_commit,
+
+	.pack_refs = debug_pack_refs,
+	.create_symref = debug_create_symref,
+	.delete_refs = debug_delete_refs,
+	.rename_ref = debug_rename_ref,
+	.copy_ref = debug_copy_ref,
+
+	.iterator_begin = debug_ref_iterator_begin,
+	.read_raw_ref = debug_read_raw_ref,
+	.read_symbolic_ref = NULL,
+
+	.reflog_iterator_begin = debug_reflog_iterator_begin,
+	.for_each_reflog_ent = debug_for_each_reflog_ent,
+	.for_each_reflog_ent_reverse = debug_for_each_reflog_ent_reverse,
+	.reflog_exists = debug_reflog_exists,
+	.create_reflog = debug_create_reflog,
+	.delete_reflog = debug_delete_reflog,
+	.reflog_expire = debug_reflog_expire,
 };
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0457ecdb42d..f95552f9263 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3291,30 +3291,30 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 }
 
 struct ref_storage_be refs_be_files = {
-	NULL,
-	"files",
-	files_ref_store_create,
-	files_init_db,
-	files_transaction_prepare,
-	files_transaction_finish,
-	files_transaction_abort,
-	files_initial_transaction_commit,
-
-	files_pack_refs,
-	files_create_symref,
-	files_delete_refs,
-	files_rename_ref,
-	files_copy_ref,
-
-	files_ref_iterator_begin,
-	files_read_raw_ref,
-	files_read_symbolic_ref,
-
-	files_reflog_iterator_begin,
-	files_for_each_reflog_ent,
-	files_for_each_reflog_ent_reverse,
-	files_reflog_exists,
-	files_create_reflog,
-	files_delete_reflog,
-	files_reflog_expire
+	.next = NULL,
+	.name = "files",
+	.init = files_ref_store_create,
+	.init_db = files_init_db,
+	.transaction_prepare = files_transaction_prepare,
+	.transaction_finish = files_transaction_finish,
+	.transaction_abort = files_transaction_abort,
+	.initial_transaction_commit = files_initial_transaction_commit,
+
+	.pack_refs = files_pack_refs,
+	.create_symref = files_create_symref,
+	.delete_refs = files_delete_refs,
+	.rename_ref = files_rename_ref,
+	.copy_ref = files_copy_ref,
+
+	.iterator_begin = files_ref_iterator_begin,
+	.read_raw_ref = files_read_raw_ref,
+	.read_symbolic_ref = files_read_symbolic_ref,
+
+	.reflog_iterator_begin = files_reflog_iterator_begin,
+	.for_each_reflog_ent = files_for_each_reflog_ent,
+	.for_each_reflog_ent_reverse = files_for_each_reflog_ent_reverse,
+	.reflog_exists = files_reflog_exists,
+	.create_reflog = files_create_reflog,
+	.delete_reflog = files_delete_reflog,
+	.reflog_expire = files_reflog_expire
 };
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index f56e2cc635b..47f01fa5c98 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1667,30 +1667,30 @@ static int packed_reflog_expire(struct ref_store *ref_store,
 }
 
 struct ref_storage_be refs_be_packed = {
-	NULL,
-	"packed",
-	packed_ref_store_create,
-	packed_init_db,
-	packed_transaction_prepare,
-	packed_transaction_finish,
-	packed_transaction_abort,
-	packed_initial_transaction_commit,
-
-	packed_pack_refs,
-	packed_create_symref,
-	packed_delete_refs,
-	packed_rename_ref,
-	packed_copy_ref,
-
-	packed_ref_iterator_begin,
-	packed_read_raw_ref,
-	NULL,
-
-	packed_reflog_iterator_begin,
-	packed_for_each_reflog_ent,
-	packed_for_each_reflog_ent_reverse,
-	packed_reflog_exists,
-	packed_create_reflog,
-	packed_delete_reflog,
-	packed_reflog_expire
+	.next = NULL,
+	.name = "packed",
+	.init = packed_ref_store_create,
+	.init_db = packed_init_db,
+	.transaction_prepare = packed_transaction_prepare,
+	.transaction_finish = packed_transaction_finish,
+	.transaction_abort = packed_transaction_abort,
+	.initial_transaction_commit = packed_initial_transaction_commit,
+
+	.pack_refs = packed_pack_refs,
+	.create_symref = packed_create_symref,
+	.delete_refs = packed_delete_refs,
+	.rename_ref = packed_rename_ref,
+	.copy_ref = packed_copy_ref,
+
+	.iterator_begin = packed_ref_iterator_begin,
+	.read_raw_ref = packed_read_raw_ref,
+	.read_symbolic_ref = NULL,
+
+	.reflog_iterator_begin = packed_reflog_iterator_begin,
+	.for_each_reflog_ent = packed_for_each_reflog_ent,
+	.for_each_reflog_ent_reverse = packed_for_each_reflog_ent_reverse,
+	.reflog_exists = packed_reflog_exists,
+	.create_reflog = packed_create_reflog,
+	.delete_reflog = packed_delete_reflog,
+	.reflog_expire = packed_reflog_expire
 };
-- 
2.35.1.1384.g7d2906948a1


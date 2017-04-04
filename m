Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5CF20966
	for <e@80x24.org>; Tue,  4 Apr 2017 10:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754203AbdDDKWE (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 06:22:04 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33781 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753289AbdDDKWD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 06:22:03 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so36314966pgf.0
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 03:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBuOgQEUicnp2q+VmTIDn+B/lPB1CgfX7ZNeZLdGbG0=;
        b=QlNKEYqwBg+FFDkIr2ZBzont2CpgxJJbtV7y5yz1b2wj4TVl0YoYzWyTXE2r6YXZ+d
         LYZ1Pop1bAoCVMobB0Hh+/8oMhTM8XUyhKyQK7rZo9b2Zy+hTVj0pJOjarI5mCQD3Zqx
         ZZqrwsmF9SIT/s7MDzz0rufhlvxavuyABdrHvFPB44WfjGUImEzgwYI6k5f9MOj7E0mL
         hQHY9FevcltOsQTCylVx1/L25W5Bsuvgl5EHoVQWJRAMdxL65inV5jYZmfUUBSHXwq81
         UU87FcXvS68QzYdumOTe2zMFpym7K2yyW7Qve7jdvDBA9qPZ2WlrhusvPulJ9x+Qpck7
         oFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBuOgQEUicnp2q+VmTIDn+B/lPB1CgfX7ZNeZLdGbG0=;
        b=bjBOD/N3UC2iVQGQHHrA5nbNzeD0+tWwdlqoVElKBMIyDzLB5NXH1eCyOZfVwvIOfc
         PGkRi04gkDnpBTdFcdJqSztOn0PbyCSWoH3+rGiFRHr6pCFq/YLg4rbg8g1qOGDSW033
         R1LbhpBel/unieIrIy4CbQBYKnQBwZrODberMZQENEweVactwHYWsKNWJIGUXcfx2Qpq
         S/Nf1+UwYQrhHO82Gd/Fu3PGoGxMHhYT6ej58r5TbGaPW6zUypKh4XFSrXtWHNDcj6qf
         TcsXo4Q5oeuev7I6LzxrESDTCxqx0yAzis+t2HOsmzPxnT1+XMGyY5hJIEob7FbWsAC+
         2CIg==
X-Gm-Message-State: AFeK/H1Y5wVaooZ0Wq0Mguzn/xad6+N/LwzUk8NdGh+9TPiBmZ/xD47EWK4aEJM72ioqaQ==
X-Received: by 10.98.34.208 with SMTP id p77mr2156467pfj.118.1491301322622;
        Tue, 04 Apr 2017 03:22:02 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id a5sm30873707pfh.124.2017.04.04.03.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Apr 2017 03:22:01 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 04 Apr 2017 17:21:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 3/5] refs: introduce get_worktree_ref_store()
Date:   Tue,  4 Apr 2017 17:21:21 +0700
Message-Id: <20170404102123.25315-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170404102123.25315-1-pclouds@gmail.com>
References: <20170318100206.5980-1-pclouds@gmail.com>
 <20170404102123.25315-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

files-backend at this point is still aware of the per-repo/worktree
separation in refs, so it can handle a linked worktree.

Some refs operations are known not working when current files-backend is
used in a linked worktree (e.g. reflog). Tests will be written when
refs_* functions start to be called with worktree backend to verify that
they work as expected.

Note: accessing a worktree of a submodule remains unaddressed. Perhaps
after get_worktrees() can access submodule (or rather a new function
get_submodule_worktrees(), that lists worktrees of a submodule), we can
update this function to work with submodules as well.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 31 +++++++++++++++++++++++++++++++
 refs.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/refs.c b/refs.c
index 875e30a0b8..a4083caf6a 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,7 @@
 #include "object.h"
 #include "tag.h"
 #include "submodule.h"
+#include "worktree.h"
 
 /*
  * List of all available backends
@@ -1486,6 +1487,9 @@ static struct ref_store *main_ref_store;
 /* A hashmap of ref_stores, stored by submodule name: */
 static struct hashmap submodule_ref_stores;
 
+/* A hashmap of ref_stores, stored by worktree id: */
+static struct hashmap worktree_ref_stores;
+
 /*
  * Look up a ref store by name. If that ref_store hasn't been
  * registered yet, return NULL.
@@ -1590,6 +1594,33 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	return refs;
 }
 
+struct ref_store *get_worktree_ref_store(const struct worktree *wt)
+{
+	struct ref_store *refs;
+	unsigned int refs_all_capabilities =
+		REF_STORE_READ | REF_STORE_WRITE |
+		REF_STORE_ODB | REF_STORE_MAIN;
+
+	if (wt->is_current)
+		return get_main_ref_store();
+
+	refs = lookup_ref_store_map(&worktree_ref_stores, wt->id);
+	if (refs)
+		return refs;
+
+	if (wt->id)
+		refs = ref_store_init(git_common_path("worktrees/%s", wt->id),
+				      refs_all_capabilities);
+	else
+		refs = ref_store_init(get_git_common_dir(),
+				      refs_all_capabilities);
+
+	if (refs)
+		register_ref_store_map(&worktree_ref_stores, "worktree",
+				       refs, wt->id);
+	return refs;
+}
+
 void base_ref_store_init(struct ref_store *refs,
 			 const struct ref_storage_be *be)
 {
diff --git a/refs.h b/refs.h
index 49e97d7d5f..6df69a2adb 100644
--- a/refs.h
+++ b/refs.h
@@ -5,6 +5,7 @@ struct object_id;
 struct ref_store;
 struct strbuf;
 struct string_list;
+struct worktree;
 
 /*
  * Resolve a reference, recursively following symbolic refererences.
@@ -655,5 +656,6 @@ struct ref_store *get_main_ref_store(void);
  * submodule==NULL.
  */
 struct ref_store *get_submodule_ref_store(const char *submodule);
+struct ref_store *get_worktree_ref_store(const struct worktree *wt);
 
 #endif /* REFS_H */
-- 
2.11.0.157.gd943d85


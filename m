Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D655C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiGUGj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiGUGj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:39:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A9D5247D
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:39:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a5so799151wrx.12
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CjKbQSxjSLU4H4FdKciqb1gw8pQEvvBpj4at/MBM2o=;
        b=KDqGzfXpNgX+klxJSwGpQqnUsSldkgsrQ1F1GiIEHXw/jAGnHtgCMVp/6tuiiAvP5i
         7kaMgRfSatvTFKOY9qjLZ5s/lFM3zwd6MP+iB3G6GunK3NSYYWx8Ms5zJTHrA36GYbJ0
         E87Ds7X9KL9Ya1516gaEcs2qzBaQqjBjfXri07XQt+QOaqhpuGBmiuv1Sg07HpGYVDSq
         25YPla0CwL6hEqG7YkjW6L0Pd7GMomarcLPHiuq6WsSTpzmTwPZxLMgmtYR8vbxvODvH
         ShEZaiqc8iIl/Xh4F7BRTqEXpjpKpRTzNYWaOKhFrXR3VuUIgkzHaIFHoqJPMdBACDCO
         fsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0CjKbQSxjSLU4H4FdKciqb1gw8pQEvvBpj4at/MBM2o=;
        b=JISfHL27W+xYlbh4WLx0FQEFFaKAAd+Eyr8Ko9BKybiRO48o2l0O1Xf42XH9zTXPnV
         5h2wdX4r3jMh55exxs+gkQz1Szocd2MIvJWYW0eER67Ml10jDvGyn3accdwuydkTJZgp
         SF7cMnkL9rUbUXxdLWhiaTyxqXIebb4hv4E4P/WoA4fBCnvsntrHdFmxjyz0xNrhOTwR
         1oVjOdb0MgkmhCxPNjCkp6Ffuv4FLKGZq1F/fwG0LohVgF1P0U/+MiK+WbxJnyk4GYTA
         dzXHIUYff/IDw8IwbsaLrKvISTlxoYoIS8pjzSr+aBdI63nfMHxBeCJMM5OWY9QpQ63d
         jkmQ==
X-Gm-Message-State: AJIora/GIr3GO3Q5KfowoM2cxOaE5Q6Vy+7lP+W5dtKpfP2VaP2Ly3Rj
        aI79Its5857RdJBc7ZK39N25mhI/y9O2Mg==
X-Google-Smtp-Source: AGRyM1vzMqUvitq97s7Ow1jRi7xYX8GZhRY03MOy3resOwuD4SMuDDzBrf/wKjHedsWMvO+riPI48w==
X-Received: by 2002:adf:dd82:0:b0:21d:62e3:a51 with SMTP id x2-20020adfdd82000000b0021d62e30a51mr32789437wrl.324.1658385594241;
        Wed, 20 Jul 2022 23:39:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r67-20020a1c2b46000000b003a308e9a192sm4641137wmr.30.2022.07.20.23.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:39:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] string_list API users + cocci: use string_list_init_dup()
Date:   Thu, 21 Jul 2022 08:39:44 +0200
Message-Id: <patch-1.2-c89758491e7-20220721T063543Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220721T063543Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a coccinelle rule to detect a particular misuse of the "struct
string_list" API. We have the *_INIT macros, but this code assumed
that a zero'd out "struct string_list" with a "strdup_string" set
would be the same as string_list_init_dup().

That assumption happens to be right, but let's instead use the helper
functions introduced in 183113a5ca9 (string_list: Add STRING_LIST_INIT
macro and make use of it., 2010-07-04).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/string_list.cocci     | 8 ++++++++
 contrib/coccinelle/tests/string_list.c   | 7 +++++++
 contrib/coccinelle/tests/string_list.res | 7 +++++++
 refs.c                                   | 4 ++--
 resolve-undo.c                           | 8 ++++----
 revision.c                               | 4 ++--
 6 files changed, 30 insertions(+), 8 deletions(-)
 create mode 100644 contrib/coccinelle/string_list.cocci
 create mode 100644 contrib/coccinelle/tests/string_list.c
 create mode 100644 contrib/coccinelle/tests/string_list.res

diff --git a/contrib/coccinelle/string_list.cocci b/contrib/coccinelle/string_list.cocci
new file mode 100644
index 00000000000..5d285d5732c
--- /dev/null
+++ b/contrib/coccinelle/string_list.cocci
@@ -0,0 +1,8 @@
+@@
+struct string_list *P;
+@@
+- CALLOC_ARRAY(P, 1);
++ ALLOC_ARRAY(P, 1);
+... when != P
+- (P)->strdup_strings = 1;
++ string_list_init_dup(P);
diff --git a/contrib/coccinelle/tests/string_list.c b/contrib/coccinelle/tests/string_list.c
new file mode 100644
index 00000000000..e77822b7682
--- /dev/null
+++ b/contrib/coccinelle/tests/string_list.c
@@ -0,0 +1,7 @@
+int init(void)
+{
+	struct string_list *list;
+
+	CALLOC_ARRAY(list, 1);
+	list->strdup_strings = 1;
+}
diff --git a/contrib/coccinelle/tests/string_list.res b/contrib/coccinelle/tests/string_list.res
new file mode 100644
index 00000000000..7e666f5bf48
--- /dev/null
+++ b/contrib/coccinelle/tests/string_list.res
@@ -0,0 +1,7 @@
+int init(void)
+{
+	struct string_list *list;
+
+	ALLOC_ARRAY(list, 1);
+	string_list_init_dup(list);
+}
diff --git a/refs.c b/refs.c
index 90bcb271687..83151a42b3a 100644
--- a/refs.c
+++ b/refs.c
@@ -1313,8 +1313,8 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 		while (len && ref[len - 1] == '/')
 			ref[--len] = '\0';
 		if (!hide_refs) {
-			CALLOC_ARRAY(hide_refs, 1);
-			hide_refs->strdup_strings = 1;
+			ALLOC_ARRAY(hide_refs, 1);
+			string_list_init_dup(hide_refs);
 		}
 		string_list_append(hide_refs, ref);
 	}
diff --git a/resolve-undo.c b/resolve-undo.c
index e81096e2d45..e66b8306fe0 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -15,8 +15,8 @@ void record_resolve_undo(struct index_state *istate, struct cache_entry *ce)
 		return;
 
 	if (!istate->resolve_undo) {
-		CALLOC_ARRAY(resolve_undo, 1);
-		resolve_undo->strdup_strings = 1;
+		ALLOC_ARRAY(resolve_undo, 1);
+		string_list_init_dup(resolve_undo);
 		istate->resolve_undo = resolve_undo;
 	}
 	resolve_undo = istate->resolve_undo;
@@ -57,8 +57,8 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 	int i;
 	const unsigned rawsz = the_hash_algo->rawsz;
 
-	CALLOC_ARRAY(resolve_undo, 1);
-	resolve_undo->strdup_strings = 1;
+	ALLOC_ARRAY(resolve_undo, 1);
+	string_list_init_dup(resolve_undo);
 
 	while (size) {
 		struct string_list_item *lost;
diff --git a/revision.c b/revision.c
index 0c6e26cd9c8..e44af92cacc 100644
--- a/revision.c
+++ b/revision.c
@@ -1578,8 +1578,8 @@ void clear_ref_exclusion(struct string_list **ref_excludes_p)
 void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
 {
 	if (!*ref_excludes_p) {
-		CALLOC_ARRAY(*ref_excludes_p, 1);
-		(*ref_excludes_p)->strdup_strings = 1;
+		ALLOC_ARRAY(*ref_excludes_p, 1);
+		string_list_init_dup(*ref_excludes_p);
 	}
 	string_list_append(*ref_excludes_p, exclude);
 }
-- 
2.37.1.1095.g64a1e8362fd


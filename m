Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75EEC433FE
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 18:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376628AbhLBSne (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 13:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348349AbhLBSna (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 13:43:30 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3483BC061758
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 10:40:07 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so3072468wme.0
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 10:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eOVaXRyEW4I+R8MQt1q26NykBYsWtrIR+bY5GzLeR/8=;
        b=SipttDS+OLVDgDkqY6Y4mZm3XZ1nziGlDK6WpqXMXW2nY+ZTxASy1srpgaTf9LSUGd
         X8e087Xscvl6KQFKoD0Y/odC8e9Ay1uN9uJd/k+bn6YLhVhraJuv2jeK6KuYdou+pmpt
         +rEbG+jgxWXIIPqapeNe1+1sk7kIqOTDwHMO6KDypYQHCsiZQQ6qpLU9f91adCjW2WJo
         B9T72yoABL79NO5lwZFxOKtRCPRUxT1sJKOPuE//angmOqFnYs93gmApT/m3yenUM1Af
         bLe2WxPVUxicP10KtSuQuP3yiKaTL0yRWsONJGnwyoHoN9UhAX/UqKraT+JcQYLLzrqQ
         qAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eOVaXRyEW4I+R8MQt1q26NykBYsWtrIR+bY5GzLeR/8=;
        b=6whxEUU9qLpVjsGlRIDSkS69IDxRWw+fygeNNiTs5JXNZhnSQiK+DvGxVKAKA+RGwo
         txJS5o1GRn68KVOGUBlxAptZo5AbNjAK7kKFRj2EQhKXks/1hszqur3VUomUYxAOXexY
         Pdbths/aeUro7OI+qhbaLGcUWpe3UMHRL93SFXodsRTkFIMOJOfAVz6GDL2kGx9YCntj
         cYqSmhWmq5tB5qaSnA9iTiJfviw1zh/1S3gLJPgTdnULxS9FZkX/VxtJQDK1GK0J9J/X
         8E6Th057DSoDFW3mBeehLotBc1H+nOgtSld0GP5NXM/FN9taCqqvwzNViqY8J0fIj4+z
         p81w==
X-Gm-Message-State: AOAM530xkMc0GqZraTCgvEmeU3Z/+kvyCBoNej+DTL4bEO2GYVnAGqUZ
        r+Mugz5dKveHjMCW/08Ggk0GQoNVTYg=
X-Google-Smtp-Source: ABdhPJzVtRguGdqeQ5FfGqVeEtAQMCoJdhNQFnDEd6z7pDPro4C+5XeueTQFlDXtEqF1NOfb3ZI6vQ==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr8275429wmm.163.1638470405581;
        Thu, 02 Dec 2021 10:40:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x13sm559271wrr.47.2021.12.02.10.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 10:40:05 -0800 (PST)
Message-Id: <3cdebd2dbcad2f6d428d88846569d6563249dad8.1638470403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
References: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 18:39:56 +0000
Subject: [PATCH v3 2/8] test-ref-store: parse symbolic flag constants
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This lets tests use REF_XXXX constants instead of hardcoded integers. The flag
names should be separated by a ','.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c | 69 +++++++++++++++++++++++++++++++++++----
 t/t1405-main-ref-store.sh |  3 +-
 2 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b795a56eedf..cbf1b5f506d 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -5,6 +5,50 @@
 #include "object-store.h"
 #include "repository.h"
 
+struct flag_definition {
+	const char *name;
+	uint64_t mask;
+};
+
+#define FLAG_DEF(x)     \
+	{               \
+#x, (x) \
+	}
+
+static unsigned int parse_flags(const char *str, struct flag_definition *defs)
+{
+	struct string_list masks = STRING_LIST_INIT_DUP;
+	int i = 0;
+	unsigned int result = 0;
+
+	if (!strcmp(str, "0"))
+		return 0;
+
+	string_list_split(&masks, str, ',', 64);
+	for (; i < masks.nr; i++) {
+		const char *name = masks.items[i].string;
+		struct flag_definition *def = defs;
+		int found = 0;
+		while (def->name) {
+			if (!strcmp(def->name, name)) {
+				result |= def->mask;
+				found = 1;
+				break;
+			}
+			def++;
+		}
+		if (!found)
+			die("unknown flag \"%s\"", name);
+	}
+
+	string_list_clear(&masks, 0);
+	return result;
+}
+
+static struct flag_definition empty_flags[] = {
+	{ NULL, 0 },
+};
+
 static const char *notnull(const char *arg, const char *name)
 {
 	if (!arg)
@@ -12,9 +56,10 @@ static const char *notnull(const char *arg, const char *name)
 	return arg;
 }
 
-static unsigned int arg_flags(const char *arg, const char *name)
+static unsigned int arg_flags(const char *arg, const char *name,
+			      struct flag_definition *defs)
 {
-	return atoi(notnull(arg, name));
+	return parse_flags(notnull(arg, name), defs);
 }
 
 static const char **get_store(const char **argv, struct ref_store **refs)
@@ -64,10 +109,14 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 	return argv + 1;
 }
 
+static struct flag_definition pack_flags[] = {
+	FLAG_DEF(PACK_REFS_PRUNE),
+	FLAG_DEF(PACK_REFS_ALL),
+};
 
 static int cmd_pack_refs(struct ref_store *refs, const char **argv)
 {
-	unsigned int flags = arg_flags(*argv++, "flags");
+	unsigned int flags = arg_flags(*argv++, "flags", pack_flags);
 
 	return refs_pack_refs(refs, flags);
 }
@@ -81,9 +130,15 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
 	return refs_create_symref(refs, refname, target, logmsg);
 }
 
+static struct flag_definition transaction_flags[] = {
+	FLAG_DEF(REF_NO_DEREF),
+	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
+	{ NULL, 0 },
+};
+
 static int cmd_delete_refs(struct ref_store *refs, const char **argv)
 {
-	unsigned int flags = arg_flags(*argv++, "flags");
+	unsigned int flags = arg_flags(*argv++, "flags", transaction_flags);
 	const char *msg = *argv++;
 	struct string_list refnames = STRING_LIST_INIT_NODUP;
 
@@ -120,7 +175,7 @@ static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 {
 	struct object_id oid = *null_oid();
 	const char *refname = notnull(*argv++, "refname");
-	int resolve_flags = arg_flags(*argv++, "resolve-flags");
+	int resolve_flags = arg_flags(*argv++, "resolve-flags", empty_flags);
 	int flags;
 	const char *ref;
 	int ignore_errno;
@@ -209,7 +264,7 @@ static int cmd_delete_ref(struct ref_store *refs, const char **argv)
 	const char *msg = notnull(*argv++, "msg");
 	const char *refname = notnull(*argv++, "refname");
 	const char *sha1_buf = notnull(*argv++, "old-sha1");
-	unsigned int flags = arg_flags(*argv++, "flags");
+	unsigned int flags = arg_flags(*argv++, "flags", transaction_flags);
 	struct object_id old_oid;
 
 	if (get_oid_hex(sha1_buf, &old_oid))
@@ -224,7 +279,7 @@ static int cmd_update_ref(struct ref_store *refs, const char **argv)
 	const char *refname = notnull(*argv++, "refname");
 	const char *new_sha1_buf = notnull(*argv++, "new-sha1");
 	const char *old_sha1_buf = notnull(*argv++, "old-sha1");
-	unsigned int flags = arg_flags(*argv++, "flags");
+	unsigned int flags = arg_flags(*argv++, "flags", transaction_flags);
 	struct object_id old_oid;
 	struct object_id new_oid;
 
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 5e0f7073286..63e0ae82bdf 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -17,8 +17,7 @@ test_expect_success 'setup' '
 test_expect_success REFFILES 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
 	N=`find .git/refs -type f | wc -l` &&
 	test "$N" != 0 &&
-	ALL_OR_PRUNE_FLAG=3 &&
-	$RUN pack-refs ${ALL_OR_PRUNE_FLAG} &&
+	$RUN pack-refs PACK_REFS_PRUNE,PACK_REFS_ALL &&
 	N=`find .git/refs -type f` &&
 	test -z "$N"
 '
-- 
gitgitgadget


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C359C47089
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 20:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiK3Ubc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 15:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiK3UbH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 15:31:07 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC857062A
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:30:57 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x17-20020a17090a8a9100b002196a3b190cso2331517pjn.6
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ORptEKDWT/5lQ5u4HKujRlDs50a/yOrczO3C14UbvG8=;
        b=jACzVdrjoXTOsbz87B5tvvWZTEyggskT9G/b9GJijg8uEULtAPFMqH8j+5Qjk6uqVe
         L2ulzo2fSbdX3/fox2HmBs+mX3kf5sX/1LnAfxZC/eVJYpNTjsdfQBe5SIsJJUSEj1aC
         H39v/zpPDMhV+l1zoYJRG49CpL7lheRVsxvMNy1G6ssiDyi/bbZeZ1PX/KXxMk6iCfbR
         Fb+Hv4kWQWmLD1piB3i0SSEjiUQqoVJ0d7YPmPb+TATM502f0Hp7Aw5j6sXbl/s4WzYa
         37ZsTE0Fd2hwZM5e79Z54cDFo1qSdMjsU5fOJpQlH86rk7qmGEutHEHv+BCwd5CH2127
         Qe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORptEKDWT/5lQ5u4HKujRlDs50a/yOrczO3C14UbvG8=;
        b=i4zTHAiPsGjnaEfnxLpND5/xxNnVbU9llvW/q3J8QdoVuNfR5OtjYeLb2iXy/JU9NL
         cP9vRiF1hBFvg9759rjap4RQqkJA12G2rsudowpOplkJOQdUP25jtj0ioi/gtDYTlgm9
         zAM4w+mDyjF1Cast7Nkgmdo3vm6Yhh0/Z8dcYU9TyT9WHiKCGG1yj4WpIJ244jCDWjHq
         8Ip1xaSxri6buTzykI6bkqFucGlqVznyety0NHKo0i2yYs1qKq9+K1/p5nUdn0qQ/HZg
         Z3B4dboss9NWLUD862nkPZQ+4w2eUoOvRDGRc0y/biWgbu9+4WVhzzKqiT7308MLIHFd
         YmPQ==
X-Gm-Message-State: ANoB5pnaO9TqaeZ+WobGiIHMUAbLr0ccCMVeLZurfMlzUobBHm5LkJi1
        AEpj2h5hOM5KOs3zMGMqNBtvXUdZjVwyOkCwy+/Fzec4kdV3E03t7+FBQYcMI64Uzaumi97422A
        +k1QG+dg7xwz8mgN64+vP0Woe6obUukIJBsD4T4XsuZUjTFqNPMm5SBq0guUlmuDJYx27pyxIn7
        ns
X-Google-Smtp-Source: AA0mqf4G/hUOlGuXP+qFasvVGmqgEL7+53kI2AYcGbUuVbgpfFhot92Y+3F68M88B45xF7IvA/Y+Ca8oW42uyeUDmOdC
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:8d0e:0:b0:574:6a48:3fd9 with
 SMTP id j14-20020aa78d0e000000b005746a483fd9mr35327897pfe.36.1669840257228;
 Wed, 30 Nov 2022 12:30:57 -0800 (PST)
Date:   Wed, 30 Nov 2022 12:30:47 -0800
In-Reply-To: <cover.1669839849.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <a8c5fcd9f860a0434f974779bae6edf6a8ceeaca.1669839849.git.jonathantanmy@google.com>
Subject: [PATCH 2/4] object-file: refactor corrupt object diagnosis
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This functionality will be used from another file in a subsequent patch,
so refactor it into a public function.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c  | 29 ++++++++++++++++++-----------
 object-store.h |  9 +++++++++
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/object-file.c b/object-file.c
index 1cde477267..37468bc256 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1705,9 +1705,6 @@ void *read_object_file_extended(struct repository *r,
 				int lookup_replace)
 {
 	void *data;
-	const struct packed_git *p;
-	const char *path;
-	struct stat st;
 	const struct object_id *repl = lookup_replace ?
 		lookup_replace_object(r, oid) : oid;
 
@@ -1715,26 +1712,36 @@ void *read_object_file_extended(struct repository *r,
 	data = read_object(r, repl, type, size);
 	if (data)
 		return data;
+	die_if_corrupt(r, oid, repl);
+
+	return NULL;
+}
+
+void die_if_corrupt(struct repository *r,
+		    const struct object_id *oid,
+		    const struct object_id *real_oid)
+{
+	const struct packed_git *p;
+	const char *path;
+	struct stat st;
 
 	obj_read_lock();
 	if (errno && errno != ENOENT)
 		die_errno(_("failed to read object %s"), oid_to_hex(oid));
 
 	/* die if we replaced an object with one that does not exist */
-	if (repl != oid)
+	if (real_oid != oid)
 		die(_("replacement %s not found for %s"),
-		    oid_to_hex(repl), oid_to_hex(oid));
+		    oid_to_hex(real_oid), oid_to_hex(oid));
 
-	if (!stat_loose_object(r, repl, &st, &path))
+	if (!stat_loose_object(r, real_oid, &st, &path))
 		die(_("loose object %s (stored in %s) is corrupt"),
-		    oid_to_hex(repl), path);
+		    oid_to_hex(real_oid), path);
 
-	if ((p = has_packed_and_bad(r, repl)))
+	if ((p = has_packed_and_bad(r, real_oid)))
 		die(_("packed object %s (stored in %s) is corrupt"),
-		    oid_to_hex(repl), p->pack_name);
+		    oid_to_hex(real_oid), p->pack_name);
 	obj_read_unlock();
-
-	return NULL;
 }
 
 void *read_object_with_reference(struct repository *r,
diff --git a/object-store.h b/object-store.h
index 1be57abaf1..88c879c61e 100644
--- a/object-store.h
+++ b/object-store.h
@@ -256,6 +256,15 @@ static inline void *repo_read_object_file(struct repository *r,
 #define read_object_file(oid, type, size) repo_read_object_file(the_repository, oid, type, size)
 #endif
 
+/*
+ * Dies if real_oid is corrupt, not just missing.
+ *
+ * real_oid should be an oid that could not be read.
+ */
+void die_if_corrupt(struct repository *r,
+		    const struct object_id *oid,
+		    const struct object_id *real_oid);
+
 /* Read and unpack an object file into memory, write memory to an object file */
 int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
 
-- 
2.38.1.584.g0f3c55d4c2-goog


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7756AC43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 19:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiLAT1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 14:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiLAT1l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 14:27:41 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0488E0ED
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 11:27:39 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id om6-20020a17090b3a8600b0021965c06195so6649128pjb.2
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 11:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TodTgJTHAfLxIfznVa94Ovf+scmC3jr+AlIcU9Dzm4=;
        b=pDKF/tpBIVDMEj6owmRAVD6W9Mhf4aR0Wy6qDAF1EuTECUKbh8Dr2X6xOhI68ntEq5
         TzSdWz5Q8dhzinzq6pOltBrYHRdiZeAmmCcMM3ikJIi8xJ+e+vUrOGNGofDK9b2FcRuC
         aXg1TPwqjy5jWDlM9/iiaVskyIoo3wZWufb7uKmWM70NuPws1R6+SMYDiTVBlbwIR3Xz
         BxfIoidiqJ9t8q/p4qVZOxm/lCzlha9WjjN6Q6ZCD0d1FTo3w7w9f9S7XOyMow9Gk2g7
         GP8N1Ekc0bpv4hz8NdCKComYN5RpxrRx3cXRVFrKLiRS8mOXeJ0CCdGsgfMSHMLbZzeB
         6nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TodTgJTHAfLxIfznVa94Ovf+scmC3jr+AlIcU9Dzm4=;
        b=thYRQfkkG2UBELEpGGj/YbChkzIusvc6XSCRm0XzUXRPCb9WBqjFXr28DYV1rZ0ZZt
         LrjrDWaAnoCWzWqzcRvHbe8PPceHrsFfFXGmLgn087ec8zD4uoPXfwxGm+FIVb8S1Kqq
         en+6kQM7yj6XsKVE3BF/hGv37c/e9q3epjDY68bLWrH9kYFtLNBV0MiVqDZStWuU4gjO
         xTmPCthsQKyVsWjlxMBLxpOd3PquACI21pV+Kim2T8jloO2JFLMXQQJi8ZtcbkSfh+bd
         +O7z7a1jxNpavcy50nraFYcWoqVuw7PF4rMG9DigWeBvT+VaOD/dyOipofv6caaQ5B7q
         QaeQ==
X-Gm-Message-State: ANoB5pmUw3yxIPD/leXt2U2cpgpxpUvqntlbfCf+7QnYc5YZg0wNP67U
        X8sOrJm/WFf+B86/i0npWNVnrMgpdsbgTYMin0dbXNKpAMeUxoWnd9IeuzPbf6cB1nwMcoZMby9
        H9AyGEdqqLcJS+X7pGSlpPJY3lGgDYfG1o5quHq4iB4zSOtArXOE/dYBHg20bVXQNIyq1oYAiYZ
        n9
X-Google-Smtp-Source: AA0mqf6xd5ciR4YBH5S8DBrWbjY38Ijmrryj2H9mjmHytxFmTN4agLy72Dz5L1INtw9UoMdtjo2/oHSrCWXlvedL/sUG
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:f89:b0:219:5b3b:2b9f with
 SMTP id ft9-20020a17090b0f8900b002195b3b2b9fmr1267857pjb.2.1669922859141;
 Thu, 01 Dec 2022 11:27:39 -0800 (PST)
Date:   Thu,  1 Dec 2022 11:27:31 -0800
In-Reply-To: <cover.1669922792.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1669922792.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <1be60f1bf2f368f5e5c8b6550b3e4d4f3efe1496.1669922792.git.jonathantanmy@google.com>
Subject: [PATCH v2 2/4] object-file: refactor corrupt object diagnosis
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
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
index 1cde477267..36f81c7958 100644
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
+	if (!oideq(real_oid, oid))
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
2.39.0.rc0.267.gcb52ba06e7-goog


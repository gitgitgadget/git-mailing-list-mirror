Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E32C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 20:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiK3Ubk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 15:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiK3UbU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 15:31:20 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A1783257
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:30:59 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3d0465d32deso56909817b3.20
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=65M7tiq/FJ1u1l1cHdwb9zK5l8rNjAqx7bihp6tcD3Y=;
        b=VqGIbI+eCnlVQ5UDFNxo96i3PKvpJlxt0IbCc2+28U9cotjkLR21603HzbEFp8Nvrf
         QY1C0XVr+BXzxwSmtzD6iGWIt7i8+BG0XEfUdgM1VWIdltaE7pH5ZNmbUhLcz/h+A15Z
         8tQjSV2UltxPrK9KJgYntLwLPppJ6Dz+aKJbOOCPo62+nbAuNRjOg6pYaTwe2jyP21cr
         TrmXB45ddp9hIJc+iQNAeOec3HPTfg6v5dQwyqMdqkVRFaPqmrRJWxJBIYbJVjc8bZk6
         4o0Rbzum7JuA5Z8w0dLAG2E/tA77j/gMi3iTfFfuyTNeG1skcpEGtn49Mw3ibeIrLYRq
         lrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65M7tiq/FJ1u1l1cHdwb9zK5l8rNjAqx7bihp6tcD3Y=;
        b=jlQcCskzVLJ6O7xnuxqjbyJO4O4zyn0XqWYJk/S4j0uCzjCHCZ+jSgRnT7aCWRmZw5
         TGQdBAzU0XUhGgGwKPjfJgiFyGaE7Pldh6h0HvQFZhLfoROPvY2eU4YZHKFV00/NEEOU
         qIAMjx/alL7Ai2RHiD0ELXXhot5vnZKbgA5ce7KwJDq87/V9xQ7qNd9EhdhXnDf5dntE
         tG4wQ1P2GRy7nyBun+SXPL3+RoSpgMaKgYPUn3lGTi5JQAREm2ol/fM0Jm3ri6fJDoHP
         LO/x12dZaQrkXOi479VjANTwqPepezT1FJv/Li9ss4TqKYdgBOL5gAtExI4NnM1bdmPg
         QR5g==
X-Gm-Message-State: ANoB5ploq9wzatU6m5SLcM6yuOI0wutmlW6mLd6p8nS/CCEzRmNqIVQm
        y84Z4xLYBS6p7ISUxs/7DXLB11ragpsZaGBghQQLZQ9ip1LRl4YZ9F1/Gnz/o1TbKHp5bWt68gh
        iTAflVh+T+OOAsH3NSyjuMLFanhx7tcA9qaHwFNXlvNqPfLo3F/1tJnzm2fpT+eehK56zfHjnNo
        ++
X-Google-Smtp-Source: AA0mqf6yrc09RaBQrXarfbZqFtEKsHt+z3lSVPlhO/XlFaMRIRyk76lPSWVgoxEiS3rLp1Re1VfUYHtZ/JQH/VuFVdF6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:a241:0:b0:6ee:e865:c2e2 with
 SMTP id b59-20020a25a241000000b006eee865c2e2mr39262872ybi.206.1669840258972;
 Wed, 30 Nov 2022 12:30:58 -0800 (PST)
Date:   Wed, 30 Nov 2022 12:30:48 -0800
In-Reply-To: <cover.1669839849.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <940396307fea59b434d33edbf2c7f98adc62c053.1669839849.git.jonathantanmy@google.com>
Subject: [PATCH 3/4] object-file: refactor replace object lookup
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the replace object lookup (specifically, the ability for the caller
to know the result of the lookup) from read_object_file_extended()
to one of the functions that it indirectly calls,
do_oid_object_info_extended(), because a subsequent patch will need that
ability from the latter.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c  | 28 +++++++++++++++++++++-------
 object-store.h |  1 +
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/object-file.c b/object-file.c
index 37468bc256..fd394f1ace 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1546,6 +1546,11 @@ static int do_oid_object_info_extended(struct repository *r,
 
 	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
 		real = lookup_replace_object(r, oid);
+	if (oi && oi->real_oidp) {
+		if (!(flags & OBJECT_INFO_LOOKUP_REPLACE))
+			BUG("specifying real_oidp does not make sense without OBJECT_INFO_LOOKUP_REPLACE");
+		*oi->real_oidp = real;
+	}
 
 	if (is_null_oid(real))
 		return -1;
@@ -1659,17 +1664,27 @@ int oid_object_info(struct repository *r,
 	return type;
 }
 
+/*
+ * If real_oid is not NULL, check if oid has a replace object and store the
+ * object that we end up using there.
+ */
 static void *read_object(struct repository *r,
 			 const struct object_id *oid, enum object_type *type,
-			 unsigned long *size)
+			 unsigned long *size, const struct object_id **real_oid)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	void *content;
+	unsigned int flags = 0;
 	oi.typep = type;
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (oid_object_info_extended(r, oid, &oi, 0) < 0)
+	if (real_oid) {
+		flags |= OBJECT_INFO_LOOKUP_REPLACE;
+		oi.real_oidp = real_oid;
+	}
+
+	if (oid_object_info_extended(r, oid, &oi, flags) < 0)
 		return NULL;
 	return content;
 }
@@ -1705,14 +1720,13 @@ void *read_object_file_extended(struct repository *r,
 				int lookup_replace)
 {
 	void *data;
-	const struct object_id *repl = lookup_replace ?
-		lookup_replace_object(r, oid) : oid;
+	const struct object_id *real_oid;
 
 	errno = 0;
-	data = read_object(r, repl, type, size);
+	data = read_object(r, oid, type, size, &real_oid);
 	if (data)
 		return data;
-	die_if_corrupt(r, oid, repl);
+	die_if_corrupt(r, oid, real_oid);
 
 	return NULL;
 }
@@ -2283,7 +2297,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 
 	if (has_loose_object(oid))
 		return 0;
-	buf = read_object(the_repository, oid, &type, &len);
+	buf = read_object(the_repository, oid, &type, &len, NULL);
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
diff --git a/object-store.h b/object-store.h
index 88c879c61e..9684562eb2 100644
--- a/object-store.h
+++ b/object-store.h
@@ -406,6 +406,7 @@ struct object_info {
 	struct object_id *delta_base_oid;
 	struct strbuf *type_name;
 	void **contentp;
+	const struct object_id **real_oidp;
 
 	/* Response */
 	enum {
-- 
2.38.1.584.g0f3c55d4c2-goog


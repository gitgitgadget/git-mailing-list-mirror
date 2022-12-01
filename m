Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EE1C47088
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 19:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiLAT1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 14:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiLAT1n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 14:27:43 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03C61208C
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 11:27:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 187-20020a250dc4000000b006f8cd26bfcfso1063710ybn.13
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 11:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AjpFZiyVD04CAbZg7L/3S1F1hg/bH47GALCNYOb6SvM=;
        b=hiEmxEQpzrA+t2r+d5C1QT07SSEuybhGGrH8HVTeqX+neK7ia+DEJe1gImuwdslKf8
         bDX1JQcnzigPwn4Bvh4A2LwMfFvSVc5dJuWr+6Zbja7x7uMCmiRnO0dfWBJ//Ir3sxi4
         wVu2RbjVn520z1OlUjsLuKG9Lp+jGvcPYkdBtT7CJc4CgNHHJ80V3YdrNJH3FriRQHMf
         Zoel4SocdliAeginqhOTksxmbc1d3rzWa/6q7d2zJLge/RpM4EJc+g28Xm31IFlAPrjJ
         EgwWElXhdv8WIVl44on7f6zAFEctM2wV3Cx16szlwvblFBGs7c5s/RmQ52ohDLGQERKj
         BSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjpFZiyVD04CAbZg7L/3S1F1hg/bH47GALCNYOb6SvM=;
        b=SxzHFolOozr21DY7gy54DmmfP635it684BWQcTtMf77xuwJJagjdVNbBBAvxdwCcKi
         G5hF+2Bc/Xf3oCA4uq0rnGVPQ0/5QY/E2lFrT5sbEDx2nW1rgSmkWvsJ9MVG2Gsfg50L
         WYtIBzajH7ZJbOhIwzYIh3Ej+KYQfeWol0T+HhW7x63qKG9lllVZCTFo4EIIoo0XqE2H
         iJSY60FbXJiMeItlifNGvWO+IAKqBuTjV4DsJo+0HRQDLRVXgOUO90v9BXlR3lgyKE8y
         kUhF2ik/sax1dodjutPkjo69uUdLU9/yfpni2WJZZczcRPyKN4slZhvxDUE6UjZ3cv0Y
         KZ0A==
X-Gm-Message-State: ANoB5pm618NzHCYVsyHL0i+4aSeTtEkSGzTa/emzgwm3ujpWZjHNYExq
        2zDOhwIefXcG4uoODWfYZFAG32ib4NL7B2zCInbhnLo7GnWdAUMnJq7U1NQI3a2+wh3roacVDFs
        JEWw1k9ZtIor92VKFSbtKKdTGvJyUoobsEk8ezuewLOqCrN1RIQSpPGOhwtxJARphAA/AdabM35
        tt
X-Google-Smtp-Source: AA0mqf4kgJRO74CAhSWphjFhN6Zx7dXVUdHEnqWvYFrdXoRNn/r+yTARH15XN5ky9eEAC+Pti5kjrdIUMnR5eXtJsCgw
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:6344:0:b0:352:5ccb:2273 with
 SMTP id x65-20020a816344000000b003525ccb2273mr62146184ywb.315.1669922860840;
 Thu, 01 Dec 2022 11:27:40 -0800 (PST)
Date:   Thu,  1 Dec 2022 11:27:32 -0800
In-Reply-To: <cover.1669922792.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com> <cover.1669922792.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <28935ba1b0132fa4d1a9f93e1d65835a8da12455.1669922792.git.jonathantanmy@google.com>
Subject: [PATCH v2 3/4] object-file: refactor replace object lookup
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
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
index 36f81c7958..8adef99a7c 100644
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
2.39.0.rc0.267.gcb52ba06e7-goog


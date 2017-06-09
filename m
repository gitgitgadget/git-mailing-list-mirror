Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715A61F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 19:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbdFITXf (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 15:23:35 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33836 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbdFITXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 15:23:34 -0400
Received: by mail-pg0-f53.google.com with SMTP id v18so29355079pgb.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 12:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qHj2YpMiZw8jXkluvUmtT4SnzOy2ZCbjz32zhwzIyPE=;
        b=BZP+u6uLFnFOsOxxO84IDgClmJzp+mvKzDCeXFbbfSXLJuGrjrNq2nnncuKFIM5t/h
         ycfmjzRPTtQ7xpDjlhVaX69FIS/qbHhqpGJKgVPEQzGvqAalz8JTrV/dOmPQJI2upW4T
         ZTdn66ywEK9NxZhEgQLNLWmtM8v8bHMQQ3c5rei0i/+bogfFLxrbS1SUlNiizAuWTWrn
         i9aDOHfHhE4W3cVIRcL2ooXGcDqojitg0sU/wy8J/0By5yw2doFqo4DKST4z5z6nNgwf
         74HauwiD/B0c1A4BYvfWv0tcvPqlwB8Q0CZGmoWb3rymFG6c/23fyo1FYH7F3JdRyovF
         zPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qHj2YpMiZw8jXkluvUmtT4SnzOy2ZCbjz32zhwzIyPE=;
        b=A3WlS9ZzyvoXEY3HDn3PAbYN9xgq8FLJBvves3MzE5UcUCnNwhWIsdwWQPHgbFytL0
         PtBiO6BjLl/hKZK5kB+Iy2WuUcPxj+3rW1DERIYsk5E/yfn1F+IRhNBH7prn4NBRbgI8
         QEvSZ41C8KUemK0vNnOy5FXW16RqRHbLjc23djjOJ5cHpHeIllzaq7F/reNBuk46qfre
         8kKYNkhe4N5AgnOGzNoa+i9W7FBv5KgcGOO9c8VMBgIiBqYvr7RXGDuWHi6S7KSf2ou0
         F8T0BF2yRS0zIPK65uTEKoiOoTjEtU+0uUxWYDK5184t0vZoLE9RyLqj5zDk65SkFzQb
         C6gw==
X-Gm-Message-State: AODbwcC58zokiO+ZYQlhGYPcPcljS5VYQp+isGsENOJaWD9YZS9vJKGx
        OpCPM3jZOoyVMVpPiieQzw==
X-Received: by 10.84.232.197 with SMTP id x5mr42369866plm.248.1497036213451;
        Fri, 09 Jun 2017 12:23:33 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id f72sm5757924pfe.4.2017.06.09.12.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 12:23:32 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 1/4] sha1_file: teach packed_object_info about typename
Date:   Fri,  9 Jun 2017 12:23:23 -0700
Message-Id: <e7a79c114b7131ba286bf3f76789b2efaeeb1cf1.1497035376.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <cover.1497035376.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497035376.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 46f0344 ("sha1_file: support reading from a loose object of
unknown type", 2015-05-06), "struct object_info" gained a "typename"
field that could represent a type name from a loose object file, whether
valid or invalid, as opposed to the existing "typep" which could only
represent valid types. Some relatively complex manipulations were added
to avoid breaking packed_object_info() without modifying it, but it is
much easier to just teach packed_object_info() about the new field.
Therefore, teach packed_object_info() as described above.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sha1_file.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 59a4ed2ed..a52b27541 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2277,9 +2277,18 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 		*oi->disk_sizep = revidx[1].offset - obj_offset;
 	}
 
-	if (oi->typep) {
-		*oi->typep = packed_to_object_type(p, obj_offset, type, &w_curs, curpos);
-		if (*oi->typep < 0) {
+	if (oi->typep || oi->typename) {
+		enum object_type ptot;
+		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
+					     curpos);
+		if (oi->typep)
+			*oi->typep = ptot;
+		if (oi->typename) {
+			const char *tn = typename(ptot);
+			if (tn)
+				strbuf_addstr(oi->typename, tn);
+		}
+		if (ptot < 0) {
 			type = OBJ_BAD;
 			goto out;
 		}
@@ -2960,7 +2969,6 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
-	enum object_type real_type;
 	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
 
 	co = find_cached_object(real);
@@ -2992,18 +3000,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			return -1;
 	}
 
-	/*
-	 * packed_object_info() does not follow the delta chain to
-	 * find out the real type, unless it is given oi->typep.
-	 */
-	if (oi->typename && !oi->typep)
-		oi->typep = &real_type;
-
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
-		if (oi->typep == &real_type)
-			oi->typep = NULL;
 		return sha1_object_info_extended(real, oi, 0);
 	} else if (in_delta_base_cache(e.p, e.offset)) {
 		oi->whence = OI_DBCACHED;
@@ -3014,10 +3013,6 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
 					 rtype == OBJ_OFS_DELTA);
 	}
-	if (oi->typename)
-		strbuf_addstr(oi->typename, typename(*oi->typep));
-	if (oi->typep == &real_type)
-		oi->typep = NULL;
 
 	return 0;
 }
-- 
2.13.1.508.gb3defc5cc-goog


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1426620401
	for <e@80x24.org>; Thu, 15 Jun 2017 20:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbdFOUjm (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 16:39:42 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36737 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752660AbdFOUjk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 16:39:40 -0400
Received: by mail-pf0-f173.google.com with SMTP id x63so12439961pff.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 13:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rpTPV9xDT9DY624zyVASu39xQy1FuS4rtMr7LYL8e8A=;
        b=NdW6hn0qR3QReE7f1gC8BEntHwI7XfRQMO5GSzlVLhOLjVPuaOI/rYClgzEmiCYYCf
         x6Ff3fHFAnI5k7fQh1Q0uIph8cG3jWkj8Ag9vYfAen5V1EIe6IDYCHs2B/w4n4Np3pX6
         J+VWTHqrQI3r+iboJV2tUxWtmDMJd3Whoe3chTAJImDqzEF/2K7miOnt/RTxpIAkT7Kh
         3MsUXoJklgzNOOj+eWw/eXxjmlvB5Z0Zu17CcSldclIakzyHJF/cK4XJC9lU4BSKoilH
         4BnA0AiBpEo0pZ+/8ZnIHxKZaXjm4QVhxxbnjcrze8rE5FmjbvvGtKNoJu2kwmWxzK2M
         RinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rpTPV9xDT9DY624zyVASu39xQy1FuS4rtMr7LYL8e8A=;
        b=CjwJW2t4y4E4eChRFfeCE4yaoNnzcQ6WUShRWQHmJ2x2YUDviVYQ+XiuurphvZYe5u
         rLP6H1Zq1fiOgJVFg7lokBj5AbICPImyRI7TLEgxD28umP5TIhX7qQTNhF7JP30qfN6m
         +flyg+3fRYE9KWI3huKRlV/vjC2MkFqHN+vCRmCI4WfQBNKgpHI0HAvqHvpC8Oe525be
         ge4WcLOznSDOflbGxql3HoZjZv9ptSWKq4H6gxrrMKFNW+DhfbwCtH2PoRgquAq4KS7u
         v9q4WNZ20402giFEDRhbM0QBsAJ9kQH+q9i9qdTySTJrhPmu145MtigvfcIxNC+R6VhF
         NtUw==
X-Gm-Message-State: AKS2vOxRSGM9W8l2S2PUcitvwpAKj3bjyWX5yrGCUt7LP1LEuExwdJ4a
        9w2gB2HLJq4YsBDB6gxh0w==
X-Received: by 10.84.233.130 with SMTP id l2mr8405257plk.212.1497559178852;
        Thu, 15 Jun 2017 13:39:38 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id i2sm274226pfe.89.2017.06.15.13.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 13:39:37 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 1/4] sha1_file: teach packed_object_info about typename
Date:   Thu, 15 Jun 2017 13:39:28 -0700
Message-Id: <e7a79c114b7131ba286bf3f76789b2efaeeb1cf1.1497558850.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <cover.1497558850.git.jonathantanmy@google.com>
References: <cover.1497558850.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497558850.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497558850.git.jonathantanmy@google.com>
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
2.13.1.518.g3df882009-goog


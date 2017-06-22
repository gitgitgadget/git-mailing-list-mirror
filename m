Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1107A20401
	for <e@80x24.org>; Thu, 22 Jun 2017 00:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbdFVAkd (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 20:40:33 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34809 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbdFVAkc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 20:40:32 -0400
Received: by mail-pf0-f176.google.com with SMTP id s66so896454pfs.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 17:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zLz5B+EozbQNdRg8tPdpPA+a7AmV30XrGgm9PacoIf8=;
        b=neEhxQNGdPu4veH5k/FCFDqxnjDaaIdrm7IDOpJaYrDOJfIhZUeJ0gRXnKOHfDUemI
         6EoKJnCAfJQOVKYBcc3Ydsbtl/eujXV0w7vHK84k3pRZIUHJts8VEO8j/JsRNqjjx/3G
         E350C61NwsJshLCujmStHtTyRPEbljZyNJxoysYkMG6HIJmlS4JsAOSprCDd1DbK78Es
         KBNeZFJ6gs0dpSK0MUCnGa4e4eB/EnS6iY4yWq2xIApPy63oLnAMXa3S+hLlB1lXtCW6
         mkSdtKdJC23K++CiIhARf7BmqK5/NZ3A6V3cz2aiI01D11N8LH1u4aDZbAYBDVu09O8/
         85hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zLz5B+EozbQNdRg8tPdpPA+a7AmV30XrGgm9PacoIf8=;
        b=GZxrRPs0ZfaJv2BcrLz3VT46qTKbouts004SlFP0gmHpK1JhhLxE1V0lpnqrB+Grhq
         /ExSH0F1fJUMaCeUjuHUITr0o1i44drnf60EioF88pvOBOWxcPhHHImDBdPeK+cOWwwb
         xgzVN4q+TNm73TknPUyNkuQD7zSjwuUm79cGsr6av5GaHhXh0iRkFWGtkY74OJTyAA43
         8Lcfrg7l0/J+cO6ISiVdbyy6B9sBDIcqfsAXJwcaD7+DgyqSFrG7Vc8zVHfYihxDzzcF
         smofQFok1jnBoP02vyQXAmlAoIbayROXTdYpgK6WfUfV6/03SqPe6Vr91KmOXwbsLdAq
         A+cA==
X-Gm-Message-State: AKS2vOyvarYrtUuHa4tmsk39s9/szmHd2Rs1gfAEGy8Sg2g+IEbEHG7x
        zyKDAqvrp9iIEzRIIPBnkA==
X-Received: by 10.98.110.132 with SMTP id j126mr12819285pfc.115.1498092031256;
        Wed, 21 Jun 2017 17:40:31 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c205sm34658213pfb.74.2017.06.21.17.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 17:40:30 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v5 1/8] sha1_file: teach packed_object_info about typename
Date:   Wed, 21 Jun 2017 17:40:17 -0700
Message-Id: <e7a79c114b7131ba286bf3f76789b2efaeeb1cf1.1498091579.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com>
References: <cover.1498091579.git.jonathantanmy@google.com>
In-Reply-To: <cover.1498091579.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1498091579.git.jonathantanmy@google.com>
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
2.13.1.611.g7e3b11ae1-goog


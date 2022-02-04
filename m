Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05F5C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 13:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359142AbiBDNvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359091AbiBDNvi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9083BC06173D
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 05:51:37 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j25so10763273wrb.2
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 05:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3ei4Ewu2EZROseYDP4edKEuj5ZPhDL+Wzjsg1FbPdc=;
        b=bWNr9c/fbfoTL1KymWeUJba5V3e2O7JPkpUW4/8X1/cmRg3H6Wze3TBRO/a4d/kgVv
         eFtccNQ1tQwTPwc/vfrfgm3cMCQxueSwc4YAfnZJYEiTNG9j80P633MF9yX+UFU8t+6e
         N7D+U1WpBWAXMLw0jQytXirIYJwQcWoW1/dex5Hv7/euZOkGHmROkmJuiXsjnPFre/IN
         nFrnmAcM2I3JctPkg4kmExI3uVJzC/W3TUqnvx3DGF5gYOlGl00BLpBr9+XYnRkuTkRt
         oz73DOc01WlFFVdnkVb4EQSazjzvldDOsNPLP0lDpTrM+TFjDJiV5meAS6Y2irhdTDtY
         YkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3ei4Ewu2EZROseYDP4edKEuj5ZPhDL+Wzjsg1FbPdc=;
        b=H26hWBkGoo3JRZBdE1t/LVEwlrzm0zNjgNN35v+y46uutZNbBWmgYjE28bWGDjx3ne
         UDlIJO951PGHZdzWn4o1nUvDojvz5KrrZFu3XxWB2sA5vU5QBqZppAgxvR1FKZw4bp7m
         xLFMRzlhmhJOdYPsDqbSKY1Xp/UjgL24v42cYqzFIgfxV9Ffo3JoMff6IK0i51Sz6x+B
         rV9wEskGEl3LCqPWtjvs/4crCibW8fn4S02cInYl7VgsiMvaZrzImohbchZPiCaeTqkw
         BJXkgPESk8iSaOKcWzd9+mAe1H5XeVNPuLEUUDY2bk2SArzTROidWhcU29iqmFa2Dlet
         UL8Q==
X-Gm-Message-State: AOAM530TtLvneVWZblwEUIBMeCn8sZKJ9ALSDUW67OnrJcjHPd9HXF8A
        3sIV/WyhUvxSXdS7YUSt8MCnHy00bXMFWg==
X-Google-Smtp-Source: ABdhPJw30IgeuIzBuhgxC8BfUJuwhnmiaQfBGg0drlpJ4w6js/wLjkVbACfwA2Ldr+cSkMqSml7L7A==
X-Received: by 2002:a5d:4d50:: with SMTP id a16mr2596492wru.182.1643982695858;
        Fri, 04 Feb 2022 05:51:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z2sm205963wmi.22.2022.02.04.05.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/11] object API: make check_object_signature() oideq()-like, move docs
Date:   Fri,  4 Feb 2022 14:51:20 +0100
Message-Id: <patch-v2-06.11-636a647ac51-20220204T135005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the return value of check_object_signature() behave like oideq()
and memcmp() instead of returning negative values on failure.

This reduces the boilerplate required when calling the function, and
makes the calling code behave the same is if though we'd called
oideq(), which is basically what we're doing here. We already had some
callers using "f() < 0", with others using "!f()". Instead of
declaring the latter a bug let's convert all callers to it.

It is unfortunate that there's also cases where we "return -1" on
various errors, and we can't tell those apart from the expected OID
being less than the real OID, but this was the case already.

This change is rather dangerous stand-alone as we're changing the
return semantics, but not changing the prototype. Therefore any
out-of-tree code rebased on this change would start doing the opposite
of what it was meant to do. In a subsequent commit we'll make that a
non-issue by changing the signature of the function, ensuring that the
compiler will catch any such misuse.

While we're at it let's re-flow some of the callers to wrap at 79
characters, and move the API documentation to cache.h, where the
prototype of this function lives.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-export.c |  4 ++--
 builtin/index-pack.c  |  5 ++---
 builtin/mktag.c       |  5 ++---
 cache.h               |  9 +++++++++
 object-file.c         | 16 +++++-----------
 object.c              |  6 +++---
 pack-check.c          |  4 ++--
 7 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9f1c730e587..7a79cb186b1 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -299,8 +299,8 @@ static void export_blob(const struct object_id *oid)
 		buf = read_object_file(oid, &type, &size);
 		if (!buf)
 			die("could not read blob %s", oid_to_hex(oid));
-		if (check_object_signature(the_repository, oid, buf, size,
-					   type_name(type), NULL) < 0)
+		if (!check_object_signature(the_repository, oid, buf, size,
+					    type_name(type), NULL))
 			die("oid mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 01574378ce2..6db3e728ff4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1412,9 +1412,8 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		if (!data)
 			continue;
 
-		if (check_object_signature(the_repository, &d->oid,
-					   data, size,
-					   type_name(type), NULL))
+		if (!check_object_signature(the_repository, &d->oid, data,
+					    size, type_name(type), NULL))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 
 		/*
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 96a3686af53..a715bf53cf0 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -61,9 +61,8 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 		    type_name(*tagged_type), type_name(type));
 
 	repl = lookup_replace_object(the_repository, tagged_oid);
-	ret = check_object_signature(the_repository, repl,
-				     buffer, size, type_name(*tagged_type),
-				     NULL);
+	ret = !check_object_signature(the_repository, repl, buffer, size,
+				      type_name(*tagged_type), NULL);
 	free(buffer);
 
 	return ret;
diff --git a/cache.h b/cache.h
index 281f00ab1b1..3a156dcb37b 100644
--- a/cache.h
+++ b/cache.h
@@ -1319,6 +1319,15 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
+/**
+ * With in-core object data in "buf", rehash it to make sure the
+ * object name actually matches "oid" to detect object corruption.
+ * With "buf" == NULL, try reading the object named with "oid" using
+ * the streaming interface and rehash it to do the same.
+ *
+ * Treat the return value like oideq() (which is like memcmp()),
+ * except that negative values might also indicate a generic error.
+ */
 int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size, const char *type,
 			   struct object_id *real_oidp);
diff --git a/object-file.c b/object-file.c
index 271acf4dd15..4c38ddad5dc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1066,12 +1066,6 @@ int format_object_header(char *str, size_t size, enum object_type type,
 	return format_object_header_literally(str, size, name, objsize);
 }
 
-/*
- * With in-core object data in "buf", rehash it to make sure the
- * object name actually matches "oid" to detect object corruption.
- * With "buf" == NULL, try reading the object named with "oid" using
- * the streaming interface and rehash it to do the same.
- */
 int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size, const char *type,
 			   struct object_id *real_oidp)
@@ -1086,7 +1080,7 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 
 	if (buf) {
 		hash_object_file(r->hash_algo, buf, size, type, real_oid);
-		return !oideq(oid, real_oid) ? -1 : 0;
+		return oideq(oid, real_oid);
 	}
 
 	st = open_istream(r, oid, &obj_type, &size, NULL);
@@ -1113,7 +1107,7 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 	}
 	r->hash_algo->final_oid_fn(real_oid, &c);
 	close_istream(st);
-	return !oideq(oid, real_oid) ? -1 : 0;
+	return oideq(oid, real_oid);
 }
 
 int git_open_cloexec(const char *name, int flags)
@@ -2617,9 +2611,9 @@ int read_loose_object(const char *path,
 			git_inflate_end(&stream);
 			goto out;
 		}
-		if (check_object_signature(the_repository, expected_oid,
-					   *contents, *size,
-					   oi->type_name->buf, real_oid))
+		if (!check_object_signature(the_repository, expected_oid,
+					    *contents, *size,
+					    oi->type_name->buf, real_oid))
 			goto out;
 	}
 
diff --git a/object.c b/object.c
index c37501fc120..b778b32407d 100644
--- a/object.c
+++ b/object.c
@@ -279,7 +279,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (check_object_signature(r, repl, NULL, 0, NULL, NULL) < 0) {
+		if (!check_object_signature(r, repl, NULL, 0, NULL, NULL)) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
@@ -289,8 +289,8 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
-		if (check_object_signature(r, repl, buffer, size,
-					   type_name(type), NULL) < 0) {
+		if (!check_object_signature(r, repl, buffer, size,
+					    type_name(type), NULL)) {
 			free(buffer);
 			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
diff --git a/pack-check.c b/pack-check.c
index 3f418e3a6af..35cca10057c 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -142,8 +142,8 @@ static int verify_packfile(struct repository *r,
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    oid_to_hex(&oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-		else if (check_object_signature(r, &oid, data, size,
-						type_name(type), NULL))
+		else if (!check_object_signature(r, &oid, data, size,
+						 type_name(type), NULL))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
-- 
2.35.1.940.ge7a5b4b05f2


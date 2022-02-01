Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7C2C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 14:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbiBAOxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 09:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239536AbiBAOx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 09:53:28 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CFDC061751
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 06:53:28 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l25so32447885wrb.13
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 06:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/Xo0wVgPKBzazvAr/XlilEXWF0mmWaCHFyW89trm9U=;
        b=cekJ3UTmuQgDh8XDegxxOcdwnXDxc8MzRg6uy5Vsh48kyUekapgIzeCA39awPo88DY
         +HpFOw6SLPh7Zf0N4y1wvfXB4Zeau3zRtecrzuizSvytyrx6W/1mHcevRnu8ZqIjutiN
         Zl0OmePi6/7E/l7irjOQQ1LLvCeKXHGUAsB+hbY7MW7QcNq6WoR/MiaHfQkKxeusnfXE
         fGexqAnvGPBJtXWV6/KOC6+YUmOnUbgbx2EcMPjyeRfbAZs1FWd9PQzh6XNgodwzcG5D
         nI8z0VbbysAl/3ErV42v0Q6rPo7k9GSMQiYV4FykqxAgV0OrL9KKaAxnN4ACehvaP9O8
         ACtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/Xo0wVgPKBzazvAr/XlilEXWF0mmWaCHFyW89trm9U=;
        b=bUIj2asiUqO7k9TjsFfpQCV3qfHo6tdJmlp9UhVIz173Ec3jX7jXnT+rTmXU+0BYjd
         fedE/3eUcvCQ0yJdGDyQlKUXCoT72v3PWHEBXy515IW6d5Yus39oDO0wVRnKI6d3Z45d
         VZYQDPIh9OSSEA2brxeyawag+0t5q+OnkhMOPvFw/+Q+ynHB3ovzk5HfulbiB8boxE2F
         7giVNHwi1T5OqcQy4HMNU+LnDHURc24wyhrX8ckE1Sdx2XEhIfwpriarw1ts4IFadCev
         qijZtZAZAGKcxkX4+qc0tGLaGuWM+vWu/DYnYk589rTwpqf9QeFUFTS/Cnn1DV9d3vHw
         0tMQ==
X-Gm-Message-State: AOAM533hvKoG3Vf3Gn0ZGs7I/wixJ9QcFvdEixoeoc6/eLs3GM6m0usy
        ZVCf4qv1CrEpaoYavALr/f0S4DzZw9RHKg==
X-Google-Smtp-Source: ABdhPJxFvsqmmJDC4ic8K1U+arTjPtdZrajRV3RSraJkYnpaqAqNGGkHPXvavhmehpsqNtQUOmRwgw==
X-Received: by 2002:a05:6000:170b:: with SMTP id n11mr21994005wrc.163.1643727206458;
        Tue, 01 Feb 2022 06:53:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg17sm2492054wmb.2.2022.02.01.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 06:53:25 -0800 (PST)
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
Subject: [PATCH 08/10] object-file API: replace check_object_signature() with stream_*
Date:   Tue,  1 Feb 2022 15:53:10 +0100
Message-Id: <patch-08.10-70c3e84dd0d-20220201T144803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.913.g12b4baa2536
In-Reply-To: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the task of the the check_object_signature() function so that
it no longer confusingly does two unrelated things.

Now the "!map" branch of it is exposed as a renamed
stream_object_signature(). In preceding commits we migrated all of the
"if (map)" callers over to "hash_object_file_oideq()" or
"hash_object_file_literally()" followed by "!oideq(...)".

This makes the caller in parse_object() less confusing, as we'll now
no longer need to pass NULL for "map" and "OBJ_BAD" for the unused
"type" argument. The "verify_packfile()" caller is arguably a bit
worse off than before, but as we're only using this function in a
couple of places now a bit more verbosity there is acceptable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h       | 11 ++++++++---
 object-file.c | 17 +++--------------
 object.c      |  2 +-
 pack-check.c  |  8 ++++++--
 4 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/cache.h b/cache.h
index d9c68c66d53..881ae36fd47 100644
--- a/cache.h
+++ b/cache.h
@@ -1319,9 +1319,14 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
-int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *buf, unsigned long size, enum object_type type,
-			   struct object_id *real_oidp);
+
+/**
+ * stream_object_signature() tries to read the object named with "oid"
+ * using the streaming interface and rehash it to make sure the object
+ * name actually matches "oid" to detect object corruption.
+ */
+int stream_object_signature(struct repository *r, const struct object_id *oid,
+			    struct object_id *real_oidp);
 
 int finalize_object_file(const char *tmpfile, const char *filename);
 
diff --git a/object-file.c b/object-file.c
index 4a23a7aa79f..27f587d1dcd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1066,29 +1066,18 @@ int format_object_header(char *str, size_t size, enum object_type type,
 	return format_object_header_literally(str, size, name, objsize);
 }
 
-/*
- * With an in-core object data in "map", rehash it to make sure the
- * object name actually matches "oid" to detect object corruption.
- * With "map" == NULL, try reading the object named with "oid" using
- * the streaming interface and rehash it to do the same.
- */
-int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *map, unsigned long size, enum object_type type,
-			   struct object_id *real_oidp)
+int stream_object_signature(struct repository *r, const struct object_id *oid,
+			    struct object_id *real_oidp)
 {
 	struct object_id tmp;
 	struct object_id *real_oid = real_oidp ? real_oidp : &tmp;
+	unsigned long size;
 	enum object_type obj_type;
 	struct git_istream *st;
 	git_hash_ctx c;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
-	if (map) {
-		hash_object_file(r->hash_algo, map, size, type, real_oid);
-		return !oideq(oid, real_oid) ? -1 : 0;
-	}
-
 	st = open_istream(r, oid, &obj_type, &size, NULL);
 	if (!st)
 		return -1;
diff --git a/object.c b/object.c
index 795b1356a1b..bf51b2056e9 100644
--- a/object.c
+++ b/object.c
@@ -279,7 +279,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (check_object_signature(r, repl, NULL, 0, OBJ_BAD, NULL) < 0) {
+		if (stream_object_signature(r, repl, NULL) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
diff --git a/pack-check.c b/pack-check.c
index faceae610d3..5d5169507ec 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -142,8 +142,12 @@ static int verify_packfile(struct repository *r,
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    oid_to_hex(&oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-		else if (check_object_signature(r, &oid, data, size,
-						type, NULL))
+		else if (data && !hash_object_file_oideq(r->hash_algo, data,
+							 size, type, &oid,
+							 NULL))
+			err = error("packed %s from %s is corrupt",
+				    oid_to_hex(&oid), p->pack_name);
+		else if (!data && stream_object_signature(r, &oid, NULL))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
-- 
2.35.0.913.g12b4baa2536


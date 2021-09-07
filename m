Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA25C433FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE32E60F6D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbhIGLAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbhIGK7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A5AC0612E7
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u16so13779488wrn.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTMZsWmcbbPQ1jY9Fd2Vlkg9IlIs1cKyWXs/9KBZ1yw=;
        b=g/KhQFQ9HR04wU4LGFkRF+TxtjJgGrta1RArNTc/sK+qfSBNhQhiCQ1tASvqeqZcpI
         m//+P3iCskQsoUOEWPgYeiYRb/TnxfDuFtovFsNnZxzdBaVnlCTemWlFoWQrMk1yjouQ
         L6efVSJbhPonf5ZTgOwRmipvYaA2tfqq/7PHUgvVHaOvouWNIFlYEXco55+E4t2+2FyJ
         rr5AuOaOnYD5ra8NMcgmiUvk9qhUTwcAJjOTQ+kUm16bL/psrAjVbaH3Ub2YLHVRyGoz
         gb+jSuYXavrNVPIBaZvdfVsQ5yDo3gqfjOJ+Ars+t0j9hGj/fEMEWJZUU48F/+/3X7hI
         jjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTMZsWmcbbPQ1jY9Fd2Vlkg9IlIs1cKyWXs/9KBZ1yw=;
        b=bpxRwIYaRi3h33JroGfjFt4vDlWRKTRY/Rh45DKeR3nS+hJVtH4FlUJiyjrWW84I34
         wXB1hcZoJRv0CeHJjzCzbLFhH3YNzKPPrkuJuZT4nBZ245aH+UD4szBIvuY1IsQUPNva
         WFGyx7RPP9uH33TK2T8t/1o6RBI2BzIAFL/ZguyjxTWKgZ37zpzb2X9/n1zpBUF2zAaE
         eVn1YuCCtZUW+BX5qnht5Pm6O9csud0mYhzm0Ll6VUlTHyxWJShG+HxCaHmR7rszNEGJ
         fV/a9fqa3PB45f6+CQYawhskbVXMzgzYN36xDcJKBPaIvqnrjK1yVGfFsKhifRJ1qM4G
         Sy7g==
X-Gm-Message-State: AOAM533bHG+prwg+6bjWNSp65vb8KkRZZuIVzJndH/TT+4zWR6X58xnF
        erENs3dvDIp2UakPBo2uQcY3NEf2IdyDVg==
X-Google-Smtp-Source: ABdhPJxGn2E9tuV3i6HNp0CGzuugtuTpEWgLDzf33SVgiZCzenfvBHqguYOJAo2BuaFbUdAdS7FaVg==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr18278885wrp.94.1631012325172;
        Tue, 07 Sep 2021 03:58:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 22/22] fsck: report invalid object type-path combinations
Date:   Tue,  7 Sep 2021 12:58:17 +0200
Message-Id: <patch-v6-22.22-804673a17b0-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the error that's emitted in cases where we find a loose object
we parse, but which isn't at the location we expect it to be.

Before this change we'd prefix the error with a not-a-OID derived from
the path at which the object was found, due to an emergent behavior in
how we'd end up with an "OID" in these codepaths.

Now we'll instead say what object we hashed, and what path it was
found at. Before this patch series e.g.:

    $ git hash-object --stdin -w -t blob </dev/null
    e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
    $ mv objects/e6/ objects/e7

Would emit ("[...]" used to abbreviate the OIDs):

    git fsck
    error: hash mismatch for ./objects/e7/9d[...] (expected e79d[...])
    error: e79d[...]: object corrupt or missing: ./objects/e7/9d[...]

Now we'll instead emit:

    error: e69d[...]: hash-path mismatch, found at: ./objects/e7/9d[...]

Furthermore, we'll do the right thing when the object type and its
location are bad. I.e. this case:

    $ git hash-object --stdin -w -t garbage --literally </dev/null
    8315a83d2acc4c174aed59430f9a9c4ed926440f
    $ mv objects/83 objects/84

As noted in an earlier commits we'd simply die early in those cases,
until preceding commits fixed the hard die on invalid object type:

    $ git fsck
    fatal: invalid object type

Now we'll instead emit sensible error messages:

    $ git fsck
    error: 8315[...]: hash-path mismatch, found at: ./objects/84/15[...]
    error: 8315[...]: object is of unknown type 'garbage': ./objects/84/15[...]

In both fsck.c and object-file.c we're using null_oid as a sentinel
value for checking whether we got far enough to be certain that the
issue was indeed this OID mismatch.

In the case of check_object_signature() I don't really trust all the
moving parts there to behave consistently, in the face of future
refactorings. Getting it wrong would mean that we'd potentially emit
no error at all on a failing check_object_signature(), or worse
misreport whatever issue we encountered. So let's use the new bug()
function to ferry and return code up to fsck_loose() in that case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fast-export.c |  2 +-
 builtin/fsck.c        | 13 +++++++++----
 builtin/index-pack.c  |  2 +-
 builtin/mktag.c       |  3 ++-
 object-file.c         | 21 ++++++++++++---------
 object-store.h        |  4 +++-
 object.c              |  4 ++--
 pack-check.c          |  3 ++-
 t/t1006-cat-file.sh   |  2 +-
 t/t1450-fsck.sh       |  8 +++++---
 10 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 3c20f164f0f..48a3b6a7f8f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -312,7 +312,7 @@ static void export_blob(const struct object_id *oid)
 		if (!buf)
 			die("could not read blob %s", oid_to_hex(oid));
 		if (check_object_signature(the_repository, oid, buf, size,
-					   type_name(type)) < 0)
+					   type_name(type), NULL) < 0)
 			die("oid mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 07af0434db6..158b9dac9b3 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -603,20 +603,25 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
 	struct strbuf sb = STRBUF_INIT;
 	unsigned int oi_flags = OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 	struct object_info oi;
+	struct object_id real_oid = *null_oid();
 	int found = 0;
 	oi.type_name = &sb;
 	oi.sizep = &size;
 	oi.typep = &type;
 
-	if (read_loose_object(path, oid, &contents, &oi, oi_flags) < 0) {
+	if (read_loose_object(path, oid, &real_oid, &contents, &oi, oi_flags) < 0) {
 		found |= ERROR_OBJECT;
-		error(_("%s: object corrupt or missing: %s"),
-		      oid_to_hex(oid), path);
+		if (!oideq(&real_oid, oid))
+			error(_("%s: hash-path mismatch, found at: %s"),
+			      oid_to_hex(&real_oid), path);
+		else
+			error(_("%s: object corrupt or missing: %s"),
+			      oid_to_hex(oid), path);
 	}
 	if (type < 0) {
 		found |= ERROR_OBJECT;
 		error(_("%s: object is of unknown type '%s': %s"),
-		      oid_to_hex(oid), sb.buf, path);
+		      oid_to_hex(&real_oid), sb.buf, path);
 	}
 	if (found) {
 		errors_found |= ERROR_OBJECT;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8336466865c..9f540e0236a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1419,7 +1419,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 
 		if (check_object_signature(the_repository, &d->oid,
 					   data, size,
-					   type_name(type)))
+					   type_name(type), NULL))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 
 		/*
diff --git a/builtin/mktag.c b/builtin/mktag.c
index dddcccdd368..3b2dbbb37e6 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -62,7 +62,8 @@ static int verify_object_in_tag(struct object_id *tagged_oid, int *tagged_type)
 
 	repl = lookup_replace_object(the_repository, tagged_oid);
 	ret = check_object_signature(the_repository, repl,
-				     buffer, size, type_name(*tagged_type));
+				     buffer, size, type_name(*tagged_type),
+				     NULL);
 	free(buffer);
 
 	return ret;
diff --git a/object-file.c b/object-file.c
index f4850ba62b4..07b3e4d9b4b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1062,9 +1062,11 @@ void *xmmap(void *start, size_t length,
  * the streaming interface and rehash it to do the same.
  */
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *map, unsigned long size, const char *type)
+			   void *map, unsigned long size, const char *type,
+			   struct object_id *real_oidp)
 {
-	struct object_id real_oid;
+	struct object_id tmp;
+	struct object_id *real_oid = real_oidp ? real_oidp : &tmp;
 	enum object_type obj_type;
 	struct git_istream *st;
 	git_hash_ctx c;
@@ -1072,8 +1074,8 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 	int hdrlen;
 
 	if (map) {
-		hash_object_file(r->hash_algo, map, size, type, &real_oid);
-		return !oideq(oid, &real_oid) ? -1 : 0;
+		hash_object_file(r->hash_algo, map, size, type, real_oid);
+		return !oideq(oid, real_oid) ? -1 : 0;
 	}
 
 	st = open_istream(r, oid, &obj_type, &size, NULL);
@@ -1098,9 +1100,9 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
 			break;
 		r->hash_algo->update_fn(&c, buf, readlen);
 	}
-	r->hash_algo->final_oid_fn(&real_oid, &c);
+	r->hash_algo->final_oid_fn(real_oid, &c);
 	close_istream(st);
-	return !oideq(oid, &real_oid) ? -1 : 0;
+	return !oideq(oid, real_oid) ? -1 : 0;
 }
 
 int git_open_cloexec(const char *name, int flags)
@@ -2560,6 +2562,7 @@ static int check_stream_oid(git_zstream *stream,
 
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
+		      struct object_id *real_oid,
 		      void **contents,
 		      struct object_info *oi,
 		      unsigned int oi_flags)
@@ -2609,9 +2612,9 @@ int read_loose_object(const char *path,
 			goto out;
 		}
 		if (check_object_signature(the_repository, expected_oid,
-					   *contents, *size, oi->type_name->buf)) {
-			error(_("hash mismatch for %s (expected %s)"), path,
-			      oid_to_hex(expected_oid));
+					   *contents, *size, oi->type_name->buf, real_oid)) {
+			if (oideq(real_oid, null_oid()))
+				BUG("should only get OID mismatch errors with mapped contents");
 			free(*contents);
 			goto out;
 		}
diff --git a/object-store.h b/object-store.h
index f3045148b89..3c4ada23f5d 100644
--- a/object-store.h
+++ b/object-store.h
@@ -392,6 +392,7 @@ int oid_object_info_extended(struct repository *r,
  */
 int read_loose_object(const char *path,
 		      const struct object_id *expected_oid,
+		      struct object_id *real_oid,
 		      void **contents,
 		      struct object_info *oi,
 		      unsigned int oi_flags);
@@ -528,7 +529,8 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
 int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *buf, unsigned long size, const char *type);
+			   void *buf, unsigned long size, const char *type,
+			   struct object_id *real_oidp);
 int finalize_object_file(const char *tmpfile, const char *filename);
 int check_and_freshen_file(const char *fn, int freshen);
 
diff --git a/object.c b/object.c
index 4e85955a941..23a24e678a8 100644
--- a/object.c
+++ b/object.c
@@ -279,7 +279,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
 	    (!obj && repo_has_object_file(r, oid) &&
 	     oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
-		if (check_object_signature(r, repl, NULL, 0, NULL) < 0) {
+		if (check_object_signature(r, repl, NULL, 0, NULL, NULL) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
 			return NULL;
 		}
@@ -290,7 +290,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
 	buffer = repo_read_object_file(r, oid, &type, &size);
 	if (buffer) {
 		if (check_object_signature(r, repl, buffer, size,
-					   type_name(type)) < 0) {
+					   type_name(type), NULL) < 0) {
 			free(buffer);
 			error(_("hash mismatch %s"), oid_to_hex(repl));
 			return NULL;
diff --git a/pack-check.c b/pack-check.c
index c8e560d71ab..3f418e3a6af 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -142,7 +142,8 @@ static int verify_packfile(struct repository *r,
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    oid_to_hex(&oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-		else if (check_object_signature(r, &oid, data, size, type_name(type)))
+		else if (check_object_signature(r, &oid, data, size,
+						type_name(type), NULL))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(&oid), p->pack_name);
 		else if (fn) {
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 43a9f4e7f0c..39fe11bc92c 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -490,7 +490,7 @@ test_expect_success 'cat-file -t and -s on corrupt loose object' '
 		# Swap the two to corrupt the repository
 		mv -f "$other_path" "$empty_path" &&
 		test_must_fail git fsck 2>err.fsck &&
-		grep "hash mismatch" err.fsck &&
+		grep "hash-path mismatch" err.fsck &&
 
 		# confirm that cat-file is reading the new swapped-in
 		# blob...
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index da2658155c7..7d0d57564b5 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -53,6 +53,7 @@ test_expect_success 'object with hash mismatch' '
 	(
 		cd hash-mismatch &&
 		oid=$(echo blob | git hash-object -w --stdin) &&
+		oldoid=$oid &&
 		old=$(test_oid_to_path "$oid") &&
 		new=$(dirname $old)/$(test_oid ff_2) &&
 		oid="$(dirname $new)$(basename $new)" &&
@@ -62,7 +63,7 @@ test_expect_success 'object with hash mismatch' '
 		cmt=$(echo bogus | git commit-tree $tree) &&
 		git update-ref refs/heads/bogus $cmt &&
 		test_must_fail git fsck 2>out &&
-		test_i18ngrep "$oid.*corrupt" out
+		grep "$oldoid: hash-path mismatch, found at: .*$new" out
 	)
 '
 
@@ -71,6 +72,7 @@ test_expect_success 'object with hash and type mismatch' '
 	(
 		cd hash-type-mismatch &&
 		oid=$(echo blob | git hash-object -w --stdin -t garbage --literally) &&
+		oldoid=$oid &&
 		old=$(test_oid_to_path "$oid") &&
 		new=$(dirname $old)/$(test_oid ff_2) &&
 		oid="$(dirname $new)$(basename $new)" &&
@@ -80,8 +82,8 @@ test_expect_success 'object with hash and type mismatch' '
 		cmt=$(echo bogus | git commit-tree $tree) &&
 		git update-ref refs/heads/bogus $cmt &&
 		test_must_fail git fsck 2>out &&
-		grep "^error: hash mismatch for " out &&
-		grep "^error: $oid: object is of unknown type '"'"'garbage'"'"'" out
+		grep "^error: $oldoid: hash-path mismatch, found at: .*$new" out &&
+		grep "^error: $oldoid: object is of unknown type '"'"'garbage'"'"'" out
 	)
 '
 
-- 
2.33.0.815.g21c7aaf6073


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D83C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A144060F6D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343986AbhIGK76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbhIGK7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C195C06129F
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso820297wmc.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKPGQcEdxSHXpNCwGotG/qh6jyDtSZlEEym+uPKc4nk=;
        b=eHMXFnjzQACNgnFqrJdtAtO738FuV39q81ht4Hlu30Wn1Gh59cjpkLYsn7j9A/aR6x
         3w6QRFybfjnpfhIBeTXvlWb6AUehiNu8jn3gyOzZ5Qe9DKkhMqpawfwhza7wQwar4DRc
         GxDWOiuzcpmguXL6lG7IogyEWwtCWgMHlWULphmxrEgwZhXDMHtx8n1nKrnJAIkjxKfS
         kZfETfirB+vhrQOAd7M6tKwFcnAl1muj/aV2h4EGH68Bf4iBM/DAM20JYE1LtFnZNDRR
         vSrV8+///J4d99MqsDTxbhBO5k/uBwnbCC1kKNG0hsxhc0t9dEGZL9XSMjuWUG6CnR/O
         qF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKPGQcEdxSHXpNCwGotG/qh6jyDtSZlEEym+uPKc4nk=;
        b=lJi4qm9fPHJGQ1uPfVgCcj3uSMuZDeBMBOX56TJHZx0kpEGBYgzba1VDeRS5VjXPgt
         gyyU4eIz1Bd3KVFQyEuRDqk9mWcPkhYmIwb8wMGC3LyIQ73QWvwTuaROXhPm30oPMof7
         VVsvUH/r5OUxbY+UbKlYKoTDLsDtW4y5btMEQOcgvnd71tVQPlCjuY4EovHMQGkB5GU3
         9eRM0xzX5lJHAa8UaHQzsuC0ZXzhv+SxxLyucGqfh8V0MIDDygWwuizOkxK6VL8VM1aX
         keFR8zk2dZD5lEb3AV528UL3kdgTi4aJtdYXR4bVtzBuy36UTS8Uc6rrIyBvyTc5/GUZ
         l1Uw==
X-Gm-Message-State: AOAM530K1M2OEPg1syJKeEgpwfRnY9f+I0Y9vjCps7tCA4Rs1CzVZQwM
        A1MXNY8sT1GUVFipTKLnlbomeLVUWoZnmQ==
X-Google-Smtp-Source: ABdhPJzk+uVEpkaJH99MuS9FF63zzu2tUvTOg1uQZn89VK2STyAZchEKtgtaDTbm09dHFGtaHumeTw==
X-Received: by 2002:a05:600c:3542:: with SMTP id i2mr3265972wmq.170.1631012317333;
        Tue, 07 Sep 2021 03:58:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 14/22] object-file.c: stop dying in parse_loose_header()
Date:   Tue,  7 Sep 2021 12:58:09 +0200
Message-Id: <patch-v6-14.22-7c9819d37c5-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start the libification of parse_loose_header() by making it return
error codes and data instead of invoking die() by itself. For now
we'll move the relevant die() call to loose_object_info() and
read_loose_object() to keep this change smaller, but in subsequent
commits we'll also libify those.

Since the refactoring of parse_loose_header_extended() into
parse_loose_header() in an earlier commit, its interface accepts a
"unsigned long *sizep". Rather it accepts a "struct object_info *",
that structure will be populated with information about the object.

It thus makes sense to further libify the interface so that it stops
calling die() when it encounters OBJ_BAD, and instead rely on its
callers to check the populated "oi->typep".

Because of this we don't need to pass in the "unsigned int flags"
which we used for OBJECT_INFO_ALLOW_UNKNOWN_TYPE, we can instead do
that check in loose_object_info().

This also refactors some confusing control flow around the "status"
variable. In some cases we set it to the return value of "error()",
i.e. -1, and later checked if "status < 0" was true.

In another case added in c84a1f3ed4d (sha1_file: refactor read_object,
2017-06-21) (but the behavior pre-dated that) we did checks of "status
>= 0", because at that point "status" had become the return value of
parse_loose_header(). I.e. a non-negative "enum object_type" (unless
we -1, aka. OBJ_BAD).

Now that parse_loose_header() will return 0 on success instead of the
type (which it'll stick into the "struct object_info") we don't need
to conflate these two cases in its callers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c  | 53 ++++++++++++++++++++++++++------------------------
 object-store.h | 13 +++++++++++--
 streaming.c    |  4 +++-
 3 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/object-file.c b/object-file.c
index 7c6a865a6c0..d656960422d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1345,9 +1345,7 @@ static void *unpack_loose_rest(git_zstream *stream,
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-int parse_loose_header(const char *hdr,
-		       struct object_info *oi,
-		       unsigned int flags)
+int parse_loose_header(const char *hdr, struct object_info *oi)
 {
 	const char *type_buf = hdr;
 	unsigned long size;
@@ -1369,15 +1367,6 @@ int parse_loose_header(const char *hdr,
 	type = type_from_string_gently(type_buf, type_len, 1);
 	if (oi->type_name)
 		strbuf_add(oi->type_name, type_buf, type_len);
-	/*
-	 * Set type to 0 if its an unknown object and
-	 * we're obtaining the type using '--allow-unknown-type'
-	 * option.
-	 */
-	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE) && (type < 0))
-		type = 0;
-	else if (type < 0)
-		die(_("invalid object type"));
 	if (oi->typep)
 		*oi->typep = type;
 
@@ -1407,7 +1396,11 @@ int parse_loose_header(const char *hdr,
 	if (*hdr)
 		return -1;
 
-	return type;
+	/*
+	 * The format is valid, but the type may still be bogus. The
+	 * Caller needs to check its oi->typep.
+	 */
+	return 0;
 }
 
 static int loose_object_info(struct repository *r,
@@ -1422,6 +1415,8 @@ static int loose_object_info(struct repository *r,
 	char hdr[MAX_HEADER_LEN];
 	struct strbuf hdrbuf = STRBUF_INIT;
 	unsigned long size_scratch;
+	enum object_type type_scratch;
+	int parsed_header = 0;
 	int allow_unknown = flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (oi->delta_base_oid)
@@ -1453,6 +1448,8 @@ static int loose_object_info(struct repository *r,
 
 	if (!oi->sizep)
 		oi->sizep = &size_scratch;
+	if (!oi->typep)
+		oi->typep = &type_scratch;
 
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
@@ -1463,18 +1460,20 @@ static int loose_object_info(struct repository *r,
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
 	}
-
-	if (status < 0) {
-		/* Do nothing */
-	} else if (hdrbuf.len) {
-		if ((status = parse_loose_header(hdrbuf.buf, oi, flags)) < 0)
-			status = error(_("unable to parse %s header with --allow-unknown-type"),
-				       oid_to_hex(oid));
-	} else if ((status = parse_loose_header(hdr, oi, flags)) < 0) {
-		status = error(_("unable to parse %s header"), oid_to_hex(oid));
+	if (!status) {
+		if (!parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi))
+			/*
+			 * oi->{sizep,typep} are meaningless unless
+			 * parse_loose_header() returns >= 0.
+			 */
+			parsed_header = 1;
+		else
+			status = error(_("unable to parse %s header"), oid_to_hex(oid));
 	}
+	if (!allow_unknown && parsed_header && *oi->typep < 0)
+		die(_("invalid object type"));
 
-	if (status >= 0 && oi->contentp) {
+	if (parsed_header && oi->contentp) {
 		*oi->contentp = unpack_loose_rest(&stream, hdr,
 						  *oi->sizep, oid);
 		if (!*oi->contentp) {
@@ -1489,6 +1488,8 @@ static int loose_object_info(struct repository *r,
 	if (oi->sizep == &size_scratch)
 		oi->sizep = NULL;
 	strbuf_release(&hdrbuf);
+	if (oi->typep == &type_scratch)
+		oi->typep = NULL;
 	oi->whence = OI_LOOSE;
 	return (status < 0) ? status : 0;
 }
@@ -2557,6 +2558,7 @@ int read_loose_object(const char *path,
 	git_zstream stream;
 	char hdr[MAX_HEADER_LEN];
 	struct object_info oi = OBJECT_INFO_INIT;
+	oi.typep = type;
 	oi.sizep = size;
 
 	*contents = NULL;
@@ -2573,12 +2575,13 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	*type = parse_loose_header(hdr, &oi, 0);
-	if (*type < 0) {
+	if (parse_loose_header(hdr, &oi) < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
 		goto out;
 	}
+	if (*type < 0)
+		die(_("invalid object type"));
 
 	if (*type == OBJ_BLOB && *size > big_file_threshold) {
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
diff --git a/object-store.h b/object-store.h
index 4064710ae29..584bf5556af 100644
--- a/object-store.h
+++ b/object-store.h
@@ -500,8 +500,17 @@ int for_each_packed_object(each_packed_object_fn, void *,
 int unpack_loose_header(git_zstream *stream, unsigned char *map,
 			unsigned long mapsize, void *buffer,
 			unsigned long bufsiz, struct strbuf *hdrbuf);
-int parse_loose_header(const char *hdr, struct object_info *oi,
-		       unsigned int flags);
+
+/**
+ * parse_loose_header() parses the starting "<type> <len>\0" of an
+ * object. If it doesn't follow that format -1 is returned. To check
+ * the validity of the <type> populate the "typep" in the "struct
+ * object_info". It will be OBJ_BAD if the object type is unknown. The
+ * parsed <len> can be retrieved via "oi->sizep", and from there
+ * passed to unpack_loose_rest().
+ */
+int parse_loose_header(const char *hdr, struct object_info *oi);
+
 int check_object_signature(struct repository *r, const struct object_id *oid,
 			   void *buf, unsigned long size, const char *type);
 int finalize_object_file(const char *tmpfile, const char *filename);
diff --git a/streaming.c b/streaming.c
index cb3c3cf6ff6..c3dc241d6a5 100644
--- a/streaming.c
+++ b/streaming.c
@@ -225,6 +225,7 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 	oi.sizep = &st->size;
+	oi.typep = type;
 
 	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
@@ -235,7 +236,8 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 				 st->u.loose.hdr,
 				 sizeof(st->u.loose.hdr),
 				 NULL) < 0) ||
-	    (parse_loose_header(st->u.loose.hdr, &oi, 0) < 0)) {
+	    (parse_loose_header(st->u.loose.hdr, &oi) < 0) ||
+	    *type < 0) {
 		git_inflate_end(&st->z);
 		munmap(st->u.loose.mapped, st->u.loose.mapsize);
 		return -1;
-- 
2.33.0.815.g21c7aaf6073


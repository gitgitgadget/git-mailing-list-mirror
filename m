Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6464B8DFC
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593319; cv=none; b=Be1Pi6HQRfOzyghSbEcI6cIvLiydEepLGuCK3bAl0Z83qKNOz/Axai6JQrPdgdvE4vlAbbqFpTrI3LQJe9VbUqs56h/i5f7rzOzqO7Pgbv1rdZhCSNgv1Kxsu9NllbHeSLF6lC10IeiZYkm2RNeP3EC4GR6G/9zXQoCY0EaJ4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593319; c=relaxed/simple;
	bh=SlCQ6UeIhOlUY4MyHDGgHnJmShb5UBIfGtbQf57ZHVo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fqbwYkQ8GMcr1evN1MLt4Fmp9+dumM1mGThq+So/It8oSdHu5jd200/RGRnUwJf/846cTsWTqrDGghQ6q1u7VqKPk3eOWKLzXjWIwgSmexbbCBh5zJ/SXY6tTuC3yspzaTZZmP9ZtKMJBVBWHrAkg+pk7c14g3f03qDJ9s2k/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/yYH8cv; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/yYH8cv"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304df7ff4c2so1398825eec.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 10:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780593317; x=1781198117; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1GdbKM+SGB/YQGB+NjzypQHBYEPmIy8eHAYxbAFC24=;
        b=E/yYH8cvc/8mnlsZJUNDUDehvmXLCPqwzxgq5GiiRXgoL+GsAmyCmX6YlytTalXUr/
         nNNKNUKyTqIhfTCfYkXVd5QIzeSIxWXQ+wPA+iZ+CxC9z3lpTXw5TLP73f1tYLOMWv3p
         AbgwvFvy2dr/tJ65XnzEd4J38gN3+4z6ri5WzLUpOZ69aR++5B/uXdraoA9S448zx4En
         qYcMAugUEOdnxQ3oYgXOJGYydtwVLYFxI7c7GcvgE+d7eH+F4Nlw+tZ+BOcIzP4YatKw
         ph08K4yHLIU6VQoBdFJVxor21jotZJlbNlVgAMqBdmDAFdfRS5jQ8+JVQxDuuVqO4HMU
         0QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593317; x=1781198117;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S1GdbKM+SGB/YQGB+NjzypQHBYEPmIy8eHAYxbAFC24=;
        b=rG28UM3JrGAyMGZaH1y2sjfp9i+hV2RldbDYUasFbxLCoctNi6nVsmd+W6eehniCLR
         tgHdcd5f8eHSqEWsph4arn08SvUFNrRDv4jxewRBNlYTVeXbD/Fk1r1DEyKN7y4UkI8R
         bulKXawtBNnszK+La30wap4RIYP5zNu7Kp+kQx7jbrfMiEaAMaGELeexNUSW+lPxcnZy
         waUHGeMAltIBea1nadZXWzAOi4NyLXqkWouxEqYFxgTcszu9DWhw5e6hXlKw5w1MBE21
         7xhZ5lbR9WjvKvHzydZvaUEXF7fvGWsU/A6X/Z8EGpvtauySdyqcfS5+Xiuj9LNuZ3jK
         7v7Q==
X-Gm-Message-State: AOJu0YygVsGGwn5MAlBKbSoNJVnTOKJ38F63s2YJfwMiZ2c16Zua8vke
	oKndB66YVMd2VdAIdqRaL/tdALB/WngDNZuIky6HTd3uuqzHV+3Zh4NZJW6JTQ==
X-Gm-Gg: Acq92OEIfrml//QzWu+0HgcIMiF3fTfRvsORHovsU65BdflRAVK8JwnW7czsOvcRdS3
	VCG0OFFa7h5H0O+BSTGlVEVS7LAEV8RfKOAQU2q99cEynHi/Oh8D2FPnL8Lv90S5OJ1KgeZzyz2
	qcCAtmtMSzgGZZZM2InEprLg0SbcEf39HOrDSerjrkb4LwxggDB77Iv5d01ujuJ61G9yMLkvj0a
	UPYJ4aBGoBZ108mTlSAmhfeqbnPxyI43BbSQ1qf5+1I9g6XlV6j7Nr4uz/b4aRarMH0RPgGMeXC
	587C/4xE0jZGzqB6JAM3yBwmNPRrIKFp7TMPTeY4+Fn4DrlqHrU0xnrTfsUycIjcewia6lx/Qpc
	JS5AVepcF0WImB0uU+xXeAnVRDY+kLmMB9FnxJA3yGtp85aehhfEBwRh+oo7wBoXRO8WURLf66a
	slDzZaSrpAUnjYIGtw40kVrB9d2ogE9zpKb0vncw==
X-Received: by 2002:a05:7301:5f85:b0:304:dc2c:3280 with SMTP id 5a478bee46e88-307622bea98mr2146391eec.14.1780593317350;
        Thu, 04 Jun 2026 10:15:17 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dfa3a2asm7653053eec.31.2026.06.04.10.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:15:16 -0700 (PDT)
Message-Id: <809d83e46fb46baeb5d0dfcd12eb7fc63580eec4.1780593313.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
From: "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 17:15:08 +0000
Subject: [PATCH 2/6] object-file.c: use size_t for header lengths
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Philip Oakley <philipoakley@iee.email>

From: Philip Oakley <philipoakley@iee.email>

Continue walking the code path for the >4GB `hash-object --literally`
test. The `hash_object_file_literally()` function internally uses both
`hash_object_file()` and `write_object_file_prepare()`. Both function
signatures use `unsigned long` rather than `size_t` for the mem buffer
sizes. Use `size_t` instead, for LLP64 compatibility.

While at it, convert those function's object's header buffer length to
`size_t` for consistency. The value is already upcast to `uintmax_t` for
print format compatibility.

Note: The hash-object test still does not pass. A subsequent commit
continues to walk the call tree's lower level hash functions to identify
further fixes.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 object-file.c | 14 +++++++-------
 object-file.h |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/object-file.c b/object-file.c
index 90f995d000..1f5f9daf24 100644
--- a/object-file.c
+++ b/object-file.c
@@ -563,7 +563,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
 			     const void *buf, unsigned long len,
 			     struct object_id *oid,
-			     char *hdr, int *hdrlen)
+			     char *hdr, size_t *hdrlen)
 {
 	algo->init_fn(c);
 	git_hash_update(c, hdr, *hdrlen);
@@ -572,9 +572,9 @@ static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_c
 }
 
 static void write_object_file_prepare(const struct git_hash_algo *algo,
-				      const void *buf, unsigned long len,
+				      const void *buf, size_t len,
 				      enum object_type type, struct object_id *oid,
-				      char *hdr, int *hdrlen)
+				      char *hdr, size_t *hdrlen)
 {
 	struct git_hash_ctx c;
 
@@ -717,11 +717,11 @@ out:
 }
 
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
-		      unsigned long len, enum object_type type,
+		      size_t len, enum object_type type,
 		      struct object_id *oid)
 {
 	char hdr[MAX_HEADER_LEN];
-	int hdrlen = sizeof(hdr);
+	size_t hdrlen = sizeof(hdr);
 
 	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
 }
@@ -1177,7 +1177,7 @@ cleanup:
 }
 
 int odb_source_loose_write_object(struct odb_source *source,
-				  const void *buf, unsigned long len,
+				  const void *buf, size_t len,
 				  enum object_type type, struct object_id *oid,
 				  struct object_id *compat_oid_in,
 				  enum odb_write_object_flags flags)
@@ -1186,7 +1186,7 @@ int odb_source_loose_write_object(struct odb_source *source,
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	struct object_id compat_oid;
 	char hdr[MAX_HEADER_LEN];
-	int hdrlen = sizeof(hdr);
+	size_t hdrlen = sizeof(hdr);
 
 	/* Generate compat_oid */
 	if (compat) {
diff --git a/object-file.h b/object-file.h
index 5241b8dd5c..e1e22d512d 100644
--- a/object-file.h
+++ b/object-file.h
@@ -66,7 +66,7 @@ int odb_source_loose_freshen_object(struct odb_source *source,
 				    const struct object_id *oid);
 
 int odb_source_loose_write_object(struct odb_source *source,
-				  const void *buf, unsigned long len,
+				  const void *buf, size_t len,
 				  enum object_type type, struct object_id *oid,
 				  struct object_id *compat_oid_in,
 				  enum odb_write_object_flags flags);
@@ -201,7 +201,7 @@ int finalize_object_file_flags(struct repository *repo,
 			       enum finalize_object_file_flags flags);
 
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
-		      unsigned long len, enum object_type type,
+		      size_t len, enum object_type type,
 		      struct object_id *oid);
 
 /* Helper to check and "touch" a file */
-- 
gitgitgadget


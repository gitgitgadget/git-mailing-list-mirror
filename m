Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B0D35947
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071804; cv=none; b=p3491o4B6T6wnxSRZbAC0fa6SOjux+mruRty+IVzjByjPU8LRoG0H0H9AYjcmu0qt+Cl5OtZ6O2Prk0yrGgMNNbBlnXa7jafpG32knOj3JGFEigJnEg4FcdpEn1hFYkysVEFBhYEjRWISaSIvW3aHAtfWNwsfWbLeWZqCUt26W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071804; c=relaxed/simple;
	bh=GavDDpe1bjWlmv3WfSvByLJL05SLLH2WpxPHmjRWPR8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iqALGa96Qn9FdVy+cjSt1IUyBL0RJGncPRJrvNX9tbGDBGddSp5BL4iWVPONII7G+QjuJl0nRzb7ZYysXR3vWvW3fh0PuMO95I6r7MMHhZNPeLoqfcuFuNvfXcfG5tTNPcvYecV313lbzfg3NhBDhXucmUr7eUn7pVisSCytALg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btx+ArZ0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btx+ArZ0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7761578340dso5642255b3a.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071801; x=1758676601; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acuge1vw+EC3pqHxoVjxFm+q70ltVgDgkiCI2UqqxVM=;
        b=btx+ArZ0rFFBEqtqdZD0GQDBmaeWr5Iyuh+nnPyKTFfUCwTdiZ3w46GIZ5yxUZlp7O
         K93mj7C6LdLps8/x8wmkBFDZhjj4vHSCzx3xiTTareMcwxY3zcEGniZjHFk9iazXZVwU
         /0tC7Kscfj6Mq1QeKLtK6zam+hWgr9+0oefUMK5XZPrjqUxUPX07U3OUFzRFKyz6KIjk
         h+ynVjaat9yHA2z1Acudwn1l/bhYlZNCpxo2i2gmjk2Ezzcg+FcM8gYYgqd9/JTmXBHW
         6zXsjeqYJPivl5rK8uEhp63iKLzIBR7jVffwOD5qEuOAbpfLQo2g581cwHBEOOXEtDWD
         32kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071801; x=1758676601;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acuge1vw+EC3pqHxoVjxFm+q70ltVgDgkiCI2UqqxVM=;
        b=c3tsfT25XMdAyus3G4GW6RgJ8nFK/GbEcTsb7v6/jOS6aG3Wx0bBIO50G+ZzCx1IVz
         eyAPGpvoPisgcNRnl+/YIKspoEeRNhy4TuxXEmPk3/3BwQiRHF6DUhQjg6pF4gIQUBmM
         J7ANDpq3kR+lCDezmtLGLzbLDfYzFDdN76egO1Ul/NWEgZmAfkA501g/XBAsFWobFcG+
         TlAbbOknSpYqBQnJ9I1w5eHCQrgsTOL58L+XKJAzsTX2GGgrqo9VrOnYA2zqCBM0XuGR
         rWkfaG2uXDnKbQ8w+oEb5WyA/iHVZockMXPSyzrrS9SN6ZWEDK/vCMaq8MwjWiSujqYT
         2dlQ==
X-Gm-Message-State: AOJu0YwQTvE9P7kJbjIByviA+CpZb/m5sIOrndB/mhq5/d1y//nGiqYt
	/xlIAUFAAEvYdKSSbm7k1FdHOu/WvWtzJlJ0rfL0P6fkWXdbsMFp4WTrZJD9JQ==
X-Gm-Gg: ASbGncuJC2pc3amxRDUebBry51glxBioFR55M4lJXUXAUmbbMDsVvdcVe5qXAllLENe
	5zff9DLas1aDsb7dVAo+EuMzOA7QifaevvysknBxOwqYJzgAjr3V1WOJS9Zs7g6N007JuUJZ3HC
	rpbFloDRp1c4LBbMpyXarloZJVmkU7X/eY9TbRr/youJXBXiD/v91Nw6EfIDobyJ3zDqzMHS0Bf
	J+VB7I/bvpn1xAR7bGtJXnAgjJqXn21xfwWKiEbv2uOAOW2WZo47lhg1J7F8C+JwVToG4hb/BLX
	HyI2o5dcpcKfU62HCeSgFEg1Bapgd6ydx8ow777KuxGvTxEv0o27Hb2iUkXZUsuzkNSx+lXm2xM
	QBhOs/Sk/+NcfYrOnYOTskOaoAfk=
X-Google-Smtp-Source: AGHT+IHWSotIrJ4PtJsLbQO6Fz45VIbZnvOffJgWhrjD0dLx/ekqeH4vcB6FLrX1RkoevJ7yadpn4Q==
X-Received: by 2002:a05:6a00:928d:b0:772:8694:1d5d with SMTP id d2e1a72fcca58-77bfa642247mr323466b3a.29.1758071801106;
        Tue, 16 Sep 2025 18:16:41 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77613e4308csm14477658b3a.73.2025.09.16.18.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:40 -0700 (PDT)
Message-Id: <5f77f1bd5d986dc1f8d123919af24dd219e323e8.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:21 +0000
Subject: [PATCH v2 01/18] cleanup: rename variables that collide with Rust
 primitive type names
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Use a regex to find and rename variables that collide with Rust
primitive integer and float type names:

    git grep -n -E -e '\<([ui](8|16|32|64|size)|(f(32|64)))\>'

Matches were reviewed and renamed. The remaining matches don't count
because:
- Rust source files:
  contrib/libgit-rs/src/config.rs
  contrib/libgit-sys/src/lib.rs
  t/t4018/rust-impl
  t/t4018/rust-trait
- Intentional references:
  t/helper/test-parse-options.c (prints Rust int names)
  t/t0040-parse-options.sh (tests the above)

View with --color-words to highlight the variable renames.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 odb.c                         |  8 ++++----
 reftable/record.c             |  6 +++---
 t/helper/test-parse-options.c | 12 ++++++------
 xdiff/xtypes.h                |  2 +-
 xdiff/xutils.c                |  8 ++++----
 xdiff/xutils.h                |  2 +-
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/odb.c b/odb.c
index 2a92a018c4..f0255b4b36 100644
--- a/odb.c
+++ b/odb.c
@@ -913,7 +913,7 @@ void *odb_read_object_peeled(struct object_database *odb,
 {
 	enum object_type type;
 	void *buffer;
-	unsigned long isize;
+	unsigned long isize_;
 	struct object_id actual_oid;
 
 	oidcpy(&actual_oid, oid);
@@ -921,11 +921,11 @@ void *odb_read_object_peeled(struct object_database *odb,
 		int ref_length = -1;
 		const char *ref_type = NULL;
 
-		buffer = odb_read_object(odb, &actual_oid, &type, &isize);
+		buffer = odb_read_object(odb, &actual_oid, &type, &isize_);
 		if (!buffer)
 			return NULL;
 		if (type == required_type) {
-			*size = isize;
+			*size = isize_;
 			if (actual_oid_return)
 				oidcpy(actual_oid_return, &actual_oid);
 			return buffer;
@@ -941,7 +941,7 @@ void *odb_read_object_peeled(struct object_database *odb,
 		}
 		ref_length = strlen(ref_type);
 
-		if (ref_length + odb->repo->hash_algo->hexsz > isize ||
+		if (ref_length + odb->repo->hash_algo->hexsz > isize_ ||
 		    memcmp(buffer, ref_type, ref_length) ||
 		    get_oid_hex_algop((char *) buffer + ref_length, &actual_oid,
 				      odb->repo->hash_algo)) {
diff --git a/reftable/record.c b/reftable/record.c
index fcd387ba5d..e8fc854561 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -675,7 +675,7 @@ static int reftable_log_record_key(const void *r, struct reftable_buf *dest)
 	const struct reftable_log_record *rec =
 		(const struct reftable_log_record *)r;
 	int len = strlen(rec->refname), err;
-	uint8_t i64[8];
+	uint8_t i64_[8];
 	uint64_t ts = 0;
 
 	reftable_buf_reset(dest);
@@ -684,9 +684,9 @@ static int reftable_log_record_key(const void *r, struct reftable_buf *dest)
 		return err;
 
 	ts = (~ts) - rec->update_index;
-	reftable_put_be64(&i64[0], ts);
+	reftable_put_be64(&i64_[0], ts);
 
-	err = reftable_buf_add(dest, i64, sizeof(i64));
+	err = reftable_buf_add(dest, i64_, sizeof(i64_));
 	if (err < 0)
 		return err;
 
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 68579d83f3..aa1cb693a2 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -120,8 +120,8 @@ int cmd__parse_options(int argc, const char **argv)
 	};
 	struct string_list expect = STRING_LIST_INIT_NODUP;
 	struct string_list list = STRING_LIST_INIT_NODUP;
-	uint16_t u16 = 0;
-	int16_t i16 = 0;
+	uint16_t u16_ = 0;
+	int16_t i16_ = 0;
 
 	struct option options[] = {
 		OPT_BOOL(0, "yes", &boolean, "get a boolean"),
@@ -142,10 +142,10 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_NEGBIT(0, "neg-or4", &boolean, "same as --no-or4", 4),
 		OPT_GROUP(""),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
-		OPT_INTEGER(0, "i16", &i16, "get a 16 bit integer"),
+		OPT_INTEGER(0, "i16", &i16_, "get a 16 bit integer"),
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
 		OPT_UNSIGNED('u', "unsigned", &unsigned_integer, "get an unsigned integer"),
-		OPT_UNSIGNED(0, "u16", &u16, "get a 16 bit unsigned integer"),
+		OPT_UNSIGNED(0, "u16", &u16_, "get a 16 bit unsigned integer"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
 		OPT_CMDMODE(0, "mode1", &integer, "set integer to 1 (cmdmode option)", 1),
 		OPT_CMDMODE(0, "mode2", &integer, "set integer to 2 (cmdmode option)", 2),
@@ -225,9 +225,9 @@ int cmd__parse_options(int argc, const char **argv)
 	}
 	show(&expect, &ret, "boolean: %d", boolean);
 	show(&expect, &ret, "integer: %d", integer);
-	show(&expect, &ret, "i16: %"PRIdMAX, (intmax_t) i16);
+	show(&expect, &ret, "i16: %"PRIdMAX, (intmax_t) i16_);
 	show(&expect, &ret, "unsigned: %lu", unsigned_integer);
-	show(&expect, &ret, "u16: %"PRIuMAX, (uintmax_t) u16);
+	show(&expect, &ret, "u16: %"PRIuMAX, (uintmax_t) u16_);
 	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
 	show(&expect, &ret, "string: %s", string ? string : "(not set)");
 	show(&expect, &ret, "abbrev: %d", abbrev);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 8442bd436e..ec1dc7548a 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -32,7 +32,7 @@ typedef struct s_chanode {
 
 typedef struct s_chastore {
 	chanode_t *head, *tail;
-	long isize, nsize;
+	long isize_, nsize;
 	chanode_t *ancur;
 	chanode_t *sncur;
 	long scurr;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 444a108f87..20dee53dbd 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -71,11 +71,11 @@ long xdl_mmfile_size(mmfile_t *mmf)
 }
 
 
-int xdl_cha_init(chastore_t *cha, long isize, long icount) {
+int xdl_cha_init(chastore_t *cha, long isize_, long icount) {
 
 	cha->head = cha->tail = NULL;
-	cha->isize = isize;
-	cha->nsize = icount * isize;
+	cha->isize_ = isize_;
+	cha->nsize = icount * isize_;
 	cha->ancur = cha->sncur = NULL;
 	cha->scurr = 0;
 
@@ -113,7 +113,7 @@ void *xdl_cha_alloc(chastore_t *cha) {
 	}
 
 	data = (char *) ancur + sizeof(chanode_t) + ancur->icurr;
-	ancur->icurr += cha->isize;
+	ancur->icurr += cha->isize_;
 
 	return data;
 }
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index fd0bba94e8..b531d2ebff 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -28,7 +28,7 @@
 long xdl_bogosqrt(long n);
 int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
 		     xdemitcb_t *ecb);
-int xdl_cha_init(chastore_t *cha, long isize, long icount);
+int xdl_cha_init(chastore_t *cha, long isize_, long icount);
 void xdl_cha_free(chastore_t *cha);
 void *xdl_cha_alloc(chastore_t *cha);
 long xdl_guess_lines(mmfile_t *mf, long sample);
-- 
gitgitgadget


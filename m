Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34FA1CDA27
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678160; cv=none; b=p6W3/k1rWOE/Gx0DxlTqeqTtiis3ZdrbvorbI9hUAp0IfCg1RMOD8zLw75AGuU2Iy2Dkz5Dr22PjaBQupRo9pYx7PDDUdftGjvziK9jTggqU3WSZH73xWGQA66RkI1QZxqN65fMx7un/112VtpJOhdoiI7dfHNlHYFj4dWssheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678160; c=relaxed/simple;
	bh=qEgPHA1kEAP6LjVKf3sHnN7zJKJOuuEOS3mN6DAp0wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dmuMMoruI86g2KqebJHqE+Pi2LTFKvp9nNMnQ2ay2mJMUHxSjfuZmJheWUyUzAEaQb2NilIv2jwPqiCnc45IJNUfNL/bpTIgt8A6aTobaFbCVm1iF6KobdG5lWKV6KLJA+YyEdipruI7gGffa/9hDTHamr/n8OZT6L+qX5JsngQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AF+BSt0I; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AF+BSt0I"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso238148266b.3
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731678157; x=1732282957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oCDmLyC/fXaZTbw5h3pOxSBIbqrrS70C2qZB7HJQGA=;
        b=AF+BSt0ITzPn8BxyeVJnymppATgSLXiXt99AI0XuIqJ/MwB2oz9T5JrOYW73XbmZ30
         mpkaDstB1yNZQ7uqxgcx4rgXOmp2cEUgTYecHYLzvzaumPImI0DynIKwN427IjtMlus6
         nw8/zSqk5hEDGIHQLPEQhkaIbiEmriFVp3E9L7+IBi0Ud7yOmgUsRSHiGYu+WUd7VW/v
         bGC5BZeiSZ9bQSJgFhyZqA4sDATxZxGfMqWb6jNcJzGlZ2WmpPCvD1omM821uS7L5/tB
         91+NeM/D60uXnWPKxPpe0v3cJffC6Y9cJmtLEz74Eii6ncKcWyEGbLfFroM9YidQ0lk4
         HkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678157; x=1732282957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oCDmLyC/fXaZTbw5h3pOxSBIbqrrS70C2qZB7HJQGA=;
        b=uW9qcuVG49K1CIQYPERVNsGNt7j5U94IfkrFjnliX3SjL7XmbjSjEKbH/S2pdhtEQj
         j8XcCV+Lfr0lOs11T7AAwuq53ZqF8AeOZqxP2IDAdSF/LtYv0EjSRw+L8cwrkZVjM24/
         yY3pk55lRICydD5Y2deR6ASTrc2ueJez3EANg1WFMA3CCJEVvc9IhfCaKrLQNZKIFJeu
         Niq1/wBrM8aJjI0vRr23i7QIIY5INeAAEgXbicJKIDZxWNhzmbRcnLAkBZb+Tb+p0hlE
         vTda6DJdNlWalanK1UfpIiu42MOJoAgHDiXiUiuW5MwViAb4OuMrwR8Y1unN3YepBYf3
         VgVA==
X-Gm-Message-State: AOJu0YwPmiWA6TdQraSX1Eonr699B2kc/WyiJ7gN4uMM5DOsJSXl84hf
	jSeLP4yZAaLhbXITFWxsvN75OlCgxkb8LwfpS143DUk2qKDj006G
X-Google-Smtp-Source: AGHT+IEUwXdxc0h8Hy94rmOdDmnpDUv8qtI8J8J6dZFpB25Z2kmj5IPqwWVGSiiQvaXHIvIGnWBCCg==
X-Received: by 2002:a17:907:2d90:b0:a9f:4f7:9fa3 with SMTP id a640c23a62f3a-aa4833f6aadmr214171766b.1.1731678156870;
        Fri, 15 Nov 2024 05:42:36 -0800 (PST)
Received: from [10.82.5.93] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26a69sm180753966b.34.2024.11.15.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:42:36 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 15 Nov 2024 14:42:17 +0100
Subject: [PATCH 4/8] midx: cleanup internal usage of `the_repository` and
 `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-4-761f8a2c7775@gmail.com>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, peff@peff.net
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7357; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=qEgPHA1kEAP6LjVKf3sHnN7zJKJOuuEOS3mN6DAp0wE=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnN0/I3LBlCqnwiqyHeTxiNQr32NVGvUM8GPqB7
 lUQYbfsFOuJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzdPyAAKCRA+1Z8kjkaM
 f/wwC/0eM8MZ5kSqxm7z8h8YvSrt7JXTIWU8Abws9hhjaUDhdLKvLgIBLsUKIkrp2xqTZfa3gzQ
 NAYEvJypUX1QMQ9FHJUXIihdbr71p1a0EuQMqPwF0BKv+5ZKLpKYN97wpSU9cNw9JtYsy3Vv6/B
 Axjj+TpG6Y1NUeaDfJG7pW6msbsRTRpudbODtJ7WEcWCTKeTEwlj4rv03uB+WDdOPtfN1I+GLbm
 CQGdDMM4SF4AMEtymsbHjYqcS/1WILtLlZnbU59MLayraE4/Eiq9f/0kSYyhnBqwkhYdAz1U3EZ
 8F1AQmWbEV3JCFCkLyvoPWHHUR/3DoMyllV8IVs4ERYpANvwYIxB4ZyAzxpA8yG0Kjz40SiEh7x
 GSB0Zk8xxxFwOz+d/Kr/nCd7tR4sx3yfRnPKaV6RXGqYAcFZcvl+xBokLJ1PrhNKP727LbxHajQ
 dL2Uk6t8Za+7FhOboVYpMiZSO1iUdb8iYfKqJJ56pgHaz9leCzjvBIcRO55bBABWpNQak=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the `midx.c` file, there are multiple usages of `the_repository` and
`the_hash_algo` within static functions of the file. Some of the usages
can be simply swapped out with the available `repository` struct
available. While some of them can be swapped out by passing the
repository to the required functions.

This leaves out only some other usages of `the_repository` and
`the_hash_algo` in the file in non-static functions, which we'll tackle
in upcoming commits.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx.c | 49 +++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/midx.c b/midx.c
index 079c45a1aafb658a7b887ac216cc6ecf5f0fb6ff..6f0fb8285af14843da132ef1b0c3a8bdd06732c9 100644
--- a/midx.c
+++ b/midx.c
@@ -25,7 +25,7 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 
 const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 {
-	return m->data + m->data_len - the_hash_algo->rawsz;
+	return m->data + m->data_len - m->repo->hash_algo->rawsz;
 }
 
 void get_midx_filename(struct strbuf *out, const char *object_dir)
@@ -94,7 +94,8 @@ static int midx_read_object_offsets(const unsigned char *chunk_start,
 
 #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
 
-static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir,
+static struct multi_pack_index *load_multi_pack_index_one(struct repository *r,
+							  const char *object_dir,
 							  const char *midx_name,
 							  int local)
 {
@@ -131,7 +132,7 @@ static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir
 	m->data = midx_map;
 	m->data_len = midx_size;
 	m->local = local;
-	m->repo = the_repository;
+	m->repo = r;
 
 	m->signature = get_be32(m->data);
 	if (m->signature != MIDX_SIGNATURE)
@@ -144,12 +145,12 @@ static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir
 		      m->version);
 
 	hash_version = m->data[MIDX_BYTE_HASH_VERSION];
-	if (hash_version != oid_version(the_hash_algo)) {
+	if (hash_version != oid_version(r->hash_algo)) {
 		error(_("multi-pack-index hash version %u does not match version %u"),
-		      hash_version, oid_version(the_hash_algo));
+		      hash_version, oid_version(r->hash_algo));
 		goto cleanup_fail;
 	}
-	m->hash_len = the_hash_algo->rawsz;
+	m->hash_len = r->hash_algo->rawsz;
 
 	m->num_chunks = m->data[MIDX_BYTE_NUM_CHUNKS];
 
@@ -206,8 +207,8 @@ static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir
 			      m->pack_names[i]);
 	}
 
-	trace2_data_intmax("midx", the_repository, "load/num_packs", m->num_packs);
-	trace2_data_intmax("midx", the_repository, "load/num_objects", m->num_objects);
+	trace2_data_intmax("midx", r, "load/num_packs", m->num_packs);
+	trace2_data_intmax("midx", r, "load/num_objects", m->num_objects);
 
 	free_chunkfile(cf);
 	return m;
@@ -240,8 +241,9 @@ void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
 	strbuf_addf(buf, "/multi-pack-index-%s.%s", hash_to_hex(hash), ext);
 }
 
-static int open_multi_pack_index_chain(const char *chain_file,
-				       int *fd, struct stat *st)
+static int open_multi_pack_index_chain(const struct git_hash_algo *hash_algo,
+				       const char *chain_file, int *fd,
+				       struct stat *st)
 {
 	*fd = git_open(chain_file);
 	if (*fd < 0)
@@ -250,7 +252,7 @@ static int open_multi_pack_index_chain(const char *chain_file,
 		close(*fd);
 		return 0;
 	}
-	if (st->st_size < the_hash_algo->hexsz) {
+	if (st->st_size < hash_algo->hexsz) {
 		close(*fd);
 		if (!st->st_size) {
 			/* treat empty files the same as missing */
@@ -292,7 +294,8 @@ static int add_midx_to_chain(struct multi_pack_index *midx,
 	return 1;
 }
 
-static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
+static struct multi_pack_index *load_midx_chain_fd_st(struct repository *r,
+						      const char *object_dir,
 						      int local,
 						      int fd, struct stat *st,
 						      int *incomplete_chain)
@@ -303,7 +306,7 @@ static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
 	uint32_t i, count;
 	FILE *fp = xfdopen(fd, "r");
 
-	count = st->st_size / (the_hash_algo->hexsz + 1);
+	count = st->st_size / (r->hash_algo->hexsz + 1);
 
 	for (i = 0; i < count; i++) {
 		struct multi_pack_index *m;
@@ -312,7 +315,7 @@ static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
 		if (strbuf_getline_lf(&buf, fp) == EOF)
 			break;
 
-		if (get_oid_hex(buf.buf, &layer)) {
+		if (get_oid_hex_algop(buf.buf, &layer, r->hash_algo)) {
 			warning(_("invalid multi-pack-index chain: line '%s' "
 				  "not a hash"),
 				buf.buf);
@@ -325,7 +328,7 @@ static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
 		strbuf_reset(&buf);
 		get_split_midx_filename_ext(&buf, object_dir, layer.hash,
 					    MIDX_EXT_MIDX);
-		m = load_multi_pack_index_one(object_dir, buf.buf, local);
+		m = load_multi_pack_index_one(r, object_dir, buf.buf, local);
 
 		if (m) {
 			if (add_midx_to_chain(m, midx_chain)) {
@@ -348,7 +351,8 @@ static struct multi_pack_index *load_midx_chain_fd_st(const char *object_dir,
 	return midx_chain;
 }
 
-static struct multi_pack_index *load_multi_pack_index_chain(const char *object_dir,
+static struct multi_pack_index *load_multi_pack_index_chain(struct repository *r,
+							    const char *object_dir,
 							    int local)
 {
 	struct strbuf chain_file = STRBUF_INIT;
@@ -357,10 +361,10 @@ static struct multi_pack_index *load_multi_pack_index_chain(const char *object_d
 	struct multi_pack_index *m = NULL;
 
 	get_midx_chain_filename(&chain_file, object_dir);
-	if (open_multi_pack_index_chain(chain_file.buf, &fd, &st)) {
+	if (open_multi_pack_index_chain(r->hash_algo, chain_file.buf, &fd, &st)) {
 		int incomplete;
 		/* ownership of fd is taken over by load function */
-		m = load_midx_chain_fd_st(object_dir, local, fd, &st,
+		m = load_midx_chain_fd_st(r, object_dir, local, fd, &st,
 					  &incomplete);
 	}
 
@@ -376,9 +380,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir,
 
 	get_midx_filename(&midx_name, object_dir);
 
-	m = load_multi_pack_index_one(object_dir, midx_name.buf, local);
+	m = load_multi_pack_index_one(the_repository, object_dir,
+				      midx_name.buf, local);
 	if (!m)
-		m = load_multi_pack_index_chain(object_dir, local);
+		m = load_multi_pack_index_chain(the_repository, object_dir, local);
 
 	strbuf_release(&midx_name);
 
@@ -520,7 +525,7 @@ int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
 		     uint32_t *result)
 {
 	int ret = bsearch_hash(oid->hash, m->chunk_oid_fanout,
-			       m->chunk_oid_lookup, the_hash_algo->rawsz,
+			       m->chunk_oid_lookup, m->repo->hash_algo->rawsz,
 			       result);
 	if (result)
 		*result += m->num_objects_in_base;
@@ -551,7 +556,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 	n = midx_for_object(&m, n);
 
 	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n),
-		the_repository->hash_algo);
+		m->repo->hash_algo);
 	return oid;
 }
 

-- 
2.47.0


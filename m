Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D861D1514
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030627; cv=none; b=Yl/BbgZTSrU/29Vxjy5IiA0fzyLN5CFVvz6cvZba2lG5VDiC2/tXPhO5plulruNTvyAkh29wMTP7JhsW8GuvvagOFzWSr47dDDbseb+Rdzeg2/VRE76oWN+VEh01ctOCEIVagLL+K6xHvotCwZ/c7JFPoJkudlvfyFqbFOs0Mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030627; c=relaxed/simple;
	bh=hgMcM7RU+5OOznCJFeSrWwbcsDbQEcDGjBTNvWC4fI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DH3ajkDi2pC069UIVYDAQa+iHbRT6pRJSptNz1/zLLLxTbeJCW/bCHVHk9+swSXOjRecVOcZ2/egiV4v19cRBm++SwbhKEOy+w43OCDreZJzB3LPHT3LKlPx2p/J7hMoIH6cFk4/i6ywySLDjDNjUHeu3+zCRdd8bYd0sHPrpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0mMfhkO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0mMfhkO"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa3a79d4d59so181786566b.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732030623; x=1732635423; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNScgfXDNZe14P6alytYLQFb9MHc0hfFQBIXj3QZLl4=;
        b=e0mMfhkOl57DuucAQh5jlbZb2La/HvrtMMlrVMlQp/l/jktB4k/XdzahXYGTX3fEcn
         8ZzOs8RDgoWVLLgnYdk2wu/N2M1gjPlRm5I1ZE25tP+QDIl2kZw04gBmAXgAPCxdPrw0
         bMX4Y3Q3Xpaeq8kdEZGDCWpUWYZTVBLMga3YePOePn257ecXTaVNAwVq2WPfh0BNbaRR
         w9FuKI619nIUn7R6ue1e8bvYTG5rXczuQMzwLPhUGcunHULsQqEwt023oERV2TB5xcnH
         jAEUWfQyhZOU8NfhbPyiNuKa7QNlzgtSQpXPBl8uR/GnCk0PMHtdTYpbK9+EHocjUFf6
         GWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030623; x=1732635423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNScgfXDNZe14P6alytYLQFb9MHc0hfFQBIXj3QZLl4=;
        b=FoL7FZ/Ia7FxP2uZqXXwZaj4/Np73smKR8t8YJ7igq9mgdcQdnKS6VK5Vm4UL0mqFe
         Vx1uAa1sfXCr7K3J/CE9WdRzsTR0EfU4Me6fTfw/whkXiKXudmEMM3kvr9eJff+7dY4j
         qqkFMoO785BvZxgjB7LR3dF9ZNquj6Vod5bz9rdcSkLTBV1s7kehDCA2S7B3SLIGFpQK
         00GMPDgtfRspwp/v6hma9qpAfvqeqhPejXm7esfzhMMF72XM6AiKLIQof7n35rtwl74b
         8UpHFw82VdEBzucRKL5wjsuKs+zpnhT7TzQpJzm3tKaAGyuja3lEVJ6mPDzfX79t6pef
         UV9Q==
X-Gm-Message-State: AOJu0YyK+RpIFzxdYxL3hWTIziU+KKYn3qM36RHa7pmyzAlCcH0x3CAg
	opejyd1nHQACstnwtDEwJzSignmrpI3kxoAmRIkttEqvIVu+iymcwQSFXWmH
X-Google-Smtp-Source: AGHT+IHQm6bUO+MuA7ZclFYJwPK1/sf9CCPBpaNiU9rOx3TBUbG/VFjKPFC+yuvhqs8T5o7lY4Ve9Q==
X-Received: by 2002:a17:907:2dac:b0:a9a:46:83ee with SMTP id a640c23a62f3a-aa483525d31mr1649668866b.48.1732030623500;
        Tue, 19 Nov 2024 07:37:03 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm661900566b.42.2024.11.19.07.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:37:03 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Nov 2024 16:36:45 +0100
Subject: [PATCH v2 06/10] midx: cleanup internal usage of `the_repository`
 and `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-6-e2f607174efc@gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, shejialuo@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7347; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=hgMcM7RU+5OOznCJFeSrWwbcsDbQEcDGjBTNvWC4fI4=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnPLCYERFJCGdauPn+xYHXhkAqSvOmht2m8F596
 T9jhrPxpy2JAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzywmAAKCRA+1Z8kjkaM
 f5zmDACYhaVCvYGT0DSbbnxMWx/WxIBanYqGfp3Ikmloe6Dz1R1fcZjcQ2qKKxNnzkgROG18H6G
 ARnDY75igIavUrnvpaBQfJJsaIEZlpRmderbwabYzzs+Rmh3T5Ly1vzckh95qmZ7p0H2sSC4CAC
 9vjWTRKENt1tnVewawCqw34PXrwWkPwmEQWS/n0PvFQ6qfGcdz0lel3chhZjXobMYeQquavYacs
 1Oxgo3Xbe+p4L+dNA+EyBOR7R3kgxCNb3C3KeQzcT3CrXx4EkFqtX3PD0MlEcJ0MhKeoJkRSwA3
 QI3CsWezj0sksoMLktt50PHJ2N5vXvMowrIHemFZoGipOhf74dz3bNrRyGl8gycoTR4nzL+uil3
 +SKOrqTwRMTVjQgcpde4gjzvBeucqe7zPeACufCx4FvTo9ZoyYNU6RfQJaaLUCXwcTeUBStdVfG
 TCCLT3BNQnFrvPi1TdzzuQs+MVyoUpJZo9Bn2x/4/Pz8cH+cES+60ygtSgf4RLVE8lIgc=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In the `midx.c` file, there are multiple usages of `the_repository` and
`the_hash_algo` within static functions of the file. Some of the usages
can be simply swapped out with the available `repository` struct. While
some of them can be swapped out by passing the repository to the
required functions.

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


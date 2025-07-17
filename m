Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70161FF603
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728204; cv=none; b=ke2CUqLtdO/niEZGFdIvzNVlC1Xjw6/jQ2ig1L/RnDw5I3SM/unkOB17D+ub4lMiVMqU1wBr0af7klZ2DEtPGrqI8ucUJn3v3bgCPwPnXMM0sxsXbnObP4ShMctQ4vY1UwPeUBt/7tOmvdFgCN42tfheSeFC2Z2ESPfA6ROm7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728204; c=relaxed/simple;
	bh=A2LeTa6VhDIHTBJOxApx6SzxIkvcBlfoBidOvn6FoYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YNQOEtsBopL5TJRcCqgq+xYN6rrAHFKD5VeuNAj1wVYgwxYWwDyKl+a1bJd9eS8MC8U9gUYRX3uvDfMghbdLqYMLVhXszAj81TrPFeUrjFrzI7bhV6Gl2l/EuM1U+IDD5310Om2U8eD/8BcQSixUOE84dQjMSuRw8OIuFKPrzt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o4iGIwlV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UZMl4QUe; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o4iGIwlV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UZMl4QUe"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 08DEC1D00185;
	Thu, 17 Jul 2025 00:56:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 17 Jul 2025 00:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752728201;
	 x=1752814601; bh=EpVrdq9LYAZlEaph39kbfoW30vBHh2YywkzozjY9ILw=; b=
	o4iGIwlV/MxNhwTWJaKqPcF21xOdYGSvGmetLbdHwV97VQ2z/IEHABKSQXSF/CxR
	VxGHR9Ec7Am81MBg0X1ujwZgLmNAeBmfUHRYN7wRS/Xske+L01nvHDBwcdXYKEDE
	94j7QkN5hcGQesTMT4ufAXRuAjdrXXAsMp5wxFBlWH+S9uwBSItd6GSzzRjfaK7d
	XAtqPNQwLE7ZHaQkCT8/DNK+Hky2k+2ED4spvDLWuUaguupiFnpQLhSVKHe+JD5R
	Nwh2f52iyic9j+YFewLsfEI2TPc84E7DZDqekviHDf5yQdQXvn5e6whh1oylf4jW
	w3htwOdD2+JadYjYcjkPfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752728201; x=
	1752814601; bh=EpVrdq9LYAZlEaph39kbfoW30vBHh2YywkzozjY9ILw=; b=U
	ZMl4QUeHRylzQywXKbv/qAmQ/8jKa4Wcxy/5CWsIi1gIrZpTtDcSIovupoMeUbvO
	BLfntxlmH2g+BIiiSKaMfO7lomuCfTzza8Gx8eKClpLL7vaOp8NaGErG0Xp0u7hv
	lI0dQO+BHOsANho/UT0KDE5WaK7B2i9cTPIGfiB9lNf4IUnHWx04dxNLimk5BReM
	U0T7YIRf5wj/R0J1sfppowUEsIDSL7B9Cxdo56vWmH+Bbb5pZsx083E/dp+FM7t+
	J8Vs4sxdOhxlhSMsiyGE8C0RF5rDizNLJJ8TPyNMual58Y2IXyKTeKxyqLBaNxwz
	hXql9dG2FoaSc3K13TZJw==
X-ME-Sender: <xms:iYJ4aN3LYhnsGVYgC4rqyWCoEK1475LL_zlzLbG2boW5nchmIz2YJw>
    <xme:iYJ4aPntB8sCW6_cnH4izXFBSIg3crIA1B1eaq6qumV-QuznLkhuVHA8afwLnKp0v
    LH84Tlxb7Glc84uYA>
X-ME-Received: <xmr:iYJ4aEUzW2dnHr8KJjmJrBOLM1xtaT7kuQLI7W_NCH8RlebBIEtnmZF46r8CwUMTlRJID-1YvaTxS3jj0kNi3Bnuc82zlUj78vINGA2BKCGP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:iYJ4aFuPlkCAg8ohew5J_O3Wm-ObuNxf-W4DrqIahWH0lVaQ3wXB-Q>
    <xmx:iYJ4aHYlx9qJ2LQG4fFNe4zJ0iLApj3PaIJhQefV5NZQjxuJrkv3PA>
    <xmx:iYJ4aEU_dEUN3X_hqtrXlF74Hr5AWImE6BpntiaSsgGioeMkriNWaw>
    <xmx:iYJ4aMQvZCRQwf9ZN7HWMxjg3v8E0834tPTIgTUNFC0S-txbVR3T2Q>
    <xmx:iYJ4aIDuc4beGsMgUnK2pp3ByqCc5g-Rw_QB0J2o_khRVK4PVocc3SMw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:56:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a95a7805 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:56:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 06:56:28 +0200
Subject: [PATCH v2 02/16] object-file: stop using `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-object-file-wo-the-repository-v2-2-36d2cd6c700e@pks.im>
References: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
In-Reply-To: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

There are a couple of users of the `the_hash_algo` macro, which
implicitly depends on `the_repository`. Adapt these callers to not do so
anymore, either by deriving it from already-available context or by
using `the_repository->hash_algo`. The latter variant doesn't yet help
to remove the global dependency, but such users will be adapted in the
following commits to not use `the_repository` anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 40 ++++++++++++++++++++++++----------------
 object-file.h |  1 +
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/object-file.c b/object-file.c
index 987cf289420..bc395febc9d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -25,6 +25,7 @@
 #include "pack.h"
 #include "packfile.h"
 #include "path.h"
+#include "read-cache-ll.h"
 #include "setup.h"
 #include "streaming.h"
 
@@ -41,9 +42,11 @@ static int get_conv_flags(unsigned flags)
 		return 0;
 }
 
-static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
+static void fill_loose_path(struct strbuf *buf,
+			    const struct object_id *oid,
+			    const struct git_hash_algo *algop)
 {
-	for (size_t i = 0; i < the_hash_algo->rawsz; i++) {
+	for (size_t i = 0; i < algop->rawsz; i++) {
 		static char hex[] = "0123456789abcdef";
 		unsigned int val = oid->hash[i];
 		strbuf_addch(buf, hex[val >> 4]);
@@ -60,7 +63,7 @@ const char *odb_loose_path(struct odb_source *source,
 	strbuf_reset(buf);
 	strbuf_addstr(buf, source->path);
 	strbuf_addch(buf, '/');
-	fill_loose_path(buf, oid);
+	fill_loose_path(buf, oid, source->odb->repo->hash_algo);
 	return buf->buf;
 }
 
@@ -1165,7 +1168,7 @@ static int index_mem(struct index_state *istate,
 
 		opts.strict = 1;
 		opts.error_func = hash_format_check_report;
-		if (fsck_buffer(null_oid(the_hash_algo), type, buf, size, &opts))
+		if (fsck_buffer(null_oid(istate->repo->hash_algo), type, buf, size, &opts))
 			die(_("refusing to create malformed object"));
 		fsck_finish(&opts);
 	}
@@ -1173,7 +1176,7 @@ static int index_mem(struct index_state *istate,
 	if (write_object)
 		ret = write_object_file(buf, size, type, oid);
 	else
-		hash_object_file(the_hash_algo, buf, size, type, oid);
+		hash_object_file(istate->repo->hash_algo, buf, size, type, oid);
 
 	strbuf_release(&nbuf);
 	return ret;
@@ -1199,7 +1202,7 @@ static int index_stream_convert_blob(struct index_state *istate,
 		ret = write_object_file(sbuf.buf, sbuf.len, OBJ_BLOB,
 					oid);
 	else
-		hash_object_file(the_hash_algo, sbuf.buf, sbuf.len, OBJ_BLOB,
+		hash_object_file(istate->repo->hash_algo, sbuf.buf, sbuf.len, OBJ_BLOB,
 				 oid);
 	strbuf_release(&sbuf);
 	return ret;
@@ -1297,7 +1300,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		if (strbuf_readlink(&sb, path, st->st_size))
 			return error_errno("readlink(\"%s\")", path);
 		if (!(flags & INDEX_WRITE_OBJECT))
-			hash_object_file(the_hash_algo, sb.buf, sb.len,
+			hash_object_file(istate->repo->hash_algo, sb.buf, sb.len,
 					 OBJ_BLOB, oid);
 		else if (write_object_file(sb.buf, sb.len, OBJ_BLOB, oid))
 			rc = error(_("%s: failed to insert into database"), path);
@@ -1328,6 +1331,7 @@ int read_pack_header(int fd, struct pack_header *header)
 
 int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 				struct strbuf *path,
+				const struct git_hash_algo *algop,
 				each_loose_object_fn obj_cb,
 				each_loose_cruft_fn cruft_cb,
 				each_loose_subdir_fn subdir_cb,
@@ -1364,12 +1368,12 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		namelen = strlen(de->d_name);
 		strbuf_setlen(path, baselen);
 		strbuf_add(path, de->d_name, namelen);
-		if (namelen == the_hash_algo->hexsz - 2 &&
+		if (namelen == algop->hexsz - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
-				  the_hash_algo->rawsz - 1)) {
-			oid_set_algo(&oid, the_hash_algo);
-			memset(oid.hash + the_hash_algo->rawsz, 0,
-			       GIT_MAX_RAWSZ - the_hash_algo->rawsz);
+				  algop->rawsz - 1)) {
+			oid_set_algo(&oid, algop);
+			memset(oid.hash + algop->rawsz, 0,
+			       GIT_MAX_RAWSZ - algop->rawsz);
 			if (obj_cb) {
 				r = obj_cb(&oid, path->buf, data);
 				if (r)
@@ -1405,7 +1409,8 @@ int for_each_loose_file_in_objdir_buf(struct strbuf *path,
 	int i;
 
 	for (i = 0; i < 256; i++) {
-		r = for_each_file_in_obj_subdir(i, path, obj_cb, cruft_cb,
+		r = for_each_file_in_obj_subdir(i, path, the_repository->hash_algo,
+						obj_cb, cruft_cb,
 						subdir_cb, data);
 		if (r)
 			break;
@@ -1481,6 +1486,7 @@ struct oidtree *odb_loose_cache(struct odb_source *source,
 	}
 	strbuf_addstr(&buf, source->path);
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
+				    source->odb->repo->hash_algo,
 				    append_loose_object,
 				    NULL, NULL,
 				    source->loose_objects_cache);
@@ -1501,7 +1507,8 @@ static int check_stream_oid(git_zstream *stream,
 			    const char *hdr,
 			    unsigned long size,
 			    const char *path,
-			    const struct object_id *expected_oid)
+			    const struct object_id *expected_oid,
+			    const struct git_hash_algo *algop)
 {
 	struct git_hash_ctx c;
 	struct object_id real_oid;
@@ -1509,7 +1516,7 @@ static int check_stream_oid(git_zstream *stream,
 	unsigned long total_read;
 	int status = Z_OK;
 
-	the_hash_algo->init_fn(&c);
+	algop->init_fn(&c);
 	git_hash_update(&c, hdr, stream->total_out);
 
 	/*
@@ -1594,7 +1601,8 @@ int read_loose_object(const char *path,
 
 	if (*oi->typep == OBJ_BLOB &&
 	    *size > repo_settings_get_big_file_threshold(the_repository)) {
-		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
+		if (check_stream_oid(&stream, hdr, *size, path, expected_oid,
+				     the_repository->hash_algo) < 0)
 			goto out_inflate;
 	} else {
 		*contents = unpack_loose_rest(&stream, hdr, *size, expected_oid);
diff --git a/object-file.h b/object-file.h
index 67b4ffc4808..222ff2871a1 100644
--- a/object-file.h
+++ b/object-file.h
@@ -89,6 +89,7 @@ typedef int each_loose_subdir_fn(unsigned int nr,
 				 void *data);
 int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 				struct strbuf *path,
+				const struct git_hash_algo *algo,
 				each_loose_object_fn obj_cb,
 				each_loose_cruft_fn cruft_cb,
 				each_loose_subdir_fn subdir_cb,

-- 
2.50.1.465.gcb3da1c9e6.dirty


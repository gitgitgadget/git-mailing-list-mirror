Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3826187FE8
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687659; cv=none; b=pxtm9Q/3qynq0RKVXiFz6qBmqDGgsQcDMHiCxjLkQYtNiJzDeaZMukAVN1ZVrTyfTkFrlWiGL8CYoutzVu/6qeE7Ho50FsNMiqB1NT9cS792lHkF2S/z56yvabOMpwYKLtLyBQwyQCu7KzB1vykxbiBYKZjQd0vj+h3tIfaugcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687659; c=relaxed/simple;
	bh=mFJJt1ngQcysSachnt6VDGjJG6e6UgHPzN8eIm5VGys=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQT5We5u40NKB6nGLevAKJSkr7lNjo7TONw/Qnf1ICjpSpreFPq3QY2yaX0JS97+xNzQzUx3uxWw/yteCzJV9I1r6Ufn4aSRZSwqZfg89Ujqw8hpfzwbOvbrTr22V6iEX7fHGli63ndpZvbabh3VZtHCpKtmkkpvPSVmN+w1Vww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rKBFN8fK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SkWqUr3I; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rKBFN8fK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SkWqUr3I"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E3A71140268
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 05:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687657; x=1727774057; bh=6tV1M7ju0E
	XAmCv/0wh6kRzOnXIF96oJW58XhpZ8b5k=; b=rKBFN8fKkz6m2aOjSix3r2kUwv
	UNWCGtjmU8Q8IDo3OBVdNZbyUfnRGew1H2UcL7QSQlEdDsPQODo9pOTVNz3AlIFU
	O4ddMTkTL2y64MIwrL7Qc2W8BjcyASrkMMubcAvKRnQWMOIcfi3FZz4HT14sPx7x
	3cX8ccpHmwt/t41HOmsFlYhjcSKI2QtEt7V4ikLKTzUhNK0MmicBiT5mXWPOMwIc
	BzA5c5DHZLITwnPQseg5FMT7OIAfjYEew1v3cQHyxGnU5GZtCvYoaFu2ODVymCR2
	7refKy/E0f21eEJJ2LwqSCGDKewFQ8yQKEXec19wA8A0E4SupdYq4tibOZGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687657; x=1727774057; bh=6tV1M7ju0EXAmCv/0wh6kRzOnXIF
	96oJW58XhpZ8b5k=; b=SkWqUr3I3wiRc1/8McgjEk/Muclz2RVQUqqEDK7NliAR
	KWzCt25ELTDCicsANLnqeckue5TQq49Q2qSAIQ3ubxKKyum3016WXQFNQ7oyEIg+
	vbQRMP9AI9mH8hP1kmD8JZi29zPvvLKM6FxMA8M2SP5a0JBxogNsD7zwR+IatDb+
	vqbWfSCwafB0JaRJB6CrneWYziCGzpf0w9v7eJQbMLCKIx8UfJZdRV4R+CqS6dln
	WPmdQ2aLMwsYPg7yuI71SzsI9Y1eizaNVnfNYuaNlv/FmLxba0JrJ6B8dxq/Vgpa
	Pur6+Pc4iMAAJQlmXmLeRCZHL9vFjFq/3zPYLqTHDg==
X-ME-Sender: <xms:6Wv6ZguypBs817njNvUyHAZ7o3nMcRJ2aQJtMbtVYaEss5qkd_pPdw>
    <xme:6Wv6ZtfML7E9kFFhnGs-QH-Q3iMRDu54InD7NX0e2lWF17k8peAVguj_FQCCmaFfj
    MylIyP05Rk9b7Wn0A>
X-ME-Received: <xmr:6Wv6Zry596KVOq1D_6nL9ujgk13FVtFWeU0FbhWv7lh4RvEanW58oQMRSVcAAq8zfpeFFkTw828wOGTMlxt0UMSzL7g8yCKoPFU5DYq2On7mahA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6Wv6ZjNpjHqHxY7LX_5Us0H6fGPdLhU-VT7XajKsenGs55-qTMaCrQ>
    <xmx:6Wv6Zg9hlMUbnvfz3e59Re95MQYiN20mksr2Hmp7ObtPMlWEOyGYjg>
    <xmx:6Wv6ZrVpG2z2Hzr79fWaTTdqF_hUNaZdqxwvuBp47JnELelnJrNmcg>
    <xmx:6Wv6ZpcxHoTw-P7DiSg7UsQcmejlNrX9OxV2nnvt3R_WJGrVM6I6rA>
    <xmx:6Wv6ZulHJv7WoFmoFAZnfR2shV7qzXw9n-0io_uF4GVKmUhXSB38k0TE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:14:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3b48b40b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:13:30 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:14:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/23] pack-write: fix return parameter of
 `write_rev_file_order()`
Message-ID: <2f3e17915d750c0ded8bf4f2f57106b81e9d8b3b.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

While the return parameter of `write_rev_file_order()` is a string
constant, the function may indeed return an allocated string when its
first parameter is a `NULL` pointer. This makes for a confusing calling
convention, where callers need to be aware of these intricate ownership
rules and cast away the constness to free the string in some cases.

Adapt the function and its caller `write_rev_file()` to always return an
allocated string and adapt callers to always free the return value.

Note that this requires us to also adapt `rename_tmp_packfile()`, which
compares the pointers to packfile data with each other. Now that the
path of the reverse index file gets allocated unconditionally the check
will always fail. This is fixed by using strcmp(3P) instead, which also
feels way less fragile.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/index-pack.c              |  7 +++---
 midx-write.c                      |  3 ++-
 pack-write.c                      | 42 +++++++++++++++++--------------
 pack.h                            |  4 +--
 t/t5327-multi-pack-bitmaps-rev.sh |  1 +
 5 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index e228c56ff2..9d23b41b3a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1505,7 +1505,7 @@ static void rename_tmp_packfile(const char **final_name,
 				struct strbuf *name, unsigned char *hash,
 				const char *ext, int make_read_only_if_same)
 {
-	if (*final_name != curr_name) {
+	if (!*final_name || strcmp(*final_name, curr_name)) {
 		if (!*final_name)
 			*final_name = odb_pack_name(name, hash, ext);
 		if (finalize_object_file(curr_name, *final_name))
@@ -1726,7 +1726,7 @@ int cmd_index_pack(int argc,
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, rev_index;
 	const char *curr_index;
-	const char *curr_rev_index = NULL;
+	char *curr_rev_index = NULL;
 	const char *index_name = NULL, *pack_name = NULL, *rev_index_name = NULL;
 	const char *keep_msg = NULL;
 	const char *promisor_msg = NULL;
@@ -1968,8 +1968,7 @@ int cmd_index_pack(int argc,
 		free((void *) curr_pack);
 	if (!index_name)
 		free((void *) curr_index);
-	if (!rev_index_name)
-		free((void *) curr_rev_index);
+	free(curr_rev_index);
 
 	/*
 	 * Let the caller know this pack is not self contained
diff --git a/midx-write.c b/midx-write.c
index 625c7d3137..b3a5f6c516 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -649,7 +649,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 				     struct write_midx_context *ctx)
 {
 	struct strbuf buf = STRBUF_INIT;
-	const char *tmp_file;
+	char *tmp_file;
 
 	trace2_region_enter("midx", "write_midx_reverse_index", the_repository);
 
@@ -662,6 +662,7 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 		die(_("cannot store reverse index file"));
 
 	strbuf_release(&buf);
+	free(tmp_file);
 
 	trace2_region_leave("midx", "write_midx_reverse_index", the_repository);
 }
diff --git a/pack-write.c b/pack-write.c
index 27965672f1..9961149e65 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -212,15 +212,15 @@ static void write_rev_trailer(struct hashfile *f, const unsigned char *hash)
 	hashwrite(f, hash, the_hash_algo->rawsz);
 }
 
-const char *write_rev_file(const char *rev_name,
-			   struct pack_idx_entry **objects,
-			   uint32_t nr_objects,
-			   const unsigned char *hash,
-			   unsigned flags)
+char *write_rev_file(const char *rev_name,
+		     struct pack_idx_entry **objects,
+		     uint32_t nr_objects,
+		     const unsigned char *hash,
+		     unsigned flags)
 {
 	uint32_t *pack_order;
 	uint32_t i;
-	const char *ret;
+	char *ret;
 
 	if (!(flags & WRITE_REV) && !(flags & WRITE_REV_VERIFY))
 		return NULL;
@@ -238,13 +238,14 @@ const char *write_rev_file(const char *rev_name,
 	return ret;
 }
 
-const char *write_rev_file_order(const char *rev_name,
-				 uint32_t *pack_order,
-				 uint32_t nr_objects,
-				 const unsigned char *hash,
-				 unsigned flags)
+char *write_rev_file_order(const char *rev_name,
+			   uint32_t *pack_order,
+			   uint32_t nr_objects,
+			   const unsigned char *hash,
+			   unsigned flags)
 {
 	struct hashfile *f;
+	char *path;
 	int fd;
 
 	if ((flags & WRITE_REV) && (flags & WRITE_REV_VERIFY))
@@ -254,12 +255,13 @@ const char *write_rev_file_order(const char *rev_name,
 		if (!rev_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
 			fd = odb_mkstemp(&tmp_file, "pack/tmp_rev_XXXXXX");
-			rev_name = strbuf_detach(&tmp_file, NULL);
+			path = strbuf_detach(&tmp_file, NULL);
 		} else {
 			unlink(rev_name);
 			fd = xopen(rev_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
+			path = xstrdup(rev_name);
 		}
-		f = hashfd(fd, rev_name);
+		f = hashfd(fd, path);
 	} else if (flags & WRITE_REV_VERIFY) {
 		struct stat statbuf;
 		if (stat(rev_name, &statbuf)) {
@@ -270,22 +272,24 @@ const char *write_rev_file_order(const char *rev_name,
 				die_errno(_("could not stat: %s"), rev_name);
 		}
 		f = hashfd_check(rev_name);
-	} else
+		path = xstrdup(rev_name);
+	} else {
 		return NULL;
+	}
 
 	write_rev_header(f);
 
 	write_rev_index_positions(f, pack_order, nr_objects);
 	write_rev_trailer(f, hash);
 
-	if (rev_name && adjust_shared_perm(rev_name) < 0)
-		die(_("failed to make %s readable"), rev_name);
+	if (adjust_shared_perm(path) < 0)
+		die(_("failed to make %s readable"), path);
 
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
 			  ((flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
 
-	return rev_name;
+	return path;
 }
 
 static void write_mtimes_header(struct hashfile *f)
@@ -549,7 +553,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 unsigned char hash[],
 			 char **idx_tmp_name)
 {
-	const char *rev_tmp_name = NULL;
+	char *rev_tmp_name = NULL;
 	char *mtimes_tmp_name = NULL;
 
 	if (adjust_shared_perm(pack_tmp_name))
@@ -575,7 +579,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 	if (mtimes_tmp_name)
 		rename_tmp_packfile(name_buffer, mtimes_tmp_name, "mtimes");
 
-	free((char *)rev_tmp_name);
+	free(rev_tmp_name);
 	free(mtimes_tmp_name);
 }
 
diff --git a/pack.h b/pack.h
index 3ab9e3f60c..02bbdfb19c 100644
--- a/pack.h
+++ b/pack.h
@@ -96,8 +96,8 @@ struct ref;
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
 
-const char *write_rev_file(const char *rev_name, struct pack_idx_entry **objects, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
-const char *write_rev_file_order(const char *rev_name, uint32_t *pack_order, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
+char *write_rev_file(const char *rev_name, struct pack_idx_entry **objects, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
+char *write_rev_file_order(const char *rev_name, uint32_t *pack_order, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
 
 /*
  * The "hdr" output buffer should be at least this big, which will handle sizes
diff --git a/t/t5327-multi-pack-bitmaps-rev.sh b/t/t5327-multi-pack-bitmaps-rev.sh
index 9cac03a94b..994a8e6be4 100755
--- a/t/t5327-multi-pack-bitmaps-rev.sh
+++ b/t/t5327-multi-pack-bitmaps-rev.sh
@@ -2,6 +2,7 @@
 
 test_description='exercise basic multi-pack bitmap functionality (.rev files)'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "${TEST_DIRECTORY}/lib-bitmap.sh"
 
-- 
2.46.2.852.g229c0bf0e5.dirty


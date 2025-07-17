Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A56A202F87
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728227; cv=none; b=dBvjm5VspGU16lFsMEVk+UZiZdAH5cGD9cXL2I2I1pIh81WWl5i/sh9xsFeUonnjg4uHlt4TAXSj91sIZIUB38DrKZkbgsenXT34jCPUykz7fL6b50PltpCQF9mYtCOCpvTAeSu4HqtNU/KXNFAl+e7Enae06njv7tJKGtAKnb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728227; c=relaxed/simple;
	bh=niQQT3aZLtqj4XSImQY9Qjw0JLvK+aAxUEfsfkwHahQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SiKutd+OLi06G1ubeXFW7Lvkarp2Nq+RGCA3f4cztj1t06Ms/eqYHLG/lUG1ovZfP8MIE4PBt8xSouwvBhISt5UTshGoY0DuzXa485e+qWP+w1i8B2tU7AAB3b6W3VvpG55ZZiTiAHqX1eQDYhKKIIl+eQHS/mWzus147OcU4Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KI/mhoPe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NQvPCKXd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KI/mhoPe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NQvPCKXd"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id D72281D0019E;
	Thu, 17 Jul 2025 00:57:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 17 Jul 2025 00:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752728224;
	 x=1752814624; bh=OhiKU8bM+uHUgGlOnDnbwJ/jFm28Y0rT337B6vDjgSA=; b=
	KI/mhoPehsM0wooV6zk+eIAiAdmDnkX2KyMHRv8GVPXAykPkN0ShFOLEijwI1kpI
	snPwcfVK6pgjEQPP4eO/MwZQrPE9nTg0q3ozKsg8mvkxat3JsXFvMkz5hkFeMnYZ
	l/3XyvAyCeG6uqLcjRprPL636rJ9nrPCouhPHrEtxtoWTWh+PMppcWL5aBnT72jd
	/8LGEw2h/4FjGJ5lCKy8vu7nqTbxfn4C2I2+OsLTJUpwM4m2xWSgErAhX1ZTZlI3
	EDf7hHpzLUzBCMEg338scDQH73fRLXK7okVXetGhlL6JXnS6No8nD5w53XNcRloc
	xLRRTy+fgArKqAqppvHd6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752728224; x=
	1752814624; bh=OhiKU8bM+uHUgGlOnDnbwJ/jFm28Y0rT337B6vDjgSA=; b=N
	QvPCKXdEYbjBEBEVG4BEEzMbukHmItFfzHG/440cZxlw3VPeR783wT8HYnfzzSDC
	llrIztQP3YEwtwCvCkQq3OUBE5n/3u9A43HDtdfHwV4lm8nBE+7WjyVV7nYbBwLC
	aHXrSb0AggznIHBLSJmU2aXzwqAC1lng+eb8CVja59OsB0PKLHI+QqKA2XXrVeoh
	u/Y166oS3CMqhpcefiDlgQPfaYXz7VmMuhSqzPT5qT34X694/z6IATkz1gJ1KcTz
	Dy+3daAdne1yYtFPFgjiI51YnKPyaqwicM0tnFX3GDZ1gnGWKKKwhaNlDYdK0oYa
	t/63zdpdJlvwpVLzbYFaw==
X-ME-Sender: <xms:oIJ4aIFDTdYlCMVTfZJibZC1x6ncQHO-3KUm8GNb6mxui9_xGoAHiw>
    <xme:oIJ4aM02imUAigGCsIcagIynaeMP5xDLtdt2awkrZ8vBb2uPWyOTQGgsIN9_ic0Qw
    OpS7mXlsv80GlavZA>
X-ME-Received: <xmr:oIJ4aImtsjn_RULE5t0S1xWatLReRIUPlosFMcq2deeNql0Cu03B7GJvNnSlQ2cUSDZficmmLU1kc9SH3MYZyALkJ9mhLgs_h3N0rTplCs97>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oIJ4aE-2XhbGTsfjPJV59tzUGy0xnin564BsB4N6kwhN8Iwq2HxiuQ>
    <xmx:oIJ4aFrz7jS83qo3eleYPdJlizcuSn2AYxMSJZkdCCp2QywjsJeJ9w>
    <xmx:oIJ4aFnBkfGewSA1LGFV3DuL4HcgLavWj8dX0Imwyd-rM3Ay5TgSiw>
    <xmx:oIJ4aEiKQjJWyU9ArduunPaHu2uKH5GH1hpCDDVt9EyDGreMR80HUg>
    <xmx:oIJ4aDQMAwp4esPEaLPnnCYwZGdqbRfDDCEhPXA1B1jH-THoeRnbhaP2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:57:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bd7696e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:57:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 06:56:35 +0200
Subject: [PATCH v2 09/16] odb: introduce `odb_write_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-object-file-wo-the-repository-v2-9-36d2cd6c700e@pks.im>
References: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
In-Reply-To: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

We do not have a backend-agnostic way to write objects into an object
database. While there is `write_object_file()`, this function is rather
specific to the loose object format.

Introduce `odb_write_object()` to plug this gap. For now, this function
is a simple wrapper around `write_object_file()` and doesn't even use
the passed-in object database yet. This will change in subsequent
commits, where `write_object_file()` is converted so that it works on
top of an `odb_source`. `odb_write_object()` will then become
responsible for deciding which source an object shall be written to.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c                  | 11 +++++++----
 builtin/checkout.c       |  2 +-
 builtin/merge-file.c     |  3 ++-
 builtin/mktag.c          |  2 +-
 builtin/mktree.c         |  2 +-
 builtin/notes.c          |  3 ++-
 builtin/receive-pack.c   |  4 ++--
 builtin/replace.c        |  3 ++-
 builtin/tag.c            |  4 ++--
 builtin/unpack-objects.c | 12 ++++++------
 cache-tree.c             |  5 ++---
 commit.c                 |  4 ++--
 match-trees.c            |  2 +-
 merge-ort.c              |  7 ++++---
 notes-cache.c            |  3 ++-
 notes.c                  | 12 ++++++++----
 object-file.c            | 18 +++++++++---------
 object-file.h            | 26 +++-----------------------
 odb.c                    | 10 ++++++++++
 odb.h                    | 38 ++++++++++++++++++++++++++++++++++++++
 read-cache.c             |  2 +-
 21 files changed, 106 insertions(+), 67 deletions(-)

diff --git a/apply.c b/apply.c
index a6836692d0c..ffb9d9f76d6 100644
--- a/apply.c
+++ b/apply.c
@@ -3621,7 +3621,7 @@ static int try_threeway(struct apply_state *state,
 
 	/* Preimage the patch was prepared for */
 	if (patch->is_new)
-		write_object_file("", 0, OBJ_BLOB, &pre_oid);
+		odb_write_object(the_repository->objects, "", 0, OBJ_BLOB, &pre_oid);
 	else if (repo_get_oid(the_repository, patch->old_oid_prefix, &pre_oid) ||
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
 		return error(_("repository lacks the necessary blob to perform 3-way merge."));
@@ -3637,7 +3637,8 @@ static int try_threeway(struct apply_state *state,
 		return -1;
 	}
 	/* post_oid is theirs */
-	write_object_file(tmp_image.buf.buf, tmp_image.buf.len, OBJ_BLOB, &post_oid);
+	odb_write_object(the_repository->objects, tmp_image.buf.buf,
+			 tmp_image.buf.len, OBJ_BLOB, &post_oid);
 	image_clear(&tmp_image);
 
 	/* our_oid is ours */
@@ -3650,7 +3651,8 @@ static int try_threeway(struct apply_state *state,
 			return error(_("cannot read the current contents of '%s'"),
 				     patch->old_name);
 	}
-	write_object_file(tmp_image.buf.buf, tmp_image.buf.len, OBJ_BLOB, &our_oid);
+	odb_write_object(the_repository->objects, tmp_image.buf.buf,
+			 tmp_image.buf.len, OBJ_BLOB, &our_oid);
 	image_clear(&tmp_image);
 
 	/* in-core three-way merge between post and our using pre as base */
@@ -4360,7 +4362,8 @@ static int add_index_file(struct apply_state *state,
 			}
 			fill_stat_cache_info(state->repo->index, ce, &st);
 		}
-		if (write_object_file(buf, size, OBJ_BLOB, &ce->oid) < 0) {
+		if (odb_write_object(the_repository->objects, buf, size,
+				     OBJ_BLOB, &ce->oid) < 0) {
 			discard_cache_entry(ce);
 			return error(_("unable to create backing store "
 				       "for newly created file %s"), path);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0a90b86a729..f95eb64ffb3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -320,7 +320,7 @@ static int checkout_merged(int pos, const struct checkout *state,
 	 * (it also writes the merge result to the object database even
 	 * when it may contain conflicts).
 	 */
-	if (write_object_file(result_buf.ptr, result_buf.size, OBJ_BLOB, &oid))
+	if (odb_write_object(the_repository->objects, result_buf.ptr, result_buf.size, OBJ_BLOB, &oid))
 		die(_("Unable to add merge result for '%s'"), path);
 	free(result_buf.ptr);
 	ce = make_transient_cache_entry(mode, &oid, path, 2, ce_mem_pool);
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 9464f275629..b8b25a14e6d 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -155,7 +155,8 @@ int cmd_merge_file(int argc,
 		if (object_id && !to_stdout) {
 			struct object_id oid;
 			if (result.size) {
-				if (write_object_file(result.ptr, result.size, OBJ_BLOB, &oid) < 0)
+				if (odb_write_object(the_repository->objects, result.ptr,
+						     result.size, OBJ_BLOB, &oid) < 0)
 					ret = error(_("Could not write object file"));
 			} else {
 				oidcpy(&oid, the_hash_algo->empty_blob);
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 27e649736cf..12552bbb217 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -106,7 +106,7 @@ int cmd_mktag(int argc,
 	if (verify_object_in_tag(&tagged_oid, &tagged_type) < 0)
 		die(_("tag on stdin did not refer to a valid object"));
 
-	if (write_object_file(buf.buf, buf.len, OBJ_TAG, &result) < 0)
+	if (odb_write_object(the_repository->objects, buf.buf, buf.len, OBJ_TAG, &result) < 0)
 		die(_("unable to write tag file"));
 
 	strbuf_release(&buf);
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 81df7f6099f..12772303f50 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -63,7 +63,7 @@ static void write_tree(struct object_id *oid)
 		strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
 	}
 
-	write_object_file(buf.buf, buf.len, OBJ_TREE, oid);
+	odb_write_object(the_repository->objects, buf.buf, buf.len, OBJ_TREE, oid);
 	strbuf_release(&buf);
 }
 
diff --git a/builtin/notes.c b/builtin/notes.c
index a9529b1696a..a3580b4aa3d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -229,7 +229,8 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 
 static void write_note_data(struct note_data *d, struct object_id *oid)
 {
-	if (write_object_file(d->buf.buf, d->buf.len, OBJ_BLOB, oid)) {
+	if (odb_write_object(the_repository->objects, d->buf.buf,
+			     d->buf.len, OBJ_BLOB, oid)) {
 		int status = die_message(_("unable to write note object"));
 
 		if (d->edit_path)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index dd1d1446e75..bd9baf81e56 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -760,8 +760,8 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		int bogs /* beginning_of_gpg_sig */;
 
 		already_done = 1;
-		if (write_object_file(push_cert.buf, push_cert.len, OBJ_BLOB,
-				      &push_cert_oid))
+		if (odb_write_object(the_repository->objects, push_cert.buf,
+				     push_cert.len, OBJ_BLOB, &push_cert_oid))
 			oidclr(&push_cert_oid, the_repository->hash_algo);
 
 		memset(&sigcheck, '\0', sizeof(sigcheck));
diff --git a/builtin/replace.c b/builtin/replace.c
index 5ff2ab723cb..7c46d05ec15 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -488,7 +488,8 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 		return -1;
 	}
 
-	if (write_object_file(buf.buf, buf.len, OBJ_COMMIT, &new_oid)) {
+	if (odb_write_object(the_repository->objects, buf.buf,
+			     buf.len, OBJ_COMMIT, &new_oid)) {
 		strbuf_release(&buf);
 		return error(_("could not write replacement commit for: '%s'"),
 			     old_ref);
diff --git a/builtin/tag.c b/builtin/tag.c
index 46cbf892e34..8fbe9e7be04 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -271,8 +271,8 @@ static int build_tag_object(struct strbuf *buf, int sign, struct object_id *resu
 	struct object_id *compat_oid = NULL, compat_oid_buf;
 	if (sign && do_sign(buf, &compat_oid, &compat_oid_buf) < 0)
 		return error(_("unable to sign the tag"));
-	if (write_object_file_flags(buf->buf, buf->len, OBJ_TAG, result,
-				    compat_oid, 0) < 0)
+	if (odb_write_object_ext(the_repository->objects, buf->buf,
+				 buf->len, OBJ_TAG, result, compat_oid, 0) < 0)
 		return error(_("unable to write tag file"));
 	return 0;
 }
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index a69d59eb50c..1a4fbef36f8 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -204,8 +204,8 @@ static void write_cached_object(struct object *obj, struct obj_buffer *obj_buf)
 {
 	struct object_id oid;
 
-	if (write_object_file(obj_buf->buffer, obj_buf->size,
-			      obj->type, &oid) < 0)
+	if (odb_write_object(the_repository->objects, obj_buf->buffer, obj_buf->size,
+			     obj->type, &oid) < 0)
 		die("failed to write object %s", oid_to_hex(&obj->oid));
 	obj->flags |= FLAG_WRITTEN;
 }
@@ -272,16 +272,16 @@ static void write_object(unsigned nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
 	if (!strict) {
-		if (write_object_file(buf, size, type,
-				      &obj_list[nr].oid) < 0)
+		if (odb_write_object(the_repository->objects, buf, size, type,
+				     &obj_list[nr].oid) < 0)
 			die("failed to write object");
 		added_object(nr, type, buf, size);
 		free(buf);
 		obj_list[nr].obj = NULL;
 	} else if (type == OBJ_BLOB) {
 		struct blob *blob;
-		if (write_object_file(buf, size, type,
-				      &obj_list[nr].oid) < 0)
+		if (odb_write_object(the_repository->objects, buf, size, type,
+				     &obj_list[nr].oid) < 0)
 			die("failed to write object");
 		added_object(nr, type, buf, size);
 		free(buf);
diff --git a/cache-tree.c b/cache-tree.c
index a4bc14ad15c..66ef2becbe0 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -456,9 +456,8 @@ static int update_one(struct cache_tree *it,
 	} else if (dryrun) {
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
 				 OBJ_TREE, &it->oid);
-	} else if (write_object_file_flags(buffer.buf, buffer.len, OBJ_TREE,
-					   &it->oid, NULL, flags & WRITE_TREE_SILENT
-					   ? WRITE_OBJECT_FILE_SILENT : 0)) {
+	} else if (odb_write_object_ext(the_repository->objects, buffer.buf, buffer.len, OBJ_TREE,
+					&it->oid, NULL, flags & WRITE_TREE_SILENT ? WRITE_OBJECT_SILENT : 0)) {
 		strbuf_release(&buffer);
 		return -1;
 	}
diff --git a/commit.c b/commit.c
index 15115125c36..bcc9aea55f6 100644
--- a/commit.c
+++ b/commit.c
@@ -1797,8 +1797,8 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		compat_oid = &compat_oid_buf;
 	}
 
-	result = write_object_file_flags(buffer.buf, buffer.len, OBJ_COMMIT,
-					 ret, compat_oid, 0);
+	result = odb_write_object_ext(the_repository->objects, buffer.buf, buffer.len,
+				      OBJ_COMMIT, ret, compat_oid, 0);
 out:
 	free(parent_buf);
 	strbuf_release(&buffer);
diff --git a/match-trees.c b/match-trees.c
index 5a8a5c39b04..4216933d06b 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -246,7 +246,7 @@ static int splice_tree(struct repository *r,
 		rewrite_with = oid2;
 	}
 	hashcpy(rewrite_here, rewrite_with->hash, r->hash_algo);
-	status = write_object_file(buf, sz, OBJ_TREE, result);
+	status = odb_write_object(r->objects, buf, sz, OBJ_TREE, result);
 	free(buf);
 	return status;
 }
diff --git a/merge-ort.c b/merge-ort.c
index 473ff61e36e..535ef3efc6f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2216,8 +2216,8 @@ static int handle_content_merge(struct merge_options *opt,
 		}
 
 		if (!ret && record_object &&
-		    write_object_file(result_buf.ptr, result_buf.size,
-				      OBJ_BLOB, &result->oid)) {
+		    odb_write_object(the_repository->objects, result_buf.ptr, result_buf.size,
+				     OBJ_BLOB, &result->oid)) {
 			path_msg(opt, ERROR_OBJECT_WRITE_FAILED, 0,
 				 pathnames[0], pathnames[1], pathnames[2], NULL,
 				 _("error: unable to add %s to database"), path);
@@ -3772,7 +3772,8 @@ static int write_tree(struct object_id *result_oid,
 	}
 
 	/* Write this object file out, and record in result_oid */
-	if (write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid))
+	if (odb_write_object(the_repository->objects, buf.buf,
+			     buf.len, OBJ_TREE, result_oid))
 		ret = -1;
 	strbuf_release(&buf);
 	return ret;
diff --git a/notes-cache.c b/notes-cache.c
index dd56feed6e8..bf5bb1f6c13 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -98,7 +98,8 @@ int notes_cache_put(struct notes_cache *c, struct object_id *key_oid,
 {
 	struct object_id value_oid;
 
-	if (write_object_file(data, size, OBJ_BLOB, &value_oid) < 0)
+	if (odb_write_object(the_repository->objects, data,
+			     size, OBJ_BLOB, &value_oid) < 0)
 		return -1;
 	return add_note(&c->tree, key_oid, &value_oid, NULL);
 }
diff --git a/notes.c b/notes.c
index 97b995f3f2d..7596c0df9a1 100644
--- a/notes.c
+++ b/notes.c
@@ -682,7 +682,8 @@ static int tree_write_stack_finish_subtree(struct tree_write_stack *tws)
 		ret = tree_write_stack_finish_subtree(n);
 		if (ret)
 			return ret;
-		ret = write_object_file(n->buf.buf, n->buf.len, OBJ_TREE, &s);
+		ret = odb_write_object(the_repository->objects, n->buf.buf,
+				       n->buf.len, OBJ_TREE, &s);
 		if (ret)
 			return ret;
 		strbuf_release(&n->buf);
@@ -847,7 +848,8 @@ int combine_notes_concatenate(struct object_id *cur_oid,
 	free(new_msg);
 
 	/* create a new blob object from buf */
-	ret = write_object_file(buf, buf_len, OBJ_BLOB, cur_oid);
+	ret = odb_write_object(the_repository->objects, buf,
+			       buf_len, OBJ_BLOB, cur_oid);
 	free(buf);
 	return ret;
 }
@@ -927,7 +929,8 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 				 string_list_join_lines_helper, &buf))
 		goto out;
 
-	ret = write_object_file(buf.buf, buf.len, OBJ_BLOB, cur_oid);
+	ret = odb_write_object(the_repository->objects, buf.buf,
+			       buf.len, OBJ_BLOB, cur_oid);
 
 out:
 	strbuf_release(&buf);
@@ -1215,7 +1218,8 @@ int write_notes_tree(struct notes_tree *t, struct object_id *result)
 	ret = for_each_note(t, flags, write_each_note, &cb_data) ||
 	      write_each_non_note_until(NULL, &cb_data) ||
 	      tree_write_stack_finish_subtree(&root) ||
-	      write_object_file(root.buf.buf, root.buf.len, OBJ_TREE, result);
+	      odb_write_object(the_repository->objects, root.buf.buf,
+			       root.buf.len, OBJ_TREE, result);
 	strbuf_release(&root.buf);
 	return ret;
 }
diff --git a/object-file.c b/object-file.c
index a9248760a26..84ece01337e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -755,7 +755,7 @@ static int start_loose_object_common(struct strbuf *tmp_file,
 
 	fd = create_tmpfile(tmp_file, filename);
 	if (fd < 0) {
-		if (flags & WRITE_OBJECT_FILE_SILENT)
+		if (flags & WRITE_OBJECT_SILENT)
 			return -1;
 		else if (errno == EACCES)
 			return error(_("insufficient permission for adding "
@@ -887,7 +887,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		utb.actime = mtime;
 		utb.modtime = mtime;
 		if (utime(tmp_file.buf, &utb) < 0 &&
-		    !(flags & WRITE_OBJECT_FILE_SILENT))
+		    !(flags & WRITE_OBJECT_SILENT))
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
@@ -1032,9 +1032,9 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 	return err;
 }
 
-int write_object_file_flags(const void *buf, unsigned long len,
-			    enum object_type type, struct object_id *oid,
-			    struct object_id *compat_oid_in, unsigned flags)
+int write_object_file(const void *buf, unsigned long len,
+		      enum object_type type, struct object_id *oid,
+		      struct object_id *compat_oid_in, unsigned flags)
 {
 	struct repository *repo = the_repository;
 	const struct git_hash_algo *algo = repo->hash_algo;
@@ -1159,7 +1159,7 @@ static int index_mem(struct index_state *istate,
 	}
 
 	if (write_object)
-		ret = write_object_file(buf, size, type, oid);
+		ret = odb_write_object(istate->repo->objects, buf, size, type, oid);
 	else
 		hash_object_file(istate->repo->hash_algo, buf, size, type, oid);
 
@@ -1184,8 +1184,8 @@ static int index_stream_convert_blob(struct index_state *istate,
 				 get_conv_flags(flags));
 
 	if (write_object)
-		ret = write_object_file(sbuf.buf, sbuf.len, OBJ_BLOB,
-					oid);
+		ret = odb_write_object(istate->repo->objects, sbuf.buf, sbuf.len, OBJ_BLOB,
+				       oid);
 	else
 		hash_object_file(istate->repo->hash_algo, sbuf.buf, sbuf.len, OBJ_BLOB,
 				 oid);
@@ -1287,7 +1287,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		if (!(flags & INDEX_WRITE_OBJECT))
 			hash_object_file(istate->repo->hash_algo, sb.buf, sb.len,
 					 OBJ_BLOB, oid);
-		else if (write_object_file(sb.buf, sb.len, OBJ_BLOB, oid))
+		else if (odb_write_object(the_repository->objects, sb.buf, sb.len, OBJ_BLOB, oid))
 			rc = error(_("%s: failed to insert into database"), path);
 		strbuf_release(&sb);
 		break;
diff --git a/object-file.h b/object-file.h
index 370139e0762..8ee24b7d8f3 100644
--- a/object-file.h
+++ b/object-file.h
@@ -157,29 +157,9 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
-enum {
-	/*
-	 * By default, `write_object_file()` does not actually write
-	 * anything into the object store, but only computes the object ID.
-	 * This flag changes that so that the object will be written as a loose
-	 * object and persisted.
-	 */
-	WRITE_OBJECT_FILE_PERSIST = (1 << 0),
-
-	/*
-	 * Do not print an error in case something gose wrong.
-	 */
-	WRITE_OBJECT_FILE_SILENT = (1 << 1),
-};
-
-int write_object_file_flags(const void *buf, unsigned long len,
-			    enum object_type type, struct object_id *oid,
-			    struct object_id *compat_oid_in, unsigned flags);
-static inline int write_object_file(const void *buf, unsigned long len,
-				    enum object_type type, struct object_id *oid)
-{
-	return write_object_file_flags(buf, len, type, oid, NULL, 0);
-}
+int write_object_file(const void *buf, unsigned long len,
+		      enum object_type type, struct object_id *oid,
+		      struct object_id *compat_oid_in, unsigned flags);
 
 struct input_stream {
 	const void *(*read)(struct input_stream *, unsigned long *len);
diff --git a/odb.c b/odb.c
index 1f48a0448e3..519df2fa497 100644
--- a/odb.c
+++ b/odb.c
@@ -980,6 +980,16 @@ void odb_assert_oid_type(struct object_database *odb,
 		    type_name(expect));
 }
 
+int odb_write_object_ext(struct object_database *odb UNUSED,
+			 const void *buf, unsigned long len,
+			 enum object_type type,
+			 struct object_id *oid,
+			 struct object_id *compat_oid,
+			 unsigned flags)
+{
+	return write_object_file(buf, len, type, oid, compat_oid, flags);
+}
+
 struct object_database *odb_new(struct repository *repo)
 {
 	struct object_database *o = xmalloc(sizeof(*o));
diff --git a/odb.h b/odb.h
index e922f256802..03422068888 100644
--- a/odb.h
+++ b/odb.h
@@ -437,6 +437,44 @@ enum for_each_object_flags {
 	FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
 };
 
+enum {
+	/*
+	 * By default, `odb_write_object()` does not actually write anything
+	 * into the object store, but only computes the object ID. This flag
+	 * changes that so that the object will be written as a loose object
+	 * and persisted.
+	 */
+	WRITE_OBJECT_PERSIST = (1 << 0),
+
+	/*
+	 * Do not print an error in case something goes wrong.
+	 */
+	WRITE_OBJECT_SILENT = (1 << 1),
+};
+
+/*
+ * Write an object into the object database. The object is being written into
+ * the local alternate of the repository. If provided, the converted object ID
+ * as well as the compatibility object ID are written to the respective
+ * pointers.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int odb_write_object_ext(struct object_database *odb,
+			 const void *buf, unsigned long len,
+			 enum object_type type,
+			 struct object_id *oid,
+			 struct object_id *compat_oid,
+			 unsigned flags);
+
+static inline int odb_write_object(struct object_database *odb,
+				   const void *buf, unsigned long len,
+				   enum object_type type,
+				   struct object_id *oid)
+{
+	return odb_write_object_ext(odb, buf, len, type, oid, NULL, 0);
+}
+
 /* Compatibility wrappers, to be removed once Git 2.51 has been released. */
 #include "repository.h"
 
diff --git a/read-cache.c b/read-cache.c
index 531d87e7905..be17ca7f586 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -690,7 +690,7 @@ static struct cache_entry *create_alias_ce(struct index_state *istate,
 void set_object_name_for_intent_to_add_entry(struct cache_entry *ce)
 {
 	struct object_id oid;
-	if (write_object_file("", 0, OBJ_BLOB, &oid))
+	if (odb_write_object(the_repository->objects, "", 0, OBJ_BLOB, &oid))
 		die(_("cannot create an empty blob in the object database"));
 	oidcpy(&ce->oid, &oid);
 }

-- 
2.50.1.465.gcb3da1c9e6.dirty


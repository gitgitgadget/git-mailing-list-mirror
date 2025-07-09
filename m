Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77C628FFCB
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059865; cv=none; b=GAQCuyShFyq0CPv1W9L283pw0vGB6e+ioSxeEmALCc5YwtvCsX13nm+2vjeSELJonYschziqBc1v8Kge1fu/HT3H2TCP6QLHq+cQzNOvpbzOzPqa4WvVme8YpEtFyShbtcJByb69VDR4x1141LkuMmxOcPB5L/0g6Pjter4J6hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059865; c=relaxed/simple;
	bh=9MOdq0T2PE/U4+wtTql//vWwRmrIHbaGwm8QpZEFCak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GimV/6M4/P3NbzqCR7av2X1DJvZrrVn4wjJf5RG4YbPMVJ2HO8TVb5hZFKA7k9t1KcVSa+lR0d5SxBgkdpy4/vFP8MiVMWh40lHxitqKYQKjV/rTG2yP2fDfHIFJOlUpZgweF3zBPTAnjdHHrIUjFE38yGEBWSgDn206yWwZsyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YmUc6iDv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFDAbczr; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YmUc6iDv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFDAbczr"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 28FCB1400330
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 09 Jul 2025 07:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059862;
	 x=1752146262; bh=MUnP7FnOAhGw1i63xTzgkVpB0cfO7EsdzKElZa8EEu0=; b=
	YmUc6iDv5zBvTkZJKjz3dAx9vG5ATxWXLoTW2uKJfYXsH3m0iHVmJiXeYS1Z1tSQ
	fmKO3q/v1SdpQY11k8fZ5Jpx79nksCxtuHJqAoc3XvWpup27Ph43BYSDdbKCYDet
	QPQcqin6wK++VQFSYbHiXpDFR+o4MjBJpD/G786Cw4p0h7525EsvN+fTZTw2/N20
	BuTFHS8jzNz504Ggk3rvHdjvQxSLt0OMEpt4FxiluTu5XfG7X2UbIcXIeGRwBqed
	EpIrdo4lexVIhcBv362uB8x4r8YO9ZrAaDvShT5/y/2ct0hSKmgPO15HIvlMT7Om
	u1J769aBivUYt2Zm9ymFoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059862; x=
	1752146262; bh=MUnP7FnOAhGw1i63xTzgkVpB0cfO7EsdzKElZa8EEu0=; b=P
	FDAbczrCXPvDFKQTmwagYxGX7ourTN8ZZzncNoYWZcvRidNlqA7aHVhSEUzhYzSA
	gMQKsQORSAkj3GxrttxqyliPGAo1Wr2t8I1/S5jjAU5SXvMlGj+w1z6eUqMSQ03S
	kYrVQy6XdzjY0O7rDaBU3ABTYiQRD00RrXdOmMmJYpkXanlvkMjH+A7sOeJ72aCP
	ljHsZsU4DAh/nCpJa9ma7n3h1p6f+k0RUpv2JAsCykl7ZTgcVDruQrU2kzc7Fv3Q
	mIKDFZ6zxq9JOT3LOX8aOUqG5uou2ozKeTHswGeTmwRu+KHAA92CuKy2aM6R9Mt8
	Xl2aMfQfgS4WYhHgjrwDg==
X-ME-Sender: <xms:1U9uaG7KcUCoWQUhUtcTvtV-MGsCg1GfWJ6o_Ky2pnqVBtb7nKdg6A>
    <xme:1U9uaB5w3Cl_RFU6LxC30cHdDWtJQN24p5m3QkKLBUa9t7_6ZtCstt5f9i5fQHS1N
    HL6AfHEoSPRAw7hhw>
X-ME-Received: <xmr:1U9uaO0xtKczKaZGm72fzOxOdwSCB7sWAP5tvEPfc5GwiPBp8GJscZYX4VmBjlkjTtW31r5xf4fsNgs9I42aYxvIaV_Nlzc5E2lB5_gfqAQcfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:1k9uaFUlNXqOtMgNO4wrfbxcRW0mfE5DG0_0R3BXXtuNA6AO7SnSDA>
    <xmx:1k9uaB4wMqrGgwyEAjfazVYWyTEwLk-nHFsuTTY2zH5Pu5bmNqpGQQ>
    <xmx:1k9uaEJ6QP0VKn_vzS_la2L9LK_p_TrEzKvvoh1RWdja7Yb7UVePlw>
    <xmx:1k9uaKL5tovHp7SPWtwudmdAg8jotp4Cmg5ppJLKlp95QAV4ErDMYA>
    <xmx:1k9uaIRJeA5dLgvOhWBCsgVpFoqkb9ubzEJvbZGrCpkL0OHLCYNGLMtZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea656956 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:17 +0200
Subject: [PATCH 07/19] object-file: get rid of `the_repository` in
 `finalize_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-7-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We implicitly depend on `the_repository` when moving an object file into
place in `finalize_object_file()`. Get rid of this global dependency by
passing in a repository.

Note that one might be pressed to inject an object database instead of a
repository. But the function doesn't really care about the ODB at all.
All it does is to move a file into place while checking whether there is
any collision. As such, the functionality it provides is independent of
the object database and only needs the repository as parameter so that
it can adjust permissions of the file we are about to finalize.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c  |  4 ++--
 builtin/index-pack.c   |  2 +-
 builtin/pack-objects.c |  2 +-
 bulk-checkin.c         |  2 +-
 http.c                 |  4 ++--
 midx-write.c           |  2 +-
 object-file.c          | 14 ++++++++------
 object-file.h          |  6 ++++--
 pack-write.c           | 16 +++++++++-------
 pack.h                 |  3 ++-
 tmp-objdir.c           |  2 +-
 11 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b1389c59211..89f57898b15 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -821,11 +821,11 @@ static char *keep_pack(const char *curr_index_name)
 		die_errno("failed to write keep file");
 
 	odb_pack_name(pack_data->repo, &name, pack_data->hash, "pack");
-	if (finalize_object_file(pack_data->pack_name, name.buf))
+	if (finalize_object_file(pack_data->repo, pack_data->pack_name, name.buf))
 		die("cannot store pack file");
 
 	odb_pack_name(pack_data->repo, &name, pack_data->hash, "idx");
-	if (finalize_object_file(curr_index_name, name.buf))
+	if (finalize_object_file(pack_data->repo, curr_index_name, name.buf))
 		die("cannot store index file");
 	free((void *)curr_index_name);
 	return strbuf_detach(&name, NULL);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 19c67a85344..dabeb825a6c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1598,7 +1598,7 @@ static void rename_tmp_packfile(const char **final_name,
 	if (!*final_name || strcmp(*final_name, curr_name)) {
 		if (!*final_name)
 			*final_name = odb_pack_name(the_repository, name, hash, ext);
-		if (finalize_object_file(curr_name, *final_name))
+		if (finalize_object_file(the_repository, curr_name, *final_name))
 			die(_("unable to rename temporary '*.%s' file to '%s'"),
 			    ext, *final_name);
 	} else if (make_read_only_if_same) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a44f0ce1c78..e8e85d8278b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1449,7 +1449,7 @@ static void write_pack_file(void)
 				strbuf_setlen(&tmpname, tmpname_len);
 			}
 
-			rename_tmp_packfile_idx(&tmpname, &idx_tmp_name);
+			rename_tmp_packfile_idx(the_repository, &tmpname, &idx_tmp_name);
 
 			free(idx_tmp_name);
 			strbuf_release(&tmpname);
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 16df86c0ba8..b2809ab0398 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -46,7 +46,7 @@ static void finish_tmp_packfile(struct strbuf *basename,
 	stage_tmp_packfiles(the_repository, basename, pack_tmp_name,
 			    written_list, nr_written, NULL, pack_idx_opts, hash,
 			    &idx_tmp_name);
-	rename_tmp_packfile_idx(basename, &idx_tmp_name);
+	rename_tmp_packfile_idx(the_repository, basename, &idx_tmp_name);
 
 	free(idx_tmp_name);
 }
diff --git a/http.c b/http.c
index 9b62f627dc5..7cc797116bb 100644
--- a/http.c
+++ b/http.c
@@ -2331,7 +2331,7 @@ int http_get_file(const char *url, const char *filename,
 	ret = http_request_reauth(url, result, HTTP_REQUEST_FILE, options);
 	fclose(result);
 
-	if (ret == HTTP_OK && finalize_object_file(tmpfile.buf, filename))
+	if (ret == HTTP_OK && finalize_object_file(the_repository, tmpfile.buf, filename))
 		ret = HTTP_ERROR;
 cleanup:
 	strbuf_release(&tmpfile);
@@ -2815,7 +2815,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		return -1;
 	}
 	odb_loose_path(the_repository->objects->sources, &filename, &freq->oid);
-	freq->rename = finalize_object_file(freq->tmpfile.buf, filename.buf);
+	freq->rename = finalize_object_file(the_repository, freq->tmpfile.buf, filename.buf);
 	strbuf_release(&filename);
 
 	return freq->rename;
diff --git a/midx-write.c b/midx-write.c
index f2cfb85476e..effacade2d3 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -667,7 +667,7 @@ static void write_midx_reverse_index(struct write_midx_context *ctx,
 	tmp_file = write_rev_file_order(ctx->repo, NULL, ctx->pack_order,
 					ctx->entries_nr, midx_hash, WRITE_REV);
 
-	if (finalize_object_file(tmp_file, buf.buf))
+	if (finalize_object_file(ctx->repo, tmp_file, buf.buf))
 		die(_("cannot store reverse index file"));
 
 	strbuf_release(&buf);
diff --git a/object-file.c b/object-file.c
index 800eeae85af..6a7049a9e98 100644
--- a/object-file.c
+++ b/object-file.c
@@ -584,12 +584,14 @@ static int check_collision(const char *source, const char *dest)
 /*
  * Move the just written object into its final resting place.
  */
-int finalize_object_file(const char *tmpfile, const char *filename)
+int finalize_object_file(struct repository *repo,
+			 const char *tmpfile, const char *filename)
 {
-	return finalize_object_file_flags(tmpfile, filename, 0);
+	return finalize_object_file_flags(repo, tmpfile, filename, 0);
 }
 
-int finalize_object_file_flags(const char *tmpfile, const char *filename,
+int finalize_object_file_flags(struct repository *repo,
+			       const char *tmpfile, const char *filename,
 			       enum finalize_object_file_flags flags)
 {
 	unsigned retries = 0;
@@ -649,7 +651,7 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
 	}
 
 out:
-	if (adjust_shared_perm(the_repository, filename))
+	if (adjust_shared_perm(repo, filename))
 		return error(_("unable to set permission to '%s'"), filename);
 	return 0;
 }
@@ -889,7 +891,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
-	return finalize_object_file_flags(tmp_file.buf, filename.buf,
+	return finalize_object_file_flags(the_repository, tmp_file.buf, filename.buf,
 					  FOF_SKIP_COLLISION_CHECK);
 }
 
@@ -1020,7 +1022,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		strbuf_release(&dir);
 	}
 
-	err = finalize_object_file_flags(tmp_file.buf, filename.buf,
+	err = finalize_object_file_flags(the_repository, tmp_file.buf, filename.buf,
 					 FOF_SKIP_COLLISION_CHECK);
 	if (!err && compat)
 		err = repo_add_loose_object_map(the_repository, oid, &compat_oid);
diff --git a/object-file.h b/object-file.h
index 5b63a05ab51..370139e0762 100644
--- a/object-file.h
+++ b/object-file.h
@@ -218,8 +218,10 @@ enum finalize_object_file_flags {
 	FOF_SKIP_COLLISION_CHECK = 1,
 };
 
-int finalize_object_file(const char *tmpfile, const char *filename);
-int finalize_object_file_flags(const char *tmpfile, const char *filename,
+int finalize_object_file(struct repository *repo,
+			 const char *tmpfile, const char *filename);
+int finalize_object_file_flags(struct repository *repo,
+			       const char *tmpfile, const char *filename,
 			       enum finalize_object_file_flags flags);
 
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
diff --git a/pack-write.c b/pack-write.c
index eccdc798e36..83eaf88541e 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -538,22 +538,24 @@ struct hashfile *create_tmp_packfile(struct repository *repo,
 	return hashfd(repo->hash_algo, fd, *pack_tmp_name);
 }
 
-static void rename_tmp_packfile(struct strbuf *name_prefix, const char *source,
+static void rename_tmp_packfile(struct repository *repo,
+				struct strbuf *name_prefix, const char *source,
 				const char *ext)
 {
 	size_t name_prefix_len = name_prefix->len;
 
 	strbuf_addstr(name_prefix, ext);
-	if (finalize_object_file(source, name_prefix->buf))
+	if (finalize_object_file(repo, source, name_prefix->buf))
 		die("unable to rename temporary file to '%s'",
 		    name_prefix->buf);
 	strbuf_setlen(name_prefix, name_prefix_len);
 }
 
-void rename_tmp_packfile_idx(struct strbuf *name_buffer,
+void rename_tmp_packfile_idx(struct repository *repo,
+			     struct strbuf *name_buffer,
 			     char **idx_tmp_name)
 {
-	rename_tmp_packfile(name_buffer, *idx_tmp_name, "idx");
+	rename_tmp_packfile(repo, name_buffer, *idx_tmp_name, "idx");
 }
 
 void stage_tmp_packfiles(struct repository *repo,
@@ -586,11 +588,11 @@ void stage_tmp_packfiles(struct repository *repo,
 						    hash);
 	}
 
-	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
+	rename_tmp_packfile(repo, name_buffer, pack_tmp_name, "pack");
 	if (rev_tmp_name)
-		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
+		rename_tmp_packfile(repo, name_buffer, rev_tmp_name, "rev");
 	if (mtimes_tmp_name)
-		rename_tmp_packfile(name_buffer, mtimes_tmp_name, "mtimes");
+		rename_tmp_packfile(repo, name_buffer, mtimes_tmp_name, "mtimes");
 
 	free(rev_tmp_name);
 	free(mtimes_tmp_name);
diff --git a/pack.h b/pack.h
index 5d4393eaffe..ec76472e49b 100644
--- a/pack.h
+++ b/pack.h
@@ -145,7 +145,8 @@ void stage_tmp_packfiles(struct repository *repo,
 			 struct pack_idx_option *pack_idx_opts,
 			 unsigned char hash[],
 			 char **idx_tmp_name);
-void rename_tmp_packfile_idx(struct strbuf *basename,
+void rename_tmp_packfile_idx(struct repository *repo,
+			     struct strbuf *basename,
 			     char **idx_tmp_name);
 
 #endif
diff --git a/tmp-objdir.c b/tmp-objdir.c
index ae01eae9c41..9f5a1788cd7 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -227,7 +227,7 @@ static int migrate_one(struct tmp_objdir *t,
 			return -1;
 		return migrate_paths(t, src, dst, flags);
 	}
-	return finalize_object_file_flags(src->buf, dst->buf, flags);
+	return finalize_object_file_flags(t->repo, src->buf, dst->buf, flags);
 }
 
 static int is_loose_object_shard(const char *name)

-- 
2.50.1.327.g047016eb4a.dirty


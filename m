Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A1231194B
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591607; cv=none; b=qBAKM/fUUwl/Ty6f/H1EyjxdQ4f6+2qx6xT0Jzf5gYZOTvoqYt2EAEtYXj4ABOJMrkGi0PlgVdYuVVEyxy7tKdzxS27fUDrqpGHjMVw1r2KVjt1r0zMbIv0wLQ/3KQDEWPSXpuEc8pM1EsAhF22OV12c2Tnhs8d6OfOtl639YsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591607; c=relaxed/simple;
	bh=haf3ZjY9EZKzLeTKTfLMo/ZjeQBV8qGYh6bGtj/+ZVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxJMpd4lvZmNbgYSSxZby0jwCdd6e2/Ia4a70LnD9lEyz68ZqmriCKTJq0iwxjYcnv+f8gnMsWPnEbR8MtyGEYh8mfP3oSO0GdTxkImcMGfZASlMSozE7DCVdFWZb7crgOJ6aBjAh6sWP8OOfskxNvyGxcsPpsjwaI4r83ZHUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RTLp0vpC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=biIHGoxn; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RTLp0vpC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="biIHGoxn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 78DCE1D0025F
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 19 Aug 2025 04:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591605;
	 x=1755678005; bh=gJt21j5khvpg4PHNLQcvOV3iyGMIRpFdhLy+wubGyWs=; b=
	RTLp0vpCdS6JPg9/TCbqEuPg3Mqo472Ap3WGug/awHG8a+U0VySvBNuHj4jbNq+A
	W2amAKa3BcI+YB21a26Ybb73i8CKFiReA2FcEvoMqngV4l6tRegF0Hp6dUU8Th7S
	AD3d6mxqi5GJbMUUGJYGStrRVSzNpRaX30fD6bYrltQpaERtpShf1XDtmPyjkTtu
	6LYMZtZSHBm1fD0CRTjcc9ORrSqvIW7M64BRshBgPSsmh3zAVnk8HWR9ITnCc9y9
	laeRdgZ/3+xr4RAbVjiKGdfvtBylSzMwwZEGtdRRNuidi/h06YmO5R+Nn44oD/+B
	ymTE5lbgx/pU6Gb0RZEQPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591605; x=
	1755678005; bh=gJt21j5khvpg4PHNLQcvOV3iyGMIRpFdhLy+wubGyWs=; b=b
	iIHGoxni68qzx0/QoTZNxsgIxGcCUMrxC5zcvROjgLSjas6LYkQexc8nUXcTVO8U
	d5UJxjnN2kj8hp9qF9boEy4PgQcHhTD6XI0p1k/vbTzOYYn3QUWRbWUqvDHPVttS
	L3Xot8QMounaVa0YRrF3S+HHrOT+zc6ydGr16skUCSFbW3f/At0bPAy7N59wEyt8
	H0aR/SPbp9JtpLlKfuhxqol/ZbPe78OsNBFHlgZA1gVS9mNfkg2YaTzh6JSP7W74
	684yIhBwNBrAueM+YsBk2YqAKQVHqPkFNtdxZi1bBMYJArLNRmMMOLarG0Ls05Qb
	+A1lcCuBmYeAKWxnmZcfQ==
X-ME-Sender: <xms:tTOkaFmlpl9hGdsw_XKITJXoSUK3CEI-bPHC9LKC0B7xxtRUTXkgZw>
    <xme:tTOkaC3IsIqb7oix_ILWxpeR5GfnbZ9tu1vLut2tNU_lFS49wO1FIJO7CdYseRvTM
    J0kC0S-sGEA6dZNJw>
X-ME-Received: <xmr:tTOkaFAqD9lpzZIPfGEFl9-Jq2d0g8IJzvwVS0BL9by8Dazoiju164sk-tUaIdg12uglZD0X-ezvZzHW5Y34oDoN6-IqRhmXgrRjHXi2iXAW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:tTOkaHzZXQ5TEC3O2b_SRCSnC-RzbNbkidFnCGtBXJoy0lRIHpZ6GQ>
    <xmx:tTOkaLnuVTdnuSslRGY8b1_VjS-fYZybC1FROrGAggaXyixBco4HIg>
    <xmx:tTOkaEHkm1MZx9S5AO2Psyqp1_gwCGVaNL9GxnXqvacQyGPZziodTg>
    <xmx:tTOkaDU18kqNarlzt4ZJmAydWHZxR1F8cUam4wNSx-IwBNIjL2M2EQ>
    <xmx:tTOkaGtV4j8Dr_jmnNj3xodUPl-sZTKycMUm2ZxC7VZF8d1zmeznVaHa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 828e39b5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:20:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:39 +0200
Subject: [PATCH 10/16] packfile: refactor `install_packed_git()` to work on
 packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-10-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `install_packed_git()` functions adds a packfile to a specific
object store. Refactor it to accept a packfile store instead of a
repository to clarify its scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c |  2 +-
 builtin/index-pack.c  |  2 +-
 http.c                |  2 +-
 http.h                |  2 +-
 midx.c                |  2 +-
 packfile.c            | 11 ++++++-----
 packfile.h            |  9 +++++++--
 7 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 2c35f9345d..e9d82b31c3 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -901,7 +901,7 @@ static void end_packfile(void)
 		if (!new_p)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] = new_p;
-		install_packed_git(the_repository, new_p);
+		packfile_store_add_pack(the_repository->objects->packfiles, new_p);
 		free(idx_name);
 
 		/* Print the boundary */
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f91c301bba..ed490dfad4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1645,7 +1645,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		p = add_packed_git(the_repository, final_index_name,
 				   strlen(final_index_name), 0);
 		if (p)
-			install_packed_git(the_repository, p);
+			packfile_store_add_pack(the_repository->objects->packfiles, p);
 	}
 
 	if (!from_stdin) {
diff --git a/http.c b/http.c
index 98853d6483..af2120b64c 100644
--- a/http.c
+++ b/http.c
@@ -2541,7 +2541,7 @@ void http_install_packfile(struct packed_git *p,
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	install_packed_git(the_repository, p);
+	packfile_store_add_pack(the_repository->objects->packfiles, p);
 }
 
 struct http_pack_request *new_http_pack_request(
diff --git a/http.h b/http.h
index 36202139f4..e5a5380c6c 100644
--- a/http.h
+++ b/http.h
@@ -210,7 +210,7 @@ int finish_http_pack_request(struct http_pack_request *preq);
 void release_http_pack_request(struct http_pack_request *preq);
 
 /*
- * Remove p from the given list, and invoke install_packed_git() on it.
+ * Remove p from the given list, and invoke packfile_store_add_pack() on it.
  *
  * This is a convenience function for users that have obtained a list of packs
  * from http_get_info_packs() and have chosen a specific pack to fetch.
diff --git a/midx.c b/midx.c
index 7fa2b8473a..95e74c79c1 100644
--- a/midx.c
+++ b/midx.c
@@ -477,7 +477,7 @@ int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
 	if (!p) {
 		p = add_packed_git(r, pack_name.buf, pack_name.len, m->local);
 		if (p) {
-			install_packed_git(r, p);
+			packfile_store_add_pack(r->objects->packfiles, p);
 			list_add_tail(&p->mru, &r->objects->packfiles->mru);
 		}
 	}
diff --git a/packfile.c b/packfile.c
index 180c95ec1c..186d182c7c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -779,16 +779,17 @@ struct packed_git *add_packed_git(struct repository *r, const char *path,
 	return p;
 }
 
-void install_packed_git(struct repository *r, struct packed_git *pack)
+void packfile_store_add_pack(struct packfile_store *store,
+			     struct packed_git *pack)
 {
 	if (pack->pack_fd != -1)
 		pack_open_fds++;
 
-	pack->next = r->objects->packfiles->packs;
-	r->objects->packfiles->packs = pack;
+	pack->next = store->packs;
+	store->packs = pack;
 
 	hashmap_entry_init(&pack->packmap_ent, strhash(pack->pack_name));
-	hashmap_add(&r->objects->packfiles->map, &pack->packmap_ent);
+	hashmap_add(&store->map, &pack->packmap_ent);
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
@@ -904,7 +905,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 		if (!hashmap_get(&data->r->objects->packfiles->map, &hent, pack_name)) {
 			p = add_packed_git(data->r, full_name, full_name_len, data->local);
 			if (p)
-				install_packed_git(data->r, p);
+				packfile_store_add_pack(data->r->objects->packfiles, p);
 		}
 		free(pack_name);
 	}
diff --git a/packfile.h b/packfile.h
index 75672c808a..e751a5d93e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -112,6 +112,13 @@ void packfile_store_close(struct packfile_store *store);
  */
 void packfile_store_reprepare(struct packfile_store *store);
 
+/*
+ * Add the pack to the store so that contained objects become accessible via
+ * the store. This moves ownership into the store.
+ */
+void packfile_store_add_pack(struct packfile_store *store,
+			     struct packed_git *pack);
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
@@ -188,8 +195,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-void install_packed_git(struct repository *r, struct packed_git *pack);
-
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source);

-- 
2.51.0.261.g7ce5a0a67e.dirty


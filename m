Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4282E2F49FE
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926502; cv=none; b=qPex3Mbo4AnpNZ9R5fUf00KzgvOHj9HzE4Oz7FN4KXtmq7bhnU1GY9Bn2wKtdz69Nsp9rIoG1774pJCGFf8ge27j1wa5ieGMcSd+ytNFLCR8wt6+OYpTMLL51uBHgPU9n9G7sbso9UZGQS8ND7VAUhOUulrpRz2j9Ya1+VPnfb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926502; c=relaxed/simple;
	bh=b5zN+It4nvaMq8IwiUlyZoNd+2jxhcijZqMqKGbLhBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wjir4sNFxKgaa+gAVpJyYV27Jq5yVkXNg8MDUtalXcrUjR3Bs+Y/vFdFCHsHd93sqOTaigaxHAeqT57CLuw3zMx/5bqO9Ly6yIrSMRduLf+3OLi11u6RuveFavLFNg9/Cc56jZaDBnYeSWy34Wx5R2hxDpRz+AJClUjY2ry821A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s85xjHtX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XdwNcl5A; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s85xjHtX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XdwNcl5A"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C31A140007E;
	Mon, 15 Sep 2025 04:55:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 04:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926500;
	 x=1758012900; bh=XHW2rZlvQ4K7KfcGZmeTnCZmrL5QA9xIj6CFbMI7QRA=; b=
	s85xjHtXLZOrrG7X9SZq/RAgG4iw/RkV5oxs/nMDW7V0QqhyyixtFT0938YwLshF
	YO2hdqn6mW9Zzj9QqgCfY/RrvEK2xLMASLD8JPULedONdl+R4ncZTekEG62kAeAy
	2lme7ssWQBK0/7AbbeZpMNvOdm3x1hzASkT1RNexETQ6cFUQ5B1IVB7spZI2ckyi
	+w1ouMik0OiEheh6RVCZipwmdl0MVLf8bchKnlyx/v0D7njfFrZjDDHZj5fPwrar
	iOx76n+ytwYloY5oxEBHc7E1thmaSlQftViTDW4OmfIjpgtwuaKIsIzk6vJ5OOQo
	cn2aD31g8uGhOyujsksAKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926500; x=
	1758012900; bh=XHW2rZlvQ4K7KfcGZmeTnCZmrL5QA9xIj6CFbMI7QRA=; b=X
	dwNcl5AhUsrXl24gTl3rorZBPd6RlS8kNpC7acZxTD0YIn+niqwDzDJGqt4jOl2c
	mlGlg+9VmYxofoUJ3lEkg1HsrzFLbvxekryJcVNAAymTbIxdlw3R1ShNQ8aUeO4w
	vrM44iVGkCyMFlnDhq+EM8x4zbzIrmpqiWy+Ff/eLKlHt44Qbw7t11jIh1CpR3I9
	7rfJNIE0e2o7z3Deq+CQ/UsjdwwJMZRvmONI/RodFZs6vBQLajPmiZ1ry54AAkFi
	S0Gv+v0q1+bDhkgkjRfYbwwmhdauTi1FBZiPocduiCgPUCWOTvL3d8y0FOXOhim3
	dIT/9iGOST9szy9EmwrTQ==
X-ME-Sender: <xms:ZNTHaHR3mMP1KQmnDP5yItMo__9q3tjZLHQtkMh_0rgBe0ZVSuG6wQ>
    <xme:ZNTHaESnP50_3yk408r2eHpEi8qhtsObk6WTf7Wcc_6LCPiOEm3Z9INF0TjW33f59
    rFRO6QviiefnZz3DA>
X-ME-Received: <xmr:ZNTHaDR6stSx53AB-kgTBG8dP9Ec4s70xvLC9EK709fsdyIRdU_hns2ZS57Jw0dIUv4nd9Hq4CXyXRIDy_X8e3Lfq3XD5bcYps5NcGig8dblnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:ZNTHaB59zt6tvjIqlgA5KrYbTPJOg9bBaC9lZE3IihtfTUSooapnMQ>
    <xmx:ZNTHaH2T-MHZEmxniTZFdE4uH6GFsCNryIYapjZY58JFgFnEGcHgnA>
    <xmx:ZNTHaEBizp5SfBABGV-RUok51Am9rcb1qZhVSxyfdtmLVcn9jzL1_A>
    <xmx:ZNTHaKOWlhT-QAQkupokuPE7zr5kRzOVpdjCJBB60C8iCjqeGNGp0g>
    <xmx:ZNTHaKOmipA_niEKiHgOc5fkYFQNhy0RZOSKWr-hVjAq47mDzn1dlRHj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:54:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea7e72f5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:54:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:28 +0200
Subject: [PATCH v5 10/15] packfile: refactor `install_packed_git()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-10-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
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
index 91c7b3917d..69c44be71c 100644
--- a/midx.c
+++ b/midx.c
@@ -467,7 +467,7 @@ int prepare_midx_pack(struct multi_pack_index *m,
 		p = add_packed_git(r, pack_name.buf, pack_name.len,
 				   m->source->local);
 		if (p) {
-			install_packed_git(r, p);
+			packfile_store_add_pack(r->objects->packfiles, p);
 			list_add_tail(&p->mru, &r->objects->packfiles->mru);
 		}
 	}
diff --git a/packfile.c b/packfile.c
index 950b98aac5..af806aba09 100644
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
index a85ff607fe..ba4b0cef9c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -120,6 +120,13 @@ void packfile_store_close(struct packfile_store *store);
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
@@ -196,8 +203,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-void install_packed_git(struct repository *r, struct packed_git *pack);
-
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source);

-- 
2.51.0.450.g87641ccf93.dirty


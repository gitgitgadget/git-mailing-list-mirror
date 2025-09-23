Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4B321296
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622663; cv=none; b=pFV6YDJHAqH9GzCo8UtqWVyOtoHFJUjd4Woh6vTzBY6Gx1wPh8VsN43T89qOnhHtWbuIE47lqF+N/NrOhGlRc6M3X6LQWj05L82m2faoZl2pAr8OXlYVL0BkpT49EZcINbROf8WBfNiaOAtvgdV6M6HLhr7S6Z2HvwNCksolYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622663; c=relaxed/simple;
	bh=FDPG+SpTgnMUmunAtbZuhH4QNO1xwDoeYGlSb3dwNHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rY9tCMEQkbcewjYAOeCzn9rJVfP/zUqdk+9s33EYOU9mTK9UgaKYFwafKRtuOElOs+TKi+Z6DR9lMTrK54A2l5dQrTAk6MLCWPGx8QQfV31pGK1/Zduv4iRKU1KuOs+0rSXBUbg9tc152h0to7i4q45J2By+foRXhM4mnv7EfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M+4/5k3c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TbcbOu2Z; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M+4/5k3c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TbcbOu2Z"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9822F7A01DD;
	Tue, 23 Sep 2025 06:17:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 23 Sep 2025 06:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622660;
	 x=1758709060; bh=juJsGS5k9N5k3dt/yTOjlS+8Gm/yz7k4Ss3CbYJ/u4o=; b=
	M+4/5k3cwjC79OeCaCXKVPyHpLcwuTvfVHH9yZKmzbgBWSqv9XrdJpkNLIH50Ays
	LmI91K+ZLVf0TBVh/Nl0RgaRm52oxvbXlUJpzc+E+duUcSr4E83LIN4hi9dS4/59
	+BzV7RfBTGqUtAL4N+CbZgGWMyu+Pf0HjyFTj2KXTrBDBoUrqht9rLk9WZBwU0pL
	0zCUQ9vhlWl53z/uvD4DsmKBg1GtFu4KVVWoSM+bIYBgsnJew95vv/3Fv3Odu+Ak
	o4tl6qDWUeoXuGZrashvwBW3GPXOx/3PBvrkV4r0dns/uvuqQAp2gSXy2vajYvqP
	vWKu4xZzRR2Q/i6x6ePuZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622660; x=
	1758709060; bh=juJsGS5k9N5k3dt/yTOjlS+8Gm/yz7k4Ss3CbYJ/u4o=; b=T
	bcbOu2ZBj6aqa4rW6R/09mgPhNwiNbiD9iBe4KEX4EfGf9p6eCTt4JkctbKgwakb
	34aNWDUwPGcl7/klec5FOlH3TTC+iHiIpLWxdcnQHEzo/vANVjcVGQNXo16PsYJz
	GT7oqGPh9ZdZdZS8LWFZf1SGeCDtzQqkupfST/+okUnd0Q1Itn1PyBsaXMM9nAcH
	jLmPfB/IwKFY8wvGmU95L5OsbVuQzTkdG0cUcxVXGTv9qFnSLrjFeNiO339O3aA/
	scXU8z0cpc7e0DGwanvXG5Fs6fBfK/Ge8Xdin190qmmKQDJ4BqdtTeQf25vH2yJm
	4jgHqO1veTnBq/B/PlJLQ==
X-ME-Sender: <xms:xHPSaGMqn490MAo-fWYtY2Rqavw78GxbWZMMHlH6Kfx8hnuYnuOIJg>
    <xme:xHPSaIo_jwtX4gGoVQohGi2DX2KyxCXVZAkVPYHzzQHFDTBt_paydTIHaW03uKoMj
    LFrz7BfS0Mc9OQJ6qXmw3twP1hDqYST3qhVyFljve0Q2uLiWVtm>
X-ME-Received: <xmr:xHPSaHFkDycnLYmspjwh63kFPThW5PiDH3JHHRSZdbZQVN_IrIf0oGQ7CIrt7lDMTz3ei_F6pcy_7ougtfdA1X4gyQu3kB3Kb7ormhMNK6NU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:xHPSaNq55O_J6yUP4DXZJ6FQvKirlmRdQVGcMC_LTMuke9G1xe8Lgg>
    <xmx:xHPSaAbNympls4-PV8JP830kX-qmurEQOVW0GxK-jmaDUnga7wf6yg>
    <xmx:xHPSaGXORHGsV1Y9vYo0-KiDf3ZNFSc_R1A3OgDTdA17MOBGGoN48w>
    <xmx:xHPSaJ8V3_RdySm7fpqeFKwMwVoiJoIMxQBci0sGsVwj6BRvAYzUww>
    <xmx:xHPSaOqCqPQ6l3OYFYTiS4XDjfYZ_SdutCmHvJ04TH5FzWzcriDJ-XFI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c0f0f2a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 12:17:09 +0200
Subject: [PATCH v6 10/15] packfile: refactor `install_packed_git()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-packfiles-store-v6-10-b48f2a882759@pks.im>
References: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
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
2.51.0.536.g15c5d4f767.dirty


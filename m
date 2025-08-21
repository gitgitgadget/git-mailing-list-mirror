Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04152E9EA3
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761981; cv=none; b=mu5PQOTZRJGs2Uz88vaHPw1lon9o2MNqvLEno+zxYck+UNjOF2nxzG6PryCbUofmOMWNAegWhFEiqOSQMNWlmfhr4oyEDIweiFbSuYp6AnZhvGITqoscKglib/ulZmFZ/+kDwX6Q3h+kcrfUbEDwYPo3ozBSH4HzeMOWZPr8BNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761981; c=relaxed/simple;
	bh=+M+FXRyY82wLcRxGVrmPPJScftti4dWPKCPB4dduTZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WkQLDH1ojw0hYTke6C9WTOkPLxcmQz8WgX6VxuOtRtNhmAT4G98ZpqcZm8u1CRScQcRLT/0GxGgB5alxEwEIHaT+HfyfzsLYIR4WuL1YKit6vJ0U6BiRD17dQHkh+LDJDb5lKYAphPf9ZgehwHhfbKgJhmxvrMCYcrQGM1PSF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FEEDxZ80; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P/+te6n2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FEEDxZ80";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P/+te6n2"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 12561EC009D;
	Thu, 21 Aug 2025 03:39:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 21 Aug 2025 03:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761979;
	 x=1755848379; bh=wclsu8AiRudEBD3V5f0lAWFNnBfaL8UeVKPxAyTrg2Y=; b=
	FEEDxZ80HnGyf3ie5lIOS1vHg8nmhtrPArLw7O4is23DoGPcmw4drD4P2K8pUfJY
	RVrwbdUFUXQfoLE+rPyqhLiEdivubffNTsURin0+nHHxkhimobfOktRIkIDDhFbQ
	8V9bRM4un8sD/tEjYabHD9nCRHf7Sa5WoAMlVxqpoBR6O6gqDVWH1/qFlaJUh4pa
	VZwzKeuXmDRzKujVMVZrdFeQu1x65AJilfPPYd7pYHzXu9dc7OaiU2xDDUHoVOqT
	z6B0jNptxQa0BbV71WEOhbex4ipJrrfezBqakhDezhNje3hU9jlTp0sII+8LYYea
	9oC3xsUdy+81G4tFhRB0fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761979; x=
	1755848379; bh=wclsu8AiRudEBD3V5f0lAWFNnBfaL8UeVKPxAyTrg2Y=; b=P
	/+te6n2yIsYzP1vjhN5Cr2bYvHdM5pjiO8yDt4YJYcwvT1wSK9njZpP9KJO6xH1z
	DHcWsf50RIEZHLZL0NmFI9ThOnoodoUubfV2AjMAVlFJl6wQTzCRV3qiH+4SDL0A
	VWLvuw/ReJlWV7SY218Cn2D2G9fazaMvFmaiY3Eeie3Jdl2d9QKsBRv655GSdrlt
	aO7S0qYwjn0hzFf0v+pPRv7BHaX0kw6LU2Fr0V9Yxup257lc4eBnVKVh6FT0HXyA
	R3PIchLPa9c//uOHb/rULmxUaoZj+1I24Nf0Kb7q6n/oN3KSnV9vEqstPa6R7XsN
	IZYUIoH7L59ItaXCekt/Q==
X-ME-Sender: <xms:Os2maLj9t-i783i5DVBmP3Sr0HHzmZiuCPKkdPnnS_NnmhimiCnIhA>
    <xme:Os2maLRfaA4MAD6WB4NhjXc_FlhVTw4GBr8iTbXgQ-TygfHF5DEDC-0Yhg5h1IAhj
    QwDoQamjicYX3RCiA>
X-ME-Received: <xmr:Os2maEj7JiOCZR36vh7bMJiEAJCT-8Gcc_exF9VfZNNTwv9yCyjKSgsKwuVGxIaxX0rYVUsMZvE1fmiCYofFIvYroT6-sbS_nocTzAsalA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:Os2maD4pHX70YVFEUmoM3mAEWqddRKEQKN58UGHfxi9fiCn8Ma3Khw>
    <xmx:Os2maJDEMbk6CAo09CiMeltSyQgBKc0waORnn1Cxi4YqdM2K2KDk0Q>
    <xmx:Os2maCYbXRMoG14hH1o1Kx8PAc3JmU1M3tapK1d4LIJYr6TFAm7LIA>
    <xmx:Os2maMZzP0NM6R6HXFcEgsU-EJmZuTzYHG4TgB78p8iObGSGjjxhvw>
    <xmx:O82maG43ASp_B1_hlDqeeCjvykqvLgumrvUocjQhEM-LlVQF_MmqVcv1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af544a48 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:08 +0200
Subject: [PATCH v2 10/16] packfile: refactor `install_packed_git()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-10-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
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
index 8e446dda69..c885046d9f 100644
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
index e9e60ec21b..6641238796 100644
--- a/packfile.h
+++ b/packfile.h
@@ -111,6 +111,13 @@ void packfile_store_close(struct packfile_store *store);
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
@@ -187,8 +194,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-void install_packed_git(struct repository *r, struct packed_git *pack);
-
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
 struct multi_pack_index *get_multi_pack_index(struct odb_source *source);

-- 
2.51.0.261.g7ce5a0a67e.dirty


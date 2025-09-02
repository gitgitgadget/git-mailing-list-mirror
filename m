Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D772F547D
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810156; cv=none; b=cuHYitllZLEsytKqg+1phSZRhCuK73edM0Ei71NnCW01iJPXT1Hns294ul1YiXJv3HIF04lIsU9fqMqpdSDDDKHopoyfGrAdXq7RvA23lXLu3O0Ik6X+dSJPPIs68HBu7IaJcveSiKlNQXEMxaVf+MjyCa87ogptRbQvWvmRJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810156; c=relaxed/simple;
	bh=yrcAIYWmslV0IvIfnfta33CMrwhXgpJvdWrCt5g6/zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pm8H+Yp5qW/EIiPns+HQYgG86WC3L31pQ5UuE0YRbh3DHIQu/qcp9TSXphmd81TxBy7WULGJLKshfi2iMHt6qe07gEnasSpJeE+EjzpbCI2sDlv9cUTpX7MSYMStaTw2VPYMiWFoNz0r7+YOWg9HFwU53Vv0RJ7CJBCJu3JXGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F4TmBMrW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wp3TuvMG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F4TmBMrW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wp3TuvMG"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 890DCEC0493;
	Tue,  2 Sep 2025 06:49:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 02 Sep 2025 06:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810153;
	 x=1756896553; bh=2HcYUO/bTsSALSC+whdMBGdW4TzYTYu1VpflEe3wqX8=; b=
	F4TmBMrW4CbpSZ858Pf0gwkEhwnzVnKm8WzDr3x4XmwY9f1uAz7vKH8iOzjq94rL
	4bpuX8mITCcnpq2d1eHMjIg2THTHE/p7CJtUZ8MK6l3Sm4yP7CpiawPpcSh6cQyq
	IEUtCtSFitrgtenY8gIKFJSYbCTeIAycfyl6sS/PNDr00Xv4E7tYNuwC91dzwda0
	jojR4FBPurzAV/A3g9oScL4F+FcDLFTLlQ/i1bkGl6ReMHRizgJfvkPsVmQ/dcsg
	bvTaJdxn9fYVhlXbWCkoD8ZBT5gM0hVwEcwMepW0JKsjaN2IDMVb9g3nK+BsIEoH
	JA5bpo+Cq1hMM7e7X+lAIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810153; x=
	1756896553; bh=2HcYUO/bTsSALSC+whdMBGdW4TzYTYu1VpflEe3wqX8=; b=W
	p3TuvMG5ojBmZ+W0jB5zYIEOomXv+LK3qkBgwhMld/mO0XWBdbHecWS7OyZFf4PX
	Je8C+E7a1t8t4+W+SVOEbE3SAK+byPxbWZNqqFkT0DI8KPSUToOE4QFRnCGWgL3b
	1q8DcGaInHxaiNMXGezHktIeYW11Q98UkzexhzVXQ60CVnKyxyGWG+OUzKWy1UTP
	Lk8ZKdJvKazy6PZa0O+pHDDWoMVowLno13SPShvTBkLUP67FlYkXQOdnFJZ4szsG
	2DGfGix55gkNhC+10bae0WmlMS47segDrv/WRfauf19mrKeB/zp5Mucc/Bbi0nKG
	ttpHDzwe0igkgZqs/ouSw==
X-ME-Sender: <xms:qcu2aHkyRYomr8iw4GisX6AYf0SjjQxq3-ryxynqorhxQeCtIs-O1w>
    <xme:qcu2aGXGbSM-mLH_4duJmG1X1JVGplh7dL0OQXeEi0XqN__iX6fNTlH1-0KtXR3gI
    N04L33VHe3eZeYFZQ>
X-ME-Received: <xmr:qcu2aEFhubagOKXbrmu_djPk5D9vx9blNr7smkADDvfkWYwCjKeDbM4-Xy2z6Opy9aOWn-V1ZIJc4k13khoNPNW_4ffq5V4QGE9g0zsXx5vOCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qcu2aKeLUJVMr2TxxAHwukSC81cPyRCd-a0WOFKqf2IKJy5VmUYlNw>
    <xmx:qcu2aNLZs4QUuzm1sRFQPj0yUG6Uq9nuAulGVZ4tqZKaflYTkXw_ng>
    <xmx:qcu2aHGyF1YA948VxKp1OBu37WjE9CiDXi-NJTpIEUaiNRD7jcpVYA>
    <xmx:qcu2aIDBBWiXgw2lootJpe4zYE_gG-qzEUmw80UXQ7g_k5ixNuYKng>
    <xmx:qcu2aNpLyArgmGikD6MoNZkTQ9yg4TXX-x6PIUkmMzAZy8H9aSnokxm4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:49:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fb18e17 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:49:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:35 +0200
Subject: [PATCH v3 10/15] packfile: refactor `install_packed_git()` to work
 on packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-10-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
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
index edd5ecc9cf..e1a3c0487c 100644
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
2.51.0.384.g4c02a37b29.dirty


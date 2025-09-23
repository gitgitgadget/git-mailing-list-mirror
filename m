Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CF320CD6
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622646; cv=none; b=fg6TLQF6rwvY1qsehRjC+of0W9GyuLm71x3clYDF17yqjiGR6iffoofHlcMWA1Up/2Tesl92Ai+wKVlNbN1h4FuRKUWJX1tVUI3EXWHUMjmPU6wGhoqji/RWPCfZjBMu2q8iwnRegmmu9AbZe1xFn3E4ri3LDKS3yIPBk+EAG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622646; c=relaxed/simple;
	bh=/HYcxCAskNueiJ8bPZIDbEHHrSTI6A6/h4kJS0An02I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4tW3WYwTkKxf3VjVTzyiNqEJ6pa2qCJuA4oGPfRXyNf2vBGYl1ks+HMlJN14gjmgJseI3tirivNjWc/WdWSt70rNWguJ6cx7QizgE/cLhBati3VKTZiw+wA8tLOXOymgk237YmyYu7LA6bnwrNrw13xsWtHZsFedvVfWQt4pcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qD0AM53n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=alHyvOPU; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qD0AM53n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="alHyvOPU"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0807F1D002D2;
	Tue, 23 Sep 2025 06:17:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 23 Sep 2025 06:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622643;
	 x=1758709043; bh=R3WYWPsx/m3gKkLLUDKGIzSiRsnK0ysXV78gTjliYOc=; b=
	qD0AM53nCDMP6zbVnD11k8WMEKJPerUsjZ/j+JxDChpYQVxDGDsimlIyGq9ArUDM
	XXLiT0zB5ObdWtihlOVeip0pdVfHatEP/5d/ALY1TWXAY8x1+JwNePWAsxzzehWh
	3yoH1pwjq0MUPfIRPMzbRzYdy7zmcyOAHJoJGPTydR8xUPIFRTqN6snOcOwU5RWu
	z12oC1OW2e4tvGu6ioYfEQrg6XmWRs6jwQCL5OuVr1RhbsIDpbOi8sThQdTzn9nr
	5eiZBhM4BjoTTE9TYimZfq2QO1bt78h40fw3/HUa5QoeXk2IRByLmUMFxljkkUUR
	znF3OvgO6wYxiwlLQFoVrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622643; x=
	1758709043; bh=R3WYWPsx/m3gKkLLUDKGIzSiRsnK0ysXV78gTjliYOc=; b=a
	lHyvOPUcxMWXsvVJ9qlx3tYw9kBkfiM/2BzN6IL6FnPN04i6TRZrQohqpnFEdF5o
	wBzd0sDpPk5msYfZLfcktqUiu240VYIffrS/RZYAzIhiUkTnPHRR9PZ1c5APLc1A
	/2ylKCwVQb1NY2O2lwV63T7FIuMZFQKxFHPhzuuo/jZCvHgEJf06u8rifTWT4e1T
	gAUswiZthR2BBhU3FydDT4wDidSWZf4rM/bEs8eGM22TepVmKLkJKAeZze5/vFqv
	57Yziwr1RrFx7/vm02H06nFd4cO6t5+C+PynVtv3nPpEuEu/pSse68rIqe2jG8Zk
	IRZMJC3jsnPE6kVJNjPfQ==
X-ME-Sender: <xms:s3PSaDHpmy7ROYIpTgqe6palkDrTpz9zcJk0sZC4xF_qGeDcQER_JQ>
    <xme:s3PSaECRgVpHShxypZJZktEJIih92IqXhgFJ2L5tebqvgz9reiC5wRfvDgYV4Cdds
    cmS2xH8BaaAnUxWXPVisnsk1tIK7n0RepRJkT7JKfqdeyJ676aIEg>
X-ME-Received: <xmr:s3PSaO-ybaGRumxD1ZGEX9NgwqXz9TnqwHbMKkJNAJ2wfP799W0NTwcqjdcoZHBBOqUXqJC4QKc5tww-aaT0OWNWb-huPHdc_fH83iX7Qnfm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomh
X-ME-Proxy: <xmx:s3PSaIBZuWT-x8oeHY6H3DDrA1-htLY5UUNNeSSnjCb4sLpglwp6Jw>
    <xmx:s3PSaLTqyVHgS1m5OjNttLCfy6pjoGKhCc1OcVVgdJqD9fVtoDCkRg>
    <xmx:s3PSaHvF9kC0ZK5eSCg2M9bhks3wO_YSU9JG78dIbT1OZX5n-WJOSg>
    <xmx:s3PSaP0N6yPdeyF4dA4N_ODYm15tmiPGPfN1XvOc_HDrWjVI7D9nJQ>
    <xmx:s3PSaJhc1mNv7ct4hN_ycwAUDZfNeFOTSqDW6vZbsMc_NLMMGuLjboAz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f66d9c51 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 12:17:04 +0200
Subject: [PATCH v6 05/15] odb: move MRU list of packfiles into `struct
 packfile_store`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-packfiles-store-v6-5-b48f2a882759@pks.im>
References: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The object database tracks the list of packfiles in most-recently-used
order, which is mostly used to favor reading from packfiles that contain
most of the objects that we're currently accessing. With the
introduction of the `struct packfile_store` we have a better place to
host this list though.

Move the list accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     |  2 +-
 odb.c      |  2 --
 odb.h      |  4 ----
 packfile.c | 11 ++++++-----
 packfile.h |  3 +++
 5 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/midx.c b/midx.c
index e96970efbf..91c7b3917d 100644
--- a/midx.c
+++ b/midx.c
@@ -468,7 +468,7 @@ int prepare_midx_pack(struct multi_pack_index *m,
 				   m->source->local);
 		if (p) {
 			install_packed_git(r, p);
-			list_add_tail(&p->mru, &r->objects->packed_git_mru);
+			list_add_tail(&p->mru, &r->objects->packfiles->mru);
 		}
 	}
 
diff --git a/odb.c b/odb.c
index 737d98c911..32e982bf0b 100644
--- a/odb.c
+++ b/odb.c
@@ -997,7 +997,6 @@ struct object_database *odb_new(struct repository *repo)
 	memset(o, 0, sizeof(*o));
 	o->repo = repo;
 	o->packfiles = packfile_store_new(o);
-	INIT_LIST_HEAD(&o->packed_git_mru);
 	pthread_mutex_init(&o->replace_mutex, NULL);
 	string_list_init_dup(&o->submodule_source_paths);
 	return o;
@@ -1035,7 +1034,6 @@ void odb_clear(struct object_database *o)
 		free((char *) o->cached_objects[i].value.buf);
 	FREE_AND_NULL(o->cached_objects);
 
-	INIT_LIST_HEAD(&o->packed_git_mru);
 	close_object_store(o);
 	packfile_store_free(o->packfiles);
 	o->packfiles = NULL;
diff --git a/odb.h b/odb.h
index b79e7280c1..3044b6a661 100644
--- a/odb.h
+++ b/odb.h
@@ -3,7 +3,6 @@
 
 #include "hashmap.h"
 #include "object.h"
-#include "list.h"
 #include "oidset.h"
 #include "oidmap.h"
 #include "string-list.h"
@@ -138,9 +137,6 @@ struct object_database {
 	 * Should only be accessed directly by packfile.c and midx.c.
 	 */
 	struct packfile_store *packfiles;
-	/* A most-recently-used ordered version of the packed_git list. */
-	struct list_head packed_git_mru;
-
 	struct {
 		struct packed_git **packs;
 		unsigned flags;
diff --git a/packfile.c b/packfile.c
index 17e0b8ab27..861d7ffd6f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1017,10 +1017,10 @@ static void prepare_packed_git_mru(struct repository *r)
 {
 	struct packed_git *p;
 
-	INIT_LIST_HEAD(&r->objects->packed_git_mru);
+	INIT_LIST_HEAD(&r->objects->packfiles->mru);
 
 	for (p = r->objects->packfiles->packs; p; p = p->next)
-		list_add_tail(&p->mru, &r->objects->packed_git_mru);
+		list_add_tail(&p->mru, &r->objects->packfiles->mru);
 }
 
 static void prepare_packed_git(struct repository *r)
@@ -1095,7 +1095,7 @@ struct packed_git *get_all_packs(struct repository *r)
 struct list_head *get_packed_git_mru(struct repository *r)
 {
 	prepare_packed_git(r);
-	return &r->objects->packed_git_mru;
+	return &r->objects->packfiles->mru;
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
@@ -2078,10 +2078,10 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 	if (!r->objects->packfiles->packs)
 		return 0;
 
-	list_for_each(pos, &r->objects->packed_git_mru) {
+	list_for_each(pos, &r->objects->packfiles->mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
 		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
-			list_move(&p->mru, &r->objects->packed_git_mru);
+			list_move(&p->mru, &r->objects->packfiles->mru);
 			return 1;
 		}
 	}
@@ -2347,6 +2347,7 @@ struct packfile_store *packfile_store_new(struct object_database *odb)
 	struct packfile_store *store;
 	CALLOC_ARRAY(store, 1);
 	store->odb = odb;
+	INIT_LIST_HEAD(&store->mru);
 	hashmap_init(&store->map, pack_map_entry_cmp, NULL, 0);
 	return store;
 }
diff --git a/packfile.h b/packfile.h
index 9bbef51164..d48d46cc1b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -64,6 +64,9 @@ struct packfile_store {
 	 */
 	struct packed_git *packs;
 
+	/* A most-recently-used ordered version of the packs list. */
+	struct list_head mru;
+
 	/*
 	 * A map of packfile names to packed_git structs for tracking which
 	 * packs have been loaded already.

-- 
2.51.0.536.g15c5d4f767.dirty


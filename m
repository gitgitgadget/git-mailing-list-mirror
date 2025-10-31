Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E712EC562
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891195; cv=none; b=hHgzhZeLRz5HhOOoH3B/vEjctmEahEksT1rqxOdS8ZIu3DBY6zK5z3p/BL0DtRBAM5TEbu6pQlE86qSAJNnpqHWq783kcf6BMRFkEOh+J9wf3vOOy9m/9OIFoM2cL8KwdgRiHxA9zNEnEDXlJAq30W6hyH/Il0Bph8X/HmlXA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891195; c=relaxed/simple;
	bh=8/hIBM/2x3f6oxCCzkxMU1maoDzSfABQe59jRZA9Zlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXYEngiEcuPtIua0Jt7WuQLFiYg/EmtUnywJlsw3wzbEKTgflVzw2XO25dpJE/BsRPugJNf3MR5rzszEx/za3DamXqK0yNlCicnRhq89y4MKmFERGe05phJG1+tF/QdLp9qujfMDNKQdc5lehxdRlEr3TIswvZKkPtb3H4ztU8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=knD+wF31; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZGfV2Tco; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="knD+wF31";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZGfV2Tco"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A0413EC01E4;
	Fri, 31 Oct 2025 02:13:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 31 Oct 2025 02:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891191;
	 x=1761977591; bh=UkaW2YwT54pwjq9V7MRjgngubiEvdqLxAYzNSlGgIDE=; b=
	knD+wF31rhfTY8AQo76bauTrkipAQy3gmBy9tJ5aThn2B1CHUPCYqEhovYxQPDbx
	6MDdkVNW2tB8B5l9Uu401+ogkqqRDRSeSbbH2ndK7E3dZZVv2/20C6nfRYOXP8RX
	yGt7i1CSo3PRyDKVjP8PiNAAneHMG/r2yplPiZOXtz4S7RC6cCCZEigFeSsHhLyr
	8i+/gIHMI5F+1XxLZ/oD6OY7fVajPoes+d30EQQ+RgAf/7c21Vg6jySv9+I6bGPg
	tJxydTaGCM3guwzeznLdZP1hdbYR/aULaUBtod7X0T/H4Eut8JO0V8vOyh0OJ3lW
	50fc3i6iWkqGHE+wtd3+tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891191; x=
	1761977591; bh=UkaW2YwT54pwjq9V7MRjgngubiEvdqLxAYzNSlGgIDE=; b=Z
	GfV2TcoVgaoyt5HhVJlhOOfc1z1oNXOnPomFchbBsqcZYy5UOtb7lJuyNSIMG4Pe
	34wPd+rhDSCyhiC23xWxPoCgyMOuIpUivMv/Wiy+97eCupb+MjfNqE12xrrIz7ba
	QHqmtJeQ2lv9IUZqzU3kF56I+W044ZwWT2u9TJP0i+lXjtlS6mhOU5i20KiCiWgl
	HoweAYQSgnfgz32h6lTB+mqUn/jayMxUcjqglHw+ePIcllKXjvEOVGK4ImhbG7KT
	yLuEdqEBkMlv1HEQSqkTy9AHIRMdfvrzcfrdaN1UycTU0HOlvJlEihGESmyszoFa
	Hps4NE9C7aHm+yPgotfzg==
X-ME-Sender: <xms:d1MEaYeY09x0_PgMjgXexfZJUSpSh2h7XQnSskA_oUztgmuz5vUc4g>
    <xme:d1MEaRozZ4H_RVSLpPcRyiPJbyIxNzHNbtJeHZdFovzkBKWjmwmLyA0Xab8kV65Du
    iZKQ5NXE5X8zMHL54V4AXWEcon1cE2mZoQFvwJKAqqRcKvre0QArw>
X-ME-Received: <xmr:d1MEaW4mUK0pDJP0hxl9Yj2tbd_ixjG9zzXvgMoOIBM2McpqXsZwhOmkK1PPj-5yUgo_blrDfth1KczCdR_dOnGEa5pL9SrnnfM1pN2lAAptMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:d1MEaXq02YfzadvJuQhXgC0r9MDXfQ2vA1lOMEzwlN-OcAkp3yGUaw>
    <xmx:d1MEaYjvsAZfJ6nXyr-UmD9FYp1TcT3VKsNQxwUcASCfDx_WAb0zkQ>
    <xmx:d1MEaRKue5y58eeQ_aldh-Y8wsZJloNoVPg_L-lSyOv3HYPqTBnULw>
    <xmx:d1MEaYBTeEHRewBINhzH2yAiq9C6YjRlNKzLml-DMAQF-XB5wZFNsQ>
    <xmx:d1MEadoBEFIdj8EQOAI5fsjaTw7LBS7Srnhphu_i_tFUs9JzDlDyN29O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:13:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96389faa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:13:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:44 +0100
Subject: [PATCH v2 08/13] object-file: move loose object map into loose
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-8-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The loose object map is used to map from the repository's canonical
object hash to the compatibility hash. As the name indicates, this map
is only used for loose objects, and as such it is tied to a specific
loose object source.

Same as with preceding commits, move this map into the loose object
source accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c       | 10 +++++-----
 object-file.c |  1 +
 object-file.h |  3 +++
 odb.c         |  1 -
 odb.h         |  3 ---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/loose.c b/loose.c
index 8cc7573ff2b..56cf64b648b 100644
--- a/loose.c
+++ b/loose.c
@@ -49,7 +49,7 @@ static int insert_loose_map(struct odb_source *source,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
 {
-	struct loose_object_map *map = source->loose_map;
+	struct loose_object_map *map = source->loose->map;
 	int inserted = 0;
 
 	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
@@ -65,8 +65,8 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 	FILE *fp;
 
-	if (!source->loose_map)
-		loose_object_map_init(&source->loose_map);
+	if (!source->loose->map)
+		loose_object_map_init(&source->loose->map);
 	if (!source->loose->cache) {
 		ALLOC_ARRAY(source->loose->cache, 1);
 		oidtree_init(source->loose->cache);
@@ -125,7 +125,7 @@ int repo_read_loose_object_map(struct repository *repo)
 
 int repo_write_loose_object_map(struct repository *repo)
 {
-	kh_oid_map_t *map = repo->objects->sources->loose_map->to_compat;
+	kh_oid_map_t *map = repo->objects->sources->loose->map->to_compat;
 	struct lock_file lock;
 	int fd;
 	khiter_t iter;
@@ -231,7 +231,7 @@ int repo_loose_object_map_oid(struct repository *repo,
 	khiter_t pos;
 
 	for (source = repo->objects->sources; source; source = source->next) {
-		struct loose_object_map *loose_map = source->loose_map;
+		struct loose_object_map *loose_map = source->loose->map;
 		if (!loose_map)
 			continue;
 		map = (to == repo->compat_hash_algo) ?
diff --git a/object-file.c b/object-file.c
index 2b908dc1215..e8877876d77 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2014,5 +2014,6 @@ void odb_loose_source_free(struct odb_loose_source *loose)
 	if (!loose)
 		return;
 	odb_loose_source_clear_cache(loose);
+	loose_object_map_clear(&loose->map);
 	free(loose);
 }
diff --git a/object-file.h b/object-file.h
index 6cbb4b44352..74bae27612f 100644
--- a/object-file.h
+++ b/object-file.h
@@ -32,6 +32,9 @@ struct odb_loose_source {
 	 */
 	uint32_t subdir_seen[8]; /* 256 bits */
 	struct oidtree *cache;
+
+	/* Map between object IDs for loose objects. */
+	struct loose_object_map *map;
 };
 
 struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
diff --git a/odb.c b/odb.c
index b4196f0b323..96059456f20 100644
--- a/odb.c
+++ b/odb.c
@@ -370,7 +370,6 @@ static void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
 	odb_loose_source_free(source->loose);
-	loose_object_map_clear(&source->loose_map);
 	free(source);
 }
 
diff --git a/odb.h b/odb.h
index ad57193c66a..25fbcd7d951 100644
--- a/odb.h
+++ b/odb.h
@@ -51,9 +51,6 @@ struct odb_source {
 	/* Private state for loose objects. */
 	struct odb_loose_source *loose;
 
-	/* Map between object IDs for loose objects. */
-	struct loose_object_map *loose_map;
-
 	/*
 	 * private data
 	 *

-- 
2.51.2.1041.gc1ab5b90ca.dirty


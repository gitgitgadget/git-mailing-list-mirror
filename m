Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD02C11FC
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155757; cv=none; b=pi5hSDgLXZ7I7xOzbd5RRFoY1i2VbgCcc1LbjRYPkhnQq3lYylPmPkkH5KI2Wr+CnCrFaSBtqoaAdLZCH3RKqkJ49Ka2eZUtioxcCQXEgYj3H20Dn2f0Z10qcQKZC3Cj9+icpYsTZBWAGbvC8c/sF8mcyRW7RGjYi7cGzfa1+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155757; c=relaxed/simple;
	bh=uGn8SQso8sAst/yubREoxgQtUZj+IKPYhPSdthtHhnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VZJPNsnonaMl0PoU+m599KetawaxPNp/TMYOx9LC4sQQ7Kg+xcxqb2d57NdN0napYCZolvPYon6VlTnvuh2kCokneh0mXNimH1ZGE+J6joL6FF2zb0x3mtolFwhCG47N+BH9pcWAGml5jg2rGmPvqq3G46efaFTqfWUd/T8eOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GGElcFfO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pY8VH/im; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GGElcFfO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pY8VH/im"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B11261D000E3;
	Mon,  3 Nov 2025 02:42:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 02:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155754;
	 x=1762242154; bh=ekqslmSukTavhu3+L333FdQkoQWjojVHM7MNEBdNHqc=; b=
	GGElcFfO1B2+H5q3Kqcgc0CFo09rS0mNUL8RFlTB/c6RQVvFBX/AvV2SW4Om4bjZ
	XlP6/mOieqTBu7rojbD+t6/gDhba7MBLQ2ED1F0c9ayuczJa7EwmdBfytgB4aT/7
	MVn3szuHf2gAZXRXXlynxQN4ANZ0j1U8IVRbHqFVzOnBgusI2knJoC8cJtpy7gwe
	Obu+9XAjb9cY0yeJ9rntewe7WVAQU0FGaeT/51p9uhZSN5Joit7joES5CtrkELiz
	8zGARes3hcqzI1pVNPyZwjb0Cj0DNsoixfDR1MxVl3v0DnEenQj+wiZcAquDS0jL
	ZDf1+CgTs+p4Qe8YX6aTzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155754; x=
	1762242154; bh=ekqslmSukTavhu3+L333FdQkoQWjojVHM7MNEBdNHqc=; b=p
	Y8VH/imLvSYr9fDYtoP0DX1GqpvH+Ehd3bQf1dUqB5kkBRMCV8O9jv/U/k3g0lwa
	gLEEIrqvH2FVb8OV5OPMTj0R6tDNDNa9AbwYv7Ks6gMhkQiPcroTk65i/581+1Qu
	up0BXG7i0FzF+Ozc95Hs+ZUWXVzz46JvQa4lJ4WsxWoDQr1uucWj6ko2/AtN3+Nc
	VckkCadmrS1MVf2eY+uBhFOPRtC2CYCyRbg3QOig8CUYb53resTMBoYAgrabfRa2
	ENXYTfKhNIf3kEE30Ey1ssQ3blRLhceqZvlrvq2UavH3uWg10Rw6IaU+tmnwkDwt
	jPAl1gq19uswstkOSZqzQ==
X-ME-Sender: <xms:6lwIaT2Rnmc3ZbhwiX5Rrv0ytKp69fV-clvaExkw07EMdJsFXhg2EA>
    <xme:6lwIaZicDhEFxkyOCNgBrf1qU1_n9Trc_pqWtNDyESw12Wovb9zR_rrUL7cbY0ebd
    dYlmWYHK4EC6GwtC1N6MpWWMdO2uxqDx3kugYWBiOOgfXJSS_UO>
X-ME-Received: <xmr:6lwIaRRFh8TG7WMaDUIwBIQpa_Gy9usm46-XgkqvXwH2oWvV8ZDRg9lp17EK6oNp_tHX_pQb6PZ4n2y4qL-t0wMEZ-jModCXrWE2eSWafhtX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:6lwIaSjl4iRFdu8zQ7ovDEHRbvV7t75yRFMNHvyasP6HuotnXYMlKg>
    <xmx:6lwIaZ79vukgceKW8cG9vFpkOi-2LGk4iNMbhDYcOd5GVWSKsDQ8-w>
    <xmx:6lwIaXBxZ_rEyHHnWqJfyahU52q9o0OtIUGLNlzT-q127m9-tKdMQQ>
    <xmx:6lwIaYb2CK83UESqFfZ6ksKCYFZvYhTqN6SgSC51Af7FuWnZO3jYCg>
    <xmx:6lwIadj0TKHGTkao13Zv3DftlWE2Kj4OMWiuXIEtUvGzXds6grigqt8z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 182c8d0f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:42:03 +0100
Subject: [PATCH v3 08/13] object-file: move loose object map into loose
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-8-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
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
index 20daa629a1d..ccc67713fad 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2014,5 +2014,6 @@ void odb_source_loose_free(struct odb_source_loose *loose)
 	if (!loose)
 		return;
 	odb_source_loose_clear_cache(loose);
+	loose_object_map_clear(&loose->map);
 	free(loose);
 }
diff --git a/object-file.h b/object-file.h
index bec855e8e53..f8a96a45f57 100644
--- a/object-file.h
+++ b/object-file.h
@@ -32,6 +32,9 @@ struct odb_source_loose {
 	 */
 	uint32_t subdir_seen[8]; /* 256 bits */
 	struct oidtree *cache;
+
+	/* Map between object IDs for loose objects. */
+	struct loose_object_map *map;
 };
 
 struct odb_source_loose *odb_source_loose_new(struct odb_source *source);
diff --git a/odb.c b/odb.c
index b3e8d4a49cb..d1df9609e21 100644
--- a/odb.c
+++ b/odb.c
@@ -370,7 +370,6 @@ static void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
 	odb_source_loose_free(source->loose);
-	loose_object_map_clear(&source->loose_map);
 	free(source);
 }
 
diff --git a/odb.h b/odb.h
index 77104396afe..f9a3137a34a 100644
--- a/odb.h
+++ b/odb.h
@@ -51,9 +51,6 @@ struct odb_source {
 	/* Private state for loose objects. */
 	struct odb_source_loose *loose;
 
-	/* Map between object IDs for loose objects. */
-	struct loose_object_map *loose_map;
-
 	/*
 	 * private data
 	 *

-- 
2.51.2.1041.gc1ab5b90ca.dirty


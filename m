Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31208288AD
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299792; cv=none; b=PgAhvG8ForZm+buF10JXF0CjijOqbkmUjAPG+jPlhRMxCigFeMCbJRsRzGbjUC5PxH/Uzbf1gIRRBswNxO5snZciqFYa5Sh5I3aIGBrMX+dPMumpKdFnfeBpokTmqYlfMjR3+7LDtK8NyNOzbA3ZaziH9TVUlV8Nm48LPN9y60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299792; c=relaxed/simple;
	bh=IC0+u5XbzlH9y1mf9aP/uAfL34Py17VNkctakhPtK2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOE84Y8w9bZGG1gc2kBDHsdZZGAQ36Jrf0sPTPRrV0Is0frMil98hYYzaF6INS18tG3KuvcTkpMl5v0SrOenOfDumKfpWRyD3Gr1Lll28g6lLoGg8SqOeWsNAnp3Bu29u3D1wT4ZRy1ORckbWAshD4iJy8mLdkznwFK4uCyw1Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BOiffMwC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pp0XBnB/; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BOiffMwC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pp0XBnB/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E275EC02A0
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 24 Oct 2025 05:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299790;
	 x=1761386190; bh=ttB+dRUJYM0OgrxdsyBdN7WyI/EQ3NiqBfBBnsczkRQ=; b=
	BOiffMwCbP9/wMBqo+Sswy0Ze1byUuyQVD0At+FLnp/tiqAQjsGOVNgjEe6zKV+6
	Zsz0hGelkRDmy2pHl/16mcAbUvnktONvBvb+i5jRxMMU+U0c0Hh/qG8kz/zBRIMq
	FcNg+YRqKC2DarH/cesddDXdZgxovStaNc5NJQhCja9xXODbKE5O4XlLWoXAS0S4
	MP1QdQshsbY5d58oETL1UyViPmCxbuIXTmW4uvzEiHu57282SLKnSo9kwHlsHe6y
	GXhY+CTIntQsAme3Clhv994K0RLhZgP8KBAj3auBshROAz0aEf8Ajk5tv1wuY/by
	xEZLX9JDzBfU33UV/AiUFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299790; x=
	1761386190; bh=ttB+dRUJYM0OgrxdsyBdN7WyI/EQ3NiqBfBBnsczkRQ=; b=p
	p0XBnB/ozfiD67TrYHKUvWN/pctZdfSQo9o4lz03NwB3Tj13qKCVl1owiVB+iGfz
	/RXM636dOWQF+hxJ8rlPUDG7p3fuxc6M/nQk9Mkz/wrLeztEI+FOqqEH6hIZu0zo
	K7Jj41VyowK1/J7Sqv7rHDy/f1L3NxF40/8RnbqTtcQHIxwe7MmVBsTamjbtQ5aT
	FYahYbVapdK3MqRIa/17v3ira4vwOO9sIhA5f8t3/Lcy/STxw7OVaMnPesBKKpqJ
	WFNsdKXFtSPAMip5kEG/FRm6PocPLbhF77bvLUo3pppUPNfuto8qd+vg0Oua0YFV
	ocrSTPKSUqhpM9vzuhtQg==
X-ME-Sender: <xms:Tk37aIK5D1ijwliiHd5_x6NkpotHrp4ircbzrcE6a7IffT9JyqGsjw>
    <xme:Tk37aPHc1AWwe6KN2RWUyxBastc1SiQHZ4KmyxWHN5qzV6JJuXDfPW9bGDhVlSHgf
    U6TEMuYSdgF9P36gc1G_kx7KmiNFZ6Gx7VAWRMZy_8oymZTmr009Q>
X-ME-Received: <xmr:Tk37aOUDceIeI5trf50M2gaggsEc634Idl1M3fRM45AGX0F8-O3RYnwPWfudWPQUn5Z8xIjENPM1NzAW9s3-qnK21JZhHl0_jPWxbImR0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Tk37aKjnL4mMrxo0amxUX73gsVH0lb3wvKhNJVRkWvghjXaFkOwkRg>
    <xmx:Tk37aPSHi1O9U4kaN0CcXcWVkWa2j08rfqhNPgQeb2L172Ow0Dm8TQ>
    <xmx:Tk37aNEHKZ2crptafB_9T_BJm0gaObbBl6nuufBBh1ACNB9eFfqQ-g>
    <xmx:Tk37aHkjKUl1pVCFB6zOr1QnqDNr_Y6dGpV59csP7uIUmKHiyoKY4w>
    <xmx:Tk37aBpxDY87U27ALzrenRILfFqd_pY2M_-L8m7hJMHhmrqJe1qbyFOw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e6efffd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:07 +0200
Subject: [PATCH 08/13] object-file: move loose object map into loose source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-8-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 34c7fb434dc..14daa2bdd90 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2014,5 +2014,6 @@ void odb_loose_source_free(struct odb_loose_source *source)
 	if (!source)
 		return;
 	odb_loose_source_clear_cache(source);
+	loose_object_map_clear(&source->map);
 	free(source);
 }
diff --git a/object-file.h b/object-file.h
index a8d6cf513d6..706f1e1872d 100644
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
2.51.1.930.gacf6e81ea2.dirty


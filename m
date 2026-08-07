Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A293806CD
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073680; cv=none; b=oRrteMfmKW8RmoUtoi0O1+pKbgYjx7Xhi/smmeqDgBRtWzwhq9gp7fHJy2ibZFu+O46qzErOlyPJo/ge3drwpQqLIQOlp/5gR2C/yISEGNk43pqwiQ3vm44c8GfuzafbtSKE5SMbkZ165NT+F1sZOkN7AQJslS5I3+gGJB2EAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073680; c=relaxed/simple;
	bh=3naYBg1LByg3E9Oyop+h7d3uxqZ/s8YhzPwYiyIt7bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McNwi5ORjQIw4aS/7WQpuZnwOBNkp0ldEsteVMa9dLXG2j30Nomi21HMakpFuiL1QXtuAWy3cCfJ0A0WCmysFR/+aQZDwsbuV+mbwjn4VikcsXxZpt6PP13wKSbC3Amz8hMsMXea4PeovTLeLcBU9eID3oDU22rlzn/yRYGOY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hj9IxEbO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C2T7R3r1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hj9IxEbO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C2T7R3r1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A5AD14000BF;
	Thu,  6 Aug 2026 23:34:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 23:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786073678;
	 x=1786160078; bh=cPo/55/wbb7PM3Y8Sbz1kXuBojaUDpnuMPqvcHv5UE4=; b=
	Hj9IxEbOZRy9F0c8Yxkx02Di3rMMJznqPR549Y+8jJXeZoRUlVaLTlp6zoJlzR0K
	ld1hSHky7oWhOGHuDi/9fuc98O3etjK4ZNTfzyie0KjXJFNQuMCYAHL08jgq5+c4
	DZ4ab7S5r+Qhl1ukZ2I62nNxXfFHg1wKm3UMC5Oz1pm6jqwsoJ1eXEy8t5lUdsIt
	vakRNV0LeHOSLRfQcW9zh2rNsETm56/oQojPt2jLXEAbem9/vDDbv6sVTk+t1OrR
	oKWdxI0KTEibd25NP1A/RUEUBm1V2HRaFUKCS70WxnZVfX5YEHtpKtZfUp1BGTOx
	3Cuu50OxU7AMjeodts2kdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786073678; x=
	1786160078; bh=cPo/55/wbb7PM3Y8Sbz1kXuBojaUDpnuMPqvcHv5UE4=; b=C
	2T7R3r1CKO75gnwUIlc5p+NhFZrWdCfIm9vGtOqRLxmXUrDPLdOv7Fuk9mTPJnvi
	uDNSBCtt+GFG05ym8UdzFxgmklzEQLbQ9MAO7bof8Th/mWDM8Y4EhX2XnzmynsA9
	C5VkVgVOG3DfBAR/s8t+SQzSA72thb6xHIf8aVCmgoNQSJM3LuXCbuZS6EasVKYE
	c1H61fRPgo9u/iqyj3D/eXztHSP6T8EG5hwhjnJ242wXeOd/ygA79um9mq3vBHfB
	iSB/mRBTXfYas+p95hCl/EN51WCkW11XstBvlPHsnuoXWIOai37X4fpeaS9cDTUV
	NjyHmsZN/O8jSgzV7xxxQ==
X-ME-Sender: <xms:TlJ1amVpvdcIoTaM9yFyWz0D7G8RLj7I45pntgGXbzRzpKuFBP_2Pg>
    <xme:TlJ1apleoSo0xIv4R9gax969EgpuXrrg7hn42NzF4c0pJo47V8PtE4th6m2H_BYW-
    7LfBG82AyD90ZF2khkHq6x1spDm5gKEC8pLXi7stmWftgf0MYbRZhQ>
X-ME-Received: <xmr:TlJ1avbKqHJH_Q8aA3IorP_oCAqx0eQ8xWIQTNMJoGja7XviRXj91b3GqPID-mtL_AqIuvN_elr4RUVMJhx9WGAVfrFxIHZ4XtvGFbxF5t2A9w>
X-ME-Proxy-Cause: dmFkZTE7kdBa+2ZpN9yaQzNopvi5XGOOKBTvLDG9gmHatLClTyCzXowykrFEsXwaSZzd4i
    7rZ+PYPbEsDpQY65/3WEOnc3hfu3bdJkEr0npqZzCOFaVJnElXRww4Mk5FBkx2+neuda5y
    A+H0Sn3NmT1/usz1Tgjyy7AJoC08TLsGbBAgN5++8fR1k3aPnOSgHwDRp6T+iuecMdWx7o
    nj7jBoWmovohcLM4ckangVr/9NTxAZBdKgEEJXE/ShuS40CTDkm1PTxNMXsIZneVIrNtc+
    YP0jF47y+J8bJU/RfS7k4wGaeZn5/rp5UAv2tEyMAQrx5mBuiXa3CjLgjK6t3CHEGqxXuI
    MITPMLNzrxguVr4YqAa45NbVl+WEiZrDZqSAuiGMRBnf6C5EaqZYzr3Svj35UEdJznDN8z
    6M9UWUsk2Chy3UmV2qWPncIlfEYWDX+w5zfia4gVa6KbZDJxF+NAK/jtLNIzPDQJ7qdVjB
    pRqhFvCmZEU2ebRJZfw2gIiHzRQ7eZncpM8MVNr5eSkbEcOvd6+CYygxeXENfte1V3n991
    K50VT3Ig49ij/1QiPvQNqPBaoS3is/ZIk1lDXT9HbVYlKKlARPiCPPsIo5jU0anfH6gk+V
    +JKStMtrEft3xA8PfVGk6ylUuPHnXZsuds6msgXoiXYWHonY9GJ64eayIytQ
X-ME-Proxy: <xmx:TlJ1asN8H8BaWuKPKTXQxKiFtF-dOSUN7-xKwjQdT7S-Wgd8TWxPnQ>
    <xmx:TlJ1asaGhOL4rDK4MJZvtJPHC7E06mvDP0ireY4hqavDf8WWcJZJ8w>
    <xmx:TlJ1ai2UocTzC2kdG-xDzLyvrkczdbzsHGIVnEBC70Amwspb-Ad0Yg>
    <xmx:TlJ1aqeYUwtlASRXknD5TmsqVoqISgIRgyhbX589OGbbczv4hiPcUw>
    <xmx:TlJ1alZXQk3yYHy936oAGL0NW9llyqE7bELMa3kKSjKg-cRxziRHQ4z0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 23:34:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9681cbef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 03:34:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 05:34:26 +0200
Subject: [PATCH v5 2/6] setup: detangle loading of loose object maps
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-pks-odb-create-on-disk-v5-2-399da0b0b140@pks.im>
References: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
In-Reply-To: <20260807-pks-odb-create-on-disk-v5-0-399da0b0b140@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

When a repository is configured to use a compatibility hash function
then we load the loose object map when we initialize the repository.
This object map provides the mappings between the canonical object hash
and the compatibility object hash.

Loading the object map happens in `repo_set_compat_hash_algo()`, which
calls `repo_read_loose_object_map()` in case the compatibility object
hash is non-zero. This setup sequence has two major downsides:

  - We assume that the primary object database is the "files" object
    database and unconditionally downcast it. This will cause us to BUG
    in case a different object database type was used together with a
    compat hash algorithm.

  - We require the object database to already have been initialized when
    configuring the object database. This means that we must intermix
    configuration of the repository and initialization of its
    sub-structures in a weird way.

Refactor the logic so that we instead load the loose object map via the
"loose" backend, which fixes both of the above issues.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c            | 11 +++++------
 loose.h            |  1 +
 odb/source-loose.c |  2 ++
 repository.c       |  2 --
 setup.c            |  5 +++--
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/loose.c b/loose.c
index 9dad75373b..a3b2dcedc2 100644
--- a/loose.c
+++ b/loose.c
@@ -61,7 +61,7 @@ static int insert_loose_map(struct odb_source_loose *loose,
 	return inserted;
 }
 
-static int load_one_loose_object_map(struct odb_source_loose *loose)
+int loose_object_map_load(struct odb_source_loose *loose)
 {
 	struct repository *repo = loose->base.odb->repo;
 	struct strbuf buf = STRBUF_INIT;
@@ -69,6 +69,9 @@ static int load_one_loose_object_map(struct odb_source_loose *loose)
 	FILE *fp;
 	int ret = -1;
 
+	if (!should_use_loose_object_map(repo))
+		return 0;
+
 	if (!loose->map)
 		loose_object_map_init(&loose->map);
 	if (!loose->cache) {
@@ -112,14 +115,10 @@ int repo_read_loose_object_map(struct repository *repo)
 {
 	struct odb_source *source;
 
-	if (!should_use_loose_object_map(repo))
-		return 0;
-
 	odb_prepare_alternates(repo->objects);
-
 	for (source = repo->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (load_one_loose_object_map(files->loose) < 0)
+		if (loose_object_map_load(files->loose) < 0)
 			return -1;
 	}
 
diff --git a/loose.h b/loose.h
index 6c9b3f4571..ed663ac550 100644
--- a/loose.h
+++ b/loose.h
@@ -13,6 +13,7 @@ struct loose_object_map {
 
 void loose_object_map_init(struct loose_object_map **map);
 void loose_object_map_clear(struct loose_object_map **map);
+int loose_object_map_load(struct odb_source_loose *loose);
 int repo_loose_object_map_oid(struct repository *repo,
 			      const struct object_id *src,
 			      const struct git_hash_algo *dest_algo,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 3f7d04a56e..812ca1c138 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -727,5 +727,7 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);
 
+	loose_object_map_load(loose);
+
 	return loose;
 }
diff --git a/repository.c b/repository.c
index 2ef0778846..6d633002b4 100644
--- a/repository.c
+++ b/repository.c
@@ -201,8 +201,6 @@ void repo_set_compat_hash_algo(struct repository *repo MAYBE_UNUSED, uint32_t al
 	if (hash_algo_by_ptr(repo->hash_algo) == algo)
 		BUG("hash_algo and compat_hash_algo match");
 	repo->compat_hash_algo = algo ? &hash_algos[algo] : NULL;
-	if (repo->compat_hash_algo)
-		repo_read_loose_object_map(repo);
 #else
 	if (algo)
 		die(_("compatibility hash algorithm support requires Rust"));
diff --git a/setup.c b/setup.c
index d31808130b..825572f5f1 100644
--- a/setup.c
+++ b/setup.c
@@ -1788,8 +1788,6 @@ int apply_repository_format(struct repository *repo,
 
 	repo->bare_cfg = format->is_bare;
 	repo_set_hash_algo(repo, format->hash_algo);
-	repo->objects = odb_new(repo, object_directory,
-				alternate_object_directories);
 	repo_set_compat_hash_algo(repo, format->compat_hash_algo);
 	repo_set_ref_storage_format(repo,
 				    format->ref_storage_format,
@@ -1805,6 +1803,9 @@ int apply_repository_format(struct repository *repo,
 	repo->repository_format_precious_objects =
 		format->precious_objects;
 
+	repo->objects = odb_new(repo, object_directory,
+				alternate_object_directories);
+
 	free(alternate_object_directories);
 	free(object_directory);
 	return 0;

-- 
2.55.0.679.g6767b8d81c.dirty


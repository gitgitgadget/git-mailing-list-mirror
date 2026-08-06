Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD943B9D95
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002676; cv=none; b=m+KlaMlpLkzePJtBoM8DljJ4TFvkV6FUy5FpldDN7GgZvBMfIqE+lE37xvpPz8L5JlloY1+sl8JtSuzG7bJKbEqlYA2fIpCyEFUSdG1mLjjaycLezltbWXamV0bCzdla0UkOuopRS5aEQ4sdjYJlfacuBJSzOzlZdh1ewQLk/5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002676; c=relaxed/simple;
	bh=3naYBg1LByg3E9Oyop+h7d3uxqZ/s8YhzPwYiyIt7bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apLzWoty1OYXcq9g4Zcx4pPnX4MPStlWaNJTAqwJopEIhIhu+lbjGI2CZ5JZ0RU6oAK/otjic4orb3cQyD+Onnv51qzGAGyTMDxIJ+fLm+JqbtHnVzTHZ4QFwWIN5FRTSEmI1aNHThiCF5EzquVaZ551rvHuUu35xfxQA/Rk0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O7iK4EEE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QI0AXMcI; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O7iK4EEE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QI0AXMcI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60C4C7A009F;
	Thu,  6 Aug 2026 03:51:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 03:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786002674;
	 x=1786089074; bh=cPo/55/wbb7PM3Y8Sbz1kXuBojaUDpnuMPqvcHv5UE4=; b=
	O7iK4EEEDzRxg39Jl7kUYRJ1/3iKT6gl9dhyXBSPX8MxC3NV2tmp6gFTijJmWXVD
	wXa1mIzY9ZXWqtREHR4EcLP1p/LLrl3u5fXQ+bw5srTcok9uJhpc/PVcTz4LmxL0
	dPpU4vG7piEPabR9SVpTlyxnIYPDJeu6qspTcYSVBThGh1FbbGTiN44WVrmtUzo/
	F2YYE3JMj5pIx1cTbegJc1Nt0J2X7at1ApYK2pa4V7csxa0TR7/yjT8eM/Npb8n7
	dmpToWHU97Vo6ItRdFJuhlQZZfby5LFqRNWOW9vSIzij9EAAVWVfQ/tIQ8cE4icG
	dzxLhCd4/G4gPWDc/S4uww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786002674; x=
	1786089074; bh=cPo/55/wbb7PM3Y8Sbz1kXuBojaUDpnuMPqvcHv5UE4=; b=Q
	I0AXMcIVBUcTaAKghYoimsgxuimk8Fr+Hlx4w7VSwghbiRYHOB7UEZcaMjPxuyQG
	upPvo9SnsJnPAtuqjJAhV7A4KgHXT6u+stE3CLVRcJgMgV/OGdPysMpTwHxJKu53
	0zmY+STUHZGd5WQq62BpdP2IpdsgbHwuzE7SVgqhbE+C8uDA+HCgui0y9yM1YIki
	KOirxd0AvchZqzOe4ovaC/sWJmvYht7dR0fNlihDO/KIrwRrluQisvXod5/qBMgI
	WUKDITcpyeE9xK34bhMLo0nhFcU9UX2N9I9cQo+CRiVns46ro3KAtsT1+010oz0p
	MhU96xtC7Pr9w8Btd63Nw==
X-ME-Sender: <xms:8jx0aodtv-Ntx4OyZdH9rF4Ihj_19CmQRtu_HktbiM8juRZzcj4jwg>
    <xme:8jx0ahOti2IQ-eKwHzQCfv3sqmu4Tav5bxjEYaqbyitrFedWxDHcNBJ0GErJ__1ca
    5uzJdafSf3rM036bx4QQwLZ0KDVHu4PhJbtlJPFvDDZ2GEOhooI-g>
X-ME-Received: <xmr:8jx0aujQZejio7M0RCBqGy-_fOsVaAINLYQnrFyNX-Qt8Lz9jJ3tmxWT3bHAPEBo2tQl3V4N_IUd864mT5bBRieZfScgpqdetXU0ocGw8dM>
X-ME-Proxy-Cause: dmFkZTGJiFop5Eo7uUgbFGmEFhj+5nj6icWyraTDQIYOPUKU2fZsPkxCJWcyicJ0UouqvP
    h2OQhoDZCtyJjqI5q8mR0jmJwL8i7rfGe6oQYxSjvf+FqWpojPB8RP52RC3Zop9FrXNOEf
    4MbvEMu2TNdZgrmAtmZaQOpKM5Sa1wKSY2NP/ifHOPJ8fmMFAS7RDet52+61Pr92CddgnB
    wV9xqgUkMHTf5kM94PyIqUU/Ij6MgO+B5w49KfK8y8pKbeabufQ4FkVvQr8b1nCF1awoR3
    /HWjArmpEwRBCCuwbHDnL4nwmozT8bfNNR+phxsj0YP8nC5l+N1VoCeUrYvojSWkmQQnJb
    ErdxkxqRTJRwdr2OCiCkzN1U5bDrl5RvdhEIXKLgzVHYDTcudsoiUmOU2p7aTcYegHBmke
    59VpmLPuAzDG2JBQEaVK5mi8Yg35aQPe+n29Ho5pALvx6wx4EUrCGFZMArZDLIMqQvHQYW
    4Iyr8k3LJTj1Sz1vZNqqh9vIpWHZWWH0wW0IbK2XpSF/9+D+Wy9gdEdxdNBkgCJGfEnYml
    ruXhzJacUyZD+vuoe9ZvTd7Rxn0PNVz1EKjoyE/jyccYXBXKD/FJNx9r09ksGPniqkY+/E
    m98fJE3JuJztfApL1S7cK2Yif5nTinF1e29AsobG9sjD9HibkhnXLLQzQoqA
X-ME-Proxy: <xmx:8jx0as1wCgzVJndyJrGe28N7ZxHhtp20OGUlZLUoPOhKcmt1MS8UAQ>
    <xmx:8jx0aghrB_KhLgqj9PwWqQDq-iDR3CjDZs9jV9XMwk1LL28-T-IfnQ>
    <xmx:8jx0akcQSKEqdtxnhpa1rW9RK-u1SYElWX6yTEdisPL-Zj4BmcjYkA>
    <xmx:8jx0arnLrYWDyqhRjwsy5Yc9X796Mrp_ry9azb_qS4DRBNQUAToFhw>
    <xmx:8jx0aii1eY-cJDr8MRQ-Ffw0tuBppQ3F-lhWlwGudgY428WGLpbGBOYh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 03:51:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb79f234 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 07:51:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Aug 2026 09:51:00 +0200
Subject: [PATCH v4 2/6] setup: detangle loading of loose object maps
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-pks-odb-create-on-disk-v4-2-ba8b4fdd2e3c@pks.im>
References: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
In-Reply-To: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
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


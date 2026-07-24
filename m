Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226362DAFAA
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864948; cv=none; b=Gh8ICyOjk2tRt8vH29/KaNgKlZz1Cu9SQ/s08JbyfGyiU0MmBxgBNkS/YUuIhJITVXMpAFHgdy9ojRDQJJx5e9l221Ak5t0OisG9Lv0Tol2XLPDgDTa3Bor/klvHxb0TElX+8lob2u1kpFB17PbEcgiKLyDIpMe2o0gCbj7ISUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864948; c=relaxed/simple;
	bh=QIHSiWocow5QpbsE5eUPtlATdaNRZjsu0ZDNGyvZq7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hM0ahH6m1u3VpPbbh7m9N8te5Cr2LCQ9qaJP07xAuB5sxHVwnLtZNUgbhBad89z2+Vi8BxcxdvmdDrsHy48kOvNF25Jv3jI1U7amWUzPq85EiQ4DoMKw/zvKLKTo/wv3V5xw9klIfWfWrDOU7OxKN63wiEe0Hn3ZNN3OG+oYIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GNs+/R7L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=knBkCjSH; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GNs+/R7L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="knBkCjSH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 58B5D1D0041F
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 23:49:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 23 Jul 2026 23:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784864946;
	 x=1784951346; bh=zH23R8jATqM0KWpmrG+BTONZq1NDMpbfgbdxEvIp/rM=; b=
	GNs+/R7LzuMmXaK7kBNGg7hzdfT2WI32n5GmC1Wa9vCpcz6AnViFzMqph7JxdRBu
	25nMHe6Cg1nPPBJeFgpv64H4xkwVVT3uv3IxeQyXE5E65SeaLik9U83JLv+JCmhy
	3jlTbwqK2KTsow4/SiAAySN3ydP3/KY9UXiM6QsQHs7IaQSsp1qWRIuOvYByHqIz
	RsZBjfMgseXmteHJZI+w4EyGhLb8MyIABYZx2KXVKAyhGLjTllXykQ39z5pcIBjA
	84MXj0nnM1i4fzuajKw4msgsiJzPSUO6ZIIl5u03lUT4gjsvW+thCm2Bo/ijnpOB
	9axWVlHKS87i9rLgqu/ibg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784864946; x=
	1784951346; bh=zH23R8jATqM0KWpmrG+BTONZq1NDMpbfgbdxEvIp/rM=; b=k
	nBkCjSHnEnSyJVZ3nXocCiKbLEIumhEs6yDLbWUk2s3LsU4awdDu9/D5WxoAt8qt
	PH0/pInA/jpaRpf/xaSpr8TZe7AtWswTiuDyt1Uog/R/Drn2ZqwC2OHhz/iLizgM
	ECDHgXRICeC8cLsi41yT+UN8mv6k5wrAOShawLAaFUyyZHqtD1X2FB57IXRcsGJZ
	BRKQdEhZmg/EV/iCGIIhtu+3yQ7+ONyr7NayDnEFDthUpPy6//7cM3lMWHVwE4wl
	QscgQAEMsDFpqRsqXerRhyjR/Rftxy2xbTsKpIlrDIAxKk1aY/hyFXDuy/x8q+AL
	LbkqkyvqA/cm/8L2hFWKA==
X-ME-Sender: <xms:suBiaptXAi4IMVGczGTGVwQsH-5KsqR-pW-Bes3Jnl1JCWMdiMcINw>
    <xme:suBiapajOIX6icjeMmziRGKkyiBSiETjIBZs5TNcHoNk_Jxxvd-2L1g98JmmTczdI
    yMbZmkDnegdnYrVtxw7vYTsmx6_aQP1aZoFzG1h9_Qlq-qLQgYYbg>
X-ME-Received: <xmr:suBiaibWgPp7UMdYdTkIri617LXIrYokqBsQcyp8l9KckCkZg5_GYo9wBhd7rhHcRhSuiuYE9F2aowHHixfrrkeB8zhvXq4ZXqNlG0WeuHg>
X-ME-Proxy-Cause: dmFkZTGsA7YOejt2deRbD0qRO7BTn1ESxOOsCG4Sh3Klkpquyv+B5/ZDpPA7rcVYiMYDcT
    kCh2Erp2PQ1lDgLUAUhPkgxrgeyBboGotfYvjqdvKL3QOziy0obOZCEb8UcNeorntwDaMq
    7cu8qp+kgR8MeIwhilP3trcWOMHOy7tOoDRiXe+ovhp7uoUyfHvqnoOVjxwP8jVrhi7LLE
    5H7zxTH5TfwS2scWzeZNfkVqF/pq8XIfpND2rVDeDES3SDvMEzkE+cNvsDGeTVRgXChJ1F
    pX66cp1VPSua5kfePO7q4C45VqUpEPSkmNcprCUf1azSM8kU7h9LFbPPkZPe1jrJdX6lYI
    ogo6wpovTe0RdK4ZOFEYAMDypZrRjDl1tUaaC6QxBv2TBvvHo/PfpAj8a3Xh5Bb2W0zW5g
    7a482FlGd+Q12RKwM9mq/9IqR7tZbNL/egrI6vZd+P5UeAhtdjNvbNH53S1crD7gVJ7V8O
    2gInSfFK49gm4vqnpBnlOfdV0rnzdrrBvAKvsc1/XniA5NiVCzRHVTXmxjES8AacLv7AjT
    ZNmA/OagQ77hIqscVBJzV1DowpF2tZmJg7RAKHs6j6gv70OtcmK4tMUrIBTgyj/yBJIEev
    kD8RJcXmpqAxCsDjGNMNXolZcgwQvb8hNiPKWx3laEVnU3qcczH4/gYzXI3g
X-ME-Proxy: <xmx:suBialXTvjDxDeY_riZui-6vA-O0OhDBWbIsEeAqiiBAJG83JfraMw>
    <xmx:suBiap1On1xd0nvQI1E92a8QGkE_BmA9K-YPwulzrCdlVwAoHIQmuA>
    <xmx:suBiasZz3PBAlGRiDxeLDWnDHB-BNiLy0f_MH-LBlZ2unOAzO7Cqiw>
    <xmx:suBiaso4aBtEFgBTOkr4qDmJ0KviGm7U0aTk5KXCEMVqC60VjmNjDQ>
    <xmx:suBiageikuLNtWvbAytQB-k9E1ejK7KJTF_09qtuk38dJTiU37buQ_m3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 Jul 2026 23:49:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f74bce98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Jul 2026 03:49:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Jul 2026 05:48:41 +0200
Subject: [PATCH 2/5] setup: detangle loading of loose object maps
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-pks-odb-create-on-disk-v1-2-3b3d265d979b@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When a repository is configured to use a compatibility hash function
then we load the loose object map when we initialize the repository.
This object map provides the mappings between the canonical object hash
and the compatibility object hash.

Loading the object map happens in `repo_set_compat_hash_algo()`, which
calls `repo_read_loose_object_map()` in case the compatibility object
hash is non-zero. This setup sequence has two major downsides:

  - We assume that the primary object database is the "files" object
    database so that we can extract its "loose" backend. This stops
    working with pluggable object databases.

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
2.55.0.407.g700c83d4f3.dirty


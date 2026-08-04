Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334BD43C051
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832206; cv=none; b=TrZRC/FVlDm3VVoWO1BPIGAT/rsQdzVz0EBijpQU7yff4kHmuHUrRkvn6R+nK8IPeX3UzIRyR6HRpbiELfqijJu9w1fArPS9LWX1zDCEWCLvIpIKSrNxp10xiC/qdNlTJMtepCftx/uviLIBIdXiF8YG59oVO1nusQJmbUuyZX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832206; c=relaxed/simple;
	bh=3naYBg1LByg3E9Oyop+h7d3uxqZ/s8YhzPwYiyIt7bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIyp3oBV9wMOQMNdb++jX1SfXT8x/5euqkrmHWfCjKenlY8ppSRdbIRGuMevxlAXIBeMF6YGjlsshRhIDlKunFLR7nLMR7q9b/i0Jx+bmtpgluecrF/kYWjCTVYCgPkmMPIUVE8bl1vmhSwif2AN+cFKSCqNLG+ahQobq0kwtM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M43eoAND; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G213U1Ol; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M43eoAND";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G213U1Ol"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D4C87A0129;
	Tue,  4 Aug 2026 04:30:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 04:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785832202;
	 x=1785918602; bh=cPo/55/wbb7PM3Y8Sbz1kXuBojaUDpnuMPqvcHv5UE4=; b=
	M43eoANDnHOsEV5O2Z6dlXvKKm2yZHrjmr3sXAXjHTAjo9oaritj9JafDfmZCPhn
	0SGsvQs/Ytdy4pGTkB45N1N5is+0ltXUMYBkYEU0RQGsICrvA102rDtTXRc37Ij0
	/7lMmbGJMmdXue3f1PqAhTjJpNETh4D/3j6e5sU98eTIl8BxgMipZZ61yYKI6b+4
	6XF+8YzCq2rIRD2rkrXoZdAKoOKWoy7W62utgfWnJ9F5eNKfr8x1jChtrDmizwx8
	0Ar4opL4JQo1NFULq1NBsBOxS/uqDp3CuFuXngLlaY1VHGYoomkICIkK3dCdLsnB
	k4yhu4UVXxMkmZcFqD8uVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785832202; x=
	1785918602; bh=cPo/55/wbb7PM3Y8Sbz1kXuBojaUDpnuMPqvcHv5UE4=; b=G
	213U1OlGfMv0cDaB9XQdlg2cvMpEhkFtNCpfI47koK6A7XqY6WLXZrzIPwuEpWC2
	Lvuav8S/SJzBzTHJZUs3g92tl2zXwyVx+n7fcgu0yBzqIH3eb/ohbuq/ej6+ioFS
	NnLoR2xpgIq8ZjNyb/kTadM5KyhLMUKz27uLI2rBcd7mS0vkNa5OMtwwZJb91VQv
	ihA3Q4PsFP0RIG22N3RGOUq1jBo8TD1ZG/e1oMh0xUJu5ABw0o4hZKbk/W6fCBlI
	LzolsVFWEvo7nnZHmq+DjYzxnqPRbM5zicLDklQzQiziIMIiTKKFEz9KdkxU5wy3
	YBzWZwoFZI1An3VYa/sHg==
X-ME-Sender: <xms:CqNxarAQztCQvblMtPxEjPundF4i5TYA2wiQ2hXKLs8ZXb9yNhA2Lg>
    <xme:CqNxaoj7KXD2ghq_fCFimeeIhbdySbjbkk5E8RcnnDT39rr3SWLWHi1jnkh6ewMqL
    q0jNoi2A0viNSx93pXiRSrNsk7kGvmxP4DZz_NNQqu9bKmc18N-NTE>
X-ME-Received: <xmr:CqNxarlWJrmbDBvMJJq9lPcAMukBQqqLayBovE6B91UraT8sCg0Tk0B-bRtMYFNi5-8viDyrDlIJ9lGi4u3f2rXi1r1u8LQQG0EVafK7>
X-ME-Proxy-Cause: dmFkZTEbgtzG3LVU36iLnTJFOTKaJnVb3Xpa8gL5U4HxfIGy3b8t4xIrlpDR2DpqRIZvzf
    n1NI56hVabElJrPx6MSMtz1cn1wl+/2e6XDDCQz5bBcc7tZPYbMw6N04VMFOLBi2SKlZCi
    bIg2EyW+/zEy6CTrZbhGwQc/+oDHdUmiW5xr3HKqR+v9ls9TXLukerfdzTR0S7RkaDq84C
    Pr7XwrqTs0UBCsvWclzxevhVY9QLcuIyCKGZfoFXEvWt3uFBZ852qzUxPP9qmgChakaEfl
    TykiJDiQj60J06EdA2jtQ7uStMrFkhicj42WfaCa9v3sW7CnzNa4vaxT9e6yFwS4In4JHc
    tbuOPJQAQKmC/T6QeLfQ0V1DADsKmeVyTvfU5C1IKfjUIdImEPc2o/4yD7JEUIfE6a7M6A
    vuoZjWvQRAI2y0GgyL9bh/5cpyM/BAgKwutf44krvjWQ0z0aG7zGcBydPWj4M0BmYhTRM0
    NBu6j/J1zAA/UmiDWmoXm48301kpcabJGCJYWjxvOqiQLnqPH9EFpkYQSBLW3dsOEO7E4g
    niCtr6KNM3q3WCAOTXZSXM+neJJ0iUgoAuUGtalfOE+o43LFa9SxhHb0Tzncn3SVfUVHqw
    VtiTxM4z7S+fY5Nk+iV1XVcoVviO5+uaWZVpAAo9SM1xg6QfyII1nFyqDnHw
X-ME-Proxy: <xmx:CqNxasow6YC7dUWCPZcXLVJXG34gL8WUpmpC-sWQnvN7vjYoJO67hg>
    <xmx:CqNxasF3mDjhkCefgNtk9IT7zq3FWN2Rs48TLF1bxcEULN2Mtp2F8g>
    <xmx:CqNxagyxBCf5t8IXcdorKgRTaBoWh2RtVgCL7mZUaArVUcj--Lp7bw>
    <xmx:CqNxapo9C_uUGRDdJrCI2wt8rdI_kJB1FdmUigMGCl_4AlKGR_NVfg>
    <xmx:CqNxamkNzsYz1dFNji5SHK9CBa_Q5lNUg4ZGP0S2YKZENZ70-H-rI-eH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 04:30:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 82611a01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 08:29:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 04 Aug 2026 10:29:07 +0200
Subject: [PATCH v2 2/5] setup: detangle loading of loose object maps
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-pks-odb-create-on-disk-v2-2-ddf8b59bd207@pks.im>
References: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
In-Reply-To: <20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im>
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


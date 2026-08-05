Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE503EAC84
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922146; cv=none; b=hgiygcB2fmQgFkA92ZiVeGC76Si/pwoWmsf7mqXSHj5a2vFje65dOAIIY80+kOrnBG0DvBszX50FrALVTOQVFTuYdCAK52UdrGg3GmundiRMu+FnPFNoJUuSoKITUgXkfHiiDV7QbgAD2v0I7bahTovSzutPpCbMdd2c443qaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922146; c=relaxed/simple;
	bh=3naYBg1LByg3E9Oyop+h7d3uxqZ/s8YhzPwYiyIt7bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmON5V1+XoC05JFJcARFtHPB1doPFGnx4zEFatj9UszMrkD/2DQ58WHu0SdcsjQgUr1lZ02OCQKayYh/mvHXz0Qgdr9l/iuL8uW27xi7KCqtL81QJovGry9LKJfhkFIPcp6aTCJd/tImtmChG/PyUl2G5j2mpLadKB4T9VVRKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OxWcpkw6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ABv34OPu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OxWcpkw6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ABv34OPu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 27E3CEC01F2;
	Wed,  5 Aug 2026 05:29:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Aug 2026 05:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785922144;
	 x=1786008544; bh=cPo/55/wbb7PM3Y8Sbz1kXuBojaUDpnuMPqvcHv5UE4=; b=
	OxWcpkw6xu915VucT1GJ9FQ7SAsN/rHtDLCHSyZC6wFqI2PQEhKH6+WXXIwDJ6Uh
	ysvhk4ie+NeCbSicMgbcNJIoR7gXJJu1E1D4Z/PaMFQjvtKOWK65I1JXZCzSNuyy
	/suoo+tstrjqOLxAJm43WS+iDHvJMw+VSF+Cwv5aBmHnENWZCA+4IwP1CC9QQX1+
	Xq4rFoEymp94izxuYxgN6N6393KVZPjzFJ2l/lKqXpxJORQsyv7VEgwNj63DhjFU
	tPm9T0s9MvIIpMvO6RVfb+zJkvtBW7d1Wxkw45Fn5wBTDkQYack/4XsBHYYiripp
	cYCxVNdGcSJYZPxJp+FIxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785922144; x=
	1786008544; bh=cPo/55/wbb7PM3Y8Sbz1kXuBojaUDpnuMPqvcHv5UE4=; b=A
	Bv34OPumrFonuLCSHzUq7MxycIl9wxOiUgb9fR+H1vUyCnMjZymYVs7P4Om20PDR
	J8jnd8IFGcwsl2QcI4eeMAW5W/dO0GvFcULBtCkCZh+3Wp8uMUrl0p4MgMO2Z79Z
	Cb3Dw/MetYXMB4koEaYumn3sebGEpLkTQcXrwTeA/qFETgfZMUOjb7sLs0oEGYgP
	OaetKLhGZ+lPeqNqLg2Un0n/vHSytBffZg/HEj8hzFSkOf3egDjOs72OzqQCwzoK
	7hsVM4al6a3fC+6cp9OfTmoKEZ5Yqwl9e7x7l9Xd+aYwBAh8z8YW9+S3fy5NcBaZ
	g6sF1ekUlr1RVFPRtj3+w==
X-ME-Sender: <xms:YAJzaogSuO1KKTyi32W8ddfk2dyEluo9EQx7DqfxE6woCPArqPMzzg>
    <xme:YAJzaoDUlACpHCGbsUD0lp8-Td5Eahj_wxPWhh81TkNYz14TZXWoSD309sv97H2YY
    XBwHWEDQlvr0mPIZu53jy-PN56SPYZNDpQksUNYZ0Cvdqg0XSs>
X-ME-Received: <xmr:YAJzalGIM0qOh0maD4XAyGydzYknwxOzEWcL7v9iYMlUFG7x4yZUNeRud9OAZqbEipKGiKlQ2ag45_AEgp1UvUu3QjzDilFLaD5JycV5Qw>
X-ME-Proxy-Cause: dmFkZTE5Dc+FfrkisQb5rMhIjfBUYY8IRmEIZbSHMIBCABfvXnlXkOrU1VS+slHYecbhva
    5cGzxC/sQgy9Vz3FCqlDrmr90sB0MBIjRQW4B01+jInGMY3hkKMWYT8AO32aK9LBDWSxp7
    7J/h2G6M6iDGTSXYhiyH9Sc9tI2/go8XhzV8FhB4dCpKYFlwu/YQwj/scjj16Vdj61fe+j
    Bfrq/H5dtAxkFRo15/QJtb6HHq1OePWLklNpi0SOqNLZdIN7eP75dQ1+cOJVL1pLFQZU4q
    fTnZRNSSZQMNfr/Ccca/e+kdjpbhctrCId47g1xfD27q93xd8roq+cBb6lyuj0nsmmq3PD
    ST8kWzFdGrJzdslwyl3TWDUN9t+TKtL/+cmb04EPaMEu+416JuyVwTPzKTCONpBiRZZ/b5
    mcQPk4Gdj758uNXf/+4g6etCCh5C9yGCh66KkTno0xGy/XCaXh+HkHs/dckBhO0dhh51DS
    chw6cwvSo6rYbgyZtXsII2q6qkVENh6aPwObYPHk0NQp7QY7ypbKoqKfa4r+pJuWEafR7Y
    ZoKtgYaw7Rn/YHbb1mwlZK2pl4UkLrPPnucm4mM+pGerzc6FY3oZoyaj4ECJvQ3ot7AKXX
    PdREnptHNdb5MgDTdAI7HcyJr5PckGtRJcFSF5VQynllXMnka4iBdnaZLe7w
X-ME-Proxy: <xmx:YAJzaoLeNaYAdZ0-z9N-GSTEyz6In43Xi3wvK87XqyQsI2BBPdfVQw>
    <xmx:YAJzahm_8bPwWmEFEqmTiwt1rwSUhWsKsIbEUnH1Kgc4ojZ2ta0k4A>
    <xmx:YAJzaoQhQfflvlg-QBjry4L_saGTe3dZrCWJvK79-UiLacYJLjzWqg>
    <xmx:YAJzarLwcrBY6gTfOtBnx7gvE4MUkMi7JzTiImnRwhBtQyAXxJgpdA>
    <xmx:YAJzaoGZ6akuFR5TgOV_maBqjIxHBqZJuSSh6_NYTUNNAp5nM4FRDPH2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:29:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4cdc6fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:29:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 11:28:52 +0200
Subject: [PATCH v3 2/6] setup: detangle loading of loose object maps
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-create-on-disk-v3-2-c0ee3ac5141f@pks.im>
References: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
In-Reply-To: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
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


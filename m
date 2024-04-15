Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B5612E1
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181362; cv=none; b=qiMiuZZrSDKSVt9u5Ym19sp6icyyNM2I7QMIBWO2KzMEOVYWlXVqZR7XMPmEPyq9gSxDpsHEULGDJPQfzEvCG4ehisVFYLnpjigpbGVVNZzUWPxdCZmBplFjTzogHIlcXC4oGbkirN9U+5C7Awzl6ufTdW33IND22i9J1+Ds1tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181362; c=relaxed/simple;
	bh=Gj05gnS6U53cnk/s9hrCw1cbBEm1BKyc7bzPADimSp0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nU0NR4PBqopmmUUAUM0lRU5uq24pBRYeLtWNdSv2yC38Rd7UaJ6a8dOA0/POmjRGuMmoVLofEj2nuWFDHCPbGEYtIV686iymlplAeXQbZhoZdHZJEUF6SixU2MNk6XjEpaislxjJVL9eNhC1zwmoJTffGBMYRsy0nXgtwihJcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VoFyh122; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nCOPg5uU; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VoFyh122";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nCOPg5uU"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6A34F138082A
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 07:42:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Apr 2024 07:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713181359; x=1713267759; bh=UmvSZ+Htnj
	56lHSUhgIGloI820RuTj+sljm8zZJIZPI=; b=VoFyh122qq84zFy6u2yuFqXt1L
	vdwe9EwjZDGEr/I8BwrzVc8XXKpNmxC5LZdFs6o2NFxZdf83ItGYCPiVWHy/QIUG
	4FnlkfjxtXfV5Dz9piTp0APBbvonVUwzAi9Qx/leOY6mnNysrW9PXoP1ZAdP5M7x
	+A+eAfMV4nEsrZVg8SdB8M95d51dFdqf88QaQHRDDrArTPbwjTTit3v8emaCW4Bl
	b6DN870hepBJxsqe2Mi3nrHN6hNO2kD1YVFaOb5DNcJ5iCEsxRvAWg5skh8PGeBe
	fABhPvmRlJFwZ+jLPwm/cZvsza3sV0hNdiAkAWyp8P21Y6J1i+0LH9pxIlcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713181359; x=1713267759; bh=UmvSZ+Htnj56lHSUhgIGloI820Ru
	Tj+sljm8zZJIZPI=; b=nCOPg5uUPieUSHXhwVwNm7kJ2L6batI0IM6bsyMteOIh
	e7ZTp9OF1CKapLwWzfKJcAhL0bLQyfKuKRtfv5oSPEu2EkilhQAjs6cEWhMxOXGL
	mBC166EN8tGeWGLbho9mXIgUorKj+qiqz6Ks/jRN1ozsxILwXVfK9lfDKf9OHOdk
	Wap9lertbJZW2+qBHkMB0kZPNz3mw+vMlyZs5wCi7Zhtjn7iQj14yu5jnZlHQIDe
	dXpGOCsiXSa7b+Wci9MvoNqHlvJD6O24+dvACHbfwH1SkImObStX46R/zGttTXUH
	x2bUeqs2Ga8IU5ygyetuuh68MnVZRc055+Dg5nW5nw==
X-ME-Sender: <xms:rxIdZoYB537zWiMcHrt8_-lElYDfe6w7r05NJZHulKB36k-Tc-Odgw>
    <xme:rxIdZjYmOHfzsgztiKx8kfuYPSIUcphv2XtKjLkiEQMU5t1pZyrkp9G7wXb3MarhJ
    j5yJH6UVhcF4LWrZg>
X-ME-Received: <xmr:rxIdZi8hZTp6upLFHIjitgNmzV2bfSPeWVH0wqFtuRVE_lY7OcTpaup5dlkyAGId6MdAq3F1QULv8Iv9yWh55bvvGw3JmuYDP5rnLGnYdb6QA-dpHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:rxIdZirHFle6cFZk02tbq4Seb0sWxHfqGW6SSB86zxT91m8k91jvjQ>
    <xmx:rxIdZjpNns7OQWXWXLjRxJxN-53AqwNW3q2dpJH-viWl-yDLXZJYrA>
    <xmx:rxIdZgSaJzGfpt34gwljImWlnGKeba6pFIRXe7qwGyKBtwB7jtaIrg>
    <xmx:rxIdZjq9iWgfT1XvMyvv4GwP40fa-xtQXbcIrhqP1vqDPfWB-ajPJg>
    <xmx:rxIdZsDNC1pk0oZL1X6i4dFgBwBOp3DfeXvgXueBDnuCmo00iZnE8jcg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 15 Apr 2024 07:42:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 43d80e1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 15 Apr 2024 11:42:18 +0000 (UTC)
Date: Mon, 15 Apr 2024 13:42:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/5] t/helper: stop using `the_index`
Message-ID: <7b5ec04efc89af6874461d967bf5f61939e054dd.1713180749.git.ps@pks.im>
References: <cover.1713180749.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tseibBTtE6MFLISF"
Content-Disposition: inline
In-Reply-To: <cover.1713180749.git.ps@pks.im>


--tseibBTtE6MFLISF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert test-helper tools to use `the_repository->index` instead of
`the_index`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-cache-tree.c           | 17 ++++++------
 t/helper/test-dump-cache-tree.c      |  5 ++--
 t/helper/test-dump-split-index.c     | 11 ++++----
 t/helper/test-dump-untracked-cache.c |  3 +--
 t/helper/test-lazy-init-name-hash.c  | 39 ++++++++++++++--------------
 t/helper/test-read-cache.c           |  9 +++----
 t/helper/test-scrap-cache-tree.c     |  7 +++--
 t/helper/test-write-cache.c          |  3 +--
 8 files changed, 43 insertions(+), 51 deletions(-)

diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index e7236392c8..dc89ecfd71 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "gettext.h"
 #include "hex.h"
@@ -38,29 +37,29 @@ int cmd__cache_tree(int argc, const char **argv)
 	if (repo_read_index(the_repository) < 0)
 		die(_("unable to read index file"));
=20
-	oidcpy(&oid, &the_index.cache_tree->oid);
+	oidcpy(&oid, &the_repository->index->cache_tree->oid);
 	tree =3D parse_tree_indirect(&oid);
 	if (!tree)
 		die(_("not a tree object: %s"), oid_to_hex(&oid));
=20
 	if (empty) {
 		/* clear the cache tree & allocate a new one */
-		cache_tree_free(&the_index.cache_tree);
-		the_index.cache_tree =3D cache_tree();
+		cache_tree_free(&the_repository->index->cache_tree);
+		the_repository->index->cache_tree =3D cache_tree();
 	} else if (invalidate_qty) {
 		/* invalidate the specified number of unique paths */
-		float f_interval =3D (float)the_index.cache_nr / invalidate_qty;
+		float f_interval =3D (float)the_repository->index->cache_nr / invalidate=
_qty;
 		int interval =3D f_interval < 1.0 ? 1 : (int)f_interval;
-		for (i =3D 0; i < invalidate_qty && i * interval < the_index.cache_nr; i=
++)
-			cache_tree_invalidate_path(&the_index, the_index.cache[i * interval]->n=
ame);
+		for (i =3D 0; i < invalidate_qty && i * interval < the_repository->index=
->cache_nr; i++)
+			cache_tree_invalidate_path(the_repository->index, the_repository->index=
->cache[i * interval]->name);
 	}
=20
 	if (argc !=3D 1)
 		usage_with_options(test_cache_tree_usage, options);
 	else if (!strcmp(argv[0], "prime"))
-		prime_cache_tree(the_repository, &the_index, tree);
+		prime_cache_tree(the_repository, the_repository->index, tree);
 	else if (!strcmp(argv[0], "update"))
-		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
+		cache_tree_update(the_repository->index, WRITE_TREE_SILENT | WRITE_TREE_=
REPAIR);
 	/* use "control" subcommand to specify no-op */
 	else if (!!strcmp(argv[0], "control"))
 		die(_("Unhandled subcommand '%s'"), argv[0]);
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tre=
e.c
index c38f546e4f..02b0b46c3f 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "hash.h"
 #include "hex.h"
@@ -68,10 +67,10 @@ int cmd__dump_cache_tree(int ac UNUSED, const char **av=
 UNUSED)
 	setup_git_directory();
 	if (repo_read_index(the_repository) < 0)
 		die("unable to read index file");
-	istate =3D the_index;
+	istate =3D *the_repository->index;
 	istate.cache_tree =3D another;
 	cache_tree_update(&istate, WRITE_TREE_DRY_RUN);
-	ret =3D dump_cache_tree(the_index.cache_tree, another, "");
+	ret =3D dump_cache_tree(the_repository->index->cache_tree, another, "");
 	cache_tree_free(&another);
=20
 	return ret;
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-in=
dex.c
index f29d18ef94..f472691a3c 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "hex.h"
 #include "read-cache-ll.h"
@@ -19,16 +18,16 @@ int cmd__dump_split_index(int ac UNUSED, const char **a=
v)
=20
 	setup_git_directory();
=20
-	do_read_index(&the_index, av[1], 1);
-	printf("own %s\n", oid_to_hex(&the_index.oid));
-	si =3D the_index.split_index;
+	do_read_index(the_repository->index, av[1], 1);
+	printf("own %s\n", oid_to_hex(&the_repository->index->oid));
+	si =3D the_repository->index->split_index;
 	if (!si) {
 		printf("not a split index\n");
 		return 0;
 	}
 	printf("base %s\n", oid_to_hex(&si->base_oid));
-	for (i =3D 0; i < the_index.cache_nr; i++) {
-		struct cache_entry *ce =3D the_index.cache[i];
+	for (i =3D 0; i < the_repository->index->cache_nr; i++) {
+		struct cache_entry *ce =3D the_repository->index->cache[i];
 		printf("%06o %s %d\t%s\n", ce->ce_mode,
 		       oid_to_hex(&ce->oid), ce_stage(ce), ce->name);
 	}
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untr=
acked-cache.c
index b4af9712fe..9ff67c3967 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "dir.h"
 #include "hex.h"
@@ -56,7 +55,7 @@ int cmd__dump_untracked_cache(int ac UNUSED, const char *=
*av UNUSED)
 	setup_git_directory();
 	if (repo_read_index(the_repository) < 0)
 		die("unable to read index file");
-	uc =3D the_index.untracked;
+	uc =3D the_repository->index->untracked;
 	if (!uc) {
 		printf("no untracked cache\n");
 		return 0;
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-=
name-hash.c
index 187a115d57..5f33bb7b8f 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "environment.h"
 #include "name-hash.h"
@@ -40,22 +39,22 @@ static void dump_run(void)
=20
 	repo_read_index(the_repository);
 	if (single) {
-		test_lazy_init_name_hash(&the_index, 0);
+		test_lazy_init_name_hash(the_repository->index, 0);
 	} else {
-		int nr_threads_used =3D test_lazy_init_name_hash(&the_index, 1);
+		int nr_threads_used =3D test_lazy_init_name_hash(the_repository->index, =
1);
 		if (!nr_threads_used)
 			die("non-threaded code path used");
 	}
=20
-	hashmap_for_each_entry(&the_index.dir_hash, &iter_dir, dir,
+	hashmap_for_each_entry(&the_repository->index->dir_hash, &iter_dir, dir,
 				ent /* member name */)
 		printf("dir %08x %7d %s\n", dir->ent.hash, dir->nr, dir->name);
=20
-	hashmap_for_each_entry(&the_index.name_hash, &iter_cache, ce,
+	hashmap_for_each_entry(&the_repository->index->name_hash, &iter_cache, ce,
 				ent /* member name */)
 		printf("name %08x %s\n", ce->ent.hash, ce->name);
=20
-	discard_index(&the_index);
+	discard_index(the_repository->index);
 }
=20
 /*
@@ -74,7 +73,7 @@ static uint64_t time_runs(int try_threaded)
 		t0 =3D getnanotime();
 		repo_read_index(the_repository);
 		t1 =3D getnanotime();
-		nr_threads_used =3D test_lazy_init_name_hash(&the_index, try_threaded);
+		nr_threads_used =3D test_lazy_init_name_hash(the_repository->index, try_=
threaded);
 		t2 =3D getnanotime();
=20
 		sum +=3D (t2 - t1);
@@ -86,16 +85,16 @@ static uint64_t time_runs(int try_threaded)
 			printf("%f %f %d multi %d\n",
 				   ((double)(t1 - t0))/1000000000,
 				   ((double)(t2 - t1))/1000000000,
-				   the_index.cache_nr,
+				   the_repository->index->cache_nr,
 				   nr_threads_used);
 		else
 			printf("%f %f %d single\n",
 				   ((double)(t1 - t0))/1000000000,
 				   ((double)(t2 - t1))/1000000000,
-				   the_index.cache_nr);
+				   the_repository->index->cache_nr);
 		fflush(stdout);
=20
-		discard_index(&the_index);
+		discard_index(the_repository->index);
 	}
=20
 	avg =3D sum / count;
@@ -120,8 +119,8 @@ static void analyze_run(void)
 	int nr;
=20
 	repo_read_index(the_repository);
-	cache_nr_limit =3D the_index.cache_nr;
-	discard_index(&the_index);
+	cache_nr_limit =3D the_repository->index->cache_nr;
+	discard_index(the_repository->index);
=20
 	nr =3D analyze;
 	while (1) {
@@ -135,22 +134,22 @@ static void analyze_run(void)
=20
 		for (i =3D 0; i < count; i++) {
 			repo_read_index(the_repository);
-			the_index.cache_nr =3D nr; /* cheap truncate of index */
+			the_repository->index->cache_nr =3D nr; /* cheap truncate of index */
 			t1s =3D getnanotime();
-			test_lazy_init_name_hash(&the_index, 0);
+			test_lazy_init_name_hash(the_repository->index, 0);
 			t2s =3D getnanotime();
 			sum_single +=3D (t2s - t1s);
-			the_index.cache_nr =3D cache_nr_limit;
-			discard_index(&the_index);
+			the_repository->index->cache_nr =3D cache_nr_limit;
+			discard_index(the_repository->index);
=20
 			repo_read_index(the_repository);
-			the_index.cache_nr =3D nr; /* cheap truncate of index */
+			the_repository->index->cache_nr =3D nr; /* cheap truncate of index */
 			t1m =3D getnanotime();
-			nr_threads_used =3D test_lazy_init_name_hash(&the_index, 1);
+			nr_threads_used =3D test_lazy_init_name_hash(the_repository->index, 1);
 			t2m =3D getnanotime();
 			sum_multi +=3D (t2m - t1m);
-			the_index.cache_nr =3D cache_nr_limit;
-			discard_index(&the_index);
+			the_repository->index->cache_nr =3D cache_nr_limit;
+			discard_index(the_repository->index);
=20
 			if (!nr_threads_used)
 				printf("    [size %8d] [single %f]   non-threaded code path used\n",
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 1acd362346..458efa88a6 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "config.h"
 #include "read-cache-ll.h"
@@ -27,16 +26,16 @@ int cmd__read_cache(int argc, const char **argv)
 		if (name) {
 			int pos;
=20
-			refresh_index(&the_index, REFRESH_QUIET,
+			refresh_index(the_repository->index, REFRESH_QUIET,
 				      NULL, NULL, NULL);
-			pos =3D index_name_pos(&the_index, name, strlen(name));
+			pos =3D index_name_pos(the_repository->index, name, strlen(name));
 			if (pos < 0)
 				die("%s not in index", name);
 			printf("%s is%s up to date\n", name,
-			       ce_uptodate(the_index.cache[pos]) ? "" : " not");
+			       ce_uptodate(the_repository->index->cache[pos]) ? "" : " not");
 			write_file(name, "%d\n", i);
 		}
-		discard_index(&the_index);
+		discard_index(the_repository->index);
 	}
 	return 0;
 }
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-t=
ree.c
index 0a816a96e2..737cbe475b 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "lockfile.h"
 #include "read-cache-ll.h"
@@ -15,9 +14,9 @@ int cmd__scrap_cache_tree(int ac UNUSED, const char **av =
UNUSED)
 	repo_hold_locked_index(the_repository, &index_lock, LOCK_DIE_ON_ERROR);
 	if (repo_read_index(the_repository) < 0)
 		die("unable to read index file");
-	cache_tree_free(&the_index.cache_tree);
-	the_index.cache_tree =3D NULL;
-	if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
+	cache_tree_free(&the_repository->index->cache_tree);
+	the_repository->index->cache_tree =3D NULL;
+	if (write_locked_index(the_repository->index, &index_lock, COMMIT_LOCK))
 		die("unable to write index file");
 	return 0;
 }
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index f084034d38..7e3da380a9 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -1,4 +1,3 @@
-#define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
 #include "lockfile.h"
 #include "read-cache-ll.h"
@@ -16,7 +15,7 @@ int cmd__write_cache(int argc, const char **argv)
 	for (i =3D 0; i < cnt; i++) {
 		repo_hold_locked_index(the_repository, &index_lock,
 				       LOCK_DIE_ON_ERROR);
-		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
+		if (write_locked_index(the_repository->index, &index_lock, COMMIT_LOCK))
 			die("unable to write index file");
 	}
=20
--=20
2.44.GIT


--tseibBTtE6MFLISF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYdEqsACgkQVbJhu7ck
PpSDCQ//UKM8zbiOwEeauUc6SWfzxm0xImzNaUFEvd1n0u+4x4tT28YmDVmb83Xf
c172/BffPU+CNbKLu7Y1sNjXsXSkU7JhZv9sescxXQoOfpfVeJMVxbkYtGQ5Jxu6
iYO9ZyHRAG1MIQBcmYhlAW1OcnPTbSD/wIbv1omnMphM5bvckpl/ul5ZCHjy4QdF
cyqLRCoSyXvZBr/66I878Mxv/YVf9+stWOFV529jUs6S2cSKOrvTnvV6YJwZiTtP
clAe/X4VMqih+rhfT0AIE7ZAWRTAlmBRUL4EXMvfb53vFoiD1Zt1h1pUuXjPhXN8
CGO8RuTCoM8CeBeCwk0x88hOQVeguu3Mq2EZR1mCN1HPHj1wRmXMOn8OEkSX7sje
VGxhJM1ZkPVJNupDfKTZd+Wnh8Tc+bGQXJu2UpZb/i0Gh352wYfcwGlsti9a8tZI
3Yet4aAb0o32DNGglo2sUO/qO/GL+H70ys0gRtOMMCsB4yXM2d/trnPS7o9iqRba
aR5Sw45YBSipHWAb0Oj3dEFXBaDytOhDD451OujSQNoK4c9RBWT6cqpU9XBS2zzp
nan3MLP5IyH854C/rbpO281kMFDqs7EqEY7EZ879ndpTlPXyNTYnRRooc/WcXsZU
Dv6tvGaipTHpL2PnHZ8EFeHRKhXbWhwnZ5QwgH4w4/PtouWSvrI=
=r/uR
-----END PGP SIGNATURE-----

--tseibBTtE6MFLISF--

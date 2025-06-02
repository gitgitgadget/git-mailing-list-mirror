Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094ED207DFD
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860051; cv=none; b=o6cvPglckqpjOJ3Xm9OshYdwdhBJI5EnPgqUKXzkfpuL6riXcWqDJ12k8XbR5pPYLYzrtSKhzMm3MNvV1N2GNuRgSZCN/3X/It30F33wryXg2yPkLJGYX/MjK+Nxf78CblR3Ph3Z1pvU+3YPFvmgq8ZSUrWmJutB/7pS8DgY+cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860051; c=relaxed/simple;
	bh=q8HotewZE5zD9Ol2N+yN3CISwthvpajtf5OjacjCsP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=py+Ls9bYOfesGG8I3sqgd0KJdKdy5A3cFAKuacnTxiKwIa1Birt9AumLr1M6OYfIA2Owb1kNVXMyqNjyrQJtpEsLQmv5CxYDUQfWAy4R5l8MZ+vHElJgAcvf39JaBjKvoxE42Bj+OnJuGgjlzymFgBJGNeK/4curPYnOm4td5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i42YQ0ug; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o4Q+cnvX; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i42YQ0ug";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o4Q+cnvX"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 24F53114014F;
	Mon,  2 Jun 2025 06:27:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 02 Jun 2025 06:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748860048;
	 x=1748946448; bh=U2W4MzvB72hgcEQWiln3ql2MwFIsfi3tja0UG4iwvnY=; b=
	i42YQ0ughjLE9RsiPkfc6y5JDduJa2qF6791wV2G0ndlVy1duZBrGtzErNHGGc/9
	n/tIdvVreNGcNbbJHknyDtdxECRW5lZg2KiYp1Y/qNNQiT2+jRr9LvLAnBXgaF31
	3XKs3DCC39gL/q0I6qvvJUv6Mhbbr9whDfe+keWNnqgLTgKH/zY+O0gooyXTXm7S
	pL77mao0p8KxOG9QFcXAQxOnbcauL5Fz++Loh0Kb3Z3xvipCKkKYGFWkmbEP8KSP
	qgUJCzG1OfcxE64HNd3S2vfPhTVPq38ucilKfAgNV+eaDvyjtH6Fso5dhksjIgdK
	SV576bGDvoh1WJYT9a05Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748860048; x=
	1748946448; bh=U2W4MzvB72hgcEQWiln3ql2MwFIsfi3tja0UG4iwvnY=; b=o
	4Q+cnvXbeZdSRFY37Q2iivqAh/FUFkiEn4zPu+/gKEXWLcIzINXY3bvrQ6GKR7CG
	P09ONjE8/xWrLSjRAJ+zpk5yOgGjIgKizTDwGyYfnqO/ZmCyt2hHJ5CGl1oDtHRZ
	cB2kGMWZcSumO6qhXf+pFfvhS9fJKlr4Q/dAd3Z7vtQJf7vKp4pn7Elkm7dSeVjo
	YgduGGLDUwWBktF7WD2f0/1VmDRjQXf6vCZVmGoUhutp8ut6SJ5hbCetgvPB7QMh
	o7k36IK2O9s1FJRXBkNcuUpFHqVZ3T8Bn7pRHLvbSFzoEbSOjbN0mcXvUikY+AhZ
	MFIwn7PKXpSaONkF70/Sw==
X-ME-Sender: <xms:kHw9aKI-qH6mEhzHKp7xx56Ozmfot1B97EqKc38cGL0ndFN_sktGww>
    <xme:kHw9aCJTNpePPEgxYxuvVTKaHz-K28MtncNufKoqPctzG_bGAUdjIZ7EKnaGOL6XW
    p2edkNGiADWr855NQ>
X-ME-Received: <xmr:kHw9aKtJikfXxtt9VCkoOa9z8kqPgIt4FVXBB9jq9U_9uZcHr302q8KgsDwqSUu2F5fa5Ys7BpWVPdb3NdZ3Nr4AFzHu6Cv8m5SUCgifcEtmrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjeegfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:kHw9aPZrmCxqLCsI9pePbAqnmNCehsk4DzLNokq1F9dCwGOjnqKcYQ>
    <xmx:kHw9aBbA8AR1sJBn4BjeV-qjy_27Sw2EFlGPxWpKOMQa3h2YmG0a_g>
    <xmx:kHw9aLApRBAB29JgpaXQhdQetpU3ln7ZEqJOnkgbKgRyPxR-LPthng>
    <xmx:kHw9aHZxV6sBq4xnTMGOZpc1G9eW09kH8mu4dThoGEi3GxnbUw1CIw>
    <xmx:kHw9aCBCLtK7ZNJ5NlYf93EIpXrzBd87yFXk8IbWF2mOqHZNY3niE6hj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 06:27:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 062708ff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 10:27:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 12:27:11 +0200
Subject: [PATCH v4 10/17] odb: get rid of `the_repository` when handling
 the primary source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-object-store-wo-the-repository-v4-10-e986804a7c62@pks.im>
References: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
In-Reply-To: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The functions `set_temporary_primary_odb()` and `restore_primary_odb()`
are responsible for managing a temporary primary source for the
database. Both of these functions implicitly rely on `the_repository`.

Refactor them to instead take an explicit object database parameter as
argument and adjust callers. Rename the functions accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 27 +++++++++++++++------------
 odb.h        | 25 ++++++++++++++-----------
 tmp-objdir.c | 10 ++++++----
 3 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/odb.c b/odb.c
index d83f7416e9e..b154e91953d 100644
--- a/odb.c
+++ b/odb.c
@@ -329,7 +329,8 @@ void odb_add_to_alternates_memory(struct object_database *odb,
 			     '\n', NULL, 0);
 }
 
-struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy)
+struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
+						    const char *dir, int will_destroy)
 {
 	struct odb_source *source;
 
@@ -337,14 +338,14 @@ struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy)
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
-	odb_prepare_alternates(the_repository->objects);
+	odb_prepare_alternates(odb);
 
 	/*
 	 * Make a new primary odb and link the old primary ODB in as an
 	 * alternate
 	 */
 	source = xcalloc(1, sizeof(*source));
-	source->odb = the_repository->objects;
+	source->odb = odb;
 	source->path = xstrdup(dir);
 
 	/*
@@ -353,8 +354,8 @@ struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy)
 	 */
 	source->disable_ref_updates = 1;
 	source->will_destroy = will_destroy;
-	source->next = the_repository->objects->sources;
-	the_repository->objects->sources = source;
+	source->next = odb->sources;
+	odb->sources = source;
 	return source->next;
 }
 
@@ -366,19 +367,21 @@ static void free_object_directory(struct odb_source *source)
 	free(source);
 }
 
-void restore_primary_odb(struct odb_source *restore_alt, const char *old_path)
+void odb_restore_primary_source(struct object_database *odb,
+				struct odb_source *restore_source,
+				const char *old_path)
 {
-	struct odb_source *cur_alt = the_repository->objects->sources;
+	struct odb_source *cur_source = odb->sources;
 
-	if (strcmp(old_path, cur_alt->path))
+	if (strcmp(old_path, cur_source->path))
 		BUG("expected %s as primary object store; found %s",
-		    old_path, cur_alt->path);
+		    old_path, cur_source->path);
 
-	if (cur_alt->next != restore_alt)
+	if (cur_source->next != restore_source)
 		BUG("we expect the old primary object store to be the first alternate");
 
-	the_repository->objects->sources = restore_alt;
-	free_object_directory(cur_alt);
+	odb->sources = restore_source;
+	free_object_directory(cur_source);
 }
 
 char *compute_alternate_path(const char *path, struct strbuf *err)
diff --git a/odb.h b/odb.h
index 82ddbb71e46..5acfda88fa7 100644
--- a/odb.h
+++ b/odb.h
@@ -73,17 +73,6 @@ struct odb_source {
 	char *path;
 };
 
-/*
- * Replace the current writable object directory with the specified temporary
- * object directory; returns the former primary object directory.
- */
-struct odb_source *set_temporary_primary_odb(const char *dir, int will_destroy);
-
-/*
- * Restore a previous ODB replaced by set_temporary_main_odb.
- */
-void restore_primary_odb(struct odb_source *restore_alternate, const char *old_path);
-
 struct packed_git;
 struct multi_pack_index;
 struct cached_object_entry;
@@ -187,6 +176,20 @@ void odb_clear(struct object_database *o);
  */
 struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir);
 
+/*
+ * Replace the current writable object directory with the specified temporary
+ * object directory; returns the former primary source.
+ */
+struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
+						    const char *dir, int will_destroy);
+
+/*
+ * Restore a previous backend replaced by `odb_set_temporary_primary_source()`.
+ */
+void odb_restore_primary_source(struct object_database *odb,
+				struct odb_source *restore_source,
+				const char *old_path);
+
 /*
  * Iterate through all alternates of the database and execute the provided
  * callback function for each of them. Stop iterating once the callback
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 4120badf5ce..ae01eae9c41 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -47,7 +47,7 @@ int tmp_objdir_destroy(struct tmp_objdir *t)
 		the_tmp_objdir = NULL;
 
 	if (t->prev_source)
-		restore_primary_odb(t->prev_source, t->path.buf);
+		odb_restore_primary_source(t->repo->objects, t->prev_source, t->path.buf);
 
 	err = remove_dir_recursively(&t->path, 0);
 
@@ -279,7 +279,7 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	if (t->prev_source) {
 		if (t->repo->objects->sources->will_destroy)
 			BUG("migrating an ODB that was marked for destruction");
-		restore_primary_odb(t->prev_source, t->path.buf);
+		odb_restore_primary_source(t->repo->objects, t->prev_source, t->path.buf);
 		t->prev_source = NULL;
 	}
 
@@ -311,7 +311,8 @@ void tmp_objdir_replace_primary_odb(struct tmp_objdir *t, int will_destroy)
 {
 	if (t->prev_source)
 		BUG("the primary object database is already replaced");
-	t->prev_source = set_temporary_primary_odb(t->path.buf, will_destroy);
+	t->prev_source = odb_set_temporary_primary_source(t->repo->objects,
+							  t->path.buf, will_destroy);
 	t->will_destroy = will_destroy;
 }
 
@@ -320,7 +321,8 @@ struct tmp_objdir *tmp_objdir_unapply_primary_odb(void)
 	if (!the_tmp_objdir || !the_tmp_objdir->prev_source)
 		return NULL;
 
-	restore_primary_odb(the_tmp_objdir->prev_source, the_tmp_objdir->path.buf);
+	odb_restore_primary_source(the_tmp_objdir->repo->objects,
+				   the_tmp_objdir->prev_source, the_tmp_objdir->path.buf);
 	the_tmp_objdir->prev_source = NULL;
 	return the_tmp_objdir;
 }

-- 
2.50.0.rc0.629.g846fc57c9e.dirty


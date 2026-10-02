Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44FB47ECF0
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935747; cv=none; b=SmUN5MdAED/ShX7wdx5kd9yMXb210XYzzYJZKeSfPJTdpIpAfZAzLkL+EHz6V95yn53N/hIUcmS/TDuUnw0e/8newHYueqTLWww20PGTplvuaFQv4eVpX5XMFrMzYsrltrJ3Zk2zDZTge9JYvIR35r7iGxg1YkDToMpbq9crWcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935747; c=relaxed/simple;
	bh=NFLK7U103yFDlqPuLFnQdh7G15L+l9tn7zE1eb6bwYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4/+8895Rp2Hhzs7NNznimVpGBEmExoN+Q2enZa2GiHa7dretS4VsRCslqQ5ZaqwWgCoSkc2akd1WivOhw4FQjtQg4EnomhqkUVBfrYpY41U7+M6Mmop/sHVy1ijRnHVCzHjTDO5dJodtGPKcMcVC4v+A1kvIuOSbERpurxOLI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cMFDGY9x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mgecTg64; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cMFDGY9x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mgecTg64"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 98CBAEC00C0
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:09:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 06:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790935742;
	 x=1791022142; bh=deE+tOPEBAi1VTzx65ciW+Q/w2kYddpWGTHqG0KwXwY=; b=
	cMFDGY9xGKKNdBCNePpWJhp91zDFdGKj0ZV1O1nDAEdb5xCi5+TJqOYAjWB966rq
	IAk7MP9hNq/a68Ip6gxp634mVgqAfdWyJWepJYkREeY3Ro+fl+gyMm8r7rBVUp3j
	G5k0MDBnKet+Wj7r6W/xtBKImj/kXlsIWsCK/v70DNGeb99Ziss7k0XY2RdLGc4p
	JE5crpPRA2f3l4GmMZnVjiHgSNHL34AEm9f7QcvoJv1HHCp86tgLtut7y3KT4eR5
	U9jIwe4MYzV0XmtrXmtdcDFHob/Q0V9DktLCmPmkHUCmVT2tcggik9WvIiR0iG9Z
	b6eXfMil2HLQSkudgMWJeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790935742; x=
	1791022142; bh=deE+tOPEBAi1VTzx65ciW+Q/w2kYddpWGTHqG0KwXwY=; b=m
	gecTg648DuyV4Z8kauK9Bey4J6RCZPFtfAZ7ApH2ggeJbuHeKiNd+IHJ/dK9ZZBn
	25f7yptoBTVt3J/1eqhZNoFgHNREpbzAQoZw6OgxNYHD1BH35S89rHivaDA6B38H
	jVtVX4EX4QtjPAFdsDPobVmjNRWA4UXRkqbSrAikAPdPqkpsinzhhedy8imDGKRh
	Gj6OejeuXf8z2/frEEqwM03t4mwevYpupm477tZGora7+gyHOozyijWgP57Do7JS
	TPrp7FXg3rNARDLeEliGmrPM490b9eDWPC6X/LHdYIQoJLNrIILePc0i322PVMQ/
	qrYpfYPIpJVs2zAzOAVHw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790935742; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MqVS3N4f/UKeu51skVG4iAs+dIJjX0qexzITwqqyX6xx+jS
	52RL4lmlXtrXCHLDl5eL7hrVfU7VM7zisSMvVPH6K3XAXsJw8RbODsHVOExXe0rd
	IfOcCEeWxPQCuz+dAKzy30UpQqJHBr9Sa9yBV30fOZ1FujrUgNyMfq2a0wZxIwZB
	gsnVarJddxX/2mJn8/OViNchi084hrVepHwJJlJ03uHJe/HRA4R2k+thZQtwCWqC
	LTqf1EZrkVg9tZsDRQcEAKwsEU/m1nLohfSFLHcudYNhne70VHMqKb6Q6+4mWWy8
	t7uKtIP7mIh62TCgyj9SoRJkniWONqghbXKv6gA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GZMqTo78eS+Yi93abfGaPdgVzbHHHwFryn9juNOMhRg=:NFLK7U103yFDlqPuLFnQdh7G15L+l9tn7zE1eb6bwYI=;
X-ME-Sender: <xms:voK_aknT9H-Uqb8ZQKwnb0ujRILwhGU3RENe_CFvtnZtuwo2PZBxYA>
    <xme:voK_aqyg_Sw8eNRSEFVbJu1zXtTE0Och8FyyHD7kD6O0A1a5lQy6JfAIqkgYCMveX
    IIcuflW6tLkHa4jUCNX8CdhEwyGXkz82ggL0E3Zm8JFPvPGkh_nObcj>
X-ME-Received: <xmr:voK_aoRcCsmfxH006eQSwjK5mSCO8Xdg-zeOO-w8Jf0yevVt9aWAHw>
X-ME-Proxy-Cause: dmFkZTG4M04zxrUwJ/NHbl3kDgdITLhB35V4DW2ZbTekMASFzOCCwtn4NQWgvgEnn5oWIG
    tiWQvNGvbcnI2W9o1IX1VTgc6nn0JCK2aAF2qMOC8r3clSsXjBH+MJlYQBHBE4kM3+yfJF
    ILwhgPh8N0aHpNQ4XqOFJPSqEO7W1TR48bM3hWoIlD8aQfarhDSELDI4SQ2zoLE7NH2L46
    DVFcrNKlrU0FAp8eIKH6JsbDdfH1ZW//pR+IIe/3Xt5N4Cz/9ekqeugSQLP/cKMp055149
    D0m4QsS1pJYwe6M0JaJqT0vdTmSmpSL7tl0QeceSUVPgvE3skMr7A1tF/Pq7umYVexSYTn
    KypJLmh2wrQkXhwcIfbivduVjjScZez0jsVrF5Y6L/dcxsnvySRqbXWmnNBwRRt1VNAYQK
    bFtQkLAQnbgc89/nyLSDsgBeHLeyNP37o9CtEcq5AD6Ywisnlt7HwT2j0/RMsrViK1sv9y
    QpW4lqm6eDbDWERttQzXTP3Kpq7tct4doTAC5GJybryrquD6UWUnhRU5Eba0ZRUwSx23QL
    PqoysDLVjEBpHv/PkGpS0fyaaqr+e0hasl0txp45bV9YEXzgH8iFxbPUJKIAeE7xj92xWt
    zhNP66G4b6xBJdd6zfhe3Ed2zaoa+XIjURK5yXTuGh+MKG1fVtnLPeFOqwJw
X-ME-Proxy: <xmx:voK_alt9rRKPsGPYcI7akcOKoJKPBpSbWDXC-R2vcoprDlYr_Oc5kA>
    <xmx:voK_aisXh-0Nb-S8EX-HxMn-roJNNKqYStKEeyRkDKdieHRy9iLeUQ>
    <xmx:voK_ajxspOjBQmjo9BO_O9Ib9jTUT-YN8WbBMAHFfOk8jort2i-qOA>
    <xmx:voK_aggHj6U5DERXw8ZZlf23n49H_iFSRvst1FuNWNsOf01a1M1EGQ>
    <xmx:voK_ao3ZN2jyEyGseE08NaWi_LbQGkcQg4OvXWC1F3DuKXllHqQHhvqt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 06:09:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd5ea30a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 2 Oct 2026 10:09:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 Oct 2026 12:08:24 +0200
Subject: [PATCH 13/13] odb/source: drop `read_alternates` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-pks-odb-move-alternates-v1-13-8a63507b88c4@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
In-Reply-To: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Now that alternates are an implementation detail of the "files" backend
there is no reason anymore to expose them anywhere else. The callback to
read alternates is thus no longer required. Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c    |  7 -------
 odb/source-inmemory.c |  7 -------
 odb/source-loose.c    |  7 -------
 odb/source-packed.c   |  7 -------
 odb/source.h          | 27 ---------------------------
 5 files changed, 55 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 072f515b36..455f409db0 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -594,12 +594,6 @@ static int odb_source_files_begin_transaction(struct odb_source *source,
 	return odb_transaction_files_begin(source, out, flags);
 }
 
-static int odb_source_files_read_alternates(struct odb_source *source,
-					    struct strvec *out)
-{
-	return read_alternates(source->path, out);
-}
-
 static int too_many_loose_objects(struct odb_source_files *files, int limit)
 {
 	unsigned long loose_count;
@@ -1277,7 +1271,6 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.write_object = odb_source_files_write_object;
 	files->base.write_object_stream = odb_source_files_write_object_stream;
 	files->base.begin_transaction = odb_source_files_begin_transaction;
-	files->base.read_alternates = odb_source_files_read_alternates;
 	files->base.optimize = odb_source_files_optimize;
 	files->base.optimize_required = odb_source_files_optimize_required;
 	files->base.generate_pack = odb_source_files_generate_pack;
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index f67c74a724..868e723c81 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -322,12 +322,6 @@ static int odb_source_inmemory_begin_transaction(struct odb_source *source UNUSE
 	return error("in-memory source does not support transactions");
 }
 
-static int odb_source_inmemory_read_alternates(struct odb_source *source UNUSED,
-					       struct strvec *out UNUSED)
-{
-	return 0;
-}
-
 static void odb_source_inmemory_close(struct odb_source *source UNUSED)
 {
 }
@@ -390,7 +384,6 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 	source->base.freshen_object = odb_source_inmemory_freshen_object;
 	source->base.begin_transaction = odb_source_inmemory_begin_transaction;
-	source->base.read_alternates = odb_source_inmemory_read_alternates;
 
 	return source;
 }
diff --git a/odb/source-loose.c b/odb/source-loose.c
index b2fbccd3c0..0664634938 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -985,12 +985,6 @@ static int odb_source_loose_begin_transaction(struct odb_source *source UNUSED,
 	return error("loose source does not support transactions");
 }
 
-static int odb_source_loose_read_alternates(struct odb_source *source UNUSED,
-					    struct strvec *out UNUSED)
-{
-	return 0;
-}
-
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -1145,7 +1139,6 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 	loose->base.write_object = odb_source_loose_write_object;
 	loose->base.write_object_stream = odb_source_loose_write_object_stream;
 	loose->base.begin_transaction = odb_source_loose_begin_transaction;
-	loose->base.read_alternates = odb_source_loose_read_alternates;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(odb_source_loose_reparent, loose);
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 831501f397..2226fbd313 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -687,12 +687,6 @@ static int odb_source_packed_begin_transaction(struct odb_source *source UNUSED,
 	return error("packed backend cannot begin transactions");
 }
 
-static int odb_source_packed_read_alternates(struct odb_source *source UNUSED,
-					     struct strvec *out UNUSED)
-{
-	return 0;
-}
-
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -1019,7 +1013,6 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 	packed->base.write_object = odb_source_packed_write_object;
 	packed->base.write_object_stream = odb_source_packed_write_object_stream;
 	packed->base.begin_transaction = odb_source_packed_begin_transaction;
-	packed->base.read_alternates = odb_source_packed_read_alternates;
 
 	if (!is_absolute_path(path))
 		chdir_notify_register(odb_source_packed_reparent, packed);
diff --git a/odb/source.h b/odb/source.h
index 6718aced6a..1867347dfc 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -258,19 +258,6 @@ struct odb_source {
 				 struct odb_transaction **out,
 				 enum odb_transaction_flags flags);
 
-	/*
-	 * This callback is expected to read the list of alternate object
-	 * database sources connected to it and write them into the `strvec`.
-	 *
-	 * The result is expected to be paths to the alternates. All paths must
-	 * be resolved to absolute paths.
-	 *
-	 * The callback is expected to return 0 on success, a negative error
-	 * code otherwise.
-	 */
-	int (*read_alternates)(struct odb_source *source,
-			       struct strvec *out);
-
 	/*
 	 * This callback is expected to optimize the object database source.
 	 * Returns 0 on success, a negative error code otherwise.
@@ -507,20 +494,6 @@ static inline int odb_source_write_object_stream(struct odb_source *source,
 	return source->write_object_stream(source, stream, oid);
 }
 
-/*
- * Read the list of alternative object database sources from the given backend
- * and populate the `strvec` with them. The listing is not recursive -- that
- * is, if any of the yielded alternate sources has alternates itself, those
- * will not be yielded as part of this function call.
- *
- * Return 0 on success, a negative error code otherwise.
- */
-static inline int odb_source_read_alternates(struct odb_source *source,
-					     struct strvec *out)
-{
-	return source->read_alternates(source, out);
-}
-
 /*
  * Create a new transaction that can be used to write objects into a temporary
  * staging area. The objects will only be persisted when the transaction is

-- 
2.56.0.379.gc618271300.dirty


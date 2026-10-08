Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334346EC9E
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448603; cv=none; b=jrdZKRRXgQov4DEZKuQGCeRVDwJ5yIqKF2Fw0PsN1yVCba1wdYWmCcFRknOJd8gs62s8JwZCWkEQxfiJ/R+8TdqFJYaOXPrPIL9AMv/OkCFvpsiv2LzfqfIePxM3x/iC7s1A+YyTF4K9FhF6R5bCh9rNGhYeYA06gwRZKgkUdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448603; c=relaxed/simple;
	bh=31OmJW+Cmre0hoXAuZKJBv5HoVpgv8f2QuJtHxzRWMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HfCYaI0J4pu6Sng5NpETaULp9yPVFTSGJYzUqb7k9+l8AA8d+LOgFuVZ1st/eLPcFMVQMqjLKd6oK08Yh3PjOnEPrKpeA5SrQnyteFU/UY/09F9fk89vE6KfdMaCqQ/gjsDPK5E9jAlsI+xeym9pXd26Jp+kxp9D9YU4D8/8SVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k8PaHa5o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lH0+yOVn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k8PaHa5o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lH0+yOVn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 939BD140015F
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:36:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 08 Oct 2026 04:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791448600;
	 x=1791535000; bh=fPbWmjkyFGbkqRqgjJTQRFgFCKzWxDFhXCgW1L51yuI=; b=
	k8PaHa5o+O0h/KKBUB2geT0ZwHK8iIl9wUXVG6hKhm5a/JZ4R/BxWCN8PtG0zfMN
	pmvQcPV4aPx9P6Y4EUvytHbnxezEKrLw9HWidWiRTFWe5BnPIsVbgr24EWmVDFzB
	ZHyqy4K6bUShSDLrJ6dbCuYkcJFkMWfasLTGcIYpnd+c/JAMCp6+J2T3jqmpWZS1
	OoENdOwUSYksRp4EkKxpxcf3sPXVLgYk97w+DuzD07JLGoyU5PjlfjsdXjdnPz9h
	Wion7AitustOZ9johH/bXJQzzaswOTPS6YepQ2afbrmyGVWPBXhbQVYccdqKezS+
	qo5G/LGOZQUP8vBeL1M22g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791448600; x=
	1791535000; bh=fPbWmjkyFGbkqRqgjJTQRFgFCKzWxDFhXCgW1L51yuI=; b=l
	H0+yOVnpbN+P/QDFwaO71ahzlzNA4wF4ei3uUjyGjcYbwstXCedYGLbFeE1OUQnu
	aeYW7HqH4xRO7n5VeESURfZu+ORwY5/+tYVKxEF9b9Y10JkoCAWgvBNFq7pACJxJ
	szGP3Y/oLmOaPmjUv9DUyB69oNvSYA/jLpELmK86JTL4cScx1Om8RkxdX1ubBzuJ
	JxmjgSrn/l8OCWTMensfD20d43gwiI0msCHxZwaZUGSj8fwW9FOBAaHN6BVuHk57
	bB+mJN5Gzps5BYq+vklBk0FhCazm+Mj7oo1C1w/16ccVT2r4CBYppoNJEig3RRvI
	ZSh/JytM3qFfBBloXX7sA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791448600; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QFusDQWpb3+sm2CyI9k0WEL82/Gqk2xykhrUEupRuImdPM3
	HsMOa1colspRM44ZhFbCD3hfcV0nDFFq5DLlVbjpWpiZJubJutFG6pRhzsMC125o
	pCIGdZi0qVmCpge4fNr0XRjzl+Zo/JQ/ZWYDy8jDk530wci/F41zH3W1JGrxmL2w
	se5gOAa7/tW9WQcbZjuRZ5eWUNMUQeeJVnZx73jDFrIM+rvkhItSj7UpVDV5WpT6
	mcdPjxqCYnCnqlYjaTwLHpEG7v3w8NBuohGMbKCbBhh+6iXGt7b5utUmLNc/773c
	pAayr31fSAWhSsSM6zlbm4qDakq63RJL1d0riSA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:f1JYq7dkXwfI+ZR2S5Wm+3CaDtu3g4Jmkv7iWrCtxUU=:31OmJW+Cmre0hoXAuZKJBv5HoVpgv8f2QuJtHxzRWMc=;
X-ME-Sender: <xms:GFbHat_NLsljWkkBMvExu2WCMKyGAdvNkaVEJOlkfd6n6e0DlMA37Q>
    <xme:GFbHanuhC7pZcUWI2e4IdkhbIMcIA7DXKp22aT2Xr6g_eRcQDVTMbnh885sz-DBbB
    EhnEeeN-M0qy2WmhEwNyVZx_FkUURgf-Y9U5GiQieHcmZ1GYcGdXSY>
X-ME-Received: <xmr:GFbHaoo5tWX5HhqFRdbkzll_TtfWbA_VFyhL7vH8iFTbBKt9fQ4cJQ>
X-ME-Proxy-Cause: dmFkZTF8H7ugFKa8mduDhs2PAv3SzMlx7rZ27r3cmyaOEu9LuHxcC69KxrQNAaqMI2BAgm
    0Z6qPvKNkyZwKkrw+ti9DI0sgR0lU3CseFvZXQshTXRtmiSGdLE9lV+TjRol+i1ScLI3Q6
    2cIc0ba1LQaZF1WXLYFBRWFdqqBJAp1RqYOsuOfqxZUV58gi/DK1NnXlD5/eT+rD3qkwvG
    90bSm/npPrwKC3fszaJCOcL/i54U4+UDMr1XgpZAL7tYm9c1NUtASmlzu+wzOHAW8K1Iz0
    PBtRZoclspi8l0mwdu2zZrf5dHuU+tK/A5HPuzuKkkDbz9dx1zOFC5Id7NWjdAjc3Jg+DQ
    R6740j7JGB7wvf/PaPg46ByZ1YpYeiGdDizJ+bqROM8jYGw5Ohdb5LxjrIpzl6bUuUx9KP
    lwXQhA1388R10mYwTD9ENcgRrT1oFmfNCwi1SqD71zSnol8YpvALxkBRJ3gTinWj0uCo7j
    dpc951Td4xh0kt74P0PRJRsOeVViUhO+CtoNDqTUzgJdFgQXAXub8/CAmmPOMcTvPgz98J
    WngTp1roouyALnw72ZwVddKfm87/6eleV+Og5+x5627gsQpGt0s5ivcYurzlb4rX3LKoPi
    5lt53I1VBcfkkAk4h+gCTIfccOTJYaLXeh5blof8jaxKyPssHhG83b4y72SA
X-ME-Proxy: <xmx:GFbHasnE7f5waGjnV6SADDULhsLJx3WYjLQuFCkNELYpYuOh0tc6aA>
    <xmx:GFbHakzdG8uSBzLB_gQbhIWwyFk8CPB6N04MY27hXWEgXU6pej2Afg>
    <xmx:GFbHaslsVwvzX40Gr7THN1FTuw9HSh2fZV2mE3_285JJYmzB5uSERg>
    <xmx:GFbHalea1tJ0CVrf8jSdQRy5McftlrT7I73vK9QNSgPnsW37bTedxA>
    <xmx:GFbHastObxyUeiMQfL3OJPP0HNdcQZGssByYdTNYO8yo0EC-05K4eIaV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 04:36:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 49a1f0b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 08:36:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 10:36:03 +0200
Subject: [PATCH v2 13/13] odb/source: drop `read_alternates` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-odb-move-alternates-v2-13-b47e8189baa5@pks.im>
References: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
In-Reply-To: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
2.56.0.406.ga2d225a756.dirty


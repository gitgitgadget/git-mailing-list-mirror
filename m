Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C169C24EABC
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554210; cv=none; b=Y60pGR/w2jO1AZNfbX3krgHZPODnweGScy/q12TFTvqFQiVpoczj7YZrMHyecoEIs6G2TN5UQoaN/XCeD37u/Nt78UstAbMKnMBguIPbWxbpDSltEnY86cP9pNoY8dtDlhjitZUomtzz/YLnUpnYQOOCyfkpLaMgm7nk2Qb1MpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554210; c=relaxed/simple;
	bh=3Y2NiWX++WcgNfVHZKLIIUr7/A4xNI/eOoV1Ev7PCH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mCV8+xl+NSr54fmcYzoaVJU/42qm6Lu3vrdETR1oVTAdR8YOMunJTramL9QtupRRH4UJqpG2wVDpcxNMcIcGtHkykD+7OTB0p1/74NtA0XfyhHCiAZohpEgJsk/yrTFYNPmiHIsCMJF0ScaETIUID6zzV3rSForn9ouqms0GyIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ly5UOBBH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dzZxLn02; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ly5UOBBH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzZxLn02"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D675140014E;
	Thu,  7 Aug 2025 04:10:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 07 Aug 2025 04:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754554208;
	 x=1754640608; bh=zOCnI0Cckzg+ekKZat1SUrWrh2MoLwgRnNxMQ1VZd2Y=; b=
	ly5UOBBH2F9Q0H+IowgRbBSMU0grB++6MTfVdfeujlucGHf2TIdPXJACsZR3FWJ7
	9Ei0ctU5spx2dIjJhg2gXzq7v/aiZcmQxo8ZBbzKRz470byYjl4w6PPLkt6KDxjc
	z7YFb9sj4RLLzjBY9nbdpCC2bfFW+D1G309M2EqEeE8P8IVZ5uWc7cplFixOPeSm
	hgpcALGIKj8j8MKvCd3jDiyxxWPjsnMOPDyqczCisPibEmKOZqiCCGIrKouflLDR
	l8Ky334seQySboFRaN/liaCHOAPYMmQkfnn3RxjpR67vD6e5kOFiinr7Ws4fQ35Y
	+tqzoh8owS8QFyOfUmW7Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754554208; x=
	1754640608; bh=zOCnI0Cckzg+ekKZat1SUrWrh2MoLwgRnNxMQ1VZd2Y=; b=d
	zZxLn02afYV1KnhwQjU2QuHgtphYhIKp3Qj5WRlczFXuPlEryrmRxVChvxvljg27
	ghg8m1WJMGFYyCV8g+aFrwsd2NN739Ib47lPzebHtmLJdQY62JXmsJSnRVcnI47c
	gQwbtDwpTr64WRxYdZY4uV0RqrxjGNdmpu+z1lhO3D/1GkqJomXxImsvDkrtmtn3
	1cL1RYJrxtedC6Tb2ZDQRl2oLgd2rEiKz1HagDPjRWXmCkiRoF8TeP6ct5moOIhR
	9IfuyuBMpqMXlOgNPPpfS5Jn1pzYbG7tgjdq9VXxuJjSCn/QrqnWNQWeST8TN4hq
	6sRSTSAg9ux2ilVdWLzdQ==
X-ME-Sender: <xms:X1-UaHfb9zGLeziiELRDLP5NyzL3HWAk_TXUdpXdgDICAgX5zdYYUA>
    <xme:X1-UaAdk562uzT2edQKvSyMb7JtrdBIYW6uj1MFPAev_2H17xi8aqgvcwBlgXnmb4
    6NRBCHptKihlxeQyw>
X-ME-Received: <xmr:X1-UaJ9koiCn6gKznRwAra-ekb9skD6K9C6KFeWPHZMRYsR-Hazt2sBREcot4wp5jxx1IfWxJs6RyBaGk6yMJe2Mrta2um-vi6uX1ARfBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:YF-UaEktgdowKOjaH-J-t5bMl7TA_r3uUpoefhzUP2HrXTMY-dfPHQ>
    <xmx:YF-UaD9fjS8GRlYTw6KTcCB2O3FKd_Jp4_ojhgftuU76GMHMVrNAsQ>
    <xmx:YF-UaKkxqyAT_eQNkVvL5vUD4WquT81FDZvmn99NLUqrRMs70zimmQ>
    <xmx:YF-UaI27fHD7DEGEVV5sy4IbvYKaQ2KJbRWWPSJ5RmERno90o4aTWw>
    <xmx:YF-UaDTy-AjdZUR01JqHnRZePdJhTsdErdJa_Ul4npfk9Y_vzCorV3jZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:10:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e8c34eff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:10:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:09:52 +0200
Subject: [PATCH v2 2/9] odb: allow `odb_find_source()` to fail
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-midx-deduplicate-source-info-v2-2-bcffb8fc119c@pks.im>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

When trying to locate a source for an unknown object directory we will
die right away. In subsequent patches we will add new callsites though
that want to handle this situation gracefully instead.

Refactor the function to return a `NULL` pointer if the source could not
be found and adapt the callsites to die instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 4 ++++
 midx-write.c           | 2 ++
 odb.c                  | 2 --
 odb.h                  | 4 ++--
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 25018a0b9d..dc2c1a5432 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -102,6 +102,8 @@ static int graph_verify(int argc, const char **argv, const char *prefix,
 		flags |= COMMIT_GRAPH_WRITE_PROGRESS;
 
 	source = odb_find_source(the_repository->objects, opts.obj_dir);
+	if (!source)
+		die(_("could not find object directory matching %s"), opts.obj_dir);
 	graph_name = get_commit_graph_filename(source);
 	chain_name = get_commit_graph_chain_filename(source);
 	if (open_commit_graph(graph_name, &fd, &st))
@@ -290,6 +292,8 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 		flags |= COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
 
 	source = odb_find_source(the_repository->objects, opts.obj_dir);
+	if (!source)
+		die(_("could not find object directory matching %s"), opts.obj_dir);
 
 	if (opts.reachable) {
 		if (write_commit_graph_reachable(source, flags, &write_opts))
diff --git a/midx-write.c b/midx-write.c
index c1ae62d354..40580d8c73 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -917,6 +917,8 @@ static struct multi_pack_index *lookup_multi_pack_index(struct repository *r,
 							const char *object_dir)
 {
 	struct odb_source *source = odb_find_source(r->objects, object_dir);
+	if (!source)
+		die(_("could not find object directory matching %s"), object_dir);
 	return get_multi_pack_index(source);
 }
 
diff --git a/odb.c b/odb.c
index 1761a50840..61104b7cb8 100644
--- a/odb.c
+++ b/odb.c
@@ -464,8 +464,6 @@ struct odb_source *odb_find_source(struct object_database *odb, const char *obj_
 	free(obj_dir_real);
 	strbuf_release(&odb_path_real);
 
-	if (!source)
-		die(_("could not find object directory matching %s"), obj_dir);
 	return source;
 }
 
diff --git a/odb.h b/odb.h
index f9300439ba..d085e691f2 100644
--- a/odb.h
+++ b/odb.h
@@ -186,8 +186,8 @@ struct object_database *odb_new(struct repository *repo);
 void odb_clear(struct object_database *o);
 
 /*
- * Find source by its object directory path. Dies in case the source couldn't
- * be found.
+ * Find source by its object directory path. Returns a `NULL` pointer in case
+ * the source could not be found.
  */
 struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir);
 

-- 
2.51.0.rc0.215.g125493bb4a.dirty


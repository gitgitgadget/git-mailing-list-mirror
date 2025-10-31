Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861B2ECD39
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891190; cv=none; b=gRNXy928IJV29dWrTVZA24bdvGixr3WlAyoZIxppXP+8NNsHjFIeomGiibyEIMaoFG3d8VWNgyLFgYhng3jDpYNS1ZOoboXFLh5UNeGQ3RZifC17jX3uSOt0Roqe0SXA1Y6hsj2xmKWnhN518UKpRCNZu9GEx6xbqnxlYGBZVAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891190; c=relaxed/simple;
	bh=EFDIeXi4rCW3949KMgl2l/otAQixUmsjlBIQQm53GOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+iBISBDLgq1YnGK595hueWzQMpXHf8XY6WTwDtb7BiGCwZjrOTe0x23LThOcHceauusEM8ulmmyp94RHVqKKZDQKQU8bu+lkFCRNDFPZ924v32mV+3/JTLEpmJ6/VEQj6PaTlef2kTsNBt4OVu2i028WNRWEgozrDM48ZM/STQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pAlmiN7s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=naZNF2ss; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pAlmiN7s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="naZNF2ss"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9594DEC0084;
	Fri, 31 Oct 2025 02:13:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 31 Oct 2025 02:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891187;
	 x=1761977587; bh=k4aqAXYa6+N7zp2EOP9scBzgzGmW421JJHkqND07fLc=; b=
	pAlmiN7sGBoOQdIRL5mrXds+IdnZvtV1JUB65IaU+4jN6u0NQ58vT4huvmkioWqY
	5kmaAAA178qo3Gl7oxO0wlk6V26TYli7zT2HFAnvxW4lWeDnBP4gypZx3RAe6poi
	QE0pcrcd2rZLYFMT3lgarz00OCt9Jlqm/qvEhiT4LqGDekYUi+rhv6sjPho5lq4O
	SrTcmFvV56FmIZoHQ6npBzDknU5qUPxBivvCgYVJledz89TAxKycGrJOiy+s0LzL
	bL8Un3+5naAdDQg3MPCyrB1O1O3ejDDbeqxGbDYMc3Gd2NKSGeGAzDJa3AzNX50R
	8W5OsP9ZMMXbXaZFId3JgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891187; x=
	1761977587; bh=k4aqAXYa6+N7zp2EOP9scBzgzGmW421JJHkqND07fLc=; b=n
	aZNF2ssN5HRH7qCEBVlaHjCENb4jUQBceVFeVlNh2dCmhfYTxU7xc+l5sA5PK9M1
	arjQpZZyJXh3Mj67ArusLzI1iyULCz1Jk9A1wSalaYg9sxBMt+/VSCjlI+QcQ0ly
	9XJmy1JlzJ/YM8odyhaZIKgv01cOeen02WSVLa3a/KJQdiU5PIadHGUGrD9YRg2V
	PewVIR9Iid1o8BBPQz4EvSYuz11fntCGEjy1UtObT50aOR7NSt3Q6K9f7iKKxM2A
	i+OBVAk4n45bK6AhryP5dUuZagEc/oZYNdbu9mJkKVFWvjvEVGIakIsyN5cfgbxK
	m+0jzWzCVSIR+zCUZ3YsA==
X-ME-Sender: <xms:c1MEaToIlUHGEiunaaKCLiyrW8ab7oygrM1wuO2ZC5fMAbLkuwPWCw>
    <xme:c1MEaVGUImXBofowc1rlQryVLxNQqro1g7crIdmqnHWZsHzAQ_aG_neTCvMdPyruT
    e9HSlurVbtLlee3TDnZmNX2nOFjvf23r7m0mNuIfJIH6zpeoZqMdQ>
X-ME-Received: <xmr:c1MEadn0I05_DN1uf4jyx6uHh-WwORZeEsCtG-29kDAl4VHEelBFXYVTRYESAosKyyVK9D4YLQKUr3ofnnN3BXkQ9ysX1_FFkfXcMBPsMkmEVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:c1MEaQm6IGKmdKpO9kzDgc4FesFdvfQqbQzf4XlgaLax7i9qBFAFOQ>
    <xmx:c1MEaWvHwOeL7iqbacAUcq95JOpun_lH5__ngJFEjQHhs7qB0pqnzg>
    <xmx:c1MEabmLdIsIXJn65VFJqLuIDO2ulN91N-Pb8GgUUPEF3rdd8BbQzA>
    <xmx:c1MEaZu9hsBnT55ZgImg3wHy9nBN84xJXTMNVM61RU_D_0ejmQSERg>
    <xmx:c1MEadFtxbusyVqWHxxA-RNGqveslPukPyG8aY5Lfke_XoPYpVn_wBRl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:13:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6da6f99c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:13:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:43 +0100
Subject: [PATCH v2 07/13] object-file: hide internals when we need to
 reprepare loose sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-7-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

There are two different situations where we have to clear the cache of
loose objects:

  - When freeing the loose object source itself to avoid memory leaks.

  - When repreparing the loose object source so that any potentially-
    stale data is getting evicted from the cache.

The former is already handled by `odb_loose_source_free()`. But the
latter case is still done manually by in `odb_reprepare()`, so we are
leaking internals into that code.

Introduce a new `odb_loose_source_reprepare()` function as an equivalent
to `packfile_store_prepare()` to hide these implementation details.
Furthermore, while at it, rename the function `odb_clear_loose_cache()`
to `odb_loose_source_clear()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 17 +++++++++++------
 object-file.h |  6 +++---
 odb.c         |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index 8a3db2877ee..2b908dc1215 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1834,12 +1834,17 @@ struct oidtree *odb_loose_source_cache(struct odb_source *source,
 	return source->loose->cache;
 }
 
-void odb_clear_loose_cache(struct odb_source *source)
+static void odb_loose_source_clear_cache(struct odb_loose_source *loose)
 {
-	oidtree_clear(source->loose->cache);
-	FREE_AND_NULL(source->loose->cache);
-	memset(&source->loose->subdir_seen, 0,
-	       sizeof(source->loose->subdir_seen));
+	oidtree_clear(loose->cache);
+	FREE_AND_NULL(loose->cache);
+	memset(&loose->subdir_seen, 0,
+	       sizeof(loose->subdir_seen));
+}
+
+void odb_loose_source_reprepare(struct odb_source *source)
+{
+	odb_loose_source_clear_cache(source->loose);
 }
 
 static int check_stream_oid(git_zstream *stream,
@@ -2008,6 +2013,6 @@ void odb_loose_source_free(struct odb_loose_source *loose)
 {
 	if (!loose)
 		return;
-	odb_clear_loose_cache(loose->source);
+	odb_loose_source_clear_cache(loose);
 	free(loose);
 }
diff --git a/object-file.h b/object-file.h
index 887b48725a0..6cbb4b44352 100644
--- a/object-file.h
+++ b/object-file.h
@@ -37,6 +37,9 @@ struct odb_loose_source {
 struct odb_loose_source *odb_loose_source_new(struct odb_source *source);
 void odb_loose_source_free(struct odb_loose_source *loose);
 
+/* Reprepare the loose source by emptying the loose object cache. */
+void odb_loose_source_reprepare(struct odb_source *source);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -44,9 +47,6 @@ void odb_loose_source_free(struct odb_loose_source *loose);
 struct oidtree *odb_loose_source_cache(struct odb_source *source,
 				       const struct object_id *oid);
 
-/* Empty the loose object cache for the specified object directory. */
-void odb_clear_loose_cache(struct odb_source *source);
-
 /*
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified oid.
diff --git a/odb.c b/odb.c
index 5a5e770dcd0..b4196f0b323 100644
--- a/odb.c
+++ b/odb.c
@@ -1071,7 +1071,7 @@ void odb_reprepare(struct object_database *o)
 	odb_prepare_alternates(o);
 
 	for (source = o->sources; source; source = source->next)
-		odb_clear_loose_cache(source);
+		odb_loose_source_reprepare(source);
 
 	o->approximate_object_count_valid = 0;
 

-- 
2.51.2.1041.gc1ab5b90ca.dirty


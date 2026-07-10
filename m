Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A273B2FC7
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673358; cv=none; b=NqaPTxpmHQSFzJN43xjDoXAD93BCDQlcd5aFjsk9mU9+tN2nwrbJYxyBFmA8osbiBS6zXrZzlX3Dgvx0cgAcTOAYEJNrmfdcjU/N9MWZfpZjkXwMIXvqKmZBCet43AX63bQmSeRT64S3UsfDynrx20glW/0RyKldhq1uyZGPyBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673358; c=relaxed/simple;
	bh=RT524E4MMo0gBP24qW/OgFc06L+3y0pkC24ZARyeUU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QoT8YtGrkHkCsNA/V0MudhkJ+V/ZLMsBtiH05uf8gGyQVytmjeEwnuZSR2l3GFecNJo4HB9qOPnGt1jQgDpWUF1lijNPBLQ5xBSTW3NU9Y6aMa6GO00btV/rtSZ1FTFDlAHbKDvhdMXsRp4M6r7A3rEv88DFlS7Idjc5ZI5dA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y0b8TwYq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AliRQeNw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y0b8TwYq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AliRQeNw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 851921400096;
	Fri, 10 Jul 2026 04:49:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 10 Jul 2026 04:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783673355;
	 x=1783759755; bh=cMbgkjWLucchCX5DCaAj8h4uqsBvWvYJGyJBENkkR6A=; b=
	Y0b8TwYq5f2NAJ9cP+mNHcSIkcmqgk4USpWLHPG4Ruh77rKsNwpebmxR83+B0DDP
	WAoF+x2WKAgoPmhTbXBes9ttFcYLSSNKHE+0rk8gI3UvU/bUuQyW7SKwBcCATfT8
	0kR7LTIZqM7oApgTHlx7iYg+0qRx+oO/nzv3/qw81EyjttI7lQTpNr1SNcqcE45/
	rAwQUZYmhh6r1qbBQNUUWKvMSLIZSF2bmRE8FVRxxSfSEM5lLipqcOUQ+7HLt1iL
	laUhfPP1Tr634fg5qsyyVLIq+8t2AO+b3FIM93z5hGho4SSRWk8MUkdb+KWGiEor
	qIEeoHmEB3g99i7xmLPAnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783673355; x=
	1783759755; bh=cMbgkjWLucchCX5DCaAj8h4uqsBvWvYJGyJBENkkR6A=; b=A
	liRQeNwjkVPrsHzHkG4957T1BdWyXj7t9OFp6/RSIhWUi2n4Cv+b4p/ZkF2U+Q9g
	gfsp5VwYDQ8kVZ6wMNLI8rEkv6DFx7HrZKN75wBxJAXTTP3fua25zH37UQDWlGwh
	H5w3H5MTr6R8dJE/9LIZGaR71hCQiJALXamJ0Z8XlSDK7GL1r5IgwRj855Wm0T7E
	PxRWRYdxee1KN4mxItZnuMTrCujvD6JPYqm8KgNholtLnPv3lyWDxfLdsOTjkyld
	+gTcfazvwY+1n76onkCQo5FGKNGv74t7JBPCLcLsznQRnl2Myq+v5odX2IXnEXM1
	EId95XD7VxNiLHvD4wMAg==
X-ME-Sender: <xms:C7JQauvjaPBpKnOxdgv36x4bym4A_FCUfm9Y1A8FhPDh1XQV1oHyOg>
    <xme:C7JQaq4k5DFXJ8i0OjjPBb5bhmkIPV3eqrpvkjvhIC3ywqw4oFraCTsHdKosQhmEu
    laiAwVvMTLrD-ER3rH7gDHtiNgL3jaW8myU_NVjKy5FSYDahiOC>
X-ME-Received: <xmr:C7JQanL6_R_ocZ0u_dwfQxqO9KXKcvXuydCPtZZ_35RTKA3qRhFJbwHYgRXq2_MlLDIhGWmk6JVdy8VWTOM1yKHeRs8SZcP5LythuF0xSdD7uw>
X-ME-Proxy-Cause: dmFkZTEgZYCWI0CbwqLDlonRXrqrFzk687BySmUYIjUL8URshR1m/EiDVyblVfOFgWBhiF
    2W31tpdXDxKGKgaYhurSLLFU+BbNgi/4C0xxaRmtYJz7HeqEFi+QwvHb7kxQHb/YWwMtb7
    j3NTQXjJMxj+MM+cU2WaoisEZ014DFJUFWVLynF63QDmY3YIVdTHjtzzSe4K8qmVO3lsb0
    CsQzE07xbJQnig+5tGzXACaJVyeO5r47D8vtKLZkkZ/UYzA1paKzr4n2FRqRHlz2sPYkEh
    4LtdzZNrewg5qHCD0/9LlGVHJkWjCyl/Ps9v10iDJeQ6MHaHMd3Oy/Da6KmnDR+SDj2QCs
    fiUWmk5JFkSzUASiI9z7RPSSVuiRNnLdbalznkMXQ1USawev95vGm+wpFQ7Wdee2zwpt7M
    1AfvbrcPpyNR6dZhqqC++hRMpHs6A3vpwAFfkCAm6mWZUNRXmYiHz8w6/kaejynJYdFqkH
    6oobHdDfyV+24Fm99u3GOlahxotHiPIAujPGjqKyV9GL+ejSHasnzU6E/+PT1MVexf4nz9
    A+nbsIsOo8xFYJfrxW1L4N3HFHTzjQOKPPPTuhvJorgkA4hYitRJbrUnaum0lmgwSJAulE
    ce7DSJ9Fa7Zo4z4fIkYnCCpgA6YsANsMDxaex3LNuT8toaNAFNY4oS0xj9fg
X-ME-Proxy: <xmx:C7JQai6SCHS5qpAqrAtQEZuwbJXMjqVUe6Pa72EuG3ljiaMXA1owMw>
    <xmx:C7JQaiwNxSvT2kBbq1Zue3GtUE4PmJPnl4D49oRxT8HOk9PWvYGAhg>
    <xmx:C7JQauak3QMSU0ZHpoMhC73CIv0hkdlEhI4_qy9Fekb5deHyDavC1w>
    <xmx:C7JQasTjYK0Okz4XyHb5NAgvBf_NMRRYXBoa7ClVXpGGAd-RBEdAWg>
    <xmx:C7JQam40fw_oBwIMTnpXhGXw9nyyfihfZCjAByH_ez5GFsMQWpSes95_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 04:49:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9b7b197a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 08:49:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jul 2026 10:48:56 +0200
Subject: [PATCH v2 4/8] pack-bitmap: iterate object sources when opening
 bitmaps
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-pks-odb-for-each-object-filter-v2-4-3710a9cc165a@pks.im>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When opening a bitmap for a repository we perform two steps:

  - We first look for a multi-pack index bitmap in any of the object
    sources connected to the repository.

  - We then look for a packfile bitmap in any of the packfiles of any of
    the object sources.

Both of these steps thus iterate through object sources themselves, one
via `odb_prepare_alternates()` and one via `repo_for_each_pack()`. This
layout makes it hard to introduce a way to open the bitmap of one
specific object source, which is functionality that we'll require in a
subsequent commit.

Reverse the loop so that we instead loop through all sources in the
outer loop, and then for each source we try to load its bitmap via
either the multi-pack index or via a packfile.

Note that this changes the precedence of bitmaps in one specific edge
case: when an earlier object source only has a packfile bitmap, but a
later source has a multi-pack index bitmap, we now pick the packfile
bitmap of the earlier source. Previously, a multi-pack index bitmap from
any source would have taken precedence over all packfile bitmaps. Given
that object sources are ordered such that the local source comes first,
this arguably is an improvement, as we now prefer local bitmaps over
bitmaps in alternates. Furthermore, we already warn about repositories
that have multiple bitmaps, so this setup is broken and thus arguably
not worth worrying about too much.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 69 +++++++++++++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index eda38a5433..e32795a595 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -680,60 +680,53 @@ static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git,
 	return 0;
 }
 
-static int open_pack_bitmap(struct repository *r,
-			    struct bitmap_index *bitmap_git)
+static int open_bitmap_for_source(struct odb_source_packed *source,
+				  struct bitmap_index *bitmap_git)
 {
-	struct packed_git *p;
-	int ret = -1;
+	struct multi_pack_index *midx = get_multi_pack_index(source);
+	struct packfile_list_entry *e;
+	bool found = false;
 
-	repo_for_each_pack(r, p) {
-		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
-			ret = 0;
-			/*
-			 * The only reason to keep looking is to report
-			 * duplicates.
-			 */
-			if (!trace2_is_enabled())
-				break;
-		}
+	if (midx && !open_midx_bitmap_1(bitmap_git, midx))
+		found = true;
+
+	for (e = packfile_store_get_packs(source); e; e = e->next) {
+		/*
+		 * When tracing is enabled we want to keep looking to report
+		 * duplicates even if we have already found a bitmap.
+		 */
+		if (found && !trace2_is_enabled())
+			break;
+
+		if (!open_pack_bitmap_1(bitmap_git, e->pack))
+			found = true;
 	}
 
-	return ret;
+	return found ? 0 : -1;
 }
 
-static int open_midx_bitmap(struct repository *r,
-			    struct bitmap_index *bitmap_git)
+static int open_bitmap(struct repository *r,
+		       struct bitmap_index *bitmap_git)
 {
 	struct odb_source *source;
-	int ret = -1;
+	bool found = false;
 
 	assert(!bitmap_git->map);
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct multi_pack_index *midx = get_multi_pack_index(files->packed);
-		if (midx && !open_midx_bitmap_1(bitmap_git, midx))
-			ret = 0;
-	}
-	return ret;
-}
-
-static int open_bitmap(struct repository *r,
-		       struct bitmap_index *bitmap_git)
-{
-	int found;
 
-	assert(!bitmap_git->map);
+		if (!open_bitmap_for_source(files->packed, bitmap_git))
+			found = true;
 
-	found = !open_midx_bitmap(r, bitmap_git);
-
-	/*
-	 * these will all be skipped if we opened a midx bitmap; but run it
-	 * anyway if tracing is enabled to report the duplicates
-	 */
-	if (!found || trace2_is_enabled())
-		found |= !open_pack_bitmap(r, bitmap_git);
+		/*
+		 * The only reason to keep looking after having found a bitmap
+		 * is to report duplicates.
+		 */
+		if (found && !trace2_is_enabled())
+			break;
+	}
 
 	return found ? 0 : -1;
 }

-- 
2.55.0.229.g6434b31f56.dirty


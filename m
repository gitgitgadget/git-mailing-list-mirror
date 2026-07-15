Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287E3290D2
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096573; cv=none; b=jhP/WzCc7tWi5YmWbNn8H9DAZBNl2if93GdF3tCW7e8ICIryWIpzFp5DpfzsgjYQ/l7+JQaFzapkUy9b0Cxp6ckyUVta7ivtYAxV94t/23uKaep1R2h9lqv/GBRI09lk/j63CCi3hfMC9Kf5ScJ/2kSlrRFOsJORd18loLPLIko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096573; c=relaxed/simple;
	bh=sUs/5J0gyVEk15a7cxdSPvH1SyYD7BHmSFzCuW2GeiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+GSuWjofAQZlDnNdZd1zTQ6NdexQdfhXP5dt7QK5PHGGGRMu4jQhpGEb+kERVyS4opCx9SRS4GUMx5G6ow2dT9ZJfZJxMsvSwQg0erNaBjAuerBkwuVW/gEYiEBY7PBesUnYPeusRzEl4Tl/pL5Vc+C/XUO6uACODaz8FtRyUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oL91Sx1G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jH9a0rWa; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oL91Sx1G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jH9a0rWa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C9F9C7A013B;
	Wed, 15 Jul 2026 02:22:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 02:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784096571;
	 x=1784182971; bh=6sFCWdpsMVREd5y1cgNbWRkHHOFCFyVfy3d3dZ0vslI=; b=
	oL91Sx1GzMUdL859bufnLASka0Y6Mae/FIMNsSPRwOVoPIDN3PDKwZTDIwSo8ZhN
	ldkufrunJAtaPpk3pTMVee+d8qn/67Y8IDCuZNR9JB5FUxoAqI4Ocb8Hgo1IJHbU
	TLFzv47YdDEf8n6YxfNqQRSAMrC7qTCAAWY5UDtsUW06//WeFFTVY9ynrgIm57cE
	LQo1yN8T1mV15IvoLd9vpgBuOhMMP8QSpqMpQJBXh/H42XEQ9NBUvop3u6wwLhWN
	mLX8cpjF7m5G80S7nfzKV5pm86NL1mD2+6XfC28BctaNyY6/N75GbISer0QkNxpr
	ky/GjYmCis41dOGt5WHs3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784096571; x=
	1784182971; bh=6sFCWdpsMVREd5y1cgNbWRkHHOFCFyVfy3d3dZ0vslI=; b=j
	H9a0rWaunroo7o6tL4OPR2yLu3Vgv7LOpa452HsVlCPotl/JMhFS9QXruabVOHQD
	LIuFJA92QFlthIotGRS9pv2T5P5CF2u9BnS02fPE77cukmuwBDProSgGfxEa6P7c
	g9n8LajwVSXwxFFLL4NVZRgiEPuIyKhJo0ojhMcg6FAN/RyPUC3KzF9qhxdBq+VY
	GXJKXVtmX5pkv+w3qL7KEHobtRMa505nI9JnzNO3mphrhVhHwIpWSDWEGgcTFlfy
	9zVt1BHkxXcQFaexRJbbCrwCz78BUGtO3nbLp/BcY9Kl3jb+U2DwG06qpoo7mIk+
	Em7qlKuiXrIWR/6anezZg==
X-ME-Sender: <xms:OydXatQXi-tA1XU_XZamE3sR7EvoilWBc46o8pnQUwe0432hfakBLQ>
    <xme:OydXaqfeggga93eB3RKOMaSEvxSusIxQe6J-FTGvG8GE29Cpf1wN_yXsjAztDkmKH
    isuqUxPQdlMxINVs3Wq6ZdZkaarO4w_kc-2zNcGZBotxjtAN0TlXw>
X-ME-Received: <xmr:OydXasoxepBsg3LLnsKhd026cT6Pi9r5gHETngpXSrxejwnkJlepZSrcykubVLXzxZNeCA3VPnCNyw4qQz6vBzfjJkuQ39gqn3A88GX9yp0>
X-ME-Proxy-Cause: dmFkZTFE+YB/+tAuPzC/TvjlXEPq4aubpa6Ljtxm2DA3nhwEKViS4QAXVCAGF2wRqpD2tG
    rjqCj7yrsh2K3uZv6BicpW5yYVDxtAn+hMsT9FU7TKtbZqakq4uWROhTjl1al8fUmioom/
    gefFG9Bba9YcV+ffziVUcMJmrNrrzA1KCy4PmFtbw9vUYPLeSjOeBKQy1qWCBKQ/50XXpB
    m/31leo7PRkC9756xsv1BKVgX6QCG7e5YYGSgPuf8wI3G3bR95XgOr9DD596qSCfzNLZcs
    S4vIMLLbl/r0AJQpYarwXHNGipYH7Jk4IaGmmUxih8kNXIrTailxiil1zVP+0fyXZKWziq
    kkyTFfQW8ZgmoTm0Jtz/64Z81+jrkzCfV122siiDVRIvQsSLp1flBNiOFWAOSGgPBrm1FI
    R+lvfynIrEcdHIdzEY7fFc9V/rcZIv22ICt1gEUrQHmho3+5U5l1Co4Eh6UHtHrjSPzUqI
    geaV7mCRkn+Ihj0HB4e2oZ0w9XfW9eNHwvAX6QfZM/ojTparHw2YfpMPMxVumTunxX4y8J
    lN8dvq8GhvSUqKlPSmYgSjTJhrAxES9H3gCBaSLSsfq9H4yJtTp/z3/l5PbvYfsDObEXJn
    5TU6p78jar1IVGD1C/0FJPu1Az1VsAbXHbZUMs0FDGEYV1CaJBvOIZAo2YuA
X-ME-Proxy: <xmx:OydXar8e6EKLcNy_RNu_Iuq35U0Q-UtvrK5_qKpfY36Vkt8EeOIg8g>
    <xmx:OydXaoeA_mi4TjP_lA6e_ZJPD6gQMke3ZGGksPgCE471_hFn6_pWzA>
    <xmx:OydXalIienmMn4VXBLxHeCFv1uk4MUfC54Fu2ztfwEj4W4NnGX-IbA>
    <xmx:OydXaoi_dkF1fWyGLJMPuSMAiw78iqpLkLYRuQVOSrpw7-7-Zt1wLQ>
    <xmx:OydXaqIIQVjhv16GuxG0MMXs1NqAKtPkIL9Vby4ep3xHOgzj3mKilpBM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:22:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0087b28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:22:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 08:22:35 +0200
Subject: [PATCH v4 5/9] pack-bitmap: iterate object sources when opening
 bitmaps
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-odb-for-each-object-filter-v4-5-616d7adf7fb7@pks.im>
References: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
In-Reply-To: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>, 
 Toon Claes <toon@iotcl.com>
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
2.55.0.313.g8d093f411d.dirty


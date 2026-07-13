Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8543B495
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953706; cv=none; b=UJ+NAd4Vw9NA8dC22jtfPArLzPqIlqWLm2tKsfOywBRNhGR7C1qMQWaO1sFeHdNDrPeVHc0aFVTtKkUWsZjBoDf9D8bUIHZX/QhZIcFGVVd/KVaOD/+rqZx71i58vrLewxLZq3x19l4LcNkwMczJnYDQP6qgAbffT63HIMeUg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953706; c=relaxed/simple;
	bh=sUs/5J0gyVEk15a7cxdSPvH1SyYD7BHmSFzCuW2GeiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GrHVhzFp++W/rnsbt+WyGdL9dK471GA19LvJu2u5HK85qIAjvjy2YwV7mXt2RI8Gn+fa7MKDPbc83XanWHf1+suj0AzsiSL3ANG4MJz69ahZ6gSJRXGwPHLUMtcQ1n6j2LLHJlrcJojAZtmHtdT9AcNmb6fR2RZo/ETcumtvYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GFESbAi3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ye8UDX2e; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GFESbAi3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ye8UDX2e"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 771637A0044;
	Mon, 13 Jul 2026 10:41:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 10:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783953704;
	 x=1784040104; bh=6sFCWdpsMVREd5y1cgNbWRkHHOFCFyVfy3d3dZ0vslI=; b=
	GFESbAi3V03gfoCmayzqzqVh+cKhjIEP0LSbV0OsvPfOxEws3xClaTnCo/niBTAP
	eOms0ru+7tlJVS1tjTpEDrvZD8mrxVsG4Ab+xwL291oSfv9z68cWDANGbMv/GGix
	ZTiV+N7uCI5+4qmz2EnqJfRVMf9s+RiQmZoV3wnPSLlUMcF+F6kLqEyDS0bd6fNJ
	gk03aWX1G9r8HFa5Ii4r9l1rcEnXCmki5zTtvEF1pUaUocJjVweGKw8/VMWiNsiX
	QsonsqJGd1/oZ9ZCU7MlO41cKQ/ssLZCjwjCrZgOFOWj709bfCbDdMqdoL1PwRKV
	wHTRWjL21kiu1CSz9z50ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783953704; x=
	1784040104; bh=6sFCWdpsMVREd5y1cgNbWRkHHOFCFyVfy3d3dZ0vslI=; b=Y
	e8UDX2eFJ2MBZqTPyEMMyP9bZzCT4QdGu0LccsBDxkqU+/C8vRnvPtt+q52RLn19
	/S+pKlMI6ZjREP+FzPD6t9m6jVc92jWkWACDaqR4WLM0GzyACfF53eeXrkZTj5tC
	Dbhe2SmUAj+XeSqt8w/K98Hn5zrRddYBvY20nkfhj2mzk/ePv67voJjtdVdAwTzt
	XPhKuslyuErBlvXGLRIXA4pr2ZPjdYgWZ91TgcoA3Tvm0clwY7seu7flKr62emYg
	cCj0uM6bgW4E18MH5ihcEBAD+sB11fmsX0oFr4gHtF/mER70GHwvJL9o4g1g4FBd
	Ebnex5QO5j/hMPPhAuL3A==
X-ME-Sender: <xms:KPlUaigFpXYQ9RlLztVN-p5rYQoOGcC0ig1EjsMsDwNCUCwBkJOJSA>
    <xme:KPlUap4I8lLpohqyMWuKuspZMF80Lf7Ub3SlMwa39XV1x97ELp-99lvzyJMJ7HvOY
    5rEflrc7qJfkcB1dJG-UPUHeddTlkqoMPwHfzZ_C2Bhv3Mrxn4V6g>
X-ME-Received: <xmr:KPlUaiYyhl2C-IhvErZYIktPM2ZtJgkaS-eU9yE9nrnaMtea7oDBfqPo98Wz2MAJsSgdgia05Ph-HB-knINWT2wvXVt0vP7MscILMklr>
X-ME-Proxy-Cause: dmFkZTGn6tKk7yUEEDaQcAD5NnrbDs9+Jc2GaNrXe7GrrtJmjE5gyWDnOhf4+7nS4py03P
    l5qmkh0SoOOrRNpkdOuGZfY6MrMKnQb6IMuHenECYCDYu/4jQvITXA9up7o5myyDBe+LWR
    6PZ40ESf1kKbRkIcjld4t3oD6bOy3RvOFqAL0aM+pKPn2w3AazImWnEoJTT5R5DOm6qBem
    hAEZgHqwXRG8ZmkgXPpls7/ysIHqdYiJbLDhyMxIPircdziQ+x1RcJYaJxz9DUxteOKUAy
    HEhoWFbC8ZJDJPReOwdG0zIPqJ22iBIkcd1FNaKt4n0VoIFc+BvvsejFinEcl2wPoBhVYk
    Nur0/CzFJH/Rg9xwQCPJRjRRDhFPf3hA/lkm+Q1su/AR1J4SVRfjPKiGBJ2bMwRLyx89Wl
    fESH3fyMQ9CFshsk98uMXjpqhVpzf6DKkxjVnSi8899LZdvA5o6cCAl3mI+TNDASs0IdHY
    UaVjM+RXxPrefLuxI3G3zWFIUMm2M/UZW3G7gsOiqgwzgWP2XRs7KDv5mnFtJMF8cjtNPk
    JTeFgqB7iCPzfRKlQMLPc+EKZFra2DQvcN+pA8qI9aSXIrg4iQSkpmz/kNwAl6kKuZAEDX
    V1M8IZO8pbIqcehARykJa6DbdVeuuMvJ7yVEmgQ9OpI2rPG6HwyF94TZYtzw
X-ME-Proxy: <xmx:KPlUam6o2hc2EqkjpNfxnmxaS5J9Wwi51kZ1Z6wl4tVUjqRI1xiCJQ>
    <xmx:KPlUatBH6nmn-X37ha8iUQpQMCkHPOC2QTU6JIqF7RCz7A3KUpcHdA>
    <xmx:KPlUakfNAf0HHvU44KJeyBgwMT0ZCzXmn-Hx5V1IcrVX9ffewluQJQ>
    <xmx:KPlUakJ5333w1n7xIdUWTAMLEQHM_fgRaiWF2ubUqYh3AV7kxWaQAA>
    <xmx:KPlUanNTpd4F64dtJuFUGzoRMMKVqORq7y5H0iRdWbg3h2Yjvkv21VUf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 10:41:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc15dc4c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 14:41:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 16:41:29 +0200
Subject: [PATCH v3 5/9] pack-bitmap: iterate object sources when opening
 bitmaps
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-pks-odb-for-each-object-filter-v3-5-b3c65c641073@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
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


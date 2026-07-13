Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C047E43900E
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953709; cv=none; b=SiUxFja2fYwVXg0t+YWHGS9BENQhn1DTrijPSpqDAbL9m3j1NQeVEuyJTrN4Loww43jfM2GoLGZOJ7VGOvB+oYPR7XTCVuFEKULctWfCbUUOfVwT12XGdR4zCGth8ESjsumk3ZvSAMeuvJGKSX2KINoZHIgUbtqEdeER8QcW0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953709; c=relaxed/simple;
	bh=yIX7Nh5yqwyFJfBYbsyusdohBvkVrntji7/cJrtTPjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EDkZIAdN6fIuKEFkyHK0OT1fLxKuNGjxMYTvfBQAoMx57RYjlJAUYc8mem+jj4ortLD52THP0CY4+cI/ObbTsEe/YoydHp44Z47oapdRh1LtdVALbJMz3PWiQplB08JyNj+Sujn+i29/iy09LlJL8+eduVDerr2nv7QBu02O6SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K3ysGRNU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j09mGqvj; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K3ysGRNU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j09mGqvj"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 220011D000CF;
	Mon, 13 Jul 2026 10:41:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 13 Jul 2026 10:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783953706;
	 x=1784040106; bh=3mAmiJzGW8KF7qayVGCj/Rz1zqi6cvs4g54m3kzA7t8=; b=
	K3ysGRNUYFxBlfLrJb+hTTbHdWF4buBJM/Wbu+atxkih84aGvv09k0HNPMFMTG7O
	RYIjVhKmQ3SzN/VJPuDR7wV7ZxTknmdtkq+KNhL3g6sKrNqw8Kxl+DARIzblpIyx
	luivWkueeMMdl3b/UgicKz4kOgjaS1+Ew5mKCbCu4exEizE/7B73koCZxMvgylTp
	6Df+vWU5eeAZ0n6ejjMpG9F173Hkn8BTIVxE3SYftwIoi81YoXFxbIJhUmZB1AH1
	0W0BWlIew2G8i/qIQYFK4XUSKEjubdWOwk3ax5uvHffFvWrFjJUhuWg1QNc5CSdN
	52vtHiAgl0fsbG3F5dKWuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783953706; x=
	1784040106; bh=3mAmiJzGW8KF7qayVGCj/Rz1zqi6cvs4g54m3kzA7t8=; b=j
	09mGqvjtf53OGByLkJ5rb9sZ4g6s1THXGsT0OMJdiZGuVh5YrxygeUD8fS1QkCI2
	ldRl4svU1CUSFtbmiNpvqUjK5KnYlmZ9aLgmgCNnQ2URlYLAiJr6gR/NbaxBajx0
	gFZVAzLUhVhdg5gB+JvqCI6YeKA8GRwSH+1XIWnuSxW6TWX0pcOoxajjvl2pkm8z
	luuZvWj4Sd9XjWBtjrGrQA/WkVOX0SBXiy9GJo0s2XlYEpkcMrrByHddwb0P65mL
	vzHxQy0VFnRUDYNXXZswgd7YDXInR5OKegCIcHNI50173Ncg/KEoSlanJcoUUuq/
	VmQIo97gx4pOBhUpIYb2Q==
X-ME-Sender: <xms:KvlUase0iCBPoY0_hnRdU8FGqyxPCU8FYQZo4vcyYB9hulx-GORK3Q>
    <xme:KvlUalGpQAFiTbMmzQEAMx6Bu1Z7F3gdUst7QGCEAfsJw6Mj_2UmoxcUxc0lzS2jw
    8BuebiT2QNiYeGRNO4FbWCU7DNsoQQK0FH0rvFL5ajEUeD6oMNhIQ>
X-ME-Received: <xmr:KvlUal1wZZid-Cn9EGMZwXH_YbJ6QTRUB5rhvgion5hYkJVXuRsFAHGJhb2seZ5c3RQjhJZnRXEEySyTu5VyeK-6sRhYGcvMocNyYzxc>
X-ME-Proxy-Cause: dmFkZTEQ6g5/0iHs1/J0Cw6D1Nr2w7QP5JQyCmybK7LmJAmWR5IAadxB/w22iVGO+Bhkni
    zYktWO6D2Y9o/KYnsGfTMpnpZZXEfX7SsJVRjhgkV4YkDBa5Rh9o/+9nRL+SyojsU2umq2
    a4CFGNxPb/4C7Y6kO9jTojknMu/t9nxXnETW+oQ/gtyS0/9CS0LAOs4W/wXFwAsC483dAu
    FHHRCzOAUCKqZkDbPLYu+qIAh5cNwHTOdUHT3Tgj2pOLIB1MlLrHMbf0Fug15+nm6TWPfT
    peKb/JrtrSX93ZqGH+sKPLh5knn51U/AMWSmQvMASvGJN7kDLhUgT9SySbIIal4G3T3JXX
    HadRUiWZ5ai2NenUlzcyfmeueFoKA3y6rD3ACraEkfv8Gp3Dx2f60WEBzJuE/qXP2MCvsx
    2trGeWlfdMPR6lYAhcfquq9hoEuI4epDwyhjM0M+EZ30ThjmDT6pwH6VEaXxP5yfQ840pJ
    Mc+3KTlqqVN3xHBCwc9S4KL2FSkz87byARrDlBH3O0JzbBIObPf+oLzocxXJGhoOk+3y03
    tp8aB5Q3AszlTKbyC+7llvOrpuB6ZIkLBC9nRjT9XZrLZYdaj9F8CpwfCvknss95lUGCx0
    0CP7KHWYnAnkFtR90KOiKXPX27OJPF0MK0Zl84/ARx1ui8NQDjwMoizensdg
X-ME-Proxy: <xmx:KvlUatmPgcdsbA2Ser8DHvWRJa7sfIzZpNp34w9AFgJQIsxQSVlYWg>
    <xmx:KvlUal_yiFgb3Nj0IOcUNPLfXM5FKmf5sIW78avt1wc1ncJ9X1g6Rg>
    <xmx:KvlUairmoJGOp53bZniLy15qymBnvXaJ0KIIqfeE8oRNKtclmawRbQ>
    <xmx:KvlUaukDPYHRaJsCYs1-bT7cvDPwOZRw4U7mScsyIQPvJMIDyyjohw>
    <xmx:KvlUaj4jMzy76_i5bbAeYKtKnzHFinxMP395QqTaP4gGTwDkbVEOo_cd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 10:41:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 282142d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 14:41:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 16:41:30 +0200
Subject: [PATCH v3 6/9] pack-bitmap: drop `_1` suffix from functions that
 open bitmaps
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-pks-odb-for-each-object-filter-v3-6-b3c65c641073@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
X-Mailer: b4 0.15.2

In the preceding commit we've refactored how we open bitmaps. As part of
the refactoring we have consolidated `open_pack_bitmap()` as well as
`open_midx_bitmap()` into `open_bitmap_for_source()`. Consequently, we
only have their `open_pack_bitmap_1()` and `open_midx_bitmap_1()`
variants left over, where the `_1` suffix doesn't really make much sense
anymore.

Drop the suffix.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e32795a595..72c8ae3228 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -460,8 +460,8 @@ char *pack_bitmap_filename(struct packed_git *p)
 	return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
 }
 
-static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
-			      struct multi_pack_index *midx)
+static int open_midx_bitmap(struct bitmap_index *bitmap_git,
+			    struct multi_pack_index *midx)
 {
 	struct stat st;
 	char *bitmap_name = midx_bitmap_filename(midx);
@@ -539,7 +539,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	return -1;
 }
 
-static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git *packfile)
+static int open_pack_bitmap(struct bitmap_index *bitmap_git, struct packed_git *packfile)
 {
 	int fd;
 	struct stat st;
@@ -603,7 +603,7 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
 
 		/*
 		 * The multi-pack-index's .rev file is already loaded via
-		 * open_pack_bitmap_1().
+		 * open_pack_bitmap().
 		 *
 		 * But we still need to open the individual pack .rev files,
 		 * since we will need to make use of them in pack-objects.
@@ -687,7 +687,7 @@ static int open_bitmap_for_source(struct odb_source_packed *source,
 	struct packfile_list_entry *e;
 	bool found = false;
 
-	if (midx && !open_midx_bitmap_1(bitmap_git, midx))
+	if (midx && !open_midx_bitmap(bitmap_git, midx))
 		found = true;
 
 	for (e = packfile_store_get_packs(source); e; e = e->next) {
@@ -698,7 +698,7 @@ static int open_bitmap_for_source(struct odb_source_packed *source,
 		if (found && !trace2_is_enabled())
 			break;
 
-		if (!open_pack_bitmap_1(bitmap_git, e->pack))
+		if (!open_pack_bitmap(bitmap_git, e->pack))
 			found = true;
 	}
 
@@ -746,7 +746,7 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 {
 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
 
-	if (!open_midx_bitmap_1(bitmap_git, midx))
+	if (!open_midx_bitmap(bitmap_git, midx))
 		return bitmap_git;
 
 	free_bitmap_index(bitmap_git);

-- 
2.55.0.313.g8d093f411d.dirty


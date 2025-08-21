Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249F2E9ED2
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761994; cv=none; b=b6ZcOz58I3U5yvIeT3NdCip+9+W2vlP6ni1Vih/yBu0e4yZTexbd6/pA8if45X3WmP0yEbTdx/HhilrQeWVaiXE4Osc9/VoCTnZHM+KLWO49bUux564slC3w4LuEMU6GZqppXZa7U3AbGvjQU9eCcNQALYeEcRr9hlfN/LfUNeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761994; c=relaxed/simple;
	bh=+HIoJ/KoZG0w3LjEUoPq/i3ALcjMB5HA9jXEGti3qFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLR8KdzGSDO3VDy03SrKMiscMQP+B8YICRZwh78798fSmmCrESB5RaAKg9+9Hrl3/SH9W4Juzvl01yScxujoSb5MDtWbJBLFdkmyqoExImP8XL3UvVDwb99HbEq3rglcKfW/xU8S7tCIEV9HwFQZdOWIAqyjMMpNGd0Vc0PkLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fo5X1Ywj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xo/aq5zJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fo5X1Ywj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xo/aq5zJ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 2308BEC00DE;
	Thu, 21 Aug 2025 03:39:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 21 Aug 2025 03:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761992;
	 x=1755848392; bh=Ig364nzAXyCodd/pbxbLGF/GYr4x4lRvicH1056RJpk=; b=
	Fo5X1YwjEqTxxbsGDYLwqU92vKCVV+J2YqZnLUYDO+pdQGbs3BREg/ofIntzEXIZ
	HfKTvSf9E6kjEfVOVG9w0OX7BRi1A9zPyiduHEUC0K82CrPd7neAh36AU1AoZOdv
	lp0HMmRB3MdYFBECSIVKD5ckfqQ3bv/qQOKUh0BJdZIvpF0ysP7esmEUfHmqYR/e
	nbwzDLyXuE+Nq1wr1m0Ktj+MZfPZxxwcVYDrK/IXfMCo9srH9fsrIfrvoZOMnxb1
	5EHmLaWMaIGLQzO2A1OLMow0tlb5otwQmxHSX1iQA0Q+Qo661sgbpu+gi6b8eygL
	Ch8ewquhqEvoEU1vnzVarQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761992; x=
	1755848392; bh=Ig364nzAXyCodd/pbxbLGF/GYr4x4lRvicH1056RJpk=; b=X
	o/aq5zJxVcLPa7PZxu9RvxxyBKqiCtjaCjr0GONPisVDiWCYjIb351Qm4LVpPShs
	Y2ckI8S6O7GAWx5caogZEiYZhKYs3M9XadSDNP2+jryPfQ5tUhBpv0CxMXZAd4B0
	PLDXG71XJLHRxHWHJIZV96wIxuNdboUwXIfOwOzasX1f1IVGBWj0Q32NfYx44gOS
	6/71k7q6zrazTAjh080M3udTVsje2TPmTbWSuyAnpuJFT2wm+LhEkBoWO6/+lZo9
	yMudaGaQk73XaaMrMURNRoen/+3NpU2+RfkEpxwknwuiLcvcgxW/rPZv9XBwSPNH
	5sadomndkcoY0O4A5J6MA==
X-ME-Sender: <xms:R82maD7JxopIxvMPlhxEMKkDyuehA1rtwhcz8kSJ903uUmWdmEiEKA>
    <xme:R82maMJrFy1AQsJEXGbbi5VbldnyvSBsUP7ZjhY1slPe210Wouaoe4Z5dFDwLImC-
    8SuiTm1anYbF04z7A>
X-ME-Received: <xmr:R82maD6xa7k6S5b-TG73TK4nMAqHmO-M2PT2Lgh82LVY8pVRocYGaruokKfoRj70sYSkLG_wiYoSvM57gjDw4A59q3JIPzUVUp3KrR6m0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:SM2maPymoUdCJ3KrGTDy9l8pNSR1U_43fXkT_ggusUPZrtuV5vU2lQ>
    <xmx:SM2maHYCvD6oAcsb803y7kNLeajC7o-9O18OIDjrPqMrza0drhnjcg>
    <xmx:SM2maBQa3qatsN3SIRfxUz-blAZRJEvbnssA70LYas0VAJ0kTtmoaA>
    <xmx:SM2maBzTnV0ljNsdb00WCGwGmTG3v-vZLzBbUoy2TaqBymHeNieZFA>
    <xmx:SM2maLG8CpBBrjeqT100Mv_33dHO5mu7VVDW7KIG3Z0AVIeQgq3GdElv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1660a76 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 Aug 2025 09:39:12 +0200
Subject: [PATCH v2 14/16] packfile: remove `get_packed_git()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-b4-pks-packfiles-store-v2-14-d10623355e9f@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

We have two different functions to retrieve packfiles for a packfile
store:

  - `get_packed_git()` returns the list of packfiles after having called
    `prepare_packed_git()`.

  - `get_all_packs()` calls `prepare_packed_git()`, as well, but also
    calls `prepare_midx_pack()` for each pack.

This means that the latter function also properly loads the info of
whether or not a packfile is part of a multi-pack index. Preparing this
extra information also shouldn't be significantly more expensive:

  - We have already loaded all packfiles via `prepare_packed_git_one()`.
    So given that multi-pack indices may only refer to packfiles in the
    same object directory we know that we already loaded each packfile.

  - The multi-pack index was prepared via `packfile_store_prepare()`
    already, which calls `prepare_multi_pack_index_one()`.

  - So all that remains to be done is to look up the index of the pack
    in its multi-pack index so that we can store that info in both the
    pack itself and the MIDX.

So it is somewhat confusing to readers that one of these two functions
claims to load "all" packfiles while the other one doesn't, even though
the ultimate difference is way more nuanced.

Convert all of these sites to use `get_all_packs()` instead and remove
`get_packed_git()`. There doesn't seem to be a good reason to discern
these two functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c   | 2 +-
 builtin/grep.c | 2 +-
 object-name.c  | 4 ++--
 packfile.c     | 6 ------
 packfile.h     | 1 -
 5 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 1d30d1af2c..565afda51f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1422,7 +1422,7 @@ static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
 	if (incremental_repack_auto_limit < 0)
 		return 1;
 
-	for (p = get_packed_git(the_repository);
+	for (p = get_all_packs(the_repository);
 	     count < incremental_repack_auto_limit && p;
 	     p = p->next) {
 		if (!p->multi_pack_index)
diff --git a/builtin/grep.c b/builtin/grep.c
index 5df6537333..8f0e21bd70 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1214,7 +1214,7 @@ int cmd_grep(int argc,
 		if (recurse_submodules)
 			repo_read_gitmodules(the_repository, 1);
 		if (startup_info->have_repository)
-			(void)get_packed_git(the_repository);
+			packfile_store_prepare(the_repository->objects->packfiles);
 
 		start_threads(&opt);
 	} else {
diff --git a/object-name.c b/object-name.c
index 44b0d416ac..c87995cc1e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -213,7 +213,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 			unique_in_midx(m, ds);
 	}
 
-	for (p = get_packed_git(ds->repo); p && !ds->ambiguous;
+	for (p = get_all_packs(ds->repo); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
 }
@@ -806,7 +806,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 			find_abbrev_len_for_midx(m, mad);
 	}
 
-	for (p = get_packed_git(mad->repo); p; p = p->next)
+	for (p = get_all_packs(mad->repo); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 
diff --git a/packfile.c b/packfile.c
index 16384e0865..523c30c5a7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1029,12 +1029,6 @@ void packfile_store_reprepare(struct packfile_store *store)
 	packfile_store_prepare(store);
 }
 
-struct packed_git *get_packed_git(struct repository *r)
-{
-	packfile_store_prepare(r->objects->packfiles);
-	return r->objects->packfiles->packs;
-}
-
 struct packed_git *get_all_packs(struct repository *r)
 {
 	packfile_store_prepare(r->objects->packfiles);
diff --git a/packfile.h b/packfile.h
index 816b762770..15cb378781 100644
--- a/packfile.h
+++ b/packfile.h
@@ -211,7 +211,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
 struct packed_git *get_all_packs(struct repository *r);
 

-- 
2.51.0.261.g7ce5a0a67e.dirty


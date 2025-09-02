Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF0B2F068E
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810165; cv=none; b=rQZEQtUEsOpfeAgMmUz6Ymcx4tNajMkATLu32aMPSkBnv4FZNNJxUHlKREag+2Jm2+P75cWivSRpiXOdhJrEUYWooed6KHyk7jcefNy6BJJeem+2DXAZtgcgrU37RV7a4zkSvkvh2BWrTASODUPXzmMka9atrE4UUwrOpzd7SDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810165; c=relaxed/simple;
	bh=aoK3idNmnfkKSHKV8OaLeOyULnsdpSoZ03F0V7rH7aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lBcbjFJGqxZe6jpPmJ54Y2JTuuvPPoHRsmjpAOCDlwjRfmg+izKSUquYZUpQhb7ZPnJjjAcxQmUQ/ZhOP9nOsff945j9jAvrZmx56BP0djOoJ/ddH3uj/JYfo+i7D3s75Ky+sdsXC9xahF8iIpf9srQdPcoPvpZJfuPilOoSKqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MRy/wqmh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aPJESgNN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MRy/wqmh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aPJESgNN"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 26D58EC047F;
	Tue,  2 Sep 2025 06:49:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 02 Sep 2025 06:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756810162;
	 x=1756896562; bh=9cDKpzNizDfxif4u6RHqSOP01GZ7bjB1lmhIwRZybl4=; b=
	MRy/wqmhNHwMitcHsR7szdsXAH3+8gBM6EqxBf3eAJabILkWuou7jGQ5vEwxDhYX
	s/kEzs1gtI6SgxlVrP5A9dN0AL8i9PreuI7EoVl6Ybcqj1R0vxn9dLIAOFbg0+S4
	D2lrMohnDGejHqjCroKIYjK7brDU7X6vNz8dt5O52TEO90CtsoNEKpwQaEeTVe4D
	8NNeK/uu94kydnpwduwFCsgVeaK7V6SRFwWhKluamL3i9ya4NOjwWS5zHuFgrhUM
	2YLPvwx7dfwE1J84lHhYMgneFOg84F4+DQTvCzG96KvDLY87XGwbrJ0LIRuIDapa
	dHgVrVEvBI1zuyOQzLkatQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756810162; x=
	1756896562; bh=9cDKpzNizDfxif4u6RHqSOP01GZ7bjB1lmhIwRZybl4=; b=a
	PJESgNNOWRVX0h6AA3fSN9Srh4waq87YWjRxWnJl9/PbJcPB9AABi9/pm3+qCazQ
	UT8N/gMLufCZ7HFHg20tC+bBfD0iH6I4gtdxmzpb0NRjySS+gGT5Bioekt7q4d2I
	yGWDv7BUbLbWDaAH4pc+tfUduJ5O+t2MZjG2GdSUug9QL1mT5KUPdGHNVhCiPeUn
	CoNUNUDASbTc+56kN27Kv8KZGTRa2alM6t4N6LDYkAE4Xg3vGjFio8/YRF9ITJoW
	OVRYH5gZkpER4ucMp5NTqOixq6C0v7Y87httDVQTVWotb4/dwgr0u4TZQcO0Zdx9
	hvLwgmeJZn/acBbXoyZ5A==
X-ME-Sender: <xms:scu2aGV2w0nGNMHdt8WeweB4-67zkO6N7XwG4pcEtAsjquDfeBuRew>
    <xme:scu2aOG5xmLVqUvyhmcYtUKRX_BEoxjHBX0l9M8dyrFN98xjAg_kLL0GEa7wbJBoZ
    jlF3hoqacW72JkGag>
X-ME-Received: <xmr:scu2aA11qpgl6FYJCtzOOOUAdvTvC-PInqzg-2Vee-JJH93iiZ4_y1kXi5FO3dO-LVZtTQMKEHqYEuUr06_vgWgML40X3KpYWoohi5AphN4IHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepff
    euiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ssu2aINBz4ifKzKuc3iQXFiNQvpLOk057B7fcefFTJvzTn_c5VbRug>
    <xmx:ssu2aH7w2nchOn4h7pPr7wv3LES0_lZessailKZDwrHzBxWDfW-X0A>
    <xmx:ssu2aK3hqgpjVcC6VjGnESHb0JD81xPHyQ7Tcnw1uLsT-p6wcscGnw>
    <xmx:ssu2aAzGcBpbBAEI-aByTBBwZQ3NU6vR1v-2pLhM7zynmLVMuWrk4g>
    <xmx:ssu2aLZ5oas3B4kNhNccEBquoHDjtTKA4sfBuVMXcxscLauLrABkT37C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 06:49:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a658f688 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 10:49:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Sep 2025 12:48:38 +0200
Subject: [PATCH v3 13/15] packfile: remove `get_packed_git()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-b4-pks-packfiles-store-v3-13-6925278efeda@pks.im>
References: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
In-Reply-To: <20250902-b4-pks-packfiles-store-v3-0-6925278efeda@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We have two different functions to retrieve packfiles for a packfile
store:

  - `get_packed_git()` returns the list of packfiles after having called
    `prepare_packed_git()`.

  - `get_all_packs()` calls `prepare_packed_git()`, as well, but also
    calls `prepare_midx_pack()` for each pack.

Based on the naming alone one might think that `get_all_packs()` would
return more packs than `get_packed_git()`. But that's not the case: both
functions end up returning the exact same list of packfiles. The real
difference between those functions is that `get_all_packs()` also loads
the info of whether or not a packfile is part of a multi-pack index.

Preparing this extra information also shouldn't be significantly more
expensive:

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
index aeca06a08b..b3eec213d2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1423,7 +1423,7 @@ static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
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
index df9e0c5f02..ecffd2d5b1 100644
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
index 70355ae92b..faa796f2a3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,12 +1027,6 @@ void packfile_store_reprepare(struct packfile_store *store)
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
index a9e561ac39..34c2132863 100644
--- a/packfile.h
+++ b/packfile.h
@@ -220,7 +220,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
 struct packed_git *get_all_packs(struct repository *r);
 

-- 
2.51.0.384.g4c02a37b29.dirty


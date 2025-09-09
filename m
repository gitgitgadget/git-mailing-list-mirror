Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E932145B
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415829; cv=none; b=UF7TxHXMjawNgxTt/fdKFqYkaTbeDHG15nW0Eb5LukVz0SNwlgQyV7nsqN7x7sEMNroVWFms+9vVA7gBnxkIDiQuLA5BX3/c/Ro6srnjwINRGvy+pLhZU0MPNkUGMe3FLsI+jGqMu1w7PphgmiLk/PQqUCPfD9lvAiH32/ozT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415829; c=relaxed/simple;
	bh=e3zUbEfJ5IsZn+D2nxVs6yXsmvtfuBYcxcUZYFc0c/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h22hTD+WZ216vD+0qPkrs9qyyVFzQFNTtreo5xWlmNoqTz0ymisFRGhf8xEG0WYpB9tIyLHSua1aU0UpfKtYWmdwzcyvXDLIZi9uiJ+pj33xH7l3piJBjxhDWN55g79Br23k3JzXVkAxzaRnsXu0D0B0RceaVtZi+eC5+yDdJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AJ9ND04K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTZE4myT; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AJ9ND04K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTZE4myT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 66066EC0F62;
	Tue,  9 Sep 2025 07:03:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 07:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757415827;
	 x=1757502227; bh=CLasomSeBxvZGVCwU3O+6uq+6QgfXjvu938Kv18TYZ0=; b=
	AJ9ND04KVj3QfYj9i5fmatPkWrwBakBWrHAR0TyuThpow5CLgBECi7jidl7qKR+I
	p7MopEmNSscUIfvyZJlb0kWypRqL0mgG1vHXZ8ggWhfAh+9NQkETszuCy0yYU5W9
	RBARF9qk8DbxR8BhPZDxwte4o1fuybDuES4xRQEsqnEdFe78IwrR73M5qV0m3p2r
	mhxDoOy0o4e3vODQI9cWUL66DWUV5h+w8ZO3Fz2YTZh8IxoziLUqismIlN2HwCk5
	Ydld+ZNfEZx/0+x6/HDSlDeTbisReuBwsDfSiWph2CmUEOvIcirctG5U0+Tj9Ele
	WIzWW5jzmPtFag71sMGZGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757415827; x=
	1757502227; bh=CLasomSeBxvZGVCwU3O+6uq+6QgfXjvu938Kv18TYZ0=; b=j
	TZE4myTOiJ71Z/tjbEoUZrFsNGOt/UcjOdeKoylLdOPnwds04VOPvrsRj5dKxMbm
	yZOt/4b97YptEdi6JM/BO7uMTwkoYTGiwJllg0IGElLLPj5yflscvOHCTsWKCQDa
	+00Phpbm/4n2HgGVWfRpG6peW1+1c0rbvFyjREDDnYxDnpA3LfjEcwQNfuL3d93q
	e/6g7xVHrVEIw6FKc391ApRe0wTFKlLEcWdvcF0+FFVrGujwMtfKNutOgkmda3Yw
	DmFMuxtqxRwJcSrLxQSfvEiGJq9P07/0Cl5v1jZ0wOirPWDsGT6A3BVHVyvYR4hC
	RHbuPE5PI3/ywR3E/RgvQ==
X-ME-Sender: <xms:kwnAaN2WygNih_-DJ92JSUGjpHIEMB49dAa4X1thsMQwICGfVpRKhg>
    <xme:kwnAaPlcm_3FlXrn_RanrG1BBnmZZCKKZS0bVwFc-A14boiNTbyKoCfHxlshFB0SR
    y_X3DpFsW98gATpcw>
X-ME-Received: <xmr:kwnAaEV227kBkhkrGB1XeQYWm01wfVh3nSp1mSiKUwANZiTcPGE70x27WUVAttIX43CGje74NWKIMw9NPsiasBK-DqC_PShKm3sTA5u1YYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepkeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kwnAaFsWZWHoNufNORgN8S3HCRlxiw8dvcW99hmT3KtTl8ABYQG4GQ>
    <xmx:kwnAaHagANQYNyWGY7Jnbpe0P909GRfD4oEtLv3fshROGB0NowbIWw>
    <xmx:kwnAaEWeb2uINYshhNlFW3fH5oHw9chWDbdoOsqbr85949aGxPl09w>
    <xmx:kwnAaMSixbuAkTVX_Zmjy7YD8sOYYitccXOa_AQNL_nDBTGRC4D0pQ>
    <xmx:kwnAaI5-yDswZD3Y5Qd6sr8nKc2u64HvAdxym-TO64m88cNQBh8IRhAl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 07:03:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51af136d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 9 Sep 2025 11:03:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Sep 2025 13:03:12 +0200
Subject: [PATCH v4 13/15] packfile: remove `get_packed_git()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-b4-pks-packfiles-store-v4-13-151c4ba3619f@pks.im>
References: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
In-Reply-To: <20250909-b4-pks-packfiles-store-v4-0-151c4ba3619f@pks.im>
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
index e3ac7a2993..3d975e47f5 100644
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
2.51.0.450.g87641ccf93.dirty


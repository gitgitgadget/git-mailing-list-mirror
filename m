Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340C31CA6F
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758622673; cv=none; b=LnnpWI9lOc/QOAqanF1tiRrSYpm4niuj2E1iyUywkkB+r+EzrFxkA6qX7QMqVmfvBk0NCVvKgkJixlRfJ0YlHFyG7DCI6/3dWNVT3jUmJf9fCjElrkzEiG4gypnsImiwJH6gr/l4fOgCp/q/dGaB9JF5muIM3GcMpxLGzphOVsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758622673; c=relaxed/simple;
	bh=uIbwG6klpG4rmHDvjtfCtpibGntcQ3Cy187DDCGJ7YE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=taQqKc3gLqfyOwz6YIjbXKlk/xrPl2c4KY8Lt1+LTd8I+uSpRVGlm2JBgAFRfnFmGU7ABGHTwyTWLDOGS88GdD5XwaL+w8nSR320jqIrGsM32Y1mXdM4GH85vLmhNJ/czA+0BxQmL9cRIdM5B0/SMt4ySOv4vFMl0k7iJhCQB1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qR6Q6g1R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JLplO0ik; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qR6Q6g1R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JLplO0ik"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 945571D00260;
	Tue, 23 Sep 2025 06:17:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 23 Sep 2025 06:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758622670;
	 x=1758709070; bh=iTidVS1U9vhdzHSE1XJlUX/CcSnHGiEjnIZ4ShOM2EU=; b=
	qR6Q6g1R0x+QX/2muJswRmodhd3tjG9Nd2jIBAwu/zhMAbuxZsBJcyRVIde9Bmsu
	6vxMidrk+Tt4Z09w2MxrEltsPnxwu0GId7ainqOVx7LCuAGDUq6wUvMRadfr6mzU
	zIhuIfMtJuZI0HeOiLEXmbPizajfSmXCa93EO7oLoDzYk5AJmOPtAWDxVBXSPm8t
	LczLvDnxWcL8CSr4H95jzHZnYghc6OURp4+eAXHBtcsT02PXDZqQQD/ReKqM+L+L
	A0Gx/q1ysB90hpelGghHzayOv6DxID8f/iWomdJ8XyBWKMmyqVyusWBdkmo+yKnB
	gec9yXkoKTOmvo2MI/ORXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758622670; x=
	1758709070; bh=iTidVS1U9vhdzHSE1XJlUX/CcSnHGiEjnIZ4ShOM2EU=; b=J
	LplO0ikxmFOfDQEn5dGPHceh9zAlZSqwvc4jO9tkk7XjYziwoaUACdjVhginmTfO
	qWsSTKY5SYkSHo63QY/haaBt69brZCxaxOCmdXPEo2tFaeiieBObAmk4IYsJmTiV
	36fTsNHDH1CwY3SiXUAxVxvJEneX6I6sPBzDnnt1wQkmi+39YnUqaJL+oNwZlOnz
	NeQ3XMSU7/S+LP9hVlldBw9IrIjQbP1paTguDotMmRF+PXHQv/N3jVUhTCHhe5DP
	qO4kvaF6M+4yLfdUc+zYql9sqTEyzb/ccdBDpwS8Mxjli5Cfq6jRs0sn8TBAjvKl
	a4YcUf/LlJg2oOAvZFNrw==
X-ME-Sender: <xms:znPSaGRqZvW5_-hpBdDFts4uSlS9TLYbE_qzXn5BzdUe7fO-0hdycw>
    <xme:znPSaPdl0kO-4F7t1QoIHvt4H-IJLZe8ZlS8ZBDYuN2oeICq0ICtL7DrRERPAU49S
    hQmbleryF7FYs73hw0-cFloIVV2rD1xwbke6E7hfe2KbcLdCVvE4w>
X-ME-Received: <xmr:znPSaNquqGJpM0QpnLtPOb9dOQzzunz-dzT3T7dAh4ZF7Aqn4zpw7vpMPxRicJG8oeowcx0vJfcsj51ZPaMTYUt-E9NXuW_t7OnpHJW4J6rm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:znPSaI--z6-quF8jGn3YorTxVIfAd3hOHUp8cJ2M2sXisb9FGzxNqw>
    <xmx:znPSaBds8pSzRkl1TuR4By4P1X163N2DvVm9oVSrSbmd8Ay47RxuUw>
    <xmx:znPSaKLOuF4J-2p61I9W4mi1Nsw7uOfMDQNtrCan3RVVzJJZMkMOCA>
    <xmx:znPSaJj9tWW4UiZBGYjZiN0oDQuV_A1_Bec4WskkhGkmCyhmnMTfAw>
    <xmx:znPSaPsTKVNIgba97h8cs-iOcRipEVbNnHoTe7z6UsAer4P1G7_wl0ZW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 06:17:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f45fc66 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 10:17:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 23 Sep 2025 12:17:12 +0200
Subject: [PATCH v6 13/15] packfile: refactor `get_packed_git()` to work on
 packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-b4-pks-packfiles-store-v6-13-b48f2a882759@pks.im>
References: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
In-Reply-To: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The `get_packed_git()` function prepares the packfile store and then
returns its packfiles. Refactor it to accept a packfile store instead of
a repository to clarify its scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c   | 2 +-
 builtin/grep.c | 2 +-
 object-name.c  | 4 ++--
 packfile.c     | 6 +++---
 packfile.h     | 7 ++++++-
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index aeca06a08b..ec6735a540 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1423,7 +1423,7 @@ static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
 	if (incremental_repack_auto_limit < 0)
 		return 1;
 
-	for (p = get_packed_git(the_repository);
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
 	     count < incremental_repack_auto_limit && p;
 	     p = p->next) {
 		if (!p->multi_pack_index)
diff --git a/builtin/grep.c b/builtin/grep.c
index 5df6537333..63a4959568 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1214,7 +1214,7 @@ int cmd_grep(int argc,
 		if (recurse_submodules)
 			repo_read_gitmodules(the_repository, 1);
 		if (startup_info->have_repository)
-			(void)get_packed_git(the_repository);
+			(void)packfile_store_get_packs(the_repository->objects->packfiles);
 
 		start_threads(&opt);
 	} else {
diff --git a/object-name.c b/object-name.c
index df9e0c5f02..53356819a3 100644
--- a/object-name.c
+++ b/object-name.c
@@ -213,7 +213,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 			unique_in_midx(m, ds);
 	}
 
-	for (p = get_packed_git(ds->repo); p && !ds->ambiguous;
+	for (p = packfile_store_get_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
 }
@@ -806,7 +806,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 			find_abbrev_len_for_midx(m, mad);
 	}
 
-	for (p = get_packed_git(mad->repo); p; p = p->next)
+	for (p = packfile_store_get_packs(mad->repo->objects->packfiles); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 
diff --git a/packfile.c b/packfile.c
index 7a9193e5ef..b37f43afb5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1027,10 +1027,10 @@ void packfile_store_reprepare(struct packfile_store *store)
 	packfile_store_prepare(store);
 }
 
-struct packed_git *get_packed_git(struct repository *r)
+struct packed_git *packfile_store_get_packs(struct packfile_store *store)
 {
-	packfile_store_prepare(r->objects->packfiles);
-	return r->objects->packfiles->packs;
+	packfile_store_prepare(store);
+	return store->packs;
 }
 
 struct packed_git *get_all_packs(struct repository *r)
diff --git a/packfile.h b/packfile.h
index a9e561ac39..0b691ded7e 100644
--- a/packfile.h
+++ b/packfile.h
@@ -136,6 +136,12 @@ void packfile_store_reprepare(struct packfile_store *store);
 void packfile_store_add_pack(struct packfile_store *store,
 			     struct packed_git *pack);
 
+/*
+ * Get packs managed by the given store. Does not load the MIDX or any packs
+ * referenced by it.
+ */
+struct packed_git *packfile_store_get_packs(struct packfile_store *store);
+
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a
@@ -220,7 +226,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
 struct packed_git *get_all_packs(struct repository *r);
 

-- 
2.51.0.536.g15c5d4f767.dirty


Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F032F60C2
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926512; cv=none; b=WYqm9NKY5Gxzj8kK1DIauLJFmjsP+bibUov0cGtHwgoXoF80+GJs2CwOAzqyhNvkE1R6Gh15rTl+lvo50YmCx+ev9IlH2Yzz17Nc2qIwoJHHPoAoX8nKqEkD1PMunE+L94sYpBgEQBoCSnbvMcKs8iHuhs6Ivmt/wcN9upWpwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926512; c=relaxed/simple;
	bh=JBeLddM+nwCwqcg9EFVylwKLR59S3NFYa2kB05ceYcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mlxp0rbEQUSjDyfPlySk9pPKv607HA3Ja/sVSDR2ut78Mi38mmr9vf6YqkckaxpjL7Zc8KIRCL0kJGypwEASFXeSr236iFrN9m14HgiWq1c/00OqHZK/hTccMlmHfnXbZo2UX0kJ0IvQWQiYOJVVWWcbHzDxFTkSBVvZLrr+O/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q95kFBuV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WWhr7o4o; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q95kFBuV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WWhr7o4o"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA60714001A3;
	Mon, 15 Sep 2025 04:55:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 04:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757926509;
	 x=1758012909; bh=+/Lc4IT+3x4XHyXQhwM4T+tWY1kvE/4W66ZsDx8e9YA=; b=
	q95kFBuVkctkO1z4eReQaq/jNAWtMKa6C/pE8TAVRHfpQcY+gBpsVGMnBxehYhmf
	uvW2eD2mfDuqym4jV/PTzi7ScuiFGE7Rhd91wjdR3EV++FSMgqqGS1j4ai7LbqBD
	5HBlCtkzxDLLKpQwUb+1svZ52XVXihUFPOsNIm/eAG8VS/TPfFvM3AHjYgjjsUhV
	bw9GZIZYojM4ZQ2UNnU7pvzHDGAUF0LNRbx1/tJSghBrE0UOpVXPjk5hHLTMTWns
	n6M5lwCw1XleskdQchp3is/cAac53bELUqdYIm5evXQ00+VVl281QG0HZ9WTw1Pw
	/kW+RIMZCHVjYy3VnnJ0PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757926509; x=
	1758012909; bh=+/Lc4IT+3x4XHyXQhwM4T+tWY1kvE/4W66ZsDx8e9YA=; b=W
	Whr7o4olmE1y2FuVwSZzmJqT+TqWDLj11Tpb2Ls7FEhMKUfm0L9kA5C4j2aXvZUd
	0jEMPoiMLasmiKdIVYD2drwDCgxFIjs6P88YWJRdRe4xKFOyk3Rn+ZAcOnaBgXDL
	U2TSGjM6Xn3FGHcFuPZbhWzxZg5Gp03uQOH4Cv77abQTeZLNd5h9w20WeEr0cJDf
	k9Ap3lCLM5JjTXipRudQT9m2O6Yfl+ZUTCat8tTyFjYPr92npCSSTJg1nTA5Ert6
	x3J0CWbF/+VzJHTYXOeZ0KltiB4PZXPItyBhstKF/DkyVbEDdE/PhP5iOIEvR11y
	+hEPMvwXeM5mYuuF/F69A==
X-ME-Sender: <xms:bdTHaE1dFj4rTg2FpSzki0vdWsRc1gavatag8PCptO4UWWI5zb8evg>
    <xme:bdTHaKl6Z_PVo1x5_G8DOxjaVNXDee1YW6pWXp8x9cZQHj-IRPIroP8v9FqoQpusK
    nPnV8Je4fz_8OZRVw>
X-ME-Received: <xmr:bdTHaDU6sMKQ0m6ZdAI2JQGU7GLbr9SwmmAsLdY-tH9Z6xMkY7wHtR4PCZRIiFXsSMGzN9PdcuWyrpniR-paXFYsyzJ_LHcW4z84SpRIzfFKnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepleenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:bdTHaIsjRg0NEQxphym6wVvE5p5fo0Zlu3W9R7DRf9xqsNxliD9PTw>
    <xmx:bdTHaOZd7PxyWFgzFsxfA6Dtlzz6d64nsDYIpdS5IhjEz5DB_LvYig>
    <xmx:bdTHaPXmQWdodH2CBZiELpO4CHMK4TRhdZEb1lo1EL63FguIATVUeg>
    <xmx:bdTHaLS13IPJCb4pu4FTKOK_qjlcheleTF0H30IDJLAZcWDMnO1V8Q>
    <xmx:bdTHaL7r6i-rYPuAtkbgzuY2aomZnfH6AVvdeCvwHbKeNljDuCoUAuAX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:55:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ddc21995 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 08:55:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 10:54:31 +0200
Subject: [PATCH v5 13/15] packfile: refactor `get_packed_git()` to work on
 packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-b4-pks-packfiles-store-v5-13-d6340350934f@pks.im>
References: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
In-Reply-To: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
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
2.51.0.450.g87641ccf93.dirty


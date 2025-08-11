Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5D319D8AC
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920016; cv=none; b=bCQzoqtCdYY71kJqv9JCQlS0oqOYZxdZC+cmwdCnnNRl2Q5B1CALVT96DhihCJ4muBTGoDmRcxr5UVwvFX5N7y3G+ybBEUZhrt3rKDAknRA50Vv8a2c5pdXCS6NY3u+W6EaUPszS2PEZ69wZOeu75xCZGuuwueHVcNunN6Qvzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920016; c=relaxed/simple;
	bh=Hr+HbvRYerASHcSqSoBmdX/a+IN7ZOM5g9pdu0Qgt2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MzX5gdglhMogJZ7NQtwCm5tML/ShR4w9Mev0/9iwgIzfUUQaxSjZJSQdNcoN6ADvIzykIB+VH4By22lw49ZCB8sflEnDkQqQbT1t825T9hHrQw+FMm45sPAbcdwS57I2QsE1XJGyJpKz8NJLzj95XbaT/p/U8s/KVQbnSQ9Vp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eT/Cr9ir; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1avkBVL; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eT/Cr9ir";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1avkBVL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D62E17A0057;
	Mon, 11 Aug 2025 09:46:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 11 Aug 2025 09:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754920011;
	 x=1755006411; bh=4Qgkl/PMUpMk5SO8OGz9gfkn6yOrEbeEfoHJdC5xkgA=; b=
	eT/Cr9ir2mPhZsnUtWbxVTlIuJl7rVV+SkHYJEQlt4QlJ7sSzcejbAGo81TZoHvY
	jsZF4mix7Wz2gYev7x0Jr2r77Z9Ge7yGkuSqaOCY0Vz9AtXjFudLcrtLfGAAtg1C
	0AMtFl9Xg9lhXt5JygA072QqCIcSc64mr05IDXUnYRKVVwTN2mcqNtlxwqz/NDLg
	rl/+B0TaFgmvnB4OPIWMu8ffc1m9l68c+cKSPPZ/HxaFDrAXtQhoP+WNfocvM8Iw
	Hy5ZA3mG7Kk60Wj0e+ZP+Hb2WL6co43GIril5KWy+Z5DUnML7Sj4ApFBshwc+ITL
	/dPd2EFM3lgVTW3iDe5kTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754920011; x=
	1755006411; bh=4Qgkl/PMUpMk5SO8OGz9gfkn6yOrEbeEfoHJdC5xkgA=; b=F
	1avkBVLnlQVHmX2cUCM7AuausaNHWbS2mxyaNNsFvDg7c1dTgCofFK7wLlWjpW3c
	DnthSmeNh05bERJil/+l5TVpueyFBesuG2D4IgJpoTamBeDwNnxIFcgpRoj8gWKo
	An28JlA4Lc7UIFC9BVZIUPbeNHX+56qopOUnRWTv1HS1TUB35RYB+Wk+2rcmy87i
	gbLYz3lT/1tneHuKCG2oGy8cJL5RqTCZYtutjjOZ+SgA+5o6bs5wiirvytnn8j0H
	aCLm7f3tMhWCO0zQSEDPcr14Lk5KNCpp15DgZ66dZ8BgIOaCDOhyJEQxcQLWUnqI
	WLdTg0QKbJx5PNNsmwOLg==
X-ME-Sender: <xms:S_SZaOpkD6c-kPLFe2eRqjd5AXiqhcl-0G82hoqkiIznLXjH5Sl4Hw>
    <xme:S_SZaILGAo34lVx1GjNkafps3fKi1SdcXo8S4sxoaAhRl-AOY_ZRLifQ5p9GnKE3w
    -RuMS-ds7YJRVSXLA>
X-ME-Received: <xmr:S_SZaJp7AMrYrmrGYTleVBIc6gQUJiPAAM1Qol7KUrnaLwI2JZOVhxbtPLcIOFh6oRoP5wCtTxOYcF9LbsuPz49NabQo-sTTLAhfoy-F0eM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:S_SZaIy5TiRe9atxnW7v2shOJ7CgRR9YAoS30zJAlIWEGxVAP4xF3A>
    <xmx:S_SZaFMiRamFLrJHjtyBZFv9MgQeH5cHB9fbRrgdrPH9AtNkFbW4xQ>
    <xmx:S_SZaF53AyQYSsHj9ngH6MfsLhwVdkkMuD93Pn3qkElYKcTblS0Kew>
    <xmx:S_SZaGmI0fjVw8ShUI-Imrs8yXhLjNLi2coNJ6Ya8oXlrLixbKWOQA>
    <xmx:S_SZaEsACnkwzRbr8BzhwieVxCPVILG0HwjN0KXOX0rRtMURFmcERoOB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 09:46:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 07066d3f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 13:46:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Aug 2025 15:46:41 +0200
Subject: [PATCH v3 01/10] odb: store locality in object database sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-b4-pks-midx-deduplicate-source-info-v3-1-e442bdf2b4ad@pks.im>
References: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
In-Reply-To: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>, 
 Derrick Stolee <stolee@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Object database sources are classified either as:

  - Local, which means that the source is the repository's primary
    source. This is typically ".git/objects".

  - Non-local, which is everything else. Most importantly this includes
    alternates and quarantine directories.

This locality is often computed ad-hoc by checking whether a given
object source is the first one. This works, but it is quite roundabout.

Refactor the code so that we store locality when creating the sources in
the first place. This makes it both more accessible and robust.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c       | 5 +++--
 midx.h       | 2 +-
 odb.c        | 1 +
 odb.h        | 8 ++++++++
 packfile.c   | 9 ++++-----
 repository.c | 1 +
 6 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index 7d407682e6..b9ca0915a6 100644
--- a/midx.c
+++ b/midx.c
@@ -723,7 +723,7 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
 	return 0;
 }
 
-int prepare_multi_pack_index_one(struct odb_source *source, int local)
+int prepare_multi_pack_index_one(struct odb_source *source)
 {
 	struct repository *r = source->odb->repo;
 
@@ -734,7 +734,8 @@ int prepare_multi_pack_index_one(struct odb_source *source, int local)
 	if (source->midx)
 		return 1;
 
-	source->midx = load_multi_pack_index(r, source->path, local);
+	source->midx = load_multi_pack_index(r, source->path,
+					     source->local);
 
 	return !!source->midx;
 }
diff --git a/midx.h b/midx.h
index 076382de8a..28c426a823 100644
--- a/midx.h
+++ b/midx.h
@@ -122,7 +122,7 @@ int fill_midx_entry(struct repository *r, const struct object_id *oid, struct pa
 int midx_contains_pack(struct multi_pack_index *m,
 		       const char *idx_or_pack_name);
 int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id);
-int prepare_multi_pack_index_one(struct odb_source *source, int local);
+int prepare_multi_pack_index_one(struct odb_source *source);
 
 /*
  * Variant of write_midx_file which writes a MIDX containing only the packs
diff --git a/odb.c b/odb.c
index 1f48a0448e..1761a50840 100644
--- a/odb.c
+++ b/odb.c
@@ -176,6 +176,7 @@ static int link_alt_odb_entry(struct object_database *odb,
 
 	CALLOC_ARRAY(alternate, 1);
 	alternate->odb = odb;
+	alternate->local = false;
 	/* pathbuf.buf is already in r->objects->source_by_path */
 	alternate->path = strbuf_detach(&pathbuf, NULL);
 
diff --git a/odb.h b/odb.h
index 09177bf430..f9300439ba 100644
--- a/odb.h
+++ b/odb.h
@@ -63,6 +63,14 @@ struct odb_source {
 	 */
 	struct multi_pack_index *midx;
 
+	/*
+	 * Figure out whether this is the local source of the owning
+	 * repository, which would typically be its ".git/objects" directory.
+	 * This local object directory is usually where objects would be
+	 * written to.
+	 */
+	bool local;
+
 	/*
 	 * This is a temporary object store created by the tmp_objdir
 	 * facility. Disable ref updates since the objects in the store
diff --git a/packfile.c b/packfile.c
index 5d73932f50..a38544b87b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -935,14 +935,14 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
 }
 
-static void prepare_packed_git_one(struct odb_source *source, int local)
+static void prepare_packed_git_one(struct odb_source *source)
 {
 	struct string_list garbage = STRING_LIST_INIT_DUP;
 	struct prepare_pack_data data = {
 		.m = source->midx,
 		.r = source->odb->repo,
 		.garbage = &garbage,
-		.local = local,
+		.local = source->local,
 	};
 
 	for_each_file_in_pack_dir(source->path, prepare_pack, &data);
@@ -1037,9 +1037,8 @@ static void prepare_packed_git(struct repository *r)
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
-		int local = (source == r->objects->sources);
-		prepare_multi_pack_index_one(source, local);
-		prepare_packed_git_one(source, local);
+		prepare_multi_pack_index_one(source);
+		prepare_packed_git_one(source);
 	}
 	rearrange_packed_git(r);
 
diff --git a/repository.c b/repository.c
index ecd691181f..97f0578381 100644
--- a/repository.c
+++ b/repository.c
@@ -168,6 +168,7 @@ void repo_set_gitdir(struct repository *repo,
 	if (!repo->objects->sources) {
 		CALLOC_ARRAY(repo->objects->sources, 1);
 		repo->objects->sources->odb = repo->objects;
+		repo->objects->sources->local = true;
 		repo->objects->sources_tail = &repo->objects->sources->next;
 	}
 	expand_base_dir(&repo->objects->sources->path, o->object_dir,

-- 
2.51.0.rc1.163.g2494970778.dirty


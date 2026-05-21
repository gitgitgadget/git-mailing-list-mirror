Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED93A5E99
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351800; cv=none; b=W6a/oosf11K43hXoPXE/uUT4jnsvlrVZ6P545R58BOFireLxhORC2RdG3PlKZzsTFv19jkm+1KQQmwAGnHOZxhD8MvnAoTCp2qhUIs3cZ9hGpnJ54+eKjkUhcwBs+c0WZFYRoEr4OGzHRG4dE1FgGH1NOL4wS2gW+5NC4Hivdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351800; c=relaxed/simple;
	bh=HoNxoecn1QPkVGWj6F/7iuAMAwCFcDWQkzaq3O3ZwKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bx245qW5pQcz/1n7bpIjJcASBgrbs8oK2KeiQRNIWzDYugsF5mhmRO2Kzw/1rzAi50ePuymx434iRup9ebE48y3tD8/Q393g1K99z2QDcv80NiJXAJO3TulcHLJU28gPURFRpx90PaVhKNbnkPweEp/odCAVjPWC0foYykz3i44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e5U2iEkB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=We4W7upc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e5U2iEkB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="We4W7upc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 525A0EC0067
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:23:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 04:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351798;
	 x=1779438198; bh=ND8+UeVpDyxlgUJ/YVvUQ/B6Chy6BL4bohykbU8zehU=; b=
	e5U2iEkBkNBSh7ZByN1Xme+hKH4z88kPAE3VlFawBREyj9HTc8CRO8c+rlPncWhx
	Gk2GYKIef9yNzvutF9vw9rxXYRKK/FUWo4b+S2EXXAL+Aaghv6olgHC/lqvwlAcu
	Pa+SfK+BdiHZpKWJayCCF39CpBab3NsGYLf0Gxm3UWZdoFwOFF2pdoTlrxTaTG6Q
	XCFOgx/C6vBA7ujcXPWxgBYxDjr+hQyMaRxjfXBnfpqwVnK8bkCyL1NBquyyASyK
	Nk6oL6CgvIFlcbRk+IGrzp2eK7/Ba69tSD0oTRU9YSCoiaWX1c4LrAqB3y028J/M
	YCEIUENy0w40jGpp4CpZHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351798; x=
	1779438198; bh=ND8+UeVpDyxlgUJ/YVvUQ/B6Chy6BL4bohykbU8zehU=; b=W
	e4W7upcoe3foQn5PyxvgFTHpZGm+NwUJ/dLNZ5DAoTAeOfxxLP+aydGzW27VwBzX
	JmBQKQptcVlbCUKp8h7UfxqeuHUpxjDKCWYWCB0ks9cVJrZgKkfI1Iz0ONWhviy9
	ywL9aor3dTE4AA80eKnG0EcMalW7BuD+PVUL4I8U1dWj8sxb8964megKc55x7S4+
	ZnCS/zxrmmDo7ptXR1QfNjDz9pmOUWJQfwP3tNTP5ubqSDPJ+k/cwVjMhZDPcbVH
	jrqyh8ZgNOGq7Ee0OhGtgZ5IrXuFZjYn9X+HLUEzwSPP7qNmISqewjfs1bwxBlGZ
	mUi1PtbrpbdsqGemUCQHg==
X-ME-Sender: <xms:9sAOag3BD0s7k0MkEirAVNKtQZuFa4guCPerbVZp8MMpVneOTZN_1w>
    <xme:9sAOaiD1wgFwufsjY7oWOzzzWZZYI7VmTbepswZJmUxHRauZcZhLCPmgc9vfjP_Ca
    pUsB4OI497ZYAe8cT5Kcxj32nMoIT0HES9_79LCjGK1H7GmWRuQaA>
X-ME-Received: <xmr:9sAOauiJ3x213aLJtgE3V5Fsp_CnqadSPQoQzjYBgfSxYf_0Qqp1NJ2Z9FpLCGRRrbhdE6kkSBkVYA5PmTuXxDqnCO0LnS8uecy3MagOhM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:9sAOau-oaUjnoLHnujQJrzO_y3X6_0x0qf5uGLBlzOFTxGOwAImBAA>
    <xmx:9sAOai-dPGJxZLgU_Yp0VQd1gI8sbDtg74bjgDG9wmrxY3VkfceCMg>
    <xmx:9sAOavATBrSB4fEN1Aef-Aep0iKnaAp-KB7MngL2VufkCO-NT9Fepg>
    <xmx:9sAOaqwmv6ymc2TepZMYeJZQLVUEqLSMdn8gll9sgNxTOdTIygDfOw>
    <xmx:9sAOaiESZsQDhIM6xIKSE9wRxzlN-qsqNWMkYxOX7drG1Agla0fRu5iN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:23:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b6b3511 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:23:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:38 +0200
Subject: [PATCH 18/18] odb/source-loose: drop pointer to the "files" source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-18-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Now that all callbacks of the loose source operate on `struct
odb_source_loose` directly we no longer have to reach into the "files"
source at all.

Drop this field and update `odb_source_loose_new()` to instead accept
all parameters required to initialize itself. This ensures that the
"loose" backend is a fully standalone source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 2 +-
 odb/source-loose.c | 8 ++++----
 odb/source-loose.h | 7 ++++---
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 83f8066c67..5bdd042922 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -268,7 +268,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 
 	CALLOC_ARRAY(files, 1);
 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
-	files->loose = odb_source_loose_new(files);
+	files->loose = odb_source_loose_new(odb, path, local);
 	files->packed = packfile_store_new(&files->base);
 
 	files->base.free = odb_source_files_free;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index e174941318..7d7ea2fb84 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -705,14 +705,14 @@ static void odb_source_loose_free(struct odb_source *source)
 	free(loose);
 }
 
-struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
+struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
+					      const char *path,
+					      bool local)
 {
 	struct odb_source_loose *loose;
 
 	CALLOC_ARRAY(loose, 1);
-	odb_source_init(&loose->base, files->base.odb, ODB_SOURCE_LOOSE,
-			files->base.path, files->base.local);
-	loose->files = files;
+	odb_source_init(&loose->base, odb, ODB_SOURCE_LOOSE, path, local);
 
 	loose->base.free = odb_source_loose_free;
 	loose->base.close = odb_source_loose_close;
diff --git a/odb/source-loose.h b/odb/source-loose.h
index 825e703072..fb75e3bbff 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -9,11 +9,10 @@ struct oidtree;
 
 /*
  * An object database source that stores its objects in loose format, one
- * file per object. This source is part of the files source.
+ * file per object.
  */
 struct odb_source_loose {
 	struct odb_source base;
-	struct odb_source_files *files;
 
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
@@ -31,7 +30,9 @@ struct odb_source_loose {
 	struct loose_object_map *map;
 };
 
-struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files);
+struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
+					      const char *path,
+					      bool local);
 
 /*
  * Cast the given object database source to the loose backend. This will cause

-- 
2.54.0.926.g75ba10bac6.dirty


Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1BD3624AE
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351761; cv=none; b=T+zkYy+O9IsQbtpPpMH/Q8SRSCrrDvwBZw8DzE3+8HCGoMRNQ36tG71cBFxdQtPNoWMKc5bw0op5SW3OBjGKoAM6Et/Z/EzzSybp6hsBIOuVGcJOcdbTGZr35VWCMpCvzURkSGYT57uIEyklCJxFJm5dGtOV+YaSgxL8urDtK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351761; c=relaxed/simple;
	bh=6e0dmOEecgMeFVQN54ihP03yHlTqaQYGqXjAVnOgRVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ugW+htkYntGPIOxo6nJmhFkvEtsYgOk6G2P3EFxJOgYYp1xvN3hfv9C5BDgoIitoky5kZ+0eig3K3QzQ/BKFJ6wmRoR4GJ1DPX0NdfzpYlk5UhdveHRdWUE+nyWGufTtU1GcrAj2SrcDfFNbn0kc1oihe2JH2NXw/UTJNu2AbXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k9SbCpEL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nwQC7lBU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k9SbCpEL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nwQC7lBU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C621EEC00A2
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:22:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 21 May 2026 04:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351756;
	 x=1779438156; bh=bbHftUDs+QYZ9baVg8bZoYPgEsIDBp3nK3g073uCtKw=; b=
	k9SbCpELYfgnnccy5ThioDu77KjBH4C+AMB66fk5TNl4ubIhaGVKwqBJG4glLpMM
	O09ajE6Fc06ywRrNpl57d2GPv6ckyJR7vmOoM9p7rXP7UuJdnOLhBApXkbb30T8A
	eHK8ZaNSNp93ufyYEINpTza5KbCqEYI3WuWz1QI2aPjI8XY5dPhm8fy+pdhRJBPD
	a06eNsk3ablKmpossQjDq2oe56XpBOo/sVybE6ySXM86tj+Owp5rFdMEfiFGS5Y/
	LbrxLPcRFmsWvsY6t+wwfUUt0u31+M9NHQA1ZGoMHx4XoROgPStGjhTFTRjaAefH
	aeTNZE77wdYQ34nMbk0xOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351756; x=
	1779438156; bh=bbHftUDs+QYZ9baVg8bZoYPgEsIDBp3nK3g073uCtKw=; b=n
	wQC7lBUtSxExrgcZQJOC4g0KbYUvz12gUs1YNUBLH9rBOPedNof1DARti6oJwlD6
	UaZGzqHsXcm35kQeWuqdvHOfevzpoJF6fdWoMw7enN1eDKbVIutxLJLou20qjwIM
	AYwECHMCULdC7vhUUBVKOyzMPx5OqoxJuF26i2e5vn+w0M7Lyj+yeDERpvG+akMT
	OdAguu6JWm4jk8SA09NE4p6ZM61v2SKydyNiePWSbnL/L7UqxND0W5P3JqxA3FTQ
	tZA7RNrDxSlgkFu4zt7j38B7Zzqj4JkLQdjM/dB8Jrl0AGOdHPSE28zPQKfmcd8j
	uoJJCwNg6c4qt4sygFicw==
X-ME-Sender: <xms:zMAOaofUdFQJf-rXAjmVTYZQSu_LV2wVUEBmxVEhWTXfgK7J1DhFjw>
    <xme:zMAOahLcw5GqWtsM45wh_MoeaEnKDB9wcakeA16pm7Dcpb2-LHSy3hX1R7pjG8k9x
    jVXMAgEKzgSDVzyH4tr6QJGl5f-qw54ayroH1Nyy9_pR-qOvRR2>
X-ME-Received: <xmr:zMAOavJK1wB_f6ajG-ZQq5pKDBW88XH1zl_hJc_VT-uiDWX-auC90rTbPhKyVPFZVp8JGlO5VabVaXVV1z5DU8InDQWTH7HR3yexN2piYv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:zMAOajHWjSRJKnKuqL037sDFX7atbnBOUoELWRfoqxg35og2l7GxaA>
    <xmx:zMAOakkuJZMPS-pI2sSDbKaZC8-EXzg3ldFspVTeSxQ7bb_lsjNloQ>
    <xmx:zMAOagI4YcmnjCgXu2N2lQUlbzZizXZpZBXtNrJ446cE9t09dq1VrQ>
    <xmx:zMAOalaujYODWQRIrHwuQ4JchxS-09hE8eq3gAoH1ukUcShFq3ifPA>
    <xmx:zMAOauMT2DNDF3T7g39zVGk6oqamGQlgP15gBcGUgJs6KGWM9vE0U63K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:22:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 034d6b3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:22:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:22 +0200
Subject: [PATCH 02/18] odb/source-loose: store pointer to "files" instead
 of generic source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-2-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `struct odb_source_loose` holds a pointer to its owning parent
source. The way that Git is currently structured, this parent is always
the "files" source. In subsequent commits we're going to detangle that
so that the "loose" source doesn't have any owning parent source at all
so that it can be used as a completely standalone source.

Detangling this mess is somewhat intricate though, and is made even more
intricate because it's not always clear which kind of source one is
holding at a specific point in time -- either the parent "files" source,
or the child "loose" source.

Make this relationship more explicit by storing a pointer to the "files"
source instead of storing a pointer to a generic `struct odb_source`.
This will help make subsequent steps a bit clearer.

Note that this is a temporary step, only. At the end of this series
we will have dropped the parent pointer completely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 4 ++--
 odb/source-files.c | 2 +-
 odb/source-loose.c | 4 ++--
 odb/source-loose.h | 5 +++--
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/object-file.c b/object-file.c
index 641bd9c079..7a1908bfc0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -178,7 +178,7 @@ static int open_loose_object(struct odb_source_loose *loose,
 	static struct strbuf buf = STRBUF_INIT;
 	int fd;
 
-	*path = odb_loose_path(loose->source, &buf, oid);
+	*path = odb_loose_path(&loose->files->base, &buf, oid);
 	fd = git_open(*path);
 	if (fd >= 0)
 		return fd;
@@ -189,7 +189,7 @@ static int open_loose_object(struct odb_source_loose *loose,
 static int quick_has_loose(struct odb_source_loose *loose,
 			   const struct object_id *oid)
 {
-	return !!oidtree_contains(odb_source_loose_cache(loose->source, oid), oid);
+	return !!oidtree_contains(odb_source_loose_cache(&loose->files->base, oid), oid);
 }
 
 /*
diff --git a/odb/source-files.c b/odb/source-files.c
index b5abd20e97..185cc6903e 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -264,7 +264,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 
 	CALLOC_ARRAY(files, 1);
 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
-	files->loose = odb_source_loose_new(&files->base);
+	files->loose = odb_source_loose_new(files);
 	files->packed = packfile_store_new(&files->base);
 
 	files->base.free = odb_source_files_free;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index b944d21813..c9e7414814 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -1,10 +1,10 @@
 #include "git-compat-util.h"
 #include "odb/source-loose.h"
 
-struct odb_source_loose *odb_source_loose_new(struct odb_source *source)
+struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 {
 	struct odb_source_loose *loose;
 	CALLOC_ARRAY(loose, 1);
-	loose->source = source;
+	loose->files = files;
 	return loose;
 }
diff --git a/odb/source-loose.h b/odb/source-loose.h
index 8b4bac77ea..bf61e767c8 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -3,6 +3,7 @@
 
 #include "odb/source.h"
 
+struct odb_source_files;
 struct object_database;
 struct oidtree;
 
@@ -11,7 +12,7 @@ struct oidtree;
  * file per object. This source is part of the files source.
  */
 struct odb_source_loose {
-	struct odb_source *source;
+	struct odb_source_files *files;
 
 	/*
 	 * Used to store the results of readdir(3) calls when we are OK
@@ -29,6 +30,6 @@ struct odb_source_loose {
 	struct loose_object_map *map;
 };
 
-struct odb_source_loose *odb_source_loose_new(struct odb_source *source);
+struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files);
 
 #endif

-- 
2.54.0.926.g75ba10bac6.dirty


Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4924267B90
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863501; cv=none; b=mkB6xpTvkJuvBa3bo3Cb5Y4E3DLwg0owHtvYROWEgSDLpsdILP6yPc7jvUho/A66yKMn8OYeCA5DZXjdcRPJRpk+wJ2P/d1FQBa1yi0z3MFtX7S0Xgve+9J11BYRu7evjryhVud2rh9BVSMqsS5g0eLJJ78HGP7RPavIntMVztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863501; c=relaxed/simple;
	bh=02HijvUoT/d7RNPMLkNmGC35gYV5UMcXLJUBqfnmnA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McheaHpMH2JaJdh9s3jCsmv9i/PUhB0T35qalFcsNDvIVfch+1XXcqzeosQ9WUgFk9o0dFF0OSaW549P72oldui8IPu6HkgTo39PDr2l2XAsxiN5szU56/7IL+Kfaoxx9uslWZembudz3ImRbC3MmfDLv4UeS20TTSdEHeEUOBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SWuKxpli; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J4jXj/+C; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SWuKxpli";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J4jXj/+C"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F20C1400219
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 23 Feb 2026 11:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863500;
	 x=1771949900; bh=FShB2WbuaemWOuSRazSXd0bef+vDDxxFZl2CjVF5lVA=; b=
	SWuKxpliY7PlwIedxff1d0uKhfF26f4tRMVmVg5h4mxyffRqh1tjIDLi/J3pIeAm
	FqvuWwlxbHDUGgxVWTyUIt49AAXDzYdC8NKN8B7oA80duOh3dKgK15/qlZ3fpT6W
	sPbfTp0pjMWnZSyeamv5XULIAPPtohEisev14koEiYXnhH4fogv++D8svvj2oJEp
	G/ED/6MX8NUQG1gYEyFoJCFvqrM94fH9t9U4NXY3aZPJzqfEV8tdKIwbHNt68Otx
	nvB0v9xvdyhEB9QRjRzf7YZMmvyS1d9CmWlSjJ4Vg6eCrB9l7NmOZsUDEkWAyqPN
	M65jzRxWxeRgMtey2zbFxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863500; x=
	1771949900; bh=FShB2WbuaemWOuSRazSXd0bef+vDDxxFZl2CjVF5lVA=; b=J
	4jXj/+C1J6FCa9KWbk5wvVkwbKO3kprJGb3Zn+TFFEg373C6nPWtF1K0MMizAbYZ
	nhFCDIcF29VH3f8Q3hWQQ4s5hFcFKghl2LKQEPnhpRMuNfIlYFi6keiTyEM4h18y
	5pr7ouosd7jtsA60ylNn/YZXtNPmYiW+K2KuXnOMtqlVeNQ47qnTZoimYgoTStez
	4kAp3A5e9I/ZaasBj5up7hXaY4/DJSBLhVrU7QpxkETd/gWMk5WdYsZdOlciUTwp
	fCSmO7g18cDGaQmhvW5d+BVr9+oU+TGKsmts2vjRADD96Map7cnk4EPGY6w+8Aqb
	ltL6d9dfI0Pa67IazeCAg==
X-ME-Sender: <xms:y32caefB5jZFpz_cmHiDySArJBHDByKWvxC8so9rZiosJnI3G0VRjQ>
    <xme:y32cafItCmx2JgtcROH8fmp-KPDuCTqW2J7j0rcCka0VU-64ljDrTQiRxHmel7Fy_
    hzyzC_hzDqofW1OdrFlBujXhKHtDEf5YlpwjQrj7l5CPG3ftxnJ>
X-ME-Received: <xmr:y32caVJn19i41WVjS37t-OHqDiNDqakzv4GvQeUa0skNwrrR7M9SDYpo_Zslvgqv9IP2uSVUSnWLmuupA1sq6Bg6SrUzkIF_4STDbkpv4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:y32caRErmJ76Fa1U8lVnXTd6797OVQBXfw6hxOWrzqk55Ic4hV_3KQ>
    <xmx:zH2caamRTFB858ixjCmS9FJ4wEfK4wiIvO2jbua3aJrSbMOzsDXnYg>
    <xmx:zH2caeLH7pLlGutudRl6ZPL-H1DvD40HDIdPNvZOqI5dG59JKaQFhA>
    <xmx:zH2cabYwl2bh1HRFjr3AW6TYz8MeoRZTBOSacxzV0CyyZ8-0j5CzhQ>
    <xmx:zH2cacNgobqC2N3imWsaKGGbpTylkvBjYSr69DyjyS_9BpsnjO8-e8EM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79e6e550 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:17:56 +0100
Subject: [PATCH 05/17] odb/source: introduce source type for robustness
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-5-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When a caller holds a `struct odb_source`, they have no way of telling
what type the source is. This doesn't really cause any problems in the
current status quo as we only have a single type anyway, "files". But
going forward we expect to add more types, and if so it will become
necessary to tell the sources apart.

Introduce a new enum to cover this use case and assert that the given
source actually matches the target source when performing the downcast.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c |  2 +-
 odb/source-files.h |  2 ++
 odb/source.c       |  2 ++
 odb/source.h       | 16 ++++++++++++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index df0ea9ee62..7496e1d9f8 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -36,7 +36,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	struct odb_source_files *files;
 
 	CALLOC_ARRAY(files, 1);
-	odb_source_init(&files->base, odb, path, local);
+	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
 	files->loose = odb_source_loose_new(&files->base);
 	files->packed = packfile_store_new(&files->base);
 
diff --git a/odb/source-files.h b/odb/source-files.h
index 58753d40de..803fa995fb 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -30,6 +30,8 @@ void odb_source_files_free(struct odb_source_files *files);
  */
 static inline struct odb_source_files *odb_source_files_downcast(struct odb_source *source)
 {
+	if (source->type != ODB_SOURCE_FILES)
+		BUG("trying to downcast source of type '%d' to files", source->type);
 	return container_of(source, struct odb_source_files, base);
 }
 
diff --git a/odb/source.c b/odb/source.c
index d8b2176a94..c7dcc528f6 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -13,10 +13,12 @@ struct odb_source *odb_source_new(struct object_database *odb,
 
 void odb_source_init(struct odb_source *source,
 		     struct object_database *odb,
+		     enum odb_source_type type,
 		     const char *path,
 		     bool local)
 {
 	source->odb = odb;
+	source->type = type;
 	source->local = local;
 	source->path = xstrdup(path);
 }
diff --git a/odb/source.h b/odb/source.h
index e6698b73a3..a1f2f8fdb1 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -1,6 +1,18 @@
 #ifndef ODB_SOURCE_H
 #define ODB_SOURCE_H
 
+enum odb_source_type {
+	/*
+	 * The "unknown" type, which should never be in use. This is type
+	 * mostly exists to catch cases where the type field remains zeroed
+	 * out.
+	 */
+	ODB_SOURCE_UNKNOWN,
+
+	/* The "files" backend that uses loose objects and packfiles. */
+	ODB_SOURCE_FILES,
+};
+
 /*
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
@@ -19,6 +31,9 @@ struct odb_source {
 	/* Object database that owns this object source. */
 	struct object_database *odb;
 
+	/* The type used by this source. */
+	enum odb_source_type type;
+
 	/*
 	 * Figure out whether this is the local source of the owning
 	 * repository, which would typically be its ".git/objects" directory.
@@ -58,6 +73,7 @@ struct odb_source *odb_source_new(struct object_database *odb,
  */
 void odb_source_init(struct odb_source *source,
 		     struct object_database *odb,
+		     enum odb_source_type type,
 		     const char *path,
 		     bool local);
 

-- 
2.53.0.536.g309c995771.dirty


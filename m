Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961330E84B
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863515; cv=none; b=lwhvjO7T4Vc34lL+ql9yEu2+6iKqjJXTsyw8flT1AYC+wl5jSDCi1ATBisnppo5Bjbvab6+uqg6bIiPp39A0FD70xtZl6zUsVJpCig+SuWpq7cAYAlpsCdUo+3SIrIQpSUv7qA4wkslV7rcjP7nq9HPVriG4nKk5NzF+7+ZZGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863515; c=relaxed/simple;
	bh=rnsHFBGSd5oz3GyPaYzU3UxqhOAD1HxcFp73hihcx78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UEQigUKCuVvWCimQQi1qFd9jJ0Z1qvzxZjIU83yI2YyFZObQ46SuYL69yZ/EPNwHxmolUKapk97MqPeLS43IK+Hm2p4OpoSfKKWkX66b/ICs9aWhmgtwPBBoEWsnXpJIZeeWw3M3LXNcbMFSxrZ3Q9Aoz+Pj8pA4xR/NzjW3ZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TbIYd/V0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WahcySEn; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TbIYd/V0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WahcySEn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 14103EC05A3
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:32 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 23 Feb 2026 11:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863512;
	 x=1771949912; bh=JWaNF4GJJbQ2r5rv2JkxOnIdO1c6x/8pL1B8u7H+9gY=; b=
	TbIYd/V04n6Rd+4G+82LR4t8AuAeRs8oacNkHY31KMPaGa3g9MyekgruPCQruiTl
	PTrfl0POy4t/YtnS6m3kxH+w72pdi/vk6akR6TxS2vn60ckFcbHADLzrlPC2FfCO
	58NvlUOJC+LJ2/QvWq4LW6oa3VFTK/HZfj5zoZcbyWUQCgVcGXNqc25DFXK+CJt7
	tl4wgQVtQ/CwiI9WDxmo41Jr8LdgbxnlynbaC2qMbWvjd0iI+YF7cEi707ICza6C
	+Gurdl/7LDIZWDLnjDI09O6WFiNNZ0S8+prktaFqYHRNqCStS4PVBYuSzcUSzWMC
	4ddnxobeQc5Awc0IsxJpDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863512; x=
	1771949912; bh=JWaNF4GJJbQ2r5rv2JkxOnIdO1c6x/8pL1B8u7H+9gY=; b=W
	ahcySEnwqVkwF2FsHK8kOoifwj9B9hal0neMbUS+vUdwyzRv1XNvk9Fi5e20URUM
	1uFBKjgBnwSGdPXqpb1WyCpwLHWch+9giSGgfN8eYeU4FtzxC2l53FhgMq+3Gu41
	usT6QBknw17VnLiApedJrO0LNpRg7QCtft+Nel/qIl1/qP4RF2wxmvDaX/mZ4amN
	ATyQYrRfFNhciXJQBEFJZ/03n2Bur0ipEMDnF536361DoRfUKtlsOHcoqARFTZ4E
	WCyXVjdCflTuuQVm80mOWxzQ7+NVkuSTUbUCF/SRW/vDA/BTcEQDwNBCkGZlFako
	xe8gp1CaIDmQzATaSoZww==
X-ME-Sender: <xms:132cab4alNEShdAOm62RO5xfq11EWmMderwq6E9XrIEf2iSTFoipbw>
    <xme:132caX0r3l1WRZiZ3Y7kI9ShTCwKOSHV6wd2a2JetLFtGYaUUVtR_yZrLZOZMr4p2
    Q13uW6R0osyS2MAM0zVUyN35akgwXF8ApbOJhDVwgtjGpOPz4Oh>
X-ME-Received: <xmr:132caYE9CYxmDhgMY_a3b0GrJ5H42gyVE0J8HzlLlxtxRZyUcwwH0NFOOi18afIEATodU9VqCcYgce7GcK-fmN3jQcfitQToO_4I6cnDwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:132caRSXkubNuW8YbQRY4SJ-uwLn7Ef9JxxvX-0PFeagm1wcJ2wm1Q>
    <xmx:132cafBAux_f-POAAoXD0HxWIbM6Rdp_3ZnnKV8Lhp3MEvHRYA_smg>
    <xmx:132caR0z_X2y49r5FK6AHo00jmLIYK-Or_apcKdMAZUQnDFH4GNZqw>
    <xmx:132cadXadXTq9y0B5Wa4oezYdtykvaI0ONPHOAzQA7IBI4VguHQMTg>
    <xmx:2H2caYbTagfry6iWoh49eR6jSlm0W-njHsYFs_btQ2KX0B0Q32uPw0f1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:31 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 32932e90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:18:00 +0100
Subject: [PATCH 09/17] odb/source: make `read_object_info()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-9-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Note that this function is a bit less straight-forward to convert
compared to the other functions. The reason here is that the logic to
read an object is:

  1. We try to read the object. If it exists we return it.

  2. If the object does not exist we reprepare the object database
     source.

  3. We then try reading the object info a second time in case the
     reprepare caused it to appear.

The second read is only supposed to happen for the packfile store
though, as reading loose objects is not impacted by repreparing the
object database.

Ideally, we'd just move this whole logic into the ODB source. But that's
not easily possible because we try to avoid the reprepare unless really
required, which is after we have found out that no other ODB source
contains the object, either. So the logic spans across multiple ODB
sources, and consequently we cannot move it into an individual source.

Instead, introduce a new flag `OBJECT_INFO_SECOND_READ` that tells the
backend that we already tried to look up the object once, and that this
time around the ODB source should try to find any new objects that may
have surfaced due to an on-disk change.

With this flag, the "files" backend can trivially skip trying to re-read
the object as a loose object. Furthermore, as we know that we only try
the second read via the packfile store, we can skip repreparing loose
objects and only reprepare the packfile store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 12 ++++++++-
 odb.c              | 22 +++++++--------
 odb.h              | 24 -----------------
 odb/source-files.c | 15 +++++++++++
 odb/source.h       | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.c         | 10 ++++++-
 6 files changed, 123 insertions(+), 38 deletions(-)

diff --git a/object-file.c b/object-file.c
index 25c1146849..eefde72c7d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -543,9 +543,19 @@ static int read_object_info_from_path(struct odb_source *source,
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
 				      struct object_info *oi,
-				      unsigned flags)
+				      enum object_info_flags flags)
 {
 	static struct strbuf buf = STRBUF_INIT;
+
+	/*
+	 * The second read shouldn't cause new loose objects to show up, unless
+	 * there was a race condition with a secondary process. We don't care
+	 * about this case though, so we simply skip reading loose objects a
+	 * second time.
+	 */
+	if (flags & OBJECT_INFO_SECOND_READ)
+		return -1;
+
 	odb_loose_path(source, &buf, oid);
 	return read_object_info_from_path(source, buf.buf, oid, oi, flags);
 }
diff --git a/odb.c b/odb.c
index f7487eb0df..c0b8cd062b 100644
--- a/odb.c
+++ b/odb.c
@@ -688,22 +688,20 @@ static int do_oid_object_info_extended(struct object_database *odb,
 	while (1) {
 		struct odb_source *source;
 
-		/* Most likely it's a loose object. */
-		for (source = odb->sources; source; source = source->next) {
-			struct odb_source_files *files = odb_source_files_downcast(source);
-			if (!packfile_store_read_object_info(files->packed, real, oi, flags) ||
-			    !odb_source_loose_read_object_info(source, real, oi, flags))
+		for (source = odb->sources; source; source = source->next)
+			if (!odb_source_read_object_info(source, real, oi, flags))
 				return 0;
-		}
 
-		/* Not a loose object; someone else may have just packed it. */
+		/*
+		 * When the object hasn't been found we try a second read and
+		 * tell the sources so. This may cause them to invalidate
+		 * caches or reload on-disk state.
+		 */
 		if (!(flags & OBJECT_INFO_QUICK)) {
-			odb_reprepare(odb->repo->objects);
-			for (source = odb->sources; source; source = source->next) {
-				struct odb_source_files *files = odb_source_files_downcast(source);
-				if (!packfile_store_read_object_info(files->packed, real, oi, flags))
+			for (source = odb->sources; source; source = source->next)
+				if (!odb_source_read_object_info(source, real, oi,
+								 flags | OBJECT_INFO_SECOND_READ))
 					return 0;
-			}
 		}
 
 		/*
diff --git a/odb.h b/odb.h
index e13b5b7c44..70ffb033f9 100644
--- a/odb.h
+++ b/odb.h
@@ -339,30 +339,6 @@ struct object_info {
  */
 #define OBJECT_INFO_INIT { 0 }
 
-/* Flags that can be passed to `odb_read_object_info_extended()`. */
-enum object_info_flags {
-	/* Invoke lookup_replace_object() on the given hash. */
-	OBJECT_INFO_LOOKUP_REPLACE = (1 << 0),
-
-	/* Do not reprepare object sources when the first lookup has failed. */
-	OBJECT_INFO_QUICK = (1 << 1),
-
-	/*
-	 * Do not attempt to fetch the object if missing (even if fetch_is_missing is
-	 * nonzero).
-	 */
-	OBJECT_INFO_SKIP_FETCH_OBJECT = (1 << 2),
-
-	/* Die if object corruption (not just an object being missing) was detected. */
-	OBJECT_INFO_DIE_IF_CORRUPT = (1 << 3),
-
-	/*
-	 * This is meant for bulk prefetching of missing blobs in a partial
-	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
-	 */
-	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
-};
-
 /*
  * Read object info from the object database and populate the `object_info`
  * structure. Returns 0 on success, a negative error code otherwise.
diff --git a/odb/source-files.c b/odb/source-files.c
index 20a24f524a..f2969a1214 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -41,6 +41,20 @@ static void odb_source_files_reprepare(struct odb_source *source)
 	packfile_store_reprepare(files->packed);
 }
 
+static int odb_source_files_read_object_info(struct odb_source *source,
+					     const struct object_id *oid,
+					     struct object_info *oi,
+					     enum object_info_flags flags)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+
+	if (!packfile_store_read_object_info(files->packed, oid, oi, flags) ||
+	    !odb_source_loose_read_object_info(source, oid, oi, flags))
+		return 0;
+
+	return -1;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -55,6 +69,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
 	files->base.reprepare = odb_source_files_reprepare;
+	files->base.read_object_info = odb_source_files_read_object_info;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index 7af4900ab4..45563de61e 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -13,6 +13,45 @@ enum odb_source_type {
 	ODB_SOURCE_FILES,
 };
 
+/* Flags that can be passed to `odb_read_object_info_extended()`. */
+enum object_info_flags {
+	/* Invoke lookup_replace_object() on the given hash. */
+	OBJECT_INFO_LOOKUP_REPLACE = (1 << 0),
+
+	/* Do not reprepare object sources when the first lookup has failed. */
+	OBJECT_INFO_QUICK = (1 << 1),
+
+	/*
+	 * Do not attempt to fetch the object if missing (even if fetch_is_missing is
+	 * nonzero).
+	 */
+	OBJECT_INFO_SKIP_FETCH_OBJECT = (1 << 2),
+
+	/* Die if object corruption (not just an object being missing) was detected. */
+	OBJECT_INFO_DIE_IF_CORRUPT = (1 << 3),
+
+	/*
+	 * We have already tried reading the object, but it couldn't be found
+	 * via any of the attached sources, and are now doing a second read.
+	 * This second read asks the individual sources to also evaluate
+	 * whether any on-disk state may have changed that may have caused the
+	 * object to appear.
+	 *
+	 * This flag is for internal use, only. The second read only occurs
+	 * when `OBJECT_INFO_QUICK` was not passed.
+	 */
+	OBJECT_INFO_SECOND_READ = (1 << 4),
+
+	/*
+	 * This is meant for bulk prefetching of missing blobs in a partial
+	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
+	 */
+	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
+};
+
+struct object_id;
+struct object_info;
+
 /*
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
@@ -73,6 +112,33 @@ struct odb_source {
 	 * example just been repacked so that new objects will become visible.
 	 */
 	void (*reprepare)(struct odb_source *source);
+
+	/*
+	 * This callback is expected to read object information from the object
+	 * database source. The object info will be partially populated with
+	 * pointers for each bit of information that was requested by the
+	 * caller.
+	 *
+	 * The flags field is a combination of `OBJECT_INFO` flags. Only the
+	 * following fields need to be handled by the backend:
+	 *
+	 *   - `OBJECT_INFO_QUICK` indicates it is fine to use caches without
+	 *     re-verifying the data.
+	 *
+	 *   - `OBJECT_INFO_SECOND_READ` indicates that the initial object
+	 *     lookup has failed and that the object sources should check
+	 *     whether any of its on-disk state has changed that may have
+	 *     caused the object to appear. Sources are free to ignore the
+	 *     second read in case they know that the first read would have
+	 *     already surfaced the object without reloading any on-disk state.
+	 *
+	 * The callback is expected to return a negative error code in case
+	 * reading the object has failed, 0 otherwise.
+	 */
+	int (*read_object_info)(struct odb_source *source,
+				const struct object_id *oid,
+				struct object_info *oi,
+				enum object_info_flags flags);
 };
 
 /*
@@ -132,4 +198,16 @@ static inline void odb_source_reprepare(struct odb_source *source)
 	source->reprepare(source);
 }
 
+/*
+ * Read an object from the object database source identified by its object ID.
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static inline int odb_source_read_object_info(struct odb_source *source,
+					      const struct object_id *oid,
+					      struct object_info *oi,
+					      enum object_info_flags flags)
+{
+	return source->read_object_info(source, oid, oi, flags);
+}
+
 #endif
diff --git a/packfile.c b/packfile.c
index da1c0dfa39..71db10e7c6 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2181,11 +2181,19 @@ int packfile_store_freshen_object(struct packfile_store *store,
 int packfile_store_read_object_info(struct packfile_store *store,
 				    const struct object_id *oid,
 				    struct object_info *oi,
-				    enum object_info_flags flags UNUSED)
+				    enum object_info_flags flags)
 {
 	struct pack_entry e;
 	int ret;
 
+	/*
+	 * In case the first read didn't surface the object, we have to reload
+	 * packfiles. This may cause us to discover new packfiles that have
+	 * been added since the last time we have prepared the packfile store.
+	 */
+	if (flags & OBJECT_INFO_SECOND_READ)
+		packfile_store_reprepare(store);
+
 	if (!find_pack_entry(store, oid, &e))
 		return 1;
 

-- 
2.53.0.536.g309c995771.dirty


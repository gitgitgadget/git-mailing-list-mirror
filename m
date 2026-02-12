Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AAB7081A
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770879601; cv=none; b=tEL2gndDekNi2GL7YJKi7WrusOsDiDbJQ1WxtRdWRjXSlTj95nRwQ1KPRlFqlE2Lon4OrOO944S3EVPH0/9qHAtxdiXRMAIiLu3jHjehDZcXSZ9f9arUHLhmUuJ25YQAGkW3IHrHA7wkr4+Lh3pCkznC6Ir5evDZ5mEQ5G5v4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770879601; c=relaxed/simple;
	bh=/cKGWGy1OWo4IGcEAhpHSR41EFYoY7EKafmft+3R5gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s29sNnBRl+T4gfzfJuQWVS/Cw71jE/4aglKjsKQkDZhASU01ZIOzNdq6jhj9B2/bOKa+h9EuBy9iXcuvDO5JhM7kYhGCRDHZxGSIuKuwgAGgyfHhapwCP8MLuZ+YuJac+hcUkC7Mwtutm0cgxdaA01Y7Y2M3P+CCseNWGCsArqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WoiH2EAd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f0PfCcwp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WoiH2EAd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f0PfCcwp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB03A14001C2
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 01:59:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Feb 2026 01:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770879599;
	 x=1770965999; bh=iEZ8n0kQZgt201GZ/nhYup0+tk6yPitRXjQ9MrlJUTE=; b=
	WoiH2EAdXm4mIyr0bOg0H3m5Qur0G5JTY1tTqh8KAIXHYDyqr73tr3ryCVxi34Dg
	CXFsU598SK9HJgdmh4tkKYV17udIW7JRKVafp40clICeEOmSQr2q+JAt85crobFX
	f63dmh8FvJ3utsIYeyHjOiC8vkT5yYAHGYHyfiFwxwYmozwykRyKj1grvHVmRxFo
	6sWT/HQa/eDuIawXPQqnDKxkfnI+p6+4AHb3EXXhPfne2myU2pcQFAoqft2MdIxY
	YqL6ivcwyc/DAYcDVSrgotqnbFWkH+WujWjAAQuczTeypFUnUB5YWIU1kEk/oh4u
	gu90Ttsycf9lnekmq8sBEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770879599; x=
	1770965999; bh=iEZ8n0kQZgt201GZ/nhYup0+tk6yPitRXjQ9MrlJUTE=; b=f
	0PfCcwpiTFlKhNJXGBtKdK7OWxuACqExAgcCG6cpleDbS8YQZrdGrlutlkIvv4Za
	0odpQTdBFdZ1uNKoCqQhe7rSmKEZQFKyTNM4ICPmrZZGoSi35KQzW1E2TqvmiuId
	6Nl2K96b6pP0BzhN9tBzoMDixiVGYdgTZZUuFecHfPsTbOi497sdiQM6yaAnYxX3
	w3W/KNkTp1gIBmPkJvqMgZwsCSJ5gpVlQ1tRIK90SL0EaoU8FhQSVZZziiEeCNj0
	/DO+AoB0fTBNJzm5QQNPZp2SDmMZoIWiGcXm2khqNJN2cX+6jwdrHrK3YhGQtPor
	T7dZ2GUpAVWrlB3VQgd9A==
X-ME-Sender: <xms:b3qNaTmRqlPZO9kdKjvYImPjL8ByfMKaW25LtQ5LLJETuK6jYWpOjQ>
    <xme:b3qNadwfRdPbTWBQRabt9XabllYGQpEdYDdyrjA1Gjoq7eE0-JDNsceiFU_yKr9lf
    tw9PlJ8CuTraAQcN2ebAHmWenhTkHxhEN6B-3oY9aJPX_SfAFzn>
X-ME-Received: <xmr:b3qNafSjALLlKDWFty4o5DT2w5xiNbro__27Df7vt2-jspuH8puD63pVJw2rp0noRkw-Wo2y2qozQ_E2rDEChmjTqQ5-lh3A_a8H0ui3fIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:b3qNaQuI-IKKQW6iqU-N4VG7lsx3xjaEsEVIH0OjDEPyCxYuYc2Yqw>
    <xmx:b3qNaRvEVKMKIHnouivZ1ZNF50jHF5Yrxp3GhK-7bZHJ-wWpDKimeQ>
    <xmx:b3qNaWyu1qdH-rawkQa78yXJy-Oq-NdBkexZOaIz0VJEgyfREhCbFw>
    <xmx:b3qNaXhVrNmR9mBoaXsyv5taD00qhRJGYzatcqXnwxvlz7SOnD6TKA>
    <xmx:b3qNaT3wGllWZfm4doQOBTSl6P30b5RSyWW5C_qrC7pIlhsYG6lmbBvL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 12 Feb 2026 01:59:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97b23f2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 12 Feb 2026 06:59:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Feb 2026 07:59:40 +0100
Subject: [PATCH v2 4/5] odb: convert object info flags into an enum
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-b4-pks-read-object-info-flags-v2-4-3bfa9bb149ef@pks.im>
References: <20260212-b4-pks-read-object-info-flags-v2-0-3bfa9bb149ef@pks.im>
In-Reply-To: <20260212-b4-pks-read-object-info-flags-v2-0-3bfa9bb149ef@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Convert the object info flags into an enum and adapt all functions that
receive these flags as parameters to use the enum instead of an integer.
This serves two purposes:

  - The function signatures become more self-documenting, as callers
    don't have to wonder which flags they expect.

  - The compiler can warn when a wrong flag type is passed.

Note that the second benefit is somewhat limited. For example, when
or-ing multiple enum flags together the result will be an integer, and
the compiler will not warn about such use cases. But where it does help
is when a single flag of the wrong type is passed, as the compiler would
generate a warning in that case.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c |  3 ++-
 object-file.h |  3 ++-
 odb.c         |  2 +-
 odb.h         | 40 +++++++++++++++++++++++-----------------
 packfile.c    |  2 +-
 packfile.h    |  2 +-
 6 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/object-file.c b/object-file.c
index e7e4c3348f..0ab6c4d4f3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -414,7 +414,8 @@ static int parse_loose_header(const char *hdr, struct object_info *oi)
 
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
-				      struct object_info *oi, int flags)
+				      struct object_info *oi,
+				      enum object_info_flags flags)
 {
 	int ret;
 	int fd;
diff --git a/object-file.h b/object-file.h
index 1229d5f675..cdb54b5218 100644
--- a/object-file.h
+++ b/object-file.h
@@ -47,7 +47,8 @@ void odb_source_loose_reprepare(struct odb_source *source);
 
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
-				      struct object_info *oi, int flags);
+				      struct object_info *oi,
+				      enum object_info_flags flags);
 
 int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 					struct odb_source *source,
diff --git a/odb.c b/odb.c
index ac70b6a099..d437aa8b06 100644
--- a/odb.c
+++ b/odb.c
@@ -842,7 +842,7 @@ static int oid_object_info_convert(struct repository *r,
 int odb_read_object_info_extended(struct object_database *odb,
 				  const struct object_id *oid,
 				  struct object_info *oi,
-				  unsigned flags)
+				  enum object_info_flags flags)
 {
 	int ret;
 
diff --git a/odb.h b/odb.h
index 8e1fca7755..e94cdc3665 100644
--- a/odb.h
+++ b/odb.h
@@ -352,23 +352,29 @@ struct object_info {
  */
 #define OBJECT_INFO_INIT { 0 }
 
-/* Invoke lookup_replace_object() on the given hash */
-#define OBJECT_INFO_LOOKUP_REPLACE (1 << 0)
-/* Do not retry packed storage after checking packed and loose storage */
-#define OBJECT_INFO_QUICK (1 << 1)
-/*
- * Do not attempt to fetch the object if missing (even if fetch_is_missing is
- * nonzero).
- */
-#define OBJECT_INFO_SKIP_FETCH_OBJECT (1 << 2)
-/*
- * This is meant for bulk prefetching of missing blobs in a partial
- * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
- */
-#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
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
 
-/* Die if object corruption (not just an object being missing) was detected. */
-#define OBJECT_INFO_DIE_IF_CORRUPT (1 << 3)
+	/*
+	 * This is meant for bulk prefetching of missing blobs in a partial
+	 * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK.
+	 */
+	OBJECT_INFO_FOR_PREFETCH = (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK),
+};
 
 /*
  * Read object info from the object database and populate the `object_info`
@@ -377,7 +383,7 @@ struct object_info {
 int odb_read_object_info_extended(struct object_database *odb,
 				  const struct object_id *oid,
 				  struct object_info *oi,
-				  unsigned flags);
+				  enum object_info_flags flags);
 
 /*
  * Read a subset of object info for the given object ID. Returns an `enum
diff --git a/packfile.c b/packfile.c
index 402c3b5dc7..cb418846ae 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2149,7 +2149,7 @@ int packfile_store_freshen_object(struct packfile_store *store,
 int packfile_store_read_object_info(struct packfile_store *store,
 				    const struct object_id *oid,
 				    struct object_info *oi,
-				    unsigned flags UNUSED)
+				    enum object_info_flags flags UNUSED)
 {
 	struct pack_entry e;
 	int ret;
diff --git a/packfile.h b/packfile.h
index acc5c55ad5..989fd10cb6 100644
--- a/packfile.h
+++ b/packfile.h
@@ -247,7 +247,7 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
 int packfile_store_read_object_info(struct packfile_store *store,
 				    const struct object_id *oid,
 				    struct object_info *oi,
-				    unsigned flags);
+				    enum object_info_flags flags);
 
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns

-- 
2.53.0.295.g64333814d3.dirty


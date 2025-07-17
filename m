Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2A1DF75B
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728208; cv=none; b=dWGt/sU9o3+XMXXUFVcqwSgH4FwpI05FYBz2iivSRzKfmHucrQw/Z+1eNxd/tw9NkpWFs6GMcrAOKPMjkxtIjm3RSb77ygvDpU2k4U6GrQpefB6nsTRjgtNuiIbWw12uVOyn9ikQexYFaqrT/dcALgj6mmdGi48Inv6EExD6C10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728208; c=relaxed/simple;
	bh=Ve+COSjlkzaPsn8+y5Ei9YwWZn8F6YJYlB6t3syXaCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+lGpoJZYt2OKdblNJOAbD3AkPNHgxukI8W4bUAh6nmPsPRC/+tsVj0U5WfBAAqRQUOELBDb0wkcEi9Pw0yiyHMV7PzPyzYuXNRMTBR0P5b3Nra1Vq8XvIslNqMms29swBpbHCF/xFpGsQnifYp3oANiN2fvMYUkYsONgx4eR90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ypmdr9XW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eKsM1Q36; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ypmdr9XW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eKsM1Q36"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 8EBEF1D00193;
	Thu, 17 Jul 2025 00:56:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 17 Jul 2025 00:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752728205;
	 x=1752814605; bh=hLlTCHYiG/Lp7idsFytMsIy1FwGQuEb7eWR79GsVd0I=; b=
	ypmdr9XWSA32zkrJ3lEyZWvCVHI9lyhpBCF9rYeiwMqW6Tbc5l/tMLQcvKjp1053
	InRvCf3HxSC5cYzdniGRo6Tof1ROBza+N/FynniY9VS3jhwpRyr4Lo/CD1cSMjCz
	XRXaC/T7Q4CnpMsFK5ygMd8IV7dEweinmMAkfRXj7FWMR+weQZ0Y2TJOtai8gsAp
	OqjKfRhNttvS5Yt//+qsvfon+3tbWuFfR/E4Zyr1K/cDK0QezTu1WdZBlSsQDyvb
	6I4NXqrsKcFelOr4m3+0MEvHNuulJY1DwZ6xU9abk6bV+SM0rf3QqGS1z0LZ4eBX
	VZyakXA/4HDK8NG7lu5GBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752728205; x=
	1752814605; bh=hLlTCHYiG/Lp7idsFytMsIy1FwGQuEb7eWR79GsVd0I=; b=e
	KsM1Q3653ajloNAA8GU/YZy5AidjHW4rRpt0kGWSfHl8Iy5JILpSeRSwsR792bJ9
	vpm8nCJf2aWk9sTf8cT2G33BATgrQiKMQyNvl3LmdkN5GwmO1uyglqQSybDCcZBn
	aKFBj9ehuacznBSBXJdjIyQeowEIEtkwB3d7+k4aVNhAuYSGaDBaEBzMoxT7qRVj
	PRbv6MxDIUyUcjtcVfnSgTKbL2DQTKoffDpHFcsN/PQ7VaUbTkUHOjhOk5aeq9B3
	WhO9aQv4wQzKmFsV9NNN/tfqKdjAta1Is36RFWxff01SWV+li0L3H6+dQEYzeYkV
	eu1BArg7UJVlYZ9VjfbJQ==
X-ME-Sender: <xms:jYJ4aES9spvrd7Ke1bobwWTz1zcYkzpiUU6nkGS_r1fzfjP7DTlS3A>
    <xme:jYJ4aNRA6PYwaezBcVpx3AqtcSo9DdMrf4XBlnxy5LCFKiaC1eeWQj6h08hPczTwg
    o1Lq9tFzyK2MMi0dA>
X-ME-Received: <xmr:jYJ4aIQ8M-yjXuLNHkzKn_LEBpKYrMg7Pqe25V0hHJ-yznbcFUYrhdjjd2slN7RHmFBKUMgR3uk7uvqH7D37qZiojiOLEEAL0lDy5frHvtP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jYJ4aC4Z9RC69svm0yhmv4CJmeDLdn_8xBd5QahQUW5e2T0Mh9lMPg>
    <xmx:jYJ4aE1mX4sKWufaHm5ICZRA0sC4pAf6AXFMIh8b-OUdrLOrk9PyAg>
    <xmx:jYJ4aNAEvXhLE2o_176BCdB8r1uoeC-ze9_wQOdeDHpn7cryvv3CYw>
    <xmx:jYJ4aPMt_wHJW4Kk5arox0Dt2H6Pgv_P72bdffBpV8a9BxJtiFnL4w>
    <xmx:jYJ4aKM52yPr0EHGsL80-xzGJWOqE0oW5gNpctP22R1S8wAC0mlpR07F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:56:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e73961c5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:56:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 06:56:29 +0200
Subject: [PATCH v2 03/16] object-file: get rid of `the_repository` in
 `has_loose_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-object-file-wo-the-repository-v2-3-36d2cd6c700e@pks.im>
References: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
In-Reply-To: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

We implicitly depend on `the_repository` in `has_loose_object()`.
Refactor the function to accept an `odb_source` as input that should be
checked for such a loose object.

This refactoring changes semantics of the function to not check the
whole object database for such a loose object anymore, but instead we
now only check that single source. Existing callers thus need to loop
through all sources manually now.

While this change may seem illogical at first, whether or not an object
exists in a specific format should be answered by the source using that
format. As such, we can eventually convert this into a generic function
`odb_source_has_object()` that simply checks whether a given object
exists in an object source. And as we will know about the format that
any given source uses it allows us to derive whether the object exists
in a given format.

This change also makes `has_loose_object_nonlocal()` obsolete. The only
caller of this function is adapted so that it skips the primary object
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 24 ++++++++++++++++++++----
 object-file.c          | 16 +++++++---------
 object-file.h          |  7 +++----
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5781dec9808..a44f0ce1c78 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1703,8 +1703,16 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 	struct list_head *pos;
 	struct multi_pack_index *m;
 
-	if (!exclude && local && has_loose_object_nonlocal(oid))
-		return 0;
+	if (!exclude && local) {
+		/*
+		 * Note that we start iterating at `sources->next` so that we
+		 * skip the local object source.
+		 */
+		struct odb_source *source = the_repository->objects->sources->next;
+		for (; source; source = source->next)
+			if (has_loose_object(source, oid))
+				return 0;
+	}
 
 	/*
 	 * If we already know the pack object lives in, start checks from that
@@ -3928,7 +3936,14 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 	} else {
 		if (!want_object_in_pack_mtime(oid, 0, &pack, &offset, mtime))
 			return;
-		if (!pack && type == OBJ_BLOB && !has_loose_object(oid)) {
+		if (!pack && type == OBJ_BLOB) {
+			struct odb_source *source = the_repository->objects->sources;
+			int found = 0;
+
+			for (; !found && source; source = source->next)
+				if (has_loose_object(source, oid))
+					found = 1;
+
 			/*
 			 * If a traversed tree has a missing blob then we want
 			 * to avoid adding that missing object to our pack.
@@ -3942,7 +3957,8 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 			 * limited to "ensure non-tip blobs which don't exist in
 			 * packs do exist via loose objects". Confused?
 			 */
-			return;
+			if (!found)
+				return;
 		}
 
 		entry = create_object_entry(oid, type, pack_name_hash_fn(name),
diff --git a/object-file.c b/object-file.c
index bc395febc9d..7aecaa3d2a0 100644
--- a/object-file.c
+++ b/object-file.c
@@ -121,14 +121,10 @@ static int check_and_freshen(const struct object_id *oid, int freshen)
 	       check_and_freshen_nonlocal(oid, freshen);
 }
 
-int has_loose_object_nonlocal(const struct object_id *oid)
+int has_loose_object(struct odb_source *source,
+		     const struct object_id *oid)
 {
-	return check_and_freshen_nonlocal(oid, 0);
-}
-
-int has_loose_object(const struct object_id *oid)
-{
-	return check_and_freshen(oid, 0);
+	return check_and_freshen_odb(source, oid, 0);
 }
 
 int format_object_header(char *str, size_t size, enum object_type type,
@@ -1103,8 +1099,10 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	int hdrlen;
 	int ret;
 
-	if (has_loose_object(oid))
-		return 0;
+	for (struct odb_source *source = repo->objects->sources; source; source = source->next)
+		if (has_loose_object(source, oid))
+			return 0;
+
 	oi.typep = &type;
 	oi.sizep = &len;
 	oi.contentp = &buf;
diff --git a/object-file.h b/object-file.h
index 222ff2871a1..5b63a05ab51 100644
--- a/object-file.h
+++ b/object-file.h
@@ -45,13 +45,12 @@ const char *odb_loose_path(struct odb_source *source,
 			   const struct object_id *oid);
 
 /*
- * Return true iff an alternate object database has a loose object
+ * Return true iff an object database source has a loose object
  * with the specified name.  This function does not respect replace
  * references.
  */
-int has_loose_object_nonlocal(const struct object_id *);
-
-int has_loose_object(const struct object_id *);
+int has_loose_object(struct odb_source *source,
+		     const struct object_id *oid);
 
 void *map_loose_object(struct repository *r, const struct object_id *oid,
 		       unsigned long *size);

-- 
2.50.1.465.gcb3da1c9e6.dirty


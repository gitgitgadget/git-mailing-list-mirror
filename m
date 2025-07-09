Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23862D4B58
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059851; cv=none; b=YZTJX9/1VLknylU7K1SPlCa3b1j4EnLXVVvIoR2E6HF0TF0FOVYg/vEmcJNJl72EdSjLURkGw7jZqOYGDFmXwr1/wMS6n8p7fZYN+v5blGjxaeUsHc56Ucsv2rxjdW766YysilMWc4CZ04uLOFJTziyEEQIcy7TOaK8wHQVj8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059851; c=relaxed/simple;
	bh=ZmJbeTk9nf3V+UsN+4Dh21QuGtxSpb6iz40afG8KbhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTqpTNWVOhvpK563bi1uVAaPrDMx9kZasoDjU04jOZhXQGnaPpRDNIQC1Ws1ZEQ85wMuRhrGFBZjLlgTBXCAnCBqyia1h8oSFPQV/SKXvV++ljW2xt/UwC+SOuqnvVIbhCULqtvk79/hgLykZMzLiguy0+cDiKfgvogYHgetN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TG12i8U4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qa0G+D15; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TG12i8U4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qa0G+D15"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 004BFEC03F8
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 09 Jul 2025 07:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059848;
	 x=1752146248; bh=5afwZB9FsQQy2EtjMEs+aiXZ1XLK3x/ecmCqct6/evc=; b=
	TG12i8U43d0uexAfHA7vBFBlbu1KDLRECbw2TH6d0LYEuaTh2Ue62wPChWlv9K2B
	QDxxfqm0FPA9KVMx0SqxAxIS/V4SwsDWsuM6QRZlDWsJyNAARO2SMcdPhA79rzFE
	n2W1u9SLfnOrV+Gud43qfXUC6SyeCZCmqrbY+EUxvgSaY3dlq109rM4uDs4NyMgo
	6H+38rRSW8BNzSgSc3mI5/0wHfD6UFMKvRS970Cdym72BghJBIIbvG6p3oe/CQus
	mJVd/vfZnQPcz8xKYpK39YXFhaV55kKGeXzvGbpfzMXj4qWeMrRcBf2pllKcrYEq
	usVJin8j9MowTaDuNTQYuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059848; x=
	1752146248; bh=5afwZB9FsQQy2EtjMEs+aiXZ1XLK3x/ecmCqct6/evc=; b=Q
	a0G+D15ZAEJBEUPJhubx7uadmBnyNkFQSoRTo2J7Nqys67RDd+6dDZcSbD46aM8p
	i94wTqxoGoC3beBs91HFpJPDmfZuhDWmKsmFaT9VIz/PCciHFSkUmybPGztw5e/F
	4Zapy+APrqnHLeNpITg2W6YSoMUKtXzLuqyWW0ScRijIpXHZc/GxkWckgPj9Bt8o
	sYqV412CcXZEJY5h+7Mmeiv2E/5IxkxMd/EvY+CMvlESSEHvU4JfUSEcltBxwehc
	osncvyoEc7h/UuSFFvTCweIHlglNI/TBSgc1zeCKtPO/hyzOfEKVkH6yLTxbkALc
	9vnn5MxWVyXP1RPh/7zkQ==
X-ME-Sender: <xms:yE9uaEoj7eHmtVB7dinu24eAiJcCpK_E98GTHwZmd-faw9GtOgmI2w>
    <xme:yE9uaMrtBnD0mTQvd9IZWfGA2slYpMtQV95WRkxCJiw0wn9OUsJFNxidU--Tn6U3S
    O-iMBsKUFFwWnxU4w>
X-ME-Received: <xmr:yE9uaCk8RLcbDbzUFs07vTfBNTCLpY66ODitlZjHYkyd-Lzvd5pNDb57zspipJhCocLye9SIxYOy56zUVRJA2YOXLA6jMaLVFGkmL__unLKI9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:yE9uaOFoC_tsKyGr-3mEATLhOQTrLkyP8Cu48RlSQayplvY0U1M_TQ>
    <xmx:yE9uaLq6LLNv_MatuHHngV2GB8ufRfJXCyBEtrzejvNO6jYM9Ln10Q>
    <xmx:yE9uaK6mRfjUTvxm5taqN_5-HESyuEN225w4re2TYd-uz-Uq-P5pNQ>
    <xmx:yE9uaJ7rY67vCa0tR8gwX4oWzUZTBUR_Z22b8luT5-42_rYej0iA0g>
    <xmx:yE9uaBCI1oxlS1q6NS7G7RKITl-3yDgIzCzosZ7IQS84IaKnkFZR2531>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a7253677 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:13 +0200
Subject: [PATCH 03/19] object-file: get rid of `the_repository` in
 `has_loose_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-3-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.50.1.327.g047016eb4a.dirty


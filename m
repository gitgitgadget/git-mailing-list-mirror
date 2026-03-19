Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D036404F
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903223; cv=none; b=Can4nURykptTaL+lcNATAk7wtfZQUV2pjIYSXetvG8nM46uIo+OIynCS4hbRanzEsiVGVwfT6LQd1wtvUWSd2KqODuuxP9TxehBBR1GDlZ7Xj0FyRtV0CKrLPaRBuYwf4OPAufDEH0wL5KyNwW9H0RdcCyvbkHYXRzvMhgnnvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903223; c=relaxed/simple;
	bh=4Ygufyn39HN5jgoHMHb2cMelqZxmEi40eYZPDUwUfPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L20kifJZbnW7TXIkTJpWeXIxKXt68aHjWzQByuZ8dqfzfwJUvlfwYtttDD7t7ksA76wEac0KiUeI62UrGIb2tklC2Kf83JYbRy6E/lFWZ+8aGMQPC8RDASggwlD2EGs2/NxvygbuHZU9EE+unwX5ykHFz5WNurKVTN7923cVN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hSDkhFIy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lQKIGN1H; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hSDkhFIy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lQKIGN1H"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9454E1400221
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 19 Mar 2026 02:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903220;
	 x=1773989620; bh=PXFZHv2xR7RjOruPupYICdeEU1qTlZh5N/ZKCuTOTwY=; b=
	hSDkhFIyGkDmDY0rMr1RNOfPlhS2IreBejqA12ug+qQ/hWZku8j1RgZLtmRFlMFx
	Vnu/pQlDBH5wq7UJwtsQjY93oqMDzE1sQ7Ty/CWRaY6ohw6v5CKPTLTIgXyvkFUz
	rfBCdUIEeSWjgvJs5U67RCMLMTe3Nlskwt3yUs4DOJQRXaKt3ffS231ZmPbq5CfE
	ltQRzzajBTDfCAGAoDiw8Jw0pamB8vHYDAQmExOUzjz3uyxTYMcdtjK/oVEhvnT1
	iikYHSKTzo6YwdeTqh4UtIinp/Weo/tLrvb+xa5tcJhh2VC7yGnyXMbT+8pnqfVZ
	vi8KVr1AbgZ6Ij4krmDSFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903220; x=
	1773989620; bh=PXFZHv2xR7RjOruPupYICdeEU1qTlZh5N/ZKCuTOTwY=; b=l
	QKIGN1HJ0tg2xEeNRU/v6RFvrq1ErSyiCjWy1RV6QIueh0kPECcaHQSAM78pCets
	iWiQ0+loElo3jtnacqD+8/IvymASrr/wlEbZ48p2sVX1oqos9eJmKQnxzVhuvD7D
	glyx4QEDmr2WuwgFSODiPpj6wnTOtI4RuTNua7Wl4HlPmDQm1KZVw5dQo8Ca9SWg
	Bk6jng5oUEf5PaIi9rgvuO04XkWqENkhj+ZVsq3loxOZx5LL4DMr5VGM6ouA9cH1
	ReFox++5qo3AG9TuBHj1c2Ot8I76IB7q0p+QdRyp/5RBOcmYaV+Isp8vpwWNXm2z
	eJO12vPp8v6XJSvU1b4fg==
X-ME-Sender: <xms:dJ27aUikGS_r0W3xC4WiPLOgAK8F01K85KIS7PUJNWKrgIw5JHY-Jw>
    <xme:dJ27aT-3g6A4AxpfyVrS9PrAqS4v8cvnctu22QN1ZtcXfSk4p6TTsc3jMQhF69Q5h
    bj4TtFcgb3TgJOvDUx2z5xAExesjfELgB2Abyd1-4VAVvS-caJU2g>
X-ME-Received: <xmr:dJ27aRsL7rqo79PHhuKO3MKvkB5rTNraFBNkizZy1I7_ZCnW3voeitEPp2dBFrfMeN4TTx5jI3QW-zyBQmlKx12CQK4Vnq_AyoT_PEHq8ppI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:dJ27aaZ9roQq2RGzC3UssE1M_hG3Gj0T7BS6Ti_bFiOqs-S0KehZOw>
    <xmx:dJ27aRqZW62afmgiGOeucMv3dAOgDaFW4B5Sji_xsYFoBT0lHiwT1w>
    <xmx:dJ27af94MI2xLBMX8oUYkr_kVDFq0yyH6TBrm54r9DyadTjKp0_B9g>
    <xmx:dJ27aQ-oa2bOVWPEVx3pXpzqQTMm5tkO4P-LXhyt-W6bqss8rP3NaQ>
    <xmx:dJ27aZiCdZ4lRkaHC0IsYz9AtCrbHa9ekWqUrp0ouFBclgFC7DMv_fBw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a770bcca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:12 +0100
Subject: [PATCH 14/14] odb: introduce generic `odb_find_abbrev_len()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-14-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new generic `odb_find_abbrev_len()` function as well as
source-specific callback functions. This makes the logic to compute the
required prefix length to make a given object unique fully pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c      | 57 +++---------------------------------------
 odb.c              | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 odb.h              | 16 ++++++++++++
 odb/source-files.c | 25 +++++++++++++++++++
 odb/source.h       | 24 ++++++++++++++++++
 5 files changed, 142 insertions(+), 53 deletions(-)

diff --git a/object-name.c b/object-name.c
index bb2294a193..f6e1f29e1f 100644
--- a/object-name.c
+++ b/object-name.c
@@ -15,10 +15,9 @@
 #include "refs.h"
 #include "remote.h"
 #include "dir.h"
+#include "odb.h"
 #include "oid-array.h"
-#include "packfile.h"
 #include "pretty.h"
-#include "object-file.h"
 #include "read-cache-ll.h"
 #include "repo-settings.h"
 #include "repository.h"
@@ -569,19 +568,6 @@ int repo_for_each_abbrev(struct repository *r, const char *prefix,
 	return ret;
 }
 
-/*
- * Return the slot of the most-significant bit set in "val". There are various
- * ways to do this quickly with fls() or __builtin_clzl(), but speed is
- * probably not a big deal here.
- */
-static unsigned msb(unsigned long val)
-{
-	unsigned r = 0;
-	while (val >>= 1)
-		r++;
-	return r;
-}
-
 void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
 				   const struct object_id *oid, int abbrev_len)
 {
@@ -602,49 +588,14 @@ int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 {
 	const struct git_hash_algo *algo =
 		oid->algo ? &hash_algos[oid->algo] : r->hash_algo;
-	const unsigned hexsz = algo->hexsz;
 	unsigned len;
 
-	if (min_len < 0) {
-		unsigned long count;
-
-		if (odb_count_objects(r->objects, ODB_COUNT_OBJECTS_APPROXIMATE, &count) < 0)
-			count = 0;
-
-		/*
-		 * Add one because the MSB only tells us the highest bit set,
-		 * not including the value of all the _other_ bits (so "15"
-		 * is only one off of 2^4, but the MSB is the 3rd bit.
-		 */
-		len = msb(count) + 1;
-		/*
-		 * We now know we have on the order of 2^len objects, which
-		 * expects a collision at 2^(len/2). But we also care about hex
-		 * chars, not bits, and there are 4 bits per hex. So all
-		 * together we need to divide by 2 and round up.
-		 */
-		len = DIV_ROUND_UP(len, 2);
-		/*
-		 * For very small repos, we stick with our regular fallback.
-		 */
-		if (len < FALLBACK_DEFAULT_ABBREV)
-			len = FALLBACK_DEFAULT_ABBREV;
-	} else {
-		len = min_len;
-	}
+	if (odb_find_abbrev_len(r->objects, oid, min_len, &len) < 0)
+		len = algo->hexsz;
 
 	oid_to_hex_r(hex, oid);
-	if (len >= hexsz || !len)
-		return hexsz;
-
-	odb_prepare_alternates(r->objects);
-	for (struct odb_source *s = r->objects->sources; s; s = s->next) {
-		struct odb_source_files *files = odb_source_files_downcast(s);
-		packfile_store_find_abbrev_len(files->packed, oid, len, &len);
-		odb_source_loose_find_abbrev_len(s, oid, len, &len);
-	}
-
 	hex[len] = 0;
+
 	return len;
 }
 
diff --git a/odb.c b/odb.c
index 3019957b87..3f94a53df1 100644
--- a/odb.c
+++ b/odb.c
@@ -12,6 +12,7 @@
 #include "midx.h"
 #include "object-file-convert.h"
 #include "object-file.h"
+#include "object-name.h"
 #include "odb.h"
 #include "packfile.h"
 #include "path.h"
@@ -964,6 +965,78 @@ int odb_count_objects(struct object_database *odb,
 	return ret;
 }
 
+/*
+ * Return the slot of the most-significant bit set in "val". There are various
+ * ways to do this quickly with fls() or __builtin_clzl(), but speed is
+ * probably not a big deal here.
+ */
+static unsigned msb(unsigned long val)
+{
+	unsigned r = 0;
+	while (val >>= 1)
+		r++;
+	return r;
+}
+
+int odb_find_abbrev_len(struct object_database *odb,
+			const struct object_id *oid,
+			int min_length,
+			unsigned *out)
+{
+	const struct git_hash_algo *algo =
+		oid->algo ? &hash_algos[oid->algo] : odb->repo->hash_algo;
+	const unsigned hexsz = algo->hexsz;
+	unsigned len;
+	int ret;
+
+	if (min_length < 0) {
+		unsigned long count;
+
+		if (odb_count_objects(odb, ODB_COUNT_OBJECTS_APPROXIMATE, &count) < 0)
+			count = 0;
+
+		/*
+		 * Add one because the MSB only tells us the highest bit set,
+		 * not including the value of all the _other_ bits (so "15"
+		 * is only one off of 2^4, but the MSB is the 3rd bit.
+		 */
+		len = msb(count) + 1;
+		/*
+		 * We now know we have on the order of 2^len objects, which
+		 * expects a collision at 2^(len/2). But we also care about hex
+		 * chars, not bits, and there are 4 bits per hex. So all
+		 * together we need to divide by 2 and round up.
+		 */
+		len = DIV_ROUND_UP(len, 2);
+		/*
+		 * For very small repos, we stick with our regular fallback.
+		 */
+		if (len < FALLBACK_DEFAULT_ABBREV)
+			len = FALLBACK_DEFAULT_ABBREV;
+	} else {
+		len = min_length;
+	}
+
+	if (len >= hexsz || !len) {
+		*out = hexsz;
+		ret = 0;
+		goto out;
+	}
+
+	odb_prepare_alternates(odb);
+	for (struct odb_source *source = odb->sources; source; source = source->next) {
+		ret = odb_source_find_abbrev_len(source, oid, len, &len);
+		if (ret)
+			goto out;
+	}
+
+	ret = 0;
+	*out = len;
+
+out:
+	return ret;
+}
+
 void odb_assert_oid_type(struct object_database *odb,
 			 const struct object_id *oid, enum object_type expect)
 {
diff --git a/odb.h b/odb.h
index e80fd8f7ab..984bafca9d 100644
--- a/odb.h
+++ b/odb.h
@@ -545,6 +545,22 @@ int odb_count_objects(struct object_database *odb,
 		      enum odb_count_objects_flags flags,
 		      unsigned long *out);
 
+/*
+ * Given an object ID, find the minimum required length required to make the
+ * object ID unique across the whole object database.
+ *
+ * The `min_len` determines the minimum abbreviated length that'll be returned
+ * by this function. If `min_len < 0`, then the function will set a sensible
+ * default minimum abbreviation length.
+ *
+ * Returns 0 on success, a negative error code otherwise. The computed length
+ * will be assigned to `*out`.
+ */
+int odb_find_abbrev_len(struct object_database *odb,
+			const struct object_id *oid,
+			int min_len,
+			unsigned *out);
+
 enum {
 	/*
 	 * By default, `odb_write_object()` does not actually write anything
diff --git a/odb/source-files.c b/odb/source-files.c
index e90bb689bb..76797569de 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -122,6 +122,30 @@ static int odb_source_files_count_objects(struct odb_source *source,
 	return ret;
 }
 
+static int odb_source_files_find_abbrev_len(struct odb_source *source,
+					    const struct object_id *oid,
+					    unsigned min_len,
+					    unsigned *out)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	unsigned len = min_len;
+	int ret;
+
+	ret = packfile_store_find_abbrev_len(files->packed, oid, len, &len);
+	if (ret < 0)
+		goto out;
+
+	ret = odb_source_loose_find_abbrev_len(source, oid, len, &len);
+	if (ret < 0)
+		goto out;
+
+	*out = len;
+	ret = 0;
+
+out:
+	return ret;
+}
+
 static int odb_source_files_freshen_object(struct odb_source *source,
 					   const struct object_id *oid)
 {
@@ -250,6 +274,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.read_object_stream = odb_source_files_read_object_stream;
 	files->base.for_each_object = odb_source_files_for_each_object;
 	files->base.count_objects = odb_source_files_count_objects;
+	files->base.find_abbrev_len = odb_source_files_find_abbrev_len;
 	files->base.freshen_object = odb_source_files_freshen_object;
 	files->base.write_object = odb_source_files_write_object;
 	files->base.write_object_stream = odb_source_files_write_object_stream;
diff --git a/odb/source.h b/odb/source.h
index ee5d6ed530..a9d7d0b96f 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -157,6 +157,18 @@ struct odb_source {
 			     enum odb_count_objects_flags flags,
 			     unsigned long *out);
 
+	/*
+	 * This callback is expected to find the minimum required length to
+	 * make the given object ID unique.
+	 *
+	 * The callback is expected to return a negative error code in case it
+	 * failed, 0 otherwise.
+	 */
+	int (*find_abbrev_len)(struct odb_source *source,
+			       const struct object_id *oid,
+			       unsigned min_length,
+			       unsigned *out);
+
 	/*
 	 * This callback is expected to freshen the given object so that its
 	 * last access time is set to the current time. This is used to ensure
@@ -360,6 +372,18 @@ static inline int odb_source_count_objects(struct odb_source *source,
 	return source->count_objects(source, flags, out);
 }
 
+/*
+ * Determine the minimum required length to make the given object ID unique in
+ * the given source. Returns 0 on success, a negative error code otherwise.
+ */
+static inline int odb_source_find_abbrev_len(struct odb_source *source,
+					     const struct object_id *oid,
+					     unsigned min_len,
+					     unsigned *out)
+{
+	return source->find_abbrev_len(source, oid, min_len, out);
+}
+
 /*
  * Freshen an object in the object database by updating its timestamp.
  * Returns 1 in case the object has been freshened, 0 in case the object does

-- 
2.53.0.1055.ga2ffed1127.dirty


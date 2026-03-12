Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBE387598
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304998; cv=none; b=mAkTkbSW5vOzoCOgemcwIffhnvFaoVFg0hA6tIgU+VBeF3ALaIrPyc+VkouecDtrhxCKjfCIqrRodMb8NnbjI95DoxN4jY3xatcKz5V3aNpSCE0B/eqnKZWpyAgeULKGc9n9IuKX29RiyQvqkmTtOlSEXJzE2iThvPAChseRgZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304998; c=relaxed/simple;
	bh=0tcm7xmdg1io/l3pmBOyKlOUV+1HjnKIvhwbwFBRxbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QtFOQESl68OyFhHfY07/84y6LJx8CYznaOZxw8Aae5/pxRTKkSnTa3OIq3K06nnaV8itrTfu/j4fWZaC/97/nRCJd6KlfUPyp9iH7M6XikP6ukYWI5pjC6W89h9HDeLaEmF1dPykjV7LdSThjgHNbkshwcmnlhtT8GdGGavjiBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jGfEMjUl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OpWXxjiz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jGfEMjUl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OpWXxjiz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 57BF9EC05AD;
	Thu, 12 Mar 2026 04:43:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 04:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773304994;
	 x=1773391394; bh=hk55laFhyGc2WWKn6z7dM5YHiXFKFpjqCOlmV5cmTVo=; b=
	jGfEMjUl2Q7dKWkz0A4YkzfNNI9Pguoynv5npGA67pQVZm+ovS2oSYac2AU2u2Qv
	qjtMdsQxGQ/DEPdBEO5em5tcvKkE7xpbphUpA/yFbvDiusnIiTEBYjM3mDKxkOGV
	giXfxNBep0BHAqXw6ASQ+KN6rB/NZmxIi3xnZwAkpN9ZqisPQT/0+p1V6AXklreR
	B6YRUaXFrSb4+0UFwvseQhWcSaCSBiLYt0i410mnt1MZIFdDZBV4Wmr+uEK13Ucp
	gsmSM6MhqnXILZDoHoyuwf3Jc3Y6/vj/SjnRv+bSAnDxU1H0LXmoJxN3qgMJ2iu6
	DW4JkkLFUnsF58V4Wh/i9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773304994; x=
	1773391394; bh=hk55laFhyGc2WWKn6z7dM5YHiXFKFpjqCOlmV5cmTVo=; b=O
	pWXxjizcFzeNnEynjJKfSjrYkXVcu7lGtSRh759YQ0w3ss+FJFX+CF5c8Dxr3+Rg
	hD+miNQr1JOg9odsBnM0XOw2qC8HSqhPBPLeaqbZ6q4m/6JtL0uWypHzx0tjKQ4f
	rz60oHiS0NEy3bS22pYiXUYY6a/u2wmnU1nOcw1IUQxgIMRJmoLe1ks1aMI78iFv
	z3s12vxhyvK0XBv2oR/29VKXSEJLkPx6G8T7KFuVg+MrB3N30x329EFRd1K6qGE8
	a/rNeq4EmeSMpbBmixeFCaxi5QXpndWr1P3H9E8XQLuz7boj3CPo1XOUkYr9XfzH
	ZimGf5q8Q4KWskd1rRKzw==
X-ME-Sender: <xms:onyyaWoF06e13EIc8pfvR-npEqFuMBvoBw5pVkRi3QZS_vH6znkpMA>
    <xme:onyyacGBQKfwWj93psRa1jDUKQWZjUvpn-OelwL2u5C3PO_xdGBM-Tgtzdz4JaPQS
    1lJIEh1XAxOlBHkpPXCBj1Us05tapXYaTYsAi74bSCQ81VlmzXH>
X-ME-Received: <xmr:onyyaYmtdFscFXcq5iy5lFPs-V5XWCvW1sdpGEFnoPY-qlAOvD_LnYcsaAK9wAWMGuV_h5gE5adgQ0732ZdGpT-CjWZ1CU1HcHu7Z8lmheeVpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeifeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:onyyafl8rXWYGohRtQc0k22F1UNEsi8YEb86GDI1NqJ9IVJABnbKpg>
    <xmx:onyyaZtnE4djbiluIk4NsN-26rcRj23_J0hNmTpgyXLXPDqLnKacgA>
    <xmx:onyyaSngzel0pVS7knVssH9fOvKOqjzqr-XkX01Y8zL-gM9OJd46SA>
    <xmx:onyyaUtRrCWIRMfwqSwQ3mT8Ale0YS1AIsrMOZ7hebbWcofmkMrPQQ>
    <xmx:onyyaUvY8f0tS2zc2uzObI4Y2kvL40wvVXdfr6S5wmm2c8d8feM0NLFa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 04:43:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id feb2460b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 08:43:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Mar 2026 09:42:59 +0100
Subject: [PATCH v2 4/6] object-file: generalize counting objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-b4-pks-odb-source-count-objects-v2-4-5914f69256bf@pks.im>
References: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
In-Reply-To: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Generalize the function introduced in the preceding commit to not only
be able to approximate the number of loose objects, but to also provide
an accurate count. The behaviour can be toggled via a new flag.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c  |  5 +++--
 object-file.c | 59 ++++++++++++++++++++++++++++++++++++++---------------------
 object-file.h |  5 +++--
 odb.h         |  9 +++++++++
 4 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index a08c7554cb..3a64d28da8 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -474,8 +474,9 @@ static int too_many_loose_objects(int limit)
 	int auto_threshold = DIV_ROUND_UP(limit, 256) * 256;
 	unsigned long loose_count;
 
-	if (odb_source_loose_approximate_object_count(the_repository->objects->sources,
-						      &loose_count) < 0)
+	if (odb_source_loose_count_objects(the_repository->objects->sources,
+					   ODB_COUNT_OBJECTS_APPROXIMATE,
+					   &loose_count) < 0)
 		return 0;
 
 	return loose_count > auto_threshold;
diff --git a/object-file.c b/object-file.c
index da67e3c9ff..569ce6eaed 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1868,40 +1868,57 @@ int odb_source_loose_for_each_object(struct odb_source *source,
 					     NULL, NULL, &data);
 }
 
-int odb_source_loose_approximate_object_count(struct odb_source *source,
-					      unsigned long *out)
+static int count_loose_object(const struct object_id *oid UNUSED,
+			      struct object_info *oi UNUSED,
+			      void *payload)
+{
+	unsigned long *count = payload;
+	(*count)++;
+	return 0;
+}
+
+int odb_source_loose_count_objects(struct odb_source *source,
+				   enum odb_count_objects_flags flags,
+				   unsigned long *out)
 {
 	const unsigned hexsz = source->odb->repo->hash_algo->hexsz - 2;
-	unsigned long count = 0;
-	struct dirent *ent;
 	char *path = NULL;
 	DIR *dir = NULL;
 	int ret;
 
-	path = xstrfmt("%s/17", source->path);
+	if (flags & ODB_COUNT_OBJECTS_APPROXIMATE) {
+		unsigned long count = 0;
+		struct dirent *ent;
 
-	dir = opendir(path);
-	if (!dir) {
-		if (errno == ENOENT) {
-			*out = 0;
-			ret = 0;
+		path = xstrfmt("%s/17", source->path);
+
+		dir = opendir(path);
+		if (!dir) {
+			if (errno == ENOENT) {
+				*out = 0;
+				ret = 0;
+				goto out;
+			}
+
+			ret = error_errno("cannot open object shard '%s'", path);
 			goto out;
 		}
 
-		ret = error_errno("cannot open object shard '%s'", path);
-		goto out;
-	}
+		while ((ent = readdir(dir)) != NULL) {
+			if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
+			    ent->d_name[hexsz] != '\0')
+				continue;
+			count++;
+		}
 
-	while ((ent = readdir(dir)) != NULL) {
-		if (strspn(ent->d_name, "0123456789abcdef") != hexsz ||
-		    ent->d_name[hexsz] != '\0')
-			continue;
-		count++;
+		*out = count * 256;
+		ret = 0;
+	} else {
+		*out = 0;
+		ret = odb_source_loose_for_each_object(source, NULL, count_loose_object,
+						       out, 0);
 	}
 
-	*out = count * 256;
-	ret = 0;
-
 out:
 	if (dir)
 		closedir(dir);
diff --git a/object-file.h b/object-file.h
index b870ea9fa8..f8d8805a18 100644
--- a/object-file.h
+++ b/object-file.h
@@ -149,8 +149,9 @@ int odb_source_loose_for_each_object(struct odb_source *source,
  *
  * Returns 0 on success, a negative error code otherwise.
  */
-int odb_source_loose_approximate_object_count(struct odb_source *source,
-					      unsigned long *out);
+int odb_source_loose_count_objects(struct odb_source *source,
+				   enum odb_count_objects_flags flags,
+				   unsigned long *out);
 
 /**
  * format_object_header() is a thin wrapper around s xsnprintf() that
diff --git a/odb.h b/odb.h
index 7a583e3873..e6057477f6 100644
--- a/odb.h
+++ b/odb.h
@@ -500,6 +500,15 @@ int odb_for_each_object(struct object_database *odb,
 			void *cb_data,
 			unsigned flags);
 
+enum odb_count_objects_flags {
+	/*
+	 * Instead of providing an accurate count, allow the number of objects
+	 * to be approximated. Details of how this approximation works are
+	 * subject to the specific source's implementation.
+	 */
+	ODB_COUNT_OBJECTS_APPROXIMATE = (1 << 0),
+};
+
 enum {
 	/*
 	 * By default, `odb_write_object()` does not actually write anything

-- 
2.53.0.880.g73c4285caa.dirty


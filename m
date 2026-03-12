Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BEC38910F
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 08:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305000; cv=none; b=cICKPK50BK7xY0kJsyxr76k3nzuVNDZqxd0tp7zfMfYbiEVAaNoU1V8+YVCHGhvEWrq0QBYqicqw4VYb6GhAk1j9ZTmWPR1tRxQtG/baUNBtfX0Wm5fvaQIoZuVv6P0oeV79gFp/gvEHAXTQeeW0FLYBiCZlYUekL6ows+5KpII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305000; c=relaxed/simple;
	bh=9km4RxKCPiHlf4DaXQyEp3Pb8+qbykPpZ8g0jjNPMjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hz6IFlZ337blWKIOPSuySb4blH7jSTGDRB+TjDTeo4ks7FJYZvWuTmhBqqwJuzDmTLVnTjQ6rCl62hYh5R1XBxDpouA+Ct+n31PohLVKbaJWf6qTydVc8UOfUPyeVnGm5++6Z2YQJ6YLUpkgekxoEbjD7PVpdtCjxQxdCgr2grQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fZHn6kb7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BQSRVJaZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fZHn6kb7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQSRVJaZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8235B1400035;
	Thu, 12 Mar 2026 04:43:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 04:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773304996;
	 x=1773391396; bh=Al1IZkpZhDfhZrgqW77iEjs2gbhUJFvSs3XjPiH+6gc=; b=
	fZHn6kb7kay0b74+WoLIi5fzMPaoy0KQkM6vMKYHOnUnc16vGYXHnt3z5nFjkrr9
	FddBi5CKtwKJCn3QuOPANynl2HDhyf5Gpy2SDuiO5DflPmPngrxyiztRvlqE7cER
	t5NotakVxUMg80wXSehgs9w57DuERkqWUDym7PNE3z/kSbsqF5CTlXIgynQyk48f
	ePB8mDIEZS8rS75NCy9IOCcwTrM3IbtsVoxwJSwTpgTl04BN44cRFmVFSvrH7JJ8
	5Ys1YrH0XErvludV1AlhBgFM+lx3StQbnllZmFxpkDIf312U3DwltrjHBGKEgv02
	9Ar0/gbf+Z18U9jpG0Ytrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773304996; x=
	1773391396; bh=Al1IZkpZhDfhZrgqW77iEjs2gbhUJFvSs3XjPiH+6gc=; b=B
	QSRVJaZLvlleqC4Jxb2XegesPoXFxx4WRj97DTb2sU8t0icoJOmJT9LwjBOvfDfh
	wdSGUHWG636v8X/6IlIvxDGuvd355ktDQ2HtBm4Xsv2SJY5pyfhFPCU6GYhTYcpd
	crAGrpT+Eywn67jOnDmozukrF2omdZLuGYSABExObH7d7pKI40NqETQYVCE8y/Ql
	0l8RxH+g2I7DGj3dYgpc8gR06vX4lyCRFeZFHvz4ULUlSpp2011jCa6z9O3iAMfL
	Rz4UChhC1V2t77sU9x1jGvmmACrt6SiZ+cw0sh5dcra+Goe/fwcQp2KhyyDUcIbj
	BUweBdDC82tRsWkk7fcHA==
X-ME-Sender: <xms:pHyyaUkTqDfPEwV_FOO4QxOMUVWZQRK9eX6GLSwzwJTSkHghu_nj5A>
    <xme:pHyyabTDAXt4M2jNV2xEthrp8F9biQ4pnsrFLCiaq992COEwcJtMgn7OWhb2kemT_
    AXBlQ06x6UATL2TQsjs-m8UFFnLwGIq8dZ8wuYK1XE31r5QkWzX>
X-ME-Received: <xmr:pHyyaQAUAqzrHmv7sPMGqvjSeOtZovOqbvOSbPrAezdqwuHnNa1SQp7-P44RHqcbcib2Kub_ilvJe-pF84KjBDHwLNXIZjGnOvklbKsDaRIVaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeifeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pHyyaaQHpXPcHWmn3jAlsyEVTRPu9vjWdhlFnyn1IlKOvUfFm6D_gw>
    <xmx:pHyyaWoUsy_GJU_ea_ukMqlE6Tb8MnkTS_4xec14iKnria9cM7cidA>
    <xmx:pHyyaUxu4Ps1NX7_yRS5VHxd_JgdHkXLzPoJ5an3jvTdAOXD5KjwIg>
    <xmx:pHyyaTJIiuUz-JEaB2zu6z1tYzxmjc1s0p2JmP-u3kr_7t8yXf5D8A>
    <xmx:pHyyaU7lsdWRayNssbyEiZ9Z99HLMn-0zGP3JsYHsXJfC9bYetC-vi6y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 04:43:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec341d80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Mar 2026 08:43:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Mar 2026 09:43:00 +0100
Subject: [PATCH v2 5/6] odb/source: introduce generic object counting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-b4-pks-odb-source-count-objects-v2-5-5914f69256bf@pks.im>
References: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
In-Reply-To: <20260312-b4-pks-odb-source-count-objects-v2-0-5914f69256bf@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Introduce generic object counting on the object database source level
with a new backend-specific callback function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 30 ++++++++++++++++++++++++++++++
 odb/source.h       | 27 +++++++++++++++++++++++++++
 packfile.c         |  4 ++--
 packfile.h         |  1 +
 4 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 14cb9adeca..c08d8993e3 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -93,6 +93,35 @@ static int odb_source_files_for_each_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_files_count_objects(struct odb_source *source,
+					  enum odb_count_objects_flags flags,
+					  unsigned long *out)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	unsigned long count;
+	int ret;
+
+	ret = packfile_store_count_objects(files->packed, flags, &count);
+	if (ret < 0)
+		goto out;
+
+	if (!(flags & ODB_COUNT_OBJECTS_APPROXIMATE)) {
+		unsigned long loose_count;
+
+		ret = odb_source_loose_count_objects(source, flags, &loose_count);
+		if (ret < 0)
+			goto out;
+
+		count += loose_count;
+	}
+
+	*out = count;
+	ret = 0;
+
+out:
+	return ret;
+}
+
 static int odb_source_files_freshen_object(struct odb_source *source,
 					   const struct object_id *oid)
 {
@@ -220,6 +249,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.read_object_info = odb_source_files_read_object_info;
 	files->base.read_object_stream = odb_source_files_read_object_stream;
 	files->base.for_each_object = odb_source_files_for_each_object;
+	files->base.count_objects = odb_source_files_count_objects;
 	files->base.freshen_object = odb_source_files_freshen_object;
 	files->base.write_object = odb_source_files_write_object;
 	files->base.write_object_stream = odb_source_files_write_object_stream;
diff --git a/odb/source.h b/odb/source.h
index a1fd9dd920..96c906e7a1 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -142,6 +142,21 @@ struct odb_source {
 			       void *cb_data,
 			       unsigned flags);
 
+	/*
+	 * This callback is expected to count objects in the given object
+	 * database source. The callback function does not have to guarantee
+	 * that only unique objects are counted. The result shall be assigned
+	 * to the `out` pointer.
+	 *
+	 * Accepts `enum odb_count_objects_flag` flags to alter the behaviour.
+	 *
+	 * The callback is expected to return 0 on success, or a negative error
+	 * code otherwise.
+	 */
+	int (*count_objects)(struct odb_source *source,
+			     enum odb_count_objects_flags flags,
+			     unsigned long *out);
+
 	/*
 	 * This callback is expected to freshen the given object so that its
 	 * last access time is set to the current time. This is used to ensure
@@ -333,6 +348,18 @@ static inline int odb_source_for_each_object(struct odb_source *source,
 	return source->for_each_object(source, request, cb, cb_data, flags);
 }
 
+/*
+ * Count the number of objects in the given object database source.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static inline int odb_source_count_objects(struct odb_source *source,
+					   enum odb_count_objects_flags flags,
+					   unsigned long *out)
+{
+	return source->count_objects(source, flags, out);
+}
+
 /*
  * Freshen an object in the object database by updating its timestamp.
  * Returns 1 in case the object has been freshened, 0 in case the object does
diff --git a/packfile.c b/packfile.c
index 1ee5dd3da3..8ee462303a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1102,6 +1102,7 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 }
 
 int packfile_store_count_objects(struct packfile_store *store,
+				 enum odb_count_objects_flags flags UNUSED,
 				 unsigned long *out)
 {
 	struct packfile_list_entry *e;
@@ -1146,10 +1147,9 @@ unsigned long repo_approximate_object_count(struct repository *r)
 
 		odb_prepare_alternates(r->objects);
 		for (source = r->objects->sources; source; source = source->next) {
-			struct odb_source_files *files = odb_source_files_downcast(source);
 			unsigned long c;
 
-			if (!packfile_store_count_objects(files->packed, &c))
+			if (!odb_source_count_objects(source, ODB_COUNT_OBJECTS_APPROXIMATE, &c))
 				count += c;
 		}
 
diff --git a/packfile.h b/packfile.h
index 1da8c729cb..74b6bc58c5 100644
--- a/packfile.h
+++ b/packfile.h
@@ -275,6 +275,7 @@ enum kept_pack_type {
  * Return 0 on success, a negative error code otherwise.
  */
 int packfile_store_count_objects(struct packfile_store *store,
+				 enum odb_count_objects_flags flags,
 				 unsigned long *out);
 
 /*

-- 
2.53.0.880.g73c4285caa.dirty


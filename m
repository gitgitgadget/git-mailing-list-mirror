Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4C246BCD
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720419; cv=none; b=NebDZuSv6eu6nLEZUxV+S+/GIuMrgjPspUAIIwrFH/RQyE9135bogeFENiDq02UwKbqcoubRBFgdHKxBbjTrmbzqrbkQEjic3ha7Vazmubt3w5XXOajeeztjnBZkcdFHyNvJg6uti0nmoFg6ayMF5qYFmiif4h2HheGRF6wfByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720419; c=relaxed/simple;
	bh=sy1x/BGwisMgvO1bsvgTo9mZEkvMu3yg60p8kgXwAWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MH+TBT1lCGATg3ZLWfh7EJw2HS5WXrH0l9grUfKHtdOy0pwQryEnqiaH/uqW/lTTYKzL9EVt0Bzsipnk1epOTzfHbaGnRofb0QGf81VnXCqDMbptY8wjEPRYH861aqekYK2my8sZdlM4UlMMm2jhU4jJY9BMxVIYW+8xp5CO5Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fdbjWYoi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MY1q3Lxx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fdbjWYoi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MY1q3Lxx"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id CD91D1D00125;
	Thu,  5 Mar 2026 09:20:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 05 Mar 2026 09:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720417;
	 x=1772806817; bh=qAkq/QUkDfUQi5B/cImgpOz2b9FJ3HSbCLXkUITT0Ck=; b=
	fdbjWYoi+/GNM8Zb7N5ppp31hdVpOxjlQoYCkkzxEdWqFVvqmIbFb81n5j9OiTEn
	kzVI3nYJIjnMIla5Kqbk9StsJLk+Xr25z9Pubzg+Fn5MUVWCvCjg2nOb5XQN/+Sq
	tHgPeSmIRGQNEL6UKXGC7mTe/OGD/rjWu5naGEmHd9Pdhhs1qYHusIA/tilZzYar
	ogcIobpb407Q667mAFpQpLsvSfAytplaC7NoMkAy8LSEyGOv/CIhz8ojsyBvGm9q
	RRN3Ftm0rVsP96m5WuCGEMZRu8VQoHIzR9lR7ga+aVbwW3x//RnspjUja0tV/d9k
	QSazesbt15Uh21KRsjAT5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720417; x=
	1772806817; bh=qAkq/QUkDfUQi5B/cImgpOz2b9FJ3HSbCLXkUITT0Ck=; b=M
	Y1q3LxxyaBgs4FyiOwzZvLj2nXQ6wEVIXRfF1Lcwh3qEJtAd0j/azX8Y9NsC50pX
	mXVkoClcLgn1eUWw9ivdh8LKGOrsqb13iV3WJzPsRPVDWXx+EQnnIEwqGkCvl/bq
	rKcS+UQd/7QoGyGRfiWtLSM7gpIjdlXFv6IWdrxFiNBAfCuYp57UbGNyq9Kg/Yta
	g0SP/m2GMsJqjB8QPvSzLJUMaekhg7rH0/bd5yWBf027vV7Udd81QHQ4i2wn5hwc
	bgPtNDPMDChNlaAiaWkoQHDGdUJPS/CjOic367hCRsrr8iMoieHJ+Ntjmy2sFkZr
	a1OJBzCk+GegczDCw+QZg==
X-ME-Sender: <xms:IZGpaflaJiIh8ViAzY3_XH-vxBiKDPuh8XyRFTM4GEIVpvq0IZpyCQ>
    <xme:IZGpaZ0yyy4seJxx7vvTzuUXXyfiRI69A61bn_xqaKNWRvwCdfcB2agvJIkicB1Hu
    g_-bhK_dwqapsBRsEH_sAcW5IBKg246ZjcRY-ZQv-Hy5_MajI6L>
X-ME-Received: <xmr:IZGpaaqoo7gElH0ZQE7GBpSoW8MxmCEHvoLs49jfQgrxcaydOLxCLsPb9rhkoqwPSZY3p0VEJ2_CGHarjem3k1F-K-eIvsSt-3Sjv3n4P_HG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IZGpaWeaD2nPmJbdAN1U-XxYI2G8sw6dlSEHBhYbGVbDWvHHi-KxSQ>
    <xmx:IZGpaZp9khbv4LdwX149yblPLedw9XkrhGaRI34Wj44Vdfk_yhphLw>
    <xmx:IZGpaXEkxt2ea6TL26c2P-gN29x9FQWzqFtHsuXq0Ek1EESYMCQhWg>
    <xmx:IZGpaZsdMpC4Fy-X8UcsJf4MHuzU-iEWoCtftZwXRSe0GFuI9nJuLA>
    <xmx:IZGpaWKHRr6RUwJ4OK46KF-D_VxG4ZP5Y2f1srqfhtgJaCgD7NWrTqYO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:20:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4138eaf5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:20:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:51 +0100
Subject: [PATCH v2 11/17] odb/source: make `for_each_object()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-11-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              | 12 +---------
 odb.h              | 12 ----------
 odb/source-files.c | 23 +++++++++++++++++++
 odb/source.h       | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 23 deletions(-)

diff --git a/odb.c b/odb.c
index c0b8cd062b..494a3273cf 100644
--- a/odb.c
+++ b/odb.c
@@ -984,20 +984,10 @@ int odb_for_each_object(struct object_database *odb,
 
 	odb_prepare_alternates(odb);
 	for (struct odb_source *source = odb->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-
 		if (flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
 			continue;
 
-		if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
-			ret = odb_source_loose_for_each_object(source, request,
-							       cb, cb_data, flags);
-			if (ret)
-				return ret;
-		}
-
-		ret = packfile_store_for_each_object(files->packed, request,
-						     cb, cb_data, flags);
+		ret = odb_source_for_each_object(source, request, cb, cb_data, flags);
 		if (ret)
 			return ret;
 	}
diff --git a/odb.h b/odb.h
index 70ffb033f9..692d9029ef 100644
--- a/odb.h
+++ b/odb.h
@@ -432,18 +432,6 @@ enum odb_for_each_object_flags {
 	ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
 };
 
-/*
- * A callback function that can be used to iterate through objects. If given,
- * the optional `oi` parameter will be populated the same as if you would call
- * `odb_read_object_info()`.
- *
- * Returning a non-zero error code will cause iteration to abort. The error
- * code will be propagated.
- */
-typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
-				      struct object_info *oi,
-				      void *cb_data);
-
 /*
  * Iterate through all objects contained in the object database. Note that
  * objects may be iterated over multiple times in case they are either stored
diff --git a/odb/source-files.c b/odb/source-files.c
index b50a1f5492..d8ef1d8237 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -66,6 +66,28 @@ static int odb_source_files_read_object_stream(struct odb_read_stream **out,
 	return -1;
 }
 
+static int odb_source_files_for_each_object(struct odb_source *source,
+					    const struct object_info *request,
+					    odb_for_each_object_cb cb,
+					    void *cb_data,
+					    unsigned flags)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	int ret;
+
+	if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
+		ret = odb_source_loose_for_each_object(source, request, cb, cb_data, flags);
+		if (ret)
+			return ret;
+	}
+
+	ret = packfile_store_for_each_object(files->packed, request, cb, cb_data, flags);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -82,6 +104,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.reprepare = odb_source_files_reprepare;
 	files->base.read_object_info = odb_source_files_read_object_info;
 	files->base.read_object_stream = odb_source_files_read_object_stream;
+	files->base.for_each_object = odb_source_files_for_each_object;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index 4397cada27..be56995389 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -52,6 +52,18 @@ struct object_id;
 struct object_info;
 struct odb_read_stream;
 
+/*
+ * A callback function that can be used to iterate through objects. If given,
+ * the optional `oi` parameter will be populated the same as if you would call
+ * `odb_read_object_info()`.
+ *
+ * Returning a non-zero error code will cause iteration to abort. The error
+ * code will be propagated.
+ */
+typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
+				      struct object_info *oi,
+				      void *cb_data);
+
 /*
  * The source is the part of the object database that stores the actual
  * objects. It thus encapsulates the logic to read and write the specific
@@ -150,6 +162,30 @@ struct odb_source {
 	int (*read_object_stream)(struct odb_read_stream **out,
 				  struct odb_source *source,
 				  const struct object_id *oid);
+
+	/*
+	 * This callback is expected to iterate over all objects stored in this
+	 * source and invoke the callback function for each of them. It is
+	 * valid to yield the same object multiple time. A non-zero exit code
+	 * from the object callback shall abort iteration.
+	 *
+	 * The optional `request` structure should serve as a template for
+	 * looking up object info for every individual iterated object. It
+	 * should not be modified directly and should instead be copied into a
+	 * separate `struct object_info` that gets passed to the callback. If
+	 * the caller passes a `NULL` pointer then the object itself shall not
+	 * be read.
+	 *
+	 * The callback is expected to return a negative error code in case the
+	 * iteration has failed to read all objects, 0 otherwise. When the
+	 * callback function returns a non-zero error code then that error code
+	 * should be returned.
+	 */
+	int (*for_each_object)(struct odb_source *source,
+			       const struct object_info *request,
+			       odb_for_each_object_cb cb,
+			       void *cb_data,
+			       unsigned flags);
 };
 
 /*
@@ -232,4 +268,33 @@ static inline int odb_source_read_object_stream(struct odb_read_stream **out,
 	return source->read_object_stream(out, source, oid);
 }
 
+/*
+ * Iterate through all objects contained in the given source and invoke the
+ * callback function for each of them. Returning a non-zero code from the
+ * callback function aborts iteration. There is no guarantee that objects
+ * are only iterated over once.
+ *
+ * The optional `request` structure serves as a template for retrieving the
+ * object info for each indvidual iterated object and will be populated as if
+ * `odb_source_read_object_info()` was called on the object. It will not be
+ * modified, the callback will instead be invoked with a separate `struct
+ * object_info` for every object. Object info will not be read when passing a
+ * `NULL` pointer.
+ *
+ * The flags is a bitfield of `ODB_FOR_EACH_OBJECT_*` flags. Not all flags may
+ * apply to a specific backend, so whether or not they are honored is defined
+ * by the implementation.
+ *
+ * Returns 0 when all objects have been iterated over, a negative error code in
+ * case iteration has failed, or a non-zero value returned from the callback.
+ */
+static inline int odb_source_for_each_object(struct odb_source *source,
+					     const struct object_info *request,
+					     odb_for_each_object_cb cb,
+					     void *cb_data,
+					     unsigned flags)
+{
+	return source->for_each_object(source, request, cb, cb_data, flags);
+}
+
 #endif

-- 
2.53.0.797.g7842e34a66.dirty


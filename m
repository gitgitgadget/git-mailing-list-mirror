Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3692148167E
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999844; cv=none; b=cBCONdrdEQsY0PHXw3HnvpSdmq2UCvtbTK3QCtvqe79NH8XZk6XCExR51jqs+E8joY+qsPpedVjBSdOaax3YY6qwYJrWqlWJr+KltpS9/b1VNzSlvCb/zaYQOFTdh1mnVCU2Yj8Paa3wRrLwkbz8bGSu7r55Lv5+tU3gWquEGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999844; c=relaxed/simple;
	bh=Np+r8wtzDRxTMm2QH/M6gmJe4aiAtCRluDcuwILg3t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KALFXa1wPBangg3J3MZrdcX/5ugKrXjrI4MJB2MsuM93KSJ475vgj+Z/Kw2DD/c03zCR3rgCh9gZau9ItriP8d6QIS9gpDN0TBvn7ofYHnbrVhnxc+Fmyc/WdSnIIEstxqsL5fS8ZoioqeeYeiDIyJcAqpWWm1gWw5nrNwiobj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R/8clVEE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KPibBKy8; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R/8clVEE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPibBKy8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23BCA7A0031;
	Wed, 21 Jan 2026 07:50:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 07:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999840;
	 x=1769086240; bh=T7RCkvRAscweSAKWHgtgqY47zGoVKgEDHAnwwJqCGZU=; b=
	R/8clVEENdk60EVxIy8XdkhEZzqeWAEVEh/WYlhL6H5S3iBJFqRLMni5hkQS0T4r
	0/nIIi2ytSFUs1esA4hRrpDk5lIwmcE9p96Ihml7NztRV4VNQWJ/cXB4gVKqbRp1
	jqnkfgBvUtWi98UFfK9U+jiNkZrn/rT3x9p9Q+YgD/Orv7Vmb2K+eE72g16+znE1
	goyX2Pn1yLIbzRSNKhmOW3DaO6ibHBkmsHhYxCuvBkaf3herhbB+v1hZpaD18R2R
	Vu8svc1gcc/I9CpqMFw0ugnH1wyTUpXpO1uWtXK2W7BRXtudoyBez4wEtroXSC0C
	FkPQzNLtpFCJcdQHuYsyrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999840; x=
	1769086240; bh=T7RCkvRAscweSAKWHgtgqY47zGoVKgEDHAnwwJqCGZU=; b=K
	PibBKy8nzuIJVX0STX+V9X5dvxCQR60JOYquqFa8wI0ksJOyG5Q/WMVD5sZV1mOQ
	IA+B8sjYVlqTBnHUXTeH0eaZk0Nb7OckxCTd+dKVwwDcjQ0Hz8zeD2KVXodQkZ/m
	CAhtvt0im/scUWRByyqQDfuUMi2G0aKT6u1klDKhoKbAS2j59QUtpSRW4aMirrfu
	dF/mN8PbCg7oFXcDiEYaXszKORDwtuJs7a3YdIBYS/iIz91C2vnYFUpXExHGV/uI
	9Fbaq+fXFhtSTJh+ToOyP1zDGSGd4iqCzKfPJNITU3Sym0/+s4juawJCczMI/9FJ
	tGIYM+il3ud0IcdG/i12A==
X-ME-Sender: <xms:oMtwaa_sXZeTBPfLIILOZ02yZYEnTgKBhzTk6a8AogNiGnzdcuH1kQ>
    <xme:oMtwaRvBJSwCWbEQtwKDaxCxi_tu0eygJWD9zVyaQhqnhsrZWDCbGPLxEiTyYsSAl
    cMKMR7t9daiFxN8i1UU5wTgOp0CvgEOy7ip_ejRmYTPAGcic_M1>
X-ME-Received: <xmr:oMtwaVCIX5QaMRPWgKzP_QqkGZF2C2DlnZBGuy8eBXJ8F-JOXmP6ATiwvufiiI38xs08EaiEdnYLhpI_ZpBoS65v6OodzCUAPwGkBDiss-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oMtwaRX4BOTU44MUiTE5VLmWs0bUkkMVNrdCw845fZ8l-YcfJMv56w>
    <xmx:oMtwabC0nSNr3fonDRlkf7TJhwVFunaaYgEzGlSkMSlCjLsxOIz3FA>
    <xmx:oMtwac9cUltTkH5rMsTb994C9lWRNqIGxNxFhNB0jNcklMpp7LmGsQ>
    <xmx:oMtwaaGRMnok2eFxNGh9Fh4nSgaJ9yJfCToJANUX7HKXWxx044VGNw>
    <xmx:oMtwaYgyUvT-MC5_Yoqhph14kY9Vxj9HoKpmG9XvSmDJZq_wwdSfPv4M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:50:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd31662d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:50:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Jan 2026 13:50:20 +0100
Subject: [PATCH v3 04/14] object-file: introduce function to iterate
 through objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pks-odb-for-each-object-v3-4-12c4dfd24227@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We have multiple divergent interfaces to iterate through objects of a
specific backend:

  - `for_each_loose_object()` yields all loose objects.

  - `for_each_packed_object()` (somewhat obviously) yields all packed
    objects.

These functions have different function signatures, which makes it hard
to create a common abstraction layer that covers both of these.

Introduce a new function `odb_source_loose_for_each_object()` to plug
this gap. This function doesn't take any data specific to loose objects,
but instead it accepts a `struct object_info` that will be populated the
exact same as if `odb_source_loose_read_object()` was called.

The benefit of this new interface is that we can continue to pass
backend-specific data, as `struct object_info` contains a union for
these exact use cases. This will allow us to unify how we iterate
through objects across both loose and packed objects in a subsequent
commit.

The `for_each_loose_object()` function continues to exist for now, but
it will be removed at the end of this patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 41 +++++++++++++++++++++++++++++++++++++++++
 object-file.h | 11 +++++++++++
 odb.h         | 12 ++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/object-file.c b/object-file.c
index a651129426..65e730684b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1801,6 +1801,47 @@ int for_each_loose_object(struct object_database *odb,
 	return 0;
 }
 
+struct for_each_object_wrapper_data {
+	struct odb_source *source;
+	struct object_info *oi;
+	odb_for_each_object_cb cb;
+	void *cb_data;
+};
+
+static int for_each_object_wrapper_cb(const struct object_id *oid,
+				      const char *path,
+				      void *cb_data)
+{
+	struct for_each_object_wrapper_data *data = cb_data;
+	if (data->oi &&
+	    read_object_info_from_path(data->source, path, oid, data->oi, 0) < 0)
+			return -1;
+	return data->cb(oid, data->oi, data->cb_data);
+}
+
+int odb_source_loose_for_each_object(struct odb_source *source,
+				     struct object_info *oi,
+				     odb_for_each_object_cb cb,
+				     void *cb_data,
+				     unsigned flags)
+{
+	struct for_each_object_wrapper_data data = {
+		.source = source,
+		.oi = oi,
+		.cb = cb,
+		.cb_data = cb_data,
+	};
+
+	/* There are no loose promisor objects, so we can return immediately. */
+	if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY))
+		return 0;
+	if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !source->local)
+		return 0;
+
+	return for_each_loose_file_in_source(source, for_each_object_wrapper_cb,
+					     NULL, NULL, &data);
+}
+
 static int append_loose_object(const struct object_id *oid,
 			       const char *path UNUSED,
 			       void *data)
diff --git a/object-file.h b/object-file.h
index 2acf19fb91..048b778531 100644
--- a/object-file.h
+++ b/object-file.h
@@ -137,6 +137,17 @@ int for_each_loose_object(struct object_database *odb,
 			  each_loose_object_fn, void *,
 			  enum odb_for_each_object_flags flags);
 
+/*
+ * Iterate through all loose objects in the given object database source and
+ * invoke the callback function for each of them. If given, the object info
+ * will be populated with the object's data as if you had called
+ * `odb_source_loose_read_object_info()` on the object.
+ */
+int odb_source_loose_for_each_object(struct odb_source *source,
+				     struct object_info *oi,
+				     odb_for_each_object_cb cb,
+				     void *cb_data,
+				     unsigned flags);
 
 /**
  * format_object_header() is a thin wrapper around s xsnprintf() that
diff --git a/odb.h b/odb.h
index 74503addf1..f97f249580 100644
--- a/odb.h
+++ b/odb.h
@@ -463,6 +463,18 @@ enum odb_for_each_object_flags {
 	ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
 };
 
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
 enum {
 	/*
 	 * By default, `odb_write_object()` does not actually write anything

-- 
2.53.0.rc0.250.g0ac79233d6.dirty


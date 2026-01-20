Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85A477E28
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922781; cv=none; b=qDEUijciyIDT2i9xTVMKAmuYmDQZx4glZB89qEFNQf55U9ugwAtES/dF/dNZ7G4zV/FdzLpwwMiXuRL3jV8ZmrxuhSbHG2YcGj+6REHsezOhJtll8y1kH21zd/Xj6IoHM3rdP3S26ZvhE6PhW6Q7wnI098B5k+ya86DY9sSVyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922781; c=relaxed/simple;
	bh=Np+r8wtzDRxTMm2QH/M6gmJe4aiAtCRluDcuwILg3t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cjExNZu9Fpw/+S6bh8e6//NqZ7l+s3PXL4gNriale8jc/E+ITKQC1XfD+klyijjak3CKfwDBcj8+E/veeaLTh7Me5WJmaYj5Ol60P5twnodoczkb6JR/dt/+u1OOO60+sOS/44ROC2TlK4gp6HUTEdDk+V7qzbDyEAQYzQH71ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FS8Y41Wo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jhCEInJJ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FS8Y41Wo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jhCEInJJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A5E407A00E2;
	Tue, 20 Jan 2026 10:26:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 10:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922777;
	 x=1769009177; bh=T7RCkvRAscweSAKWHgtgqY47zGoVKgEDHAnwwJqCGZU=; b=
	FS8Y41WosutlkOKnaS5es1/jX0vcaKb+7GM+6FYsP3590BwUSauZwGt+4+6e8L19
	0GSfgkzkr6EtkkCZ8ehdr4ZVp2ek7M7GZtLFqLGbQtRazFtLiv/qihcr5rC7/8p6
	VcKfWeSqOwcnUIHR4JtYUQpfDv6FvFWVB0/uBLpPgngIyTjwNQ6T7OVx8J+zmdZ4
	YX+WdxHbgwwb/j8W6nbkqOYZbtaQbbSkoY6YUIOqG+SX2Gie5O91ucNwoCgHlFHM
	H7/JLKXUe48c+EzheGWUK3t8R5jLRx73Wut/TNbAEeKTKZFt8R6siaM0Fc2lF0q9
	X+0e8nFdHM8mgba4bgLgrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922777; x=
	1769009177; bh=T7RCkvRAscweSAKWHgtgqY47zGoVKgEDHAnwwJqCGZU=; b=j
	hCEInJJyDHEYNte6kWXFmq6RPsnsnA25R0CztYz3f02n12qIAJNE7liX5uBLv9SO
	snkjTYk3DOrDU+JkA5Fz+reim1MuR6CWruVJRu6i6C4PWetVZdc6bavnB7FDmGQA
	panOFnzdF1kFwtvZYGl1A+nUlfr0UYtTqEoVhL6H1k6PnioKMjgR8Ph28CjRTsYB
	oQc34REc4zxWidhHOV3TRpJyaTpLct7ES1FSVWGjUQ4glQWuRgqpMHsqUUZFHk8L
	RTPLpGCkAhbhsORProUVqg6pTKwk2412nK1kQm9UV4rr+uspIrs8hz8jMBvRHlb7
	noFg/8PiprZR1JEcm5xtQ==
X-ME-Sender: <xms:mZ5vafBCk1mZv-9YNfh4-aPfu6tS6dq6-tNrntM_L4brQPPzrP0veQ>
    <xme:mZ5vacjgRaqpSl_t4T5eRiI52RfvGCi7C2xh3WjoFTRfIXoHOCbItqebBdCghaBb8
    m0PXd1NBzOmNdprEbe-_gDvERVZfVZDmEjKvj3JTEnmwjgzdlO0KA>
X-ME-Received: <xmr:mZ5vafly_l2qboijskI0u8tlXG6wRe3VXRAs_J4GZ8DRwoKXPcDaSuRE3nhy7AFPBXfim16gm7XKyPom7MaJePVZ5vxYntFjMD_Av7vVYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mZ5vaQq4TmV1JcBDdzW7VwrC92kVtAOgqd6loX8nsztha84H0oBy3w>
    <xmx:mZ5vaQGOVt4-VkD24XxH0JNwgYTELJ3xLyk9sUuTq08Vy5aO3A3b7g>
    <xmx:mZ5vaUyq8YPgDJSiTI4P14o7CVrF1X5XTw3aR9sS7mOFzYtP2cbFkA>
    <xmx:mZ5vadrd4LrEjvLdN3il-dn-xVi2Q_X24bvvnPwurCZVSiDFtKyh2Q>
    <xmx:mZ5vaXGqeBtIu0LhEGrK1MczVQ83N6hHLK_cMZIoCm0Z0SCY9zzfJBVQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 82f73adb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:26:00 +0100
Subject: [PATCH v2 04/14] object-file: introduce function to iterate
 through objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-4-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
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


Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323232D7F7
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421097; cv=none; b=oQB0wbh/CHZ+Ef2FIYnN/X+YZmk2f/gDb1UTUj7n7bZliIqZfecV9VPgzp2dgx0z+CcYue0f5qRKmLrQL4MQZ6lHsXwgKpu5MCBBVU1iMG3M91UhYlpwmw4vBDZhy+UKoko9rBvdaQOAqAn56R8L9E8z+hKqbG/tvcvANDR6TH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421097; c=relaxed/simple;
	bh=7VctJU3F9/xVCIwzVLsn29qclTCfhAz8eJaYrBVwLBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QC6DPw0++wv8SRb+GSGiOAcXrLCvwm2Pi7bAWwbD8jeJtwsPn8XcYu+zksuIEw7NBTgXduRokSwmYy3KVDKsxS1ZXAzQBJVZpj893TRWPpBX7Y0iRKvUxzMSjIGDQBm7VPJlR2fBO65cWLk+eBprA1fwuTnPxlbVvpWHTASV5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z1/nUWvy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qm0nnpuP; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z1/nUWvy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qm0nnpuP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 73A1E7A0044;
	Mon, 26 Jan 2026 04:51:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 26 Jan 2026 04:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421094;
	 x=1769507494; bh=ClMQcKu1SUInB6GZ1B/s87K2OIBQx/O5ENQWPBik9c8=; b=
	Z1/nUWvy9JZ/EornExlFhuKLtSS2ARA1XNs4uFeDfXKh3b/e8JZRan0WtIzAnz+I
	hbFqbVERFH+iBcBBb+Fz/1oyhocRa/wAxqsz/NNoEsKGfr2+HKStpanKUqjDk+eN
	1dBCgqdNT3rUX17rdL5ZK1pXsLvim3hYmW3HLKNTJo0zagG35DiNAx0aJahfzjM7
	ZjpC/mf/F7ENUi2ofVRaD1k9wbe3w30JZsq8Gwzjjl1mX3c32DwTUwvEfvBB5zZt
	yDZsDjk3Ov7eS9Q5kWkc4n2oWatKEl1Qm0euWs6Kyrqmix1P9R+BrSxVAOe/e4RC
	XKXYHqf2p+aHXk7DedaC7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421094; x=
	1769507494; bh=ClMQcKu1SUInB6GZ1B/s87K2OIBQx/O5ENQWPBik9c8=; b=q
	m0nnpuPctDLkYzZwn0Q1prNC0Ho4pGZjna3oZs3QzzlKHZ/mvbaedxKZznN7yD6+
	ESr3QcO+W2T9UDeZEQCQXklFOyUpRluQd6s6MGe6ZNZlnhVxdKNArsOibLazU5PY
	TFPVGzNnmsDWED35YX9IGM6rzrueP5uuq9wiBcmu1OCmRbbYKtjxO4pFmyZG8Q8S
	d8rHhX7KMD04K5JpqEsRl869qEVW/KBiOzSmK8soRaQpiSgKGDUTTkJHU/um9WKW
	eq2NQZgNch1D4ebS7B9bTFnUByMRDbcV72Sb+yzxm8KjAOfY9SymHSUQcLSW19zW
	cEJx3jyBkVtiFuR1MPAzA==
X-ME-Sender: <xms:Jjl3aZsuJ9Tjr5uQLONa0BRiWR0IDzO07tDVqAoEC5TTzPT9F396vQ>
    <xme:Jjl3aZfaoEyCBE6QYVJIACD548swLEz_1iEdRA9DN-Vnf5qjWU4QDJHBck0aqtmND
    3kGEZOmbPPpqtVtmWJ10isKMSi_reCdvLRjmyn4EWe8EMYGdQ3bXw>
X-ME-Received: <xmr:Jjl3aRzK_gcxizhaqaVX0Xzpv3kQbGwCA_-R1Cma4dmqBPfaAFrm3iGqaa4KT0y0y112FtyVYSD1Pq76ttzTTubpZ-_FVx1hmSafpRzHExdKNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Jjl3afFDAcQu2knGL6k1JOkWmqeJEwPUAw0zCGmKv_NRytoCOh8a9w>
    <xmx:Jjl3aVypAeUTBFbURnp1DCvpe5Mc-eq0TbTX1OM82nVuRr9c_aLuIw>
    <xmx:Jjl3aQsSRDfGAYLTysFWLK89RC_Z0waKbesYC2jbA_YSEkfjwnMNdA>
    <xmx:Jjl3aS2kQGTUUq5CrOIou71I_y8RrfdeR6vzsTZo151JFwy8gjIMpg>
    <xmx:Jjl3aVQrnfW7nuG3B_TkkPSsP2HBZDBm7r7jRZC67FC9oIgCh_R9Ejpe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0f7a797c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:20 +0100
Subject: [PATCH v4 04/14] object-file: introduce function to iterate
 through objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-4-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
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
 object-file.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 object-file.h | 11 +++++++++++
 odb.h         | 12 ++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/object-file.c b/object-file.c
index a651129426..ef2c7618c1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1801,6 +1801,54 @@ int for_each_loose_object(struct object_database *odb,
 	return 0;
 }
 
+struct for_each_object_wrapper_data {
+	struct odb_source *source;
+	const struct object_info *request;
+	odb_for_each_object_cb cb;
+	void *cb_data;
+};
+
+static int for_each_object_wrapper_cb(const struct object_id *oid,
+				      const char *path,
+				      void *cb_data)
+{
+	struct for_each_object_wrapper_data *data = cb_data;
+
+	if (data->request) {
+		struct object_info oi = *data->request;
+
+		if (read_object_info_from_path(data->source, path, oid, &oi, 0) < 0)
+			return -1;
+
+		return data->cb(oid, &oi, data->cb_data);
+	} else {
+		return data->cb(oid, NULL, data->cb_data);
+	}
+}
+
+int odb_source_loose_for_each_object(struct odb_source *source,
+				     const struct object_info *request,
+				     odb_for_each_object_cb cb,
+				     void *cb_data,
+				     unsigned flags)
+{
+	struct for_each_object_wrapper_data data = {
+		.source = source,
+		.request = request,
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
index 2acf19fb91..5b9641cd89 100644
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
+				     const struct object_info *request,
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
2.53.0.rc1.267.g6e3a78c723.dirty


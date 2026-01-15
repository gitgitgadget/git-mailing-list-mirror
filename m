Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D8336E464
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475108; cv=none; b=UtobcgE0k3mwmh/Zhk5Z1bx+s4eGFY+Je1vELp1xRO4wIcv7fEwR2Tjc09L36JgN8gIXR6a+1ztDDq8KO46uTGbKJfOQw/HxS2bev/q2iokDrqVtyUZYzRMJzGB2DXmDfSsGGGHkJyNZCMQ6xSkjJz5csyLs/hGkyopCClafGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475108; c=relaxed/simple;
	bh=4V+8wxN0lJOaP+sLGPvYi0hQfEdobva8V700pPJEfIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+0lV7WAtqn1OniuUyTkw5/tLrzKcKshqMwmLS4ZwndI9TkoA0O6WBbjbLY9if9gU1RJptpUTFM+4/HeSLdqGFWSynshj0uwlsRWpMZsPqKOFyGj+WnIXyubtM+ncXaODgNhMiI7ouV2rx70qIRVoq3vi6HWfK5t5uWKBecEr+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a5LsOagF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J0+Z+M6F; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a5LsOagF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J0+Z+M6F"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 087097A00AC
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:06 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 15 Jan 2026 06:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475105;
	 x=1768561505; bh=vrHMavPnmWdx1FDIATWy48IdGXOhJMG5+OQivGZLbqs=; b=
	a5LsOagFgh7XJ8VMQ1itAb9B6rBzS2hEywLcbpkzfk3pJ1Hn8i50lkOZpSJmGLcc
	0aQ4OqdesMF0A2SkGAVtIAV1QaMRDRxySRM+NpX12O0Z7LLbZD5lVQX4uiXTizk+
	C3a9hPtQJZr9loxIhm2n2B9JS62pJf4utdVhCiGALQMm9f+yL+wmYxBMrXcbjkn0
	8eqlVaWBzT5fOD/xrtZNRUVO6lNsKB+dKrSszPzVgMtdazjVYWsgNjZWItWl7alG
	bRadbUAHWsBDiggDTtbDWbani8Zdj6E5fcqRMj36/v+AUH2Uf2cAUv2IZhfSxSVC
	0KjQdBJLM2EmHM11oTkvbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475105; x=
	1768561505; bh=vrHMavPnmWdx1FDIATWy48IdGXOhJMG5+OQivGZLbqs=; b=J
	0+Z+M6FliItxBNwkRgL55kdyLSsKfNonIpmisuwqkSZyvBkSsBd+om2NsHneMi5/
	yUzR7scx+Z26aIxirHYqxNzSdx+Sz/3elXRgvhNFFymhadGa4ikTov5AKIqqyD56
	D600WZMq0rOtpXnthKtsDy2PNIwTwTzUrnpUSbI/mjuhBkFNPzIxB5PrYKd+XFu4
	r1JSMbstsdEFmijJDULzTpcc9wJ1/YXSftd+BCn3kBPnmjLZI7/iYTz3o1tdivju
	HujFSLOVQYARsHfZGiCAJsDXeDLS4z/vyjXYzfZCeZsIoqv6XXTdgy1A2FV4grFQ
	16SEjOIvdMietBIE0mmuw==
X-ME-Sender: <xms:4cloabC7XTEKm6tE-cMdC2zmMtKVqquwxPE2yOOKOX9rKap-c-2PVA>
    <xme:4cloaYceaYhj57bi3XMGIAGbCeHWVKkjVso0-IsU647sb7Ce7UQOs2R8wpzsVIDSY
    yLkVdq6z3Pf0ykHXkyjXgUu3wYjm2fn3JbMdPEN-0cLtQOdwPnH2Q>
X-ME-Received: <xmr:4cloacO0xTghmTk9VWfr2mpH2AivQJHT5b2ZRNoJqBmR9VBgB5BSTTYZc8ahfeFybrSwrYYrK8vGQEDcVVy9qmoMNXESjF_VGpBj_XZiZwE5FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:4cloaS6qzvL24rQpwdSwVrs2wGwAkFyuyzj1sLIUqswT5zVQoV9d3A>
    <xmx:4cloaQK_cHZX6IGcQ0kqG6KlJWT2TOFRw8DDtWzUNfJA697X6QXfzg>
    <xmx:4cloaccMIE161MAPuoxUC8tVqzJ6fT2mDplXmUF9F-UcPWBgWF19Wg>
    <xmx:4cloaTdEkwrxc4QXV56EZUDWCujJh9ylvKDEhvQaL6_6XE8Lp_srKQ>
    <xmx:4cloaSDhmQJtF05x335fRRf878Lt2mW1Yex94twDIYE2y3m8JBpEcf5b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c1aa52b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:05:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:33 +0100
Subject: [PATCH 04/14] object-file: introduce function to iterate through
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-4-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.52.0.660.gd05f3a8ea5.dirty


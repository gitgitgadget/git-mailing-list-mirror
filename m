Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0017A32D438
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421093; cv=none; b=GguV1zJrQwh4+Vyg7kiGXZTgmTUTeEIwStwYD2TPAOaL1Rcu0FK1pNYUKKgqAf/a1ekIGZhsy1Z6gF43z6rPvBU2YiYJkj+Dq6ejFGG9CsJJtacZCXJIE6T3CquLRhqVTxolrTgYpkFjOmqxMLM3IjGJTRRkxiLG6gflhYxAPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421093; c=relaxed/simple;
	bh=7OH/4wU2rWjQ2+f7UWAViJDcoxU/Xrp8U76g9Dfd4xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVawq2sm0oFjmXzQu7pt4fAdEAcJPVetHFU1dbsAS282DMaThyI9VbBgtaEPeHLjf1iP92q/FIq4zSvPsoEfUiELiGyqv9aTsWk0LwJHqndum+eqCJih+ymEj1NdAGO3UVyO2UwlrGWRhtlnxiWVbQO1tFKHSs9+ao1EdwWg9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ja3fBBDr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mJWluFwC; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ja3fBBDr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mJWluFwC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 174A21D00071;
	Mon, 26 Jan 2026 04:51:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 26 Jan 2026 04:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421090;
	 x=1769507490; bh=Fz4zGMZ6nfVPxJHsDlQTtX3wYYoUEcNwuQXwujOfeiM=; b=
	Ja3fBBDrFt8E71BLkPyh81qE4/9QxpYFFQOMpGLXWOHqs/swHkisOGw98ttKvMcp
	65oUNtlh/hHlCsmvLrwmNVpT6Y9AiZ/RJfudLfI8R/e5+p3z3jDYCmwDs+NkahIo
	Oz6fz5RQfXWggTzltV43GZh9avdb4HurSyqMSIiSM1kgpZs4ykw9b0LDAxo+GKVI
	vMhtZph1UvQ8FS0vMmesUXjxr2xnLWB6/J4vRl15xeQBR+QHaZC4POLmcWqsQOq2
	/V9WTMU0e7FUA7AJn5bCAWtGN8a4vNXQX+BBGEdj8ggLm28dh3mBmcEoMMD4rVfK
	OcTxK7e2tCv5oxzZPuP/vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421090; x=
	1769507490; bh=Fz4zGMZ6nfVPxJHsDlQTtX3wYYoUEcNwuQXwujOfeiM=; b=m
	JWluFwCxGbii9600FU9R6GXmTl2fD+195hgM4VeRoHKGX6HTbjqSd2FTDOz5rRi7
	qz46WHeDXO0NYu+ZuZGMq7+o3R9wkbJeYBfWbA4HVQ1/SkyiJL16BeCZRltylnxm
	Ud0JdRNEZeA1oHg5C3500rk3obeXVaDTjxQq+qBs0JwaYW0yqJnvePuOHGKdiZqP
	FcRApoG4nXFTNi8rBmDp4R8L7RIT9BF8C7yAlzjSKTxb91tHcM9EqxvyXtRw1yr+
	dF8BvA8dYlqk6P2VIfgavTV14f8Y0/2eQ3v3HBLYmFxqfGx+7OyegM08m+7APozA
	lj7B0t1fIJ4p7L/Fy49sQ==
X-ME-Sender: <xms:Ijl3acM1H18CnEC4L311gkeu3KxoTFp2heHRzOIbiUziPoUwd7QdGQ>
    <xme:Ijl3aZ_WiZfWNDGDjJgLfB78Pp7UrxCz0bLxPvX_FmATDlbaS7EyMQ3DgtNGILrHl
    KnrWeYpe_1Oex_NVc-bIarMM0BhrItbF5lewyR5UnRhTEa5SLNkbag>
X-ME-Received: <xmr:Ijl3aYRJAYeD_hNjYvu68ZWeqkB7qOVr2VVuO1lMFS5i87KS8dAYs_uyNNhS3VFgouLsYbPZsAt_ieNJq99dQy46BVnStrKjgqSTuzRVJrnTtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ijl3aTnzaLp9KCa-GnWkjzU2ZB923ipd68ErjNy139bgG2hzEJ9yLg>
    <xmx:Ijl3aQT7Af275Pn9i5AOJeeDUPcJUtBxVdmixyUivq5CuSg_BkD9yQ>
    <xmx:Ijl3aZPGo686ZRQe-oP8HpaDC_IL6odia2M8dPDBsqCtpSdZrx_QSQ>
    <xmx:Ijl3aRWykv7Hn89JPfHRstTKCuucgHWkWBtUD2G03y_cloF6_UWyYQ>
    <xmx:Ijl3abz8iXCHfbmi0dK-qSnZSZ9t0BK3rywGgrYQm-87VVTkqEm9h2nP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 753a42e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:19 +0100
Subject: [PATCH v4 03/14] object-file: extract function to read object info
 from path
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-3-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Extract a new function that allows us to read object info for a specific
loose object via a user-supplied path. This function will be used in a
subsequent commit.

Note that this also allows us to drop `stat_loose_object()`, which is
a simple wrapper around `odb_loose_path()` plus lstat(3p).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/object-file.c b/object-file.c
index 8fa461dd59..a651129426 100644
--- a/object-file.c
+++ b/object-file.c
@@ -165,30 +165,13 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 }
 
 /*
- * Find "oid" as a loose object in given source.
- * Returns 0 on success, negative on failure.
+ * Find "oid" as a loose object in given source, open the object and return its
+ * file descriptor. Returns the file descriptor on success, negative on failure.
  *
  * The "path" out-parameter will give the path of the object we found (if any).
  * Note that it may point to static storage and is only valid until another
  * call to stat_loose_object().
  */
-static int stat_loose_object(struct odb_source_loose *loose,
-			     const struct object_id *oid,
-			     struct stat *st, const char **path)
-{
-	static struct strbuf buf = STRBUF_INIT;
-
-	*path = odb_loose_path(loose->source, &buf, oid);
-	if (!lstat(*path, st))
-		return 0;
-
-	return -1;
-}
-
-/*
- * Like stat_loose_object(), but actually open the object and return the
- * descriptor. See the caveats on the "path" parameter above.
- */
 static int open_loose_object(struct odb_source_loose *loose,
 			     const struct object_id *oid, const char **path)
 {
@@ -412,7 +395,8 @@ static int parse_loose_header(const char *hdr, struct object_info *oi)
 	return 0;
 }
 
-int odb_source_loose_read_object_info(struct odb_source *source,
+static int read_object_info_from_path(struct odb_source *source,
+				      const char *path,
 				      const struct object_id *oid,
 				      struct object_info *oi,
 				      unsigned flags)
@@ -420,7 +404,6 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 	int ret;
 	int fd;
 	unsigned long mapsize;
-	const char *path;
 	void *map = NULL;
 	git_zstream stream, *stream_to_end = NULL;
 	char hdr[MAX_HEADER_LEN];
@@ -443,7 +426,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 			goto out;
 		}
 
-		if (stat_loose_object(source->loose, oid, &st, &path) < 0) {
+		if (lstat(path, &st) < 0) {
 			ret = -1;
 			goto out;
 		}
@@ -455,7 +438,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 		goto out;
 	}
 
-	fd = open_loose_object(source->loose, oid, &path);
+	fd = git_open(path);
 	if (fd < 0) {
 		if (errno != ENOENT)
 			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
@@ -534,6 +517,16 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 	return ret;
 }
 
+int odb_source_loose_read_object_info(struct odb_source *source,
+				      const struct object_id *oid,
+				      struct object_info *oi,
+				      unsigned flags)
+{
+	static struct strbuf buf = STRBUF_INIT;
+	odb_loose_path(source, &buf, oid);
+	return read_object_info_from_path(source, buf.buf, oid, oi, flags);
+}
+
 static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
 			     const void *buf, unsigned long len,
 			     struct object_id *oid,

-- 
2.53.0.rc1.267.g6e3a78c723.dirty


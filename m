Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120530EF6C
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208462; cv=none; b=Dd0oZKOPMwNvzfAPQXHL1LCX3inuMViNK+/rEXP86v5BDO7QhXE7OESS8cl7DnTjOQxfJY47hJRyIQ16Jxoz/ekoUmA8zdGRcSE+dazLHWJnZEt8NoA4La4AL0pDHYswcqBuhda90dJg9ifAVfXQAK13Cbl1XfPhb6OmTqjKVeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208462; c=relaxed/simple;
	bh=G16mc2cj/bH5E2S6cyV7Hnp3bbgM+Yg6jEdNQHkczZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6KaidODl2wm77OnrKY+RFM0cDsnqr77KQRglfeaUtyGI83qvemOUrqAxZBYWMv0v3f/Q1xV58h9+lE7FWYjdJG+RiqFzS8zqaeTt8xaytf8QWxEkr2p5i4UXBH0h6DWBBloy2d2q4lKK01Uzvj+OttsavdaB18mVQOhl5GlO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A+VlEfjD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h+DMV02m; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A+VlEfjD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h+DMV02m"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC0507A00B2;
	Mon, 12 Jan 2026 04:00:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 12 Jan 2026 04:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208459;
	 x=1768294859; bh=eyK9Z10dMZO31/uetrS5/G8eS2Zvn1AUOHS0UYs5XtM=; b=
	A+VlEfjDAedVnLXBPhdPcOPeUEUlBSEXobgtTbe9nZy7sU+AczSCWQEEheAh4bQ6
	ckTVUNOrtBjO6aee1+HfJLKDQ+cwBjCT0r8N2cIPWuoupPq3VPUrOqqDmXj6n3xM
	yPpTVPiVasXK2DA4+Bv7pJOMAtMEdwkBWux466op0gsYCznteE4QysGBJpNjTq7p
	CXNb2SPDR8Z9/L6d992IWL/cceSLB0h2fSSP8JfbdgYR8IKc26FC9B+175iC1XQq
	dpgR/Lj9x7RxXmipOwNLonn1cH/6i8uh5rSuTUMbxQ8njzh7aAONokq2P/SCqWvp
	koCyGhvrwF7VyutpSPjNrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208459; x=
	1768294859; bh=eyK9Z10dMZO31/uetrS5/G8eS2Zvn1AUOHS0UYs5XtM=; b=h
	+DMV02mUd+fH4sKCY85vFOPI0gR/GQ+SqAvRi4islBJaZ9jHdiblBjLmLasailkU
	pYOx0iIH0yo2NaWQ9V2OFCAfBA+8j9iryz87Zl5z4tTcwzexZJo/Og2DikEMu6lO
	nHltn0G3UnofTy3ZQZfwdZY6tjPczyJOZgybXW4KHjAlv30fAZaShNtZET27piNc
	axKqXc8PjyCydp9uCqnVuJHLE8vuREDgXQPZmOkX03VMGwOKNPyS1uaeHqFPTUuL
	tNoxF4a0yZZTn7bb/9O2dIMPqbE3jKkgw+YLnosEtIJX0SZCCvIFVq0V0QBqCom7
	XQRKhlk3PZYR3ESPSYYLQ==
X-ME-Sender: <xms:S7hkaX5Op0zeYcBcPDxfDmdQSdOsl9qQZabX6x8KDH1H6pHKGU3sOA>
    <xme:S7hkaQnhWotc4DaUDDpfrL7-fhVShAzyKUWZ9_YL89ZEr_brboYpNgie3JWrPlb0V
    bv4QvrCAML5aFDs6H0hAgHL6Qt4Z6KLJUpJAINIzDeZFEKzeK5Lcg>
X-ME-Received: <xmr:S7hkaYRB74ZtVThurt2yiEu80IzRo2LxmpjuD-lw6i77sEN6mP6kX9Gxt2KtZ-GwxCxM6EA1vwMyB9fCD8JqGiY1A7_bC0wg1eTnkyzM-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:S7hkafHsWCqA7wnk3w2-gOgk9iHx5EtGX3CMJLhE8KyIFOabHmy0OQ>
    <xmx:S7hkadE3X798MQB0fVn3JYqzIpeyJBNcjVb6u5jmkU18FKF2JCc3QQ>
    <xmx:S7hkadSojEl1XtqEQaZ0aZm64pPTUI0DDuk90WbWaPuqGCGcWUqWvA>
    <xmx:S7hkaeLQCjok0zToJUkgPXYtrcqLWkYVZSG1swvI9AXB9WYWIQYACQ>
    <xmx:S7hkaTYKo1Rf-d27dFBYQkD6KdkKe1sFsxOHovq2fYpHDozDOy_KIrws>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:00:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4475d42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:00:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:00:41 +0100
Subject: [PATCH v5 1/7] object-file: always set OI_LOOSE when reading
 object info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-b4-pks-odb-read-object-info-improvements-v5-1-9a6124e95bf2@pks.im>
References: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
In-Reply-To: <20260112-b4-pks-odb-read-object-info-improvements-v5-0-9a6124e95bf2@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

There are some early returns in `odb_source_loose_read_object_info()`
in cases where we don't have to open the loose object. These return
paths do not set `struct object_info::whence` to `OI_LOOSE` though, so
it becomes impossible for the caller to tell the format of such an
object.

The root cause of this really is that we have so many different return
paths in the function. As a consequence, it's harder than necessary to
make sure that all successful exit paths sot up the `whence` field as
expected.

Address this by refactoring the function to have a single exit path.
Like this, we can trivially set up the `whence` field when we exit
successfully from the function.

Note that we also:

  - Rename `status` to `ret` to match our usual coding style, but also
    to show that the old `status` variable is now always getting the
    expected value. Furthermore, the value is not initialized anymore,
    which has the consequence that most compilers will warn for exit
    paths where we forgot to set it.

  - Move the setup of scratch pointers closer to `parse_loose_header()`
    to show where it's needed.

  - Guard a couple of variables on cleanup so that they only get
    released in case they have been set up.

  - Reset `oi->delta_base_oid` towards the end of the function, together
    with all the other object info pointers.

Overall, all these changes result in a diff that is somewhat hard to
read. But the end result is significantly easier to read and reason
about, so I'd argue this one-time churn is worth it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 115 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 44 deletions(-)

diff --git a/object-file.c b/object-file.c
index 6280e42f34..e7e4c3348f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -416,19 +416,16 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
 				      struct object_info *oi, int flags)
 {
-	int status = 0;
+	int ret;
 	int fd;
 	unsigned long mapsize;
 	const char *path;
-	void *map;
-	git_zstream stream;
+	void *map = NULL;
+	git_zstream stream, *stream_to_end = NULL;
 	char hdr[MAX_HEADER_LEN];
 	unsigned long size_scratch;
 	enum object_type type_scratch;
 
-	if (oi && oi->delta_base_oid)
-		oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
-
 	/*
 	 * If we don't care about type or size, then we don't
 	 * need to look inside the object at all. Note that we
@@ -439,71 +436,101 @@ int odb_source_loose_read_object_info(struct odb_source *source,
 	 */
 	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
 		struct stat st;
-		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK))
-			return quick_has_loose(source->loose, oid) ? 0 : -1;
-		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
-			return -1;
+
+		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK)) {
+			ret = quick_has_loose(source->loose, oid) ? 0 : -1;
+			goto out;
+		}
+
+		if (stat_loose_object(source->loose, oid, &st, &path) < 0) {
+			ret = -1;
+			goto out;
+		}
+
 		if (oi && oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
-		return 0;
+
+		ret = 0;
+		goto out;
 	}
 
 	fd = open_loose_object(source->loose, oid, &path);
 	if (fd < 0) {
 		if (errno != ENOENT)
 			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
-		return -1;
+		ret = -1;
+		goto out;
 	}
-	map = map_fd(fd, path, &mapsize);
-	if (!map)
-		return -1;
 
-	if (!oi->sizep)
-		oi->sizep = &size_scratch;
-	if (!oi->typep)
-		oi->typep = &type_scratch;
+	map = map_fd(fd, path, &mapsize);
+	if (!map) {
+		ret = -1;
+		goto out;
+	}
 
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
 
+	stream_to_end = &stream;
+
 	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr))) {
 	case ULHR_OK:
-		if (parse_loose_header(hdr, oi) < 0)
-			status = error(_("unable to parse %s header"), oid_to_hex(oid));
-		else if (*oi->typep < 0)
+		if (!oi->sizep)
+			oi->sizep = &size_scratch;
+		if (!oi->typep)
+			oi->typep = &type_scratch;
+
+		if (parse_loose_header(hdr, oi) < 0) {
+			ret = error(_("unable to parse %s header"), oid_to_hex(oid));
+			goto corrupt;
+		}
+
+		if (*oi->typep < 0)
 			die(_("invalid object type"));
 
-		if (!oi->contentp)
-			break;
-		*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
-		if (*oi->contentp)
-			goto cleanup;
+		if (oi->contentp) {
+			*oi->contentp = unpack_loose_rest(&stream, hdr, *oi->sizep, oid);
+			if (!*oi->contentp) {
+				ret = -1;
+				goto corrupt;
+			}
+		}
 
-		status = -1;
 		break;
 	case ULHR_BAD:
-		status = error(_("unable to unpack %s header"),
-			       oid_to_hex(oid));
-		break;
+		ret = error(_("unable to unpack %s header"),
+			    oid_to_hex(oid));
+		goto corrupt;
 	case ULHR_TOO_LONG:
-		status = error(_("header for %s too long, exceeds %d bytes"),
-			       oid_to_hex(oid), MAX_HEADER_LEN);
-		break;
+		ret = error(_("header for %s too long, exceeds %d bytes"),
+			    oid_to_hex(oid), MAX_HEADER_LEN);
+		goto corrupt;
 	}
 
-	if (status && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
+	ret = 0;
+
+corrupt:
+	if (ret && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(oid), path);
 
-cleanup:
-	git_inflate_end(&stream);
-	munmap(map, mapsize);
-	if (oi->sizep == &size_scratch)
-		oi->sizep = NULL;
-	if (oi->typep == &type_scratch)
-		oi->typep = NULL;
-	oi->whence = OI_LOOSE;
-	return status;
+out:
+	if (stream_to_end)
+		git_inflate_end(stream_to_end);
+	if (map)
+		munmap(map, mapsize);
+	if (oi) {
+		if (oi->sizep == &size_scratch)
+			oi->sizep = NULL;
+		if (oi->typep == &type_scratch)
+			oi->typep = NULL;
+		if (oi->delta_base_oid)
+			oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
+		if (!ret)
+			oi->whence = OI_LOOSE;
+	}
+
+	return ret;
 }
 
 static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,

-- 
2.52.0.590.g1f87b77810.dirty


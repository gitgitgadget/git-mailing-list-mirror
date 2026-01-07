Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D334939FCE
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791300; cv=none; b=i4OILeRlDuxUBATBKuRPrOKsXM2y1njGYN0gw06CkFPSqbsZv0qK0DoWKaV/d+L9pet7JhjZ3La6oNX6xmOIdiMAXiiyWIOvlN+rJzYJa7MqJYEYx+7e4BAQ0JVPI1t0cmNmcLGmwI9XE3/gt+/FwBmcUEvBReOgicpMmnQTrFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791300; c=relaxed/simple;
	bh=XPvVXejDeYUjMNcRIKrxiUab7PNRMN7cVXfNgcLCJ1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YPCvjEbN4VOF4PpRlD6vXCEG3l5ftwHrojNbW4nLeuIRzsanX4c8LTedBpzcJevAD5+bxdz9R8Qt6cRUTz9RDsN+lyhfGGXfaZsbT7/wJEHspmk/OyC+lAVPpun7FKQcGNOgYRVhF6llQ/B8p78xgWDzJY14D7i+JfinokbZJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HkrP9UGX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GPCYzWLC; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HkrP9UGX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GPCYzWLC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C1ED1400103;
	Wed,  7 Jan 2026 08:08:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 07 Jan 2026 08:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767791297;
	 x=1767877697; bh=m/o/yG3wBf++ycj1y8cxqes6S6tpKrsWdT0d8iD0+nc=; b=
	HkrP9UGXrpBo+PNpyk9s9KCM0A4R/LXxtWFEsX2TlGSuiuVLQa2u1wwTWqtUldFC
	P2pmBmZ9h6qbadlZBAC6CVbquVQFee0Oo9DtSLc1B1aEd7XszNaO64Oz9qF+y1ea
	ZivFIaFDJAiuXTigi5DPpE44KwSGbvbyWsLGPFkLcrM+sltWAV2VJ2nM1e3TVuJv
	wKl7Xfb/9vU7pOMOk4XZHgFtvLjiTjo7bYRSFfHo/1tFBn7n+nK9UBwR7NPrX6kP
	g25YJLSHrQw7QXkGaleoILyyyWue4/T2pSwtx3bCOXl9z7Ke1NeeiVddXfj5WNjT
	xaukHEUsZfJATlN+1zFPxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767791297; x=
	1767877697; bh=m/o/yG3wBf++ycj1y8cxqes6S6tpKrsWdT0d8iD0+nc=; b=G
	PCYzWLCpAuLfL5B/QmmXUUB3a5WahX9IZTLlCMzZF7m0S88KFDrHOMDHsYsqOc8K
	YlpEzbdnHdj0gRriIse3PDe6skDHyW+YCU5b6q9IgqrC5RQH2E3iJHdK1IV37VUZ
	uvY71wG5YFhts3N73zLr02wUGreOG8RrDgsb9Gj7syHV8Jnx3jdQ7qZjf782Dj1M
	dyZhGaCGLHXcWbs9n9wds3KJXLGo9xzKIJabP+K0uh9NaYhSYwi61YiZSqOU5RMc
	BoBtGAWGmEPDTDh15noWep6T7mxIlNPW37D2xnnQ1JFPeQssk+X06cVYkP/F23Iu
	sOaf4hBtONfJrxK7/IqRQ==
X-ME-Sender: <xms:wFpeaStQDtTUeoW2rQSfqQRD-UGahJ2PovNOB-QItmD14RFGXhJprg>
    <xme:wFpeabIFNE9HVflqNJHAZaFTKs_wMb2kyogW0W7mEgxQ8tQujO2Tfh_xtKbAJrWrC
    wdfg9blMvpEWqZNAfA9RrP0T23wwainnKrvHOKvL0gHjjzxxZCqvA>
X-ME-Received: <xmr:wFpeaXmzH1selb_KHWBjYfZZFKqleCqIfocXEtbuACsjkc4_qSqpLfHaa-ATNdXCONrlaxhdwXJvR96P3R_3GwGBsdrp9NDYBSH_ppwq8WU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wFpeaUKQN42zLqqgxwg9oR1Vnyyodc5LjLoyMFtsb7u4QAndhp322g>
    <xmx:wFpeaU6HkatLpmLKoNlLDt15YdNbl-VweWtwwZiYErG7Fmi0XaaFXw>
    <xmx:wFpeaQ3PnrvXLgDMEwf_VhbrWpECeNBl0yI12jiZ4Si4z9H5z29aIw>
    <xmx:wFpeaSdNqMQETccgNM3bIvAyWbcJZBZ84XB20v7i9AvjjvGDKmeDKg>
    <xmx:wVpeaUvxULI8h3Rw6SB-YbhSuJPuE4Z5oZDwOlqv6vSY19PX0tYkTNDT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 08:08:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cef97059 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 13:08:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 14:08:00 +0100
Subject: [PATCH v4 1/7] object-file: always set OI_LOOSE when reading
 object info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-odb-read-object-info-improvements-v4-1-b5d55c47082a@pks.im>
References: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
In-Reply-To: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
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
2.52.0.542.g9473a8513b.dirty


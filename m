Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC69A4779B8
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922779; cv=none; b=WknC4HbcbRY+/74/w74YRi9aPFb0SjE4t6y357ijPR0eF1UgYsld66GDNsGWr4ihhY9mARYaTuYMcb8PQNLk22/za/2JuUPDar7Mwwvi+yrd52meluLuH63RonSV8AjNnVCoseCSgim44FT3vya7XRlyIycOG1nYg1mlwOAiqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922779; c=relaxed/simple;
	bh=3p9y8fSSSh4wLD7Hiw+rDuiEqIzCFy7vr9WbYVPZ0U4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rlz+5Fzsuv8NLJz2L2m2Oi+LuR31z7rtNiQ4Df6/MuyUnAP53TDc6A3PTCmff4lmXRL9RFom4nAcSKJSv6i1N/VaULYlQhAg9HvmFSHDmhm/cItZQA+CMZadcdDY+YNxj6zjsZ4S6J0k98hcL32tmAqsn+B4kfz6x8oiQjW5e8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HJ6ZJd8s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MbqXbCVl; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HJ6ZJd8s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MbqXbCVl"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id D8A181D000BB;
	Tue, 20 Jan 2026 10:26:15 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 20 Jan 2026 10:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922775;
	 x=1769009175; bh=00QjtiafPB0P+g2SbmXeX2To62amDTsUo8HuK7SiAVo=; b=
	HJ6ZJd8shOQU54gzuVw2FVIXU5Feqw0qBc8aK5C5Vj0zBu9jdQSJoDTO9zSc9wap
	jCFA3QQ6UtwvUFE97605xFGvPHCgagG95VJ4e2ZLi9/Y2iOolUtNNMZ466TXY2K9
	sBbClXu+R0isKNxndHI4/CF535CFwwNuDN4rwXgTr9J7copCrTlbudr3Uh2O8Hkn
	qn771XvhyG2+cyN9EaRLqtoxc9t/owbxp3dIsSFWS0D62awnvVqVrEAKlWkh73fi
	pxy4Yc6/Fs32aAAxw0avcJkBkdyC7mTI8My7rr9qWB2no+4wU/tWckiQqCcw46vG
	2WScp2SsKRZYbsOgJdEM8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922775; x=
	1769009175; bh=00QjtiafPB0P+g2SbmXeX2To62amDTsUo8HuK7SiAVo=; b=M
	bqXbCVlyi9hn0DYAqsqCoGvEY4AvS6Jc+39z5MxRtQgzkyFOgOTBtODDKTW2rp9Y
	ppQZwrYNh8fr3YM+ZlJycJ5FWTAMspViTzfWRIaKXHw0fVIOCxebteNvSrkDI/An
	2ihGiL68A8a0e5pjh5Q0GlernvdfvDr1KkLWxXte8dF4pp+Pn9m/hNrtLVW3YTMG
	Q6QQNgdLX/JbwWiu3eZKmVo4EM/wB533ribEbnApZQSJZKqaI4oJupSjHjfLZwFQ
	gi/4ce+P9qKdI+oHkEld7yYJd5f4KerdZBnB0iNUiBe9BiPWiL34hIQ/Z5Z4nGNn
	rxOOvOfgiahHW+kdeol5A==
X-ME-Sender: <xms:l55vaVDvPDxhQgAOh_w7zXnZbB6CJjU2Q21clN5HobHskdcpWrF1Lg>
    <xme:l55vaaiF4sUP6HAc7NrED4rgF75-T8OQ1WcyyuFWFOcQWuacqXKtntohJsUkf5fwR
    hIV5lJbuvpUCZGqnprkCSvArmR5AsiY-bDSnSGhQWdoqOOddvlnQg>
X-ME-Received: <xmr:l55vaVnmURrMhTYjeOWlzRMZ6as1n3FOfpxh4r2CsEVtOEjMAhoSSpvaGq0l6Oq04066-U6xE8xDPen0ZXTeHbpvGHvVMVJ9d48XGoBThQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:l55vaeoX_yoW6GLFfJy2jcBFaDIKrZYyUZbYQh5kofoqlTqJ3ZXtwg>
    <xmx:l55vaWGgEiMiw5oEadW-iiilpBek1GCIJlydj3tTqqP-Y9Z4wILzYQ>
    <xmx:l55vaSy9B_FMvjcukFAinzwnjKfrHlkwUuYwnzr-DmGVIf4rm_WgOA>
    <xmx:l55vaTonvKjD7RCmM5rC7Zg4e-ZjGjG2l-yzbFxjfPWPwhT_YRkbTQ>
    <xmx:l55vadEV-uclDEgc6J6ulT-UO1zLFB0HDxf8GH47zqlxidOTyANyp_Dm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0cb2533 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:25:59 +0100
Subject: [PATCH v2 03/14] object-file: extract function to read object info
 from path
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-3-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
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
2.53.0.rc0.250.g0ac79233d6.dirty


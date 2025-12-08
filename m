Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C423C2D7DC7
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181080; cv=none; b=WlnSWkEUR9bJfTHlMW75C83gxlz7QgJY7Msw7q+Pt8+6JZUMcydgYviEFdXk9hVKJwdPFhzh4s2Ho9dJ5CK12rVto0L/AWofZpXvRAkEntwAmJ1g/n8HwhHTZ15DyypFPfrPWNEdYP4h42Bkghh6qfyHhHD8zl0FGvfj0ugUsIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181080; c=relaxed/simple;
	bh=NFQ8+cWKEy8u1wHYreUFOrs2SjO1Hd3Crf1Fzci8FCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDb0l/tSquduHBVThlxJ7fOOT1nx8XpXHZLywdFNWUBN0H4wfV+U6IpKSrl2hIyd5X2O8QfhhQIuNplyGKdtyh2qe1lYEkvf817ZMqGJe/Tx5W4bJsJx0NDmbpLuymd7+p90kd+FEA5g2KmmG7sJ2pNbBOruEgR890mSnuoc8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CLpY0sjs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lqFf+wAc; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CLpY0sjs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lqFf+wAc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E60EA1D001E3
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 03:04:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 08 Dec 2025 03:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765181077;
	 x=1765267477; bh=3XDAA8cnGfczfWw/x2yq+PtpzDMhTTL1bsKVn/BGyj4=; b=
	CLpY0sjsMh2lin+/AtMp7eoJZzjPSnQ+DfPwx0zABFa6bI+en3qhUTqZtmuPr/58
	qq8/WcCtbF2kI1/r9C1VMYNrjqzqhaqR6L2eNmveWd7ZWEmmDu052ljLpZOJMG+l
	QvzhWZ8lB27X1UBbnEg82m+JG/x07jMF7ozEcyCV2FwtM4wWqwBlhsQA4qra82am
	5AgN5dApTxDXgH9k+yXCUqyuivaM9QJaWxdZzlV98AYllIT+mt/65Uro1Hu/haeo
	WZumr60ZqJPHzgnFTZhjEGjF50kuN9h8+AhKISgmnAsyZGL8jpi3YoelwL2m4JTT
	cle6GFGRI2Q0fIhI9JFGEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765181077; x=
	1765267477; bh=3XDAA8cnGfczfWw/x2yq+PtpzDMhTTL1bsKVn/BGyj4=; b=l
	qFf+wAcnJ3LfpGKJBM40Zy+2qnH2lfsGmDi8iTj7DWluWuuN7oedcWszfCzY46vn
	or1DhfmgBsynTXB/UcK3lMP83eikuUQ/gqW7wFOUS4jtoEr62KSrYEk2+v7oaM09
	1VMhcaLPTYvhw0K+UQhnRR4DKbmk+TtO3ubifOyeOVh7AE8jPNytzNG96vkE9lA9
	r/3bi68Ln5LTWf0PrccoO//lewQuXEavTWTIM+xlD3TLJiTFgcqppJ+0bIh41/3A
	yTGH6nK3mPCzX7WVKHGBNbnaZfnf9D9CdnoJmZGLnTVJfdByA+kfxMLYDu9URjj/
	/ZxmRThTcnRbsP0UExIMw==
X-ME-Sender: <xms:lYY2ad6NReNB-meFet348j-HwQejFFHEHbhRSaiul29JBKusiV5ZoQ>
    <xme:lYY2aR3wWjXu2RacNFJkbWrkch1_kBL8NXB7vewRsstwZxZ_qvPgsYqyIm8Y4zIpW
    NWsgc47bdAWV0HRzT3_0NkI1Yy6Blf448mFp_OWdvJh29x-R96m>
X-ME-Received: <xmr:lYY2aaG1UGiD_gt5OWGsSLG6t4cD--x3iDVdEJDrjZEvc_WqNqnv-PVRH4sTo0uOZ_ZVvqm-TlnBLEcl_7ZyDUTnbOuRGUMSvDb0vALi1WY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:lYY2abR8bWQPYSy9SJPkrbuuemeYzYrbD3lOJY5jeIkeqdD2RxT7mw>
    <xmx:lYY2aRDGvM_Cbi_ZOkFyvU_mzIXkkgV3obGjM8zLapVV0a-g-Qjn1w>
    <xmx:lYY2ab2hvUXfHdn-GcvH27voLiAdKa2jUQ9F6moK_oQM5ggGY53x6Q>
    <xmx:lYY2afW0SCBSNBA3u3Rl7zEk9foteP6cPGBZSUphyr6GX-3OXjA5Ww>
    <xmx:lYY2aSZhSr5RDckdYqPoInhqOlwTjmvN_X7iou2IWckXtFDoR3vbUzTy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 8 Dec 2025 03:04:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 183df24a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 8 Dec 2025 08:04:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Dec 2025 09:04:19 +0100
Subject: [PATCH 2/8] odb: resolve relative alternative paths when parsing
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-b4-pks-odb-alternates-via-source-v1-2-e7ebb8b18c03@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Parsing alternates and resolving potential relative paths is currently
handled in two separate steps. This has the effect that the logic to
retrieve alternates is not entirely self-contained. We want it to be
just that though so that we can eventually move the logic to list
alternates into the `struct odb_source`.

Move the logic to resolve relative alternative paths into
`parse_alternates()`. Besides bringing us a step closer towards the
above goal, it also neatly separates concerns of generating the list of
alternatives and linking them into the object database.

Note that we ignore any errors when the relative path cannot be
resolved. This isn't really a change in behaviour though: if the path
cannot be resolved to a directory then `alt_odb_usable()` still knows to
bail out.

While at it, rename the function to `odb_add_source()` to more clearly
indicate what its intent is and to align it with modern terminology.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 64 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/odb.c b/odb.c
index 9785f62cb6..3ffeece567 100644
--- a/odb.c
+++ b/odb.c
@@ -159,44 +159,21 @@ static struct odb_source *odb_source_new(struct object_database *odb,
 	return source;
 }
 
-static struct odb_source *link_alt_odb_entry(struct object_database *odb,
-					     const char *dir,
-					     const char *relative_base,
-					     int depth)
+static struct odb_source *odb_add_source(struct object_database *odb,
+					 const char *source,
+					 int depth)
 {
 	struct odb_source *alternate = NULL;
-	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
 	int ret;
 
-	if (!is_absolute_path(dir) && relative_base) {
-		strbuf_realpath(&pathbuf, relative_base, 1);
-		strbuf_addch(&pathbuf, '/');
-	}
-	strbuf_addstr(&pathbuf, dir);
-
-	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
-		error(_("unable to normalize alternate object path: %s"),
-		      pathbuf.buf);
-		goto error;
-	}
-	strbuf_swap(&pathbuf, &tmp);
-
-	/*
-	 * The trailing slash after the directory name is given by
-	 * this function at the end. Remove duplicates.
-	 */
-	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
-		strbuf_setlen(&pathbuf, pathbuf.len - 1);
-
-	strbuf_reset(&tmp);
 	strbuf_realpath(&tmp, odb->sources->path, 1);
 
-	if (!alt_odb_usable(odb, pathbuf.buf, tmp.buf))
+	if (!alt_odb_usable(odb, source, tmp.buf))
 		goto error;
 
-	alternate = odb_source_new(odb, pathbuf.buf, false);
+	alternate = odb_source_new(odb, source, false);
 
 	/* add the alternate entry */
 	*odb->sources_tail = alternate;
@@ -212,20 +189,22 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
 
  error:
 	strbuf_release(&tmp);
-	strbuf_release(&pathbuf);
 	return alternate;
 }
 
 static void parse_alternates(const char *string,
 			     int sep,
+			     const char *relative_base,
 			     struct strvec *out)
 {
+	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 
 	while (*string) {
 		const char *end;
 
 		strbuf_reset(&buf);
+		strbuf_reset(&pathbuf);
 
 		if (*string == '#') {
 			/* comment; consume up to next separator */
@@ -250,9 +229,30 @@ static void parse_alternates(const char *string,
 		if (!buf.len)
 			continue;
 
+		if (!is_absolute_path(buf.buf) && relative_base) {
+			strbuf_realpath(&pathbuf, relative_base, 1);
+			strbuf_addch(&pathbuf, '/');
+		}
+		strbuf_addbuf(&pathbuf, &buf);
+
+		strbuf_reset(&buf);
+		if (!strbuf_realpath(&buf, pathbuf.buf, 0)) {
+			error(_("unable to normalize alternate object path: %s"),
+			      pathbuf.buf);
+			continue;
+		}
+
+		/*
+		 * The trailing slash after the directory name is given by
+		 * this function at the end. Remove duplicates.
+		 */
+		while (buf.len && buf.buf[buf.len - 1] == '/')
+			strbuf_setlen(&buf, buf.len - 1);
+
 		strvec_push(out, buf.buf);
 	}
 
+	strbuf_release(&pathbuf);
 	strbuf_release(&buf);
 }
 
@@ -270,10 +270,10 @@ static void link_alt_odb_entries(struct object_database *odb, const char *alt,
 		return;
 	}
 
-	parse_alternates(alt, sep, &alternates);
+	parse_alternates(alt, sep, relative_base, &alternates);
 
 	for (size_t i = 0; i < alternates.nr; i++)
-		link_alt_odb_entry(odb, alternates.v[i], relative_base, depth);
+		odb_add_source(odb, alternates.v[i], depth);
 
 	strvec_clear(&alternates);
 }
@@ -348,7 +348,7 @@ struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 	 * overwritten when they are.
 	 */
 	odb_prepare_alternates(odb);
-	return link_alt_odb_entry(odb, dir, NULL, 0);
+	return odb_add_source(odb, dir, 0);
 }
 
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,

-- 
2.52.0.270.g3f4935d65f.dirty


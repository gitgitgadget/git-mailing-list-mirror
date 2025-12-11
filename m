Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C882F6934
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445424; cv=none; b=GrnOFBAgJbrM6yJTk3Ac50SbFlXUHiR/N7jTOmGEpklpbEmamUlCv0N3J5P4/NBwpT94o6CIw1nvW53wksXTCfZrNXfYVTSJDhrfE73m1rWRwcoJOsmXaGTXF0q/MzqbuO32ZUHxPXe3TvyQQNb2tgsiAC7gzzOQI10DfAKZz6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445424; c=relaxed/simple;
	bh=EfbRzitdVCXzF7Mn0bevioO9l85lD899b6LU2fe6Vl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qntAyB5dmm4bO1tvwwY4x1LHQ/balj2PbEHCPzvWzSWTMJBd6fT7ZP+gvcelUILxdk0wEoevmoNjfZv7Os0VXNqGbpjOioHlSiUNY+ttgHuq7dyuzmJpbPnd43BeWLpesQ2215aNZ5dEDc2x5FoHNzJrr4f8WU8i/SsqZ/L1y/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O5pKwsVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPTl3iOM; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O5pKwsVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPTl3iOM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 251931D0016E;
	Thu, 11 Dec 2025 04:30:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 11 Dec 2025 04:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765445422;
	 x=1765531822; bh=EPsGiMyBCFwCDjV/qYNboAwWEAE19gKS9TI0nsL7IDA=; b=
	O5pKwsVKi7uyQGEfsXZRaYUYYpdKb70JcJ9/oO+eIlTSfUKppBhkFvfnXFLsnzUd
	3+g5q/tYgiSm0kDNUpi47N8BKntJQUQc0JCLxb7AUhlPC0QBYwl6aFX8CfkgnMdn
	DXbKPo1p78SuFPrvG1lEesmclC1dezXzHqE42BaLnjyfWpZkaSxeyTjLR5ht6Ja9
	ALtlMus8nZbkYoXnKv2Bt05zQeWNiQo0NrKqGSiLfCSs6ZrTCGb3jk05IEZu//G8
	DpMNAi8P2o/QuRq9n+zxjJy1EhzblApWgB7UyPtna3J07M+86Y3hhcBNHmhzpBZJ
	IdowoY8+soHNjdqcxeSMsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765445422; x=
	1765531822; bh=EPsGiMyBCFwCDjV/qYNboAwWEAE19gKS9TI0nsL7IDA=; b=X
	PTl3iOMe9rMqMm8o9ME3M6Rqr2DagbAyeh5oqojSxamWniO2i7G3Q8BC890wCy/C
	VAXsAISW6IxFSauPb1kuaCmUvjmbdN17nJ1ErnpIQLa2LW+InBbA7iMWDKF0adNq
	rZ2pBc4NmedIW6XprsMPTKBmt00QySTNoeXWHtBDKRb7rNx34aL7xGbrgbDSh4T3
	yA0J5Xq/nk+RB06xOK3faPKYPuHOSKXVt9JrWEUu8wI1fvSmrttEEoLOpSrtlLGe
	H/7Nlfq6QgrMGLsG+C57SvYbS0/2rG5ZYq3F77+25w2L/0ENeGzjJ+BLoV1XvnP0
	pndpgEJ9Im1rfh7tsbT5w==
X-ME-Sender: <xms:LY86aQ_tsoQlNbmT_V82glyrJPjlQ8pgnU6tBqiwTG6PMlxsBOxBoQ>
    <xme:LY86aQJh0H7LnsKZTiTjKO69IVEqj7ARiDpjNzmnCSGE3lN4GEo2mV7io91zsjTiy
    tXc7Komj2lFGh7sIp3smm786QOfyMKLRwx96Yg56IzScZQIbqXBFQ>
X-ME-Received: <xmr:LY86aTYiN5RbVQPP_lONbfsQ-AJk5s-JQrYbcoInK8FQd87SvoX3JZYz14WDXW3eGRxM4R2NeHCA1GfF5H_Kv-gvuSn0VJEkooWBkWJFmEGa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrh
    druggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:LY86aaKYyOqKvSKVuXJnbSK7npkuCZib8Q97KijfGcyDjb2FbI4NsQ>
    <xmx:LY86aZAERMynCFPw6fzvnJ6uMoXLYv3ZNfNwpR_uuirqqp5R2GwuHQ>
    <xmx:LY86aXrSYDQ3HfNKYaopAlB6yMKCZlyfeKsnb2p54n-WaJDa1qqLWw>
    <xmx:LY86achDnozQssPxeWVjLFPO-hgL43vThyAHZtxNuKvMbdn99XOKAQ>
    <xmx:Lo86aWn5Tn3U1HR4l3ilolzkA9LU5P3kgfKoiHyr5bR_8eOBDgYpv0qB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 04:30:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa90855b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 09:30:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Dec 2025 10:30:11 +0100
Subject: [PATCH v3 2/8] odb: resolve relative alternative paths when
 parsing
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-b4-pks-odb-alternates-via-source-v3-2-00e3f54d07ba@pks.im>
References: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
In-Reply-To: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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

While at it, rename the function to `odb_add_alternate_recursively()` to
more clearly indicate what its intent is and to align it with modern
terminology.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 64 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/odb.c b/odb.c
index 9785f62cb6..699bdbffd1 100644
--- a/odb.c
+++ b/odb.c
@@ -159,44 +159,21 @@ static struct odb_source *odb_source_new(struct object_database *odb,
 	return source;
 }
 
-static struct odb_source *link_alt_odb_entry(struct object_database *odb,
-					     const char *dir,
-					     const char *relative_base,
-					     int depth)
+static struct odb_source *odb_add_alternate_recursively(struct object_database *odb,
+							const char *source,
+							int depth)
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
+		odb_add_alternate_recursively(odb, alternates.v[i], depth);
 
 	strvec_clear(&alternates);
 }
@@ -348,7 +348,7 @@ struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 	 * overwritten when they are.
 	 */
 	odb_prepare_alternates(odb);
-	return link_alt_odb_entry(odb, dir, NULL, 0);
+	return odb_add_alternate_recursively(odb, dir, 0);
 }
 
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,

-- 
2.52.0.270.g3f4935d65f.dirty


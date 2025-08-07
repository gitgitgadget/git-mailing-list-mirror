Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8924728E
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554215; cv=none; b=ZTPCoyUTvCSmReAMwUNm/j5/J9hjlqsldOb6UNtIwPN8izTqZZhQaEuQrcD2zsgqktaOTE3l06xQqBrmIrxuzB328z8lUkkBXvGveKnzHGbKeY6H/yA2yvc4jjE+AKXxE+1RCYJvHdDfP+HJQOEOdVcjd/ywvhoMg1Qe0MAL6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554215; c=relaxed/simple;
	bh=Y/2BKnacxWo7IKdKTfDW4HkfiV1Io+WovQvQTFwsmA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2vf7/LHPaBK5qjUo6syUfQGc0X/wcDc8SplSdNaIsF5OtG5PkAHcIVGBj67pMFRGfwL648po6Y/XGKM4zyzM3FKXdSVtCHy+6Mm9MXNHNlNeFnmlp7KeXT8l1F/FQ6ybuVeyIN3AwX38rQlWf987xoZwv5MceHDSAzXgPKDmZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E61h1r54; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nFw6UzED; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E61h1r54";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nFw6UzED"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1B725140013E;
	Thu,  7 Aug 2025 04:10:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 07 Aug 2025 04:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754554212;
	 x=1754640612; bh=sZlFlKFerFHYZ6lN8zvxQm7U+uRYnu4nBzFqSzUu5xA=; b=
	E61h1r54cbSJRPuNz/c4UvDguKtXuG05KusGM1fz2n3e3dotHTy5pFLj26MrhQLc
	ceLM+cKcphk/GEUj7Tfvhb3MYcncdMXcu3PKa0QF4UZ18O4NgRkVIZTIRTllnTg3
	yXVUbm0TFBvT5fLrtFfD06rm/xd0MdfYYAbNTKlaGMv/m1UFKyk8pt1XvwMqYb5w
	lBisbuZRt2uW8XBpdyf0XKlG/lnxcb2+BjgfcIQQWP6wgEnxLFfyp+L1Vg4B5iNu
	kbh89merVDdYz6ROvTEga/PvTuc1Rj0JLSSjElQCN9NoSkrcqAhKxxEAtTJDG5jq
	ctayovMA6mMR9gdKhET4Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754554212; x=
	1754640612; bh=sZlFlKFerFHYZ6lN8zvxQm7U+uRYnu4nBzFqSzUu5xA=; b=n
	Fw6UzEDOgZREXPnBtVEln67WRiX134byXTq0JGjY7jJYWimcj2PPnb/BodiwV5vX
	q0q0dZ1wy/GbWnVITA0+7DEiM7Ttb4rZa7QM7JxwWMre5zYsCR4/yd+ZIQzj0e3V
	0k5yOlgqJxyyXpqIz68pSrpKsor5Wi5R+7psBdlH2vIxbIN53Gh5Va/JGCqQ9YHy
	YJCBUy3U93VRQag07MlmrQoBQDjInEUjceMtBt3HE0T6w553jdl2vopbbmoBOQFh
	9+P66y3kN9/58WnKuV0E1iZVVEGXTIz30zIbhiG9VN4K/0VtdRlyr1bOS684u3a2
	88hPwIFxpQyMqTMQGQ+BA==
X-ME-Sender: <xms:Y1-UaK79vVO3nTBos07xMfoGeP9orcIVQiI2Ecjxxcpl2p2ShxO5_g>
    <xme:Y1-UaHJftU4a9ZJUNgdC6rkWeC0Lzx4aFazf9DA-qEZ2wuvb-SsjfgA3OrU9kF7OS
    87nrHgHyBKiZDD76A>
X-ME-Received: <xmr:Y1-UaC6T3Dhe5iAiJXYgRoZu1PsQhOWMUiI9ckVTZbrUNEQEqdlWo4PWXbwDiyOw-6u8MQZRpOig9M4yiRXxg-tmaOKMbxE0FT0IrjsNfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZF-UaCx6717IDefySBhQF5faJSG-JBCTbzI8SbD6iskKha9inqwWeQ>
    <xmx:ZF-UaOYN3GZm7dzvr1kwmzDtI_d6NRpiIYapS1CcD1uT6_2xilM19w>
    <xmx:ZF-UaMSYCTIo8IRlwRxmSH_je8a5Xjvv1HCwsGSvEq4XMc74pFyyUA>
    <xmx:ZF-UaAzkNB3GNEXQkETkmNfnrj3gP0phUoGEJaNtjF_b8tdqUoYmsA>
    <xmx:ZF-UaP8SB6qii2ZXRLyj6l2eUvUj5_WLUUDFyhdxX_PQfya9CVnFXon5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:10:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf34de43 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:10:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:09:53 +0200
Subject: [PATCH v2 3/9] odb: return newly created in-memory sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-midx-deduplicate-source-info-v2-3-bcffb8fc119c@pks.im>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Callers have no trivial way to obtain the newly created object database
source when adding it to the in-memory list of alternates. While not yet
needed anywhere, a subsequent commit will want to obtain that pointer.

Refactor the function to return the source to make it easily accessible.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 37 +++++++++++++++++++++----------------
 odb.h |  4 ++--
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/odb.c b/odb.c
index 61104b7cb8..7793816f81 100644
--- a/odb.c
+++ b/odb.c
@@ -139,23 +139,22 @@ static void read_info_alternates(struct object_database *odb,
 				 const char *relative_base,
 				 int depth);
 
-static int link_alt_odb_entry(struct object_database *odb,
-			      const struct strbuf *entry,
-			      const char *relative_base,
-			      int depth,
-			      const char *normalized_objdir)
+static struct odb_source *link_alt_odb_entry(struct object_database *odb,
+					     const char *entry,
+					     const char *relative_base,
+					     int depth,
+					     const char *normalized_objdir)
 {
-	struct odb_source *alternate;
+	struct odb_source *alternate = NULL;
 	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
-	int ret = -1;
 
-	if (!is_absolute_path(entry->buf) && relative_base) {
+	if (!is_absolute_path(entry) && relative_base) {
 		strbuf_realpath(&pathbuf, relative_base, 1);
 		strbuf_addch(&pathbuf, '/');
 	}
-	strbuf_addbuf(&pathbuf, entry);
+	strbuf_addstr(&pathbuf, entry);
 
 	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
 		error(_("unable to normalize alternate object path: %s"),
@@ -189,11 +188,11 @@ static int link_alt_odb_entry(struct object_database *odb,
 
 	/* recursively add alternates */
 	read_info_alternates(odb, alternate->path, depth + 1);
-	ret = 0;
+
  error:
 	strbuf_release(&tmp);
 	strbuf_release(&pathbuf);
-	return ret;
+	return alternate;
 }
 
 static const char *parse_alt_odb_entry(const char *string,
@@ -246,7 +245,7 @@ static void link_alt_odb_entries(struct object_database *odb, const char *alt,
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(odb, &entry,
+		link_alt_odb_entry(odb, entry.buf,
 				   relative_base, depth, objdirbuf.buf);
 	}
 	strbuf_release(&entry);
@@ -316,17 +315,23 @@ void odb_add_to_alternates_file(struct object_database *odb,
 	free(alts);
 }
 
-void odb_add_to_alternates_memory(struct object_database *odb,
-				  const char *reference)
+struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
+						const char *reference)
 {
+	struct odb_source *alternate;
+	char *objdir;
+
 	/*
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
 	odb_prepare_alternates(odb);
 
-	link_alt_odb_entries(odb, reference,
-			     '\n', NULL, 0);
+	objdir = real_pathdup(odb->sources->path, 1);
+	alternate = link_alt_odb_entry(odb, reference, NULL, 0, objdir);
+
+	free(objdir);
+	return alternate;
 }
 
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
diff --git a/odb.h b/odb.h
index d085e691f2..aeca9d0a70 100644
--- a/odb.h
+++ b/odb.h
@@ -265,8 +265,8 @@ void odb_add_to_alternates_file(struct object_database *odb,
  * recursive alternates it points to), but do not modify the on-disk alternates
  * file.
  */
-void odb_add_to_alternates_memory(struct object_database *odb,
-				  const char *dir);
+struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
+						const char *dir);
 
 /*
  * Read an object from the database. Returns the object data and assigns object

-- 
2.51.0.rc0.215.g125493bb4a.dirty


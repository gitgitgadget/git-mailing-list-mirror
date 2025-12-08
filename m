Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3365C2D0C82
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181095; cv=none; b=VMW29yUVovqDXoiq4E3RQaGM5e5PE9HGG1J1xESqvaK0RmcHhWb1xNbJl6ioUqmW7Lw2HM22I7/oX3IW6vfJGs5+JSkdHfSpJVqTqxC3ldnW4AjNAwdkFfGkP7wGE8stITdcckEmdHc2wfUcDSJNOpQ207q0U8nT5JLUe20iilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181095; c=relaxed/simple;
	bh=Pd4AZGRpurJtXOPK3ARrRuAhlgYwOcqQwKTk0HlG2wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DTfovqkpkWHPPHNFRmIaDg8+TtCqa3Uw0t4sGQ+tibphiXrSrEjOtCAa2UKMTPRJySaayuFUGD4mS4a7UTs9Kx5P0en/mrCWLsQ9TlVYte01vyVguUvFVS5DPwmwTxuI3hfOO6ZzA85dKd1dcQe+Nuy4Lxw6zHI9ILLTmCIF/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B8QxEvbM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VwKZoPsU; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B8QxEvbM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VwKZoPsU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F16A7A01EE
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 03:04:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Dec 2025 03:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765181093;
	 x=1765267493; bh=nssBSKgtbeCqrwFWhu4aa2vOJjpJevPEzG4VL8e1NnQ=; b=
	B8QxEvbMlfccTA4LRoEsZpmBMYoMhqRQ/ysG45bxQZ2/yt1uwDHbUJkLTuWJ/g6q
	o0fzf4ytcDzKnsbe/diiQjrsiEsqJAj4/fgANdJOjyDDL/dCQUXaXZ3Fm9B9CvQY
	MTnfRjCuc98kH/waxMa5vyg8ZfL7gB7EmV4kG3Ou+Q9vhnewNcN2jwz9Ft+oTUAs
	HtgCxbfEC9OunET1tEDSUSXsd9h+LTeo+A+1jq1EDXsCximxPjXLUxW8H7D22L9H
	49aVcVGPp/awmvQC0TycOOoZ1dC0+RA3PEzgFBsKjtLjVByZYzKk4AfBQXTRLHMC
	cCVwjU/OcFAZ4op5LqMBCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765181093; x=
	1765267493; bh=nssBSKgtbeCqrwFWhu4aa2vOJjpJevPEzG4VL8e1NnQ=; b=V
	wKZoPsU7vXjPxahwsoLEJB2cyM/IjhorrvyN1VnFlK1ltAi357Vy6lF8QhTilUza
	7arAoi9p+wAi4SLOe+vcSZPHAsOMEnXia4uJuGMHG35S045LcOhuozy00n/5qcAA
	cUwUc3XEGoYd0YmsaGA1rCbKC/QZp6HnU7unCEgIgbdJD1DxQyj5w1Zp1Xp78/G7
	ZyEod+XPfoMVZX3cNyywXiHn51vcw6ROqzEqFxmunsP94UIOxa5xgR9hbQzErxM/
	NCOlQIKKVlUIk0HFmgUQzPGRTfdDIOHMVSGSIoqLHVxNL9Tbqy0YFB2dpDiMJsJA
	G9jI0oe4ZqZo0sYfzYObg==
X-ME-Sender: <xms:pYY2aR56it2vyx1ZcMZ3T2caGg5vyjk-MpaB_RopoKH4NJGBuPef9w>
    <xme:pYY2aV0H9ft29AJIGn-x_Dx5tSmBTL0vK3gGKcajIXDPXJ1XwiLBcBW7hgxcWGDUq
    A-83RfEmbjPS0a5-dRQqrQqWrHvrBYWI-nD77gGXpt7MhypkDAP>
X-ME-Received: <xmr:pYY2aeEb0Ff_wzYEkcEZUQKJugPhJsVgO_94ISqpVvIYkLwQ_sI3BdzWaicnyS4fLzv-HEVcaXdt5UKUzhyBVlM4ZFJ3panRMcug82pKXAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:pYY2afSFiZZajcLCfsAtu0nc5y_KI-t2tZBIaA_FNKwTj_ASYL_QBg>
    <xmx:pYY2aVA2_FzkMpmVltOWAlMBkhJRxP8xwV8wZhle__8-WYuOCrMPXQ>
    <xmx:pYY2af3smWNagBFiHlwioz7gmqDqwAhMkxzuvvxJbVk_8bKRG3zmAA>
    <xmx:pYY2aTU_sKHFmtq83d0jbgpUmg60zsWZ_wNODO47GFsPwTQNEpQIWg>
    <xmx:pYY2aWY6e-DztDHTNRdvwxhsQBZGOQoFy147a4Q5QF9jonhk1XRdFs5t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 8 Dec 2025 03:04:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 54f4a886 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 8 Dec 2025 08:04:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Dec 2025 09:04:23 +0100
Subject: [PATCH 6/8] odb: drop forward declaration of
 `read_info_alternates()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-b4-pks-odb-alternates-via-source-v1-6-e7ebb8b18c03@pks.im>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Now that we have removed the mutual recursion in the preceding commit
it is not necessary anymore to have a forward declaration of the
`read_info_alternates()` function. Move the function and its
dependencies further up so that we can remove it.

Note that this commit also removes the function documentation of
`read_info_alternates()`. It's unclear what it's documenting, but it for
sure isn't documenting the modern behaviour of the function anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 125 +++++++++++++++++++++++++++++-------------------------------------
 1 file changed, 54 insertions(+), 71 deletions(-)

diff --git a/odb.c b/odb.c
index 27f3c8e263..1d83a915e3 100644
--- a/odb.c
+++ b/odb.c
@@ -132,77 +132,6 @@ static bool odb_is_source_usable(struct object_database *o, const char *path)
 	return usable;
 }
 
-/*
- * Prepare alternate object database registry.
- *
- * The variable alt_odb_list points at the list of struct
- * odb_source.  The elements on this list come from
- * non-empty elements from colon separated ALTERNATE_DB_ENVIRONMENT
- * environment variable, and $GIT_OBJECT_DIRECTORY/info/alternates,
- * whose contents is similar to that environment variable but can be
- * LF separated.  Its base points at a statically allocated buffer that
- * contains "/the/directory/corresponding/to/.git/objects/...", while
- * its name points just after the slash at the end of ".git/objects/"
- * in the example above, and has enough space to hold all hex characters
- * of the object ID, an extra slash for the first level indirection, and
- * the terminating NUL.
- */
-static void read_info_alternates(const char *relative_base,
-				 struct strvec *out);
-
-static struct odb_source *odb_source_new(struct object_database *odb,
-					 const char *path,
-					 bool local)
-{
-	struct odb_source *source;
-
-	CALLOC_ARRAY(source, 1);
-	source->odb = odb;
-	source->local = local;
-	source->path = xstrdup(path);
-	source->loose = odb_source_loose_new(source);
-
-	return source;
-}
-
-static struct odb_source *odb_add_source(struct object_database *odb,
-					 const char *source,
-					 int depth)
-{
-	struct odb_source *alternate = NULL;
-	struct strvec sources = STRVEC_INIT;
-	khiter_t pos;
-	int ret;
-
-	if (!odb_is_source_usable(odb, source))
-		goto error;
-
-	alternate = odb_source_new(odb, source, false);
-
-	/* add the alternate entry */
-	*odb->sources_tail = alternate;
-	odb->sources_tail = &(alternate->next);
-
-	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
-	if (!ret)
-		BUG("source must not yet exist");
-	kh_value(odb->source_by_path, pos) = alternate;
-
-	/* recursively add alternates */
-	read_info_alternates(alternate->path, &sources);
-	if (sources.nr && depth + 1 > 5) {
-		error(_("%s: ignoring alternate object stores, nesting too deep"),
-		      source);
-	} else {
-		for (size_t i = 0; i < sources.nr; i++)
-			odb_add_source(odb, sources.v[i], depth + 1);
-	}
-
- error:
-	strvec_clear(&sources);
-	return alternate;
-}
-
 static void parse_alternates(const char *string,
 			     int sep,
 			     const char *relative_base,
@@ -288,6 +217,60 @@ static void read_info_alternates(const char *relative_base,
 	free(path);
 }
 
+
+static struct odb_source *odb_source_new(struct object_database *odb,
+					 const char *path,
+					 bool local)
+{
+	struct odb_source *source;
+
+	CALLOC_ARRAY(source, 1);
+	source->odb = odb;
+	source->local = local;
+	source->path = xstrdup(path);
+	source->loose = odb_source_loose_new(source);
+
+	return source;
+}
+
+static struct odb_source *odb_add_source(struct object_database *odb,
+					 const char *source,
+					 int depth)
+{
+	struct odb_source *alternate = NULL;
+	struct strvec sources = STRVEC_INIT;
+	khiter_t pos;
+	int ret;
+
+	if (!odb_is_source_usable(odb, source))
+		goto error;
+
+	alternate = odb_source_new(odb, source, false);
+
+	/* add the alternate entry */
+	*odb->sources_tail = alternate;
+	odb->sources_tail = &(alternate->next);
+
+	pos = kh_put_odb_path_map(odb->source_by_path, alternate->path, &ret);
+	if (!ret)
+		BUG("source must not yet exist");
+	kh_value(odb->source_by_path, pos) = alternate;
+
+	/* recursively add alternates */
+	read_info_alternates(alternate->path, &sources);
+	if (sources.nr && depth + 1 > 5) {
+		error(_("%s: ignoring alternate object stores, nesting too deep"),
+		      source);
+	} else {
+		for (size_t i = 0; i < sources.nr; i++)
+			odb_add_source(odb, sources.v[i], depth + 1);
+	}
+
+ error:
+	strvec_clear(&sources);
+	return alternate;
+}
+
 void odb_add_to_alternates_file(struct object_database *odb,
 				const char *dir)
 {

-- 
2.52.0.270.g3f4935d65f.dirty


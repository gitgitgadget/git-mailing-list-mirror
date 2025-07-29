Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9D1DED40
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798377; cv=none; b=O41NOOLXw62FNzbkCeWTTQySb+j7R4equZwn1L8VQqzp7VtLWMYflcs0m9RqzHYgkv4eF5tbKT9EoudDMFQzlFHyr93YIgYJci/23Tis/2MpocUuezITjuE3o5mRjyjZgjHX0i2a56tXvgDj62eS1yUBCstZL6VOzHxPBjBzhPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798377; c=relaxed/simple;
	bh=QRwCqqxbg0JTC4gjQF0fzaAKoBVJDDbmtxi+5KPkOTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hqs9/aOpDzfW4isgCAhzIYO1EjPD4utHBDbmM3whqa/fTlF1NJutdgeYU7C6VvUHXOGrpiNIT4RyqPBdJRJ9FKsSlZ5dlzwJ3hN1pDsgeq6bNK5nlcUIAjou4Ff/fbZZpEk6TfznGvYP0mGLB8Tqj89mHIzh1rCfY1/a1PHASRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E1ENmi85; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e2eexlZg; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E1ENmi85";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e2eexlZg"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 26EE21D0011A;
	Tue, 29 Jul 2025 10:12:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 29 Jul 2025 10:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753798375;
	 x=1753884775; bh=sZO+oFfCG/5QWsHm+pUyOV2wU6cyv2+L6ouMk0z/llM=; b=
	E1ENmi85ZtM0P7iocpCmHGIl9c2mspAwVPjjvKMdvoqyB7DsjdkWIQeQjpsjcY6T
	7wZYdELcn0mj6/OtypVSGcr04Hia4Iu3XdR/P+5DElsdUFnJq1KUa8zjOQqXL2Sf
	T16oa2eWCevXPIkHPrsZaN0SSSo9LZVEsWV+3L9ngdCiqnMT+vPJLJdZvc6MZAlP
	QZrIW1dX6krkDcn86NgL0CKftmLEOeMrXuvs1DEhPuDxnv4JzZe50kNyeWy0W108
	HypRdjQgFP30MhmaCQzyzdZ2JvOWX4M4gSiS3LgewlR/N5fA4QvjLwkBfLZ0Uhwt
	X904oUq91h61DNCXLpmNBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753798375; x=
	1753884775; bh=sZO+oFfCG/5QWsHm+pUyOV2wU6cyv2+L6ouMk0z/llM=; b=e
	2eexlZg3vp3s8vboCLGs+YBwyw1r8juahoPnyUOi2pdS1xcZEySFEO4htXsnaKUy
	xnAXXr/HDXZ8g5b6rzgmEU+D089Lqk/0+Gvr0uqYJL2FiUbbVVRkZnWUNBa1r4S7
	nO55LiJ4IU7I7JayupLbMLGtiR5wyV5CckA3TuSXn8soh9cIbM3yjQ4G03z0CYVp
	BE7r+Z6aPaMJnusVQlpcPl/vvEJIVL7PVpPlgzNydvd0/pGbUbPs2f3wv30SBD28
	wKxpMKsr9lW7TCAhJ0nWJAvQxVn6vzsXWXL5R9ZNkskcTNXtbD203iVD3iT2z6uO
	t8SZ+qd2EE7cbzXfqmSNg==
X-ME-Sender: <xms:5taIaELt7-COcy9_GngQSeYuPnfEVf_iej0zGwTB1TkbCETIZ68n3Q>
    <xme:5taIaEVHcn4mL5V6aY5aXMMVT6CcSwtInF7LEMuVz54UspDl4xu4Ow4JISQ8uA7G6
    2RIuRQ55e9TZ9O3WA>
X-ME-Received: <xmr:5taIaGifJjQVcdKpdBTRcMgRtcYEBPJhWTkObmdabwBRcxmAcOxFObMcLFTphbIfUoikGXg1DUYNpBeKNtIlfvdutfwIxtCg5rPGwaZ1OVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelhedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5taIaP_MT_V8DiO1-ESBK_493HlnLK_9fy9w1W56jSnjLlNyWNBRGw>
    <xmx:5taIaABO099hONQKlqKEdxxc0E37sTAlsskANYVm-lujbEtrMtCTeg>
    <xmx:5taIaMLooOha9H_-ta0cwNYLl5JVPLOmKRFl1ktl9lwWI_ZhIuivww>
    <xmx:5taIaDleSx5fU-f5UC66nxI9BFKs9mojyBhJ7_Wh6l033HObtORPRA>
    <xmx:5taIaEmHDQc41Ye78KgpOQuHpr34oisd-0J5aq0blEpG_8Wd40zyRJK8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 10:12:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 339c82b8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 14:12:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Jul 2025 16:12:42 +0200
Subject: [PATCH 3/8] odb: return newly created in-memory sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-pks-midx-deduplicate-source-info-v1-3-748db2eda3b5@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
In-Reply-To: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
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
index 387b117c87..ac7ee05188 100644
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
2.50.1.619.g074bbf1d35.dirty


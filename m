Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5462C08A2
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155739; cv=none; b=mWMB09IoEBRQ+l5lykPNHHGzLiPGsDHS0WV9sozOJCB0aENbboscnv48GZKNG1XRqmy72A036TfytfqY6rBKuho+5pRe9eKvzjD8FeIRqRNKvM14oTlGBS1hfSy33AnywgTa9cjMVPRX3piyREh6S8p5diHDmO2cRHBrQi/jMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155739; c=relaxed/simple;
	bh=thUA8hIMu/2bVggbruBxxZLyg5K6HxOFYSlSgKxIBKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LO4zovHzfFegndVLhFKIb8GmsHXkVFD2Tqr+k8O71eAJkpK5QZEy5babUMKiWQZDMDbV6WQiC1XAJhQgrBe0ukbd8XAysgLpOODrVA0B47k8RcX0aABbrFO9btjek5+jD+iaMktXdUvhmsoyX7prgmytgNmhWGOjWubpn3+5cUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B4W+Mmrd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hpgLg1C6; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B4W+Mmrd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hpgLg1C6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C5EF27A009B;
	Mon,  3 Nov 2025 02:42:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 02:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155735;
	 x=1762242135; bh=5VVBebhiyuKgzqUdm7Sshv61CCczBJr8dNzbdCPshzI=; b=
	B4W+Mmrd89KZ6MFDxpOM88ypdgxmKfemEPva+NcOAnI2oEVYLgKualJHGdvavNtO
	0c0wd1sgI5mAeZfC/4ziOe9XBZpRc2Saczzf95If0mWYU2YwljLysq9EpL4ZFLDT
	Bt5GNrnNW1B0FNN8Qjj8Wm9sLDmRk01jOJF3uF54ytIjQr26rYTMW7kz1tlU692p
	8aAZ9U8TEM2Wx0GLZG1jMtmibgH8BZREy28Gj/Er13cPrwWbmuPYeGFvpVEud+mF
	iYx+4O2FhuXp3jGEMzzJgCwNXu/GSs3PkICxj50uBi3EF+R4z1sE39U+LRLvSSoC
	YqxMLckCkHwlX0uIKyYeHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155735; x=
	1762242135; bh=5VVBebhiyuKgzqUdm7Sshv61CCczBJr8dNzbdCPshzI=; b=h
	pgLg1C61INSZ2zcO+VEheTJcj59Fr/txD+6xAfD8R+IV4fEUnVBLNXB4FXs4GNcp
	ZmsHF6ZcEqpbpWTuA1VWmLUzcbVYRFM+Iz93GA/My1Q7EmhGovSn/Dy7m5wpaIqv
	xh5+bpHaaNlUD6iSfoo67CINrgvGvJHjfXPuIYzWwiMPSGDA7Q9DuB1HE+6dYitN
	XFs257fWT4nUHXhKpvIhV9FPE8ocxVwJABRubMfYWaCfqabBxE+iKPvNgCkY+7B9
	nmICaSFBEtLYClqFVGdk8dKWHkUIlLHR2zx6CMGs5GfCIs3SBG2rvmt7dy+Y//ay
	J8zbAKoID95Pe7wf8rEag==
X-ME-Sender: <xms:11wIaWaAZa6e4t9mgV4SuyQ_F0ZtCu7uP4Uo-00i02QX2fOad_MeUQ>
    <xme:11wIaQ1HbfYhAYKtU02Xu6JFdWq2aS8_bNglPs7LepU-__Y_mcaiIf73jWYkh2DCl
    xmnZxFxTu2yBfcvAhS6AC1L2tCLiReN47COlBHupSVgefX1Zj478Nc>
X-ME-Received: <xmr:11wIaeX21hST808YsYFoGW41tRHshAniYZWDzdLVbnNKjsSknRvHl9vMmTsI3MClx9SSJ5eW0r1FtQcWJEnwwvDwaWxRrD3WjDPgN3Ke4UBX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:11wIaSVhPxuP5jC93rvgIMJp8e1oxsZmZ7mTs1wk_PirWI5DKYsQyQ>
    <xmx:11wIaVcWwZnWq_SJj4GJONpF164yQbKyNIca8Tzwqj11RFm4-MgxHA>
    <xmx:11wIaTUuDga96gg1_DKKQjMbWLeELexI7NI6WuvwuMdbWeEqJfIjdw>
    <xmx:11wIaWdUPE6y0XGRtzAIhVBeRLlCkOWhYH5MeTNJs3BN8aLwJZbVuA>
    <xmx:11wIaY1jKHL9eFb7Zx8-gNmNeLdh5nmEjBguMsHRTPyUrjJYUIErP4Db>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:14 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 63a27d21 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:41:57 +0100
Subject: [PATCH v3 02/13] odb: introduce `odb_source_new()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-2-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

We have three different locations where we create a new ODB source.
Deduplicate the logic via a new `odb_source_new()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 23 ++++++++++++++++-------
 odb.h        |  4 ++++
 repository.c | 14 +++++++++-----
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/odb.c b/odb.c
index 57d85ed9505..d2d4c514ae5 100644
--- a/odb.c
+++ b/odb.c
@@ -141,6 +141,20 @@ static void read_info_alternates(struct object_database *odb,
 				 const char *relative_base,
 				 int depth);
 
+struct odb_source *odb_source_new(struct object_database *odb,
+				  const char *path,
+				  bool local)
+{
+	struct odb_source *source;
+
+	CALLOC_ARRAY(source, 1);
+	source->odb = odb;
+	source->local = local;
+	source->path = xstrdup(path);
+
+	return source;
+}
+
 static struct odb_source *link_alt_odb_entry(struct object_database *odb,
 					     const char *dir,
 					     const char *relative_base,
@@ -178,10 +192,7 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
 	if (!alt_odb_usable(odb, pathbuf.buf, tmp.buf))
 		goto error;
 
-	CALLOC_ARRAY(alternate, 1);
-	alternate->odb = odb;
-	alternate->local = false;
-	alternate->path = strbuf_detach(&pathbuf, NULL);
+	alternate = odb_source_new(odb, pathbuf.buf, false);
 
 	/* add the alternate entry */
 	*odb->sources_tail = alternate;
@@ -341,9 +352,7 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 	 * Make a new primary odb and link the old primary ODB in as an
 	 * alternate
 	 */
-	source = xcalloc(1, sizeof(*source));
-	source->odb = odb;
-	source->path = xstrdup(dir);
+	source = odb_source_new(odb, dir, false);
 
 	/*
 	 * Disable ref updates while a temporary odb is active, since
diff --git a/odb.h b/odb.h
index e6602dd90c8..2bec895d135 100644
--- a/odb.h
+++ b/odb.h
@@ -89,6 +89,10 @@ struct odb_source {
 	char *path;
 };
 
+struct odb_source *odb_source_new(struct object_database *odb,
+				  const char *path,
+				  bool local);
+
 struct packed_git;
 struct packfile_store;
 struct cached_object_entry;
diff --git a/repository.c b/repository.c
index 6faf5c73981..6aaa7ba0086 100644
--- a/repository.c
+++ b/repository.c
@@ -160,20 +160,24 @@ void repo_set_gitdir(struct repository *repo,
 	 * until after xstrdup(root). Then we can free it.
 	 */
 	char *old_gitdir = repo->gitdir;
+	char *objects_path = NULL;
 
 	repo->gitdir = xstrdup(gitfile ? gitfile : root);
 	free(old_gitdir);
 
 	repo_set_commondir(repo, o->commondir);
+	expand_base_dir(&objects_path, o->object_dir,
+			repo->commondir, "objects");
 
 	if (!repo->objects->sources) {
-		CALLOC_ARRAY(repo->objects->sources, 1);
-		repo->objects->sources->odb = repo->objects;
-		repo->objects->sources->local = true;
+		repo->objects->sources = odb_source_new(repo->objects,
+							objects_path, true);
 		repo->objects->sources_tail = &repo->objects->sources->next;
+		free(objects_path);
+	} else {
+		free(repo->objects->sources->path);
+		repo->objects->sources->path = objects_path;
 	}
-	expand_base_dir(&repo->objects->sources->path, o->object_dir,
-			repo->commondir, "objects");
 
 	repo->objects->sources->disable_ref_updates = o->disable_ref_updates;
 

-- 
2.51.2.1041.gc1ab5b90ca.dirty


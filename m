Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3DD30DD10
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299774; cv=none; b=e3+zriI5pSnPn2fArgJzsJM53ilt/1eGQYAe/2TNZq0auxyvzHB8yoRIOoiKyb9C9dhxVIdwkX88xTPfciq2r7MS+UvIc+6Umiz/CALQ2REwyA8UuERP+V/1eM/bsz1vYTcnpN9thKkmNZoOwzeG9T1eim9poX/Nr8hR/UongdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299774; c=relaxed/simple;
	bh=7LfHcWClGtKe5bGNXe6f6S0xfcWrqAvyuAml8cwBvVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSAXOYVg6RUkPg0D55HB9alg0iahwzcbMfVIx1WTZvgljb5vDNXQJFRaBUgjs+0Gk50XfJyRsesBZtpf74DfZosey0/kVqhTu8SruJ/abFcobKoRW7KIL0NAAMVWwzdXUWb1gqQR1AelWOa3ToLOlrnsD9mK3miPEA9tEEo75t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LcmuCh4f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JcFVFNyB; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LcmuCh4f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JcFVFNyB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9EA1AEC02A6
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 05:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299771;
	 x=1761386171; bh=VbkMcDG3UnlTQBJUEXAANpDX5LksGQuC5ZYX9c0yd18=; b=
	LcmuCh4fKkdYhrxkng9BofcuW7cqkZBh/YeeDBoJWgDTF0EcAgMQiLS36RV5z7E2
	xPBf1KyLiI7GKgCgFCPeMq67+ydaWMuy8v424PZ8GXVTnDppqomgECVSF/0m/QhO
	/z/Ng2xGp/UJf5LfcsEEJBh9AIk5y/AzkpX7w7OosWw5E04sXlJMDLwsjePfanTz
	WgdvfSlV1hE1o9ukrwoOWBZCkBYr5Rfvzp7Le0Hig5oPnxMvhgBruYf0Dbx774Gy
	bTDF86+qkOP7j9kRmFwj3fSK3XvpqFrDyeRnI82bEzcKXW5y/uocdL2GfF9468Up
	OLmcjstNuU+gDsp3kEJRxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299771; x=
	1761386171; bh=VbkMcDG3UnlTQBJUEXAANpDX5LksGQuC5ZYX9c0yd18=; b=J
	cFVFNyBpKR2x9FFJfHa4SyaEJfT6uiR7z3NBUxA8UYKckTFGZOXWf3mwVPYRlC0X
	jKoTWSk2+sLgjDlwYn3qeb8PPydBAUbU9jNg212+a7uHgxbvaGakgIX5EfzWS+CX
	wd9wit9DaEGJSiwys0xX4RaXlJZ8EPUTE9wnniiXTzTVaCWRdoz+MxakTcFYPD1d
	hydcKY/zw46/tsOadJK4HQMzu2tDjo6xKerUvavhnmP/RGK4GPP7HpHU2dxwUr7y
	pqmVSfRj7fDq8wiF2N5nBJhBJaxHOtPeT+mFiIbtUs6PkPnYeU3FoWHq9R5P2aq+
	DRZhIjRjqzIIBQWROI96Q==
X-ME-Sender: <xms:O037aEN-XM7Ojv95ADrZP0bKZylGCitNZqmPzSbWpyYSlROiR2YOfA>
    <xme:O037aB4JNh1iPQBvKHGg_-dr2GZny0ZvR59Pn0_WmgxgLpCvJ9xwUuyjKKQVC6bBW
    mFuxVUSmfp41PJTQSIUfcar4lSdc4Y5Qb7w80C7NULSWAYuBvDETA>
X-ME-Received: <xmr:O037aA5B_eOqNLlWb1QCqDDXEFoPucqn19Y9NpOQIfAKVZAchIYpxzUDMZNAgzxU_jc7wfBznNcByLGOeAP4W4KaYxQu2_BPgLXuTFHH7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:O037aB3IpCDPz0HW1emM-PgJ_ZSm5GmkADGBRn0s8BgQBrKA55AwaQ>
    <xmx:O037aMU31DPm3LACr34ZzRZWxnusvhI1pOqz-yxU3OGitu9FtbznBg>
    <xmx:O037aM6pvbxGziSEvMuTSZHXtrFxLrMfoXZrRGWrnALuAujH2U1Brw>
    <xmx:O037aDJqNwAAeos9J1_MyEwOzhVCy_HMuztD90vW4UUhqq2DC5FiJw>
    <xmx:O037aM9Yf4IneVeBUv4RpCeOk7_wsB8ChNVNHrWucKG0KjhGNxBMUfc0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31109ef5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:01 +0200
Subject: [PATCH 02/13] odb: introduce `odb_source_new()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-2-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.51.1.930.gacf6e81ea2.dirty


Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926A2ECE85
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891173; cv=none; b=fkQ2diapgyZ17EYUXqQEx7v+0bLxpikpHMLcxFiFSSzDH6PwIyy0JiZMaMsk67/jTIm71mRDSLjHRVaj34HfUNH1TJ7GTZOvscoBWteKAxvEjERKplfPBn3moMSITi/dfyS9Ik+nwgAZtYxphlRT+tsUuFvnDxwasO40BJChrTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891173; c=relaxed/simple;
	bh=thUA8hIMu/2bVggbruBxxZLyg5K6HxOFYSlSgKxIBKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYIRDPS5SA2rEVMKvsttpiq19hHP0FfsxTM+qICo7FGE8IDTxukVbecOo2iHDB9iqSesuB28W2cTnQEuh+6/DyN1e73saU4phybxmBSc0mDSnuDanP2EfrONJwUxDVU5zuGp7rR+Sw0ZpyA8L5IIG1GedMjCXnpzIewe0EP3drc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I73qoRVO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h5WIJz37; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I73qoRVO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h5WIJz37"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1EA9EEC0084;
	Fri, 31 Oct 2025 02:12:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 31 Oct 2025 02:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891171;
	 x=1761977571; bh=5VVBebhiyuKgzqUdm7Sshv61CCczBJr8dNzbdCPshzI=; b=
	I73qoRVOrBiPLdm8KZOxV8x+MEwQznHFOm/5FzvyHoqJbli0BiXcUfjyaq9Rq3lw
	KZapIZ9cWJrgW/60s3pe75q5ZIpPDNJuLIfUDJ9rYGhCY/Kjgj0nhVei8SZ/MEn6
	rBRHzP1pCYDslgPBMXrApoHMehX6rWbDUz6l9ogt83PqSTvKPRvY463tl2Bhw3SJ
	DmqmyuCY0+lDxtK5YTImSqyp5HetUYvEgRI0S+dknW+fqt9fC0qb7jJxb+6/fJrv
	1zi7plkQ1j22lS3RmSNirW6xK0X8jK6QkaNENVXbKHUbD+dnHV8CoJ6vQ1s4gI7t
	FArf84BNBQLF+5a+YXkNOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891171; x=
	1761977571; bh=5VVBebhiyuKgzqUdm7Sshv61CCczBJr8dNzbdCPshzI=; b=h
	5WIJz37JeoAbpNIDOl7z2F/2IOe7qZKSGJFG+xEBbi8S9gtq1OAIIJDNxbZpDpRg
	jYGyGpqvRMoMtLlTv4hbTJRdBv74Lm2BhZVSi2tQMAgWpyENkui198lok+8xQx31
	yoSqLtbBER6xA0g5Ls8N8/zxzhTvodS2g6BE2C5QCmUuNMdTyQEibp9RKf5Ulhf5
	Cnso2G8v/DOmUXXjHFOIKoe60C3MZfSz4pAqyouwz44Xl1DRblqdIvZtIv8k9xHT
	p8vTPAGqpvJLmyv8ZCXhfTyOVyOMf6pCoE9K/J+EM8USTgOo3dRp3fvYC6mrD2eM
	8ntWP3tgYDNo2bE05QHQg==
X-ME-Sender: <xms:YlMEaXzmEeo0G9qe2KOy5emX3j3gUc8mxfDRKRtz80kYZtScNUYLzA>
    <xme:YlMEaWuC1HLI99LaliFAYaDYBlO8Np6-jlc-ZC3UurwsMQicu2fonNv4DiTUqLx8i
    voRlM98EakuIwT8yuYIUDBK5mqP9Sc04MR99EKzBeFMmHesmd82JQ>
X-ME-Received: <xmr:YlMEaeuxyQruNIrGxyPQx1uY78DvqlklhksasbZhHC_j2P-hYBfgkCzBQZ0pLJoRfPO8hP5h00Lace7LEdfM50vWH17s7xbJAOIeMNPWaelQiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:YlMEabNmKIU2J5ySy0fPhRg_9nVgBF0lBxpZ5jx0zXwklb1gnuQg9A>
    <xmx:YlMEac0H3k8j8zHquPcDTT0NDn9GZQqUwHwEHY25MsxW6-7NljROYA>
    <xmx:YlMEaXMBGX7v1ZMtC4q2pHjIedjLfaHSBbQWHW4DwnEGm3WL9Zp0DA>
    <xmx:YlMEac35yaWnmEn3Q3CGYR1tj2d-gZuCYzYKMVjPvxtQgqtLNNoXPA>
    <xmx:Y1MEaWtAim_HRZ3TcYMLg17-_KH3ec6LkVxjDVGmlj3GNJiCTqYw9sYX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:12:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a99e0ba8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:12:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:38 +0100
Subject: [PATCH v2 02/13] odb: introduce `odb_source_new()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-2-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
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


Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059422D7DDC
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538679; cv=none; b=ZSKxB/4y0UweUHWqNGXsDwpwblVnktc4Q7jQ+nMxVV2d6tW84ZEcV63mMwq0KDvbccVT5265vnliLAaXS4PqJcCA0idD9hIpAT31Iw6wewKSp+7x8jm55N7MZW6zxNIAdvx749nOhGWfeaorNT4kmB002sApmTEUsq8Mntf7KaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538679; c=relaxed/simple;
	bh=sAX6Q8ngwEYKJ4yq53Mmr7TgoPUt9E43/yLKpDlPD2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abZG3dg6ARDlPyY6eJoKmUMYr5otl+LIGs0F52tHChd32c9hdw/P1qL+5Pzrgq8YgSo7pCGhd/Zu23YfPg80YlwYIxPndnaXPzH/UHm5w5WSGmg4H83vJ+nzk34pptibopUcKfboMWG5lADu35KWDvR1dPkDZrid1zKXjWHSvgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VBwWqJPY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KqUrFwDT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VBwWqJPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KqUrFwDT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DA7B140017D
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 19 Nov 2025 02:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538676;
	 x=1763625076; bh=ocYKZtP3Jhl55MEtkWcqIxNto4/UlCjcZoD9tpu+H8Q=; b=
	VBwWqJPYAnpeoF0yie2slF+/23+/mHx/Cpwj+5grKg/gU+tSDkk9IGpCo10a5ODo
	wfb2Pr7h4iLgVaUl5RrzmVKxAWb9YbuWvF7JmQfWygCNjIXTTMJ3q04mX4u0Mz6r
	NR5DQSEqndS/ycrc3ZXZ9+DKJAi6uPObZgJwOBAVwbpKGq8mRx3f7SmHSrCd+lnq
	xxAMhbPhy5Pla7A/pfXuAKoVK/5WoLbzLj42gQwHx4mVKRl8sN4wlPfkOPiCBKA6
	bZ9e3eoNOKwTSBQ7EVPmzijDLxEvQbT23odglm2OwhmIZ5PrmJCZI191mJ9B3eBV
	p7p35gfp18h/OoxxUxGmZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538676; x=
	1763625076; bh=ocYKZtP3Jhl55MEtkWcqIxNto4/UlCjcZoD9tpu+H8Q=; b=K
	qUrFwDTqc47bz+sb7U/vryqr/VPdbveeLu/JFcqe4capDCaZwK+hvW8O9u9H1w+S
	jaMSq3mtusaKINFK+84EVfE81dB2QGUrOs2AgVF4XZXBGypDfO39ZhD7FKJGTg90
	hltNASpqrA9gDVy5h6CrLXWDnTuz5f8a7SFQTYRxtBLt602kF1mruWKGsT7XUW3f
	/SmmynKv6jW++LnkEnPgab1j/sKKT43/92XL76nZo5RZgaET/pUsa9F7iUyyZV6o
	SKIE+PYDAIPjpBK1VD9U6XcNjOV9SsGwv18Hx3LwxmIiOCzMtydc6la685uNnZro
	tAEeR6KqYZ3GGzRhDkP2A==
X-ME-Sender: <xms:83YdaVP7jPQFbREIVgXAiDhX6M9LTVNgJfbQb96GF6-u1cf5JLxZhg>
    <xme:83Ydae6o9xqu6JpwcnkJP1ms-6Ed8lGvu_1hAc1qPYbISgLlnJHVV6bsl5MyqL5M_
    bkWp3n4OJ7WE2--S9VBtS82vif0Uo--GVFeusaMpK47f7aS3zE8Mw>
X-ME-Received: <xmr:83YdaZ4sw5hSQUy7IEpQ4jZq9atgIxV3BGbxZQzyFaRNnowiorKHKOBhnZIm0ZiUVxFM06V8U3eZBLO-kSojGmxvd6ptmuigXk7O1K1fhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:83YdaW10TfMv7IbAVPiVzhN_FKmqArnblGrwL4vHeb0A-74NCcaLvQ>
    <xmx:83YdadV1NaqgKAuTA96x4Hdsdw07AVAovGVr3tnLZGQM7TBu6XL_tg>
    <xmx:83YdaZ52p5jpTJjMAuAybB92eG-pN7W3ZQ2kqeLd8nirALSTDdB60w>
    <xmx:83YdacJ-huDZGfk2VxeQeTSfJctD6DFDkADchwu7PoLJACXqMrLB0Q>
    <xmx:9HYdaR-562TFazqvpiGHC5XYealyhePsJIizPBzEb_yDE9AyQN7yAptl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c300d3cd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:50:53 +0100
Subject: [PATCH 05/13] odb: move logic to disable ref updates into repo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-5-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Our object database sources have a field `disable_ref_updates`. This
field can obviously be set to disable reference updates, but it is
somewhat curious that this logic is hosted by the object database.

The reason for this is that it was primarily added to keep us from
accidentally updating references while an ODB transaction is ongoing.
Any objects part of the transaction have not yet been committed to disk,
so new references that point to them might get corrupted in case we
never end up committing the transaction. As such, whenever we create a
new transaction we set up a new temporary ODB source and mark it as
disabling reference updates.

This has one (and only one?) upside: once we have committed the
transaction, the temporary source will be dropped and thus we clean up
the disabled reference updates automatically. But other than that, it's
somewhat misdesigned:

  - We can have multiple ODB sources, but only the currently active
    source inhibits reference updates.

  - We're mixing concerns of the refbd with the ODB.

Arguably, the decision of whether we can update references or not should
be handled by the refdb. But that wouldn't be a great fit either, as
there can be one refdb per worktree. So we'd again have the same problem
that a "global" intent becomes localized to a specific instance.

Instead, move the setting into the repository. While at it, convert it
into a boolean.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 3 ++-
 odb.h        | 7 -------
 refs.c       | 2 +-
 repository.c | 2 +-
 repository.h | 9 ++++++++-
 setup.c      | 2 +-
 6 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/odb.c b/odb.c
index 29cf6496c5..ccc6e999e7 100644
--- a/odb.c
+++ b/odb.c
@@ -360,7 +360,7 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 	 * Disable ref updates while a temporary odb is active, since
 	 * the objects in the database may roll back.
 	 */
-	source->disable_ref_updates = 1;
+	odb->repo->disable_ref_updates = true;
 	source->will_destroy = will_destroy;
 	source->next = odb->sources;
 	odb->sources = source;
@@ -387,6 +387,7 @@ void odb_restore_primary_source(struct object_database *odb,
 	if (cur_source->next != restore_source)
 		BUG("we expect the old primary object store to be the first alternate");
 
+	odb->repo->disable_ref_updates = false;
 	odb->sources = restore_source;
 	odb_source_free(cur_source);
 }
diff --git a/odb.h b/odb.h
index 77b313b784..99c4d48972 100644
--- a/odb.h
+++ b/odb.h
@@ -66,13 +66,6 @@ struct odb_source {
 	 */
 	bool local;
 
-	/*
-	 * This is a temporary object store created by the tmp_objdir
-	 * facility. Disable ref updates since the objects in the store
-	 * might be discarded on rollback.
-	 */
-	int disable_ref_updates;
-
 	/*
 	 * This object store is ephemeral, so there is no need to fsync.
 	 */
diff --git a/refs.c b/refs.c
index 965381367e..6c7283d9eb 100644
--- a/refs.c
+++ b/refs.c
@@ -2491,7 +2491,7 @@ int ref_transaction_prepare(struct ref_transaction *transaction,
 		break;
 	}
 
-	if (refs->repo->objects->sources->disable_ref_updates) {
+	if (refs->repo->disable_ref_updates) {
 		strbuf_addstr(err,
 			      _("ref updates forbidden inside quarantine environment"));
 		return -1;
diff --git a/repository.c b/repository.c
index 3c8b3813b0..455c2d279f 100644
--- a/repository.c
+++ b/repository.c
@@ -179,7 +179,7 @@ void repo_set_gitdir(struct repository *repo,
 		repo->objects->sources->path = objects_path;
 	}
 
-	repo->objects->sources->disable_ref_updates = o->disable_ref_updates;
+	repo->disable_ref_updates = o->disable_ref_updates;
 
 	free(repo->objects->alternate_db);
 	repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
diff --git a/repository.h b/repository.h
index 5808a5d610..614649413b 100644
--- a/repository.h
+++ b/repository.h
@@ -71,6 +71,13 @@ struct repository {
 	 */
 	struct ref_store *refs_private;
 
+	/*
+	 * Disable ref updates. This is especially used in contexts where
+	 * transactions may still be rolled back so that we don't start to
+	 * reference objects that may vanish.
+	 */
+	bool disable_ref_updates;
+
 	/*
 	 * A strmap of ref_stores, stored by submodule name, accessible via
 	 * `repo_get_submodule_ref_store()`.
@@ -187,7 +194,7 @@ struct set_gitdir_args {
 	const char *graft_file;
 	const char *index_file;
 	const char *alternate_db;
-	int disable_ref_updates;
+	bool disable_ref_updates;
 };
 
 void repo_set_gitdir(struct repository *repo, const char *root,
diff --git a/setup.c b/setup.c
index 8bf52df716..a752e9fc84 100644
--- a/setup.c
+++ b/setup.c
@@ -1682,7 +1682,7 @@ void setup_git_env(const char *git_dir)
 	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
 	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
 	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
-		args.disable_ref_updates = 1;
+		args.disable_ref_updates = true;
 	}
 
 	repo_set_gitdir(the_repository, git_dir, &args);

-- 
2.52.0.rc2.482.gaa765fefd0.dirty


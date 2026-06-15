Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DFC3F44FC
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531825; cv=none; b=GsMWv0Z0UguELgZ/SOrXsztHPnDh3YozajLeOgIKKDxMK4x9i0kG0invN0wVS2xQRPluyNnfVfFYUkSA1XGP1HFXfY27DvX3Z0zPOrPssmyxPXu3ZNqOnTeoCWx5RX/V7UEtiRkbmS1aC7OyoB1XyXPgeVOlMsWr7y7MRj60/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531825; c=relaxed/simple;
	bh=9z1e/DrZywMghLx/FUXva4xq6T/H3fvECdL5J82Y2vQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z4pGSZNosQv8QNqgBCJf4jTJWbs6qIxkwZyqRSQya3KFW7PKNQXb9eVINmSEXp6/tiylfZrInZYYpKlohJkms9dxf1nC2S2DCkJs3a6MYMPJhPMeCQA4mYnR4Mv1MHgpX3oNhjsZeDa+JhqdFEousPONbgcGEPB+L8R5v0im38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u/HIzqxP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U1NUzl1W; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u/HIzqxP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U1NUzl1W"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A7CAEC0281;
	Mon, 15 Jun 2026 09:57:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 15 Jun 2026 09:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531823;
	 x=1781618223; bh=WmffaeAjtpe+Wb+34csfbI15MZ2uvg0PI3f420QVNjU=; b=
	u/HIzqxP23Kp/zSrx391zuHztXQFbtO/Mxo+wzKabcDekpiS/O3AQvWobz/C3BvL
	dsKalnH+b70zCEe3DZOg1DJq8d2QVnu+4CZz8UtZ3QIc9R1heeg0zomIqkaLWUnn
	uZfBIDGj5cOWYSflxvf9ROP6J5m6YTcMaZ7Gh6soioTLxYJqu37SPhAGE5WhagxU
	HQ20MvkpHb09B6/+ZVACHOM+nvhVWX+H6ju0rZ0t1Gjn90RUpA7y9t2Px1q64lDU
	3CHEVLEp5LIjFgw1AGbr/yf9gTQw6hpj22O/PdjG0TWeIa9wxpoHNrU8mHuP2A+V
	TjKoUnIlKtY5tpkQLhkrpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531823; x=
	1781618223; bh=WmffaeAjtpe+Wb+34csfbI15MZ2uvg0PI3f420QVNjU=; b=U
	1NUzl1Wq8aKNQU+/KOvwIMldbjcAv0rIDEcjU/+Yo9pVksKXrkkeVcQspqhUt6dJ
	WL7FNNDceMXa9qCevZKraiaDtSTZJLqj6tPMu+CuEIcYYaSahVGtpmDY78ccBwkR
	SxRWEwKr/edfGBpTgLLb5Zkq0Bxb1P3+gVRZZEgIUqDgtoftTJ9GDSXTNkAMqS8g
	pwA+3yTzaiaGh9hq1uy72kiMV/4hJ/B6A5YDm3LIP1MyhsKVwCQ9aNAdJ/UbV2bT
	fbwgJ58QG1pftve9B+GK5cp8Ee4zs6BX+BXeB+hXHHqGPA9KDZiEmopNBb2k4fQH
	FObseJeQQL7CbN0OZyUCQ==
X-ME-Sender: <xms:rwQwasgLucYhnLHZps77TVWKjg9zPejhMt5nlFY--1eRzGr-L6AI9g>
    <xme:rwQwaserkdvKoEXyjvquCUKjxvZZ1tnpIsXGm240syXot5WB_AWBZ8qrRq_1bYELf
    ZeBbCA7MO0Qs4PaXP4o_slyQxxpXptuuWenmZz2W-xSqCr_bYz9qg>
X-ME-Received: <xmr:rwQwahf2TH9pmXhHEY6DAGNQuDhvj9WpE3xOJL4cCYvLZ8dxDKZdvCQ14jF60-ZOAQ9zW2ssUb6FXeiiAP5B2o-KgXnBFlxQqHeWErUDnA>
X-ME-Proxy-Cause: dmFkZTEzlJZ7R8Fvdu12VIGi3pV5LVsqHobsEu2nC0pNPyYWLdj9qPJCTKMapBlAsX/FC1
    ZbCX8TtHPplEWxYtSTu6Wxgl3HBugROG2heABRQngsHUxAkgA9ZJNEDMP2d2cDdLEK9PCh
    R9hAehfnKauFBTwOG4hB8EZg00fL1KQglppoCzUXP3cP+K4uNaKKWeaQ4zVLMTGHxDG1uT
    RHXaOGhJ6FYs6BRN9/WmRzlmt9z5H8dzqvlGMu9eQRpm7PjBo6kWzwGxTriYr9kp/zbnmh
    Reva0Rh+pLvtzTtkYVOqewlTH1iAUjzt9vKEkWf/t8xUrNceBF5ppzYc0VRIMxMTGr0kZf
    heduzCFoho7U+ZrxlKU5t8O2IC0GC7rHbw0nUl5N+o6PoWe30fUTBle4ZlvQS0QOW+7VL1
    0FXk/XO6OCEahO1J/5QJSZrDEfp3VJr0lIEfFB482DBUZuHuEVrPDGvEpxyUSxNxAS9F5I
    Jgu1t/otqpe2BAy1nt1ctByLXm0IyQjiWPHzvD7b2a1CHUoN7X1EBI2q2AV+RLAU71zBnG
    ag88RT22BSxXp3f/rNdu5tELqyzr3B24tE+jMVEzQttvuF+P7Jdn/qEvoCkFcJBkMDky3R
    GbQIFUAJw2HLYIN8anYbDyDrw8brr+gFv2y0eA3sSAFz/cuzOV/HC64YGkaQ
X-ME-Proxy: <xmx:rwQwam_12xCskHJPI3uii4ooH9I_qNkFZlvIUH0x5d0lYYeM8g8ESQ>
    <xmx:rwQwatm13rqY0kxDir0pOmHwCav_lQS_evLzhrLdkrMnGw2Afdw9vQ>
    <xmx:rwQwao_k0YQ-WKP79y4tht9vv9ojqjJoP_FR2UzQy-2rvYe555SQEA>
    <xmx:rwQwarnUXUTM6FkyjJBHUEVh8pUvOO5Tv90Sv4-S560owU175XK5Ag>
    <xmx:rwQwajJJN7TMlgrqzvMWuU-uohvIkMle2ikCGXBFROSwF1F0VkIZ_SGD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:57:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d81ba363 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:57:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:56:50 +0200
Subject: [PATCH v2 4/8] refs: unregister reference stores from
 "chdir_notify"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-4-f4854aa99859@pks.im>
References: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
In-Reply-To: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

When creating reference stores we register them with the "chdir_notify"
subsystem. This is required because some of the paths we track may be
relative paths, so we have to reparent them in case the current working
directory changes.

But while we register the reference stores, we never unregister them.
This can have multiple outcomes:

  - For a repository's main reference database we essentially keep the
    pointer alive. We never free that database, either, and our leak
    checker doesn't notice because it's still registered.

  - For submodule and worktree reference databases we do eventually free
    them in `repo_clear()`, so we may keep pointers to free'd memory
    registered. We never notice though as we don't tend to chdir around
    in the middle of the process.

We never noticed either of these symptoms, but they are obviously bad.

Partially fix those issues by unregistering the reference stores when
releasing them. The leak of the main reference database will be fixed in
a subsequent commit.

Note that this requires us to use `chdir_notify_register()` instead of
`chdir_notify_reparent()`, as there is no infrastructure to unregister the
latter. It ultimately doesn't matter much though: in a subsequent commit
we'll drop this infrastructure completely. We merely require this step
here so that we can fix the memory leaks ahead of time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c    | 22 +++++++++++++++++++---
 refs/packed-backend.c   | 16 +++++++++++++++-
 refs/reftable-backend.c | 16 +++++++++++++++-
 3 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a4c7858787..296981584b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -100,6 +100,23 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
 	}
 }
 
+static void files_ref_store_reparent(const char *name UNUSED,
+				     const char *old_cwd,
+				     const char *new_cwd,
+				     void *payload)
+{
+	struct files_ref_store *refs = payload;
+	char *tmp;
+
+	tmp = reparent_relative_path(old_cwd, new_cwd, refs->base.gitdir);
+	free(refs->base.gitdir);
+	refs->base.gitdir = tmp;
+
+	tmp = reparent_relative_path(old_cwd, new_cwd, refs->gitcommondir);
+	free(refs->gitcommondir);
+	refs->gitcommondir = tmp;
+}
+
 /*
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
@@ -128,9 +145,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 
 	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
-	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
-	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
-			      &refs->gitcommondir);
+	chdir_notify_register(NULL, files_ref_store_reparent, refs);
 
 	strbuf_release(&refdir);
 
@@ -182,6 +197,7 @@ static void files_ref_store_release(struct ref_store *ref_store)
 	free(refs->gitcommondir);
 	ref_store_release(refs->packed_ref_store);
 	free(refs->packed_ref_store);
+	chdir_notify_unregister(NULL, files_ref_store_reparent, refs);
 }
 
 static void files_reflog_path(struct files_ref_store *refs,
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 0acde48c45..499cb55dfa 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -211,6 +211,19 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
 	return snapshot->refs->base.repo->hash_algo->hexsz;
 }
 
+static void packed_ref_store_reparent(const char *name UNUSED,
+				      const char *old_cwd,
+				      const char *new_cwd,
+				      void *payload)
+{
+	struct packed_ref_store *refs = payload;
+	char *tmp;
+
+	tmp = reparent_relative_path(old_cwd, new_cwd, refs->path);
+	free(refs->path);
+	refs->path = tmp;
+}
+
 /*
  * Since packed-refs is only stored in the common dir, don't parse the
  * payload and rely on the files-backend to set 'gitdir' correctly.
@@ -229,7 +242,7 @@ struct ref_store *packed_ref_store_init(struct repository *repo,
 
 	strbuf_addf(&sb, "%s/packed-refs", gitdir);
 	refs->path = strbuf_detach(&sb, NULL);
-	chdir_notify_reparent("packed-refs", &refs->path);
+	chdir_notify_register(NULL, packed_ref_store_reparent, refs);
 	return ref_store;
 }
 
@@ -274,6 +287,7 @@ static void packed_ref_store_release(struct ref_store *ref_store)
 	clear_snapshot(refs);
 	rollback_lock_file(&refs->lock);
 	delete_tempfile(&refs->tempfile);
+	chdir_notify_unregister(NULL, packed_ref_store_reparent, refs);
 	free(refs->path);
 }
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 4ae22922de..8c93070677 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -365,6 +365,19 @@ static int reftable_be_config(const char *var, const char *value,
 	return 0;
 }
 
+static void reftable_be_reparent(const char *name UNUSED,
+				 const char *old_cwd,
+				 const char *new_cwd,
+				 void *payload)
+{
+	struct reftable_ref_store *refs = payload;
+	char *tmp;
+
+	tmp = reparent_relative_path(old_cwd, new_cwd, refs->base.gitdir);
+	free(refs->base.gitdir);
+	refs->base.gitdir = tmp;
+}
+
 static struct ref_store *reftable_be_init(struct repository *repo,
 					  const char *payload,
 					  const char *gitdir,
@@ -447,7 +460,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 			goto done;
 	}
 
-	chdir_notify_reparent("reftables-backend $GIT_DIR", &refs->base.gitdir);
+	chdir_notify_register(NULL, reftable_be_reparent, refs);
 
 done:
 	assert(refs->err != REFTABLE_API_ERROR);
@@ -474,6 +487,7 @@ static void reftable_be_release(struct ref_store *ref_store)
 		free(be);
 	}
 	strmap_clear(&refs->worktree_backends, 0);
+	chdir_notify_unregister(NULL, reftable_be_reparent, refs);
 }
 
 static int reftable_be_create_on_disk(struct ref_store *ref_store,

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty


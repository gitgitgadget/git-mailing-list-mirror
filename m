Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903E4192FB
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103453; cv=none; b=tWUmVpxliNZ2zALpA5PrzYMu5ZoFFN+5F0ddaSwRimJPNk7CQijQOcdOHRg/b2bXyJtupmSM+003tH6rt751UeYHYYHeCohKluBkvRwha8DpOLuFheiflfBLCFBWY7KRaaVbQMheG/AURpajyJp2M1mPwAow+DijNOMKMKFroAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103453; c=relaxed/simple;
	bh=YUXuhqbR5Kt1iTuCJ/Bu6zlLwZQ1Do89DNdcy0Ud2V0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BwCwKWi+AFwAdw3/+2AwczcEKeuwVayakUhH8V/pVHnyiEEumuIHh8I7h3+26JzzKRBP2zeOCgeHXo+NN/KIdR4Z2dRvK4pUAVGEqbdEpM185U2jkN2KG39mEYs5YRZBnEjLRggLzKe2rj7kkKvlh/s+7RHdo9CUhKLFAUzG8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lCCGvk1q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SBR5Aqzb; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lCCGvk1q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SBR5Aqzb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A61D0EC016D;
	Wed, 10 Jun 2026 10:57:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 10:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781103451;
	 x=1781189851; bh=5f+8LgdjSke2ZQ1+MVVk0ycWlJQM/tWSiT3/k/AWxB8=; b=
	lCCGvk1qwtU5zMILTOalei9/FYAdSwXDrDe52qZMVAAT/alSKv+uZQNJX0A2BX0f
	FxYZAqzlgPuzRJWnRidA94L30XYbL8A02OI5alae9vTv4Q7wkmRy6Wh1SbC2JtXi
	ae0fVtAqTwsczhOloWMRjOrsFSk1ftFl4T97mTp2Tk2XozZeW3w5ijl+w3EJp6ME
	a6mg2EREETcXrDxAkt8wTluyX8WioDVPV0ul0wPFzUdgYeoXv4oggZXRvJtGd2PR
	N9EAqF3k2ZecvTGkUltyDYZNfsF5pILbbWwUG6eL4qSdWbQAhDORv9YazjwD4B6g
	7xVcpuMNCSwufpYPv+F4LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781103451; x=
	1781189851; bh=5f+8LgdjSke2ZQ1+MVVk0ycWlJQM/tWSiT3/k/AWxB8=; b=S
	BR5AqzbyM0VKiNfgSc+5ZvtLgyxl+CoF9E7WoAKLnUX+ihrOlK+yFTjBmsvAke49
	0C5esChM1Cn1dHku/M1ESM3e4yhT8Wz5IOqrSdFJ8FuzWzcLTbITng7eMjgs3ktm
	buWwGfsnWziOJ/u5E80VhjT5i2LBdOK/TpUwx3cZxZXbz8FcXVTW4ZvWxlSDG5ec
	T8hhbwNveWv+8hUJakUc9MsLs6ngVI/D0atX7DPOFk2mWmMh6LlMJMJsG60oRZzv
	zgmL3OpujpTUS8OcDtiPROQ2ziVwYBL8OA76mSwD5w7KPZotHlPAo8+eTbFQLA0a
	Yf+c0L8QjNB/3qXgd9vOQ==
X-ME-Sender: <xms:W3spak3ePjVKsg8-D9bp1g0RFkGnkbPdUvANKCynua4PlbDizV2LQQ>
    <xme:W3spalF0DbXhrsGHJLPkr0s8h40ZM4gQOv7pUI5Yyx3uacZnrMxcGNENf2XH9-Wwb
    nVxDjJqT1uUdU3k7au9p21ERREFlI02Lg4P0oyVKFTTEAKROWPaPA>
X-ME-Received: <xmr:W3spaqhCMNqGe_E4bnNWes0abbPu3mwjNaKG_fw-gPMnw5THfcfKWIJm9hLjCPA4z8EEHkIeL7VUGLTVmWe_1pxT5U87osPAll2PJzBesg>
X-ME-Proxy-Cause: dmFkZTGGDIv7UKfdrq0F0Y5ZMusWd3/oSa4L2w5TcrIRi+/tkHyPCKVbzpUd2iWFjE/Vxx
    8WD2y1OL2rZyV87G9Xs/4n79Z5KP5ybBR9lyrra1wdYkKeo6qYpWIMpPWZ/dVSPeuzNjMS
    RdJV9Y1b7bZN0S55WKRUXOFfaWFHeouFPDRlVd9kchWJx2sIaCWwQ4VXGT9dn5u1weO2yB
    qb92gmlCdwx3/C42nJk6sVaQZtpKIjLhjMofqbVbxvg7BRG64J14ZdFG/AgP7hQ2xfAWQB
    Kp3n+P8W5YJbiW1FKaTRqeY8F7INWwtx94q40Vy4NbNFSQ1Im54FdRY5O7LjZt3pYnEkpS
    r7YPcYE4ABbVJaDIyUFJUbJPgl/RVD1no2N3ljyZTktrcMEXiZsl9dUq/EchDsJB68Jh3H
    5nj9Nj3Jc7GAURYsO1lKaYhmWIZQQ/CWjTXp2ZEU/xB5P2XKKDSUwWSlpu45hX/F/yLDHi
    LAyagty2Q5TUaPwu0AqY9Arvqk7+fO646U1iyvhQbjssCdPV2U0aANYlShCC4wpLJfOYAV
    rwm2uf8bP6ggitPTRaUqM3lGqBgBXfrKaMtTjONQYVRYbCd3lz5bKvY5V86Dblo+kOMKiW
    H0anLa6jo4mpL2HzbydTTBPJuJ5HhKBNyHb6lr1mR3EmWx5RWImmqr4ie6FQ
X-ME-Proxy: <xmx:W3spao-aKY1idkfYPgwqtKo97HUB_xBi-alnNX735AtpbVqsrdRdWw>
    <xmx:W3spaprGLeMUiiGTpopxvkj1oAxs__mjXGEI77Vo4ZTqrxnXKznshA>
    <xmx:W3spav_WexpoYKMRCDv4dMmWBtbL6LwPCkapINtEDIq3iemB-tqtWQ>
    <xmx:W3spalVXjLo_7i1Atx1f0GruU1skB08yGFtyzFG4WPt17ViQeb1IHA>
    <xmx:W3spajUeCfzwCnaEVIeS7JDp_afglVO7hyJhxCHm9dSIBRgr5pMAb40J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:57:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 098fe575 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 14:57:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 16:57:10 +0200
Subject: [PATCH 4/9] refs: unregister reference stores from "chdir_notify"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-4-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
`chdir_notify_parent()`, as there is no infrastructure to unregister the
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
2.54.0.1189.g8c84645362.dirty


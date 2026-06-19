Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940E17C203
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868496; cv=none; b=HG8wXGFFKk2bBEVvADmDtyHieQBrd+sA2ovjqk/zleIJQOfCH9xed8vuy8jXvMditHGPpuOArU8xb+j2/HnmZKArK77zZ3/rOyuD1n1lEKQ+pKHI/NyjpqSitNDbtyl2sBQClR8549lOkftwV0scIrSgXWCkMA9ACjvSx1BRvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868496; c=relaxed/simple;
	bh=o8Hne0k5lgUz3Yx1uTzrpZhWzdCQcTf6ogLdy72iWAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XNg3ywdKJJeia28IRLIpJVPnXpCNqeuc04T9AQzuUNt9hunvb7eUiq1kao8TJ9n5SBnpLc9J2R4Zsp9bYgfG+WDViAN4eWoDAkVQqwh9ef4PdDM2xjxR4loG0z/1PIe65AuTqw1HO0R+wRGDz75TJ6RHfpd+sJELCC6A6iUa5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gYC+4uST; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TxHp3agb; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gYC+4uST";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TxHp3agb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E97237A015E;
	Fri, 19 Jun 2026 07:28:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 19 Jun 2026 07:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781868493;
	 x=1781954893; bh=Oq7ltuEz+dRJ3qe1GlJACeywPF5RvRVw3ij+Zy/Uhmk=; b=
	gYC+4uSTXZ73Ki7l29fuQZq1dW6dxUOPr72uNqRxjLQ+a8NY9XauaxmxlLxeFH/u
	OQ08N+ZDumbEfgOn5xWCm/v5lnZh8E8FuKdwBAmBm23/isHaiXynopkSpqqCiMpT
	E2MPzDz/apgYuzF+jUwR1FVHckaFes8d3+ffDXoeghJpw3NTR1aKK/BDTnDuP5Qq
	1EzzPVQGZLdfEivU146l1N512bBP3MWSEpkvSUt1oHUPBpT1ePkN/7laR4L4ON1y
	Wg1qd0V4MEPEppEPyFOYJdkWDYhKelSkxSeZAmOyTf+bC7fD6KPXhgV6qtZgi8KC
	vs2i6NLqf/HIotShE8bH7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781868493; x=
	1781954893; bh=Oq7ltuEz+dRJ3qe1GlJACeywPF5RvRVw3ij+Zy/Uhmk=; b=T
	xHp3agbsoaGiVtlEvCOtQ3ma3R+nLYqs/femQFLxHDDXhrRZSbXGJyXStfgBx1/b
	/24KZm4WnjOIqSco01ipS7THUDSte+wIkJvaClPOlSd63fNKNv0doSzKqtVbP0f2
	XHGsWz+3hJZQ70vQGBhd/xWbugEeEbvTnbGSlIKPCgLrVPNuAsf3mc5o9C/XYtDG
	e7LH9QPo2zoHlRwEXbSgnDRZVl8HQ1pL7iR6UuuXuHdZYosLhuurbLzFlvgTy30i
	4yrfzydv17qERhHE6BQj/CvW0dAMtfDDPwTTpqF5TvKiXoimCFl3YTK26dzXmZaC
	i4ttWqSdTCg3aHA7kftGg==
X-ME-Sender: <xms:zSc1aupKb0QdyATkrawU203mbNq_tnWiCKhJmQTWNvrxkR1ald9lEw>
    <xme:zSc1ajril3_xOOaRlp3Pv_cSlsddtxr9vmgob3ulhq1kA12qByl05TH457xsa8h01
    pRtxjr-rQCmLt7Asbg1o-u3TuxYNB8WNmvO-iM1DQkVanL7RpaWYw>
X-ME-Received: <xmr:zSc1aoN8TRBLxGcmdHDOSbPYYecWSp_yZCTeFKCb7LUVDXJxPQOdYTy9fd2ttLAzqTNnYcpu9UPM8NQRHTWdszZYCEbcOL0re3oNhsYCCe0>
X-ME-Proxy-Cause: dmFkZTEde8rkG7Ow/YQajJOxpUKYHnTWdG0AUznTDLiHmSMbSqWzB/6nKIAIdk1nkTwS0K
    C8jTqdNp1V7h/KMFCwexCiiwcxkUoPM3XGMXsNXnEqixWMufecGwaAXNpfHOfwmwhgziKB
    gEME1JUhRUF4zEWjEcolbPL4SS80OZZVhDQXhaESCZsPSITOIFAzr9mdv/wwDKbMEUglz6
    Lrw5108LV8TWN60J1S3iQg3WXtzla3Zx7Q2iJ+qofdJhYzq3vyVO5Ie87s6Y7SykEWxrmz
    /vmzMKfUyKVDBOQcXezzDDbfTiNE3Vevxi8qzYGVvv3v5UE9OxNTzNX4wxQEWsT+cwQAcv
    n7CllDfqipwJKC6bEWhADjH/HUkX/KDuJT60YLYH1mll/qaqjVEYSQOsupqjieb9yeHpex
    NoztL+c2XPJIFdRvwZ3Rt5u4bb+LaZh20KanKWM5h2xzS1vCPVfbkvoiP42j5PRM+sotG5
    Yr8F68B8jjcSKTG2rDhmNbygoCaGsc8nz5mUUSiItY9fMJ1NKORipeNvDhYLOGAc9LEeeG
    rdUCfy95M4IjtNxQB5pMmVXtsip5+u5DNaIlklJ5C7jUwgy/n643K98Hl6SLd/Ghraq5GV
    P/i+MeYgHvUvS4wquLlRGD0jrfvhbRF7xs0ZzeY6DpEdfWI8CvFgSccht1AA
X-ME-Proxy: <xmx:zSc1aszDv8pS4CYBAwDAHxVGNipkhzyMdzzPhSoRpb4H_fiiVtVv-Q>
    <xmx:zSc1apvb4LI7JIXR25aAOYPuRCfwNIzkOiyZj9ydauoM0sm_D81c4A>
    <xmx:zSc1at4QhVpZGrcxqF2amMLWLS8j4C0EIQWJhaUoNDAyc9S5yUNGjQ>
    <xmx:zSc1agS2YrAgUt9KWztq5MyMq_-obOFvCphSI35_uQ5XzRVYzzDW1Q>
    <xmx:zSc1amSIIRPCTpzGsDp4r7gSP7tciNSTJmonNbesJYIHcKohaWP5VzvK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 07:28:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca0c5ff9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 11:28:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 19 Jun 2026 13:27:52 +0200
Subject: [PATCH v4 04/10] refs: unregister reference stores from
 "chdir_notify"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-4-a6472be7acc4@pks.im>
References: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
In-Reply-To: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
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
latter.

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
2.55.0.rc1.722.g2b3ac350e6.dirty


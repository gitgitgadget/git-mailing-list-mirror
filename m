Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00F3AE190
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765691; cv=none; b=SLt25upuThx59OYQg38YpDyTrnOTTa0iNbO6mdTEcRB5s/ICX2ZBTMGtPMNADET/ARqVcV5GMrfkoDInTn1slqveJwIKQ5K5U8dEOBzhbMlpGFffPxkzG5ngqgTIprjq1wSlbFAvQFJUTeSsgChYbuW73eI8fAlgfydgTtnkDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765691; c=relaxed/simple;
	bh=VdNMuBVCOQkFoZpHKwjjUgvD8WfjHYhNGlaPWh2s8bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDVSIbZQS3nf+q3ppq96rIuJagq/53eq72L0Ccb0fADbP9KsUjJRTUFXGhRYJMQiZprrqmGg0bkAmnrh6u+cSirQlz/d5cobrOpwSdM/giP0cJBfcg1uLbMxEup2C9zy0qDPZjdUwoSU6S9Z5v0itX13KEI5bXOgCFBnvkvK0lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZirmTjfI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CnlNmhv0; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZirmTjfI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CnlNmhv0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 715F31D000CC;
	Thu, 18 Jun 2026 02:54:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 18 Jun 2026 02:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781765689;
	 x=1781852089; bh=ubBuBUZcRn0yrEvITH8uPVCBmMScjOi+t56Xe46+dIo=; b=
	ZirmTjfI/bKHY5/TUGLpumGnLbnIR986luRxieIQI1hoh/PrqaPUYkA7pBGksDKr
	EtDqlapB3NH3r8w67ybX0bfZ6NmRNdPr+rAD6GkqCbJfjK6GOkQvreny68CPwflL
	arcIVrUx32ATDrogXysgFYq3SQvwgvK6JWykdXkDhbHmy96zdbWNIONsAUkq/UIF
	EqH5QIEkjm6JRXvpWFon0QPbmhfiMw4b7pOciSl0grxg5vj1foczna/c6Ybhxr8a
	tfMzdO0G42vCtLmu/+zpk7eyzMIZkwXFLTMUsz8AFiXykvbVQh43eGprhRWBj23S
	VEFEiiISy59hTN1CYdZWCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781765689; x=
	1781852089; bh=ubBuBUZcRn0yrEvITH8uPVCBmMScjOi+t56Xe46+dIo=; b=C
	nlNmhv0Pvn7SqUl+efYlMXdoU7X/h6Q1pEWffC44yPF1exaz9DxD3Z3tN0reS0Ax
	dlNaqtvY9zoU87tyY+7Ql/YHBXBFjBf3eIpKIRWekjuAas6QHJ4WGALRKxXqtOUs
	NoTXSI92gSeDDCiNgs+v80XklPxhI9j61CfVz9xqveSE1DIKFpmBB7qo+jL/3K54
	LC/uZSJaRsjXlrVgx0q9uQOcLZHrAkvqaQSjsrERqHKG7BbYdpMzGrLKHYZOb121
	d6xIMINK1ef/VwdOxGerUzawglV1RoLz4Dst5YDZYhg6Q+UMyvQG7uTaM1rkaXLY
	G3SLDoS1WBDRX6Rh/UYhA==
X-ME-Sender: <xms:OZYzarmkFFngwKcAbqcl48iw0hT4b_7SVKn50fFVSduBDiX_xew32Q>
    <xme:OZYzal0ZgyUIRApOyNPnDW8rikg5AbQy8u34OGr11YAsh91aU5RsbF-FwlBvaPS-n
    K5hI0Sw8wYlgqLGvIpy4SvTWVOqjnXsZxSQE1y_P-uxE-vCPP15gQ>
X-ME-Received: <xmr:OZYzampoQTd0PRhvVuLqTs7DqOuitZfgASPw_RYKthorZZK_7VXwFhQufPB78wv-OsFwW29uVvEOyh6BbyXGySKz-QAxrpioLmKw-xlNkg>
X-ME-Proxy-Cause: dmFkZTFD6dk3bOvvX0yaVMjewMZkeTdhDwFjQkN7CKbrsc6RX0hrYV0S0wDnX/SLDtagvs
    OXl/+ys6J6Ef+ualX4oOCc6rpWlLgwUd+CDYp+J4f9tlVotwnOyNo/D2Ul+hiGJ2GnOpwO
    20YD1dz+jK59WSjSeqbvZIbS7LjQbwOZCvQ25fWlXFborkKwttqiF//EPtS1SKQOJhwE9p
    V3KhMGYjicitMSxnodz6t0JekyXT6bD5QV2YO0G8PEP3srRCCjxK6NZiPsNL9hezzRVkL4
    4yQ1ZKu2ng6hTy03G2N6EA5XYfWUIQofvB/33+yVj+xfadwE0sg/Gf4tc/U+tgG/YyDiTL
    IwOT23i7qVaYFLlGmwjwPPsDzQIrpSiaicw1OG1fM6ASCBo8kEvyMhsjRZ79+qxmwrZ8IT
    /aTOxNiIomSZSYfWqgHPLGFVlaKDnAo1To63bzU4i48RE09fmqHILaWpF6s+VpcEodPY1I
    vcmB7NYN789ZHDyldmxCqvIqN7Th702PieYj17QhPBWu8Imd37sowXPdOYOHZkjBPUZFeH
    yQQbgjYgaaWf/jGsJAu3+f3TZCe58urUFGIZWCv9H4Pc6NTE/JxMufyBcv6y4I3HrhNmyR
    4IGy5XvXpRquaBtUubtp2MUwozOm095L4PlDgNDPZTx3PinrhubOeS/UMNVQ
X-ME-Proxy: <xmx:OZYzaie_gFFbcY26CsSZ44PCQ6KKkPwjkoQUTDlYOmZXQZpGLDoEew>
    <xmx:OZYzalqjwxYSYV2iighiXlTcxGQoDFi3Ba1d1q9umrLfGxSS_GWADA>
    <xmx:OZYzajG3nWcKFZRQPH0AUGsEOmgeDBjVpSXV6l-QMIU7yLpm-mND5w>
    <xmx:OZYzalsZ1Lfik76DMM5gM059K7GJgfXVI9Nbq2zhICp38nyiECEolA>
    <xmx:OZYzapvuXE546L6ynEKw5U303EK5FzbCrXjZholgHyyyLLFb2um7huhv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:54:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 371effa7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:54:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Jun 2026 08:54:33 +0200
Subject: [PATCH v3 4/8] refs: unregister reference stores from
 "chdir_notify"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-4-2a5669e8f486@pks.im>
References: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
In-Reply-To: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
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
2.55.0.rc0.786.g65d90a0328.dirty


Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC83911B6
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116926; cv=none; b=aHpZLvwm5shXR72Ayu6y5KGiKLknUFD1FdK/X24vQB+hOXYoPA20mH8xC6d4+llgCrCxqC8jgik/uU1xh/o7OvukY005ju4au0sWavRB20hiHKTaEtqgYhOUVv2WoK1M4PP1Mx4XlP6g+q3Izy7MdprqAQxyyGRs2MTYjWW6dF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116926; c=relaxed/simple;
	bh=JQNTE6Xc1Uvo5K/UqIA+0c0yTqHSCa4jri0zRBZn690=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CeSit9I5anDpYVjO+amHPYa8tUIhwFlONr1oJBtefO8VJr+/NiE1vzYsn1GWfU6YFiHSW5F0q4MOWGZsAJ2CsbPyT7rHwsd3QuuzueJHQtbV2vl9avBD2+c4PBZ8PLDoBODM/GwvApkIxIbvEbEj1dq0x3R34jyUB4X7rqUNj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YoNA5lMM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pz7BqYK7; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YoNA5lMM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pz7BqYK7"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id E08721D00101;
	Mon, 22 Jun 2026 04:28:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 22 Jun 2026 04:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782116919;
	 x=1782203319; bh=ekA2OCDagNKqqnvFPoQa6aWNjylwQPPbhI19UztAZQ8=; b=
	YoNA5lMMsCtddrOvGIUjw9zzHT4gD236LOnK5vUrdsemVCo9fNcEhEwMdgdzdHML
	80QUGu5xYcJ/F1ltFt4aMyvLFuqcUGs1LuK74gs5KMb86I2jw2/C8PnDQcuPneXM
	x0pyGyNyZin11ArXdobnJJFVfmF413HLYjUnuXpZaV8bCGnSirV0vo1P5oiUsp2A
	08UDpRLALXKBTdKp3hNKk6dTPzgCES0tQzj1YSnzvpqF8AT3nyYSY4G5p3k28jpt
	wZPZOP9btlcDLd+BoAc5SRufl/jKt322X+UCa+zGn2SFQPRelBSEBmq33uZ7dyro
	IvJ181+u006QXvdw4rcEjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782116919; x=
	1782203319; bh=ekA2OCDagNKqqnvFPoQa6aWNjylwQPPbhI19UztAZQ8=; b=P
	z7BqYK7GH1AqIAd/iJAltJZkZn6ZfWHElpPY7kQCv1xyAyb6pgCsAK59Ckqs+HjQ
	LDv/A7/ZivEXT6ZItnbKQH53XLuVzrfC+uOuPASmQcvr5A48999Nn9QlLXzqrLAc
	EatvCBokWNim2Vh1spZlgl+bvYkg5EaLZWDBndQylZ1EdKR4rV/srO+stBFiWsgk
	MSb75H5cWqHVMJNE9gvw9jUFnjilOvmz+CAPzvmuqS73kvl9Lyj+ckCubsmQjL04
	CyrILLNhRNpg9TkdO+ckjp4E+rIjvtIaqtPrVhwJdjx8aOj+reS+jEOaXSKEJUt3
	ZBPpc8/fi901EC8bYdDRg==
X-ME-Sender: <xms:N_I4anGWq-ym-gRcqant70zg8uujjIqKQNSuP_PH7CiC4qnVNCgqsQ>
    <xme:N_I4arVUk__CbMasvg9KR7Xv34Uo0c0mK1OJaX9YVpMp6uKIwoDmz80AC-gO4RW_k
    iWOzFqL0JHwdNmx6jCf4RfmN9OC1wphYhZp6A0rZr4TPyAtkBpduWE>
X-ME-Received: <xmr:N_I4auK8m6obD_EuMeu68kLvJC9ee9uzpmlsxfzynukS0Qoy8HA2tWTDfhIIcQHeJHE3JWfB9bB6L8fRjdv8KV7m_v1-4em-7Qraqemb_Q>
X-ME-Proxy-Cause: dmFkZTFGuvhk19wP1nIdECGxwx3gbsw2ufEFYPW/bcryZRaeS0zP3zRO2BkgCLVXG+HRAu
    eDSJo9XC9+oh3Bg4ZRtWUyrhjPNmJp3YOJHUnxHZF9fRZrG2CDlLXQ1vIYWsZ6wE8vVEag
    zy9G92nuZEbjKcNWm4jg58++glxCpMiBCJ8FdiujUMh3AT0f9M3NX3x4YMlYXDCGdPE5Jo
    sF+G7mjGMycHN/Ao7CZBomtDY3FTUdRjzmq4savyltQeIxi4PefUj35UFTgtSExhYooKOd
    zIHDBAiAvQ1kUkDPooo/KXMo5cdMPFyZNxi4JoyhlbXctSkAgq/pHTp6e/bmoS79cQ0An/
    ERKrZCcvMqOROGixi7QJtXCQjWSxnsijmNV5DuWDuvBqx4ooi07V+p73T54p8KBOVxJGta
    cJKDZRaqy8w7Iji9itNttjmT0VllwCYZvuhWgDYAo5rwVeBwkGuO6XVRcRFVhmFFHznLDm
    foVSTnDlFVwS7ffp16p8DrR0lRoErwybhnU8HZxDn7geXS7t2R1kTIH9miM0mpZT5Z4Vuf
    y3eOwBunLncqIEJqQ+4CgGk/sQY5byyYWDyaloBzoGzxLtogDWYoONvrsTM3OJB41b1JLC
    ZgtZOYwZmQBquLOJI61tVAfucpG6Acrgy5fTQyto+T/6zfGD6+CgIDcwMgvw
X-ME-Proxy: <xmx:N_I4aj-GeoXVOR-E644cRIb-1IxFk6hDZiSydcMQ2sRgZnaqfS9EFA>
    <xmx:N_I4apL4HPuHTid3VE0OrHKMKPzRLRJd2aEIXaiSrLdTCsvJ3kLu9w>
    <xmx:N_I4aglQ1wOM_PshROoRPdcic_e7-SrkfPmlAoI_sNr2I5kBBxtaPw>
    <xmx:N_I4alM9zDIRE0bYLLf-_QXXSkoH6YNPJTM8gXHc0mfmkbH67NE7sg>
    <xmx:N_I4apNRuDCPStmjJ2PONG-_M4QA7DwpN5Fn-8h3oFJ3YDSmVxRKv7RX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:28:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 88f0453f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:28:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:28:26 +0200
Subject: [PATCH v5 04/11] refs: unregister reference stores from
 "chdir_notify"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-4-018475013dbc@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
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
2.55.0.rc1.745.g43192e7977.dirty


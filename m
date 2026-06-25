Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0EA3769EF
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379222; cv=none; b=Osr5NBec8XBZapGAx0gqSuhF3V0dsaG58pzg5sX4eL2IkVffTeGdK3eRzdHiNl7CxMUoB6OaYk6qGzcUERDx2KeBeWaWI61V9i7h8g6nBfZ+dJOaRosdOLQlX+ZlWpK5GsMkCI2qYAEq6v1wBJD4Ttis38cyVhjLSbqPjWmlrd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379222; c=relaxed/simple;
	bh=JQNTE6Xc1Uvo5K/UqIA+0c0yTqHSCa4jri0zRBZn690=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1MLKTAAbhgchCP3ygqlHMwTpZ/hZV4KDdCJ11HXYNHNkrTC49JUSTe5u0c4HwtzPcAHME/72kTF7lA+miPfMdKS3bY9gNfPtuhOZYPtoez/5KuJwX95HVj4+vh3SfjD6zrwV5KuQzjTujKb+96gfWnmk9fgiWtVbMO6cKZEb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jsRveAdr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UANeFu+p; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jsRveAdr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UANeFu+p"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EFB061D0012D;
	Thu, 25 Jun 2026 05:20:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 25 Jun 2026 05:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782379219;
	 x=1782465619; bh=ekA2OCDagNKqqnvFPoQa6aWNjylwQPPbhI19UztAZQ8=; b=
	jsRveAdrfuVwzjlFXXl+KIwydLta/Ue5wguhfSVaOZ6/Kr7RRK/gsZ9aZSjR0QGq
	sLsJ2DkTDYI90z2pq8WYMT+xAuSbmVkcSaWTtniE/d0bL4LwZ8ofmSwFirZJSWwQ
	HL7ASH1jnGQCrzz7+D+8uzORWzNXYWy38Zz2FeHN6rLslnny6MLIWs2yRkppi/X2
	mhepF2stuseahTl8wDnIbcW4Z0OrfwEEAgr1VIYjMVL9j8070eIClO2d6Ln+QJaM
	YW67K4eUVQeke11MxehtJu/DF8J0tVEMeinhmcdovuQmL0CqCmCRyuwy4F+U2GAP
	x4EaBd1yhjOUDQXUFKlkFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782379219; x=
	1782465619; bh=ekA2OCDagNKqqnvFPoQa6aWNjylwQPPbhI19UztAZQ8=; b=U
	ANeFu+p+ebpQbiydHbhaK/lzOKV93O25aAT8RvCaEoBak0KruF+10qeWV3m0tVfx
	RtspJkaZX4JGLJUZ2TTRUIKm9pviHdxNjZTIpRLki4ihTzq2LGtNI7/P48ZfCtZ9
	CrJbH29h6TgUDN9knsOWuThH9MDU8UcTHVlADyH7pz0Zf+LYNE/r6itjPUDnqUCx
	/MC1cHbnbShEgMtVRIbCJgC6Yq9ILvB+ubaJGSm/V3kNMjBEzxJ4rEj40LQZ//PX
	OBz6YDTtl9AxN97T1a9BZgbOLKhYdHfLy7o7dOWScMwZbkNz6cZcCzS125EqsfDZ
	zPrGMOhr4gpTlKiExNcvA==
X-ME-Sender: <xms:0_I8am5zIRIE5edpeQEtIYPOBVSkagkM5OfVx1UDgWFCD9V1WFzMPg>
    <xme:0_I8am66ifZM2Hxu1sUu1FsbW2ysYA4QDFLhg-XJ_FxIGCA4Et2Y_51JLOon4Ywq-
    7kVr1X4N46oxVJxKlHqF5GbSsY-4o0EFN_yZPd2rGKcWmOqim-uke4>
X-ME-Received: <xmr:0_I8aqdCdWVN1tIsgmWqB13bfEAQn6F3SvnXUFo7BhSNMPIobSce1ZR90FaR_NKiRQ9GgztwUeGZeksbhqxNssSuZjIXZOe31vfnXYpSqw>
X-ME-Proxy-Cause: dmFkZTFJny8F8bT1vobP8mT/gHA8dRfG54tdLYssF9mGrBAZ33fvzfK1eqPxa29sDtYAhN
    5tkjpw8eG7f8oUYXwWxFvXTfK5hurMwltmfD04NzD/ZqkQDnNm5LG5e+36110BPFzMSHq2
    HQfiw4sPCG9XizI+bbWfQ70k6NFeQGil+Q4g9AnIT5X8yKcTuUqmWhXByog3KGvZ/ni4kX
    k9V/L/9g4/bQonvKK8Brc7cK3ZOQt+0LqTZPmn4ByHyhrpuP3EGvOEGRCSWZpe6rchkvz9
    cVZP4E7MkYqSCORu71W7wFgpoNuZR9ZptCacni39b4NdZsabOObv28iAAOaljK7R002QnQ
    0nXkImkqyCqzCq8/c00RENa3oOu1QtPocObPf54cROk4xeZW70qQOAi/y5gGQUJvFcn0uO
    ZiVPHBqSN9M4lgzwh39vuBrp++WKNOih3ujwgLtakGb9LrRH4HVb1Dik0UiSTFGW7g1D0E
    0ON3Becvdmkd9n7N4Mg7rju0pAC0LP+huzSWmWCDrUxXbIGnDH46y7Jy/tE27CuJ4s8q05
    85R7uSlVFXySCDyb4iM96nHWSCbbl8ANKQ3I1GCx0jQ6qaeT8eJqt13Pl9U/GoEbiB6bgr
    r976Y15QvDNJ1G5XIZdFDjAkENBJK2QdBx1Z1PtdQPl53qoQkITnVNVua4IA
X-ME-Proxy: <xmx:0_I8aiB546lIIsLxOfVaO7nweRMusJXg7yAWgtcKIWuHPYl2ynyefA>
    <xmx:0_I8al-IbsuQH9h2TLYLupaMQkKrVBDm0jZoKIFrQcnaGSi2PzsdOA>
    <xmx:0_I8alK4v1S-WOdEtnsrXUTaHcDfPCglBRWoOjG0a0kAHdJeQjC3kg>
    <xmx:0_I8amg6vuSmNvdzfpbEcioNrAR0B8FF9OdJXBP5EfDl4FcnN77Oig>
    <xmx:0_I8akg5Pc2MwDJMOesy8Bd64kwUUzZjeHQn7u2y1OhFfptxh5IZrZks>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:20:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d8cb1258 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:20:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:20:02 +0200
Subject: [PATCH v6 04/11] refs: unregister reference stores from
 "chdir_notify"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-4-41fbca3cf5e3@pks.im>
References: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
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


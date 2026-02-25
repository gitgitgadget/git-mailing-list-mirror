Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466138E5FE
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012456; cv=none; b=BqVFkf/DMGG1xXKJgDx+RkakxQboPIGRdjl/80gM6dZ32/c5j68PI6ww0cTcXQl6GuuvseLl0DsqHLZbwwg6Khr/uMykjiFwsVRb5SqUp2+4OqsUCKY++bm/v8WSfWEFxWvuq5zgbppZ89gBIcY7ihycZDyTPoR20GPSQ4JVUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012456; c=relaxed/simple;
	bh=bZ4zrrDYIZw/gyYEroTfqbNh5AdrRKpgvwz4PRqOOdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mi883d+mEOwVoPLJkMDEukmymLZNxHE4G6XRy65r4N2aM2a6McOfvfYIoE+/ZBPl7e+0QRyd1pSkLWQ/3q2qpzj1cIGDUMT3DasD/BxTQoocM/vm2O6Q6q7qWaDq+Zd21ioo+0ZPcegRongSxs9vc9Xv5Mbx0If6UIj0qvYd6Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUmb9dpS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUmb9dpS"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso48871095e9.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 01:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772012453; x=1772617253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+HQWXFMY9Nw55DE4pAOrhAwh5K1L61OBKbGwXEobnc=;
        b=DUmb9dpSz0xizBknCQuWCSW2jmKba5fNmevtEL+ZdtWmnhJHdxlep7MXgmad0YIkd1
         MUMTVzORq2aeOujSKmwIGXF3/AVve0PzkYkRC7QNz4RO+T5aNyXwbmkDeLh766XSNwr8
         fsWoTSEEVM0QmuyzAqh96obzy943DZw/EKx/5Ijw7d0SpiKpUVwtLyOE5xYa2fuuWD6u
         dVr29OpnLn6py9sCpXAUZhBWDh2wRJHAEYG/F5Hm4XCUjk8IzjTxC/dgZcur6g3g9cUR
         JA82eACSEa8D5j9y5UECOwlvL7HuJ+2VhirKOJVGXCS4yQlg5PPcBKaypnXbry/aSq/q
         fQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012453; x=1772617253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e+HQWXFMY9Nw55DE4pAOrhAwh5K1L61OBKbGwXEobnc=;
        b=cigk6oDIzPapL21eSKjIamS6T4CorWrYq1MgypOweViddf6Srbv06IZF2/FJtJ4Mur
         8zvTZlV5ROmaCasLHagYzkQJbkWxCLCEYNmIKI1DRY2hMzBQYfC6m5RIMyrmLIICTHuU
         sbK/BS6JHG6YxkAFNpbV04ehgB1OXK3n4jEhUv7H4nn7gjJ8gUm2IrZewHyaPZFx8fyg
         HKs++PagW/Dri7hH7w/psUF7Z4QgW4pT8O+3kssFrIvRU8HUTrK/f78f0531q4Wk0jdn
         R5c/yTms2aG6NdnlykAaQ1VjKD8Jf5ca4HfaATfEV0/i57Ioevsf6XuCuS/OmYlSmup5
         VNuA==
X-Gm-Message-State: AOJu0YxQZ4lPHMWGPjBNxegQDDktkukSQLPeo56XKiGwUG3AK4bK5wr4
	GclmrIiveLMTnYrq7uyqE6dZWF9M1gYuiPMWGAnbIeTYMfOGxHMaMuI9
X-Gm-Gg: ATEYQzwWTIS57XN1B70l8kpCEGZ4g4PQUntkfDLXcx8VJuyePxjS7EOA8pwMHauXm7Z
	ZjIR3BGHvfZ3+qbS4clhNHe2cETyjwHd1fqmsAaBTlbq3MZeuUIsiM61eDnA3rz5hM2SpjgRa3v
	/qSkiaffppaUhsEpGZl0/fBaiBk+tR30+7awmYEllBtHJgbfJrNe40QyGJJ4CWfcxt+8AOLnZA8
	yonMPrePWv1iIfyHYz/Rn0ev/Ym4oShgm2Vd0ki9VCnR3sI4MpXC6HlamzIlLKiwdbDIFserqkr
	bdnVJhIj6eSK49GYJz4nV4gM3io1e/rFbJlue8IjnvDOkGO7vEL3tc2HdigABqSdkL+US55sUxe
	4C0Ohe14hZ7ffa+KUa/ai1IGvvHzmO6jU7hEZDpAnZWd3KBG7dBM5fa7rl9jmhXQgx3X/OLP/us
	RSpOpnFuRdxEAJRw7U3GbYPSo6U0dtkMs=
X-Received: by 2002:a05:600c:4f95:b0:483:8e43:6def with SMTP id 5b1f17b1804b1-483a95e5a97mr231219425e9.28.1772012453006;
        Wed, 25 Feb 2026 01:40:53 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d32e:ae2b:c73c:65c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bffc17dasm12956025e9.2.2026.02.25.01.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:40:51 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 25 Feb 2026 10:40:44 +0100
Subject: [PATCH v9 4/6] refs: receive and use the reference storage payload
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-kn-alternate-ref-dir-v9-4-3fe118e40e28@gmail.com>
References: <20260225-kn-alternate-ref-dir-v9-0-3fe118e40e28@gmail.com>
In-Reply-To: <20260225-kn-alternate-ref-dir-v9-0-3fe118e40e28@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9635; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=bZ4zrrDYIZw/gyYEroTfqbNh5AdrRKpgvwz4PRqOOdg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmew5zkBegdiFyDIgmDveTa+dN5MoQgVvVup
 9wWaHiph0AbEokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpnsOcAAoJED7VnySO
 Rox/OawL/i2mL/bLWr32TrHLI7zQrvF8bh+g6L4GhKS5Nn7ft1exc6Q63m5hlg5A3EJNd3y/QQX
 rI6ohrQ8HSdHuQicSm7AzlcwR9LFyFmJJ0l14UScOUDLHEQy+GT+gfyWgY+BgRn7kPvIBmyXejv
 g0H2vBWvPdj3XIUZcDCYERd77ZD7vfn7uaI+B9t6RXgP9nJM1vjveSs4lpJuuksl9bhBBsIwxKX
 L3FQru2vvWAT9C0Ko50gSu2mwQ9+JvqmT0CZk1G9RpYaIJ5n7WMEZV2oi3EtyjsHdKJlEY6XnbJ
 pkHgavPvx1t8bsnMU2TKjc6OEu51Mt/5D0cz1vMspcOeQqac4dBJcTWROLycSY+lK9Rdj44XRTg
 f2HX+LaMw0MlnmFY0Ik6fmjgF14PuhEL5PBZggu0BYjIfLhSrBdXnDF7wGBF8Ox/ne9p8ZJtSdK
 theQ0ldA8Xsf0WyEHgp2MNxR9EY23RWc5+Jc9t/M+585AVln15XkkeFNFNROIUbHqkkRKmNv7M5
 LQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

An upcoming commit will add support for providing an URI via the
'extensions.refStorage' config. The URI will contain the reference
backend and a corresponding payload. The payload can be then used for
providing an alternate locations for the reference backend.

To prepare for this, modify the existing backends to accept such an
argument when initializing via the 'init()' function. Both the files
and reftable backends will parse the information to be filesystem paths
to store references. Given that no callers pass any payload yet this is
essentially a no-op change for now.

To enable this, provide a 'refs_compute_filesystem_location()' function
which will parse the current 'gitdir' and the 'payload' to provide the
final reference directory and common reference directory (if working in
a linked worktree).

The documentation and tests will be added alongside the extension of the
config variable.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 40 +++++++++++++++++++++++++++++++++++++++-
 refs/files-backend.c    | 17 ++++++++++++-----
 refs/packed-backend.c   |  5 +++++
 refs/packed-backend.h   |  1 +
 refs/refs-internal.h    | 14 ++++++++++++++
 refs/reftable-backend.c | 24 ++++++++++++++----------
 6 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index c83af63dc5..ba2573eb7a 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "advice.h"
 #include "config.h"
 #include "environment.h"
@@ -2290,7 +2291,7 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	if (!be)
 		BUG("reference backend is unknown");
 
-	refs = be->init(repo, gitdir, flags);
+	refs = be->init(repo, NULL, gitdir, flags);
 	return refs;
 }
 
@@ -3468,3 +3469,40 @@ const char *ref_transaction_error_msg(enum ref_transaction_error err)
 		return "unknown failure";
 	}
 }
+
+void refs_compute_filesystem_location(const char *gitdir, const char *payload,
+				      bool *is_worktree, struct strbuf *refdir,
+				      struct strbuf *ref_common_dir)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
+
+	if (!payload) {
+		/*
+		 * We can use the 'gitdir' as the 'refdir' without appending the
+		 * worktree path, as the 'gitdir' here is already the worktree
+		 * path and is different from 'commondir' denoted by 'ref_common_dir'.
+		 */
+		strbuf_addstr(refdir, gitdir);
+		return;
+	}
+
+	if (!is_absolute_path(payload)) {
+		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
+		strbuf_realpath(ref_common_dir, sb.buf, 1);
+	} else {
+		strbuf_realpath(ref_common_dir, payload, 1);
+	}
+
+	strbuf_addbuf(refdir, ref_common_dir);
+
+	if (*is_worktree) {
+		const char *wt_id = strrchr(gitdir, '/');
+		if (!wt_id)
+			BUG("worktree path does not contain slash");
+		strbuf_addf(refdir, "/worktrees/%s", wt_id + 1);
+	}
+
+	strbuf_release(&sb);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d3f6423261..9cde3ba724 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -106,19 +106,24 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
  * set of caches.
  */
 static struct ref_store *files_ref_store_init(struct repository *repo,
+					      const char *payload,
 					      const char *gitdir,
 					      unsigned int flags)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
-	struct strbuf sb = STRBUF_INIT;
+	struct strbuf ref_common_dir = STRBUF_INIT;
+	struct strbuf refdir = STRBUF_INIT;
+	bool is_worktree;
+
+	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
+					 &ref_common_dir);
 
-	base_ref_store_init(ref_store, repo, gitdir, &refs_be_files);
+	base_ref_store_init(ref_store, repo, refdir.buf, &refs_be_files);
 	refs->store_flags = flags;
-	get_common_dir_noenv(&sb, gitdir);
-	refs->gitcommondir = strbuf_detach(&sb, NULL);
+	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
 	refs->packed_ref_store =
-		packed_ref_store_init(repo, refs->gitcommondir, flags);
+		packed_ref_store_init(repo, NULL, refs->gitcommondir, flags);
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
 	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
@@ -126,6 +131,8 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
 			      &refs->gitcommondir);
 
+	strbuf_release(&refdir);
+
 	return ref_store;
 }
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4ea0c12299..e7bb9f10f9 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -211,7 +211,12 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
 	return snapshot->refs->base.repo->hash_algo->hexsz;
 }
 
+/*
+ * Since packed-refs is only stored in the common dir, don't parse the
+ * payload and rely on the files-backend to set 'gitdir' correctly.
+ */
 struct ref_store *packed_ref_store_init(struct repository *repo,
+					const char *payload UNUSED,
 					const char *gitdir,
 					unsigned int store_flags)
 {
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 9481d5e7c2..2c2377a356 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -14,6 +14,7 @@ struct ref_transaction;
  */
 
 struct ref_store *packed_ref_store_init(struct repository *repo,
+					const char *payload,
 					const char *gitdir,
 					unsigned int store_flags);
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7d2a6e50b..4fb8fdb872 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -389,6 +389,7 @@ struct ref_store;
  * the ref_store and to record the ref_store for later lookup.
  */
 typedef struct ref_store *ref_store_init_fn(struct repository *repo,
+					    const char *payload,
 					    const char *gitdir,
 					    unsigned int flags);
 /*
@@ -666,4 +667,17 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 					  unsigned int initial_transaction,
 					  struct strbuf *err);
 
+/*
+ * Given a gitdir and the reference storage payload provided, retrieve the
+ * 'refdir' and 'ref_common_dir'. The former is where references should be
+ * stored for the current worktree, the latter is the common reference
+ * directory if working with a linked worktree. If working with the main
+ * worktree, both values will be the same.
+ *
+ * This is used by backends that store references in the repository directly.
+ */
+void refs_compute_filesystem_location(const char *gitdir, const char *payload,
+				      bool *is_worktree, struct strbuf *refdir,
+				      struct strbuf *ref_common_dir);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6ce7f9bb8e..0e220d6bb5 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -372,18 +372,24 @@ static int reftable_be_fsync(int fd)
 }
 
 static struct ref_store *reftable_be_init(struct repository *repo,
+					  const char *payload,
 					  const char *gitdir,
 					  unsigned int store_flags)
 {
 	struct reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct strbuf ref_common_dir = STRBUF_INIT;
+	struct strbuf refdir = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
-	int is_worktree;
+	bool is_worktree;
 	mode_t mask;
 
 	mask = umask(0);
 	umask(mask);
 
-	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
+	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
+					 &ref_common_dir);
+
+	base_ref_store_init(&refs->base, repo, refdir.buf, &refs_be_reftable);
 	strmap_init(&refs->worktree_backends);
 	refs->store_flags = store_flags;
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
@@ -419,14 +425,11 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	/*
 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
 	 * This stack contains both the shared and the main worktree refs.
-	 *
-	 * Note that we don't try to resolve the path in case we have a
-	 * worktree because `get_common_dir_noenv()` already does it for us.
 	 */
-	is_worktree = get_common_dir_noenv(&path, gitdir);
+	strbuf_addbuf(&path, &ref_common_dir);
 	if (!is_worktree) {
 		strbuf_reset(&path);
-		strbuf_realpath(&path, gitdir, 0);
+		strbuf_realpath(&path, ref_common_dir.buf, 0);
 	}
 	strbuf_addstr(&path, "/reftable");
 	refs->err = reftable_backend_init(&refs->main_backend, path.buf,
@@ -443,10 +446,9 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	 * do it efficiently.
 	 */
 	if (is_worktree) {
-		strbuf_reset(&path);
-		strbuf_addf(&path, "%s/reftable", gitdir);
+		strbuf_addstr(&refdir, "/reftable");
 
-		refs->err = reftable_backend_init(&refs->worktree_backend, path.buf,
+		refs->err = reftable_backend_init(&refs->worktree_backend, refdir.buf,
 						  &refs->write_options);
 		if (refs->err)
 			goto done;
@@ -456,6 +458,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 
 done:
 	assert(refs->err != REFTABLE_API_ERROR);
+	strbuf_release(&ref_common_dir);
+	strbuf_release(&refdir);
 	strbuf_release(&path);
 	return &refs->base;
 }

-- 
2.53.GIT


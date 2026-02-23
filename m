Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D329034D3AD
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833712; cv=none; b=l09bCfvsJKNM3rcv7eDDgv4r2XFOVsFEpgfa8P49FPv7CyDwKTHywuo9dDeltVaEf/6pUhoWMMSHXPVPIdUISC0hqznrm/PcIgR8WV3uleGBgBdW2DOJuggYYNvNPpDwsMzzNPsbTdA1I7GUU+kxB7UncixDzoc/h1ONM7+J7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833712; c=relaxed/simple;
	bh=bZ4zrrDYIZw/gyYEroTfqbNh5AdrRKpgvwz4PRqOOdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMFyO9MoinonoP1GywJsdbKm8G3MLI9Tj4IohMsv8RLuGDnX2PF+JHQDI9iQwts0DRlgWGkij5UOgWUR5ZEuwEob8grqynpTx0J9f07Kuz39J/0nnflYi8f69GB5ATNNlbNbn9s398shmz7w8HTBxXkGL5D0XiWrgVckQl3Ztlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiMUYRnG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiMUYRnG"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48375f1defeso28095075e9.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 00:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771833709; x=1772438509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+HQWXFMY9Nw55DE4pAOrhAwh5K1L61OBKbGwXEobnc=;
        b=YiMUYRnGeqfs26SkJsJsD9w8BSUQc8m757kfsr/dfehumiM8z+1xapXi5RkjkAAVKp
         0KydLpSSfEYF8Nc6jYRnPNWe/7S7NMHQpoPRWz8n0dvh81+nK0gKp2V1tY6CKFy2mwWW
         zWh34NpJPnNG8hzPGLujpk8hustFL5f77BzqHceT8Dsky+n9x7XG6ZBehyJOokVFK+qm
         DaWIyOkd59k8SBzunNfvNAA5IxCgIXwxUUNmMdbpC0FkgOH4Q+xejMXTFTjTOh1I4BlP
         UjZFuedSipPVCBPdUi+h5RmD7lTBai4nPT/3ULU59FfEIehYSv/jtDyP/vKnwRqVgsvR
         q+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771833709; x=1772438509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e+HQWXFMY9Nw55DE4pAOrhAwh5K1L61OBKbGwXEobnc=;
        b=hu1x0f4G/VicKwBg24LQUYsvqZmGWdiY6cFWy9c+S326uKxo/DjOZz+w3cur97LOg1
         aE9zpOZW7mp/RUgYkkmLfHHlMIso42C2gT843P8YD2VaRsJznAARGw4YXtUnItm7A3NE
         O4Uyej9E4iwS/xT4vsBrRLoEQSqExoei4cLWwxnj7Wys5RtsNFBjrth3Uag7tUy6VV6+
         ASCHU2G9Fxy0MqBDpdirqaMOvo4Jsb+GuWbWXlz6r7heTyUF5K0b83Oe80ByxQbhw6tB
         9s0YQNgCBiC41Wd6HkVtrQ5bZZpG7j9ZL9445Wbv52shYfpXATXx/DVQdwVDYA8oG3Nt
         DvbA==
X-Gm-Message-State: AOJu0YziShByRQvYJuBaqk5z8tMRg/ID7ovUKg2FbyySO/0PA9jUh7kT
	LaE2eQ+z8iAsWSbKNprRvyMWYFznylvjHb8lsalyfFMczznyEWMLT79O
X-Gm-Gg: AZuq6aLhbXmUOtfh3N2DdPtVrf298M3yd44U0BxU0wDw9Zdn868FIs52+/1UR8CUAd9
	wmea+NnueurCMOSvA/vTc1gagTgv/EgV88yNzpoJn+2RGyObV6bhqd85UfwaXJsGxX9+Rq+g2Fw
	8UKMjwUtus0BKy3bHi2jNzExcqzvOLh40p1mkmu/K/aetzondcpS4RRtlsqhKo/VpBDDN6oXDir
	6xEeK9swDI5uMwXt4C3e6YbzP+JDSBP2cFELLddDpg5SVHX9I8WCfKeZtAfMw5ntSgGZz1hjdbj
	BClys6TiMrW1C9XeRBH1eQCchOkZiQvooYmfuUDzLgh0hsUG8oFhwxPusD64hRcFI55/bJhNG/S
	sqhxCsVe1xmDFMCtQIQbwevdglwT2LvoMH3KZIOoxu04JPJSiP/s0IXWYpjJRFPEzCp+y71yfpz
	KxjadajHRk99KOEiCloR5epgOn9KN3caU=
X-Received: by 2002:a05:600c:8708:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-483a963d62amr106339035e9.32.1771833708997;
        Mon, 23 Feb 2026 00:01:48 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:f529:6f94:a480:7bd4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3db3369sm117333775e9.0.2026.02.23.00.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:01:47 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 23 Feb 2026 09:01:39 +0100
Subject: [PATCH v8 4/6] refs: receive and use the reference storage payload
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-kn-alternate-ref-dir-v8-4-0509c132a203@gmail.com>
References: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
In-Reply-To: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9635; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=bZ4zrrDYIZw/gyYEroTfqbNh5AdrRKpgvwz4PRqOOdg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmcCWe4PXog4YVTDYFJ8sYTFXo3M5/zRMU8s
 M9YQuhsvks04YkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpnAlnAAoJED7VnySO
 Rox/NoQL/j7p+qDtIKkm4H5wnMFCFnKPs8rOLdQdCwnLheyrnSzoRbsEcQuxINhtXvsETg7hyk3
 RtuZT22sirLumo3DcC146n8QemeHrpaXvIdDFen2e8PUYek8u5UZSaF5qXi3ueVD7EyzU0WaL6G
 t5K3MLRq61tXCIX+7uVPxQCPGrM6VTFArfZWissjsdOGaDtLaYsOsz/ykXEM8ORdQwe/ItGqiWj
 m6M1psXh2WFjSrgx5d26628dOdMGQT2LGRtc79W3F7Rin/6OkodbdiZ8S/zVM8pHWqOXs6wm8M0
 NtKAj02gVyyV4QYyfgDA41CgolBW5yT54wxbrycGyANiecKNcBZ2VSkurEOXy+iLamVT39XhTWi
 Ia/f//fRyAneQdCYjAXjdCafwJx3zdo6O7+77E9SJotBL/8hpDvEdd8VODp3tlt/2aOQqux+KEo
 LYh9X+mzhC+UgS07UHjfcJ24MGAmYe9FNX6b4HzhkfD3SSdWEnMhDGvpPWKFvLjlplG0eIOUhu6
 VI=
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


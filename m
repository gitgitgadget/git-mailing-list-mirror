Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8B4F881
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771108472; cv=none; b=apfn5UNcFSnfsNCFdclPFNMnI4okOn6qcxFKPcOqILY4LK71r+VYhqrwfp8iJMjZ10Nda706AgBSTOztZsQtKrl3lP1iXQPuYrrw2RA8W7gnrm3S5uvBE6WnR1VaObi9lN5viyR0mYDU+X6q+tXZ7Ttk18aNasgo13pYdsPBvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771108472; c=relaxed/simple;
	bh=N4FyRsSxjNv3phqz8NEu+M4j4+VdYHlOKKQAQBP/i8Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=bfTu6sgSIDsEgaI63BjhEKZJRXEEaTMsA0PGQ98ekh/mOdJtP4Fzov4broVRV+4utf8IDUDh2sS/zDjrs/aGEJJt+CcMkczm6nkzRSoDlnplPPYg6vBZ/RXuU5UALXmHJ26n9JHwRjnacxhZLYAuyvWwgulS5FYDaHoW8cbish8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyF1OegL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyF1OegL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4837907f535so8701145e9.3
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 14:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771108469; x=1771713269; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yosn4DEvY4U4EQA/7jLQtkW5WdTeCFrmTuAZAtJ3mEI=;
        b=IyF1OegL0TOfKipXkIvdERNpna/h/pKO4w5TQh85CSESlphe56ytwrgxRNGIP7ALX1
         3+BTBG2wTz9/fX/SMseC+OBhidkYm6aIUzy7nC+bxP8K+WtpQzUl269jUkmPW/jwphkR
         SBmZfrNKAtkjdt+G4V5YfzjNTHEF5fw8a8Q7eV/1txDpHNcat0qskx0gmK4P11ZntzSl
         lbA2yECetE+08T+U00Q4zAPareSh4jUAAKf998ruRT4bPcSiY9hNilk3LMQT4agEJgh/
         oLzNgCLvD5W5oSxl/4nvrazTg7xctgEeeism6kNgYYmfMcsDfrHvT6Q1RQJQFpYfGM0Z
         kr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771108469; x=1771713269;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yosn4DEvY4U4EQA/7jLQtkW5WdTeCFrmTuAZAtJ3mEI=;
        b=qSzH91AHpCVvVuJSZk9MhzC7TXuENgMMm4ecYGTC+XsF/0K4aFR1VeeES++CNrOxFO
         YKqzp5dojz7mRHbnapMoDi2+r4jfbesC3KM3z7htBzaU4rt7/2DtgXEF3dP7W0nKzgyG
         guicbtbizWsCn3NeWFq7B1dlQEdbgNaB228E6275Yhv+RYDQE28/2GQAuuHRf4RQFH2h
         jjDhxu1vSSE+FmIMKYTNTUGWR4E5d8o0rBR7OxUg4iyZQVIjIK0ryne0rafplsRmzWW2
         +obOgWDiCkTT0KGWcVVKrwFB+chV2iEYYUQZwRF69CWN4qrLxYbvKGj8M1nDSyTpI4pV
         V3EQ==
X-Gm-Message-State: AOJu0YykPLPTmBt/WVCNTVX5h5Eta53pLvzo15wQac0q2QUg+KjVvlao
	vl2BFTII4a7NxcX8nhoFdY+0GN4aJUvVw0pi9JdV1UvG+DTTPkBPGHfh
X-Gm-Gg: AZuq6aJdn0blLOZVer7bCcjsbdN6i2QXy+xp3UcodD2rhhpmBs+WlRgzyDLURQkv6EE
	EkiEWQ14vFYAr6xkBXp8goChQBKzi32LVwlgZ/wY36WNlcisTQL4oQW+4B3jO0knY0qYX73ImhT
	K10kFlnga8d45vNjP3sTvX/8prGGGVv+k2SH0pZgpdZk776DiYcJbuESZNMWsbiCzpFrWmD8GaQ
	fTSz2w8e2hT7OCPzZPOfk16LfwVxvB03kDGNZe44qw6UfdQsbrQRRs3EdguoAUE9jUYbcTRJ0JL
	TDqaWWTyo3k7zjmpZx1T8m+85hL8zPiSLj2FubEtiCxfd4W4y/GcSaU582NXBEyk/6BDgobAQ0B
	hlp5j5utlIqwd/v7B5zTSglb951H2G9sRaub33PxAiD8qdqaMUb/P1GmyecnFGdlqpiu+3NfNwy
	1Of2Ct3nZP0xyBfm+iOHSSXlHuodz0bTA=
X-Received: by 2002:a05:600c:3e0d:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-48379be7576mr55257875e9.31.1771108468463;
        Sat, 14 Feb 2026 14:34:28 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:ffee:e476:e6e4:b574])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837e565f5esm83591645e9.10.2026.02.14.14.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 14:34:27 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 0/6] refs: allow setting the reference directory
Date: Sat, 14 Feb 2026 23:34:13 +0100
Message-Id: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGX4kGkC/3XQ22rDMAwG4Fcpvp6L5VPtXvU9Ri9sR27N2qQ4I
 ayUvPvUsrIQFjCCX0KfwA/WYy3Ys/3mwSqOpS9dS8F+bFg6h/aEvDSUmRTSAAjDv1oeLgPWNgz
 IK2belMoVmp1ElxqBmdHqjQbl+8V+HimfSz909f66MsKz+wuC/x8cgQuuU9bB6+QiNofTNZTLN
 nVX9gRHOUOkXUEkIS76bDO4bJVZIuoPkQJWEEVIAohe25hkDktEvxErqKwgmhAVldD0AFAtETN
 H1v7EELLTwnnvlE4Y58g0TT+CVdqFzAEAAA==
X-Change-ID: 20251105-kn-alternate-ref-dir-3e572e8cd0ef
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, gitster@pobox.com, 
 ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=29981;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=N4FyRsSxjNv3phqz8NEu+M4j4+VdYHlOKKQAQBP/i8Q=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmQ+HLkuAinnADepPJfz/iYIM+LfM7VYHAqz
 akE+4YpcccGN4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpkPhyAAoJED7VnySO
 Rox/R3IL/3wcEvgQ65vtz2a0Y1Ze2U6zkSWvRfOCsfDI8LwVXHbK5fJIaz7nmMC8/iv0jN2s4ph
 GThLcp87Nc7iD6EPQhH/mRZBTWHx19ovntajtIV46vonoHEwMK26+xgrIY98btw7sb4uAr+zA98
 T0k/mMNZSEigGv9ZLu8ht0ArO4Y90HGcHs9TuCOIj9HJnWga2xQQvMpNKi1kbVmSOYwvkiLDx0o
 bXcmDzM45O7rtQOyShLazAGd4IN7ehiknyArA/3xMbmfmegh4aopnaWGwVb9gcssZkZktzhkbI3
 vnED6qt9UDkd+aJbBlEvOs9PKW5eQDgrtKYpz87QyogG97ZCwbyj9ec8nLFC260LhGFz09LWrYM
 5lSkMgpdKjE7jM+o+eg8Zpoh4WcIuDq2GQlTgIBR5sMgeH6PYYX+7GJtkBILToN/GfP6/W6pWKM
 Em10Bn7PBK7a4gULbsn1H5oeaIoem4jhjrHcXwpTod1La9G9FvKGgSjjipszLrk5KtliSFg7eX+
 Vg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

While Git allows users to select different reference backends, unlike
with objects, there is no flexibility in selecting the reference
directory. Currently, the reference format is obtained from the config
of the repository and the reference directory is set to the $GIT_DIR.

This patch extends the config 'extensions.refStorage' to take in
multiple forms of inputs:

  - A format name alone (e.g., `reftable` or `files`).

  - A URI format `<format>://<payload>` explicitly specifies both the
    format and payload (e.g., `reftable:///foo/bar`).

We also add in a new ENV variable GIT_REFERENCE_BACKEND which can be
used to override the config.

One use case for this is migration between different backends. On the
server side, migrating from the files backend to the newly introduced
reftable backend can be achieved by running 'git refs migrate'. However,
for large repositories with millions of references, this migration can
take from seconds to minutes.

For some background, at GitLab, the criteria for our migration was to
reduce the downtime of the migrate ideally to zero. So running 'git refs
migrate --ref-format=reftable' by itself wouldn't work, since it scales
with the number of references and we have repos with millions of
references, so we need to migrate without loosing any information. We
came up with the following plan:

  1. Run git-pack-refs(1) and note timestamp of the generated packed-refs
     file.
  2. Run git refs migrate –dry-run.
  3. If there are no ongoing reference requests (read/write)
     a. Lock the repository by blocking incoming requests (done on a
        layer above git, in Gitaly [1]).
     b. If the timestamp of the packed-refs file has changed, unlock
        the repo and repeat from step 1.
     c. Apply all the loose refs to the dry-run reftable folder (this
        requires support in Git to write refs to arbitrary folder).
     d. Move the reftable dry-run folder into the GIT_DIR.
     e. Swap the repo config
     f. Unlock repo access

Using such a route, scales much better since we only have to worry about
blocking the repository by O(ref written between #1 and #3a) and not
O(refs in repo). But for doing so, we need to be able to write to a
arbitrary reference backend + path. This is to add the missing
references to the dry-run reftable folder. This series, achieves that.

Since there was a long gap between v3 <> v4, the version 4 onward is
based on top of 2258446484 (RelNotes: correct "fast-import" option name,
2026-01-30).

[1]: https://gitlab.com/gitlab-org/gitaly

---
Changes in v6:
- The biggest change in this version is that we now support using the
  environment variable with 'git-clone(1)' and 'git-init(1)'. In such
  situations, the alternate reference directory is created and the
  config is added to the repository.
- Add a new commit which moves stub creation/removal to the generic
  layer.
- Cleanup logic flow in `refs_compute_filesystem_location()`.
- Add more tests for usage with 'git-clone(1)', 'git-init(1)' and
  migration of repositories using alternate refs backend.
- Fixup documentation, commit messages and typos.
- Link to v5: https://patch.msgid.link/20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com

Changes in v5:
- Moved around the commits, to ensure that the code to handle the config
  in the backend is first. Previously, we added the config first, which
  meant the commit allowed users to provide a URI but it was simply
  ignore.
- Fix typos and grammar and rename variables.
- Clean up the description and documentation to actually specify
  protocol over location.
- Avoid an extra memory allocation by detaching the strbuf value.
- Link to v4: https://patch.msgid.link/20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com

Changes in v4:
- Mostly re-wrote the code to also support worktree. Now, the existing
  backends will store worktree references in 'ref_dir/worktrees/wt_id'
  and add corresponding stubs in 'git_dir/worktrees/wt_id'.
- We also support relative paths in the reference directories. These
  relative paths are resolved relative to the GIT_DIR.
- Link to v3: https://patch.msgid.link/20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com

Changes in v3:
- Cleanup some stale code which wasn't removed.
- Localize strings which will be output to the user.
- Remove additional defensive checks which are not needed.
- Link to v2: https://patch.msgid.link/20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com

Changes in v2:
- Added more clarification and proper intent in the cover message.
- Changed the format from '<ref_backend>://<path>' to
  `<ref_backend>://<URI-for-resource>` as it much clearer.
- Added logic to check for the '//' in the provided URI and a test for
  the same.
- In the tests:
  - Use test_must_fail() instead of ! git
  - Fix looped tests not using the variables correctly and ensure that
    the test description is correct.
- Link to v1: https://patch.msgid.link/20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com

---
 Documentation/config/extensions.adoc |  16 ++-
 Documentation/git.adoc               |   5 +
 builtin/clone.c                      |   9 +-
 builtin/worktree.c                   |  34 +++++
 environment.h                        |   1 +
 refs.c                               | 127 +++++++++++++++++-
 refs.h                               |  13 ++
 refs/files-backend.c                 |  23 +++-
 refs/packed-backend.c                |   5 +
 refs/packed-backend.h                |   1 +
 refs/refs-internal.h                 |  14 ++
 refs/reftable-backend.c              |  61 ++-------
 repository.c                         |   9 +-
 repository.h                         |   8 +-
 setup.c                              |  96 ++++++++++++--
 setup.h                              |   4 +-
 t/meson.build                        |   1 +
 t/t1423-ref-backend.sh               | 250 +++++++++++++++++++++++++++++++++++
 18 files changed, 596 insertions(+), 81 deletions(-)

Karthik Nayak (6):
      setup: don't modify repo in `create_reference_database()`
      refs: extract out `refs_create_refdir_stubs()`
      refs: receive and use the reference storage payload
      refs: move out stub modification to generic layer
      refs: allow reference location in refstorage config
      refs: add GIT_REFERENCE_BACKEND to specify reference backend

Range-diff versus v5:

-:  ---------- > 1:  f8dd9a2fd6 setup: don't modify repo in `create_reference_database()`
1:  d1f777120e ! 2:  07abde22c1 refs: extract out `refs_create_refdir_stubs()`
    @@ builtin/clone.c: int cmd_clone(int argc,
      	 * additional config can be injected with -c, make sure it's included
     
      ## refs.c ##
    -@@ refs.c: const char *ref_transaction_error_msg(enum ref_transaction_error err)
    - 		return "unknown failure";
    - 	}
    +@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
    + 	return NULL;
      }
    -+
    + 
     +void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
     +			      const char *refs_heads_content)
     +{
    @@ refs.c: const char *ref_transaction_error_msg(enum ref_transaction_error err)
     +
     +	strbuf_release(&path);
     +}
    ++
    + /* backend functions */
    + int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *err)
    + {
     
      ## refs.h ##
     @@ refs.h: void ref_iterator_free(struct ref_iterator *ref_iterator);
2:  804720d11a ! 3:  aab87c8e39 refs: forward and use the reference storage payload
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: forward and use the reference storage payload
    +    refs: receive and use the reference storage payload
     
         An upcoming commit will add support for providing an URI via the
         'extensions.refStorage' config. The URI will contain the reference
    @@ Commit message
         To prepare for this, modify the existing backends to accept such an
         argument when initializing via the 'init()' function. Both the files
         and reftable backends will parse the information to be filesystem paths
    -    to store references.
    +    to store references. Given that no callers pass any payload yet this is
    +    essentially a no-op change for now.
     
         To enable this, provide a 'refs_compute_filesystem_location()' function
         which will parse the current 'gitdir' and the 'payload' to provide the
    @@ refs.c: static struct ref_store *ref_store_init(struct repository *repo,
      	return refs;
      }
      
    -@@ refs.c: void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
    - 
    - 	strbuf_release(&path);
    +@@ refs.c: const char *ref_transaction_error_msg(enum ref_transaction_error err)
    + 		return "unknown failure";
    + 	}
      }
     +
     +void refs_compute_filesystem_location(const char *gitdir, const char *payload,
    @@ refs.c: void refs_create_refdir_stubs(struct repository *repo, const char *refdi
     +{
     +	struct strbuf sb = STRBUF_INIT;
     +
    -+	strbuf_addstr(refdir, gitdir);
     +	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
     +
    -+	if (!payload)
    ++	if (!payload) {
    ++		/*
    ++		 * We can use the 'gitdir' as the 'refdir' without appending the
    ++		 * worktree path, as the 'gitdir' here is already the worktree
    ++		 * path and is different from 'commondir' denoted by 'ref_common_dir'.
    ++		 */
    ++		strbuf_addstr(refdir, gitdir);
     +		return;
    ++	}
     +
     +	if (!is_absolute_path(payload)) {
     +		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
    @@ refs.c: void refs_create_refdir_stubs(struct repository *repo, const char *refdi
     +		strbuf_realpath(ref_common_dir, payload, 1);
     +	}
     +
    -+	strbuf_reset(refdir);
     +	strbuf_addbuf(refdir, ref_common_dir);
     +
     +	if (*is_worktree) {
    -+		char *wt_id = strrchr(gitdir, '/') + 1;
    -+		strbuf_addf(refdir, "/worktrees/%s", wt_id);
    ++		const char *wt_id = strrchr(gitdir, '/');
    ++		if (!wt_id)
    ++			BUG("worktree path does not contain slash ");
    ++		strbuf_addf(refdir, "/worktrees/%s", wt_id + 1);
     +	}
     +
     +	strbuf_release(&sb);
    @@ refs/files-backend.c: static void clear_loose_ref_cache(struct files_ref_store *
     +	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
      	refs->packed_ref_store =
     -		packed_ref_store_init(repo, refs->gitcommondir, flags);
    -+		packed_ref_store_init(repo, payload, refs->gitcommondir, flags);
    ++		packed_ref_store_init(repo, NULL, refs->gitcommondir, flags);
      	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
      	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
      
    @@ refs/files-backend.c: static struct ref_store *files_ref_store_init(struct repos
     
      ## refs/packed-backend.c ##
     @@ refs/packed-backend.c: static size_t snapshot_hexsz(const struct snapshot *snapshot)
    + 	return snapshot->refs->base.repo->hash_algo->hexsz;
      }
      
    ++/*
    ++ * Since packed-refs is only stored in the common dir, don't parse the
    ++ * payload and rely on the files-backend to set 'gitdir' correctly.
    ++ */
      struct ref_store *packed_ref_store_init(struct repository *repo,
     +					const char *payload UNUSED,
      					const char *gitdir,
    @@ refs/refs-internal.h: enum ref_transaction_error refs_verify_refnames_available(
     + * directory if working with a linked worktree. If working with the main
     + * worktree, both values will be the same.
     + *
    -+ * This is used by backends such as {files, reftable} which store references in
    -+ * dedicated filesystem paths.
    ++ * This is used by backends that store store files in the repository directly.
     + */
     +void refs_compute_filesystem_location(const char *gitdir, const char *payload,
     +				      bool *is_worktree, struct strbuf *refdir,
-:  ---------- > 4:  9ed74524d3 refs: move out stub modification to generic layer
3:  3a5058f39c ! 5:  331ac15000 refs: allow reference location in refstorage config
    @@ Commit message
         reference backend and the location.
     
         Add the required changes to obtain and propagate this value to the
    -    individual backends also add the necessary documentation and tests.
    +    individual backends. Add the necessary documentation and tests.
     
         Traditionally, for linked worktrees, references were stored in the
         '$GIT_DIR/worktrees/<wt_id>' path. But when using an alternate reference
    @@ Documentation/config/extensions.adoc: For historical reasons, this extension is
      +
      Note that this setting should only be set by linkgit:git-init[1] or
     
    - ## builtin/clone.c ##
    -@@ builtin/clone.c: int cmd_clone(int argc,
    - 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
    - 	initialize_repository_version(hash_algo, the_repository->ref_storage_format, 1);
    - 	repo_set_hash_algo(the_repository, hash_algo);
    --	create_reference_database(the_repository->ref_storage_format, NULL, 1);
    -+	create_reference_database(the_repository->ref_storage_format,
    -+				  the_repository->ref_storage_payload, NULL, 1);
    - 
    - 	/*
    - 	 * Before fetching from the remote, download and install bundle
    -
      ## builtin/worktree.c ##
     @@ builtin/worktree.c: static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
      	return run_command(&cp);
      }
      
     +/*
    -+ * References for worktress are generally stored in '$GIT_DIR/worktrees/<wt_id>'.
    ++ * References for worktrees are generally stored in '$GIT_DIR/worktrees/<wt_id>'.
     + * But when using alternate reference directories, we want to store the worktree
     + * references in '$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id>'.
     + *
    @@ builtin/worktree.c: static int make_worktree_orphan(const char * ref, const stru
     +	strbuf_reset(&sb);
     +
     +	strbuf_addf(&sb, "this worktree stores references in %s/worktrees/%s",
    -+		   path, wt->id);
    ++		    path, wt->id);
     +	refs_create_refdir_stubs(wt->repo, wt_git_path, sb.buf);
     +
     +	strbuf_release(&sb);
    @@ setup.c: static enum extension_result handle_extension_v0(const char *var,
     +static void parse_reference_uri(const char *value, char **format,
     +				char **payload)
     +{
    -+	char *schema_end;
    ++	const char *schema_end;
     +
     +	schema_end = strstr(value, "://");
     +	if (!schema_end) {
    @@ setup.c: void check_repository_format(struct repository_format *fmt)
      	the_repository->repository_format_worktree_config =
      		fmt->worktree_config;
      	the_repository->repository_format_relative_worktrees =
    -@@ setup.c: static int is_reinit(void)
    - }
    - 
    - void create_reference_database(enum ref_storage_format ref_storage_format,
    -+			       const char *ref_storage_payload,
    - 			       const char *initial_branch, int quiet)
    - {
    - 	struct strbuf err = STRBUF_INIT;
    - 	char *to_free = NULL;
    - 	int reinit = is_reinit();
    - 
    --	repo_set_ref_storage_format(the_repository, ref_storage_format);
    -+	repo_set_ref_storage_format(the_repository, ref_storage_format,
    -+				    ref_storage_payload);
    - 	if (ref_store_create_on_disk(get_main_ref_store(the_repository), 0, &err))
    - 		die("failed to set up refs db: %s", err.buf);
    - 
     @@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
      	} else {
      		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
    @@ setup.c: static void repository_format_configure(struct repository_format *repo_
      }
      
      int init_db(const char *git_dir, const char *real_git_dir,
    -@@ setup.c: int init_db(const char *git_dir, const char *real_git_dir,
    - 
    - 	if (!(flags & INIT_DB_SKIP_REFDB))
    - 		create_reference_database(repo_fmt.ref_storage_format,
    -+					  repo_fmt.ref_storage_payload,
    - 					  initial_branch, flags & INIT_DB_QUIET);
    - 	create_object_directory();
    - 
     
      ## setup.h ##
     @@ setup.h: struct repository_format {
    @@ setup.h: struct repository_format {
      	int sparse_index;
      	char *work_tree;
      	struct string_list unknown_extensions;
    -@@ setup.h: void initialize_repository_version(int hash_algo,
    - 				   enum ref_storage_format ref_storage_format,
    - 				   int reinit);
    - void create_reference_database(enum ref_storage_format ref_storage_format,
    -+			       const char *ref_storage_payload,
    - 			       const char *initial_branch, int quiet);
    - 
    - /*
     
      ## t/meson.build ##
     @@ t/meson.build: integration_tests = [
    @@ t/t1423-ref-backend.sh (new)
     +	fi
     +
     +
    -+	for dir in "$(pwd)/repo/.git" "./"
    ++	for dir in "$(pwd)/repo/.git" "."
     +	do
     +
    -+		test_expect_success "$read from $to_format backend, $dir dir" '
    ++		test_expect_success "read from $to_format backend, $dir dir" '
     +			test_when_finished "rm -rf repo" &&
     +			git init --ref-format=$from_format repo &&
     +			(
    @@ t/t1423-ref-backend.sh (new)
     +			)
     +		'
     +
    -+		test_expect_success "$write to $to_format backend, $dir dir" '
    ++		test_expect_success "write to $to_format backend, $dir dir" '
     +			test_when_finished "rm -rf repo" &&
     +			git init --ref-format=$from_format repo &&
     +			(
4:  12168d2e35 ! 6:  288bc77a98 refs: add GIT_REFERENCE_BACKEND to specify reference backend
    @@ Commit message
         variable allows us to modify the reference backend and location on the
         fly for individual Git commands.
     
    +    The environment variable also allows usage of alternate reference
    +    directories during 'git-clone(1)' and 'git-init(1)'. Add the config to
    +    the repository when created with the environment variable set.
    +
    +    When initializing the repository with an alternate reference folder,
    +    create the required stubs in the repositories $GIT_DIR. The inverse,
    +    i.e. removal of the ref store doesn't clean up the stubs in the $GIT_DIR
    +    since that would render it unusable. Removal of ref store is only used
    +    when migrating between ref formats and cleanup of the $GIT_DIR doesn't
    +    make sense in such a situation.
    +
         Helped-by: Jean-Noël Avila <jn.avila@free.fr>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ environment.h
      /*
       * Environment variable used to propagate the --no-advice global option to the
     
    + ## refs.c ##
    +@@ refs.c: int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *e
    + {
    + 	int ret = refs->be->create_on_disk(refs, flags, err);
    + 
    +-	if (!ret &&
    +-	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
    +-		struct strbuf msg = STRBUF_INIT;
    +-
    +-		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
    +-		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
    +-		strbuf_release(&msg);
    ++	if (!ret) {
    ++		/* Creation of stubs for linked worktrees are handled in the worktree code. */
    ++		if (!(flags & REF_STORE_CREATE_ON_DISK_IS_WORKTREE) && refs->repo->ref_storage_payload) {
    ++			refs_create_refdir_stubs(refs->repo, refs->repo->gitdir,
    ++						 "repository uses alternate refs storage");
    ++		} else if (ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
    ++			struct strbuf msg = STRBUF_INIT;
    ++			strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
    ++			refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
    ++			strbuf_release(&msg);
    ++		}
    + 	}
    + 
    + 	return ret;
    ++
    + }
    + 
    + int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err)
    +@@ refs.c: int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err)
    + 		if (format == REF_STORAGE_FORMAT_FILES)
    + 			return ret;
    + 
    ++		/* Alternate refs backend require stubs in the gitdir. */
    ++		if (refs->repo->ref_storage_payload)
    ++			return ret;
    ++
    + 		strbuf_addf(&sb, "%s/HEAD", refs->gitdir);
    + 		if (unlink(sb.buf) < 0) {
    + 			strbuf_addf(err, "could not delete stub HEAD: %s",
    +
      ## setup.c ##
     @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
      	static struct strbuf cwd = STRBUF_INIT;
    @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
     +	 */
     +	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
     +	if (ref_backend_uri) {
    -+		char *backend, *location;
    ++		char *backend, *payload;
     +		enum ref_storage_format format;
     +
    -+		parse_reference_uri(ref_backend_uri, &backend, &location);
    ++		parse_reference_uri(ref_backend_uri, &backend, &payload);
     +		format = ref_storage_format_by_name(backend);
     +		if (format == REF_STORAGE_FORMAT_UNKNOWN)
     +			die(_("unknown ref storage format: '%s'"), backend);
    -+		repo_set_ref_storage_format(the_repository, format, location);
    ++		repo_set_ref_storage_format(the_repository, format, payload);
     +
     +		free(backend);
    -+		free(location);
    ++		free(payload);
     +	}
     +
      	setup_original_cwd();
      
      	strbuf_release(&dir);
    +@@ setup.c: void initialize_repository_version(int hash_algo,
    + 	 * the remote repository's format.
    + 	 */
    + 	if (hash_algo != GIT_HASH_SHA1_LEGACY ||
    +-	    ref_storage_format != REF_STORAGE_FORMAT_FILES)
    ++	    ref_storage_format != REF_STORAGE_FORMAT_FILES ||
    ++	    the_repository->ref_storage_payload)
    + 		target_version = GIT_REPO_VERSION_READ;
    + 
    + 	if (hash_algo != GIT_HASH_SHA1_LEGACY && hash_algo != GIT_HASH_UNKNOWN)
    +@@ setup.c: void initialize_repository_version(int hash_algo,
    + 	else if (reinit)
    + 		repo_config_set_gently(the_repository, "extensions.objectformat", NULL);
    + 
    +-	if (ref_storage_format != REF_STORAGE_FORMAT_FILES)
    ++	if (the_repository->ref_storage_payload) {
    ++		struct strbuf ref_uri = STRBUF_INIT;
    ++
    ++		strbuf_addf(&ref_uri, "%s://%s",
    ++			    ref_storage_format_to_name(ref_storage_format),
    ++			    the_repository->ref_storage_payload);
    ++		repo_config_set(the_repository, "extensions.refstorage", ref_uri.buf);
    ++		strbuf_release(&ref_uri);
    ++	} else if (ref_storage_format != REF_STORAGE_FORMAT_FILES) {
    + 		repo_config_set(the_repository, "extensions.refstorage",
    + 				ref_storage_format_to_name(ref_storage_format));
    +-	else if (reinit)
    ++	} else if (reinit) {
    + 		repo_config_set_gently(the_repository, "extensions.refstorage", NULL);
    ++	}
    + 
    + 	if (reinit) {
    + 		struct strbuf config = STRBUF_INIT;
    +@@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
    + 		.ignore_repo = 1,
    + 		.ignore_worktree = 1,
    + 	};
    ++	const char *ref_backend_uri;
    + 	const char *env;
    + 
    + 	config_with_options(read_default_format_config, &cfg, NULL, NULL, &opts);
    +@@ setup.c: static void repository_format_configure(struct repository_format *repo_fmt,
    + 	} else {
    + 		repo_fmt->ref_storage_format = REF_STORAGE_FORMAT_DEFAULT;
    + 	}
    ++
    ++
    ++	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
    ++	if (ref_backend_uri) {
    ++		char *backend, *payload;
    ++		enum ref_storage_format format;
    ++
    ++		parse_reference_uri(ref_backend_uri, &backend, &payload);
    ++		format = ref_storage_format_by_name(backend);
    ++		if (format == REF_STORAGE_FORMAT_UNKNOWN)
    ++			die(_("unknown ref storage format: '%s'"), backend);
    ++
    ++		repo_fmt->ref_storage_format = format;
    ++		repo_fmt->ref_storage_payload = payload;
    ++
    ++		free(backend);
    ++	}
    ++
    + 	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format,
    + 				    repo_fmt->ref_storage_payload);
    + }
     
      ## t/t1423-ref-backend.sh ##
     @@ t/t1423-ref-backend.sh: test_description='Test reference backend URIs'
    @@ t/t1423-ref-backend.sh: run_with_uri() {
      }
      
     -test_expect_success 'URI is invalid' '
    -+methods="config"
    ++methods="config env"
     +for method in $methods
     +do
     +
    @@ t/t1423-ref-backend.sh: run_with_uri() {
      '
      
     @@ t/t1423-ref-backend.sh: do
    - 	for dir in "$(pwd)/repo/.git" "./"
    + 	for dir in "$(pwd)/repo/.git" "."
      	do
      
    --		test_expect_success "$read from $to_format backend, $dir dir" '
    -+		test_expect_success "$method: $read from $to_format backend, $dir dir" '
    +-		test_expect_success "read from $to_format backend, $dir dir" '
    ++		test_expect_success "$method: read from $to_format backend, $dir dir" '
      			test_when_finished "rm -rf repo" &&
      			git init --ref-format=$from_format repo &&
      			(
    @@ t/t1423-ref-backend.sh: do
      			)
      		'
      
    --		test_expect_success "$write to $to_format backend, $dir dir" '
    -+		test_expect_success "$method: $write to $to_format backend, $dir dir" '
    +-		test_expect_success "write to $to_format backend, $dir dir" '
    ++		test_expect_success "$method: write to $to_format backend, $dir dir" '
      			test_when_finished "rm -rf repo" &&
      			git init --ref-format=$from_format repo &&
      			(
    @@ t/t1423-ref-backend.sh: do
      
     -				git config set core.repositoryformatversion 1 &&
     -				git config set extensions.refStorage "$to_format://$BACKEND_PATH" &&
    +-
    +-				git worktree add ../wt 2
    +-			) &&
     +				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
     +					"worktree add ../wt 2" "$method" &&
      
    --				git worktree add ../wt 2
    --			) &&
    +-			git -C repo for-each-ref --include-root-refs >expect &&
    +-			git -C wt for-each-ref --include-root-refs >expect &&
    +-			! test_cmp expect actual &&
     +				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
     +					"for-each-ref --include-root-refs" "$method" >actual &&
     +				run_with_uri ../wt "$from_format" "$to_format://$BACKEND_PATH" \
     +					"for-each-ref --include-root-refs" "$method" >expect &&
     +				! test_cmp expect actual &&
      
    --			git -C repo for-each-ref --include-root-refs >expect &&
    --			git -C wt for-each-ref --include-root-refs >expect &&
    --			! test_cmp expect actual &&
    --
     -			git -C wt rev-parse 2 >expect &&
     -			git -C wt rev-parse HEAD >actual &&
     -			test_cmp expect actual
    @@ t/t1423-ref-backend.sh: do
     +			)
      		'
      	done # closes dir
    - done # closes to_format
    --done # closes from_format
    -+done # closes to_format
     +
    -+done # closes method
    ++	test_expect_success "migrating repository to $to_format with alternate refs directory" '
    ++		test_when_finished "rm -rf repo refdir" &&
    ++		mkdir refdir &&
    ++		GIT_REFERENCE_BACKEND="${from_format}://$(pwd)/refdir" git init repo &&
    ++		(
    ++			cd repo &&
    ++
    ++			test_commit 1 &&
    ++			test_commit 2 &&
    ++			test_commit 3 &&
    ++
    ++			git refs migrate --ref-format=$to_format &&
    ++			git refs list >out &&
    ++			test_grep "refs/tags/1"	out &&
    ++			test_grep "refs/tags/2"	out &&
    ++			test_grep "refs/tags/3"	out
    ++		)
    ++	'
    ++
    + done # closes to_format
    + done # closes from_format
      
    ++done # closes method
    ++
    ++test_expect_success 'initializing repository with alt ref directory' '
    ++	test_when_finished "rm -rf repo refdir" &&
    ++	mkdir refdir &&
    ++	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
    ++	GIT_REFERENCE_BACKEND=$BACKEND git init repo &&
    ++	(
    ++		cd repo &&
    ++
    ++		git config get extensions.refstorage >expect &&
    ++		echo $BACKEND >actual &&
    ++		test_cmp expect actual &&
    ++
    ++		test_commit 1 &&
    ++		test_commit 2 &&
    ++		test_commit 3 &&
    ++		git refs list >out &&
    ++		test_grep "refs/tags/1"	out &&
    ++		test_grep "refs/tags/2"	out &&
    ++		test_grep "refs/tags/3"	out
    ++	)
    ++'
    ++
    ++test_expect_success 'cloning repository with alt ref directory' '
    ++	test_when_finished "rm -rf source repo refdir" &&
    ++	mkdir refdir &&
    ++
    ++	git init source &&
    ++	test_commit -C source 1 &&
    ++	test_commit -C source 2 &&
    ++	test_commit -C source 3 &&
    ++
    ++	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
    ++	GIT_REFERENCE_BACKEND=$BACKEND git clone source repo &&
    ++
    ++	git -C repo config get extensions.refstorage >expect &&
    ++	echo $BACKEND >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	git -C source for-each-ref refs/tags/ >expect &&
    ++	git -C repo for-each-ref refs/tags/ >actual &&
    ++	test_cmp expect actual
    ++'
    ++
      test_done


base-commit: 22584464849815268419fd9d2eba307362360db1
change-id: 20251105-kn-alternate-ref-dir-3e572e8cd0ef

Thanks
- Karthik


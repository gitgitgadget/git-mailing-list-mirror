Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3357082F
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652705; cv=none; b=qQSMDrdl+xEgthhW5S+C1l8hnOeIdIuQ5/j7mUa1HYZm2FJ0n0tkj63Oz2pySBigNRBULBBLz+tjfYoJCvOAe0C7DEm9dSy60RweRATGHMTGhPuhaxZZVRfgUv4lOh9VGY+XjVjEjiukPnJx4bFX3/h9aAvF4mGpU6zCi4+9zAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652705; c=relaxed/simple;
	bh=Q1MbPtDcBwdclfUWwgPHWo8ujhmiUgtXEmw/MoRz0SM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=DTQ5icCNyEA9dxfubiNVSoPb2CtuQBSM1ejQdc3c4f0y9GJbZLPK8MiMv6EYjq8CAsbvP8EURvUqdKHhAtMbWVMBdt+kcYPmwdP5h9COmr5EviXwolhBrrYPd1oHiJtJCaLvVw/HXVgZGPA2lf156FDgm/5UWQpUKcGSX479GOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z41v1S0V; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z41v1S0V"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so44168015e9.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770652704; x=1771257504; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogW5/qHz7CWIsPkN3H/DSh2/3ZBAtes/RQlRukxdUCk=;
        b=Z41v1S0VOm1Qe/FDIrP7YFCDghYoMhzzZ5g7NXr5xvZYhAt9ri2RvV6c+crzYELxLl
         2mGIICB3djpj4vqHKpQp/HCavUL/t7RyCXW4cqoKI6F5wQ4NKycJ5whGv57LttnEGp0u
         VO044mgAckdFMlFZ5sqsuXD9zWR2O2M11nenI2w38bj8MiCeIAtLruj3DWtryz2CWWSE
         n4k2lSgfkhoYiDyQqxkKabOcAtWRPHQUwFc6rdmQ1TW+Pfehk4TXV/tP+8G5/N8IFQ2r
         PQ07UC6cjOAt7UTnWtYvqrTx74eHsGkaJh9LE3q7CjufAfeaJOt2hiHSYjjI1XkKUJnb
         zXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770652704; x=1771257504;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogW5/qHz7CWIsPkN3H/DSh2/3ZBAtes/RQlRukxdUCk=;
        b=Sqw4B2pJyQdngjI2n6wA6ZZLIlanmksIbdTMy8TURpfxjRZkq3RnI5wbh21MZ2CaLN
         Xx0WrDBukk8ttrzonQTbBUNOLYzhO163JxSyOpuAkBkhXb1aIdTkLlmw6iCXkficCXv5
         xY08v089v59tEC+VDhOuuNMkEjMk0bWRb6XGDvQZKaV6lggK70QeZOes41sJxEDjGFh+
         EjNwHQi8Tx7w4zKus3VbFNhnYhCuAtGpLRRZqxYsNTvLFBzBjbvl7D8rsDypBWtXzQi1
         r/5GG+ESH0fInRg1LRDzCtimLSfjdnD0vejpg4YP71riM/Cd44cEMuFoqyW1TwuHL0UY
         tBLA==
X-Gm-Message-State: AOJu0Yxmxyjy8eeI1Rvx8+dTuXLG2gbUNYR/vplW1Jmoz1HGAng5de4K
	ynE+fUYBRqKfPz9cpDnlP7h0LwxoEGLGWWZ5fxgZlVoWe+vsFb8eLiIn
X-Gm-Gg: AZuq6aJdZiWFXEpNFc+PaTVWsOAwyFJvh3o+TzxwaHTjfilTHwAryCblxoA/u+zilCg
	vZ2YEWJV3tBSnZX3Ao0DDBVcGyS0dRTEQ/K4BkXTeeWcvSDJe2iGVpERhsC8bigBDZRn2hful4H
	+w5s+mPK51Ccms6Elk2GPEjrksLgShZZGEL/hd4xKBUMGaY7BU+jlTFii/sw6ddF+9tLTo11ygF
	PFjHem/zQqDQc+Ivq8c3TzTsX57CWUzTx5Hujp1YrkjCk4DNYUsurqO4e/AlB4+DDi4AJrkh4dL
	ASHYARh7JdAiMIeXsnmzECIX1hdeTvav37xl7HbISf9zFAsdF2yKalFskR2IN1m6JMBPJ1AjZHg
	99TXfWCufXW+1x/saYb9G82sthme0g/BgVFvCbcVNSEaHdUpIgYuykU0ZngTO39tOO/phQgQVRh
	Ykxm94sAAq2bjN/UQLwEQ=
X-Received: by 2002:a05:600c:3553:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-483201dc644mr165990595e9.6.1770652703154;
        Mon, 09 Feb 2026 07:58:23 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:9616:5969:7cd9:8b71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832096f127sm128163635e9.6.2026.02.09.07.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:58:21 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 0/4] refs: allow setting the reference directory
Date: Mon, 09 Feb 2026 16:58:17 +0100
Message-Id: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABkEimkC/3XN2wrCMAwG4FeRXltpenLzyvcQL9ou1aJu0o2hy
 N7dOBSHOAiBPyFfHqzFnLBlm8WDZexTm5qaglkuWDi6+oA8VZSZFNIACMNPNXfnDnPtOuQZI69
 S5grNWmIRKoGR0emVFuk2srs95WNquybfxy89vKZvEMr/YA9ccB2idqUOhcdqe7i4dF6F5sJeY
 C8niLQziCSk8GW0EYpolflF1BeRAmYQRUgA8KW2PsjofhH9QaygNoNoQpRXQlMBoJoiwzA8AXx
 dnSaHAQAA
X-Change-ID: 20251105-kn-alternate-ref-dir-3e572e8cd0ef
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=35802;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=Q1MbPtDcBwdclfUWwgPHWo8ujhmiUgtXEmw/MoRz0SM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmKBBswTvaNx6yHQ+tZ5d8QPM4KinkTsK6KA
 z0i5ejn0J57Q4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpigQbAAoJED7VnySO
 Rox/6icL/indRE0SpQmuxfBuABCVcT4b/4Y81VuDwmNzKYoMF8TDDWVQs4WHuyjR9BnWBwHLdSw
 ow/IT66tJ55Ir9KNNKVmZYy7ErVocgWZXMvMC0fXgZCIiRg6A66aSnGVAeegOdrq7l5fMBFbxCl
 oSeOdKHFsPxLz8SOgTEGcf7ER1Y2Et/EiIeAbaqdV5avbLOHEq/oTlftqNcMZLLzBNiUlp7xxQE
 6uCu2paiTdOZiGbaQgZySEsxrzCCCRxKmw3k8+DGWMKNQfQ0iy8AkYpOfxpAbDgZIVdVCdHSDAr
 ye6qSJn2UtiuJa6ukpxXQDWAU74Fp4nPhu3BvOMfYNzdowErZiJqGr4hjlSXc0RN29RGVna/r5y
 y1iQNFVeuI8HnlTUQDmkWoSIVtXqSRLH0kluaj1xS879QCsGBt0/ZVanD6CW2BhBxtMbCdIJUi2
 Vl96qb8J1Jx3hXwu/n7CLmRe0BtMK0xVv0qiYzEhTy5TnAETQL6Fep86DAuXlxELX5LKK7YFsH4
 Ig=
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
 builtin/clone.c                      |  10 +-
 builtin/worktree.c                   |  34 +++++++
 environment.h                        |   1 +
 refs.c                               |  60 ++++++++++-
 refs.h                               |  13 +++
 refs/files-backend.c                 |  17 +++-
 refs/packed-backend.c                |   1 +
 refs/packed-backend.h                |   1 +
 refs/refs-internal.h                 |  15 +++
 refs/reftable-backend.c              |  38 +++----
 repository.c                         |   9 +-
 repository.h                         |   8 +-
 setup.c                              |  59 ++++++++++-
 setup.h                              |   2 +
 t/meson.build                        |   1 +
 t/t1423-ref-backend.sh               | 187 +++++++++++++++++++++++++++++++++++
 18 files changed, 433 insertions(+), 44 deletions(-)

Karthik Nayak (4):
      refs: extract out `refs_create_refdir_stubs()`
      refs: forward and use the reference storage payload
      refs: allow reference location in refstorage config
      refs: add GIT_REFERENCE_BACKEND to specify reference backend

Range-diff versus v4:

2:  57943ad6f9 ! 1:  6ed61ba98b refs: extract out `refs_create_refdir_stubs()`
    @@ Commit message
         directory to contain:
     
           1. 'HEAD' file
    -      2. object/ directory
    +      2. 'objects/' directory
           3. 'refs/' directory
     
         Here, #1 and #3 are part of the reference storage mechanism,
         specifically the files backend. Since then, newer backends such as the
         reftable backend have moved to using their own path ('reftable/') for
    -    storing references. But to ensure git still recognizes the directory as
    +    storing references. But to ensure Git still recognizes the directory as
         a Git directory, we create stubs.
     
    -    There are two locations we create stubs:
    +    There are two locations where we create stubs:
     
         - In 'refs/reftable-backend.c' when creating the reftable backend.
         - In 'clone.c' before spawning transport helpers.
    @@ refs.c: const char *ref_transaction_error_msg(enum ref_transaction_error err)
      }
     +
     +void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
    -+			      const char *refs_heads_msg)
    ++			      const char *refs_heads_content)
     +{
     +	struct strbuf path = STRBUF_INIT;
     +
    -+
     +	strbuf_addf(&path, "%s/HEAD", refdir);
     +	write_file(path.buf, "ref: refs/heads/.invalid");
     +	adjust_shared_perm(repo, path.buf);
    @@ refs.c: const char *ref_transaction_error_msg(enum ref_transaction_error err)
     +	strbuf_addf(&path, "%s/refs", refdir);
     +	safe_create_dir(repo, path.buf, 1);
     +
    -+	if (refs_heads_msg) {
    ++	if (refs_heads_content) {
     +		strbuf_reset(&path);
     +		strbuf_addf(&path, "%s/refs/heads", refdir);
    -+		write_file(path.buf, "%s", refs_heads_msg);
    ++		write_file(path.buf, "%s", refs_heads_content);
     +		adjust_shared_perm(repo, path.buf);
     +	}
     +
3:  330a9bd253 ! 2:  a907b190d1 refs: parse and use the reference storage payload
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: parse and use the reference storage payload
    +    refs: forward and use the reference storage payload
     
    -    The previous commit extended the 'extensions.refStorage' config to add
    -    support for a reference storage payload. The payload provides backend
    -    specific information on where to store references for a given directory.
    +    An upcoming commit will add support for providing an URI via the
    +    'extensions.refStorage' config. The URI will contain the reference
    +    backend and a corresponding payload. The payload can be then used for
    +    providing an alternate locations for the reference backend.
     
    -    Propagate this information to individual backends when initializing them
    -    via the 'init()' function. Both the files and reftable backends will
    -    parse the information to be filesystem paths to store references.
    +    To prepare for this, modify the existing backends to accept such an
    +    argument when initializing via the 'init()' function. Both the files
    +    and reftable backends will parse the information to be filesystem paths
    +    to store references.
     
         To enable this, provide a 'refs_compute_filesystem_location()' function
         which will parse the current 'gitdir' and the 'payload' to provide the
         final reference directory and common reference directory (if working in
         a linked worktree).
     
    -    Finally, for linked worktrees, traditionally references were stored in
    -    the '$GIT_DIR/worktrees/<wt_id>' path. But when using an alternate
    -    reference storage path, it doesn't make sense to store main worktree
    -    references in the new path, and linked worktree references in the
    -    $GIT_DIR path. So, let's store linked worktree references in
    -    '$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id'. To do this, create the
    -    necessary files and folders and also add stubs in the $GIT_DIR path to
    -    ensure that it is still considered a Git directory.
    -
    -    Since this commit adds the required linking, also add the necessary
    -    documentation and tests.
    +    The documentation and tests will be added alongside the extension of the
    +    config variable.
     
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    - ## Documentation/config/extensions.adoc ##
    -@@ Documentation/config/extensions.adoc: For historical reasons, this extension is respected regardless of the
    - `core.repositoryFormatVersion` setting.
    - 
    - refStorage:::
    --	Specify the ref storage format to use. The acceptable values are:
    -+	Specify the ref storage format and location to use. The value can be
    -+	either a format name or a URI:
    - +
    - --
    -+* A format name alone (e.g., `reftable` or `files`) uses the default
    -+  location (the repository's common directory).
    -+
    -+* A URI format `<format>://<location>` explicitly specifies both the
    -+  format and payload (e.g., `reftable:///foo/bar`).
    -+
    -+Supported format names are:
    -++
    - include::../ref-storage-format.adoc[]
    -++
    -+The payload is passed directly to the reference backend. For the files and
    -+reftable backends, this must be a filesystem path. Relative paths are resolved
    -+relative to the $GIT_DIR. Future backends may support other payload schemes,
    -+e.g., postgres://127.0.0.1:5432?database=myrepo.
    - --
    - +
    - Note that this setting should only be set by linkgit:git-init[1] or
    -
    - ## builtin/worktree.c ##
    -@@ builtin/worktree.c: static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
    - 	return run_command(&cp);
    - }
    - 
    -+/*
    -+ * References for worktress are generally stored in '$GIT_DIR/worktrees/<wt_id>'.
    -+ * But when using alternate reference directories, we want to store the worktree
    -+ * references in '$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id>'.
    -+ *
    -+ * Create the necessary folder structure to facilitate the same. But to ensure
    -+ * that the former path is still considered a Git directory, add stubs (similar
    -+ *  to how we do in the reftable backend).
    -+ */
    -+static void setup_alternate_ref_dir(struct worktree *wt, const char *wt_git_path)
    -+{
    -+	struct strbuf sb = STRBUF_INIT;
    -+	char *path;
    -+
    -+	path = wt->repo->ref_storage_payload;
    -+	if (!path)
    -+		return;
    -+
    -+	if (!is_absolute_path(path))
    -+		strbuf_addf(&sb, "%s/", wt->repo->commondir);
    -+
    -+	strbuf_addf(&sb, "%s/worktrees", path);
    -+	safe_create_dir(wt->repo, sb.buf, 1);
    -+	strbuf_addf(&sb, "/%s", wt->id);
    -+	safe_create_dir(wt->repo, sb.buf, 1);
    -+	strbuf_reset(&sb);
    -+
    -+	strbuf_addf(&sb, "this worktree stores references in %s/worktrees/%s",
    -+		   path, wt->id);
    -+	refs_create_refdir_stubs(wt->repo, wt_git_path, sb.buf);
    -+
    -+	strbuf_release(&sb);
    -+}
    -+
    - static int add_worktree(const char *path, const char *refname,
    - 			const struct add_opts *opts)
    - {
    -@@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
    - 		ret = error(_("could not find created worktree '%s'"), name);
    - 		goto done;
    - 	}
    -+	setup_alternate_ref_dir(wt, sb_repo.buf);
    - 	wt_refs = get_worktree_ref_store(wt);
    - 
    - 	ret = ref_store_create_on_disk(wt_refs, REF_STORE_CREATE_ON_DISK_IS_WORKTREE, &sb);
    -
      ## refs.c ##
     @@
      #define USE_THE_REPOSITORY_VARIABLE
    @@ refs.c: static struct ref_store *ref_store_init(struct repository *repo,
      		BUG("reference backend is unknown");
      
     -	refs = be->init(repo, gitdir, flags);
    -+	/*
    -+	 * TODO Send in a 'struct worktree' instead of a 'gitdir', and
    -+	 * allow the backend to handle how it wants to deal with worktrees.
    -+	 */
    -+	refs = be->init(repo, repo->ref_storage_payload, gitdir, flags);
    ++	refs = be->init(repo, NULL, gitdir, flags);
      	return refs;
      }
      
    @@ refs/files-backend.c: static void clear_loose_ref_cache(struct files_ref_store *
      	refs->store_flags = flags;
     -	get_common_dir_noenv(&sb, gitdir);
     -	refs->gitcommondir = strbuf_detach(&sb, NULL);
    -+	refs->gitcommondir = xstrdup(ref_common_dir.buf);
    ++	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
      	refs->packed_ref_store =
     -		packed_ref_store_init(repo, refs->gitcommondir, flags);
    -+		packed_ref_store_init(repo, payload, ref_common_dir.buf, flags);
    ++		packed_ref_store_init(repo, payload, refs->gitcommondir, flags);
      	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
      	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
      
    @@ refs/files-backend.c: static struct ref_store *files_ref_store_init(struct repos
      	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
      			      &refs->gitcommondir);
      
    -+	strbuf_release(&ref_common_dir);
     +	strbuf_release(&refdir);
     +
      	return ref_store;
    @@ refs/reftable-backend.c: static struct ref_store *reftable_be_init(struct reposi
      	strbuf_release(&path);
      	return &refs->base;
      }
    -
    - ## t/meson.build ##
    -@@ t/meson.build: integration_tests = [
    -   't1420-lost-found.sh',
    -   't1421-reflog-write.sh',
    -   't1422-show-ref-exists.sh',
    -+  't1423-ref-backend.sh',
    -   't1430-bad-ref-name.sh',
    -   't1450-fsck.sh',
    -   't1451-fsck-buffer.sh',
    -
    - ## t/t1423-ref-backend.sh (new) ##
    -@@
    -+#!/bin/sh
    -+
    -+test_description='Test reference backend URIs'
    -+
    -+. ./test-lib.sh
    -+
    -+# Run a git command with the provided reference storage. Reset the backend
    -+# post running the command.
    -+# Usage: run_with_uri <repo> <backend> <uri> <cmd>
    -+#   <repo> is the relative path to the repo to run the command in.
    -+#   <backend> is the original ref storage of the repo.
    -+#   <uri> is the new URI to be set for the ref storage.
    -+#   <cmd> is the git subcommand to be run in the repository.
    -+run_with_uri() {
    -+	repo=$1 &&
    -+	backend=$2 &&
    -+	uri=$3 &&
    -+	cmd=$4 &&
    -+
    -+	git -C "$repo" config set core.repositoryformatversion 1
    -+	git -C "$repo" config set extensions.refStorage "$uri" &&
    -+	git -C "$repo" $cmd &&
    -+	git -C "$repo" config set extensions.refStorage "$backend"
    -+}
    -+
    -+# Test a repository with a given reference storage by running and comparing
    -+# 'git refs list' before and after setting the new reference backend. If
    -+# err_msg is set, expect the command to fail and grep for the provided err_msg.
    -+# Usage: run_with_uri <repo> <backend> <uri> <cmd>
    -+#   <repo> is the relative path to the repo to run the command in.
    -+#   <backend> is the original ref storage of the repo.
    -+#   <uri> is the new URI to be set for the ref storage.
    -+#   <err_msg> (optional) if set, check if 'git-refs(1)' failed with the provided msg.
    -+test_refs_backend() {
    -+	repo=$1 &&
    -+	backend=$2 &&
    -+	uri=$3 &&
    -+	err_msg=$4 &&
    -+
    -+	git -C "$repo" config set core.repositoryformatversion 1 &&
    -+	if test -n "$err_msg";
    -+	then
    -+		git -C "$repo" config set extensions.refStorage "$uri" &&
    -+		test_must_fail git -C "$repo" refs list 2>err &&
    -+		test_grep "$err_msg" err
    -+	else
    -+		git -C "$repo" refs list >expect &&
    -+		run_with_uri "$repo" "$backend" "$uri" "refs list" >actual &&
    -+		test_cmp expect actual
    -+	fi
    -+}
    -+
    -+test_expect_success 'URI is invalid' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	test_refs_backend repo files "reftable@/home/reftable" \
    -+		"invalid value for ${SQ}extensions.refstorage${SQ}"
    -+'
    -+
    -+test_expect_success 'URI ends with colon' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	test_refs_backend repo files "reftable:" \
    -+		"invalid value for ${SQ}extensions.refstorage${SQ}"
    -+'
    -+
    -+test_expect_success 'unknown reference backend' '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	test_refs_backend repo files "db://.git" \
    -+		"invalid value for ${SQ}extensions.refstorage${SQ}"
    -+'
    -+
    -+ref_formats="files reftable"
    -+for from_format in $ref_formats
    -+do
    -+
    -+for to_format in $ref_formats
    -+do
    -+	if test "$from_format" = "$to_format"
    -+	then
    -+		continue
    -+	fi
    -+
    -+
    -+	for dir in "$(pwd)/repo/.git" "./"
    -+	do
    -+
    -+		test_expect_success "$read from $to_format backend, $dir dir" '
    -+			test_when_finished "rm -rf repo" &&
    -+			git init --ref-format=$from_format repo &&
    -+			(
    -+				cd repo &&
    -+				test_commit 1 &&
    -+				test_commit 2 &&
    -+				test_commit 3 &&
    -+
    -+				git refs migrate --dry-run --ref-format=$to_format >out &&
    -+				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
    -+				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method"
    -+			)
    -+		'
    -+
    -+		test_expect_success "$write to $to_format backend, $dir dir" '
    -+			test_when_finished "rm -rf repo" &&
    -+			git init --ref-format=$from_format repo &&
    -+			(
    -+				cd repo &&
    -+				test_commit 1 &&
    -+				test_commit 2 &&
    -+				test_commit 3 &&
    -+
    -+				git refs migrate --dry-run --ref-format=$to_format >out &&
    -+				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
    -+
    -+				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" &&
    -+
    -+				git refs list >expect &&
    -+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "tag -d 1" &&
    -+				git refs list >actual &&
    -+				test_cmp expect actual &&
    -+
    -+				git refs list | grep -v "refs/tags/1" >expect &&
    -+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "refs list" >actual &&
    -+				test_cmp expect actual
    -+			)
    -+		'
    -+
    -+		test_expect_success "with worktree and $to_format backend, $dir dir" '
    -+			test_when_finished "rm -rf repo wt" &&
    -+			git init --ref-format=$from_format repo &&
    -+			(
    -+				cd repo &&
    -+				test_commit 1 &&
    -+				test_commit 2 &&
    -+				test_commit 3 &&
    -+
    -+				git refs migrate --dry-run --ref-format=$to_format >out &&
    -+				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
    -+
    -+				git config set core.repositoryformatversion 1 &&
    -+				git config set extensions.refStorage "$to_format://$BACKEND_PATH" &&
    -+
    -+				git worktree add ../wt 2
    -+			) &&
    -+
    -+			git -C repo for-each-ref --include-root-refs >expect &&
    -+			git -C wt for-each-ref --include-root-refs >expect &&
    -+			! test_cmp expect actual &&
    -+
    -+			git -C wt rev-parse 2 >expect &&
    -+			git -C wt rev-parse HEAD >actual &&
    -+			test_cmp expect actual
    -+		'
    -+	done # closes dir
    -+done # closes to_format
    -+done # closes from_format
    -+
    -+test_done
1:  77ec79dfc7 ! 3:  630aef7910 refs: allow reference location in refstorage config
    @@ Commit message
         utilize the $GIT_DIR as the reference folder by default in
         `get_main_ref_store()`.
     
    -    Since the reference backends are pluggable, this means that they should
    +    Since the reference backends are pluggable, this means that they could
         work with out-of-tree reference directories too. Extend the 'refStorage'
         config to also support taking an URI input, where users can specify the
         reference backend and the location.
     
         Add the required changes to obtain and propagate this value to the
    -    individual backends. A follow up commit will add the required changes on
    -    the backends to parse this value.
    +    individual backends also add the necessary documentation and tests.
    +
    +    Traditionally, for linked worktrees, references were stored in the
    +    '$GIT_DIR/worktrees/<wt_id>' path. But when using an alternate reference
    +    storage path, it doesn't make sense to store the main worktree
    +    references in the new path, and the linked worktree references in the
    +    $GIT_DIR. So, let's store linked worktree references in
    +    '$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id>'. To do this, create the
    +    necessary files and folders while also adding stubs in the $GIT_DIR path
    +    to ensure that it is still considered a Git directory.
    +
    +    Ideally, we would want to pass in a `struct worktree *` to individual
    +    backends, instead of passing the `gitdir`. This allows them to handle
    +    worktree specific logic. Currently, that is not possible since the
    +    worktree code is:
    +
    +      - Tied to using the global `the_repository` variable.
    +
    +      - Is not setup before the reference database during initialization of
    +        the repository.
    +
    +    Add a TODO in 'refs.c' to ensure we can eventually make that change.
     
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    + ## Documentation/config/extensions.adoc ##
    +@@ Documentation/config/extensions.adoc: For historical reasons, this extension is respected regardless of the
    + `core.repositoryFormatVersion` setting.
    + 
    + refStorage:::
    +-	Specify the ref storage format to use. The acceptable values are:
    ++	Specify the ref storage format and a corresponding payload. The value
    ++	can be either a format name or a URI:
    + +
    + --
    ++* A format name alone (e.g., `reftable` or `files`).
    ++
    ++* A URI format `<format>://<payload>` explicitly specifies both the
    ++  format and payload (e.g., `reftable:///foo/bar`).
    ++
    ++Supported format names are:
    +++
    + include::../ref-storage-format.adoc[]
    +++
    ++The payload is passed directly to the reference backend. For the files and
    ++reftable backends, this must be a filesystem path where the references will
    ++be stored. Defaulting to the commondir when no payload is provided. Relative
    ++paths are resolved relative to the $GIT_DIR. Future backends may support
    ++other payload schemes, e.g., postgres://127.0.0.1:5432?database=myrepo.
    + --
    + +
    + Note that this setting should only be set by linkgit:git-init[1] or
    +
      ## builtin/clone.c ##
     @@ builtin/clone.c: int cmd_clone(int argc,
      	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
    @@ builtin/clone.c: int cmd_clone(int argc,
      	/*
      	 * Before fetching from the remote, download and install bundle
     
    + ## builtin/worktree.c ##
    +@@ builtin/worktree.c: static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
    + 	return run_command(&cp);
    + }
    + 
    ++/*
    ++ * References for worktress are generally stored in '$GIT_DIR/worktrees/<wt_id>'.
    ++ * But when using alternate reference directories, we want to store the worktree
    ++ * references in '$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id>'.
    ++ *
    ++ * Create the necessary folder structure to facilitate the same. But to ensure
    ++ * that the former path is still considered a Git directory, add stubs.
    ++ */
    ++static void setup_alternate_ref_dir(struct worktree *wt, const char *wt_git_path)
    ++{
    ++	struct strbuf sb = STRBUF_INIT;
    ++	char *path;
    ++
    ++	path = wt->repo->ref_storage_payload;
    ++	if (!path)
    ++		return;
    ++
    ++	if (!is_absolute_path(path))
    ++		strbuf_addf(&sb, "%s/", wt->repo->commondir);
    ++
    ++	strbuf_addf(&sb, "%s/worktrees", path);
    ++	safe_create_dir(wt->repo, sb.buf, 1);
    ++	strbuf_addf(&sb, "/%s", wt->id);
    ++	safe_create_dir(wt->repo, sb.buf, 1);
    ++	strbuf_reset(&sb);
    ++
    ++	strbuf_addf(&sb, "this worktree stores references in %s/worktrees/%s",
    ++		   path, wt->id);
    ++	refs_create_refdir_stubs(wt->repo, wt_git_path, sb.buf);
    ++
    ++	strbuf_release(&sb);
    ++}
    ++
    + static int add_worktree(const char *path, const char *refname,
    + 			const struct add_opts *opts)
    + {
    +@@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
    + 		ret = error(_("could not find created worktree '%s'"), name);
    + 		goto done;
    + 	}
    ++	setup_alternate_ref_dir(wt, sb_repo.buf);
    + 	wt_refs = get_worktree_ref_store(wt);
    + 
    + 	ret = ref_store_create_on_disk(wt_refs, REF_STORE_CREATE_ON_DISK_IS_WORKTREE, &sb);
    +
    + ## refs.c ##
    +@@ refs.c: static struct ref_store *ref_store_init(struct repository *repo,
    + 	if (!be)
    + 		BUG("reference backend is unknown");
    + 
    +-	refs = be->init(repo, NULL, gitdir, flags);
    ++	/*
    ++	 * TODO Send in a 'struct worktree' instead of a 'gitdir', and
    ++	 * allow the backend to handle how it wants to deal with worktrees.
    ++	 */
    ++	refs = be->init(repo, repo->ref_storage_payload, gitdir, flags);
    + 	return refs;
    + }
    + 
    +
      ## repository.c ##
     @@ repository.c: void repo_set_compat_hash_algo(struct repository *repo, int algo)
      }
    @@ repository.h: struct repository {
      
      	/* Repository's reference storage format, as serialized on disk. */
      	enum ref_storage_format ref_storage_format;
    -+	/* Reference storage information as needed for the backend. */
    ++	/*
    ++	 * Reference storage information as needed for the backend. This contains
    ++	 * only the payload from the reference URI without the schema.
    ++	 */
     +	char *ref_storage_payload;
      
      	/* A unique-id for tracing purposes. */
    @@ setup.h: void initialize_repository_version(int hash_algo,
      			       const char *initial_branch, int quiet);
      
      /*
    +
    + ## t/meson.build ##
    +@@ t/meson.build: integration_tests = [
    +   't1420-lost-found.sh',
    +   't1421-reflog-write.sh',
    +   't1422-show-ref-exists.sh',
    ++  't1423-ref-backend.sh',
    +   't1430-bad-ref-name.sh',
    +   't1450-fsck.sh',
    +   't1451-fsck-buffer.sh',
    +
    + ## t/t1423-ref-backend.sh (new) ##
    +@@
    ++#!/bin/sh
    ++
    ++test_description='Test reference backend URIs'
    ++
    ++. ./test-lib.sh
    ++
    ++# Run a git command with the provided reference storage. Reset the backend
    ++# post running the command.
    ++# Usage: run_with_uri <repo> <backend> <uri> <cmd>
    ++#   <repo> is the relative path to the repo to run the command in.
    ++#   <backend> is the original ref storage of the repo.
    ++#   <uri> is the new URI to be set for the ref storage.
    ++#   <cmd> is the git subcommand to be run in the repository.
    ++run_with_uri() {
    ++	repo=$1 &&
    ++	backend=$2 &&
    ++	uri=$3 &&
    ++	cmd=$4 &&
    ++
    ++	git -C "$repo" config set core.repositoryformatversion 1
    ++	git -C "$repo" config set extensions.refStorage "$uri" &&
    ++	git -C "$repo" $cmd &&
    ++	git -C "$repo" config set extensions.refStorage "$backend"
    ++}
    ++
    ++# Test a repository with a given reference storage by running and comparing
    ++# 'git refs list' before and after setting the new reference backend. If
    ++# err_msg is set, expect the command to fail and grep for the provided err_msg.
    ++# Usage: run_with_uri <repo> <backend> <uri> <cmd>
    ++#   <repo> is the relative path to the repo to run the command in.
    ++#   <backend> is the original ref storage of the repo.
    ++#   <uri> is the new URI to be set for the ref storage.
    ++#   <err_msg> (optional) if set, check if 'git-refs(1)' failed with the provided msg.
    ++test_refs_backend() {
    ++	repo=$1 &&
    ++	backend=$2 &&
    ++	uri=$3 &&
    ++	err_msg=$4 &&
    ++
    ++	git -C "$repo" config set core.repositoryformatversion 1 &&
    ++	if test -n "$err_msg";
    ++	then
    ++		git -C "$repo" config set extensions.refStorage "$uri" &&
    ++		test_must_fail git -C "$repo" refs list 2>err &&
    ++		test_grep "$err_msg" err
    ++	else
    ++		git -C "$repo" refs list >expect &&
    ++		run_with_uri "$repo" "$backend" "$uri" "refs list" >actual &&
    ++		test_cmp expect actual
    ++	fi
    ++}
    ++
    ++test_expect_success 'URI is invalid' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	test_refs_backend repo files "reftable@/home/reftable" \
    ++		"invalid value for ${SQ}extensions.refstorage${SQ}"
    ++'
    ++
    ++test_expect_success 'URI ends with colon' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	test_refs_backend repo files "reftable:" \
    ++		"invalid value for ${SQ}extensions.refstorage${SQ}"
    ++'
    ++
    ++test_expect_success 'unknown reference backend' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	test_refs_backend repo files "db://.git" \
    ++		"invalid value for ${SQ}extensions.refstorage${SQ}"
    ++'
    ++
    ++ref_formats="files reftable"
    ++for from_format in $ref_formats
    ++do
    ++
    ++for to_format in $ref_formats
    ++do
    ++	if test "$from_format" = "$to_format"
    ++	then
    ++		continue
    ++	fi
    ++
    ++
    ++	for dir in "$(pwd)/repo/.git" "./"
    ++	do
    ++
    ++		test_expect_success "$read from $to_format backend, $dir dir" '
    ++			test_when_finished "rm -rf repo" &&
    ++			git init --ref-format=$from_format repo &&
    ++			(
    ++				cd repo &&
    ++				test_commit 1 &&
    ++				test_commit 2 &&
    ++				test_commit 3 &&
    ++
    ++				git refs migrate --dry-run --ref-format=$to_format >out &&
    ++				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
    ++				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method"
    ++			)
    ++		'
    ++
    ++		test_expect_success "$write to $to_format backend, $dir dir" '
    ++			test_when_finished "rm -rf repo" &&
    ++			git init --ref-format=$from_format repo &&
    ++			(
    ++				cd repo &&
    ++				test_commit 1 &&
    ++				test_commit 2 &&
    ++				test_commit 3 &&
    ++
    ++				git refs migrate --dry-run --ref-format=$to_format >out &&
    ++				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
    ++
    ++				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" &&
    ++
    ++				git refs list >expect &&
    ++				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "tag -d 1" &&
    ++				git refs list >actual &&
    ++				test_cmp expect actual &&
    ++
    ++				git refs list | grep -v "refs/tags/1" >expect &&
    ++				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "refs list" >actual &&
    ++				test_cmp expect actual
    ++			)
    ++		'
    ++
    ++		test_expect_success "with worktree and $to_format backend, $dir dir" '
    ++			test_when_finished "rm -rf repo wt" &&
    ++			git init --ref-format=$from_format repo &&
    ++			(
    ++				cd repo &&
    ++				test_commit 1 &&
    ++				test_commit 2 &&
    ++				test_commit 3 &&
    ++
    ++				git refs migrate --dry-run --ref-format=$to_format >out &&
    ++				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
    ++
    ++				git config set core.repositoryformatversion 1 &&
    ++				git config set extensions.refStorage "$to_format://$BACKEND_PATH" &&
    ++
    ++				git worktree add ../wt 2
    ++			) &&
    ++
    ++			git -C repo for-each-ref --include-root-refs >expect &&
    ++			git -C wt for-each-ref --include-root-refs >expect &&
    ++			! test_cmp expect actual &&
    ++
    ++			git -C wt rev-parse 2 >expect &&
    ++			git -C wt rev-parse HEAD >actual &&
    ++			test_cmp expect actual
    ++		'
    ++	done # closes dir
    ++done # closes to_format
    ++done # closes from_format
    ++
    ++test_done
4:  dbb7d9c632 ! 4:  590bb706dd refs: add GIT_REFERENCE_BACKEND to specify reference backend
    @@ Commit message
         Let's also add a new environment variable 'GIT_REFERENCE_BACKEND' that
         takes in the same input as the config variable. Having an environment
         variable allows us to modify the reference backend and location on the
    -    fly for individual git commands.
    +    fly for individual Git commands.
     
         Helped-by: Jean-Noël Avila <jn.avila@free.fr>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    @@ Documentation/git.adoc: double-quotes and respecting backslash escapes. E.g., th
     +`GIT_REFERENCE_BACKEND`::
     +    Specify which reference backend to be used along with its URI.
     +    See `extensions.refStorage` option in linkgit:git-config[1] for more
    -+    description. Overrides the config variable when used.
    ++    details. Overrides the config variable when used.
     +
      Git Commits
      ~~~~~~~~~~~


base-commit: 22584464849815268419fd9d2eba307362360db1
change-id: 20251105-kn-alternate-ref-dir-3e572e8cd0ef

Thanks
- Karthik


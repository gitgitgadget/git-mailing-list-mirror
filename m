Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C3145FE0
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493912; cv=none; b=X0hyvATlGlihU4Viv5kXW0HS0NM0q0qI3aVPHn/FzJstAZvuN34T1GRI3ExBayISNGfpJBhoXL5Y+OHKsGY+tLoz5mwoOYk1iVjc/3HLXAGMCyoI1PR3lltaKlc3nQLiRIlWId4yiYwM+DgrtbAee2yVfiKIO41vwN6Dl0MlK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493912; c=relaxed/simple;
	bh=MnIDfBZylQyfgrKVS3SJHJ46i4nhUF2tee6EywpS5PI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=l9hL6w83wRIvRdln+VSXS7yigLOIPus9fq51OYid6kkAviIhW2osot+Um0eC17njoBXNShrw3GO0WktZLYTp2J+epLLQnAlfQU84//9gbmcCgr/rISWVbaaT7WEPk5UGkOs8hnhbHayG1T/GOAT+zcGDRLMjOOkfjmd73grrFxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0fVhUqy; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0fVhUqy"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48371119eacso6853945e9.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 01:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771493909; x=1772098709; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EI7zQptxNbXOvDpaS39XwPka947PRVs3dJuifue3m4s=;
        b=d0fVhUqyzHiXRzELuiRwtBJIN6JPAGYX+8QbLLfJCsKgDRToKfGxTNGMxCDfEEZskK
         OXwvaXBk8rSZay2znyExoniSpBjcQ3qP4S1Kix9eEsYf5++IaZWBAakM5m8YBb6vNTdd
         1Fz4m/NVCf0W8ndF7W2WShpEOHSg6BoPZnKLsDD1oQ7axuR9hlZhpodKyXfMtpAIq3wE
         3GH8jdXoXywnJf8pYqWFu9+OsvZXF/pil9/HP6IYzkB6nBbNdSO9aYdlKcoIurwS/2BJ
         wth00zbBA4Iv62nP7AwvkTf7A/Kld7q8gqfCyZ/L7HqQRhyg6fc8oIZ5+Dhu8Plmccui
         FXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493909; x=1772098709;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EI7zQptxNbXOvDpaS39XwPka947PRVs3dJuifue3m4s=;
        b=fgV6oSFJaZLb0IXHAmliO4upJMcwDEu4pNs//JHObLypiMQ0xDrClnI/LubYCuXIlg
         DpcvWBfOLI9ImHvi0ziSUfFxpNdrhV8wz5GtKA/qY8it4svVxZlailoZFnvyxIAXtRR+
         vE4gWZkvlrmyF1LeA6G6shpO5DqBHlT0Cfbqzxx7OjRnXOqay+Mrt2KEdy+Ow2rpFtgk
         bPJ5fNn9tE4wrT/buVtznmQpyHBrorh7B9XMaQqbxXiYNiQfXQzQgVt2J++gzMftn58s
         3ZJ7peNSWKIpkUqpMvUQ6CFDTTbVhD3Dca4iGfnc9ai2O3ET8H3bNFrvsATA6L6XU2ZW
         g44Q==
X-Gm-Message-State: AOJu0Yy11QW5Yc5Vv0YcLlIyHJCicKIrPNq3281pOnXHdV3E6YYYFmiO
	BnBVpzuwqwVWGC/pvrxw6c5+lfTpslIIlMNRge3wWteAHHyQ3VrKDgFi
X-Gm-Gg: AZuq6aJw8mwPPmgVlRf6h2toVp3bl8UwWAU79k2DT1bY25vuPv6QLvipss4yXgmxQ6A
	ep719N+Jlpcc44Fdld02RUz+ZygNtP5GpQhdauVuiDkRD6sEbHF05WPtF8f11c3ZQE4xHAv5n3S
	CHuTWrnB3ehnJ0IcCrmLsmBMW7d5C95flq1Zy2SbRnz/SDe/asIRVvrGnQIw5aWe5fqm1OZNnwT
	Nh8TjPjSY3nEKoAoAYwAv7xNHn1qhJiogh8MDdFThGxpmj2kK4vKlp5+j475co402CCuq7XwrRt
	+bheMXP4rTW1hCs34MblHnx1TLqo9PUGYyrBuiz8Whi8spgoV5ILQy50QgSESRWqkXJfjQrhh35
	3lEheSR+Py45+r7k7MwGVKTUiXqBj3h2EG3mj7nEnbpXObypoHFhXwnX7TQGe9nXCMBA4EQ1Vp/
	QGsNP/R0Ok/kCLKZ4UqfMyd3ou9i11fw==
X-Received: by 2002:a05:600c:474c:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-48398b79afemr85294035e9.31.1771493908150;
        Thu, 19 Feb 2026 01:38:28 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1ea7:2b8f:9148:411a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm694274985e9.7.2026.02.19.01.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 01:38:27 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 0/6] refs: allow setting the reference directory
Date: Thu, 19 Feb 2026 10:38:19 +0100
Message-Id: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAvalmkC/3XQ32rDIBQG8FcpXs/h8V+0V3uP0Qs1x1bWJsOEs
 FLy7jspGwthARG+c/AnfA82YC04sOPhwSpOZSh9R6F5ObB0Cd0ZeWkpMymkARCGf3Q8XEesXRi
 RV8y8LZUrNI1El1qBmdHTT1qUryf7fqJ8KcPY1/vzlwmW6Q8I/n9wAi64TlkHr5OL2L6db6FcX
 1N/Yws4yRUi7Q4iCXHRZ5vBZavMFlF/iBSwgyhCEkD02sYkc9gi+hexgq4dRBOiohKaDgCqLWL
 WyF4nhpBGC+e9Uzph3CJ2hYDeQezSiQ1OpqZJ2fg1Ms/zN2M3F9kRAgAA
X-Change-ID: 20251105-kn-alternate-ref-dir-3e572e8cd0ef
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 toon@iotcl.com, =?utf-8?q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12776;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=MnIDfBZylQyfgrKVS3SJHJ46i4nhUF2tee6EywpS5PI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmW2hL0JlXyIvo+aXmbiIDfDHLG7DpwJKsmJ
 WrBAx5biZYvVIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpltoSAAoJED7VnySO
 Rox/YLAL/jIlfefH/0eNHQR1t4jswcP+uK+S6SghBdXKXlFxFHkLBy6bIBfvV4ZMXn3GemzuDd7
 NbeZQHa1OBsvEofmAErS+ILWviqZAZ+5xokHJ58Ca7gXNiRchrRFIH7PBcZzodpSqa47VRRxflI
 sqxRrtJlAojDdvQOe3d70Ci9xb6Zg1iVYsVjM56QuHoS6QgZN39bc+Vbkx6bj/DzK/PeiOgn4of
 3WTebK/+xGCVC7tPWe1RUbozD0oDw7/rAhdsDcb4UXecxYK5M1Vz8PYi6tY8+BPEl0v1qVLUpni
 yRuW7YOgwjvIVJ/OGX0iEeq3SGr6JM6HMOudhpKHKygKLnWJx94SSDIhfQZIzVTHQx9JL5CQAMt
 2Q4YaEyxVNsHHp2eywx5l682TQLLrMU/kdvXIAQNRn0n/9WmPsuRKFUS2AD9XxMn3Lki5IJUA2C
 PG5j9s4vouK8i8tHJuDNsob3S5gvF8ePpO8vl0wvxGvx+cwLrhwO2FFCkGqc9QpddcKOZNsbzj5
 7c=
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
Changes in v7:
- Add more details in the commit messages.
- Cleanup some whitespace.
- Reorder the commits to be group related changes together.
- Add checks for stubs in the tests when creating new repos.
- Link to v6: https://patch.msgid.link/20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com

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
 Documentation/config/extensions.adoc |  16 +-
 Documentation/git.adoc               |   5 +
 builtin/clone.c                      |   9 +-
 builtin/worktree.c                   |  34 +++++
 environment.h                        |   1 +
 refs.c                               | 126 +++++++++++++++-
 refs.h                               |  13 ++
 refs/files-backend.c                 |  23 ++-
 refs/packed-backend.c                |   5 +
 refs/packed-backend.h                |   1 +
 refs/refs-internal.h                 |  14 ++
 refs/reftable-backend.c              |  61 ++------
 repository.c                         |   9 +-
 repository.h                         |   8 +-
 setup.c                              |  96 ++++++++++--
 setup.h                              |   4 +-
 t/meson.build                        |   1 +
 t/t1423-ref-backend.sh               | 282 +++++++++++++++++++++++++++++++++++
 18 files changed, 627 insertions(+), 81 deletions(-)

Karthik Nayak (6):
      setup: don't modify repo in `create_reference_database()`
      refs: extract out `refs_create_refdir_stubs()`
      refs: move out stub modification to generic layer
      refs: receive and use the reference storage payload
      refs: allow reference location in refstorage config
      refs: add GIT_REFERENCE_BACKEND to specify reference backend

Range-diff versus v6:

1:  bbc8d0678c ! 1:  d958e2597e setup: don't modify repo in `create_reference_database()`
    @@ Commit message
         dynamically allocated strings, where we would free/allocate the same
         string back into `the_repostiory`.
     
    -    To avoid all this confusion, clean up the function to longer take in and
    -    set the repo's reference storage format.
    +    To avoid all this confusion, clean up the function to no longer take in
    +    and set the repo's reference storage format.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
2:  4f868d2f4c = 2:  f6583f00b1 refs: extract out `refs_create_refdir_stubs()`
4:  6e4c372402 ! 3:  bffb0ede9d refs: move out stub modification to generic layer
    @@ Commit message
         ensure that the directory can be recognized as a Git repository. This is
         done by calling `refs_create_refdir_stubs()`. Move this to the generic
         layer as this is needed for all backends excluding from the files
    -    backends. In an upcoming commit, we'll also need to extend this logic to
    -    create stubs when using alternate reference directories.
    +    backends. In an upcoming commit where we introduce alternate reference
    +    backend locations, we'll have to also create stubs in the $GIT_DIR
    +    irrespective of the backend being used. This commit builds the base to
    +    add that logic.
     
         Similarly, move the logic for deletion of stubs to the generic layer.
         The files backend recursively calls the remove function of the
    @@ refs.c: void refs_create_refdir_stubs(struct repository *repo, const char *refdi
     -	return refs->be->remove_on_disk(refs, err);
     +	int ret = refs->be->remove_on_disk(refs, err);
     +
    -+	if (!ret) {
    -+		enum ref_storage_format format = ref_storage_format_by_name(refs->be->name);
    ++	if (!ret &&
    ++	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
     +		struct strbuf sb = STRBUF_INIT;
     +
    -+		/* Backends apart from the files backend create stubs. */
    -+		if (format == REF_STORAGE_FORMAT_FILES)
    -+			return ret;
    -+
     +		strbuf_addf(&sb, "%s/HEAD", refs->gitdir);
     +		if (unlink(sb.buf) < 0) {
     +			strbuf_addf(err, "could not delete stub HEAD: %s",
3:  363e36875b ! 4:  a7d4c22861 refs: receive and use the reference storage payload
    @@ refs.c: const char *ref_transaction_error_msg(enum ref_transaction_error err)
     +	if (*is_worktree) {
     +		const char *wt_id = strrchr(gitdir, '/');
     +		if (!wt_id)
    -+			BUG("worktree path does not contain slash ");
    ++			BUG("worktree path does not contain slash");
     +		strbuf_addf(refdir, "/worktrees/%s", wt_id + 1);
     +	}
     +
5:  da04b77ed6 = 5:  dca8fc6b77 refs: allow reference location in refstorage config
6:  78b9589da7 ! 6:  d515ab78e3 refs: add GIT_REFERENCE_BACKEND to specify reference backend
    @@ refs.c: int ref_store_create_on_disk(struct ref_store *refs, int flags, struct s
      	}
      
      	return ret;
    -+
    - }
    - 
    - int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err)
     @@ refs.c: int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err)
    - 		if (format == REF_STORAGE_FORMAT_FILES)
    - 			return ret;
    + {
    + 	int ret = refs->be->remove_on_disk(refs, err);
    + 
    +-	if (!ret &&
    +-	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
    ++	if (!ret) {
    ++		enum ref_storage_format format = ref_storage_format_by_name(refs->be->name);
    + 		struct strbuf sb = STRBUF_INIT;
      
    ++		/* Backends apart from the files backend create stubs. */
    ++		if (format == REF_STORAGE_FORMAT_FILES)
    ++			return ret;
    ++
     +		/* Alternate refs backend require stubs in the gitdir. */
     +		if (refs->repo->ref_storage_payload)
     +			return ret;
    @@ t/t1423-ref-backend.sh: run_with_uri() {
      }
      
     -test_expect_success 'URI is invalid' '
    ++# Verify that the expected files are present in the gitdir and the refsdir.
    ++# Usage: verify_files_exist <gitdir> <refdir>
    ++#   <gitdir> is the path for the gitdir.
    ++#   <refdir> is the path for the refdir.
    ++verify_files_exist() {
    ++	gitdir=$1 &&
    ++	refdir=$2 &&
    ++
    ++	# verify that the stubs were added to the $GITDIR.
    ++	cat $gitdir/refs/heads >actual &&
    ++	echo "repository uses alternate refs storage" >expect &&
    ++	test_cmp expect actual &&
    ++	cat $gitdir/HEAD >actual &&
    ++	echo "ref: refs/heads/.invalid" >expect &&
    ++	test_cmp expect actual
    ++
    ++	# verify that backend specific files exist.
    ++	case "$GIT_DEFAULT_REF_FORMAT" in
    ++	files)
    ++		test_path_is_dir $refdir/refs/heads &&
    ++		test_path_is_file $refdir/HEAD;;
    ++	reftable)
    ++		test_path_is_dir $refdir/reftable &&
    ++		test_path_is_file $refdir/reftable/tables.list;;
    ++	*)
    ++		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
    ++	esac
    ++}
    ++
     +methods="config env"
     +for method in $methods
     +do
    @@ t/t1423-ref-backend.sh: do
     +	mkdir refdir &&
     +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
     +	GIT_REFERENCE_BACKEND=$BACKEND git init repo &&
    ++	verify_files_exist repo/.git refdir &&
     +	(
     +		cd repo &&
     +
    @@ t/t1423-ref-backend.sh: do
     +	echo $BACKEND >actual &&
     +	test_cmp expect actual &&
     +
    ++	verify_files_exist repo/.git refdir &&
    ++
     +	git -C source for-each-ref refs/tags/ >expect &&
     +	git -C repo for-each-ref refs/tags/ >actual &&
     +	test_cmp expect actual


base-commit: 22584464849815268419fd9d2eba307362360db1
change-id: 20251105-kn-alternate-ref-dir-3e572e8cd0ef

Thanks
- Karthik


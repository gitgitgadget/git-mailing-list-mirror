Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87B3ED5C7
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929426; cv=none; b=PR2ygQJfWK5dchxOUwTogRsL5uxJvwUpooSS6B8w+ub0KE1LsiQvGW7U7B4GzJaQhpM/IFethvwBlQydiQeIGVgm+v/507mTizGXY7s+8ypF//QHNT5zxOR4zb91orHoQ0Ouuse5ZHiNPl7QaeNJvtZrdf13DQICpAZQD2UeFEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929426; c=relaxed/simple;
	bh=83D/Ae+gDksAgLtZ/D9HpClnI4H/beDaDZSbs4U99rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjRhgxbZii2uBV5wSjK5sJXzhoS5NH1d7KU5lrm9O/hlIKeraE0I6lR3kMn2m+L0KBeE7gmQHdRzCWCMTbQa+r+Iyyqcyk+dRGfQE5YpNdG3QuG3TXjccrk7BbpKJPyPU1kvZUktStLb/j29D3yhkkS7I3cMpx7pXchPzzAWGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3biF2L9; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3biF2L9"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b0591cf85so1178704f8f.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 01:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790929422; x=1791534222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EO/7K765MyqpmemzaHhRh8/suEAa46A+4g3nZZP3dIw=;
        b=s3biF2L9ZYp9oRkHah4OrMLt4CIy0vcaldTaB4ZUdZGpib9uyeLe6kq2rghl95R/5z
         7atcNxuAOmGUaVTyKhEkkOc1doBxeIJ5eXnDxIC43xlBYiEtpU1MYB4WHTvXuE93Fgh4
         EdnnM/WPcaBdt5N5Z+9sOgFLJVwi8vzn3qfrk5pg5FeuBdLufyXTS3d9QNsio4JUX/Hs
         xel3fYbThsbQIiVUkzRaHawLdQHhU89OW94Bg8AaYxKZBqUKPS6N6R68ubpUSUCdSfy/
         PLge2DLmJT7h2Jm3XACna0JF2skLGvLq1noEPPXIpOR4EtYHCNEPC8YsaoNHIS6k4wZU
         qa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929422; x=1791534222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EO/7K765MyqpmemzaHhRh8/suEAa46A+4g3nZZP3dIw=;
        b=iSPZh89kHac3BUmNAajw9x+5wq6lGzslnGXyWfoWr+GgrOYIYf5on9follAGQrO0d5
         NO1iavpMvuWFoe9GxSL1ntyt9O1qvClNLdYzHdTtZGd8P/KSefdUZXPTqfZfWnaRDjCs
         +q6BIMa2kRQUJdSu7cHdCia4iyJo99jVwcDslFRfpUB2HoukmeZ85meT6pXmkRMF11Z+
         9G34SOK8KK5myqv1EiJLewiOcbVU0LLwy9GwZ966Dg1dobz+Wxp+JiHvkOGnxhvpVN5H
         YyuKT8emQdZb08rYWHNUoQ30fLnV5h6ufEMbBL2REFyr5kb5p+Neko3r6UFXTKPJIYG2
         Suhg==
X-Gm-Message-State: AFq9FYJh4R4dsuxtMmZYfH/zhKBkDtzP+ARxzBYhdrH6ew7nQRPERFUI
	H0M+L+6sluNVPJK11JZgdjVP0fEBmi/pB4ZYESwOUCnmp5jsxyfaG1dAqvquOQ==
X-Gm-Gg: AYBFou2TkSpyA1YwSfmglSRbiOsYOGWqEx45dutL+7tqa5GE7E28z9a9yRnvLut+y6/
	gK5iJA/WXF/4bkIeR8yMTEM4aJfEKM7olr3QAxaJf8nQmHRSulOHmhSmf9Lr4C+HTl94bmxkDQf
	HsfDhrFOGWI6DUcd7BnCx/96NkOAIBuKhND9Q7G0qJ5Vwbne6A/QHCcCJp7pJ08GJWi5d4HrEEf
	Gm6lrj/IWxAwM+1oeD/NAlqpA7RBsTi1aGJGDJv2xzNC4S/MKypaAcKA5X416eGagCEqJAGerLB
	gZ22QpOlNepD938uRwEIlKsJLx8SUOZLKc1gNNLdASq0+kdXBadwL1a/qXUuOaY7zG7AyVef28O
	pqlxU8Q2XnCSulPTuWqfbRhbdB3zmulx66PphNAEmuuO/NWsd8rebwVwDfPCQbxqJEjUIC35d0k
	xgBwb5b8aM8pyg3/8JnyCU4zL5SVpF7K7NatvN0tazqWgXXUczCuFnWpRdoOEgVqelNkjuhlETz
	3nTU8CtnOSrUDeSWCJEEMJeNsj/OMEHJ6n6km0BIhN0x0REtb/e3615xBU5kJ3MEGmjVTkrjKEX
	mBJ5FtNZAv2h1Hu4eaqJGKXutJGp3kRINA1WTGEbq8OuMfVXqWwk7DZ7Ja1QDFYcTbY2hLajkv0
	/hCMqFpV4
X-Received: by 2002:a5d:64cf:0:b0:48b:11df:c496 with SMTP id ffacd0b85a97d-48b12716ee0mr3814285f8f.28.1790929421489;
        Fri, 02 Oct 2026 01:23:41 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8ab4sm3905817f8f.35.2026.10.02.01.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:23:40 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 0/5] Introduce 'uploadpack.lazyFetchTrusted'
Date: Fri,  2 Oct 2026 10:23:17 +0200
Message-ID: <20261002082322.2682869-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.20.g34f06850c1
In-Reply-To: <20260928133846.2094261-1-christian.couder@gmail.com>
References: <20260928133846.2094261-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently the "promisor-remote" capability was added to protocol v2,
allowing servers and clients to agree on the promisor remotes they can
safely use.

The more servers use promisor remotes, the more it is important to
properly control if they can lazy fetch when responding to a clone or
fetch request from the client.

For example, in the context of large object promisors (see
"Documentation/technical/large-object-promisors.adoc"), if a client
clones with a filter set to 100kB while the server has moved all of
the blobs >= 10kB to a promisor remote, the server will not be able to
provide blobs between 10kB and 100kB to the client, which will make
the clone fail.

Even if the `--filter=auto` option is available since ef2f1845ec
(fetch-pack: wire up and enable auto filter logic, 2026-02-16) it's
still a good idea to provide more control over lazy fetching on the
server side to server operators, as lazy fetching on the server side
could be useful in corporate environments.

Since 7b70e9efb1 (upload-pack: disable lazy-fetching by default,
2024-04-16), lazy fetching has been controlled by the
`GIT_NO_LAZY_FETCH` environment variable. This is a boolean that is
set to 'true' by default when calling `git upload-pack` for security
reasons.

The main security issue on the server side is making sure the served
repo itself is also trusted, as lazily fetching runs `git fetch`,
which may execute arbitrary commands specified in the configuration
and hooks of the served repo. The operator of the server should decide
and mark that trust, not the served repo itself, nor the client.

This series introduces a new 'uploadpack.lazyFetchTrusted' protected
configuration variable similar to 'safe.directory' (see
"Documentation/config/safe.adoc") to mark trusted repos where lazy
fetching is allowed. As it is protected, this config variable will
only take effect if it is set in global or system scope, so only
server operators can control it.

Previous related work
=====================

A previous series called "Introduce a 'fromAccepted' option to
GIT_NO_LAZY_FETCH" [1] took a different approach as it wanted to make
it easier to allow lazy fetching from accepted promisor remotes. But
after brian replied that he didn't think it was a good idea, and after
thinking about this more, my opinion now is that some promisor remotes
being accepted or not is not really relevant to the issue.

In my reply to brian, I said:

"""
Different features could be developed (in future work) to improve on
the current state:
    - a way for lazy fetching to work without reading config files,
triggering hooks, or doing potentially sensitive things,
    - an explicit way for operators to mark trusted repos (like
perhaps a server-side config the operator sets per-repo),
    - operator-defined allow/deny rules, or maybe
    - some ways/scripts/commands to scan repos and check configuration
information, remote settings and everything potentially sensitive to
decide if a repo looks safe enough to allow lazy fetching or not.
"""

So I decided to go with "an explicit way for operators to mark trusted
repos" and this series is an implementation of that.

Note that the feature developed in this series applies to protocol
v0/v1 as well as v2 while the previous one was only related to v2.

[1]: https://lore.kernel.org/git/CAP8UFD0_S9eg_w42tcNRnT9E2ntLr_eHLnzE4c2dSu67DzZoXg@mail.gmail.com/

Overview of the patches
=======================

  - Patch 1/5 is the only patch saved from the "Introduce a
    'fromAccepted' option to GIT_NO_LAZY_FETCH" series. It's not
    necessary for the rest of this series and its main feature to
    work, but I think it's a nice refactoring related to lazy
    fetching, so it might as well be part of this series.

  - Patch 2/5 extracts and modifies code used by the 'safe.directory'
    config variable in new path_allowlist_config_apply() and
    path_allowlist_apply() functions, so that these functions can be
    reused to process 'uploadpack.lazyFetchTrusted' in the next patch.

  - Patch 3/5 uses the new functions from the previous patch in a new
    upload_pack_lazy_fetch_trusted() function to process
    'uploadpack.lazyFetchTrusted', but the result from that processing
    isn't actually used to have a practical effect.

  - Patch 4/5 prevents infinite lazy fetch recursions that the
    following patch would otherwise make possible. If a repo is
    allowed to lazy fetch and one of its promisor remotes resolves
    back to it, for example if it is its own promisor remote as Junio
    noticed when reviewing v2, each nested `upload-pack` inherits
    `GIT_NO_LAZY_FETCH=0` and fetches again.

  - Patch 5/5 wires up the new upload_pack_lazy_fetch_trusted()
    function to decide if lazy fetching can actually be enabled.

Changes since v4
================

Thanks to Junio for reviewing previous versions of this series.

Rebased on top of a018953688 (Git 2.56, 2026-09-27) to be on a stable
base.

There are no functional code changes compared to v4. Only code
comments, documentation, tests and commit messages have changed, and
those changes are relatively small.

 - In patch 2/5, a NEEDSWORK code comment has been added to say that
   we may want to warn in case of a missing path unless that path is
   marked with an ":(optional)" prefix. Also the commit message
   now mentions that NEEDSWORK code comment.

 - In the commit message of patch 3/5 and the documentation in patch
   5/5, the way a repository is identified by its git directory is
   worded more correctly and explained in more detail respectively. A
   test for the case where a repo is initialized using
   `--separate-git-dir=...` is added to the tests in patch 5/5.

 - In patch 5/5:

   - In both "uploadpack.adoc" and "git-upload-pack.adoc", as well as
     the commit message, it is now explained that while setting
     `GIT_NO_LAZY_FETCH` to 0 propagates to promisor remotes (on the
     same machine) which could also want to lazily fetch in turn,
     setting "uploadpack.lazyFetchTrusted" doesn't. A test is also
     added to check that.

   - "uploadpack.lazyFetchTrusted" is now described as "A multi-valued
     configuration variable, each value of which specifies the
     absolute local path of a repository ..." which fixes the grammar
     of "each of which".

   - "i.e." and "e.g." are now followed by a comma.

   - The test called "uploadpack.lazyFetchTrusted needs the git dir of
     a non-bare repo" now cleans up the "nonbare-pack-*" files it
     generates.

CI tests
========

They all pass, see:

https://github.com/chriscool/git/actions/runs/36861893004

Range-diff compared to v4
=========================

1:  e7332d0aa4 = 1:  d03dbba92c promisor-remote: factor out lazy_fetch_objects()
2:  b4a63e3e4e ! 2:  a067c2396b setup: extract path_allowlist_apply()
    @@ Commit message
     
         While at it let's make the helper's code simpler and more generic, by
         passing it a `bool (*allow_path)(const char *path, void *cbdata)`
    -    function that decides if a path is acceptable by the caller.
    +    function that decides if a path is acceptable by the caller, and let's
    +    add a NEEDSWORK comment about it silently ignoring missing, possibly
    +    misspelled, paths.
     
         To further simplify how to reuse that new helper, and avoid duplicating
         the config-value handling in a future commit, let's also introduce a
    @@ setup.c: static int canonicalize_ceiling_entry(struct string_list_item *item,
     +	 * exist as paths on all of these machines.  In other words,
     +	 * it is not a warning worthy event when there is no such path
     +	 * on this machine---the entry may be useful elsewhere.
    ++	 *
    ++	 * NEEDSWORK: this also silently ignores misspelled paths. We
    ++	 * may want to warn about a missing path unless it is marked
    ++	 * as allowed to be missing, e.g., with an ":(optional)"
    ++	 * prefix like pathname-typed configuration values, and hint
    ++	 * about that prefix in the warning.
     +	 */
     +	normalized = real_pathdup(allowed, 0);
     +	if (!normalized)
3:  1e2d2d4b4f ! 3:  1c489de88f upload-pack: read uploadpack.lazyFetchTrusted
    @@ Commit message
         instead of the usual repository discovery, so it never learns about a
         worktree and `r->worktree` is always NULL there. In practice this
         means that a non-bare repository served as "/srv/repo" has to be
    -    allowlisted as "/srv/repo/.git".
    +    allowlisted as "/srv/repo/.git" (or as the directory its ".git" file
    +    points to, if it has a ".git" file instead of a ".git" directory).
     
         The new upload_pack_lazy_fetch_trusted() function will be used in a
         following commit.
4:  3e88ec41a4 = 4:  69592b1b86 promisor-remote: prevent infinite recursion when lazy fetching
5:  ad8814984b ! 5:  6d0e72c357 builtin/upload-pack: don't disable lazy fetching on trusted repo
    @@ Commit message
         a client trusts the repo it fetches from is a separate matter, and up
         to the client.
     
    -    As `GIT_NO_LAZY_FETCH` is passed down to child processes through the
    -    environment, this works for `pack-objects`, which performs the lazy
    -    fetch when serving a client, without any further plumbing.
    +    As `pack-objects`, which performs the lazy fetch when serving a
    +    client, is a child process of `upload-pack`, not setting
    +    `GIT_NO_LAZY_FETCH` in `upload-pack` is enough for it to be allowed to
    +    lazily fetch, without any further plumbing.
    +
    +    On the other hand, as we leave `GIT_NO_LAZY_FETCH` unset for a trusted
    +    repo instead of setting it to 0, the trust doesn't propagate: if a
    +    trusted repo lazily fetches from a promisor remote that is itself
    +    served by `upload-pack` on the same machine, that nested `upload-pack`
    +    decides for its own repo. This is unlike when a server operator sets
    +    `GIT_NO_LAZY_FETCH` to 0, as that is inherited by all child processes.
     
         Now that "uploadpack.lazyFetchTrusted" is actually doing something,
    -    let's document it and reference it from GIT_NO_LAZY_FETCH's docs.
    +    let's document it (including this difference with `GIT_NO_LAZY_FETCH`),
    +    let's reference it from `GIT_NO_LAZY_FETCH`'s docs, and let's add tests
    +    for it.
     
         Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
    @@ Documentation/config/uploadpack.adoc: uploadpack.allowRefInWant::
      	replication delay.
     +
     +uploadpack.lazyFetchTrusted::
    -+	A multi-valued configuration variable, each of which contains the
    -+	absolute local path of a repository that `upload-pack` is allowed to
    -+	lazily fetch missing objects for.
    ++	A multi-valued configuration variable, each value of which
    ++	specifies the absolute local path of a repository that
    ++	`upload-pack` is allowed to lazily fetch missing objects for.
     ++
    -+A repository is identified by its git directory, i.e. the `.git`
    -+directory of a repository that has a worktree, or the repository itself
    -+if it is bare. So a non-bare repository served as `/srv/repo` has to be
    -+allowlisted as `/srv/repo/.git`. Giving a path with `/*` appended to it
    -+will trust all repositories under the named directory. To trust all
    -+served repositories, set `uploadpack.lazyFetchTrusted` to the string
    -+`*`.
    ++A repository is identified by its git directory, after following any
    ++`.git` file and resolving symbolic links. That is the repository
    ++itself if it is bare, the `.git` directory of a repository that has a
    ++worktree, or the directory that a `.git` file points to, for example
    ++when the repository was created with `--separate-git-dir` or for a
    ++linked worktree (see linkgit:git-worktree[1]). So a non-bare
    ++repository served as `/srv/repo` usually has to be allowlisted as
    ++`/srv/repo/.git`. Giving a path with `/*` appended to it will trust
    ++all repositories under the named directory. To trust all served
    ++repositories, set `uploadpack.lazyFetchTrusted` to the string `*`.
     ++
    -+The value of this setting is interpolated, i.e. `~/<path>` expands to a
    -+path relative to the home directory and `%(prefix)/<path>` expands to a
    -+path relative to Git's (runtime) prefix.
    ++The value of this setting is interpolated, i.e., `~/<path>` expands to
    ++a path relative to the home directory and `%(prefix)/<path>` expands
    ++to a path relative to Git's (runtime) prefix.
     ++
     +By default, `upload-pack` refuses to lazily fetch (see the description
     +of the `GIT_NO_LAZY_FETCH` environment variable in
    @@ Documentation/config/uploadpack.adoc: uploadpack.allowRefInWant::
     +which may execute arbitrary commands specified in the configuration
     +and hooks of the served repository. Listing a repository here tells
     +`upload-pack` that it is trusted, so lazy fetching from the promisor
    -+remotes configured in it is allowed. This is equivalent to setting
    -+`GIT_NO_LAZY_FETCH` to `0` for the matching repositories. An
    ++remotes configured in it is allowed. This is similar to setting
    ++`GIT_NO_LAZY_FETCH` to `0`, but only for the matching repositories:
    ++unlike that environment variable, the trust is not inherited by child
    ++processes. So if a trusted repository lazily fetches from a promisor
    ++remote that is itself served by `upload-pack` on the same machine,
    ++for example through a local path or a `file://` URL, lazy fetching is
    ++allowed there only if that promisor remote is also listed here. An
     +explicitly set `GIT_NO_LAZY_FETCH` takes precedence over this setting.
     ++
     +Note that this allows lazy fetching from any promisor remote
    @@ Documentation/config/uploadpack.adoc: uploadpack.allowRefInWant::
     ++
     +As this is a multi-valued setting, you can add more than one
     +repository via `git config (--global|--system) --add`. To reset the
    -+list of trusted repositories (e.g. to override any such repositories
    ++list of trusted repositories (e.g., to override any such repositories
     +specified in the system config), add an `uploadpack.lazyFetchTrusted`
     +entry with an empty value.
     ++
    @@ Documentation/config/uploadpack.adoc: uploadpack.allowRefInWant::
     
      ## Documentation/git-upload-pack.adoc ##
     @@ Documentation/git-upload-pack.adoc: This is implemented by having `upload-pack` internally set the
    + `GIT_NO_LAZY_FETCH` variable to `1`. If you want to override it
      (because you are fetching from a partial clone, and you are sure
      you trust it), you can explicitly set `GIT_NO_LAZY_FETCH` to
    - `0`.
    +-`0`.
    ++`0`. As it is an environment variable, it is also inherited by child
    ++processes, including any `upload-pack` run to lazily fetch from a
    ++promisor remote on the same machine.
     ++
     +Instead of setting `GIT_NO_LAZY_FETCH` to `0` in the environment, a
     +server operator can allow lazy fetching on a per-repository basis by
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
     +'
     +
     +test_expect_success "uploadpack.lazyFetchTrusted needs the git dir of a non-bare repo" '
    -+	test_when_finished "rm -rf nonbare client client2" &&
    ++	test_when_finished "rm -rf nonbare nonbare-pack-* client client2" &&
     +
     +	# Create a non-bare repo, without any worktree content, so that
     +	# its largest object can be filtered out below
    @@ t/t5710-promisor-remote-capability.sh: test_expect_success "clone with promisor.
     +	git clone --no-local --filter="blob:limit=1k" nonbare client2 &&
     +	check_missing_objects nonbare 0 ""
     +'
    ++
    ++test_expect_success "uploadpack.lazyFetchTrusted needs the git dir a .git file points to" '
    ++	test_when_finished "rm -rf sepwt sepgit sep-pack-* client client2" &&
    ++
    ++	# Create a non-bare repo with a ".git" file pointing to a
    ++	# separate git dir, without any worktree content, so that its
    ++	# largest object can be filtered out below
    ++	git init --separate-git-dir="$(pwd)/sepgit" sepwt &&
    ++	test_path_is_file sepwt/.git &&
    ++	git -C sepwt remote add origin "$TRASH_DIRECTORY_URL/template" &&
    ++	git -C sepwt fetch origin &&
    ++	git -C sepwt update-ref HEAD FETCH_HEAD &&
    ++
    ++	git -C sepwt remote add lop "$TRASH_DIRECTORY_URL/lop" &&
    ++	git -C sepwt config remote.lop.promisor true &&
    ++	git -C sepwt config uploadpack.allowFilter true &&
    ++	git -C sepwt config uploadpack.allowAnySHA1InWant true &&
    ++	git -C sepwt config promisor.advertise false &&
    ++
    ++	# Repack everything, then repack without the largest object and
    ++	# create a promisor pack, like initialize_server() does
    ++	git -C sepwt -c repack.writebitmaps=false repack -a -d &&
    ++	rm -f sepgit/objects/pack/*.promisor &&
    ++	git -C sepwt -c repack.writebitmaps=false repack -a -d \
    ++		--filter=blob:limit=5k --filter-to="$(pwd)/sep-pack" &&
    ++	promisor_file=$(ls sepgit/objects/pack/*.pack | sed "s/\.pack/.promisor/") &&
    ++	>"$promisor_file" &&
    ++	check_missing_objects sepwt 1 "$oid" &&
    ++
    ++	# The ".git" file does not identify the repo, so it is not
    ++	# trusted and the clone fails
    ++	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/sepwt/.git" &&
    ++	test_must_fail git clone --no-local --filter="blob:limit=1k" \
    ++		sepwt client 2>err &&
    ++	test_grep "lazy fetching disabled" err &&
    ++	check_missing_objects sepwt 1 "$oid" &&
    ++
    ++	# The git dir the ".git" file points to identifies the repo, so
    ++	# it is trusted and the clone succeeds
    ++	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/sepgit" &&
    ++	git clone --no-local --filter="blob:limit=1k" sepwt client2 &&
    ++	check_missing_objects sepwt 0 ""
    ++'
    ++
    ++test_expect_success "uploadpack.lazyFetchTrusted trust does not propagate to promisor remotes" '
    ++	# No promisors are advertised
    ++	git -C server config promisor.advertise false &&
    ++	test_when_finished "rm -rf client lop2" &&
    ++
    ++	# Create "lop2", a partial clone that is also missing the
    ++	# largest object, and that can lazily fetch it from "lop"
    ++	test_config -C template uploadpack.allowFilter true &&
    ++	git clone --bare --no-local --filter="blob:limit=5k" \
    ++		"$TRASH_DIRECTORY_URL/template" lop2 &&
    ++	git -C lop2 remote set-url origin "$TRASH_DIRECTORY_URL/lop" &&
    ++	git -C lop2 config uploadpack.allowFilter true &&
    ++	git -C lop2 config uploadpack.allowAnySHA1InWant true &&
    ++	check_missing_objects lop2 1 "$oid" &&
    ++
    ++	# Make "lop2" the only promisor remote of the server. Note that
    ++	# "remote.lop.partialCloneFilter" also makes "lop" a promisor
    ++	# remote, so it has to be unset too.
    ++	git -C server remote add lop2 "$TRASH_DIRECTORY_URL/lop2" &&
    ++	git -C server config remote.lop2.promisor true &&
    ++	test_when_finished "git -C server remote remove lop2" &&
    ++	git -C server config --unset remote.lop.promisor &&
    ++	test_when_finished "git -C server config remote.lop.promisor true" &&
    ++	lop_filter="$(git -C server config remote.lop.partialCloneFilter)" &&
    ++	git -C server config --unset remote.lop.partialCloneFilter &&
    ++	test_when_finished "git -C server config remote.lop.partialCloneFilter \"$lop_filter\"" &&
    ++
    ++	# Only the server is trusted, not "lop2", so the upload-pack
    ++	# serving "lop2" to the server refuses to lazily fetch from "lop"
    ++	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/server" &&
    ++	test_must_fail git clone --no-local --filter="blob:limit=5k" \
    ++		server client 2>err &&
    ++	test_grep "lazy fetching disabled" err &&
    ++	check_missing_objects server 1 "$oid" &&
    ++	check_missing_objects lop2 1 "$oid" &&
    ++
    ++	# Once "lop2" is also trusted, the clone succeeds
    ++	git config --global --add uploadpack.lazyFetchTrusted "$(pwd)/lop2" &&
    ++	git clone --no-local --filter="blob:limit=5k" server client &&
    ++	check_missing_objects server 0 "" &&
    ++
    ++	# Reinitialize server so that the largest object is missing again
    ++	initialize_server 1 "$oid"
    ++'
     +
      test_expect_success "init + fetch with promisor.advertise set to 'true'" '
      	git -C server config promisor.advertise true &&


Christian Couder (5):
  promisor-remote: factor out lazy_fetch_objects()
  setup: extract path_allowlist_apply()
  upload-pack: read uploadpack.lazyFetchTrusted
  promisor-remote: prevent infinite recursion when lazy fetching
  builtin/upload-pack: don't disable lazy fetching on trusted repo

 Documentation/config/uploadpack.adoc  |  57 +++++++
 Documentation/git-upload-pack.adoc    |   9 +-
 Documentation/git.adoc                |   4 +-
 builtin/upload-pack.c                 |  19 ++-
 environment.h                         |   8 +
 promisor-remote.c                     | 105 ++++++++----
 setup.c                               | 142 ++++++++++------
 setup.h                               |  50 ++++++
 t/t0410-partial-clone.sh              |  33 ++++
 t/t5710-promisor-remote-capability.sh | 230 ++++++++++++++++++++++++++
 upload-pack.c                         |  59 +++++++
 upload-pack.h                         |   3 +
 12 files changed, 639 insertions(+), 80 deletions(-)


base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.56.0.rc2.20.g34f06850c1


Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C01A264E
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140569; cv=none; b=W1xrbyuGj+Ipfr3WQLuMTSmIhegyTwP2Nr97lBqlNqfC6KoK/CTRn0gqaTaPUmlycPcQC364ofgeZtFW6VjALlxdBOm4rcOoiiw+ZQTWvMrA/H/su6PS3btJC/EyKjQ+kh+WZDPpxHDCSBNM0LSJ/tFk0irzejT3GLQwIVIUndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140569; c=relaxed/simple;
	bh=FtTtYIiqdg0E2gfMjJHGzmaYbN38FEN9duWb4gvO6Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DK6yN1Vd4mSMP4WBqLIS8RqF9KVghXYRNAzsqMFkHydnWN6l0AfzLPjjhXyzwqg1Tq7eVnbRwB8IHig4dn9r0OFL06UCE+Uipty3dLIwmkUmkjyFqR0NYaUtPpE4nCRPzZXcxRT3eKljcMyUOgI9bk6Ixzyx89OoOBhSL+eLFvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=In81h2s/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oM4ijxm4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="In81h2s/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oM4ijxm4"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EEE8711405A4;
	Thu, 12 Sep 2024 07:29:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 12 Sep 2024 07:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140564; x=1726226964; bh=7UchtCswyg
	o/TRSi7X1A0fttGp5yfrIvKzFsskfJrD0=; b=In81h2s/giIpzZtJdVHOCEgCSh
	5GaTjLiFyTSNURlZK5XaC7gm7UEFWwevq37wabWOAfY030mmd8z6MdveL/i+YGjb
	iCvXX8NwPg08BzIqY73boSuBPmgW/VHvuPjokMjkk76C/Zxeg8YJbLzTe7CJ0VZa
	kqdTjbu/qMVwgGxxshnXLfvSwEkOk9HAuLDZLBF5hprjHT5AWxPmCCjXINKKwiyb
	0SV/Lw5t4mL2ggjs1X4VsOy951yMvL//eGf3NrP0n8GhykNGMMJcGs47JDZYujiG
	GJb7H9Mf2JYUdWM8kAKSN2iAoS/V8ljYy7zsDxlHo1RtzlPZN/LTyZ4ofllg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140564; x=1726226964; bh=7UchtCswygo/TRSi7X1A0fttGp5y
	frIvKzFsskfJrD0=; b=oM4ijxm40wMwcM2+rzQSWyeRCDH7+7oUGUTMc+GSt/Hc
	lmhKzx9j/DhEBjg7gfmJMXUKI41rhczmLLc+mL9IFhR/oxuuK+jRkZMUdabG3YR4
	Sny5QeyrMf2eHl78eO7bapXecDYCSSi62cS5kygZrorB+AmNyOIy7NfVMRyI91EX
	Z8nIMHOELYT0us58ZD7dUpqqsxqsDSR1dGyyPQsQvQBxqXH6tY/XGK4WE2nyF8PV
	hBGOALzieJvT1dQUslQprn6VAR9J3GHniWSPinPwq9tWADhVkvSWn58T716AaV1z
	k5FFfRDhXTD6/zvmT6uKr8z//kji2RQYuxUSQX0Jvw==
X-ME-Sender: <xms:lNDiZm-XyYgC-AJK6_1FELi7SQz6NP6u3eJE26YgXoTrbDM9vTQiug>
    <xme:lNDiZmtQLYBIJyqbpelJBXwlClBpprA7SGED5k-HJoOKMcnFagDEiFCH0GnfLwQBA
    7oH2wx4tSDL3Zkj1A>
X-ME-Received: <xmr:lNDiZsC3jy3SZFBAIBP-qUf72DpFT6pl4mMiyswDkgFVuwk9-5CunSaOq4shDre7fcbm78EAlFdDoQRN9kjZPi-D7i2HTZy6rNCL6Z0YeqCe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:lNDiZucoK68xfh12tgpz5COS_MLTWisRrjzk9cBdOM83i9YIt_QIYg>
    <xmx:lNDiZrO4V599dIF9B0I2LuWKsNqTYkBSSm18WZUJ3H9JkvPeUcjBrw>
    <xmx:lNDiZokSNaj5Y3sEsOtkumgWGoe39UA7MFRaK_xKkDaq71e4HhdzKA>
    <xmx:lNDiZtuLKaQIoT3VwLEn4cd4fL94E2BT6dAjOBybspRXJtmC90IETg>
    <xmx:lNDiZm31nQxP-0m5vpKuDhVuRm1HmoJqQ_CZlHf4b1-D5Nx8zOzFOuVt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:29:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9fdef01a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:13 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:29:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 00/21] environment: guard reliance on `the_repository`
Message-ID: <cover.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

Hi,

this is the third version of my patch series which guards functions and
variables in the environment subsystem that rely on `the_repository`
with the `USE_THE_REPOSITORY_VARIABLE` define.

Changes compared to v2:

  - Adapt BUG messages in the first 5 commits to better match the new
    semantics of this function.

  - Adapt commit message to mention that we don't only move over
    `odb_mkstemp()`, but also `odb_pack_keep()`.

  - Explain why setting REF_FORCE_CREATE_REFLOG is equivalent to setting
    LOG_REFS_NORMAL.

Thanks!

Patrick

Patrick Steinhardt (21):
  environment: make `get_git_dir()` accept a repository
  environment: make `get_git_common_dir()` accept a repository
  environment: make `get_object_directory()` accept a repository
  environment: make `get_index_file()` accept a repository
  environment: make `get_graft_file()` accept a repository
  environment: make `get_git_work_tree()` accept a repository
  config: document `read_early_config()` and `read_very_early_config()`
  config: make dependency on repo in `read_early_config()` explicit
  environment: move object database functions into object layer
  environment: make `get_git_namespace()` self-contained
  environment: move `set_git_dir()` and related into setup layer
  environment: reorder header to split out `the_repository`-free section
  environment: guard state depending on a repository
  repo-settings: split out declarations into a standalone header
  repo-settings: track defaults close to `struct repo_settings`
  branch: stop modifying `log_all_ref_updates` variable
  refs: stop modifying global `log_all_ref_updates` variable
  environment: stop storing "core.logAllRefUpdates" globally
  environment: stop storing "core.preferSymlinkRefs" globally
  environment: stop storing "core.warnAmbiguousRefs" globally
  environment: stop storing "core.notesRef" globally

 alias.c                     |   6 +-
 apply.c                     |   3 +-
 branch.c                    |   5 +-
 builtin/am.c                |  13 +-
 builtin/blame.c             |   2 +-
 builtin/checkout.c          |   5 +-
 builtin/commit-graph.c      |   5 +-
 builtin/commit.c            |  13 +-
 builtin/config.c            |   4 +-
 builtin/count-objects.c     |   3 +-
 builtin/difftool.c          |   9 +-
 builtin/fsmonitor--daemon.c |   7 +-
 builtin/gc.c                |   2 +-
 builtin/init-db.c           |   4 +-
 builtin/merge.c             |  18 +--
 builtin/multi-pack-index.c  |   4 +-
 builtin/notes.c             |  22 ++--
 builtin/pack-objects.c      |   2 +-
 builtin/prune.c             |   8 +-
 builtin/repack.c            |   7 +-
 builtin/replace.c           |   3 +-
 builtin/reset.c             |   5 +-
 builtin/rev-parse.c         |  11 +-
 builtin/stash.c             |  17 +--
 builtin/submodule--helper.c |   2 +-
 builtin/update-index.c      |   4 +-
 builtin/worktree.c          |   4 +-
 builtin/write-tree.c        |   4 +-
 bulk-checkin.c              |   4 +-
 bundle-uri.c                |   2 +-
 cache-tree.c                |   5 +-
 commit.c                    |   4 +-
 compat/mingw.c              |   2 +
 compat/win32/path-utils.c   |   2 +
 config.c                    |  42 +------
 config.h                    |  13 +-
 dir.c                       |   3 +-
 environment.c               | 237 +++++-------------------------------
 environment.h               | 142 ++++++++++-----------
 fetch-pack.c                |   2 +-
 fsmonitor.c                 |   3 +-
 help.c                      |   2 +-
 http-backend.c              |   2 +-
 name-hash.c                 |   3 +
 notes.c                     |  21 ++--
 notes.h                     |   3 +-
 object-file.c               |  37 +++++-
 object-name.c               |   5 +-
 object-store-ll.h           |  15 +++
 pack-write.c                |   3 +-
 packfile.c                  |   2 +-
 pager.c                     |   7 +-
 path.c                      |   2 +
 pathspec.c                  |   4 +-
 preload-index.c             |   3 +
 prompt.c                    |   2 +
 prune-packed.c              |   6 +-
 read-cache.c                |   6 +-
 ref-filter.c                |   3 +-
 refs.c                      |   9 +-
 refs.h                      |   4 +-
 refs/files-backend.c        |  32 +++--
 refs/reftable-backend.c     |  22 ++--
 repo-settings.c             |  35 +++++-
 repo-settings.h             |  75 ++++++++++++
 repository.c                |  40 ++++++
 repository.h                |  58 ++-------
 server-info.c               |   4 +-
 setup.c                     | 140 ++++++++++++++++++---
 setup.h                     |   5 +-
 sparse-index.c              |   2 +
 statinfo.c                  |   2 +
 submodule.c                 |   2 +-
 t/helper/test-config.c      |   3 +-
 t/helper/test-path-utils.c  |   2 +
 tmp-objdir.c                |   8 +-
 trace.c                     |  10 +-
 trace2/tr2_cfg.c            |   4 +-
 transport-helper.c          |   2 +-
 tree-diff.c                 |   3 +
 userdiff.c                  |   2 +
 worktree.c                  |  12 +-
 wt-status.c                 |   3 +-
 83 files changed, 698 insertions(+), 560 deletions(-)
 create mode 100644 repo-settings.h

Range-diff against v2:
 1:  a1969c5b073 !  1:  adeaa5030b4 environment: make `get_git_dir()` accept a repository
    @@ repository.c: static void expand_base_dir(char **out, const char *in,
     +const char *repo_get_git_dir(struct repository *repo)
     +{
     +	if (!repo->gitdir)
    -+		BUG("git environment hasn't been setup");
    ++		BUG("repository hasn't been set up");
     +	return repo->gitdir;
     +}
     +
 2:  deebf2c5205 !  2:  2964cfc7790 environment: make `get_git_common_dir()` accept a repository
    @@ repository.c: const char *repo_get_git_dir(struct repository *repo)
     +const char *repo_get_common_dir(struct repository *repo)
     +{
     +	if (!repo->commondir)
    -+		BUG("git environment hasn't been setup");
    ++		BUG("repository hasn't been set up");
     +	return repo->commondir;
     +}
     +
 3:  43abfa7b139 !  3:  b2edc57163c environment: make `get_object_directory()` accept a repository
    @@ repository.c: const char *repo_get_common_dir(struct repository *repo)
     +const char *repo_get_object_directory(struct repository *repo)
     +{
     +	if (!repo->objects->odb)
    -+		BUG("git environment hasn't been setup");
    ++		BUG("repository hasn't been set up");
     +	return repo->objects->odb->path;
     +}
     +
 4:  d7554cb0fe0 !  4:  f82bee6d04f environment: make `get_index_file()` accept a repository
    @@ repository.c: const char *repo_get_object_directory(struct repository *repo)
     +const char *repo_get_index_file(struct repository *repo)
     +{
     +	if (!repo->index_file)
    -+		BUG("git environment hasn't been setup");
    ++		BUG("repository hasn't been set up");
     +	return repo->index_file;
     +}
     +
 5:  1cc727e4763 !  5:  e3f3f6391da environment: make `get_graft_file()` accept a repository
    @@ repository.c: const char *repo_get_index_file(struct repository *repo)
     +const char *repo_get_graft_file(struct repository *repo)
     +{
     +	if (!repo->graft_file)
    -+		BUG("git environment hasn't been setup");
    ++		BUG("repository hasn't been set up");
     +	return repo->graft_file;
     +}
     +
 6:  22e9dcb28a9 =  6:  00950932195 environment: make `get_git_work_tree()` accept a repository
 7:  ec4804a99bf =  7:  8c0010b4397 config: document `read_early_config()` and `read_very_early_config()`
 8:  b8aa5dcc0b6 =  8:  1ed3d3f1d71 config: make dependency on repo in `read_early_config()` explicit
 9:  ac2cc4e0371 !  9:  b164373d10b environment: move `odb_mkstemp()` into object layer
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    environment: move `odb_mkstemp()` into object layer
    +    environment: move object database functions into object layer
     
    -    The `odb_mkstemp()` function is quite clearly tied to the object store,
    -    but regardless of that it is located in "environment.c". Move it over,
    -    which also helps to get rid of dependencies on `the_repository` in the
    -    environment subsystem.
    +    The `odb_mkstemp()` and `odb_pack_keep()` functions are quite clearly
    +    tied to the object store, but regardless of that they are located in
    +    "environment.c". Move them over, which also helps to get rid of
    +    dependencies on `the_repository` in the environment subsystem.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
10:  f0d3794dfc4 = 10:  85c10fad522 environment: make `get_git_namespace()` self-contained
11:  9e0e2528b94 = 11:  437b6f1f30d environment: move `set_git_dir()` and related into setup layer
12:  78f77a006a0 = 12:  8de5b246dad environment: reorder header to split out `the_repository`-free section
13:  9a3f466b530 = 13:  417cca950bf environment: guard state depending on a repository
14:  0d7365c5190 = 14:  a9d032b3ec7 repo-settings: split out declarations into a standalone header
15:  231c52ce82f = 15:  7a74c8d8a8d repo-settings: track defaults close to `struct repo_settings`
16:  fc30365e1f1 ! 16:  b5f3bf5cd25 branch: stop modifying `log_all_ref_updates` variable
    @@ Commit message
         discouraged, as it may have all kinds of consequences in other places of
         our codebase.
     
    -    Stop modifying the variable and pass the `REF_FORCE_CREATE_REFLOG` flag,
    -    which has the same effect.
    +    Stop modifying the variable and pass the `REF_FORCE_CREATE_REFLOG` flag
    +    instead. Setting this flag has a stronger meaning than setting the
    +    config to `LOG_REFS_NORMAL`:
    +
    +      - `LOG_REFS_NORMAL` will ask us to only create reflog entries for
    +        preexisting reflogs or branches, remote refs, note refs and HEAD.
    +
    +      - `REF_FORCE_CREATE_REFLOG` will unconditionally create a reflog and
    +        is thus equivalent to `LOG_REFS_ALWAYS`.
    +
    +    But as we are in `create_branch()` and thus do not have to worry about
    +    arbitrary references, but only about branches, `LOG_REFS_NORMAL` and
    +    `LOG_REFS_ALWAYS` are indeed equivalent.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
17:  9cc8518a02d = 17:  128fefd33a8 refs: stop modifying global `log_all_ref_updates` variable
18:  b5ed6928070 = 18:  df0f29cfec0 environment: stop storing "core.logAllRefUpdates" globally
19:  194d858877f = 19:  e3527e7d73f environment: stop storing "core.preferSymlinkRefs" globally
20:  fc6fcebf7f7 = 20:  3c4a9259fbb environment: stop storing "core.warnAmbiguousRefs" globally
21:  a0b75c4bc99 = 21:  08672e8a073 environment: stop storing "core.notesRef" globally

base-commit: 17d4b10aea6bda2027047a0e3548a6f8ad667dde
-- 
2.46.0.551.gc5ee8f2d1c.dirty


Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C9B339A1
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540405; cv=none; b=CRZp2Tn9PYPoZIorZyvk3CQ+uvPMkAGGY98zmVA7LcJHG59zfEJz07+I4kBbz4ihcKH2y04xNWl9QCJZIuOhAWOBS1EIv1pKWrYDJoy6Ta1/Q1xAl2hDw0lpob4Udpn5fOz8HjzpedNRjvfbEgFZekAPzsfAO5mJbh3gwoigQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540405; c=relaxed/simple;
	bh=MIhT7p+A7QD5l8NLID4fLY7T8PwlvCyLC9IPh1R1OZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuSxidfWIlwSw1PnqDM69uXHMrg2zwsn4zGqp9aFuPvhN7WaaSOmjiVcRAgPzgmglUbyOsOhoT0AvyPxHyaotRrnIhW0NPOpWKz7w4jvTh3veIANMyamyimaRPg69OTTA5URjSkso+cry4waNIPW5E+2FLGSDWKfk4fEUmVvavk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OIFlNpYw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GiXbg0v/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OIFlNpYw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GiXbg0v/"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id F0249138FB5F;
	Tue, 13 Aug 2024 05:13:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 05:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540401; x=1723626801; bh=SfpPpgNQN/
	DVD9Y9Ho+qvw6oRKloGJTblK++y0goRMU=; b=OIFlNpYwHRh7yMs5r3WWwPEeYL
	SMiTU+hzmRNkAsyDauvvt0aduXvHtCJz1BPwwpBdv6je4g0RSVPXs0RfU+slJOmG
	VnUvv/MBsS2UJKRNr4uQlrusrAxeXC/A8WSMgLl2VRKfaqIJ0diAWS4A7ZGG7Rvi
	EJwyvDAOH9r4ayC0V9JgO3Iho4npug3DiKA4h+nfogB3ez7YjCaLv6KBI17Xmqwj
	NpLa8vtb+0xsfPKerfWfXfSVo9Z2beKNZQHCTgim+mvneC2dK50YXsQSLwEhBa1S
	V9n+uWAM3IGBHHNhUaEnwbY4tiYfAo0ykPrHi/ojwKNG7nBEROxLzugEmTxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540401; x=1723626801; bh=SfpPpgNQN/DVD9Y9Ho+qvw6oRKlo
	GJTblK++y0goRMU=; b=GiXbg0v/mOgWof4Prp22y5yeQTWTwmu4cViXP5Gbr5MH
	sVF4y750IcDJBt+ZyikWCI94KZ8IORIe/0K1OZz/+b7XEC/XwXW1OpzAEmvTR/El
	OhEwuHRP3KBvUCjBh370+035OCP+SGkxzJC+Crl1wAZNkShwuV0ZUeRbchKVC286
	3LMrIC0Gv5WhLT0rLHl16Oe+/vZror/6rj65lLVFy5YAL5cKAISHJQw/Baq5/8WY
	BeRV4w3s3fP9rUBdQOu3E0O7LAGOa4eS2Pu+mpsCArATBTOzGUSGdQEAwcTPIbZT
	QetMUszdrvX538qpSwPJfL4vytnIWrV5a56ohA6L0w==
X-ME-Sender: <xms:sSO7ZuXnpu3yn7AAl2wQ4lxsG8a1nxCWvzJTEE5lACF8Tk3xllDX2A>
    <xme:sSO7ZqmWesm3rdSmBxHTXXOwjD4U09UP2bozruVZngJci2dU-IuB1tuMzeCJARDde
    L8ZMoRXfHwYt86R2A>
X-ME-Received: <xmr:sSO7ZiZUulWau5yaVV3Xa7_qSQJcgSJgzR9WKp8hiUd-LPyFeHrVeim_T0eF87pHkFQJi16QOnxSTsDEfYzCBwaJYumMdpQrdDCRvpr73xKcUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sSO7ZlVk27PwMdozrJhJZ2rBA9xpGL6on1GeTMzJM-nahWsCBRAlOQ>
    <xmx:sSO7ZonaLSF2I7hbbu29ZuWmmPVn9VMPCppakEX6yoNe2Io54b5roA>
    <xmx:sSO7Zqe-DxjayeMOTimb0B8ru1_g80ZIFvS6-wbUZW_-FPObGeD_5g>
    <xmx:sSO7ZqHIj2pD8JZ7zdifvk5TCswG7RCOPnUNqrUiLMczi3Hi4p4U5g>
    <xmx:sSO7ZiiyPA4c79IYmgpuVZHaS7t58Sc_fhnQYcIan2aBE_tb-NstKlq_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d8c6293a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:02 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/20] Stop using `the_repository` in "config.c"
Message-ID: <cover.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>

Hi,

this is the second version of my patch series that drops the dependency
on `the_repository` in both "path.c" and "config.c".

Changes compared to v1:

  - Various typo fixes in commit messages.

  - Rename `strbuf_git_common_pathv()` to `repo_common_pathv()`.

  - Reorder arguments of `strbuf_edit_interactively()` such that the
    `struct repository` gets passed as first argument.

  - Document behaviour of `worktree_git_path()` when no worktree is
    given.

  - Wrap some overly long lines.

Thanks!

Patrick

Patrick Steinhardt (20):
  path: expose `do_git_path()` as `repo_git_pathv()`
  path: expose `do_git_common_path()` as `repo_common_pathv()`
  editor: do not rely on `the_repository` for interactive edits
  hooks: remove implicit dependency on `the_repository`
  path: stop relying on `the_repository` when reporting garbage
  path: stop relying on `the_repository` in `worktree_git_path()`
  path: hide functions using `the_repository` by default
  config: introduce missing setters that take repo as parameter
  config: expose `repo_config_clear()`
  config: pass repo to `git_config_get_index_threads()`
  config: pass repo to `git_config_get_split_index()`
  config: pass repo to `git_config_get_max_percent_split_change()`
  config: pass repo to `git_config_get_expiry()`
  config: pass repo to `git_config_get_expiry_in_days()`
  config: pass repo to `git_die_config()`
  config: pass repo to functions that rename or copy sections
  config: don't have setters depend on `the_repository`
  config: don't depend on `the_repository` with branch conditions
  global: prepare for hiding away repo-less config functions
  config: hide functions using `the_repository` by default

 add-patch.c                       |   3 +-
 builtin/am.c                      |   9 +-
 builtin/branch.c                  |   7 +-
 builtin/bugreport.c               |   2 +-
 builtin/checkout.c                |   2 +-
 builtin/clone.c                   |   2 +-
 builtin/config.c                  |  16 +-
 builtin/count-objects.c           |   2 +-
 builtin/fast-import.c             |   4 +-
 builtin/fsck.c                    |   2 +-
 builtin/gc.c                      |   8 +-
 builtin/hook.c                    |   2 +-
 builtin/merge.c                   |   2 +-
 builtin/notes.c                   |   2 +-
 builtin/rebase.c                  |   2 +-
 builtin/receive-pack.c            |  10 +-
 builtin/remote.c                  |   4 +-
 builtin/submodule--helper.c       |   2 +-
 builtin/update-index.c            |   4 +-
 builtin/worktree.c                |   6 +-
 commit.c                          |   2 +-
 compat/fsmonitor/fsm-ipc-darwin.c |   2 +
 compat/precompose_utf8.c          |   1 +
 config.c                          | 225 ++++++++---------------
 config.h                          | 285 +++++++++++++++++++++---------
 connect.c                         |   2 +
 credential.c                      |   2 +
 daemon.c                          |   2 +
 editor.c                          |  15 +-
 editor.h                          |   5 +-
 fsmonitor.c                       |   2 +
 gpg-interface.c                   |   2 +
 graph.c                           |   2 +
 hook.c                            |  21 +--
 hook.h                            |  13 +-
 imap-send.c                       |   2 +
 mailinfo.c                        |   2 +
 merge-ll.c                        |   2 +
 parallel-checkout.c               |   2 +
 path.c                            |  97 +++-------
 path.h                            | 170 ++++++++++++------
 protocol.c                        |   2 +
 read-cache.c                      |  22 +--
 refs.c                            |   4 +-
 refs/packed-backend.c             |   2 +
 refs/reftable-backend.c           |   2 +
 rerere.c                          |   6 +-
 reset.c                           |   2 +-
 revision.c                        |   2 +-
 sequencer.c                       |   6 +-
 sideband.c                        |   2 +
 submodule.c                       |   2 +-
 t/helper/test-advise.c            |   2 +
 t/helper/test-config.c            |   2 +
 t/helper/test-userdiff.c          |   2 +
 trailer.c                         |   2 +
 transport.c                       |   2 +-
 versioncmp.c                      |   2 +
 worktree.c                        |   2 +-
 wt-status.c                       |  14 +-
 60 files changed, 570 insertions(+), 457 deletions(-)

Range-diff against v1:
 1:  7ce3278f64 =  1:  d0f5f2b17f path: expose `do_git_path()` as `repo_git_pathv()`
 2:  e7a143c30d !  2:  2e3f474e5d path: expose `do_git_common_path()` as `strbuf_git_common_pathv()`
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    path: expose `do_git_common_path()` as `strbuf_git_common_pathv()`
    +    path: expose `do_git_common_path()` as `repo_common_pathv()`
     
         With the same reasoning as the preceding commit, expose the function
    -    `do_git_common_path()` as `strbuf_git_common_pathv()`.
    +    `do_git_common_path()` as `repo_common_pathv()`. While at it, reorder
    +    parameters such that they match the order we have in `repo_git_pathv()`.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ path.c: int strbuf_git_path_submodule(struct strbuf *buf, const char *path,
     -			       struct strbuf *buf,
     -			       const char *fmt,
     -			       va_list args)
    -+void strbuf_git_common_pathv(struct strbuf *sb,
    -+			     const struct repository *repo,
    -+			     const char *fmt,
    -+			     va_list args)
    ++void repo_common_pathv(const struct repository *repo,
    ++		       struct strbuf *sb,
    ++		       const char *fmt,
    ++		       va_list args)
      {
     -	strbuf_addstr(buf, repo->commondir);
     -	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
    @@ path.c: const char *git_common_path(const char *fmt, ...)
      	va_list args;
      	va_start(args, fmt);
     -	do_git_common_path(the_repository, pathname, fmt, args);
    -+	strbuf_git_common_pathv(pathname, the_repository, fmt, args);
    ++	repo_common_pathv(the_repository, pathname, fmt, args);
      	va_end(args);
      	return pathname->buf;
      }
    @@ path.c: void strbuf_git_common_path(struct strbuf *sb,
      	va_list args;
      	va_start(args, fmt);
     -	do_git_common_path(repo, sb, fmt, args);
    -+	strbuf_git_common_pathv(sb, repo, fmt, args);
    ++	repo_common_pathv(repo, sb, fmt, args);
      	va_end(args);
      }
      
    @@ path.h: void strbuf_git_common_path(struct strbuf *sb,
      			    const struct repository *repo,
      			    const char *fmt, ...)
      	__attribute__((format (printf, 3, 4)));
    -+void strbuf_git_common_pathv(struct strbuf *sb,
    -+			     const struct repository *repo,
    -+			     const char *fmt,
    -+			     va_list args);
    ++void repo_common_pathv(const struct repository *repo,
    ++		       struct strbuf *buf,
    ++		       const char *fmt,
    ++		       va_list args);
      
      /*
       * Return a statically allocated path into the main repository's
 3:  c2556fff9e !  3:  2f73e0efcd editor: do not rely on `the_repository` for interactive edits
    @@ Commit message
     
         We implicitly rely on `the_repository` when editing a file interactively
         because we call `git_path()`. Adapt the function to instead take a
    -    `sturct repository` as parameter so that we can remove this hidden
    +    `struct repository` as a parameter so that we can remove this hidden
         dependency.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ add-patch.c: static int edit_hunk_manually(struct add_p_state *s, struct hunk *h
      				"aborted and the hunk is left unchanged.\n"));
      
     -	if (strbuf_edit_interactively(&s->buf, "addp-hunk-edit.diff", NULL) < 0)
    -+	if (strbuf_edit_interactively(&s->buf, "addp-hunk-edit.diff", NULL,
    -+				      the_repository) < 0)
    ++	if (strbuf_edit_interactively(the_repository, &s->buf,
    ++				      "addp-hunk-edit.diff", NULL) < 0)
      		return -1;
      
      	/* strip out commented lines */
     
      ## editor.c ##
     @@ editor.c: int launch_sequence_editor(const char *path, struct strbuf *buffer,
    + 	return launch_specified_editor(git_sequence_editor(), path, buffer, env);
      }
      
    - int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
    --			      const char *const *env)
    -+			      const char *const *env, struct repository *r)
    +-int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
    ++int strbuf_edit_interactively(struct repository *r,
    ++			      struct strbuf *buffer, const char *path,
    + 			      const char *const *env)
      {
     -	char *path2 = NULL;
     +	struct strbuf sb = STRBUF_INIT;
    @@ editor.h
      
      const char *git_editor(void);
     @@ editor.h: int launch_sequence_editor(const char *path, struct strbuf *buffer,
    +  *
       * If `path` is relative, it refers to a file in the `.git` directory.
       */
    - int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
    +-int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
     -			      const char *const *env);
    -+			      const char *const *env, struct repository *r);
    ++int strbuf_edit_interactively(struct repository *r, struct strbuf *buffer,
    ++			      const char *path, const char *const *env);
      
      #endif
 4:  9a0964aff3 =  4:  688d705179 hooks: remove implicit dependency on `the_repository`
 5:  4368b32f65 =  5:  bbaa85ebad path: stop relying on `the_repository` when reporting garbage
 6:  67405dcd0a !  6:  29302f4b14 path: stop relying on `the_repository` in `worktree_git_path()`
    @@ path.c: const char *mkpath(const char *fmt, ...)
     
      ## path.h ##
     @@ path.h: const char *git_path(const char *fmt, ...)
    + 
    + /*
       * Similar to git_path() but can produce paths for a specified
    -  * worktree instead of current one
    +- * worktree instead of current one
    ++ * worktree instead of current one. When no worktree is given, then the path is
    ++ * computed relative to main worktree of the given repository.
       */
     -const char *worktree_git_path(const struct worktree *wt,
     +const char *worktree_git_path(struct repository *r,
 7:  b4e973a280 !  7:  1b6651770a path: hide functions using `the_repository` by default
    @@ Metadata
      ## Commit message ##
         path: hide functions using `the_repository` by default
     
    -    The path subsytem provides a bunch of legacy functions that compute
    +    The path subsystem provides a bunch of legacy functions that compute
         paths relative to the "gitdir" and "commondir" directories of the global
         `the_repository` variable. Use of those functions is discouraged, and it
         is easy to miss the implicit dependency on `the_repository` that calls
         to those functions may cause.
     
         With `USE_THE_REPOSITORY_VARIABLE`, we have recently introduced a tool
    -    that allows us to get rid of such functions over time. With this define,
    +    that allows us to get rid of such functions over time. With this macro,
         we can hide away functions that have such implicit dependency such that
         other subsystems that want to be free of `the_repository` will not use
         them by accident.
    @@ path.c: void strbuf_repo_git_path(struct strbuf *sb,
      char *mkpathdup(const char *fmt, ...)
      {
      	struct strbuf sb = STRBUF_INIT;
    -@@ path.c: void strbuf_git_common_pathv(struct strbuf *sb,
    +@@ path.c: void repo_common_pathv(const struct repository *repo,
      	strbuf_cleanup_path(sb);
      }
      
    @@ path.c: void strbuf_git_common_pathv(struct strbuf *sb,
     -	struct strbuf *pathname = get_pathname();
     -	va_list args;
     -	va_start(args, fmt);
    --	strbuf_git_common_pathv(pathname, the_repository, fmt, args);
    +-	repo_common_pathv(the_repository, pathname, fmt, args);
     -	va_end(args);
     -	return pathname->buf;
     -}
    @@ path.h: char *mkpathdup(const char *fmt, ...)
       * repository's common git directory, which is shared by all worktrees.
       */
      
    -@@ path.h: void strbuf_git_common_pathv(struct strbuf *sb,
    - 			     va_list args);
    +@@ path.h: void repo_common_pathv(const struct repository *repo,
    + 		       va_list args);
      
      /*
     - * Return a statically allocated path into the main repository's
    @@ path.h: void strbuf_repo_git_path(struct strbuf *sb,
     -/*
     - * Similar to git_path() but can produce paths for a specified
     + * Similar to repo_git_path() but can produce paths for a specified
    -  * worktree instead of current one
    +  * worktree instead of current one. When no worktree is given, then the path is
    +  * computed relative to main worktree of the given repository.
       */
    - const char *worktree_git_path(struct repository *r,
     @@ path.h: const char *worktree_git_path(struct repository *r,
      			      const char *fmt, ...)
      	__attribute__((format (printf, 3, 4)));
    @@ path.h: char *xdg_cache_home(const char *filename);
     +	struct strbuf *pathname = get_pathname();
     +	va_list args;
     +	va_start(args, fmt);
    -+	strbuf_git_common_pathv(pathname, the_repository, fmt, args);
    ++	repo_common_pathv(the_repository, pathname, fmt, args);
     +	va_end(args);
     +	return pathname->buf;
     +}
 8:  feae2ad31a !  8:  e316491e56 config: introduce missing setters that take repo as parameter
    @@ Commit message
     
         While we already provide some of the config-setting interfaces with a
         `struct repository` as parameter, others only have a variant that
    -    implicitly depend on `the_repository`. Fill in those gaps such that we
    +    implicitly depends on `the_repository`. Fill in those gaps such that we
         can start to deprecate the repo-less variants.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
 9:  63da87696e =  9:  5e73ef6cec config: expose `repo_config_clear()`
10:  03df1277f7 = 10:  35e0f4579c config: pass repo to `git_config_get_index_threads()`
11:  85311d686e = 11:  a88ed83b97 config: pass repo to `git_config_get_split_index()`
12:  b95ed05f88 = 12:  17c5420d63 config: pass repo to `git_config_get_max_percent_split_change()`
13:  412cc514e8 = 13:  f39d4a3244 config: pass repo to `git_config_get_expiry()`
14:  cf7942479f ! 14:  111f77e653 config: pass repo to `git_config_get_expiry_in_days()`
    @@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
      
     -	git_config_get_expiry_in_days("gc.rerereresolved", &cutoff_resolve, now);
     -	git_config_get_expiry_in_days("gc.rerereunresolved", &cutoff_noresolve, now);
    -+	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved", &cutoff_resolve, now);
    -+	repo_config_get_expiry_in_days(the_repository, "gc.rerereunresolved", &cutoff_noresolve, now);
    ++	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
    ++				       &cutoff_resolve, now);
    ++	repo_config_get_expiry_in_days(the_repository, "gc.rerereunresolved",
    ++				       &cutoff_noresolve, now);
      	git_config(git_default_config, NULL);
      	dir = opendir(git_path("rr-cache"));
      	if (!dir)
15:  d70d9bfa7e = 15:  6adee5633a config: pass repo to `git_die_config()`
16:  980533972c = 16:  b8c54b751c config: pass repo to functions that rename or copy sections
17:  1c1b27cbac = 17:  1e5cd92e8e config: don't have setters depend on `the_repository`
18:  d8530a300b = 18:  96963364e7 config: don't depend on `the_repository` with branch conditions
19:  f7617beaa5 ! 19:  124f5794e6 global: prepare for hiding away repo-less config functions
    @@ Commit message
         We're about to hide config functions that implicitly depend on
         `the_repository` behind the `USE_THE_REPOSITORY_VARIABLE` macro. This
         will uncover a bunch of dependents that transitively relied on the
    -    global variable, but didn'd define the macro yet.
    +    global variable, but didn't define the macro yet.
     
         Adapt them such that we define the macro to prepare for this change.
     
20:  43757f3077 ! 20:  467cd481f5 config: hide functions using `the_repository` by default
    @@ Metadata
      ## Commit message ##
         config: hide functions using `the_repository` by default
     
    -    The config subsytem provides a bunch of legacy functions that read or
    +    The config subsystem provides a bunch of legacy functions that read or
         set configuration for `the_repository`. The use of those functions is
         discouraged, and it is easy to miss the implicit dependency on
         `the_repository` that calls to those functions may cause.
-- 
2.46.0.46.g406f326d27.dirty


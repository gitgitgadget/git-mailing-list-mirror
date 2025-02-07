Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D78192D77
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926216; cv=none; b=JjgXzJjnUYPhJTJa8Bv63r3i6nu5jrjaqbCoq/HeG3PDCdUfGwGn0349z+pZFFulh0nk8th4JjrYw/z1Hvsawv3qwzgaViG7rONbCFhMLyEnV1Oa6cC0cswqRUQsJh1JbbrA8hw/oAS/Cfyopv9YTIQZXO0FnDvIk+9iT7qlf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926216; c=relaxed/simple;
	bh=e4jtV6gxtiovnbKHGswn5BME4blN06F6R+kVxPJcKqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=uuKISquRC2ohhtpXvpVNrjJV3A3fANSSsiuO8zgg20oEM71s6L0v7q65C8qt1HAJcJ+V+HHX8OFYrppDf5O885LBkpUQSq5uhu0WrB58cDXVs3OY9D68wWY5qlnitKwscnWLYKnY4sg+egNegRUlbgdWjiD2NkYVoG/vosEt8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QCsSgO2P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hnbGGwn9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QCsSgO2P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hnbGGwn9"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E4FD01140127;
	Fri,  7 Feb 2025 06:03:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 06:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738926212;
	 x=1739012612; bh=+dDPt6XCDYHo370kqJJDVFl5gC5eUwHDof7NkoVFDNg=; b=
	QCsSgO2PkdSoLVhbGHlsyCLXwaZ40tAvT63jB4YjWlG64Ulzlv0WEkDG/Xuo9boM
	UGPMO6khQ3P+zEALNeGUS/hh8aqFynkHfzFHpBhGk4D+QsimhTs0XKcYh19KQRFI
	QQqH2Wvdzb6gndw6TIUU9EDoMJFXc7cQabaRxmG9+knYrOj8lvmLdWaH2mE++NKB
	8oq2UWLOzMvAW6Ja0xS5iColHLhLijlV+4j4Bu+n/wFQVMLz79kAIdRNQQdfus+1
	lC1Jq6ddCANyUS7H8lTQ/vbdjulhwniYa6dFJTpVMBK16cF6Y4+AyAMa6MOhP/oq
	vaHd5/mjFYhAuq8yhyuDXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926212; x=
	1739012612; bh=+dDPt6XCDYHo370kqJJDVFl5gC5eUwHDof7NkoVFDNg=; b=h
	nbGGwn92xFTHyjYilo9AkDZW5lw4UXxYhcBwO7eEx3YPQzcYiKlfPdbdkCs5nc3N
	JLQCwnJxGiY9vw7oA/GqVLdsYnO1bOFLizwInoY2O2KQLiv7XvYOcU1uerMW/dRF
	nvIAh55FlqP+ngDdqY8/QT7od8liwt0wdVMweTyzjMdeO0BrXXQVWWM7UaKuJhBA
	alJTD0oWhMj+EOFs0EXIFjfL21zV0TV6ZEqdrtU4VwwTcJ8/h7m38nqMJWcAcPGL
	EHCzuyEU4G+gAA/fOgAIcNWv2CjrwuqDmP8O68M0+lK2XlhpKdlk/FWf5gt/rnbJ
	eb3WFiEwfiRSKRUr/y/WQ==
X-ME-Sender: <xms:hOilZ0v90mTBMkoI8krxWW1U_A2414On_Ry7RcRB2E5YzyACGhW9nQ>
    <xme:hOilZxdXgVBBhP3lwlqlA2DQxSIijIA24DKE-DkMLbhNlzMHsNBDePwez2QS_I3ZU
    GFNBFC5i8dp0JWUEA>
X-ME-Received: <xmr:hOilZ_wW5a2l--iL5OVy2DOo8xmD3JX2SU1TnF6dFG7Y7FYlSHIf8V0A23QOUx9piq_-gvucWn4qxPUlgo8UOoBF0cFMZknxOT2nXRD7KqzZ0ym_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtudehtdeh
    fefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhu
    ohesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:hOilZ3OdZNqIlQCYri0X9jTs5QTusz3X1HOee5YEt0Jz6VuxSuzqCQ>
    <xmx:hOilZ08glH7yXUr3tsy_SjWhVzSalBkV69XTJpKu5Jv_HCeH14Fqbw>
    <xmx:hOilZ_VX08VwEGiwI87wBV3iK4yzDy51yS5NPixNsscSfpsjG7aQGg>
    <xmx:hOilZ9cifBpzeA7yxdCi3oU_UTqKuE1-EN83dhoBNmuNleDSTeiYCw>
    <xmx:hOilZzbn8IpyyCDCAHD7od_Gcqeie995dfP25hD7erDN0AWipkReUvvd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:03:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 691a158d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:03:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/16] path: remove dependency on `the_repository`
Date: Fri, 07 Feb 2025 12:03:25 +0100
Message-Id: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH3opWcC/4WNzQrCMBCEX6Xs2ZUk/SOe+h7SQ7Ubs4hNSEpQS
 t7dtODZ4zfMfLNBpMAU4VJtEChxZLcUUKcK7nZaHoQ8FwYlVCuUaPDWoH9G9NNqcQ7O42oJA3k
 XeXXhg5pmYbRuu7qTUCw+kOH38XAdC1uOe+84THJPf+7urztJFNhQ3xtRy7oshlI/8wvGnPMX6
 ztR9MsAAAA=
X-Change-ID: 20250204-b4-pks-path-drop-the-repository-9ed0f9956361
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series removes the dependency on `the_repository` from the
"path" subsystem. The series is structured as follows:

  - Patches 1 to 5 unifyf the interfaces that can be used to retrieve
    repository paths (gitdir, commondir, workdir and submodule paths)
    and adapts callers accodringly.

  - Patches 6 to 12 drop repository path functions that had an implicit
    dependency on `the_repository`.

  - Patches 13 to 16 refactor "path.c"-internal code to stop depending
    on `the_repository`.

Changes in v2:
  - Rename variable to `wt_gitdir` for the sake of consistency.
  - Improve several commit messages.
  - Link to v1: https://lore.kernel.org/r/20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (16):
      path: refactor `repo_common_path()` family of functions
      path: refactor `repo_git_path()` family of functions
      path: refactor `repo_worktree_path()` family of functions
      submodule: refactor `submodule_to_gitdir()` to accept a repo
      path: refactor `repo_submodule_path()` family of functions
      path: drop unused `strbuf_git_path()` function
      path: drop `git_pathdup()` in favor of `repo_git_path()`
      path: drop `git_path_buf()` in favor of `repo_git_path_replace()`
      worktree: return allocated string from `get_worktree_git_dir()`
      path: drop `git_common_path()` in favor of `repo_common_path()`
      rerere: let `rerere_path()` write paths into a caller-provided buffer
      path: drop `git_path()` in favor of `repo_git_path()`
      repo-settings: introduce function to clear struct
      environment: move access to "core.hooksPath" into repo settings
      environment: move access to "core.sharedRepository" into repo settings
      path: adjust last remaining users of `the_repository`

 bisect.c                    |   2 +-
 branch.c                    |   7 +-
 builtin/am.c                |   2 +-
 builtin/clone.c             |   4 +-
 builtin/commit.c            |   8 +-
 builtin/config.c            |   8 +-
 builtin/fast-import.c       |   4 +-
 builtin/fsck.c              |  10 ++-
 builtin/gc.c                |  25 ++++--
 builtin/init-db.c           |   8 +-
 builtin/log.c               |   6 +-
 builtin/notes.c             |   9 ++-
 builtin/rebase.c            |   2 +-
 builtin/receive-pack.c      |   4 +-
 builtin/remote.c            |   6 +-
 builtin/replace.c           |   2 +-
 builtin/rerere.c            |  11 ++-
 builtin/rev-parse.c         |   6 +-
 builtin/submodule--helper.c |   4 +-
 builtin/tag.c               |   2 +-
 builtin/worktree.c          |  43 +++++++---
 commit-graph.c              |   2 +-
 compat/precompose_utf8.c    |   6 +-
 config.c                    |   5 --
 copy.c                      |   4 +-
 dir.c                       |   2 +-
 editor.c                    |   6 +-
 environment.c               |  27 -------
 environment.h               |  11 ---
 hook.c                      |   3 +-
 http-backend.c              |   2 +-
 loose.c                     |   8 +-
 midx-write.c                |   2 +-
 notes-merge.c               |  26 +++---
 object-file.c               |  14 ++--
 pack-bitmap-write.c         |   2 +-
 pack-write.c                |  10 ++-
 path.c                      | 166 +++++++++++++++++++++++++++-----------
 path.h                      | 191 ++++++++++++--------------------------------
 reachable.c                 |   6 +-
 read-cache.c                |  26 ++++--
 refs.c                      |   6 +-
 refs/files-backend.c        |  10 +--
 refs/reftable-backend.c     |  10 +--
 remote.c                    |  21 ++---
 repo-settings.c             |  44 +++++++++-
 repo-settings.h             |  14 ++++
 repository.c                |   6 +-
 rerere.c                    | 101 ++++++++++++++++-------
 rerere.h                    |   3 +-
 revision.c                  |   7 +-
 server-info.c               |   2 +-
 setup.c                     |  70 ++++++++--------
 shallow.c                   |   4 +-
 submodule.c                 |  15 ++--
 submodule.h                 |   3 +-
 t/helper/test-ref-store.c   |   7 +-
 tempfile.c                  |   4 +-
 tmp-objdir.c                |  17 ++--
 worktree.c                  |  49 ++++++++----
 worktree.h                  |   2 +-
 wt-status.c                 |  42 ++++++----
 62 files changed, 639 insertions(+), 490 deletions(-)

Range-diff versus v1:

 1:  3b24ba58d4 !  1:  a1bbae7e0d path: refactor `repo_common_path()` family of functions
    @@ Commit message
           - `repo_*_path_replace()` replaces contents of the buffer with the
             computed path, again returning a pointer to the buffer contents.
     
    +    The returned constant pointer isn't being used anywhere yet, but it will
    +    be used in subsequent commits. Its intent is to allow calling patterns
    +    like the following somewhat contrived example:
    +
    +        if (!stat(&st, repo_common_path_replace(repo, &buf, ...)) &&
    +            !unlink(repo_common_path_replace(repo, &buf, ...)))
    +                ...
    +
         Refactor the commondir family of functions accordingly and adapt all
         callers.
     
    +    Note that `repo_common_pathv()` is converted into an internal
    +    implementation detail. It is only used to implement `the_repository`
    +    compatibility shims and will eventually be removed from the public
    +    interface.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## loose.c ##
 2:  8bf77754df !  2:  f7f2013b55 path: refactor `repo_git_path()` family of functions
    @@ hook.c: const char *find_hook(struct repository *r, const char *name)
      	if (!found_hook) {
     
      ## path.c ##
    -@@ path.c: static void strbuf_worktree_gitdir(struct strbuf *buf,
    - 		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
    - }
    - 
    --void repo_git_pathv(const struct repository *repo,
    -+void repo_git_pathv(struct repository *repo,
    - 		    const struct worktree *wt, struct strbuf *buf,
    - 		    const char *fmt, va_list args)
    - {
    -@@ path.c: void repo_git_pathv(const struct repository *repo,
    - 	strbuf_cleanup_path(buf);
    - }
    - 
    --char *repo_git_path(const struct repository *repo,
    -+char *repo_git_path(struct repository *repo,
    - 		    const char *fmt, ...)
    - {
    - 	struct strbuf path = STRBUF_INIT;
     @@ path.c: char *repo_git_path(const struct repository *repo,
      	return strbuf_detach(&path, NULL);
      }
    @@ path.c: char *repo_git_path(const struct repository *repo,
     -void strbuf_repo_git_path(struct strbuf *sb,
     -			  const struct repository *repo,
     -			  const char *fmt, ...)
    -+const char *repo_git_path_append(struct repository *repo,
    ++const char *repo_git_path_append(const struct repository *repo,
     +				 struct strbuf *sb,
     +				 const char *fmt, ...)
      {
    @@ path.c: char *repo_git_path(const struct repository *repo,
     +	return sb->buf;
     +}
     +
    -+const char *repo_git_path_replace(struct repository *repo,
    ++const char *repo_git_path_replace(const struct repository *repo,
     +				  struct strbuf *sb,
     +				  const char *fmt, ...)
     +{
    @@ path.h: const char *repo_common_path_replace(const struct repository *repo,
     -/*
     - * Return a path into the git directory of repository `repo`.
     - */
    --char *repo_git_path(const struct repository *repo,
    -+char *repo_git_path(struct repository *repo,
    + char *repo_git_path(const struct repository *repo,
      		    const char *fmt, ...)
      	__attribute__((format (printf, 2, 3)));
     -
    @@ path.h: const char *repo_common_path_replace(const struct repository *repo,
     -void strbuf_repo_git_path(struct strbuf *sb,
     -			  const struct repository *repo,
     -			  const char *fmt, ...)
    -+const char *repo_git_path_append(struct repository *repo,
    ++const char *repo_git_path_append(const struct repository *repo,
     +				 struct strbuf *sb,
     +				 const char *fmt, ...)
     +	__attribute__((format (printf, 3, 4)));
    -+const char *repo_git_path_replace(struct repository *repo,
    ++const char *repo_git_path_replace(const struct repository *repo,
     +				  struct strbuf *sb,
     +				  const char *fmt, ...)
      	__attribute__((format (printf, 3, 4)));
    @@ path.h: struct strbuf *get_pathname(void);
      		       struct strbuf *buf,
      		       const char *fmt,
      		       va_list args);
    -+void repo_git_pathv(struct repository *repo,
    ++void repo_git_pathv(const struct repository *repo,
     +		    const struct worktree *wt, struct strbuf *buf,
     +		    const char *fmt, va_list args);
      
 3:  06b86c01fd =  3:  36eef25a6e path: refactor `repo_worktree_path()` family of functions
 4:  aced89e60e =  4:  d86ab046c3 submodule: refactor `submodule_to_gitdir()` to accept a repo
 5:  0495f12932 !  5:  d58c55e9db path: refactor `repo_submodule_path()` family of functions
    @@ Commit message
         commondir, gitdir and worktree. Refactor the "submodule" family of
         functions accordingly.
     
    +    Note that in contrast to the other `repo_*_path()` families, we have to
    +    pass in the repository as a non-constant pointer. This is because we end
    +    up calling `repo_read_gitmodules()` deep down in the callstack, which
    +    may end up modifying the repository.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/submodule--helper.c ##
 6:  ecba20e416 =  6:  438a055bdf path: drop unused `strbuf_git_path()` function
 7:  e204e037bf =  7:  8ab37db627 path: drop `git_pathdup()` in favor of `repo_git_path()`
 8:  473c8befb3 =  8:  17c4dddf2b path: drop `git_path_buf()` in favor of `repo_git_path_replace()`
 9:  d2f9c302e6 !  9:  d0d6af1ea4 worktree: return allocated string from `get_worktree_git_dir()`
    @@ Commit message
         worktree: return allocated string from `get_worktree_git_dir()`
     
         The `get_worktree_git_dir()` function returns a string constant that
    -    does not need to be free'd by the caller. For `repo_get_git_dir()` and
    -    `repo_get_common_dir()` this is because we return strings owned by
    -    `the_repository`.
    +    does not need to be free'd by the caller. This string is computed for
    +    three different cases:
     
    -    But for `git_common_path()` it's a bit less obvious though, because that
    -    function does end up allocating memory. This doesn't result in a memory
    -    leak either because we write into a buffer returned by `get_pathname()`,
    -    which returns one out of four static buffers.
    +      - If we don't have a worktree we return a path into the Git directory.
    +        The returned string is owned by `the_repository`, so there is no
    +        need for the caller to free it.
    +
    +      - If we have a worktree, but no worktree ID then the caller requests
    +        the main worktree. In this case we return a path into the common
    +        directory, which again is owned by `the_repository` and thus does
    +        not need to be free'd.
    +
    +      - In the third case, where we have an actual worktree, we compute the
    +        path relative to "$GIT_COMMON_DIR/worktrees/". This string does not
    +        need to be released either, even though `git_common_path()` ends up
    +        allocating memory. But this doesn't result in a memory leak either
    +        because we write into a buffer returned by `get_pathname()`, which
    +        returns one out of four static buffers.
     
         We're about to drop `git_common_path()` in favor of `repo_common_path()`,
         which doesn't use the same mechanism but instead returns an allocated
    @@ revision.c: void add_index_objects_to_pending(struct rev_info *revs, unsigned in
      	for (p = worktrees; *p; p++) {
      		struct worktree *wt = *p;
      		struct index_state istate = INDEX_STATE_INIT(revs->repo);
    -+		char *gitdir;
    ++		char *wt_gitdir;
      
      		if (wt->is_current)
      			continue; /* current index already taken care of */
      
    -+		gitdir = get_worktree_git_dir(wt);
    ++		wt_gitdir = get_worktree_git_dir(wt);
     +
      		if (read_index_from(&istate,
      				    worktree_git_path(the_repository, wt, "index"),
     -				    get_worktree_git_dir(wt)) > 0)
    -+				    gitdir) > 0)
    ++				    wt_gitdir) > 0)
      			do_add_index_objects_to_pending(revs, &istate, flags);
     +
      		discard_index(&istate);
    -+		free(gitdir);
    ++		free(wt_gitdir);
      	}
      	free_worktrees(worktrees);
      }
10:  1fd3722960 ! 10:  aa07ddb6f9 path: drop `git_common_path()` in favor of `repo_common_path()`
    @@ path.h: struct strbuf *get_pathname(void);
     -		       struct strbuf *buf,
     -		       const char *fmt,
     -		       va_list args);
    - void repo_git_pathv(struct repository *repo,
    + void repo_git_pathv(const struct repository *repo,
      		    const struct worktree *wt, struct strbuf *buf,
      		    const char *fmt, va_list args);
      
11:  44df197055 = 11:  e70348a141 rerere: let `rerere_path()` write paths into a caller-provided buffer
12:  d774d8ca66 ! 12:  a5a67d9a14 path: drop `git_path()` in favor of `repo_git_path()`
    @@ path.c: static void strbuf_worktree_gitdir(struct strbuf *buf,
      		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
      }
      
    --void repo_git_pathv(struct repository *repo,
    +-void repo_git_pathv(const struct repository *repo,
     -		    const struct worktree *wt, struct strbuf *buf,
     -		    const char *fmt, va_list args)
    -+static void repo_git_pathv(struct repository *repo,
    ++static void repo_git_pathv(const struct repository *repo,
     +			   const struct worktree *wt, struct strbuf *buf,
     +			   const char *fmt, va_list args)
      {
    @@ path.h: char *xdg_cache_home(const char *filename);
      #  include "repository.h"
      
     -/* Internal implementation details that should not be used. */
    --void repo_git_pathv(struct repository *repo,
    +-void repo_git_pathv(const struct repository *repo,
     -		    const struct worktree *wt, struct strbuf *buf,
     -		    const char *fmt, va_list args);
     -
13:  4981b2524b = 13:  e38ee5e724 repo-settings: introduce function to clear struct
14:  b90c3c3bee ! 14:  7f7e3522d3 environment: move access to "core.hooksPath" into repo settings
    @@ Commit message
         should be functionally the same as there aren't ever any code paths
         where we'd execute hooks outside the context of a repository.
     
    +    Note that this requires us to change the passed-in repository in the
    +    `repo_git_path()` family of functions to be non-constant, as we call
    +    `adjust_git_path()` there.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## config.c ##
    @@ path.c: static void adjust_git_path(const struct repository *repo,
      	else if (repo->different_commondir)
      		update_common_dir(buf, git_dir_len, repo->commondir);
      }
    +@@ path.c: static void strbuf_worktree_gitdir(struct strbuf *buf,
    + 		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
    + }
    + 
    +-static void repo_git_pathv(const struct repository *repo,
    ++static void repo_git_pathv(struct repository *repo,
    + 			   const struct worktree *wt, struct strbuf *buf,
    + 			   const char *fmt, va_list args)
    + {
    +@@ path.c: static void repo_git_pathv(const struct repository *repo,
    + 	strbuf_cleanup_path(buf);
    + }
    + 
    +-char *repo_git_path(const struct repository *repo,
    ++char *repo_git_path(struct repository *repo,
    + 		    const char *fmt, ...)
    + {
    + 	struct strbuf path = STRBUF_INIT;
    +@@ path.c: char *repo_git_path(const struct repository *repo,
    + 	return strbuf_detach(&path, NULL);
    + }
    + 
    +-const char *repo_git_path_append(const struct repository *repo,
    ++const char *repo_git_path_append(struct repository *repo,
    + 				 struct strbuf *sb,
    + 				 const char *fmt, ...)
    + {
    +@@ path.c: const char *repo_git_path_append(const struct repository *repo,
    + 	return sb->buf;
    + }
    + 
    +-const char *repo_git_path_replace(const struct repository *repo,
    ++const char *repo_git_path_replace(struct repository *repo,
    + 				  struct strbuf *sb,
    + 				  const char *fmt, ...)
    + {
    +
    + ## path.h ##
    +@@ path.h: const char *repo_common_path_replace(const struct repository *repo,
    +  * For an exhaustive list of the adjustments made look at `common_list` and
    +  * `adjust_git_path` in path.c.
    +  */
    +-char *repo_git_path(const struct repository *repo,
    ++char *repo_git_path(struct repository *repo,
    + 		    const char *fmt, ...)
    + 	__attribute__((format (printf, 2, 3)));
    +-const char *repo_git_path_append(const struct repository *repo,
    ++const char *repo_git_path_append(struct repository *repo,
    + 				 struct strbuf *sb,
    + 				 const char *fmt, ...)
    + 	__attribute__((format (printf, 3, 4)));
    +-const char *repo_git_path_replace(const struct repository *repo,
    ++const char *repo_git_path_replace(struct repository *repo,
    + 				  struct strbuf *sb,
    + 				  const char *fmt, ...)
    + 	__attribute__((format (printf, 3, 4)));
     
      ## repo-settings.c ##
     @@ repo-settings.c: void repo_settings_clear(struct repository *r)
15:  392af38fbb = 15:  cff542e247 environment: move access to "core.sharedRepository" into repo settings
16:  f5aeb9c3e6 = 16:  6a64329ef4 path: adjust last remaining users of `the_repository`

---
base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
change-id: 20250204-b4-pks-path-drop-the-repository-9ed0f9956361


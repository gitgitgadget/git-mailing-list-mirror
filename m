Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56CE3C199B
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408905; cv=none; b=YBd0y5V+G+H1KuOftgWuPLTNYlICOS0FccOQuoe0fuFb3cbyMzBRYkjNFWNrxHtpSJ3d7EUKA4yCqc8xRn1wsGqR0ajz02TSQUs8MN90Wbs3lUapbQ2+VQ/UHWQHleIFeg99qkp88bMd5dAtdcFMMtndlLX4qSf3iNEg9d5a2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408905; c=relaxed/simple;
	bh=ZhsT94UlmqR36qpzJbjNIV31m1JgqBIvzWxUHtToM/w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=I/VtQHGsfco6t6E52Bl6D7BjQuOGlwCQhtuLOVTTTcrOTD7Dvn9Pq2H5yhF4E+w7AtQCkoTEgPpvNbEfMZHGIps3UovAE68rKYMVSIj2ZjU/Mn+aEOcJ0m4Gktg0OxzUwC5S/BUwwNeH4SAvXzAh5eXoVv/2raeKosL7qwPwN6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ak0PCe/7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GvylMsL8; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ak0PCe/7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GvylMsL8"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D25A51D000B1;
	Tue,  7 Jul 2026 03:21:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 07 Jul 2026 03:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408891;
	 x=1783495291; bh=CWxNjREN1D4blsijhFJutnamnBm5C+N9qx2OjouHof4=; b=
	Ak0PCe/71JNdOUz052ldNWxpmUQ5wDfYMy/ZPYiH5SWUrbHyJBNvNdaKXuMU8dA/
	JF4wFgrQ8vwy7fZaSk9sAwsY4NBsMBpxP8B/vCUukj3CpnYgV3chUkMG3WRw1fVr
	bsW4/YZ7RGlQgredIz4aRw4xqzZu9oEiV3wJiTT856rafAm6mmG8HFFc8gCMW0lk
	emQm/5kSkB44sl+6n0s5l51YrdRCiSIPXC9IfB+2UYy+Ar6skHMreyTsIfQ8UJuV
	H6tO17YCzsdIXdYqQVrb/Ac0okX6wD1obL/C0GLx4wl7Yu99mTmuko51EH3HzFG5
	cnPGKiFasJhTo0RY2CfLHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408891; x=
	1783495291; bh=CWxNjREN1D4blsijhFJutnamnBm5C+N9qx2OjouHof4=; b=G
	vylMsL86D34M4DeDlpnrpPNVsy6UuUbPnYGzlDzFOZiS5BDfnJhBP5+/Z0eg/SVw
	dPALICxyvYK0wUSSubg2DgMMwpJFavO4nK586fCZkR/SiKA80pD3h2D0I3LU1jNJ
	AMe1OGSGwOx9yNICtz/49CcbT5/LCaibJcXJZFswkMQZxr3Y+0+O5RoM4i6i3DfY
	Ue70NWHdgZxMaI31umtml5BiWa6HJqwJd+6A+wmKWuCLFEbf5k8H9hTZw0GGZdAo
	wgv55xEsxvwNIOlOqYnsevS0RlooXphHYXVSM+XLVP+etT0e0uR31zZT+PBwzcWa
	5Bzoaq12GyMuzBmhRc5zg==
X-ME-Sender: <xms:-6hMaoIhMHSfQV6FAjdBHZ9A-PNxukdxbIk18tme_EneCnCZhdMsLA>
    <xme:-6hMavkHQwjG9Eoj-QSQt19mbv5AAUzBJeAZd3V5L75MfIXTeBMlQ8uJaHLaYkZYN
    P14q0R_xdI1MnzIX-2OI57kPhnMy_52q8aKuQMF4d50-MV3j3uU9g>
X-ME-Received: <xmr:-6hMamEjvjniC07iDepl3gzqDx46xIqpuBsANLdf7RCf8I3x4YivmctgSV8DU7lmTUx7PCYhJMab43BWHLH7qjnoKw-s4u65rRzU67l6ug>
X-ME-Proxy-Cause: dmFkZTEW0d5yHSv6g44l71Xf+WlofgaV1bbVSfFFHsU3Qi8eq+fSbh7U0XJ/g8O6e7PtRT
    E23+fiyrHp3Uy2Lt7+OzK22Z842m6PuXkI1+0Dlxl17/WA4dUhtiRaq3Ln3quEQG0FftGB
    fO8zVN2mAKLaOgJzYiNh/vRzwiwlnV29S6TSysDr+UslLcsc95PqP+fitxe3YhOhnTKEQW
    L2A1snaBylUzOjD/MXEtbjFfzjyXbAZh9HVeEFMTgJcO4d5pQyWJC6vPfY2iPifFoykT0A
    56bgXYwFoyjtYrrQgmYZQ61+/B3UdWUEK4VYhN2IUNllKpdEjepibMmhaUlFo7IhQQFvZI
    2txyduDBossG2r9qzU0r7NCqS5e3JaRsFzN7Def03V19PNIuc7RULX42dRGsvTcLVjHdW0
    OyTwisSHzl7WcuFgxs92IBCfhhkjVAZcZObqpu+qcvvwpQbRbbiFhGCximEUOdW2tR+TKM
    sWX8JRzZegEZAEJzXKhG795hgYmUGaiu6HBsJ9lRMF7hSkKseKGTIr503yduyGLBdqaznC
    otOeqmwyad6P2UDgAha5VmjU24ZmHKOaRb2jVZjFLKT3i759MuDL5h9ciqHGHSUDENN/e+
    U/nffr24EdzFVcMrCy9h/OofOjcbr1i0eX+wHS/qqWpbZIemJzEJ2B8bQntg
X-ME-Proxy: <xmx:-6hMavG59A0XHBv0oxu4HXjep43l66_jzQn5ePYpszkEdcqld6U_jQ>
    <xmx:-6hMajMtz6LVBsohAdroEC3k--cnvb81gADoMsaw0IfwvRKEbfdeEA>
    <xmx:-6hMauGRZ2QD_GLaKvYVMo-karAItJZifzaSVN4jkGjQoKBDs9kElw>
    <xmx:-6hMaqNMaNTvKcXC6n_kqVrE1AeJWL_9Eupulvm_MRkReSN4h3blwQ>
    <xmx:-6hMankD9FOOiBLRbqNVvn0VETEyCJzozIOkERFyoKFOr_6GoiMv1qaT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:21:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8b27be3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:21:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/13] setup: split up repository discovery and setup
Date: Tue, 07 Jul 2026 09:21:19 +0200
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO+oTGoC/42Oyw6CMBBFf8V0bU0fio0r/8OwgHaQ8QFNpzQSw
 r9bkA9weTL33jMTIwgIxC67iQVISNh3GdR+x2xbdXfg6DIzJVQhCmm4fxIniIPn5F8YuUOyfYI
 w8qpz28WdG6WNlkZoy/KSD9DgZ7Xcyh/TUD/AxmV6SbRIsQ/j+kaSS24zavGXMUkuuNSmOEJ9q
 oRW19w64JuV8zx/Ae7moIzlAAAA
X-Change-ID: 20260618-pks-setup-split-discovery-and-setup-d7f23831803c
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this patch series is the next set of refactorings to simplify how we
configure repositories in "setup.c".

The setup of the repository is essentially happening in two phases:

  1. We discover the location of the repository as well as its format.

  2. We then use this information to configure the repository.

So far so sensible. In our code base though these two phases are quite
intertwined with one another, as we continue to repeatedly call
`set_git_dir()` and `set_work_tree()` on the repository as we discover
its locations. This makes it hard to follow the logic, and it basically
leaves us with a partially-configured repository.

This patch series splits this up into two proper phases that are
completely separate from one another. The first phase now populates a
`struct repo_discovery` structure, without even having access to any
repository. The second phase then takes that structure and configures
the repository accordingly.

Ultimately, the motivation of this whole exercise is that eventually we
can unify configuration of the repository into `repo_init()` instead of
having bits and pieces thereof distributed across "repository.c" and
"setup.c".

This series is built on top of v2.55.0 with the following three branches
merged into it:

  - ps/refs-onbranch-fixes at d6522d01df (refs: protect against
    chicken-and-egg recursion, 2026-06-25).

  - ps/setup-drop-global-state at 1ceee7431b (treewide: drop
    USE_THE_REPOSITORY_VARIABLE, 2026-06-11).

  - jk/repo-info-path-keys at 3ac28d832a (repo: add path.gitdir with
    absolute and relative suffix formatting, 2026-06-24).

Changes in v2:
  - Expand commit message to talk about precedence order between
    the "GIT_SHALLOW_FILE" environment variable and the "--shallow-file"
    command line switch.
  - Remove a now-unused parameter in `set_alternate_shallow_file()`.
  - Fix a typo.
  - Link to v1: https://patch.msgid.link/20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (13):
      setup: rename `check_repository_format_gently()`
      setup: mark bogus worktree in `apply_repository_format()`
      setup: unify setup of shallow file
      setup: split up concerns of `setup_git_env_internal()`
      setup: introduce explicit repository discovery
      setup: embed repository format in discovery
      setup: move prefix into repository
      setup: drop static `cwd` variable
      setup: propagate prefix via repository discovery
      setup: make repository discovery self-contained
      setup: drop redundant configuration of `startup_info->have_repository`
      setup: pass worktree to `init_db()`
      setup: mark `set_git_work_tree()` as file-local

 builtin/clone.c        |   8 +-
 builtin/init-db.c      |  34 ++--
 builtin/repo.c         |   8 +-
 builtin/rev-parse.c    |   5 +-
 builtin/update-index.c |   4 +-
 common-init.c          |  20 +++
 git.c                  |   2 +-
 object-name.c          |   4 +-
 repository.c           |   1 +
 repository.h           |   8 +
 setup.c                | 419 ++++++++++++++++++++++++++-----------------------
 setup.h                |   7 +-
 shallow.c              |   4 +-
 shallow.h              |   2 +-
 trace.c                |   4 +-
 15 files changed, 285 insertions(+), 245 deletions(-)

Range-diff versus v1:

 1:  19230b18cf =  1:  f4db0a6a10 setup: rename `check_repository_format_gently()`
 2:  246e8caf8f !  2:  72f51e01ff setup: mark bogus worktree in `apply_repository_format()`
    @@ setup.c: static const char *setup_explicit_git_dir(struct repository *repo,
     +		 * The environment variable overrides "core.worktree". This
     +		 * also has the consequence that we don't want to flag cases as
     +		 * bogus where we have both "core.worktree" and "core.bare", so
    -+		 * we have to exlicitly unset the configuration.
    ++		 * we have to explicitly unset the configuration.
     +		 */
     +		FREE_AND_NULL(repo_fmt->work_tree);
      		set_git_work_tree(repo, work_tree_env);
 3:  06ea13242f !  3:  1542e52523 setup: unify setup of shallow file
    @@ Commit message
         of this patch series. Consequently, it will become possible for us to
         completely discard `the_repository` and populate it anew.
     
    +    Note that on first sight, this change looks like it might change the
    +    precedence order. Before this change, we used to configure the shallow
    +    file in the arguments handler first, and then it looks like we override
    +    it via the environment variable. What's important to note though is the
    +    last parameter to `set_alternate_shallow_file()`, which tells us whether
    +    we want to overwrite a preexisting value, and when applying the value
    +    from the environment we tell it not to overwrite preexisting values. So
    +    in effect, the command line has precedence over the environment. After
    +    this change, we now overwrite preexisting environment variables when we
    +    see the argument, and consequently we keep the precedence order in tact.
    +
    +    With this change though we don't need the final parameter anymore that
    +    tells `set_alternate_shallow_file()` whether or not to overwrite. We
    +    only have a single callsite for this function now, and that function is
    +    itself only ever called exactly once. Remove that parameter.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## git.c ##
    @@ setup.c: int apply_repository_format(struct repository *repo,
      		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
     +		shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
     +		if (shallow_file)
    -+			set_alternate_shallow_file(repo, shallow_file, 0);
    ++			set_alternate_shallow_file(repo, shallow_file);
      	}
      
      	repo->bare_cfg = format->is_bare;
    +
    + ## shallow.c ##
    +@@
    + #include "statinfo.h"
    + #include "trace.h"
    + 
    +-void set_alternate_shallow_file(struct repository *r, const char *path, int override)
    ++void set_alternate_shallow_file(struct repository *r, const char *path)
    + {
    + 	if (r->parsed_objects->is_shallow != -1)
    + 		BUG("is_repository_shallow must not be called before set_alternate_shallow_file");
    +-	if (r->parsed_objects->alternate_shallow_file && !override)
    +-		return;
    + 	free(r->parsed_objects->alternate_shallow_file);
    + 	r->parsed_objects->alternate_shallow_file = xstrdup_or_null(path);
    + }
    +
    + ## shallow.h ##
    +@@
    + struct oid_array;
    + struct strvec;
    + 
    +-void set_alternate_shallow_file(struct repository *r, const char *path, int override);
    ++void set_alternate_shallow_file(struct repository *r, const char *path);
    + int register_shallow(struct repository *r, const struct object_id *oid);
    + int unregister_shallow(const struct object_id *oid);
    + int is_repository_shallow(struct repository *r);
 4:  add8007726 =  4:  5a2b4132a1 setup: split up concerns of `setup_git_env_internal()`
 5:  4bc374b957 !  5:  8190a24acf setup: introduce explicit repository discovery
    @@ setup.c: static void apply_and_export_relative_gitdir(struct repository *repo, c
      	int offset;
      
     @@ setup.c: static const char *setup_explicit_git_dir(struct repository *repo,
    - 		 * we have to exlicitly unset the configuration.
    + 		 * we have to explicitly unset the configuration.
      		 */
      		FREE_AND_NULL(repo_fmt->work_tree);
     -		set_git_work_tree(repo, work_tree_env);
 6:  687443fcac !  6:  869b6cf7cb setup: embed repository format in discovery
    @@ setup.c: static const char *repo_discover_explicit_gitdir(struct repo_discovery
      	}
     @@ setup.c: static const char *repo_discover_explicit_gitdir(struct repo_discovery *discover
      		 * bogus where we have both "core.worktree" and "core.bare", so
    - 		 * we have to exlicitly unset the configuration.
    + 		 * we have to explicitly unset the configuration.
      		 */
     -		FREE_AND_NULL(repo_fmt->work_tree);
     +		FREE_AND_NULL(discovery->format.work_tree);
 7:  6e2e1caf30 =  7:  af482fd82c setup: move prefix into repository
 8:  9dda7f521b =  8:  8ad046bc79 setup: drop static `cwd` variable
 9:  4fc0bbd6a2 =  9:  231c98255b setup: propagate prefix via repository discovery
10:  54ddf6a854 = 10:  ee241b765d setup: make repository discovery self-contained
11:  46dbc1ac4c = 11:  4fa953a970 setup: drop redundant configuration of `startup_info->have_repository`
12:  c42085145a = 12:  4299a4aadb setup: pass worktree to `init_db()`
13:  9a9a4dea01 = 13:  1add08fce7 setup: mark `set_git_work_tree()` as file-local

---
base-commit: b340fc4c4f3850656b726ff757b42d2020215378
change-id: 20260618-pks-setup-split-discovery-and-setup-d7f23831803c


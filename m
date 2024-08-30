Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05816D9AA
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008940; cv=none; b=jmIUGURsXBhpEvcxb6chpCRAQ2SUXPFlmQ71qWBFhsE2iC0c1pHvpohtt5S188JN9WZpxJhBrAgbJasUQxJl7OOaLfLL2VI77IU2mOfx6wBiz2ACMB0EFK3UYfVCOIlLkninw6kVco5Uo7TE9azzGqu5iXPWKpezjYPdI8nVbRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008940; c=relaxed/simple;
	bh=GegADp2vWjzzxp6YP2I2vTBXrKy2fzS86v4IKwO6ing=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQzmy9njjHvTQ9QSBHNMm9+4IxPMwnDkvb3zLX4edSCOd4y2v1pIQzE8halzEj+YOCmJehEOzg+KkIqSf9ykAvU4sDP5GDlEXh3Pu7lru0rBcPvxVPYKR4IRLGlhhEAaktg+WTVX3pB6K3fKIt/yIVmMOtQ80ZLAKczgzz15u9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yxp00vT9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QF28+/Iq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yxp00vT9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QF28+/Iq"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id AC798138024B;
	Fri, 30 Aug 2024 05:08:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 30 Aug 2024 05:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008936; x=1725095336; bh=+31IH685et
	hHBuckx46422SeWcvihYHvuaO+Xqok/JQ=; b=Yxp00vT9GyhGQQp2/Qkl4d1HMf
	QLapDr6yIjk2RJ8kA2iq3KoYjbhQuQD9TsOM+XoigZY+tQ8e9XVwxZOfNEAV8ZyW
	MNG56aIjGR/EGoACN+vl/vtkHl7ustJQsABEC+5SKyBOetrU5UERcGdEX7j/Cj0A
	h0ArrNhFQv1d0lmAsfsIdX6uLZwJWG7+c70DHxSgjCr9kxQn4TcsM6F4gYIlXI2f
	dsYykcCM3L0sizv7PEJtTIUx7Hsv9E3p9oWOwpmT5/kh/wlMVn9c1QXpGVTo+NDl
	vqNpt+T1L7NidYO3yhjND1hgF0uHZjKOr//D3CY7jty2JNwiq0iOnYtSTgsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008936; x=1725095336; bh=+31IH685ethHBuckx46422SeWcvi
	hYHvuaO+Xqok/JQ=; b=QF28+/IqyMxlRojiUd1yVp+ihPmXhElTqyPbqtErh/dV
	AfC0duQng1VUIWdgyEvzfYJ03WGqWyVm55iH0ZxOdmeA+qajLNOgcFr6Ed7GZtFo
	Q2Nt13wD6XzmcbXtP9w5PHVDGeHZ4Hzysh8BY4eH+8LgV5LD5LDGz58fg3QjDBpi
	Gr9107incMo0pdtjTryMQQJ8cd85X2c4k2tbPjmPNLQan8XfNTeDXKTqq6d74bWU
	QjTHWKwbYwh6FTWEJJd8m9AjR0DsWQQ0AV6SJSfNhk0Vv/kTm65bLa5sKcCI5xHu
	yi38yKuFR2SaZdw+AulbWtNIVp0nv/YIzQ2BrdID7Q==
X-ME-Sender: <xms:KIzRZgIVQN7zUjVQI43ytHL8MAelvTMM_33-L0Qbf-b2paXYGimCgQ>
    <xme:KIzRZgLa9pWMCNUDxcOkDtaFHLWZWByunUm__BEUZhCM9ar3Gt9jkGgDKB8qomMcE
    Fzj0FnWCyFxnbSzUA>
X-ME-Received: <xmr:KIzRZgv3ME_ZyY2cXIpL_iiDKCjoVCUm4TqdldywOFEVVy0m_uq8vpWMLQwkxCbkW5KuNFXDdNr_SMeU6SokGWf3HdA89BA_LrnmdHlJzV_kew1omw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghl
    vhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:KIzRZtZ91EKaVYDHQ3Vd6ZoIu1Ojol4JLpZMoAfcwxTUxRTJv85fTA>
    <xmx:KIzRZnacEy-g8QGm9u2XuN4qiXgYtzoHDzHQKi36FIqSKLZBgn7AQQ>
    <xmx:KIzRZpA-mrv-fAP8UssJj15zJCW9oZ6mwPV6Z1Qd5TEkCZQl1x4IYw>
    <xmx:KIzRZtaUP3Q0NjFioBy8U8PltVKyCn7GGIbcOFAORb1idiR9Qnu2tA>
    <xmx:KIzRZmWogjtTzSIXr0zu4Gliu3xD-vd9lzbGDcu9azFaLdUz5LoKmUpu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:08:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d178f230 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:08:43 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:08:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/21] environment: guard reliance on `the_repository`
Message-ID: <cover.1725008897.git.ps@pks.im>
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

this is the second version of my patch series which guards functions and
variables in the environment subsystem that rely on `the_repository`
with the `USE_THE_REPOSITORY_VARIABLE` define.

Changes compared to v1:

  - Clean up now-unnecessary and add newly-necessary includes.

  - Stop reordering includes in "setup.c".

  - Fix missing `USE_THE_REPOSITORY_VARIABLE` defines in Win32 code.

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
  environment: move `odb_mkstemp()` into object layer
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

Range-diff against v1:
 1:  0fe3e3e1ccc !  1:  a1969c5b073 environment: make `get_git_dir()` accept a repository
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## apply.c ##
    +@@
    + #include "path.h"
    + #include "quote.h"
    + #include "read-cache.h"
    ++#include "repository.h"
    + #include "rerere.h"
    + #include "apply.h"
    + #include "entry.h"
     @@ apply.c: static int read_apply_cache(struct apply_state *state)
      {
      	if (state->index_file)
    @@ builtin/am.c: static int fall_back_threeway(const struct am_state *state, const
      		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
     
      ## builtin/commit.c ##
    +@@
    + #include "path.h"
    + #include "preload-index.h"
    + #include "read-cache.h"
    ++#include "repository.h"
    + #include "string-list.h"
    + #include "rerere.h"
    + #include "unpack-trees.h"
     @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
      
      		discard_index(the_repository->index);
    @@ builtin/config.c: static void location_options_init(struct config_location_optio
      
     
      ## builtin/difftool.c ##
    +@@
    + #include "hex.h"
    + #include "parse-options.h"
    + #include "read-cache-ll.h"
    ++#include "repository.h"
    + #include "sparse-index.h"
    + #include "strvec.h"
    + #include "strbuf.h"
     @@ builtin/difftool.c: static void changed_files(struct hashmap *result, const char *index_path,
      	struct child_process update_index = CHILD_PROCESS_INIT;
      	struct child_process diff_files = CHILD_PROCESS_INIT;
    @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
      
     
      ## builtin/merge.c ##
    +@@
    + #include "object-name.h"
    + #include "parse-options.h"
    + #include "lockfile.h"
    ++#include "repository.h"
    + #include "run-command.h"
    + #include "hook.h"
    + #include "diff.h"
     @@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
      		if (invoked_hook)
      			discard_index(the_repository->index);
    @@ builtin/merge.c: static void prepare_to_commit(struct commit_list *remoteheads)
      		BUG("the control must not reach here under --squash");
     
      ## builtin/stash.c ##
    +@@
    + #include "entry.h"
    + #include "preload-index.h"
    + #include "read-cache.h"
    ++#include "repository.h"
    + #include "rerere.h"
    + #include "revision.h"
    + #include "setup.h"
     @@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info *info,
      		strvec_pushf(&cp.env, GIT_WORK_TREE_ENVIRONMENT"=%s",
      			     absolute_path(get_git_work_tree()));
    @@ builtin/stash.c: static int do_apply_stash(const char *prefix, struct stash_info
      	}
     
      ## cache-tree.c ##
    +@@
    + #define USE_THE_REPOSITORY_VARIABLE
    + 
    + #include "git-compat-util.h"
    +-#include "environment.h"
    + #include "hex.h"
    + #include "lockfile.h"
    + #include "tree.h"
    +@@
    + #include "object-store-ll.h"
    + #include "read-cache-ll.h"
    + #include "replace-object.h"
    ++#include "repository.h"
    + #include "promisor-remote.h"
    + #include "trace.h"
    + #include "trace2.h"
     @@ cache-tree.c: int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
      
      	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
    @@ pathspec.c: static void init_pathspec_item(struct pathspec_item *item, unsigned
      		}
     
      ## read-cache.c ##
    +@@
    + #include "path.h"
    + #include "preload-index.h"
    + #include "read-cache.h"
    ++#include "repository.h"
    + #include "resolve-undo.h"
    + #include "revision.h"
    + #include "strbuf.h"
     @@ read-cache.c: static int should_delete_shared_index(const char *shared_index_path)
      static int clean_shared_index_files(const char *current_hex)
      {
    @@ trace.c
      #include "git-compat-util.h"
      #include "abspath.h"
      #include "environment.h"
    ++#include "repository.h"
    + #include "quote.h"
    + #include "setup.h"
    + #include "trace.h"
     @@ trace.c: void trace_repo_setup(void)
      	if (!startup_info->prefix)
      		prefix = "(null)";
 2:  cdd6dd308c3 !  2:  deebf2c5205 environment: make `get_git_common_dir()` accept a repository
    @@ builtin/gc.c: static int schtasks_schedule_task(const char *exec_path, enum sche
      
     
      ## builtin/rev-parse.c ##
    +@@
    + #include "path.h"
    + #include "diff.h"
    + #include "read-cache-ll.h"
    ++#include "repository.h"
    + #include "revision.h"
    + #include "setup.h"
    + #include "split-index.h"
     @@ builtin/rev-parse.c: int cmd_rev_parse(int argc, const char **argv, const char *prefix)
      				continue;
      			}
 3:  bb01e4fab9d !  3:  43abfa7b139 environment: make `get_object_directory()` accept a repository
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/commit-graph.c ##
    +@@
    + #include "builtin.h"
    + #include "commit.h"
    + #include "config.h"
    +-#include "environment.h"
    + #include "gettext.h"
    + #include "hex.h"
    + #include "parse-options.h"
     @@ builtin/commit-graph.c: static int graph_verify(int argc, const char **argv, const char *prefix)
      		usage_with_options(builtin_commit_graph_verify_usage, options);
      
    @@ builtin/commit-graph.c: static int graph_write(int argc, const char **argv, cons
      	if (opts.split)
     
      ## builtin/count-objects.c ##
    +@@
    + #include "builtin.h"
    + #include "config.h"
    + #include "dir.h"
    +-#include "environment.h"
    + #include "gettext.h"
    + #include "path.h"
    + #include "repository.h"
     @@ builtin/count-objects.c: int cmd_count_objects(int argc, const char **argv, const char *prefix)
      		report_linked_checkout_garbage(the_repository);
      	}
    @@ builtin/count-objects.c: int cmd_count_objects(int argc, const char **argv, cons
      	if (verbose) {
     
      ## builtin/multi-pack-index.c ##
    +@@
    + #include "builtin.h"
    + #include "abspath.h"
    + #include "config.h"
    +-#include "environment.h"
    + #include "gettext.h"
    + #include "parse-options.h"
    + #include "midx.h"
    +@@
    + #include "trace2.h"
    + #include "object-store-ll.h"
    + #include "replace-object.h"
    ++#include "repository.h"
    + 
    + #define BUILTIN_MIDX_WRITE_USAGE \
    + 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]" \
     @@ builtin/multi-pack-index.c: static int parse_object_dir(const struct option *opt, const char *arg,
      	char **value = opt->value;
      	free(*value);
    @@ object-file.c: int stream_loose_object(struct input_stream *in_stream, size_t le
      	/*
     
      ## pack-write.c ##
    +@@
    + #include "pack-objects.h"
    + #include "pack-revindex.h"
    + #include "path.h"
    ++#include "repository.h"
    + #include "strbuf.h"
    + 
    + void reset_pack_idx_option(struct pack_idx_option *opts)
     @@ pack-write.c: char *index_pack_lockfile(int ip_out, int *is_well_formed)
      		packname[len-1] = 0;
      		if (skip_prefix(packname, "keep\t", &name))
    @@ prune-packed.c
     +#define USE_THE_REPOSITORY_VARIABLE
     +
      #include "git-compat-util.h"
    - #include "environment.h"
    +-#include "environment.h"
      #include "gettext.h"
    + #include "object-store-ll.h"
    + #include "packfile.h"
    + #include "progress.h"
    + #include "prune-packed.h"
    ++#include "repository.h"
    + 
    + static struct progress *progress;
    + 
     @@ prune-packed.c: void prune_packed_objects(int opts)
      	if (opts & PRUNE_PACKED_VERBOSE)
      		progress = start_delayed_progress(_("Removing duplicate objects"), 256);
    @@ repository.h: extern struct repository *the_repository;
       * Define a custom repository layout. Any field can be NULL, which
     
      ## server-info.c ##
    +@@
    + 
    + #include "git-compat-util.h"
    + #include "dir.h"
    +-#include "environment.h"
    + #include "hex.h"
    + #include "repository.h"
    + #include "refs.h"
     @@ server-info.c: static int write_pack_info_file(struct update_info_ctx *uic)
      
      static int update_info_packs(int force)
    @@ setup.c: static void create_object_directory(void)
      	safe_create_dir(path.buf, 1);
     
      ## tmp-objdir.c ##
    +@@
    + #include "strvec.h"
    + #include "quote.h"
    + #include "object-store-ll.h"
    ++#include "repository.h"
    + 
    + struct tmp_objdir {
    + 	struct strbuf path;
     @@ tmp-objdir.c: struct tmp_objdir *tmp_objdir_create(const char *prefix)
      	 * can recognize any stale objdirs left behind by a crash and delete
      	 * them.
 4:  d857c5fab44 !  4:  d7554cb0fe0 environment: make `get_index_file()` accept a repository
    @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
      			die("Unable to write new index file");
     
      ## builtin/write-tree.c ##
    +@@
    + 
    + #include "builtin.h"
    + #include "config.h"
    +-#include "environment.h"
    + #include "gettext.h"
    + #include "hex.h"
    + #include "tree.h"
     @@ builtin/write-tree.c: int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
      	prepare_repo_settings(the_repository);
      	the_repository->settings.command_requires_full_index = 0;
    @@ repository.h: extern struct repository *the_repository;
       * Define a custom repository layout. Any field can be NULL, which
     
      ## wt-status.c ##
    +@@
    + #include "revision.h"
    + #include "diffcore.h"
    + #include "quote.h"
    ++#include "repository.h"
    + #include "run-command.h"
    + #include "strvec.h"
    + #include "remote.h"
     @@ wt-status.c: void wt_status_prepare(struct repository *r, struct wt_status *s)
      					"HEAD", 0, NULL, NULL);
      	s->reference = "HEAD";
 5:  ac27d7128a4 !  5:  1cc727e4763 environment: make `get_graft_file()` accept a repository
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/replace.c ##
    +@@
    + #include "builtin.h"
    + #include "config.h"
    + #include "editor.h"
    +-#include "environment.h"
    + #include "gettext.h"
    + #include "hex.h"
    + #include "refs.h"
     @@ builtin/replace.c: static int create_graft(int argc, const char **argv, int force, int gentle)
      
      static int convert_graft_file(int force)
 6:  7fc346d3bb5 !  6:  22e9dcb28a9 environment: make `get_git_work_tree()` accept a repository
    @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *pr
      
     
      ## builtin/fsmonitor--daemon.c ##
    +@@
    + #include "abspath.h"
    + #include "config.h"
    + #include "dir.h"
    +-#include "environment.h"
    + #include "gettext.h"
    + #include "parse-options.h"
    + #include "fsmonitor-ll.h"
     @@ builtin/fsmonitor--daemon.c: static int fsmonitor_run_daemon(void)
      
      	/* Prepare to (recursively) watch the <worktree-root> directory. */
    @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *pref
      		if (real_git_dir)
     
      ## builtin/reset.c ##
    +@@
    + #include "object-name.h"
    + #include "parse-options.h"
    + #include "path.h"
    ++#include "repository.h"
    + #include "unpack-trees.h"
    + #include "cache-tree.h"
    + #include "setup.h"
     @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
      	else
      		trace2_cmd_mode(reset_type_names[reset_type]);
    @@ builtin/update-index.c: int cmd_update_index(int argc, const char **argv, const
      		BUG("bad untracked_cache value: %d", untracked_cache);
     
      ## dir.c ##
    +@@
    + #include "object-store-ll.h"
    + #include "path.h"
    + #include "refs.h"
    ++#include "repository.h"
    + #include "wildmatch.h"
    + #include "pathspec.h"
    + #include "utf8.h"
     @@ dir.c: static const char *get_ident_string(void)
      		return sb.buf;
      	if (uname(&uts) < 0)
    @@ environment.h: extern char *git_work_tree_cfg;
      #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
     
      ## fsmonitor.c ##
    +@@
    + #include "fsmonitor.h"
    + #include "fsmonitor-ipc.h"
    + #include "name-hash.h"
    ++#include "repository.h"
    + #include "run-command.h"
    + #include "strbuf.h"
    + #include "trace2.h"
     @@ fsmonitor.c: static int query_fsmonitor_hook(struct repository *r,
      	strvec_pushf(&cp.args, "%d", version);
      	strvec_pushf(&cp.args, "%s", last_update);
    @@ setup.c: static int create_default_files(const char *template_path,
      	 * First copy the templates -- we might have the default
     
      ## trace.c ##
    +@@
    + 
    + #include "git-compat-util.h"
    + #include "abspath.h"
    +-#include "environment.h"
    + #include "repository.h"
    + #include "quote.h"
    + #include "setup.h"
     @@ trace.c: void trace_repo_setup(void)
      
      	cwd = xgetcwd();
 7:  d2f81a540a2 =  7:  ec4804a99bf config: document `read_early_config()` and `read_very_early_config()`
 8:  85e40696cc9 =  8:  b8aa5dcc0b6 config: make dependency on repo in `read_early_config()` explicit
 9:  8321454adc8 !  9:  ac2cc4e0371 environment: move `odb_mkstemp()` into object layer
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## bundle-uri.c ##
    +@@
    + #include "bundle-uri.h"
    + #include "bundle.h"
    + #include "copy.h"
    +-#include "environment.h"
    + #include "gettext.h"
    + #include "refs.h"
    + #include "run-command.h"
     @@
      #include "config.h"
      #include "fetch-pack.h"
10:  0b3916b2d0d = 10:  f0d3794dfc4 environment: make `get_git_namespace()` self-contained
11:  c20f6c04dfa ! 11:  9e0e2528b94 environment: move `set_git_dir()` and related into setup layer
    @@ environment.h: int have_git_dir(void);
     
      ## setup.c ##
     @@
    - 
    - #include "git-compat-util.h"
    - #include "abspath.h"
    -+#include "chdir-notify.h"
    -+#include "config.h"
    - #include "copy.h"
    -+#include "dir.h"
    - #include "environment.h"
      #include "exec-cmd.h"
    -+#include "exec-cmd.h"
      #include "gettext.h"
      #include "hex.h"
     +#include "object-file.h"
      #include "object-name.h"
    -+#include "path.h"
    -+#include "quote.h"
      #include "refs.h"
     +#include "replace-object.h"
      #include "repository.h"
    --#include "config.h"
    --#include "dir.h"
    + #include "config.h"
    + #include "dir.h"
      #include "setup.h"
     +#include "shallow.h"
      #include "string-list.h"
    --#include "chdir-notify.h"
    --#include "path.h"
    --#include "quote.h"
     +#include "strvec.h"
    + #include "chdir-notify.h"
    + #include "path.h"
    + #include "quote.h"
     +#include "tmp-objdir.h"
     +#include "trace.h"
      #include "trace2.h"
      #include "worktree.h"
    --#include "exec-cmd.h"
    - 
    - static int inside_git_dir = -1;
    - static int inside_work_tree = -1;
    + #include "exec-cmd.h"
     @@ setup.c: enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
      	return result;
      }
12:  a5a78db1697 = 12:  78f77a006a0 environment: reorder header to split out `the_repository`-free section
13:  27a7d00de78 ! 13:  9a3f466b530 environment: guard state depending on a repository
    @@ Commit message
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## compat/mingw.c ##
    +@@
    ++#define USE_THE_REPOSITORY_VARIABLE
    ++
    + #include "../git-compat-util.h"
    + #include "win32.h"
    + #include <aclapi.h>
    +
    + ## compat/win32/path-utils.c ##
    +@@
    ++#define USE_THE_REPOSITORY_VARIABLE
    ++
    + #include "../../git-compat-util.h"
    + #include "../../environment.h"
    + 
    +
      ## config.c ##
     @@
       *
14:  b2c11c8e316 = 14:  0d7365c5190 repo-settings: split out declarations into a standalone header
17:  d22209121ce = 15:  231c52ce82f repo-settings: track defaults close to `struct repo_settings`
15:  f1b6807fae3 = 16:  fc30365e1f1 branch: stop modifying `log_all_ref_updates` variable
16:  626e24aac7a ! 17:  9cc8518a02d refs: stop modifying global `log_all_ref_updates` variable
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/checkout.c ##
    +@@
    + #include "read-cache.h"
    + #include "refs.h"
    + #include "remote.h"
    ++#include "repo-settings.h"
    + #include "resolve-undo.h"
    + #include "revision.h"
    + #include "setup.h"
     @@ builtin/checkout.c: static void update_refs_for_switch(const struct checkout_opts *opts,
      
      			refname = mkpathdup("refs/heads/%s", opts->new_orphan_branch);
    @@ environment.h: extern int core_apply_sparse_checkout;
      enum rebase_setup_type {
     
      ## refs.c ##
    +@@
    + #include "submodule.h"
    + #include "worktree.h"
    + #include "strvec.h"
    +-#include "repository.h"
    ++#include "repo-settings.h"
    + #include "setup.h"
    + #include "sigchain.h"
    + #include "date.h"
     @@ refs.c: static char *normalize_reflog_message(const char *msg)
      	return strbuf_detach(&sb, NULL);
      }
    @@ refs.h: int refs_verify_refname_available(struct ref_store *refs,
      
     
      ## refs/files-backend.c ##
    +@@
    + #include "../hex.h"
    + #include "../fsck.h"
    + #include "../refs.h"
    ++#include "../repo-settings.h"
    + #include "refs-internal.h"
    + #include "ref-cache.h"
    + #include "packed-backend.h"
     @@ refs/files-backend.c: static int write_ref_to_lockfile(struct files_ref_store *refs,
      static int commit_ref_update(struct files_ref_store *refs,
      			     struct ref_lock *lock,
18:  b6a9eb981ee = 18:  b5ed6928070 environment: stop storing "core.logAllRefUpdates" globally
19:  ef312f67f76 = 19:  194d858877f environment: stop storing "core.preferSymlinkRefs" globally
20:  f2a28d38e5d ! 20:  fc6fcebf7f7 environment: stop storing "core.warnAmbiguousRefs" globally
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/rev-parse.c ##
    +@@
    + #include "path.h"
    + #include "diff.h"
    + #include "read-cache-ll.h"
    ++#include "repo-settings.h"
    + #include "repository.h"
    + #include "revision.h"
    + #include "setup.h"
     @@ builtin/rev-parse.c: int cmd_rev_parse(int argc, const char **argv, const char *prefix)
      			}
      			if (opt_with_value(arg, "--abbrev-ref", &arg)) {
    @@ environment.h: extern int has_symlinks;
      extern char *apply_default_ignorewhitespace;
     
      ## object-name.c ##
    +@@
    + #include "pretty.h"
    + #include "object-store-ll.h"
    + #include "read-cache-ll.h"
    ++#include "repo-settings.h"
    + #include "repository.h"
    + #include "setup.h"
    + #include "midx.h"
     @@ object-name.c: static int get_oid_basic(struct repository *r, const char *str, int len,
      	int fatal = !(flags & GET_OID_QUIETLY);
      
    @@ object-name.c: static int get_oid_basic(struct repository *r, const char *str, i
      		warning(warn_msg, len, str);
     
      ## ref-filter.c ##
    +@@
    + #include "object-name.h"
    + #include "object-store-ll.h"
    + #include "oid-array.h"
    ++#include "repo-settings.h"
    + #include "repository.h"
    + #include "commit.h"
    + #include "mailmap.h"
     @@ ref-filter.c: static const char *show_ref(struct refname_atom *atom, const char *refname)
      	if (atom->option == R_SHORT)
      		return refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
21:  ecafe1585f8 = 21:  a0b75c4bc99 environment: stop storing "core.notesRef" globally
-- 
2.46.0.421.g159f2d50e7.dirty


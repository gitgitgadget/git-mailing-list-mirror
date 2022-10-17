Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770C5C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 02:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJQCXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiJQCX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 22:23:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5412C66A
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so11324761wms.0
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lbS3AszidKN7RP9hYps707b85/07UQyqRHz2S+0YiM=;
        b=chWZoh65KwCsLzTJGRMdA+fJMk9B/pG1zVJF20a59fsliV2LnDqk0NZstvPX66pOgC
         0C+0d/MvLGlqzNWjcpCOVTc5gY7f/5NUg4G2lGTUsp7UU0s3TSkOE4vtBpJaPw42vPHx
         c64c5KCjgupC1P6ZkAh/6XSrdHYG4npVeIY2QEiFQuVKE4DjsNG4R5drNEMkzQdpzJK4
         9IoO6bFRwbwCsGlCoYXuQ7Ogm3OxqcVBvVim6jku+eu5ZeqOYRBJWxDVsRDctv/hZeyf
         glq3iXoeN2GDHwsHH0iJzOTA2nhb6pE1bcE0d3Xsh9yEv0AgUUfbpHBts6YM9N6jeRkn
         kdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lbS3AszidKN7RP9hYps707b85/07UQyqRHz2S+0YiM=;
        b=WQmK56iD/QulZF+GIqnlGuOGGUNeYKbbEmiRuhD5NOBj18nTm03mFYBC2RNsE8yTHk
         yxXQkN3vAW0hBJzeWfhNR/7XFZLsRt9BkGVX6I+FxIcRInYRlz2mfJr63ewpkV528wcl
         yMXznfxrcK3OJ8kOGtRR4oa+9XBVpL8aHH3fmvpRvlzHDheq9GtqN6hmu3Knx6tVnqx3
         ME7Y8b81Ovv1ha8LhpILHvhanc/kpcgCnRSjmZZPHHpmv4/1DObT8XLClgQAWeKcgayE
         byklbIDWY1+56B2mzpH1yVWN9FbNn89JDeriRh2xh3J1uoXgA16xB54y/Dc88QuA6w30
         gjwQ==
X-Gm-Message-State: ACrzQf0bD1ojrxl1kWeMujArgSvn2DKuKoKT1IvtSJizC5apbqnA1kRI
        VFIFvTJOEf0b6Cdb5d7Y3Htlz+fuVoQ=
X-Google-Smtp-Source: AMsMyM64y91hIupWNTgj/r/46Nf1gwvXgzfsO2p/Msj3m+5B1QXHeMO3c6bNofRWwEvzrYrUrKKljg==
X-Received: by 2002:a05:600c:3c8e:b0:3b4:d224:addf with SMTP id bg14-20020a05600c3c8e00b003b4d224addfmr17604679wmb.132.1665973403204;
        Sun, 16 Oct 2022 19:23:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020adf8b04000000b00231893bfdc7sm7651121wra.2.2022.10.16.19.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 19:23:22 -0700 (PDT)
Message-Id: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
From:   "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 02:23:12 +0000
Subject: [PATCH v3 0/9] archive: Add --recurse-submodules to git-archive command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it possible to include submodule contents in an archive command.

The inspiration for this change comes from this Github thread,
https://github.com/dear-github/dear-github/issues/214, with at least 160
👍🏻 's at the time of writing. (I stumbled upon it because I wanted it as
well).

I figured the underlying implementation wouldn't be too difficult with most
of the plumbing already in place, so I decided to add the relevant logic to
the client git-archive command.

One of the trickier parts of this implementation involved teaching read_tree
about submodules. Some of the troublesome areas were still using the
the_repository references to look up commit or tree or oid information. I
ended up deciding that read_tree_fn_t would probably be best off having a
concrete repo reference since it allows changing the context to a subrepo
where needed (even though some of the usages did not need it specifically).

I am open to feedback since this is all quite new to me :)

Alphadelta14 (1):
  tree: do not use the_repository for tree traversal methods.

Heather Lapointe (8):
  tree: update cases to use repo_ tree methods
  tree: increase test coverage for tree.c
  tree: handle submodule case for read_tree_at properly
  tree: add repository parameter to read_tree_fn_t
  archive: pass repo objects to write_archive handlers
  archive: remove global repository from archive_args
  archive: add --recurse-submodules to git-archive command
  archive: add tests for git archive --recurse-submodules

 Documentation/git-archive.txt     |   6 +-
 Makefile                          |   1 +
 archive-tar.c                     |  15 ++--
 archive-zip.c                     |  15 ++--
 archive.c                         | 138 ++++++++++++++++++++----------
 archive.h                         |  16 +++-
 builtin/checkout.c                |   4 +-
 builtin/log.c                     |   4 +-
 builtin/ls-files.c                |   8 +-
 builtin/ls-tree.c                 |  34 +++++---
 merge-recursive.c                 |   4 +-
 merge.c                           |   4 +-
 reset.c                           |   2 +-
 revision.c                        |   4 +-
 sequencer.c                       |   6 +-
 sparse-index.c                    |   4 +-
 t/helper/test-tool.c              |   1 +
 t/helper/test-tool.h              |   1 +
 t/helper/test-tree-read-tree-at.c |  41 +++++++++
 t/t1023-tree-read-tree-at.sh      |  65 ++++++++++++++
 t/t5005-archive-submodules.sh     |  83 ++++++++++++++++++
 tree.c                            |  93 ++++++++++++++------
 tree.h                            |  16 ++--
 wt-status.c                       |   4 +-
 24 files changed, 448 insertions(+), 121 deletions(-)
 create mode 100644 t/helper/test-tree-read-tree-at.c
 create mode 100755 t/t1023-tree-read-tree-at.sh
 create mode 100755 t/t5005-archive-submodules.sh


base-commit: e85701b4af5b7c2a9f3a1b07858703318dce365d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1359%2FAlphadelta14%2Farchive-recurse-submodules-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1359/Alphadelta14/archive-recurse-submodules-v3
Pull-Request: https://github.com/git/git/pull/1359

Range-diff vs v2:

  -:  ----------- >  1:  79959a54eb4 tree: do not use the_repository for tree traversal methods.
  -:  ----------- >  2:  2291e0f9b5c tree: update cases to use repo_ tree methods
  -:  ----------- >  3:  9a07c6932f4 tree: increase test coverage for tree.c
  2:  68f7830c6d9 !  4:  d3d1738e670 archive: fix a case of submodule in submodule traversal
     @@
       ## Metadata ##
     -Author: Alphadelta14 <alpha@alphaservcomputing.solutions>
     +Author: Heather Lapointe <alpha@alphaservcomputing.solutions>
      
       ## Commit message ##
     -    archive: fix a case of submodule in submodule traversal
     +    tree: handle submodule case for read_tree_at properly
      
     -    repo_submodule_init actually expects the path relative to submodule_prefix.
     -    We preform a simple strip to the correct path.
     +    This supports traversal into an actual submodule for read_tree_at.
     +    The logic is blocked on pathspec->recurse_submodules now,
     +    but previously hadn't been executed due to all fn() cases
     +    returning early for submodules.
      
     -    Signed-off-by: Alphadelta14 <alpha@alphaservcomputing.solutions>
     +    Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
      
       ## tree.c ##
     +@@
     + #include "alloc.h"
     + #include "tree-walk.h"
     + #include "repository.h"
     ++#include "pathspec.h"
     + 
     + const char *tree_type = "tree";
     + 
      @@ tree.c: int read_tree_at(struct repository *r,
     - 			struct repository subrepo;
     - 			struct repository* subrepo_p = &subrepo;
     - 			struct tree* submodule_tree;
     + 			return -1;
     + 		}
     + 
     +-		if (S_ISDIR(entry.mode))
     ++		if (S_ISDIR(entry.mode)) {
     + 			oidcpy(&oid, &entry.oid);
     +-		else if (S_ISGITLINK(entry.mode)) {
     +-			struct commit *commit;
     + 
     +-			commit = lookup_commit(r, &entry.oid);
     ++			len = tree_entry_len(&entry);
     ++			strbuf_add(base, entry.path, len);
     ++			strbuf_addch(base, '/');
     ++			retval = read_tree_at(r, lookup_tree(r, &oid),
     ++						base, pathspec,
     ++						fn, context);
     ++			strbuf_setlen(base, oldlen);
     ++			if (retval)
     ++				return -1;
     ++		} else if (pathspec->recurse_submodules && S_ISGITLINK(entry.mode)) {
     ++			struct commit *commit;
     ++			struct repository subrepo;
     ++			struct repository* subrepo_p = &subrepo;
     ++			struct tree* submodule_tree;
      +			char *submodule_rel_path;
      +			int name_base_len = 0;
     - 
     --			if (repo_submodule_init(subrepo_p, r, entry.path, null_oid()))
     --				die("couldn't init submodule %s%s", base->buf, entry.path);
     ++
      +			len = tree_entry_len(&entry);
      +			strbuf_add(base, entry.path, len);
      +			submodule_rel_path = base->buf;
     @@ tree.c: int read_tree_at(struct repository *r,
      +
      +			if (repo_submodule_init(subrepo_p, r, submodule_rel_path, null_oid()))
      +				die("couldn't init submodule %s", base->buf);
     - 
     - 			if (repo_read_index(subrepo_p) < 0)
     - 				die("index file corrupt");
     - 
     - 			commit = lookup_commit(subrepo_p, &entry.oid);
     ++
     ++			if (repo_read_index(subrepo_p) < 0)
     ++				die("index file corrupt");
     ++
     ++			commit = lookup_commit(subrepo_p, &entry.oid);
       			if (!commit)
      -				die("Commit %s in submodule path %s%s not found",
      +				die("Commit %s in submodule path %s not found",
       				    oid_to_hex(&entry.oid),
      -				    base->buf, entry.path);
     -+				    base->buf);
     - 
     - 			if (repo_parse_commit(subrepo_p, commit))
     +-
     +-			// FIXME: This is the wrong repo instance (it refers to the superproject)
     +-			// it will always fail as is (will fix in later patch)
     +-			// This current codepath isn't executed by any existing callbacks
     +-			// so it wouldn't show up as an issue at this time.
     +-			if (repo_parse_commit(r, commit))
      -				die("Invalid commit %s in submodule path %s%s",
     ++				    base->buf);
     ++
     ++			if (repo_parse_commit(subrepo_p, commit))
      +				die("Invalid commit %s in submodule path %s",
       				    oid_to_hex(&entry.oid),
      -				    base->buf, entry.path);
      +				    base->buf);
       
     - 			submodule_tree = repo_get_commit_tree(subrepo_p, commit);
     - 			oidcpy(&oid, submodule_tree ? &submodule_tree->object.oid : NULL);
     +-			oidcpy(&oid, get_commit_tree_oid(commit));
     +-		}
     +-		else
     +-			continue;
     ++			submodule_tree = repo_get_commit_tree(subrepo_p, commit);
     ++			oidcpy(&oid, submodule_tree ? &submodule_tree->object.oid : NULL);
       
     --			len = tree_entry_len(&entry);
     --			strbuf_add(base, entry.path, len);
     - 			strbuf_addch(base, '/');
     +-		len = tree_entry_len(&entry);
     +-		strbuf_add(base, entry.path, len);
     +-		strbuf_addch(base, '/');
     +-		retval = read_tree_at(r, lookup_tree(r, &oid),
     +-				      base, pathspec,
     +-				      fn, context);
     +-		strbuf_setlen(base, oldlen);
     +-		if (retval)
     +-			return -1;
     ++			strbuf_addch(base, '/');
      +
     - 			retval = read_tree_at(subrepo_p, lookup_tree(subrepo_p, &oid),
     - 						base, pathspec,
     - 						fn, context);
     - 			if (retval) {
     --			    die("failed to read tree for %s%s", base->buf, entry.path);
     ++			retval = read_tree_at(subrepo_p, lookup_tree(subrepo_p, &oid),
     ++						base, pathspec,
     ++						fn, context);
     ++			if (retval)
      +			    die("failed to read tree for %s", base->buf);
     - 			    return -1;
     - 			}
     - 			strbuf_setlen(base, oldlen);
     ++			strbuf_setlen(base, oldlen);
     ++			repo_clear(subrepo_p);
     ++		}
     ++		// else, this is a file (or a submodule, but no pathspec->recurse_submodules)
     + 	}
     + 	return 0;
     + }
  -:  ----------- >  5:  376345fdf66 tree: add repository parameter to read_tree_fn_t
  1:  41664a59029 !  6:  1b9b049d64f archive: add --recurse-submodules to git-archive command
     @@
       ## Metadata ##
     -Author: Alphadelta14 <alpha@alphaservcomputing.solutions>
     +Author: Heather Lapointe <alpha@alphaservcomputing.solutions>
      
       ## Commit message ##
     -    archive: add --recurse-submodules to git-archive command
     +    archive: pass repo objects to write_archive handlers
      
     -    This makes it possible to include submodule contents in an archive command.
     -
     -    This required updating the general read_tree callbacks to support sub-repos
     -    by not using the_repository global references where possible.
     -
     -    archive: update streaming to use target repo
     -    archive: add test cases for git archive --recurse-submodules
     +    Use contextual repos instead of the_repository or args->repo
     +    to ensure that submodules will be handled correctly
     +    since they use multiple repo instances.
      
          Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
      
     @@ archive-tar.c: static unsigned long offset;
       static int tar_umask = 002;
       
       static int write_tar_filter_archive(const struct archiver *ar,
     -+				    struct repository *repo,
     ++					struct repository *repo,
       				    struct archiver_args *args);
       
       /*
     @@ archive-tar.c: static void write_extended_header(struct archiver_args *args,
       }
       
      -static int write_tar_entry(struct archiver_args *args,
     -+static int write_tar_entry(struct repository *repo,
     ++static int write_tar_entry(
     ++			   struct repository *repo,
      +			   struct archiver_args *args,
       			   const struct object_id *oid,
       			   const char *path, size_t pathlen,
     @@ archive-tar.c: static void tgz_write_block(const void *data)
       static const char internal_gzip_command[] = "git archive gzip";
       
       static int write_tar_filter_archive(const struct archiver *ar,
     -+				    struct repository *repo,
     ++					struct repository *repo,
       				    struct archiver_args *args)
       {
       #if ZLIB_VERNUM >= 0x1221
     @@ archive-zip.c: static int entry_is_binary(struct index_state *istate, const char
       #define STREAM_BUFFER_SIZE (1024 * 16)
       
      -static int write_zip_entry(struct archiver_args *args,
     -+static int write_zip_entry(struct repository *repo,
     ++static int write_zip_entry(
     ++			   struct repository *repo,
      +			   struct archiver_args *args,
       			   const struct object_id *oid,
       			   const char *path, size_t pathlen,
     @@ archive-zip.c: static int archive_zip_config(const char *var, const char *value,
       }
       
       static int write_zip_archive(const struct archiver *ar UNUSED,
     -+			     struct repository *repo,
     ++				 struct repository *repo,
       			     struct archiver_args *args)
       {
       	int err;
     @@ archive-zip.c: static int write_zip_archive(const struct archiver *ar UNUSED,
       
      
       ## archive.c ##
     -@@
     - #include "unpack-trees.h"
     - #include "dir.h"
     - #include "quote.h"
     -+#include "submodule.h"
     - 
     - static char const * const archive_usage[] = {
     - 	N_("git archive [<options>] <tree-ish> [<path>...]"),
     -@@ archive.c: static void format_subst(const struct commit *commit,
     - }
     - 
     - static void *object_file_to_archive(const struct archiver_args *args,
     -+				    struct repository *repo,
     - 				    const char *path,
     - 				    const struct object_id *oid,
     - 				    unsigned int mode,
     -@@ archive.c: static void *object_file_to_archive(const struct archiver_args *args,
     - 			       (args->tree ? &args->tree->object.oid : NULL), oid);
     - 
     - 	path += args->baselen;
     --	buffer = read_object_file(oid, type, sizep);
     -+	buffer = repo_read_object_file(repo, oid, type, sizep);
     - 	if (buffer && S_ISREG(mode)) {
     - 		struct strbuf buf = STRBUF_INIT;
     - 		size_t size = 0;
     - 
     - 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
     --		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &buf, &meta);
     -+		convert_to_working_tree(repo->index, path, buf.buf, buf.len, &buf, &meta);
     - 		if (commit)
     - 			format_subst(commit, buf.buf, buf.len, &buf, args->pretty_ctx);
     - 		buffer = strbuf_detach(&buf, &size);
      @@ archive.c: static int check_attr_export_subst(const struct attr_check *check)
       	return check && ATTR_TRUE(check->items[1].value);
       }
       
      -static int write_archive_entry(const struct object_id *oid, const char *base,
     -+static int write_archive_entry(struct repository *repo, const struct object_id *oid, const char *base,
     ++static int write_archive_entry(
     ++		struct repository *repo,
     ++		const struct object_id *oid, const char *base,
       		int baselen, const char *filename, unsigned mode,
       		void *context)
       {
     @@ archive.c: static int write_archive_entry(const struct object_id *oid, const cha
      +		err = write_entry(repo, args, oid, path.buf, path.len, mode, NULL, 0);
       		if (err)
       			return err;
     --		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
     -+		return READ_TREE_RECURSIVE;
     - 	}
     - 
     - 	if (args->verbose)
     + 		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
      @@ archive.c: static int write_archive_entry(const struct object_id *oid, const char *base,
       
       	/* Stream it? */
       	if (S_ISREG(mode) && !args->convert &&
      -	    oid_object_info(args->repo, oid, &size) == OBJ_BLOB &&
     --	    size > big_file_threshold)
     --		return write_entry(args, oid, path.buf, path.len, mode, NULL, size);
      +	    oid_object_info(repo, oid, &size) == OBJ_BLOB &&
     -+	    size > big_file_threshold) {
     -+			err = write_entry(repo, args, oid, path.buf, path.len, mode, NULL, size);
     -+			if (err) {
     -+				die("Failed to write file %.*s", (int)path.len, path.buf);
     -+			}
     -+			return err;
     -+		}
     + 	    size > big_file_threshold)
     +-		return write_entry(args, oid, path.buf, path.len, mode, NULL, size);
     ++		return write_entry(repo, args, oid, path.buf, path.len, mode, NULL, size);
       
     --	buffer = object_file_to_archive(args, path.buf, oid, mode, &type, &size);
     -+	buffer = object_file_to_archive(args, repo, path.buf, oid, mode, &type, &size);
     + 	buffer = object_file_to_archive(args, path.buf, oid, mode, &type, &size);
       	if (!buffer)
       		return error(_("cannot read '%s'"), oid_to_hex(oid));
      -	err = write_entry(args, oid, path.buf, path.len, mode, buffer, size);
     @@ archive.c: static void queue_directory(const struct object_id *oid,
       }
       
      -static int write_directory(struct archiver_context *c)
     -+static void queue_submodule(struct repository *superproject,
     -+		const struct object_id *oid,
     -+		struct strbuf *base, const char *filename,
     -+		unsigned mode, struct archiver_context *c)
     -+{
     -+	struct repository subrepo;
     -+
     -+	if (repo_submodule_init(&subrepo, superproject, filename, null_oid()))
     -+		return;
     -+
     -+	if (repo_read_index(&subrepo) < 0)
     -+		die("index file corrupt");
     -+
     -+    queue_directory(oid, base, filename, mode, c);
     -+
     -+	repo_clear(&subrepo);
     -+}
     -+
     -+static int write_directory(struct repository *repo, struct archiver_context *c)
     ++static int write_directory(
     ++		struct repository *repo,
     ++		struct archiver_context *c)
       {
       	struct directory *d = c->bottom;
       	int ret;
     @@ archive.c: static int write_directory(struct archiver_context *c)
      +		write_directory(repo, c) ||
      +		write_archive_entry(repo, &d->oid, d->path, d->baselen,
       				    d->path + d->baselen, d->mode,
     --				    c) != READ_TREE_RECURSIVE;
     -+				    c);
     + 				    c) != READ_TREE_RECURSIVE;
       	free(d);
     --	return ret ? -1 : 0;
     -+	if (ret == READ_TREE_RECURSIVE)
     -+		return 0;
     -+	return ret;
     - }
     - 
     --static int queue_or_write_archive_entry(const struct object_id *oid,
     -+static int queue_or_write_archive_entry(
     -+		struct repository *repo, const struct object_id *oid,
     - 		struct strbuf *base, const char *filename,
     - 		unsigned mode, void *context)
     - {
     -@@ archive.c: static int queue_or_write_archive_entry(const struct object_id *oid,
     - 		/* Borrow base, but restore its original value when done. */
     - 		strbuf_addstr(base, filename);
     - 		strbuf_addch(base, '/');
     --		check = get_archive_attrs(c->args->repo->index, base->buf);
     -+		check = get_archive_attrs(repo->index, base->buf);
     - 		strbuf_setlen(base, baselen);
     - 
     - 		if (check_attr_export_ignore(check))
     - 			return 0;
     - 		queue_directory(oid, base, filename, mode, c);
     +@@ archive.c: static int queue_or_write_archive_entry(
       		return READ_TREE_RECURSIVE;
     -+	} else if (c->args->recurse_submodules && S_ISGITLINK(mode)) {
     -+		if (is_submodule_active(repo, filename)) {
     -+			queue_submodule(repo, oid, base, filename, mode, c);
     -+			return READ_TREE_RECURSIVE;
     -+		}
       	}
       
      -	if (write_directory(c))
     -+	if (write_directory(repo, c))
     ++	if (write_directory(r, c))
       		return -1;
      -	return write_archive_entry(oid, base->buf, base->len, filename, mode,
     -+	return write_archive_entry(repo, oid, base->buf, base->len, filename, mode,
     ++	return write_archive_entry(r, oid, base->buf, base->len, filename, mode,
       				   context);
       }
       
     @@ archive.c: struct extra_file_info {
       };
       
      -int write_archive_entries(struct archiver_args *args,
     -+int write_archive_entries(struct repository *repo,
     ++int write_archive_entries(
     ++		struct repository *repo,
      +		struct archiver_args *args,
       		write_archive_entry_fn_t write_entry)
       {
     @@ archive.c: int write_archive_entries(struct archiver_args *args,
       				  len, 040777, NULL, 0);
       		if (err)
       			return err;
     -@@ archive.c: int write_archive_entries(struct archiver_args *args,
     - 		memset(&opts, 0, sizeof(opts));
     - 		opts.index_only = 1;
     - 		opts.head_idx = -1;
     --		opts.src_index = args->repo->index;
     --		opts.dst_index = args->repo->index;
     -+		opts.src_index = repo->index;
     -+		opts.dst_index = repo->index;
     - 		opts.fn = oneway_merge;
     - 		init_tree_desc(&t, args->tree->buffer, args->tree->size);
     - 		if (unpack_trees(1, &t, &opts))
     -@@ archive.c: int write_archive_entries(struct archiver_args *args,
     - 		git_attr_set_direction(GIT_ATTR_INDEX);
     - 	}
     - 
     --	err = read_tree(args->repo, args->tree,
     -+	err = read_tree(repo, args->tree,
     - 			&args->pathspec,
     - 			queue_or_write_archive_entry,
     - 			&context);
      @@ archive.c: int write_archive_entries(struct archiver_args *args,
       			if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
       				err = error_errno(_("cannot read '%s'"), path);
     @@ archive.c: int write_archive_entries(struct archiver_args *args,
       					  path, strlen(path),
       					  canon_mode(info->stat.st_mode),
       					  info->content, info->stat.st_size);
     -@@ archive.c: struct path_exists_context {
     - 	struct archiver_args *args;
     - };
     - 
     --static int reject_entry(const struct object_id *oid UNUSED,
     -+static int reject_entry(struct repository *repo, const struct object_id *oid UNUSED,
     - 			struct strbuf *base,
     - 			const char *filename, unsigned mode,
     - 			void *context)
     -@@ archive.c: static int reject_entry(const struct object_id *oid UNUSED,
     - 		struct strbuf sb = STRBUF_INIT;
     - 		strbuf_addbuf(&sb, base);
     - 		strbuf_addstr(&sb, filename);
     --		if (!match_pathspec(ctx->args->repo->index,
     -+		if (!match_pathspec(repo->index,
     - 				    &ctx->pathspec,
     - 				    sb.buf, sb.len, 0, NULL, 1))
     - 			ret = READ_TREE_RECURSIVE;
     -@@ archive.c: static void parse_pathspec_arg(const char **pathspec,
     - 		       PATHSPEC_PREFER_FULL,
     - 		       "", pathspec);
     - 	ar_args->pathspec.recursive = 1;
     -+	ar_args->pathspec.recurse_submodules = ar_args->recurse_submodules;
     - 	if (pathspec) {
     - 		while (*pathspec) {
     - 			if (**pathspec && !path_exists(ar_args, *pathspec))
     -@@ archive.c: static int parse_archive_args(int argc, const char **argv,
     - 	int verbose = 0;
     - 	int i;
     - 	int list = 0;
     -+	int recurse_submodules = 0;
     - 	int worktree_attributes = 0;
     - 	struct option opts[] = {
     - 		OPT_GROUP(""),
     -@@ archive.c: static int parse_archive_args(int argc, const char **argv,
     - 		  add_file_cb, (intptr_t)&base },
     - 		OPT_STRING('o', "output", &output, N_("file"),
     - 			N_("write the archive to this file")),
     -+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
     -+			N_("include submodules in archive")),
     - 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
     - 			N_("read .gitattributes in working directory")),
     - 		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
     -@@ archive.c: static int parse_archive_args(int argc, const char **argv,
     - 	args->base = base;
     - 	args->baselen = strlen(base);
     - 	args->worktree_attributes = worktree_attributes;
     -+	args->recurse_submodules = recurse_submodules;
     - 
     - 	return argc;
     - }
      @@ archive.c: int write_archive(int argc, const char **argv, const char *prefix,
       	parse_treeish_arg(argv, &args, prefix, remote);
       	parse_pathspec_arg(argv + 1, &args);
     @@ archive.c: int write_archive(int argc, const char **argv, const char *prefix,
       	free(args.refname);
      
       ## archive.h ##
     -@@ archive.h: struct archiver_args {
     - 	timestamp_t time;
     - 	struct pathspec pathspec;
     - 	unsigned int verbose : 1;
     -+	unsigned int recurse_submodules : 1;
     - 	unsigned int worktree_attributes : 1;
     - 	unsigned int convert : 1;
     - 	int compression_level;
      @@ archive.h: const char *archive_format_from_filename(const char *filename);
       #define ARCHIVER_HIGH_COMPRESSION_LEVELS 4
       struct archiver {
       	const char *name;
      -	int (*write_archive)(const struct archiver *, struct archiver_args *);
     -+	int (*write_archive)(const struct archiver *, struct repository *repo, struct archiver_args *);
     ++	int (*write_archive)(
     ++		const struct archiver *,
     ++		struct repository *,
     ++		struct archiver_args *);
       	unsigned flags;
       	char *filter_command;
       };
     @@ archive.h: void init_tar_archiver(void);
       void init_archivers(void);
       
      -typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
     -+typedef int (*write_archive_entry_fn_t)(struct repository *repo,
     ++typedef int (*write_archive_entry_fn_t)(
     ++					struct repository *repo,
      +					struct archiver_args *args,
       					const struct object_id *oid,
       					const char *path, size_t pathlen,
     @@ archive.h: void init_tar_archiver(void);
       					void *buffer, unsigned long size);
       
      -int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
     -+int write_archive_entries(struct repository *repo, struct archiver_args *args, write_archive_entry_fn_t write_entry);
     ++int write_archive_entries(
     ++	struct repository *repo,
     ++	struct archiver_args *args,
     ++	write_archive_entry_fn_t write_entry);
       
       #endif	/* ARCHIVE_H */
     -
     - ## builtin/checkout.c ##
     -@@ builtin/checkout.c: static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
     - 
     - }
     - 
     --static int update_some(const struct object_id *oid, struct strbuf *base,
     -+static int update_some(struct repository *repo UNUSED, const struct object_id *oid, struct strbuf *base,
     - 		       const char *pathname, unsigned mode, void *context UNUSED)
     - {
     - 	int len;
     -
     - ## builtin/log.c ##
     -@@ builtin/log.c: static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
     - 	return 0;
     - }
     - 
     --static int show_tree_object(const struct object_id *oid UNUSED,
     -+static int show_tree_object(struct repository *repo UNUSED, const struct object_id *oid UNUSED,
     - 			    struct strbuf *base UNUSED,
     - 			    const char *pathname, unsigned mode,
     - 			    void *context)
     -
     - ## builtin/ls-files.c ##
     -@@ builtin/ls-files.c: static int get_common_prefix_len(const char *common_prefix)
     - 	return common_prefix_len;
     - }
     - 
     --static int read_one_entry_opt(struct index_state *istate,
     -+static int read_one_entry_opt(struct repository *repo UNUSED, struct index_state *istate,
     - 			      const struct object_id *oid,
     - 			      struct strbuf *base,
     - 			      const char *pathname,
     -@@ builtin/ls-files.c: static int read_one_entry_opt(struct index_state *istate,
     - 	return add_index_entry(istate, ce, opt);
     - }
     - 
     --static int read_one_entry(const struct object_id *oid, struct strbuf *base,
     -+static int read_one_entry(struct repository *repo, const struct object_id *oid, struct strbuf *base,
     - 			  const char *pathname, unsigned mode,
     - 			  void *context)
     - {
     - 	struct index_state *istate = context;
     --	return read_one_entry_opt(istate, oid, base, pathname,
     -+	return read_one_entry_opt(repo, istate, oid, base, pathname,
     - 				  mode,
     - 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
     - }
     -@@ builtin/ls-files.c: static int read_one_entry(const struct object_id *oid, struct strbuf *base,
     -  * This is used when the caller knows there is no existing entries at
     -  * the stage that will conflict with the entry being added.
     -  */
     --static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base,
     -+static int read_one_entry_quick(struct repository *repo, const struct object_id *oid, struct strbuf *base,
     - 				const char *pathname, unsigned mode,
     - 				void *context)
     - {
     - 	struct index_state *istate = context;
     --	return read_one_entry_opt(istate, oid, base, pathname,
     -+	return read_one_entry_opt(repo, istate, oid, base, pathname,
     - 				  mode, ADD_CACHE_JUST_APPEND);
     - }
     - 
     -
     - ## builtin/ls-tree.c ##
     -@@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, const char *pathname
     - 	return 0;
     - }
     - 
     --static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
     -+static int show_tree_fmt(struct repository *repo UNUSED, const struct object_id *oid, struct strbuf *base,
     - 			 const char *pathname, unsigned mode, void *context UNUSED)
     - {
     - 	size_t baselen;
     -@@ builtin/ls-tree.c: static void show_tree_common_default_long(struct strbuf *base,
     - 	strbuf_setlen(base, baselen);
     - }
     - 
     --static int show_tree_default(const struct object_id *oid, struct strbuf *base,
     -+static int show_tree_default(struct repository *repo UNUSED, const struct object_id *oid, struct strbuf *base,
     - 			     const char *pathname, unsigned mode,
     - 			     void *context UNUSED)
     - {
     -@@ builtin/ls-tree.c: static int show_tree_default(const struct object_id *oid, struct strbuf *base,
     - 	return recurse;
     - }
     - 
     --static int show_tree_long(const struct object_id *oid, struct strbuf *base,
     -+static int show_tree_long(struct repository *repo, const struct object_id *oid, struct strbuf *base,
     - 			  const char *pathname, unsigned mode,
     - 			  void *context UNUSED)
     - {
     -@@ builtin/ls-tree.c: static int show_tree_long(const struct object_id *oid, struct strbuf *base,
     - 
     - 	if (data.type == OBJ_BLOB) {
     - 		unsigned long size;
     --		if (oid_object_info(the_repository, data.oid, &size) == OBJ_BAD)
     -+		if (oid_object_info(repo, data.oid, &size) == OBJ_BAD)
     - 			xsnprintf(size_text, sizeof(size_text), "BAD");
     - 		else
     - 			xsnprintf(size_text, sizeof(size_text),
     -@@ builtin/ls-tree.c: static int show_tree_long(const struct object_id *oid, struct strbuf *base,
     - 	}
     - 
     - 	printf("%06o %s %s %7s\t", data.mode, type_name(data.type),
     --	       find_unique_abbrev(data.oid, abbrev), size_text);
     -+	       repo_find_unique_abbrev(repo, data.oid, abbrev), size_text);
     - 	show_tree_common_default_long(base, pathname, data.base->len);
     - 	return recurse;
     - }
     - 
     --static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
     -+static int show_tree_name_only(struct repository *repo UNUSED, const struct object_id *oid, struct strbuf *base,
     - 			       const char *pathname, unsigned mode,
     - 			       void *context UNUSED)
     - {
     -@@ builtin/ls-tree.c: static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
     - 	return recurse;
     - }
     - 
     --static int show_tree_object(const struct object_id *oid, struct strbuf *base,
     -+static int show_tree_object(struct repository *repo, const struct object_id *oid, struct strbuf *base,
     - 			    const char *pathname, unsigned mode,
     - 			    void *context UNUSED)
     - {
     -@@ builtin/ls-tree.c: static int show_tree_object(const struct object_id *oid, struct strbuf *base,
     - 	if (early >= 0)
     - 		return early;
     - 
     --	printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
     -+	printf("%s%c", repo_find_unique_abbrev(repo, oid, abbrev), line_termination);
     - 	return recurse;
     - }
     - 
     -
     - ## list-objects.c ##
     -@@ list-objects.c: static void process_tree(struct traversal_context *ctx,
     - 	    !revs->include_check_obj(&tree->object, revs->include_check_data))
     - 		return;
     - 
     --	failed_parse = parse_tree_gently(tree, 1);
     -+	failed_parse = parse_tree_gently(revs->repo, tree, 1);
     - 	if (failed_parse) {
     - 		if (revs->ignore_missing_links)
     - 			return;
     -
     - ## merge-recursive.c ##
     -@@ merge-recursive.c: static void unpack_trees_finish(struct merge_options *opt)
     - 	clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
     - }
     - 
     --static int save_files_dirs(const struct object_id *oid UNUSED,
     -+static int save_files_dirs(struct repository *repo UNUSED, const struct object_id *oid UNUSED,
     - 			   struct strbuf *base, const char *path,
     - 			   unsigned int mode, void *context)
     - {
     -
     - ## revision.c ##
     -@@ revision.c: static void mark_tree_contents_uninteresting(struct repository *r,
     - 	struct tree_desc desc;
     - 	struct name_entry entry;
     - 
     --	if (parse_tree_gently(tree, 1) < 0)
     -+	if (parse_tree_gently(r, tree, 1) < 0)
     - 		return;
     - 
     - 	init_tree_desc(&desc, tree->buffer, tree->size);
     -@@ revision.c: static void add_children_by_path(struct repository *r,
     - 	if (!tree)
     - 		return;
     - 
     --	if (parse_tree_gently(tree, 1) < 0)
     -+	if (parse_tree_gently(r, tree, 1) < 0)
     - 		return;
     - 
     - 	init_tree_desc(&desc, tree->buffer, tree->size);
     -
     - ## sparse-index.c ##
     -@@ sparse-index.c: static void set_index_entry(struct index_state *istate, int nr, struct cache_ent
     - 	add_name_hash(istate, ce);
     - }
     - 
     --static int add_path_to_index(const struct object_id *oid,
     -+static int add_path_to_index(struct repository *repo UNUSED, const struct object_id *oid,
     - 			     struct strbuf *base, const char *path,
     - 			     unsigned int mode, void *context)
     - {
     -
     - ## t/t5005-archive-submodules.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='git archive --recurse-submodules test'
     -+
     -+. ./test-lib.sh
     -+. "$TEST_DIRECTORY"/lib-submodule-update.sh
     -+
     -+test_expect_success 'setup' '
     -+	create_lib_submodule_repo &&
     -+	git -C submodule_update_repo checkout valid_sub1 &&
     -+	git -C submodule_update_repo submodule update
     -+'
     -+
     -+check_tar() {
     -+	tarfile=$1.tar
     -+	listfile=$1.lst
     -+	dir=$1
     -+	dir_with_prefix=$dir/$2
     -+
     -+	test_expect_success ' extract tar archive' '
     -+		(mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile
     -+	'
     -+}
     -+
     -+check_added() {
     -+	dir=$1
     -+	path_in_fs=$2
     -+	path_in_archive=$3
     -+
     -+	test_expect_success " validate extra file $path_in_archive" '
     -+		test -f $dir/$path_in_archive &&
     -+		diff -r $path_in_fs $dir/$path_in_archive
     -+	'
     -+}
     -+
     -+check_not_added() {
     -+	dir=$1
     -+	path_in_archive=$2
     -+
     -+	test_expect_success " validate unpresent file $path_in_archive" '
     -+		! test -f $dir/$path_in_archive &&
     -+		! test -d $dir/$path_in_archive
     -+	'
     -+}
     -+
     -+test_expect_success 'archive without recurse, non-init' '
     -+	reset_work_tree_to valid_sub1 &&
     -+	git -C submodule_update archive HEAD >b.tar
     -+'
     -+
     -+check_tar b
     -+check_added b submodule_update/file1 file1
     -+check_not_added b sub1/file1
     -+
     -+test_expect_success 'archive with recurse, non-init' '
     -+	reset_work_tree_to valid_sub1 &&
     -+	! git -C submodule_update archive --recurse-submodules HEAD >b2-err.tar
     -+'
     -+
     -+test_expect_success 'archive with recurse, init' '
     -+	reset_work_tree_to valid_sub1 &&
     -+	git -C submodule_update submodule update --init &&
     -+	git -C submodule_update ls-files --recurse-submodules &&
     -+	git -C submodule_update ls-tree HEAD &&
     -+	git -C submodule_update archive --recurse-submodules HEAD >b2.tar
     -+'
     -+
     -+check_tar b2
     -+check_added b2 submodule_update/sub1/file1 sub1/file1
     -+
     -+test_expect_success 'archive with recurse with big files' '
     -+	reset_work_tree_to valid_sub1 &&
     -+	test_config core.bigfilethreshold 1 &&
     -+	git -C submodule_update submodule update --init &&
     -+	git -C submodule_update ls-files --recurse-submodules &&
     -+	git -C submodule_update ls-tree HEAD &&
     -+	git -C submodule_update archive --recurse-submodules HEAD >b3.tar
     -+'
     -+
     -+check_tar b3
     -+check_added b3 submodule_update/sub1/file1 sub1/file1
     -+
     -+
     -+test_done
     -
     - ## tree.c ##
     -@@
     - #include "alloc.h"
     - #include "tree-walk.h"
     - #include "repository.h"
     -+#include "pathspec.h"
     - 
     - const char *tree_type = "tree";
     - 
     -@@ tree.c: int read_tree_at(struct repository *r,
     - 	int len, oldlen = base->len;
     - 	enum interesting retval = entry_not_interesting;
     - 
     --	if (parse_tree(tree))
     --		return -1;
     -+	if (repo_parse_tree(r, tree))
     -+		die("Failed to parse tree");
     - 
     - 	init_tree_desc(&desc, tree->buffer, tree->size);
     - 
     -@@ tree.c: int read_tree_at(struct repository *r,
     - 				continue;
     - 		}
     - 
     --		switch (fn(&entry.oid, base,
     -+		switch (fn(r, &entry.oid, base,
     - 			   entry.path, entry.mode, context)) {
     - 		case 0:
     - 			continue;
     -@@ tree.c: int read_tree_at(struct repository *r,
     - 			return -1;
     - 		}
     - 
     --		if (S_ISDIR(entry.mode))
     -+		if (S_ISDIR(entry.mode)) {
     - 			oidcpy(&oid, &entry.oid);
     --		else if (S_ISGITLINK(entry.mode)) {
     -+			len = tree_entry_len(&entry);
     -+			strbuf_add(base, entry.path, len);
     -+			strbuf_addch(base, '/');
     -+			retval = read_tree_at(r, lookup_tree(r, &oid),
     -+						base, pathspec,
     -+						fn, context);
     -+			strbuf_setlen(base, oldlen);
     -+			if (retval)
     -+				return -1;
     -+		} else if (pathspec->recurse_submodules && S_ISGITLINK(entry.mode)) {
     - 			struct commit *commit;
     -+			struct repository subrepo;
     -+			struct repository* subrepo_p = &subrepo;
     -+			struct tree* submodule_tree;
     - 
     --			commit = lookup_commit(r, &entry.oid);
     -+			if (repo_submodule_init(subrepo_p, r, entry.path, null_oid()))
     -+				die("couldn't init submodule %s%s", base->buf, entry.path);
     -+
     -+			if (repo_read_index(subrepo_p) < 0)
     -+				die("index file corrupt");
     -+
     -+			commit = lookup_commit(subrepo_p, &entry.oid);
     - 			if (!commit)
     - 				die("Commit %s in submodule path %s%s not found",
     - 				    oid_to_hex(&entry.oid),
     - 				    base->buf, entry.path);
     - 
     --			if (parse_commit(commit))
     -+			if (repo_parse_commit(subrepo_p, commit))
     - 				die("Invalid commit %s in submodule path %s%s",
     - 				    oid_to_hex(&entry.oid),
     - 				    base->buf, entry.path);
     - 
     --			oidcpy(&oid, get_commit_tree_oid(commit));
     -+			submodule_tree = repo_get_commit_tree(subrepo_p, commit);
     -+			oidcpy(&oid, submodule_tree ? &submodule_tree->object.oid : NULL);
     -+
     -+			len = tree_entry_len(&entry);
     -+			strbuf_add(base, entry.path, len);
     -+			strbuf_addch(base, '/');
     -+			retval = read_tree_at(subrepo_p, lookup_tree(subrepo_p, &oid),
     -+						base, pathspec,
     -+						fn, context);
     -+			if (retval) {
     -+			    die("failed to read tree for %s%s", base->buf, entry.path);
     -+			    return -1;
     -+			}
     -+			strbuf_setlen(base, oldlen);
     -+			repo_clear(subrepo_p);
     - 		}
     --		else
     --			continue;
     - 
     --		len = tree_entry_len(&entry);
     --		strbuf_add(base, entry.path, len);
     --		strbuf_addch(base, '/');
     --		retval = read_tree_at(r, lookup_tree(r, &oid),
     --				      base, pathspec,
     --				      fn, context);
     --		strbuf_setlen(base, oldlen);
     --		if (retval)
     --			return -1;
     - 	}
     - 	return 0;
     - }
     -@@ tree.c: int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
     - 	return 0;
     - }
     - 
     --int parse_tree_gently(struct tree *item, int quiet_on_missing)
     -+int parse_tree_gently(struct repository *r, struct tree *item, int quiet_on_missing)
     - {
     - 	 enum object_type type;
     - 	 void *buffer;
     -@@ tree.c: int parse_tree_gently(struct tree *item, int quiet_on_missing)
     - 
     - 	if (item->object.parsed)
     - 		return 0;
     --	buffer = read_object_file(&item->object.oid, &type, &size);
     -+	buffer = repo_read_object_file(r, &item->object.oid, &type, &size);
     - 	if (!buffer)
     - 		return quiet_on_missing ? -1 :
     - 			error("Could not read %s",
     -
     - ## tree.h ##
     -@@ tree.h: struct tree *lookup_tree(struct repository *r, const struct object_id *oid);
     - 
     - int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
     - 
     --int parse_tree_gently(struct tree *tree, int quiet_on_missing);
     --static inline int parse_tree(struct tree *tree)
     -+int parse_tree_gently(struct repository *r, struct tree *tree, int quiet_on_missing);
     -+static inline int repo_parse_tree(struct repository *r, struct tree *tree)
     - {
     --	return parse_tree_gently(tree, 0);
     -+	return parse_tree_gently(r, tree, 0);
     - }
     -+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
     -+#define parse_tree(tree) repo_parse_tree(the_repository, tree)
     -+#endif
     - void free_tree_buffer(struct tree *tree);
     - 
     - /* Parses and returns the tree in the given ent, chasing tags and commits. */
     -@@ tree.h: struct tree *parse_tree_indirect(const struct object_id *oid);
     - int cmp_cache_name_compare(const void *a_, const void *b_);
     - 
     - #define READ_TREE_RECURSIVE 1
     --typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
     -+typedef int (*read_tree_fn_t)(struct repository *, const struct object_id *, struct strbuf *, const char *, unsigned int, void *);
     - 
     - int read_tree_at(struct repository *r,
     - 		 struct tree *tree, struct strbuf *base,
     -
     - ## wt-status.c ##
     -@@ wt-status.c: static void wt_status_collect_changes_index(struct wt_status *s)
     - 	release_revisions(&rev);
     - }
     - 
     --static int add_file_to_list(const struct object_id *oid,
     -+static int add_file_to_list(struct repository *repo UNUSED, const struct object_id *oid,
     - 			    struct strbuf *base, const char *path,
     - 			    unsigned int mode, void *context)
     - {
  -:  ----------- >  7:  2443c9b1b6e archive: remove global repository from archive_args
  -:  ----------- >  8:  4672e3d9586 archive: add --recurse-submodules to git-archive command
  -:  ----------- >  9:  f88ebbaf17c archive: add tests for git archive --recurse-submodules

-- 
gitgitgadget

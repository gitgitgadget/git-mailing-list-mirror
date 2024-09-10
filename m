Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E421A76DF
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001975; cv=none; b=EkvZ0x17ayT2KRogjC13drdcuySwIm5t/UySJ52/S3tyi3RGvLAhNUs83JFR6nwQuXNxpLsI+riSngOEhC1mHqakQ2vTLoggrtuf+MdpPFIR+9IJOUL+I6XbEIfcGhmcqCctS2bioUdvncu9gPTVQ/+4pXmz0S4Is1CXeaT3pzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001975; c=relaxed/simple;
	bh=66ECLxFl+Bf3WjdhJBtQWR8OJKvopqSXGUfhvgHZM+0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RDwkV2flLNUoPIvqkC0sTJHB3OYTm7O5QQk0S6WpbgO4c1iWrDGQu0WAU62m+XebpHjpgo3O7hyfB/wru8L11TWzyukFCYZvJrrbdv/5dBmZpUvqfBDAzMGmpGRGkllSj6ryNePlPnqN+2JPDv+YGJGwwTHL7cFO+SqJZaNKPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrLx1W67; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrLx1W67"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d60e23b33so332672066b.0
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726001968; x=1726606768; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4UcDWHmsJ6hl+56cepiqfFUYb3xapklmPe7Oijb8co=;
        b=TrLx1W67sRvFDgO4S8S4n/kHs8gXDWhXZ29qS4fVvn7YjScfO2ThEDLYdMdJKnbjqb
         Qi8/a8NEjhinEHJ6A8mjoMIXdVbC9GTyGPEn9e940NEDQ8w8SHtch67e50GFnd1jo9SE
         bVWQHorv/ZqOLf7BG4VBnHhc28Wu0femfBZjLqK79fkTPYGDqkLdidorxWxUIiz+eASe
         Ovos9n9VSGOpvI9YBOFsANwqRXxFU9VkmmRgjeffapFIf0/IGRRRYvSDKLpbb3TnX7C8
         +9+c5gGTXSLYPGOHqjPYVTQGySkSE3rRaOE61HJnnZyvWrDtbcbT/fylU5gBx5SgiX4/
         OVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726001968; x=1726606768;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4UcDWHmsJ6hl+56cepiqfFUYb3xapklmPe7Oijb8co=;
        b=k01xBCv/qtD9lZBooIdD9V8IK8MAdFUARcxZb/qXiBQ/7j9KCG8q28MDE1NOi6hAZj
         19NaeKGz/yNa6xAZbDPhKwrSD84bH60CQ/9IaZwVz7e+7sAtUPzn/SNT0LLL16ZaOB2R
         E4dmbYhukzwF9xf8UpkZbFzQ0NwdjHxGkI+PvmOkGrdKPOWEy+xfWEOf12mRVgHvr5Df
         PeZ/zOiCnEDGnvoDE6XNFq1F0ixXBP24bwKWzUSzdauUtTNTkYnig7SD4m7vYr2sseIi
         D5xBXcP4mlj4Afnee9cSx/tPH3gVSOa1c5Ug73RHL0iN8vvLT87RIVnCBXOJUMpNJ8mr
         Vr9g==
X-Gm-Message-State: AOJu0YzV9at7wKpBSXIzzQa28NcwVGr+722j9URKpfT0Nrk7ZhVqPDRl
	IQQLq9QdzegFIpyn1UY54bNoLfkaEf2qGdMVTplEQIrNH+d+d4K8uStJNw==
X-Google-Smtp-Source: AGHT+IEmCWIdXpCt7tOJm6NchpOxHlriNPiuWrMVPmTIiWWj8qtqKM6eej0uDDUr5onnml6UFKhpuQ==
X-Received: by 2002:a17:907:97ce:b0:a7a:a138:dbc1 with SMTP id a640c23a62f3a-a8ffab186e2mr170389666b.20.1726001966267;
        Tue, 10 Sep 2024 13:59:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d29399sm524075066b.185.2024.09.10.13.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 13:59:25 -0700 (PDT)
Message-Id: <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
In-Reply-To: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 20:59:17 +0000
Subject: [PATCH v2 0/3] Add repository parameter to builtins
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>

As part of the effort to remove global state of the_repository, add a
repository parameter to builtins so that a repository variable can be passed
down. The patches are ordered as follows:

 1. Changes the signature of builtins and passes the_repository down in
    git.c to be called by all builtins.
 2. Remove USE_THE_REPOSITORY_VARIABLE from builtin.h, and instead add it to
    each individual builtin. This paves the way for a migration process
    whereby each builtin can be migrated away from using the_repository.
 3. As an example, migrate builtin/add.c to get rid of the_repository by
    instead passing the repository argument down into helper functions.

Changes since V1:

 * Removed USE_THE_REPOSITORY_VARIABLE from add.c
 * removed changes that conflict with existing topics in seen
 * Fixed overly long lines formatting issues

John Cai (3):
  builtin: add a repository parameter for builtin functions
  builtin: remove USE_THE_REPOSITORY_VARIABLE from builtin.h
  add: pass in repo variable instead of global the_repository

 builtin.h                          | 285 ++++++++++++++---------------
 builtin/add.c                      | 119 ++++++------
 builtin/am.c                       |   7 +-
 builtin/annotate.c                 |   9 +-
 builtin/apply.c                    |   7 +-
 builtin/archive.c                  |   7 +-
 builtin/bisect.c                   |   6 +-
 builtin/blame.c                    |   8 +-
 builtin/branch.c                   |   7 +-
 builtin/bugreport.c                |   6 +-
 builtin/bundle.c                   |   7 +-
 builtin/cat-file.c                 |   9 +-
 builtin/check-attr.c               |   7 +-
 builtin/check-ignore.c             |   7 +-
 builtin/check-mailmap.c            |   6 +-
 builtin/check-ref-format.c         |   5 +-
 builtin/checkout--worker.c         |   6 +-
 builtin/checkout-index.c           |   8 +-
 builtin/checkout.c                 |  16 +-
 builtin/clean.c                    |   8 +-
 builtin/clone.c                    |   8 +-
 builtin/column.c                   |   6 +-
 builtin/commit-graph.c             |   7 +-
 builtin/commit-tree.c              |   8 +-
 builtin/commit.c                   |  14 +-
 builtin/config.c                   |   7 +-
 builtin/count-objects.c            |   8 +-
 builtin/credential-cache--daemon.c |  11 +-
 builtin/credential-cache.c         |   5 +-
 builtin/credential-store.c         |   6 +-
 builtin/credential.c               |   7 +-
 builtin/describe.c                 |   8 +-
 builtin/diagnose.c                 |   5 +-
 builtin/diff-files.c               |   7 +-
 builtin/diff-index.c               |   7 +-
 builtin/diff-tree.c                |   7 +-
 builtin/diff.c                     |   7 +-
 builtin/difftool.c                 |   8 +-
 builtin/fast-export.c              |   6 +-
 builtin/fast-import.c              |   7 +-
 builtin/fetch-pack.c               |   6 +-
 builtin/fetch.c                    |   7 +-
 builtin/fmt-merge-msg.c            |   6 +-
 builtin/for-each-ref.c             |   6 +-
 builtin/for-each-repo.c            |   7 +-
 builtin/fsck.c                     |   7 +-
 builtin/fsmonitor--daemon.c        |  10 +-
 builtin/gc.c                       |  13 +-
 builtin/get-tar-commit-id.c        |   5 +-
 builtin/grep.c                     |   7 +-
 builtin/hash-object.c              |   6 +-
 builtin/help.c                     |   7 +-
 builtin/hook.c                     |   6 +-
 builtin/index-pack.c               |   6 +-
 builtin/init-db.c                  |   7 +-
 builtin/interpret-trailers.c       |   7 +-
 builtin/log.c                      |  33 +++-
 builtin/ls-files.c                 |   7 +-
 builtin/ls-remote.c                |   6 +-
 builtin/ls-tree.c                  |   7 +-
 builtin/mailinfo.c                 |   6 +-
 builtin/mailsplit.c                |   5 +-
 builtin/merge-base.c               |   7 +-
 builtin/merge-file.c               |   6 +-
 builtin/merge-index.c              |   7 +-
 builtin/merge-ours.c               |   8 +-
 builtin/merge-recursive.c          |   7 +-
 builtin/merge-tree.c               |   7 +-
 builtin/merge.c                    |  12 +-
 builtin/mktag.c                    |   6 +-
 builtin/mktree.c                   |   7 +-
 builtin/multi-pack-index.c         |   7 +-
 builtin/mv.c                       |   8 +-
 builtin/name-rev.c                 |   7 +-
 builtin/notes.c                    |   9 +-
 builtin/pack-objects.c             |   7 +-
 builtin/pack-redundant.c           |  10 +-
 builtin/pack-refs.c                |   7 +-
 builtin/patch-id.c                 |   6 +-
 builtin/prune-packed.c             |   5 +-
 builtin/prune.c                    |   6 +-
 builtin/pull.c                     |   6 +-
 builtin/push.c                     |   7 +-
 builtin/range-diff.c               |   8 +-
 builtin/read-tree.c                |   8 +-
 builtin/rebase.c                   |   8 +-
 builtin/receive-pack.c             |   8 +-
 builtin/reflog.c                   |  11 +-
 builtin/refs.c                     |   7 +-
 builtin/remote-ext.c               |   5 +-
 builtin/remote-fd.c                |   5 +-
 builtin/remote.c                   |   6 +-
 builtin/repack.c                   |   6 +-
 builtin/replace.c                  |   8 +-
 builtin/replay.c                   |   6 +-
 builtin/rerere.c                   |   8 +-
 builtin/reset.c                    |   7 +-
 builtin/rev-list.c                 |   6 +-
 builtin/rev-parse.c                |   8 +-
 builtin/revert.c                   |  12 +-
 builtin/rm.c                       |   9 +-
 builtin/send-pack.c                |   6 +-
 builtin/shortlog.c                 |   7 +-
 builtin/show-branch.c              |   8 +-
 builtin/show-index.c               |   7 +-
 builtin/show-ref.c                 |   6 +-
 builtin/sparse-checkout.c          |   7 +-
 builtin/stash.c                    |   6 +-
 builtin/stripspace.c               |   6 +-
 builtin/submodule--helper.c        |   8 +-
 builtin/symbolic-ref.c             |   6 +-
 builtin/tag.c                      |   7 +-
 builtin/unpack-file.c              |   6 +-
 builtin/unpack-objects.c           |   6 +-
 builtin/update-index.c             |   8 +-
 builtin/update-ref.c               |   7 +-
 builtin/update-server-info.c       |   6 +-
 builtin/upload-archive.c           |  12 +-
 builtin/upload-pack.c              |   5 +-
 builtin/var.c                      |   7 +-
 builtin/verify-commit.c            |   7 +-
 builtin/verify-pack.c              |   6 +-
 builtin/verify-tag.c               |   6 +-
 builtin/worktree.c                 |   7 +-
 builtin/write-tree.c               |   8 +-
 commit.h                           |   5 +-
 git.c                              |  12 +-
 help.c                             |   3 +-
 stkOs5Qh                           | Bin 0 -> 10485768 bytes
 129 files changed, 903 insertions(+), 436 deletions(-)
 create mode 100644 stkOs5Qh


base-commit: 4590f2e9412378c61eac95966709c78766d326ba
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1778%2Fjohn-cai%2Fjc%2Fadd-the-repository-to-builtin-signature-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1778/john-cai/jc/add-the-repository-to-builtin-signature-v2
Pull-Request: https://github.com/git/git/pull/1778

Range-diff vs v1:

 1:  3301a34f763 ! 1:  9aaf9662544 builtin: add a repository parameter for builtin functions
     @@ builtin.h: int is_builtin(const char *s);
       #endif
      
       ## builtin/add.c ##
     +@@ builtin/add.c: int interactive_add(const char **argv, const char *prefix, int patch)
     + 	return ret;
     + }
     + 
     +-static int edit_patch(int argc, const char **argv, const char *prefix)
     ++static int edit_patch(int argc,
     ++		      const char **argv,
     ++		      const char *prefix,
     ++		      struct repository *repo UNUSED)
     + {
     + 	char *file = git_pathdup("ADD_EDIT.patch");
     + 	struct child_process child = CHILD_PROCESS_INIT;
      @@ builtin/add.c: static int add_files(struct dir_struct *dir, int flags)
       	return exit_status;
       }
       
      -int cmd_add(int argc, const char **argv, const char *prefix)
     -+int cmd_add(int argc, const char **argv, const char *prefix, struct repository *repository UNUSED)
     ++int cmd_add(int argc,
     ++	    const char **argv,
     ++	    const char *prefix,
     ++	    struct repository *repo UNUSED)
       {
       	int exit_status = 0;
       	struct pathspec pathspec;
     +@@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
     + 	if (edit_interactive) {
     + 		if (pathspec_from_file)
     + 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--edit");
     +-		return(edit_patch(argc, argv, prefix));
     ++		return(edit_patch(argc, argv, prefix, the_repository));
     + 	}
     + 	argc--;
     + 	argv++;
      
       ## builtin/am.c ##
      @@ builtin/am.c: static int parse_opt_show_current_patch(const struct option *opt, const char *ar
     @@ builtin/am.c: static int parse_opt_show_current_patch(const struct option *opt,
       }
       
      -int cmd_am(int argc, const char **argv, const char *prefix)
     -+int cmd_am(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_am(int argc,
     ++	   const char **argv,
     ++	   const char *prefix,
     ++	   struct repository *repo UNUSED)
       {
       	struct am_state state;
       	int binary = -1;
     @@ builtin/annotate.c
       #include "strvec.h"
       
      -int cmd_annotate(int argc, const char **argv, const char *prefix)
     -+int cmd_annotate(int argc, const char **argv, const char *prefix, struct repository *repo)
     ++int cmd_annotate(int argc,
     ++		 const char **argv,
     ++		 const char *prefix,
     ++		 struct repository *repo UNUSED)
       {
       	struct strvec args = STRVEC_INIT;
       	int i;
     @@ builtin/annotate.c: int cmd_annotate(int argc, const char **argv, const char *pr
       	}
       
      -	return cmd_blame(args.nr, args.v, prefix);
     -+	return cmd_blame(args.nr, args.v, prefix, repo);
     ++	return cmd_blame(args.nr, args.v, prefix, the_repository);
       }
      
       ## builtin/apply.c ##
     @@ builtin/apply.c: static const char * const apply_usage[] = {
       };
       
      -int cmd_apply(int argc, const char **argv, const char *prefix)
     -+int cmd_apply(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_apply(int argc,
     ++	      const char **argv,
     ++	      const char *prefix,
     ++	      struct repository *repo UNUSED)
       {
       	int force_apply = 0;
       	int options = 0;
     @@ builtin/archive.c: static int run_remote_archiver(int argc, const char **argv,
       			     PARSE_OPT_NO_INTERNAL_HELP	)
       
      -int cmd_archive(int argc, const char **argv, const char *prefix)
     -+int cmd_archive(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_archive(int argc,
     ++		const char **argv,
     ++		const char *prefix,
     ++		struct repository *repo UNUSED)
       {
       	const char *exec = "git-upload-archive";
       	char *output = NULL;
     @@ builtin/bisect.c: static int cmd_bisect__run(int argc, const char **argv, const
       }
       
      -int cmd_bisect(int argc, const char **argv, const char *prefix)
     -+int cmd_bisect(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_bisect(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	int res = 0;
       	parse_opt_subcommand_fn *fn = NULL;
     @@ builtin/blame.c: static void build_ignorelist(struct blame_scoreboard *sb,
       }
       
      -int cmd_blame(int argc, const char **argv, const char *prefix)
     -+int cmd_blame(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_blame(int argc,
     ++	      const char **argv,
     ++	      const char *prefix,
     ++	      struct repository *repo UNUSED)
       {
       	struct rev_info revs;
       	char *path = NULL;
     @@ builtin/branch.c: static int edit_branch_description(const char *branch_name)
       }
       
      -int cmd_branch(int argc, const char **argv, const char *prefix)
     -+int cmd_branch(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_branch(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	/* possible actions */
       	int delete = 0, rename = 0, copy = 0, list = 0,
     @@ builtin/bugreport.c: static void get_header(struct strbuf *buf, const char *titl
       }
       
      -int cmd_bugreport(int argc, const char **argv, const char *prefix)
     -+int cmd_bugreport(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_bugreport(int argc,
     ++		  const char **argv,
     ++		  const char *prefix,
     ++		  struct repository *repo UNUSED)
       {
       	struct strbuf buffer = STRBUF_INIT;
       	struct strbuf report_path = STRBUF_INIT;
     @@ builtin/bundle.c: cleanup:
       }
       
      -int cmd_bundle(int argc, const char **argv, const char *prefix)
     -+int cmd_bundle(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_bundle(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	parse_opt_subcommand_fn *fn = NULL;
       	struct option options[] = {
     @@ builtin/cat-file.c: static int batch_option_callback(const struct option *opt,
       }
       
      -int cmd_cat_file(int argc, const char **argv, const char *prefix)
     -+int cmd_cat_file(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_cat_file(int argc,
     ++		 const char **argv,
     ++		 const char *prefix,
     ++		 struct repository *repo UNUSED)
       {
       	int opt = 0;
       	int opt_cw = 0;
     @@ builtin/check-attr.c: static NORETURN void error_with_usage(const char *msg)
       }
       
      -int cmd_check_attr(int argc, const char **argv, const char *prefix)
     -+int cmd_check_attr(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_check_attr(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	struct attr_check *check;
       	struct object_id initialized_oid;
     @@ builtin/check-ignore.c: static int check_ignore_stdin_paths(struct dir_struct *d
       }
       
      -int cmd_check_ignore(int argc, const char **argv, const char *prefix)
     -+int cmd_check_ignore(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_check_ignore(int argc,
     ++		     const char **argv,
     ++		     const char *prefix,
     ++		     struct repository *repo UNUSED)
       {
       	int num_ignored;
       	struct dir_struct dir = DIR_INIT;
     @@ builtin/check-mailmap.c: static void check_mailmap(struct string_list *mailmap,
       }
       
      -int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
     -+int cmd_check_mailmap(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_check_mailmap(int argc,
     ++		      const char **argv,
     ++		      const char *prefix,
     ++		      struct repository *repo UNUSED)
       {
       	int i;
       	struct string_list mailmap = STRING_LIST_INIT_NODUP;
     @@ builtin/check-ref-format.c: static int check_ref_format_branch(const char *arg)
       }
       
      -int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
     -+int cmd_check_ref_format(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_check_ref_format(int argc,
     ++			 const char **argv,
     ++			 const char *prefix,
     ++			 struct repository *repo UNUSED)
       {
       	int i;
       	int normalize = 0;
     @@ builtin/checkout--worker.c: static const char * const checkout_worker_usage[] =
       };
       
      -int cmd_checkout__worker(int argc, const char **argv, const char *prefix)
     -+int cmd_checkout__worker(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_checkout__worker(int argc,
     ++			 const char **argv,
     ++			 const char *prefix,
     ++			 struct repository *repo UNUSED)
       {
       	struct checkout state = CHECKOUT_INIT;
       	struct option checkout_worker_options[] = {
     @@ builtin/checkout-index.c: static int option_parse_stage(const struct option *opt
       }
       
      -int cmd_checkout_index(int argc, const char **argv, const char *prefix)
     -+int cmd_checkout_index(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_checkout_index(int argc,
     ++		       const char **argv,
     ++		       const char *prefix,
     ++		       struct repository *repo UNUSED)
       {
       	int i;
       	struct lock_file lock_file = LOCK_INIT;
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
       }
       
      -int cmd_checkout(int argc, const char **argv, const char *prefix)
     -+int cmd_checkout(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_checkout(int argc,
     ++		 const char **argv,
     ++		 const char *prefix,
     ++		 struct repository *repo UNUSED)
       {
       	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
       	struct option *options;
     @@ builtin/checkout.c: int cmd_checkout(int argc, const char **argv, const char *pr
       }
       
      -int cmd_switch(int argc, const char **argv, const char *prefix)
     -+int cmd_switch(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_switch(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
       	struct option *options = NULL;
     @@ builtin/checkout.c: int cmd_switch(int argc, const char **argv, const char *pref
       }
       
      -int cmd_restore(int argc, const char **argv, const char *prefix)
     -+int cmd_restore(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_restore(int argc,
     ++		const char **argv,
     ++		const char *prefix,
     ++		struct repository *repo UNUSED)
       {
       	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
       	struct option *options;
     @@ builtin/clean.c: static void correct_untracked_entries(struct dir_struct *dir)
       }
       
      -int cmd_clean(int argc, const char **argv, const char *prefix)
     -+int cmd_clean(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_clean(int argc,
     ++	      const char **argv,
     ++	      const char *prefix,
     ++	      struct repository *repo UNUSED)
       {
       	int i, res;
       	int dry_run = 0, remove_directories = 0, quiet = 0, ignored = 0;
     @@ builtin/clone.c: static int path_exists(const char *path)
       }
       
      -int cmd_clone(int argc, const char **argv, const char *prefix)
     -+int cmd_clone(int argc, const char **argv, const char *prefix, struct repository *repository UNUSED)
     ++int cmd_clone(int argc,
     ++	      const char **argv,
     ++	      const char *prefix,
     ++	      struct repository *repository UNUSED)
       {
       	int is_bundle = 0, is_local;
       	int reject_shallow = 0;
     @@ builtin/column.c: static int column_config(const char *var, const char *value,
       }
       
      -int cmd_column(int argc, const char **argv, const char *prefix)
     -+int cmd_column(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_column(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	struct string_list list = STRING_LIST_INIT_DUP;
       	struct strbuf sb = STRBUF_INIT;
     @@ builtin/commit-graph.c: cleanup:
       }
       
      -int cmd_commit_graph(int argc, const char **argv, const char *prefix)
     -+int cmd_commit_graph(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_commit_graph(int argc,
     ++		     const char **argv,
     ++		     const char *prefix,
     ++		     struct repository *repo UNUSED)
       {
       	parse_opt_subcommand_fn *fn = NULL;
       	struct option builtin_commit_graph_options[] = {
     @@ builtin/commit-tree.c: static int parse_file_arg_callback(const struct option *o
       }
       
      -int cmd_commit_tree(int argc, const char **argv, const char *prefix)
     -+int cmd_commit_tree(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_commit_tree(int argc,
     ++		    const char **argv,
     ++		    const char *prefix,
     ++		    struct repository *repo UNUSED)
       {
       	static struct strbuf buffer = STRBUF_INIT;
       	struct commit_list *parents = NULL;
     @@ builtin/commit.c: static int git_status_config(const char *k, const char *v,
       }
       
      -int cmd_status(int argc, const char **argv, const char *prefix)
     -+int cmd_status(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_status(int argc,
     ++const char **argv,
     ++const char *prefix,
     ++struct repository *repo UNUSED)
       {
       	static int no_renames = -1;
       	static const char *rename_score_arg = (const char *)-1;
     @@ builtin/commit.c: static int git_commit_config(const char *k, const char *v,
       }
       
      -int cmd_commit(int argc, const char **argv, const char *prefix)
     -+int cmd_commit(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_commit(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	static struct wt_status s;
       	static struct option builtin_commit_options[] = {
     @@ builtin/config.c: out:
       }
       
      -int cmd_config(int argc, const char **argv, const char *prefix)
     -+int cmd_config(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_config(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	parse_opt_subcommand_fn *subcommand = NULL;
       	struct option subcommand_opts[] = {
     @@ builtin/count-objects.c: static char const * const count_objects_usage[] = {
       };
       
      -int cmd_count_objects(int argc, const char **argv, const char *prefix)
     -+int cmd_count_objects(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_count_objects(int argc,
     ++		      const char **argv,
     ++		      const char *prefix,
     ++		      struct repository *repo UNUSED)
       {
       	int human_readable = 0;
       	struct option opts[] = {
     @@ builtin/credential-cache--daemon.c: static void init_socket_directory(const char
       }
       
      -int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
     -+int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_credential_cache_daemon(int argc,
     ++				const char **argv,
     ++				const char *prefix,
     ++				struct repository *repo UNUSED)
       {
       	struct tempfile *socket_file;
       	const char *socket_path;
     @@ builtin/credential-cache--daemon.c: int cmd_credential_cache_daemon(int argc, co
       #else
       
      -int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
     -+int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_credential_cache_daemon(int argc,
     ++const char **argv,
     ++const char *prefix,
     ++struct repository *repo UNUSED)
       {
       	const char * const usage[] = {
       		"git credential-cache--daemon [--debug] <socket-path>",
     @@ builtin/credential-cache.c: static void announce_capabilities(void)
       }
       
      -int cmd_credential_cache(int argc, const char **argv, const char *prefix)
     -+int cmd_credential_cache(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_credential_cache(int argc,
     ++			 const char **argv,
     ++			 const char *prefix,
     ++			 struct repository *repo UNUSED)
       {
       	const char *socket_path_arg = NULL;
       	char *socket_path;
     @@ builtin/credential-store.c: static void lookup_credential(const struct string_li
       }
       
      -int cmd_credential_store(int argc, const char **argv, const char *prefix)
     -+int cmd_credential_store(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_credential_store(int argc,
     ++			 const char **argv,
     ++			 const char *prefix,
     ++			 struct repository *repo UNUSED)
       {
       	const char * const usage[] = {
       		"git credential-store [<options>] <action>",
     @@ builtin/credential.c
       	"git credential (fill|approve|reject)";
       
      -int cmd_credential(int argc, const char **argv, const char *prefix UNUSED)
     -+int cmd_credential(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED)
     ++int cmd_credential(int argc,
     ++		   const char **argv,
     ++		   const char *prefix UNUSED,
     ++		   struct repository *repo UNUSED)
       {
       	const char *op;
       	struct credential c = CREDENTIAL_INIT;
     @@ builtin/describe.c: static int option_parse_exact_match(const struct option *opt
       }
       
      -int cmd_describe(int argc, const char **argv, const char *prefix)
     -+int cmd_describe(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED )
     ++int cmd_describe(int argc,
     ++		 const char **argv,
     ++		 const char *prefix,
     ++		 struct repository *repo UNUSED )
       {
       	int contains = 0;
       	struct option options[] = {
     @@ builtin/diagnose.c: static const char * const diagnose_usage[] = {
       };
       
      -int cmd_diagnose(int argc, const char **argv, const char *prefix)
     -+int cmd_diagnose(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_diagnose(int argc,
     ++		 const char **argv,
     ++		 const char *prefix,
     ++		 struct repository *repo UNUSED)
       {
       	struct strbuf zip_path = STRBUF_INIT;
       	time_t now = time(NULL);
     @@ builtin/diff-files.c: static const char diff_files_usage[] =
       COMMON_DIFF_OPTIONS_HELP;
       
      -int cmd_diff_files(int argc, const char **argv, const char *prefix)
     -+int cmd_diff_files(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_diff_files(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	struct rev_info rev;
       	int result;
     @@ builtin/diff-index.c: static const char diff_cache_usage[] =
       COMMON_DIFF_OPTIONS_HELP;
       
      -int cmd_diff_index(int argc, const char **argv, const char *prefix)
     -+int cmd_diff_index(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_diff_index(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	struct rev_info rev;
       	unsigned int option = 0;
     @@ builtin/diff-tree.c: static void diff_tree_tweak_rev(struct rev_info *rev)
       }
       
      -int cmd_diff_tree(int argc, const char **argv, const char *prefix)
     -+int cmd_diff_tree(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_diff_tree(int argc,
     ++		  const char **argv,
     ++		  const char *prefix,
     ++		  struct repository *repo UNUSED)
       {
       	char line[1000];
       	struct object *tree1, *tree2;
     @@ builtin/diff.c: static void symdiff_release(struct symdiff *sdiff)
       }
       
      -int cmd_diff(int argc, const char **argv, const char *prefix)
     -+int cmd_diff(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_diff(int argc,
     ++	     const char **argv,
     ++	     const char *prefix,
     ++	     struct repository *repo UNUSED)
       {
       	int i;
       	struct rev_info rev;
     @@ builtin/difftool.c: static int run_file_diff(int prompt, const char *prefix,
       }
       
      -int cmd_difftool(int argc, const char **argv, const char *prefix)
     -+int cmd_difftool(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_difftool(int argc,
     ++		 const char **argv,
     ++		 const char *prefix,
     ++		 struct repository *repo UNUSED)
       {
       	int use_gui_tool = -1, dir_diff = 0, prompt = -1, symlinks = 0,
       	    tool_help = 0, no_index = 0;
     @@ builtin/fast-export.c: static int parse_opt_anonymize_map(const struct option *o
       }
       
      -int cmd_fast_export(int argc, const char **argv, const char *prefix)
     -+int cmd_fast_export(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_fast_export(int argc,
     ++		    const char **argv,
     ++		    const char *prefix,
     ++		    struct repository *repo UNUSED)
       {
       	struct rev_info revs;
       	struct commit *commit;
     @@ builtin/fast-import.c: static void parse_argv(void)
       }
       
      -int cmd_fast_import(int argc, const char **argv, const char *prefix)
     -+int cmd_fast_import(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_fast_import(int argc,
     ++		    const char **argv,
     ++		    const char *prefix,
     ++		    struct repository *repo UNUSED)
       {
       	unsigned int i;
       
     @@ builtin/fetch-pack.c: static void add_sought_entry(struct ref ***sought, int *nr
       }
       
      -int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED)
     -+int cmd_fetch_pack(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED)
     ++int cmd_fetch_pack(int argc,
     ++		   const char **argv,
     ++		   const char *prefix UNUSED,
     ++		   struct repository *repo UNUSED)
       {
       	int i, ret;
       	struct ref *ref = NULL;
     @@ builtin/fetch.c: static int fetch_one(struct remote *remote, int argc, const cha
       }
       
      -int cmd_fetch(int argc, const char **argv, const char *prefix)
     -+int cmd_fetch(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_fetch(int argc,
     ++	      const char **argv,
     ++	      const char *prefix,
     ++	      struct repository *repo UNUSED)
       {
       	struct fetch_config config = {
       		.display_format = DISPLAY_FORMAT_FULL,
     @@ builtin/fmt-merge-msg.c: static const char * const fmt_merge_msg_usage[] = {
       };
       
      -int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
     -+int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_fmt_merge_msg(int argc,
     ++		      const char **argv,
     ++		      const char *prefix,
     ++		      struct repository *repo UNUSED)
       {
       	char *inpath = NULL;
       	const char *message = NULL;
     @@ builtin/for-each-ref.c: static char const * const for_each_ref_usage[] = {
       };
       
      -int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
     -+int cmd_for_each_ref(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_for_each_ref(int argc,
     ++		     const char **argv,
     ++		     const char *prefix,
     ++		     struct repository *repo UNUSED)
       {
       	struct ref_sorting *sorting;
       	struct string_list sorting_options = STRING_LIST_INIT_DUP;
     @@ builtin/for-each-repo.c: static int run_command_on_repo(const char *path, int ar
       }
       
      -int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
     -+int cmd_for_each_repo(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_for_each_repo(int argc,
     ++		      const char **argv,
     ++		      const char *prefix,
     ++		      struct repository *repo UNUSED)
       {
       	static const char *config_key = NULL;
       	int keep_going = 0;
     @@ builtin/fsck.c: static struct option fsck_opts[] = {
       };
       
      -int cmd_fsck(int argc, const char **argv, const char *prefix)
     -+int cmd_fsck(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_fsck(int argc,
     ++	     const char **argv,
     ++	     const char *prefix,
     ++	     struct repository *repo UNUSED)
       {
       	int i;
       	struct object_directory *odb;
     @@ builtin/fsmonitor--daemon.c: static int try_to_start_background_daemon(void)
       }
       
      -int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
     -+int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_fsmonitor__daemon(int argc,
     ++			  const char **argv,
     ++			  const char *prefix,
     ++			  struct repository *repo UNUSED)
       {
       	const char *subcmd;
       	enum fsmonitor_reason reason;
     @@ builtin/gc.c: static void gc_before_repack(struct maintenance_run_opts *opts,
       }
       
      -int cmd_gc(int argc, const char **argv, const char *prefix)
     -+int cmd_gc(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_gc(int argc,
     ++const char **argv,
     ++const char *prefix,
     ++struct repository *repo UNUSED)
       {
       	int aggressive = 0;
       	int quiet = 0;
     @@ builtin/gc.c: static const char * const builtin_maintenance_usage[] = {
       };
       
      -int cmd_maintenance(int argc, const char **argv, const char *prefix)
     -+int cmd_maintenance(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_maintenance(int argc,
     ++		    const char **argv,
     ++		    const char *prefix,
     ++		    struct repository *repo UNUSED)
       {
       	parse_opt_subcommand_fn *fn = NULL;
       	struct option builtin_maintenance_options[] = {
     @@ builtin/get-tar-commit-id.c: static const char builtin_get_tar_commit_id_usage[]
       #define HEADERSIZE (2 * RECORDSIZE)
       
      -int cmd_get_tar_commit_id(int argc, const char **argv UNUSED, const char *prefix)
     -+int cmd_get_tar_commit_id(int argc, const char **argv UNUSED, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_get_tar_commit_id(int argc,
     ++			  const char **argv UNUSED,
     ++			  const char *prefix,
     ++			  struct repository *repo UNUSED)
       {
       	char buffer[HEADERSIZE];
       	struct ustar_header *header = (struct ustar_header *)buffer;
     @@ builtin/grep.c: static int pattern_callback(const struct option *opt, const char
       }
       
      -int cmd_grep(int argc, const char **argv, const char *prefix)
     -+int cmd_grep(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_grep(int argc,
     ++	     const char **argv,
     ++	     const char *prefix,
     ++	     struct repository *repo UNUSED)
       {
       	int hit = 0;
       	int cached = 0, untracked = 0, opt_exclude = -1;
     @@ builtin/hash-object.c: static void hash_stdin_paths(const char *type, int no_fil
       }
       
      -int cmd_hash_object(int argc, const char **argv, const char *prefix)
     -+int cmd_hash_object(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_hash_object(int argc,
     ++		    const char **argv,
     ++		    const char *prefix,
     ++		    struct repository *repo UNUSED)
       {
       	static const char * const hash_object_usage[] = {
       		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters]\n"
     @@ builtin/help.c: static void opt_mode_usage(int argc, const char *opt_mode,
       }
       
      -int cmd_help(int argc, const char **argv, const char *prefix)
     -+int cmd_help(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_help(int argc,
     ++	     const char **argv,
     ++	     const char *prefix,
     ++	     struct repository *repo UNUSED)
       {
       	int nongit;
       	enum help_format parsed_help_format;
     @@ builtin/hook.c: usage:
       }
       
      -int cmd_hook(int argc, const char **argv, const char *prefix)
     -+int cmd_hook(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_hook(int argc,
     ++	     const char **argv,
     ++	     const char *prefix,
     ++	     struct repository *repo UNUSED)
       {
       	parse_opt_subcommand_fn *fn = NULL;
       	struct option builtin_hook_options[] = {
     @@ builtin/index-pack.c: static void show_pack_info(int stat_only)
       }
       
      -int cmd_index_pack(int argc, const char **argv, const char *prefix)
     -+int cmd_index_pack(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_index_pack(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	int i, fix_thin_pack = 0, verify = 0, stat_only = 0, rev_index;
       	const char *curr_index;
     @@ builtin/init-db.c: static const char *const init_db_usage[] = {
        * be the judge.  The default case is to have one DB per managed directory.
        */
      -int cmd_init_db(int argc, const char **argv, const char *prefix)
     -+int cmd_init_db(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_init_db(int argc,
     ++		const char **argv,
     ++		const char *prefix,
     ++		struct repository *repo UNUSED)
       {
       	const char *git_dir;
       	const char *real_git_dir = NULL;
     @@ builtin/interpret-trailers.c: static void interpret_trailers(const struct proces
       }
       
      -int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
     -+int cmd_interpret_trailers(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_interpret_trailers(int argc,
     ++			   const char **argv,
     ++			   const char *prefix,
     ++			   struct repository *repo UNUSED)
       {
       	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
       	LIST_HEAD(trailers);
     @@ builtin/log.c: static int git_log_config(const char *var, const char *value,
       }
       
      -int cmd_whatchanged(int argc, const char **argv, const char *prefix)
     -+int cmd_whatchanged(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_whatchanged(int argc,
     ++		    const char **argv,
     ++		    const char *prefix,
     ++		    struct repository *repo UNUSED)
       {
       	struct log_config cfg;
       	struct rev_info rev;
     @@ builtin/log.c: static void show_setup_revisions_tweak(struct rev_info *rev)
       }
       
      -int cmd_show(int argc, const char **argv, const char *prefix)
     -+int cmd_show(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_show(int argc,
     ++	     const char **argv,
     ++	     const char *prefix,
     ++	     struct repository *repo UNUSED)
       {
       	struct log_config cfg;
       	struct rev_info rev;
     @@ builtin/log.c: int cmd_show(int argc, const char **argv, const char *prefix)
        * This is equivalent to "git log -g --abbrev-commit --pretty=oneline"
        */
      -int cmd_log_reflog(int argc, const char **argv, const char *prefix)
     -+int cmd_log_reflog(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_log_reflog(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	struct log_config cfg;
       	struct rev_info rev;
     @@ builtin/log.c: static void log_setup_revisions_tweak(struct rev_info *rev)
       }
       
      -int cmd_log(int argc, const char **argv, const char *prefix)
     -+int cmd_log(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_log(int argc,
     ++	    const char **argv,
     ++	    const char *prefix,
     ++	    struct repository *repo UNUSED)
       {
       	struct log_config cfg;
       	struct rev_info rev;
     @@ builtin/log.c: static void infer_range_diff_ranges(struct strbuf *r1,
       }
       
      -int cmd_format_patch(int argc, const char **argv, const char *prefix)
     -+int cmd_format_patch(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_format_patch(int argc,
     ++		     const char **argv,
     ++		     const char *prefix,
     ++		     struct repository *repo UNUSED)
       {
       	struct format_config cfg;
       	struct commit *commit;
     @@ builtin/log.c: static void print_commit(char sign, struct commit *commit, int ve
       }
       
      -int cmd_cherry(int argc, const char **argv, const char *prefix)
     -+int cmd_cherry(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_cherry(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	struct rev_info revs;
       	struct patch_ids ids;
     @@ builtin/ls-files.c: static int option_parse_exclude_standard(const struct option
       }
       
      -int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
     -+int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix, struct repository *repo UNUSED)
     ++int cmd_ls_files(int argc,
     ++		 const char **argv,
     ++		 const char *cmd_prefix,
     ++		 struct repository *repo UNUSED)
       {
       	int require_work_tree = 0, show_tag = 0, i;
       	char *max_prefix;
     @@ builtin/ls-remote.c: static int tail_match(const struct strvec *pattern, const c
       }
       
      -int cmd_ls_remote(int argc, const char **argv, const char *prefix)
     -+int cmd_ls_remote(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_ls_remote(int argc,
     ++		  const char **argv,
     ++		  const char *prefix,
     ++		  struct repository *repo UNUSED)
       {
       	const char *dest = NULL;
       	unsigned flags = 0;
     @@ builtin/ls-tree.c: static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[]
       };
       
      -int cmd_ls_tree(int argc, const char **argv, const char *prefix)
     -+int cmd_ls_tree(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_ls_tree(int argc,
     ++		const char **argv,
     ++		const char *prefix,
     ++		struct repository *repo UNUSED)
       {
       	struct object_id oid;
       	struct tree *tree;
     @@ builtin/mailinfo.c: static int parse_opt_quoted_cr(const struct option *opt, con
       }
       
      -int cmd_mailinfo(int argc, const char **argv, const char *prefix)
     -+int cmd_mailinfo(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_mailinfo(int argc,
     ++		 const char **argv,
     ++		 const char *prefix,
     ++		 struct repository *repo UNUSED)
       {
       	struct metainfo_charset meta_charset;
       	struct mailinfo mi;
     @@ builtin/mailsplit.c: out:
       }
       
      -int cmd_mailsplit(int argc, const char **argv, const char *prefix)
     -+int cmd_mailsplit(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_mailsplit(int argc,
     ++		  const char **argv,
     ++		  const char *prefix,
     ++		  struct repository *repo UNUSED)
       {
       	int nr = 0, nr_prec = 4, num = 0;
       	int allow_bare = 0;
     @@ builtin/merge-base.c: static int handle_fork_point(int argc, const char **argv)
       }
       
      -int cmd_merge_base(int argc, const char **argv, const char *prefix)
     -+int cmd_merge_base(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_merge_base(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	struct commit **rev;
       	int rev_nr = 0;
     @@ builtin/merge-file.c: static int diff_algorithm_cb(const struct option *opt,
       }
       
      -int cmd_merge_file(int argc, const char **argv, const char *prefix)
     -+int cmd_merge_file(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_merge_file(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	const char *names[3] = { 0 };
       	mmfile_t mmfs[3] = { 0 };
     @@ builtin/merge-index.c: static void merge_all(void)
       }
       
      -int cmd_merge_index(int argc, const char **argv, const char *prefix UNUSED)
     -+int cmd_merge_index(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED)
     ++int cmd_merge_index(int argc,
     ++		    const char **argv,
     ++		    const char *prefix UNUSED,
     ++		    struct repository *repo UNUSED)
       {
       	int i, force_file = 0;
       
     @@ builtin/merge-ours.c
       	"git merge-ours <base>... -- HEAD <remote>...";
       
      -int cmd_merge_ours(int argc, const char **argv, const char *prefix UNUSED)
     -+int cmd_merge_ours(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED)
     ++int cmd_merge_ours(int argc,
     ++		   const char **argv,
     ++		   const char *prefix UNUSED,
     ++		   struct repository *repo UNUSED)
       {
       	if (argc == 2 && !strcmp(argv[1], "-h"))
       		usage(builtin_merge_ours_usage);
     @@ builtin/merge-recursive.c: static char *better_branch_name(const char *branch)
       }
       
      -int cmd_merge_recursive(int argc, const char **argv, const char *prefix UNUSED)
     -+int cmd_merge_recursive(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED)
     ++int cmd_merge_recursive(int argc,
     ++			const char **argv,
     ++			const char *prefix UNUSED,
     ++			struct repository *repo UNUSED)
       {
       	struct object_id bases[21];
       	unsigned bases_count = 0;
     @@ builtin/merge-tree.c: static int real_merge(struct merge_tree_options *o,
       }
       
      -int cmd_merge_tree(int argc, const char **argv, const char *prefix)
     -+int cmd_merge_tree(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_merge_tree(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	struct merge_tree_options o = { .show_messages = -1 };
       	struct strvec xopts = STRVEC_INIT;
     @@ builtin/merge.c: static int merging_a_throwaway_tag(struct commit *commit)
       }
       
      -int cmd_merge(int argc, const char **argv, const char *prefix)
     -+int cmd_merge(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_merge(int argc,
     ++	      const char **argv,
     ++	      const char *prefix,
     ++	      struct repository *repo UNUSED)
       {
       	struct object_id result_tree, stash, head_oid;
       	struct commit *head_commit;
     @@ builtin/mktag.c: static int verify_object_in_tag(struct object_id *tagged_oid, i
       }
       
      -int cmd_mktag(int argc, const char **argv, const char *prefix)
     -+int cmd_mktag(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_mktag(int argc,
     ++	      const char **argv,
     ++	      const char *prefix,
     ++	      struct repository *repo UNUSED)
       {
       	static struct option builtin_mktag_options[] = {
       		OPT_BOOL(0, "strict", &option_strict,
     @@ builtin/mktree.c: static void mktree_line(char *buf, int nul_term_line, int allo
       }
       
      -int cmd_mktree(int ac, const char **av, const char *prefix)
     -+int cmd_mktree(int ac, const char **av, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_mktree(int ac,
     ++	       const char **av,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	struct strbuf sb = STRBUF_INIT;
       	struct object_id oid;
     +@@ builtin/mktree.c: int cmd_mktree(int ac, const char **av, const char *prefix)
     + 		used=0; /* reset tree entry buffer for re-use in batch mode */
     + 	}
     + 	strbuf_release(&sb);
     ++
     + 	return 0;
     + }
      
       ## builtin/multi-pack-index.c ##
      @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_repack(int argc, const char **argv,
     + 			   (size_t)opts.batch_size, opts.flags);
       }
       
     - int cmd_multi_pack_index(int argc, const char **argv,
     +-int cmd_multi_pack_index(int argc, const char **argv,
      -			 const char *prefix)
     -+			 const char *prefix, struct repository *repo UNUSED)
     ++int cmd_multi_pack_index(int argc,
     ++			 const char **argv,
     ++			 const char *prefix,
     ++			 struct repository *repo UNUSED)
       {
       	int res;
       	parse_opt_subcommand_fn *fn = NULL;
     @@ builtin/mv.c: static void remove_empty_src_dirs(const char **src_dir, size_t src
       }
       
      -int cmd_mv(int argc, const char **argv, const char *prefix)
     -+int cmd_mv(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_mv(int argc,
     ++	   const char **argv,
     ++	   const char *prefix,
     ++	   struct repository *repo UNUSED)
       {
       	int i, flags, gitmodules_modified = 0;
       	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
     @@ builtin/name-rev.c: static void name_rev_line(char *p, struct name_ref_data *dat
       }
       
      -int cmd_name_rev(int argc, const char **argv, const char *prefix)
     -+int cmd_name_rev(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_name_rev(int argc,
     ++		 const char **argv,
     ++		 const char *prefix,
     ++		 struct repository *repo UNUSED)
       {
       	struct mem_pool string_pool;
       	struct object_array revs = OBJECT_ARRAY_INIT;
     @@ builtin/notes.c: static int get_ref(int argc, const char **argv, const char *pre
       }
       
      -int cmd_notes(int argc, const char **argv, const char *prefix)
     -+int cmd_notes(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_notes(int argc,
     ++	      const char **argv,
     ++	      const char *prefix,
     ++	      struct repository *repo UNUSED)
       {
       	const char *override_notes_ref = NULL;
       	parse_opt_subcommand_fn *fn = NULL;
     @@ builtin/pack-objects.c: static int option_parse_cruft_expiration(const struct op
       }
       
      -int cmd_pack_objects(int argc, const char **argv, const char *prefix)
     -+int cmd_pack_objects(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_pack_objects(int argc,
     ++		     const char **argv,
     ++		     const char *prefix,
     ++		     struct repository *repo UNUSED)
       {
       	int use_internal_rev_list = 0;
       	int shallow = 0;
     @@ builtin/pack-redundant.c: static void load_all(void)
       }
       
      -int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED)
     -+int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED)
     - {
     - 	int i;
     - 	int i_still_use_this = 0;
     +-{
     +-	int i;
     +-	int i_still_use_this = 0;
     +-	struct pack_list *min = NULL, *red, *pl;
     ++int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED) {
     ++	int i; int i_still_use_this = 0; struct pack_list *min = NULL, *red, *pl;
     + 	struct llist *ignore;
     + 	struct object_id *oid;
     + 	char buf[GIT_MAX_HEXSZ + 2]; /* hex hash + \n + \0 */
      
       ## builtin/pack-refs.c ##
      @@ builtin/pack-refs.c: static char const * const pack_refs_usage[] = {
     @@ builtin/pack-refs.c: static char const * const pack_refs_usage[] = {
       };
       
      -int cmd_pack_refs(int argc, const char **argv, const char *prefix)
     -+int cmd_pack_refs(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_pack_refs(int argc,
     ++		  const char **argv,
     ++		  const char *prefix,
     ++		  struct repository *repo UNUSED)
       {
       	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
       	struct string_list included_refs = STRING_LIST_INIT_NODUP;
     @@ builtin/patch-id.c: static int git_patch_id_config(const char *var, const char *
       }
       
      -int cmd_patch_id(int argc, const char **argv, const char *prefix)
     -+int cmd_patch_id(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_patch_id(int argc,
     ++		 const char **argv,
     ++		 const char *prefix,
     ++		 struct repository *repo UNUSED)
       {
       	/* if nothing is set, default to unstable */
       	struct patch_id_opts config = {0, 0};
     @@ builtin/prune-packed.c: static const char * const prune_packed_usage[] = {
       };
       
      -int cmd_prune_packed(int argc, const char **argv, const char *prefix)
     -+int cmd_prune_packed(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_prune_packed(int argc,
     ++		     const char **argv,
     ++		     const char *prefix,
     ++		     struct repository *repo UNUSED)
       {
       	int opts = isatty(2) ? PRUNE_PACKED_VERBOSE : 0;
       	const struct option prune_packed_options[] = {
     @@ builtin/prune.c: static void remove_temporary_files(const char *path)
       }
       
      -int cmd_prune(int argc, const char **argv, const char *prefix)
     -+int cmd_prune(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_prune(int argc,
     ++	      const char **argv,
     ++	      const char *prefix,
     ++	      struct repository *repo UNUSED)
       {
       	struct rev_info revs;
       	int exclude_promisor_objects = 0;
     @@ builtin/pull.c: static void show_advice_pull_non_ff(void)
       }
       
      -int cmd_pull(int argc, const char **argv, const char *prefix)
     -+int cmd_pull(int argc, const char **argv, const char *prefix, struct repository *repository UNUSED)
     ++int cmd_pull(int argc,
     ++	     const char **argv,
     ++	     const char *prefix,
     ++	     struct repository *repository UNUSED)
       {
       	const char *repo, **refspecs;
       	struct oid_array merge_heads = OID_ARRAY_INIT;
     @@ builtin/push.c: static int git_push_config(const char *k, const char *v,
       }
       
      -int cmd_push(int argc, const char **argv, const char *prefix)
     -+int cmd_push(int argc, const char **argv, const char *prefix, struct repository *repository UNUSED)
     ++int cmd_push(int argc,
     ++	     const char **argv,
     ++	     const char *prefix,
     ++	     struct repository *repository UNUSED)
       {
       	int flags = 0;
       	int tags = 0;
     @@ builtin/range-diff.c: N_("git range-diff [<options>] <base> <old-tip> <new-tip>"
       };
       
      -int cmd_range_diff(int argc, const char **argv, const char *prefix)
     -+int cmd_range_diff(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_range_diff(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	struct diff_options diffopt = { NULL };
       	struct strvec other_arg = STRVEC_INIT;
     @@ builtin/read-tree.c: static int git_read_tree_config(const char *var, const char
       }
       
      -int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
     -+int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix, struct repository *repo UNUSED)
     ++int cmd_read_tree(int argc,
     ++		  const char **argv,
     ++		  const char *cmd_prefix,
     ++		  struct repository *repo UNUSED)
       {
       	int i, stage = 0;
       	struct object_id oid;
     @@ builtin/rebase.c: static int check_exec_cmd(const char *cmd)
       }
       
      -int cmd_rebase(int argc, const char **argv, const char *prefix)
     -+int cmd_rebase(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_rebase(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	struct rebase_options options = REBASE_OPTIONS_INIT;
       	const char *branch_name;
     @@ builtin/receive-pack.c: static int delete_only(struct command *commands)
       }
       
      -int cmd_receive_pack(int argc, const char **argv, const char *prefix)
     -+int cmd_receive_pack(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_receive_pack(int argc,
     ++		     const char **argv,
     ++		     const char *prefix,
     ++		     struct repository *repo UNUSED)
       {
       	int advertise_refs = 0;
       	struct command *commands;
     @@ builtin/reflog.c: static int cmd_reflog_exists(int argc, const char **argv, cons
        */
       
      -int cmd_reflog(int argc, const char **argv, const char *prefix)
     -+int cmd_reflog(int argc, const char **argv, const char *prefix, struct repository *repository)
     ++int cmd_reflog(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repository)
       {
       	parse_opt_subcommand_fn *fn = NULL;
       	struct option options[] = {
     @@ builtin/refs.c: static int cmd_refs_verify(int argc, const char **argv, const ch
       }
       
      -int cmd_refs(int argc, const char **argv, const char *prefix)
     -+int cmd_refs(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_refs(int argc,
     ++	     const char **argv,
     ++	     const char *prefix,
     ++	     struct repository *repo UNUSED)
       {
       	const char * const refs_usage[] = {
       		REFS_MIGRATE_USAGE,
     @@ builtin/remote-ext.c: static int command_loop(const char *child)
       }
       
      -int cmd_remote_ext(int argc, const char **argv, const char *prefix)
     -+int cmd_remote_ext(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_remote_ext(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	BUG_ON_NON_EMPTY_PREFIX(prefix);
       
     @@ builtin/remote-fd.c: static void command_loop(int input_fd, int output_fd)
       }
       
      -int cmd_remote_fd(int argc, const char **argv, const char *prefix)
     -+int cmd_remote_fd(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_remote_fd(int argc,
     ++		  const char **argv,
     ++		  const char *prefix,
     ++		  struct repository *repo UNUSED)
       {
       	int input_fd = -1;
       	int output_fd = -1;
     @@ builtin/remote.c: out:
       }
       
      -int cmd_remote(int argc, const char **argv, const char *prefix)
     -+int cmd_remote(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_remote(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	parse_opt_subcommand_fn *fn = NULL;
       	struct option options[] = {
     @@ builtin/repack.c: static const char *find_pack_prefix(const char *packdir, const
       }
       
      -int cmd_repack(int argc, const char **argv, const char *prefix)
     -+int cmd_repack(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_repack(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	struct child_process cmd = CHILD_PROCESS_INIT;
       	struct string_list_item *item;
     @@ builtin/replace.c: static int convert_graft_file(int force)
       }
       
      -int cmd_replace(int argc, const char **argv, const char *prefix)
     -+int cmd_replace(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_replace(int argc,
     ++		const char **argv,
     ++		const char *prefix,
     ++		struct repository *repo UNUSED)
       {
       	int force = 0;
       	int raw = 0;
     @@ builtin/replay.c: static struct commit *pick_regular_commit(struct commit *pickm
       }
       
      -int cmd_replay(int argc, const char **argv, const char *prefix)
     -+int cmd_replay(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_replay(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	const char *advance_name_opt = NULL;
       	char *advance_name = NULL;
     @@ builtin/rerere.c: static int diff_two(const char *file1, const char *label1,
       }
       
      -int cmd_rerere(int argc, const char **argv, const char *prefix)
     -+int cmd_rerere(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_rerere(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	struct string_list merge_rr = STRING_LIST_INIT_DUP;
       	int i, autoupdate = -1, flags = 0;
     @@ builtin/reset.c: static int git_reset_config(const char *var, const char *value,
       }
       
      -int cmd_reset(int argc, const char **argv, const char *prefix)
     -+int cmd_reset(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_reset(int argc,
     ++	      const char **argv,
     ++	      const char *prefix,
     ++	      struct repository *repo UNUSED)
       {
       	int reset_type = NONE, update_ref_status = 0, quiet = 0;
       	int no_refresh = 0;
     @@ builtin/rev-list.c: static int try_bitmap_disk_usage(struct rev_info *revs,
       }
       
      -int cmd_rev_list(int argc, const char **argv, const char *prefix)
     -+int cmd_rev_list(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_rev_list(int argc,
     ++		 const char **argv,
     ++		 const char *prefix,
     ++		 struct repository *repo UNUSED)
       {
       	struct rev_info revs;
       	struct rev_list_info info;
     @@ builtin/rev-parse.c: static void print_path(const char *path, const char *prefix
       }
       
      -int cmd_rev_parse(int argc, const char **argv, const char *prefix)
     -+int cmd_rev_parse(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_rev_parse(int argc,
     ++		  const char **argv,
     ++		  const char *prefix,
     ++		  struct repository *repo UNUSED)
       {
       	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
       	const struct git_hash_algo *output_algo = NULL;
     @@ builtin/revert.c: static int run_sequencer(int argc, const char **argv, const ch
       }
       
      -int cmd_revert(int argc, const char **argv, const char *prefix)
     -+int cmd_revert(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_revert(int argc,
     ++	       const char **argv,
     ++	       const char *prefix,
     ++	       struct repository *repo UNUSED)
       {
       	struct replay_opts opts = REPLAY_OPTS_INIT;
       	int res;
     @@ builtin/revert.c: int cmd_revert(int argc, const char **argv, const char *prefix
       }
       
      -int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
     -+int cmd_cherry_pick(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_cherry_pick(int argc,
     ++const char **argv,
     ++const char *prefix,
     ++struct repository *repo UNUSED)
       {
       	struct replay_opts opts = REPLAY_OPTS_INIT;
       	int res;
     @@ builtin/rm.c: static struct option builtin_rm_options[] = {
       };
       
      -int cmd_rm(int argc, const char **argv, const char *prefix)
     -+int cmd_rm(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_rm(int argc,
     ++	   const char **argv,
     ++	   const char *prefix,
     ++	   struct repository *repo UNUSED)
       {
       	struct lock_file lock_file = LOCK_INIT;
       	int i, ret = 0;
     @@ builtin/send-pack.c: static int send_pack_config(const char *k, const char *v,
       }
       
      -int cmd_send_pack(int argc, const char **argv, const char *prefix)
     -+int cmd_send_pack(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_send_pack(int argc,
     ++		  const char **argv,
     ++		  const char *prefix,
     ++		  struct repository *repo UNUSED)
       {
       	struct refspec rs = REFSPEC_INIT_PUSH;
       	const char *remote_name = NULL;
     @@ builtin/shortlog.c: void shortlog_finish_setup(struct shortlog *log)
       }
       
      -int cmd_shortlog(int argc, const char **argv, const char *prefix)
     -+int cmd_shortlog(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_shortlog(int argc,
     ++		 const char **argv,
     ++		 const char *prefix,
     ++		 struct repository *repo UNUSED)
       {
       	struct shortlog log = { STRING_LIST_INIT_NODUP };
       	struct rev_info rev;
     @@ builtin/show-branch.c: static int parse_reflog_param(const struct option *opt, c
       }
       
      -int cmd_show_branch(int ac, const char **av, const char *prefix)
     -+int cmd_show_branch(int ac, const char **av, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_show_branch(int ac,
     ++		const char **av,
     ++		const char *prefix,
     ++		struct repository *repo UNUSED)
       {
       	struct commit *rev[MAX_REVS], *commit;
       	char *reflog_msg[MAX_REVS] = {0};
     @@ builtin/show-index.c: static const char *const show_index_usage[] = {
       };
       
      -int cmd_show_index(int argc, const char **argv, const char *prefix)
     -+int cmd_show_index(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_show_index(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	int i;
       	unsigned nr;
     @@ builtin/show-ref.c: static int exclude_existing_callback(const struct option *op
       }
       
      -int cmd_show_ref(int argc, const char **argv, const char *prefix)
     -+int cmd_show_ref(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_show_ref(int argc,
     ++const char **argv,
     ++const char *prefix,
     ++struct repository *repo UNUSED)
       {
       	struct exclude_existing_options exclude_existing_opts = {0};
       	struct patterns_options patterns_opts = {0};
     @@ builtin/sparse-checkout.c: static int sparse_checkout_check_rules(int argc, cons
       }
       
      -int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
     -+int cmd_sparse_checkout(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_sparse_checkout(int argc,
     ++			const char **argv,
     ++			const char *prefix,
     ++			struct repository *repo UNUSED)
       {
       	parse_opt_subcommand_fn *fn = NULL;
       	struct option builtin_sparse_checkout_options[] = {
     @@ builtin/stash.c: static int save_stash(int argc, const char **argv, const char *
       }
       
      -int cmd_stash(int argc, const char **argv, const char *prefix)
     -+int cmd_stash(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_stash(int argc,
     ++	      const char **argv,
     ++	      const char *prefix,
     ++	      struct repository *repo UNUSED)
       {
       	pid_t pid = getpid();
       	const char *index_file;
     @@ builtin/stripspace.c: enum stripspace_mode {
       };
       
      -int cmd_stripspace(int argc, const char **argv, const char *prefix)
     -+int cmd_stripspace(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_stripspace(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	struct strbuf buf = STRBUF_INIT;
       	enum stripspace_mode mode = STRIP_DEFAULT;
     @@ builtin/submodule--helper.c: cleanup:
       }
       
      -int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
     -+int cmd_submodule__helper(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_submodule__helper(int argc,
     ++			  const char **argv,
     ++			  const char *prefix,
     ++			  struct repository *repo UNUSED)
       {
       	parse_opt_subcommand_fn *fn = NULL;
       	const char *const usage[] = {
     @@ builtin/symbolic-ref.c: static int check_symref(const char *HEAD, int quiet, int
       }
       
      -int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
     -+int cmd_symbolic_ref(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_symbolic_ref(int argc,
     ++		     const char **argv,
     ++		     const char *prefix,
     ++		     struct repository *repo UNUSED)
       {
       	int quiet = 0, delete = 0, shorten = 0, recurse = 1, ret = 0;
       	const char *msg = NULL;
     @@ builtin/tag.c: static int strbuf_check_tag_ref(struct strbuf *sb, const char *na
       }
       
      -int cmd_tag(int argc, const char **argv, const char *prefix)
     -+int cmd_tag(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_tag(int argc,
     ++	    const char **argv,
     ++	    const char *prefix,
     ++	    struct repository *repo UNUSED)
       {
       	struct strbuf buf = STRBUF_INIT;
       	struct strbuf ref = STRBUF_INIT;
     @@ builtin/unpack-file.c: static char *create_temp_file(struct object_id *oid)
       }
       
      -int cmd_unpack_file(int argc, const char **argv, const char *prefix UNUSED)
     -+int cmd_unpack_file(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED)
     ++int cmd_unpack_file(int argc,
     ++		    const char **argv,
     ++		    const char *prefix UNUSED,
     ++		    struct repository *repo UNUSED)
       {
       	struct object_id oid;
       
     @@ builtin/unpack-objects.c: static void unpack_all(void)
       }
       
      -int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
     -+int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED)
     ++int cmd_unpack_objects(int argc,
     ++		       const char **argv,
     ++		       const char *prefix UNUSED,
     ++		       struct repository *repo UNUSED)
       {
       	int i;
       	struct object_id oid;
     @@ builtin/update-index.c: static enum parse_opt_result reupdate_callback(
       }
       
      -int cmd_update_index(int argc, const char **argv, const char *prefix)
     -+int cmd_update_index(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_update_index(int argc,
     ++		     const char **argv,
     ++		     const char *prefix,
     ++		     struct repository *repo UNUSED)
       {
       	int newfd, entries, has_errors = 0, nul_term_line = 0;
       	enum uc_mode untracked_cache = UC_UNSPECIFIED;
     @@ builtin/update-ref.c: static void update_refs_stdin(void)
       }
       
      -int cmd_update_ref(int argc, const char **argv, const char *prefix)
     -+int cmd_update_ref(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_update_ref(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	const char *refname, *oldval;
       	struct object_id oid, oldoid;
     @@ builtin/update-server-info.c: static const char * const update_server_info_usage
       };
       
      -int cmd_update_server_info(int argc, const char **argv, const char *prefix)
     -+int cmd_update_server_info(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_update_server_info(int argc,
     ++			   const char **argv,
     ++			   const char *prefix,
     ++			   struct repository *repo UNUSED)
       {
       	int force = 0;
       	struct option options[] = {
     @@ builtin/upload-archive.c: static const char deadchild[] =
       #define MAX_ARGS (64)
       
      -int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
     -+int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_upload_archive_writer(int argc,
     ++			      const char **argv,
     ++			      const char *prefix,
     ++			      struct repository *repo UNUSED)
       {
       	struct strvec sent_argv = STRVEC_INIT;
       	const char *arg_cmd = "argument ";
     @@ builtin/upload-archive.c: static ssize_t process_input(int child_fd, int band)
       }
       
      -int cmd_upload_archive(int argc, const char **argv, const char *prefix)
     -+int cmd_upload_archive(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_upload_archive(int argc,
     ++const char **argv,
     ++const char *prefix,
     ++struct repository *repo UNUSED)
       {
       	struct child_process writer = CHILD_PROCESS_INIT;
       
     @@ builtin/upload-pack.c: static const char * const upload_pack_usage[] = {
       };
       
      -int cmd_upload_pack(int argc, const char **argv, const char *prefix)
     -+int cmd_upload_pack(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_upload_pack(int argc,
     ++		    const char **argv,
     ++		    const char *prefix,
     ++		    struct repository *repo UNUSED)
       {
       	const char *dir;
       	int strict = 0;
     @@ builtin/var.c: static int show_config(const char *var, const char *value,
       }
       
      -int cmd_var(int argc, const char **argv, const char *prefix UNUSED)
     -+int cmd_var(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED)
     ++int cmd_var(int argc,
     ++	    const char **argv,
     ++	    const char *prefix UNUSED,
     ++	    struct repository *repo UNUSED)
       {
       	const struct git_var *git_var;
       	char *val;
     @@ builtin/verify-commit.c: static int verify_commit(const char *name, unsigned fla
       }
       
      -int cmd_verify_commit(int argc, const char **argv, const char *prefix)
     -+int cmd_verify_commit(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_verify_commit(int argc,
     ++		      const char **argv,
     ++		      const char *prefix,
     ++		      struct repository *repo UNUSED)
       {
       	int i = 1, verbose = 0, had_error = 0;
       	unsigned flags = 0;
     @@ builtin/verify-pack.c: static const char * const verify_pack_usage[] = {
       };
       
      -int cmd_verify_pack(int argc, const char **argv, const char *prefix)
     -+int cmd_verify_pack(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_verify_pack(int argc,
     ++		    const char **argv,
     ++		    const char *prefix,
     ++		    struct repository *repo UNUSED)
       {
       	int err = 0;
       	unsigned int flags = 0;
     @@ builtin/verify-tag.c: static const char * const verify_tag_usage[] = {
       };
       
      -int cmd_verify_tag(int argc, const char **argv, const char *prefix)
     -+int cmd_verify_tag(int argc, const char **argv, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_verify_tag(int argc,
     ++		   const char **argv,
     ++		   const char *prefix,
     ++		   struct repository *repo UNUSED)
       {
       	int i = 1, verbose = 0, had_error = 0;
       	unsigned flags = 0;
     @@ builtin/worktree.c: static int repair(int ac, const char **av, const char *prefi
       }
       
      -int cmd_worktree(int ac, const char **av, const char *prefix)
     -+int cmd_worktree(int ac, const char **av, const char *prefix, struct repository *repo UNUSED)
     ++int cmd_worktree(int ac,
     ++		 const char **av,
     ++		 const char *prefix,
     ++		 struct repository *repo UNUSED)
       {
       	parse_opt_subcommand_fn *fn = NULL;
       	struct option options[] = {
     @@ builtin/write-tree.c: static const char * const write_tree_usage[] = {
       };
       
      -int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
     -+int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix, struct repository *repo UNUSED)
     ++int cmd_write_tree(int argc,
     ++		   const char **argv,
     ++		   const char *cmd_prefix,
     ++		   struct repository *repo UNUSED)
       {
       	int flags = 0, ret;
       	const char *tree_prefix = NULL;
     @@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
      -	status = p->fn(argc, argv, prefix);
      -	validate_cache_entries(the_repository->index);
      +	validate_cache_entries(repo->index);
     -+
     -+	status = p->fn(argc, argv, prefix, startup_info->have_repository? repo: NULL) ;
     -+
     ++	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
      +	validate_cache_entries(repo->index);
       
       	if (status)
     @@ help.c: void get_version_info(struct strbuf *buf, int show_build_options)
       {
       	struct strbuf buf = STRBUF_INIT;
       	int build_options = 0;
     +
     + ## stkOs5Qh (new) ##
     + Binary files /dev/null and stkOs5Qh differ
 2:  17acc1e054c ! 2:  434c8babbb1 builtin: remove USE_THE_REPOSITORY_VARIABLE from builtin.h
     @@ Commit message
          builtin: remove USE_THE_REPOSITORY_VARIABLE from builtin.h
      
          Instead of including USE_THE_REPOSITORY_VARIABLE by default on every
     -    builtin, remove it from builtin.h and add it where necessary to
     -    individual builtins/*. The next step will be to migrate each builtin
     +    builtin, remove it from builtin.h and add it to all the builtins that
     +    reference the_repository.
     +
     +    Also, remove the include statement for repository.h since it gets
     +    brought in through builtin.h.
     +
     +    The next step will be to migrate each builtin
          from having to use the_repository.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
     @@ builtin/add.c
       #include "builtin.h"
       #include "advice.h"
       #include "config.h"
     +@@
     + #include "preload-index.h"
     + #include "diff.h"
     + #include "read-cache.h"
     +-#include "repository.h"
     + #include "revision.h"
     + #include "bulk-checkin.h"
     + #include "strvec.h"
      
       ## builtin/am.c ##
      @@
     @@ builtin/am.c
       #include "builtin.h"
       #include "abspath.h"
       #include "advice.h"
     +@@
     + #include "string-list.h"
     + #include "pager.h"
     + #include "path.h"
     +-#include "repository.h"
     + #include "pretty.h"
     + 
     + /**
     +
     + ## builtin/annotate.c ##
     +@@
     +  *
     +  * Copyright (C) 2006 Ryan Anderson
     +  */
     ++
     ++#define USE_THE_REPOSITORY_VARIABLE
     + #include "git-compat-util.h"
     + #include "builtin.h"
     + #include "strvec.h"
      
       ## builtin/apply.c ##
      @@
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
       #include "gettext.h"
     - #include "repository.h"
     +-#include "repository.h"
     + #include "hash.h"
     + #include "apply.h"
     + 
      
       ## builtin/archive.c ##
      @@
     @@ builtin/archive.c
       #include "builtin.h"
       #include "archive.h"
       #include "gettext.h"
     + #include "transport.h"
     + #include "parse-options.h"
     + #include "pkt-line.h"
     +-#include "repository.h"
     + 
     + static void create_output_file(const char *output_file)
     + {
      
       ## builtin/bisect.c ##
      @@
     @@ builtin/blame.c
       #include "builtin.h"
       #include "config.h"
       #include "color.h"
     +@@
     + #include "environment.h"
     + #include "gettext.h"
     + #include "hex.h"
     +-#include "repository.h"
     + #include "commit.h"
     + #include "diff.h"
     + #include "revision.h"
      
       ## builtin/branch.c ##
      @@
     @@ builtin/branch.c
      -
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
       #include "config.h"
       #include "color.h"
     - #include "editor.h"
      
       ## builtin/bugreport.c ##
      @@
     @@ builtin/bundle.c
       #include "builtin.h"
       #include "abspath.h"
       #include "gettext.h"
     +@@
     + #include "strvec.h"
     + #include "parse-options.h"
     + #include "pkt-line.h"
     +-#include "repository.h"
     + #include "bundle.h"
     + 
     + /*
      
       ## builtin/cat-file.c ##
      @@
     @@ builtin/cat-file.c
      -
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
       #include "config.h"
       #include "convert.h"
     - #include "diff.h"
      
       ## builtin/check-attr.c ##
      @@
     @@ builtin/check-attr.c
       #include "builtin.h"
       #include "config.h"
       #include "attr.h"
     +@@
     + #include "gettext.h"
     + #include "object-name.h"
     + #include "quote.h"
     +-#include "repository.h"
     + #include "setup.h"
     + #include "parse-options.h"
     + #include "write-or-die.h"
      
       ## builtin/check-ignore.c ##
      @@
     @@ builtin/check-ignore.c
       #include "builtin.h"
       #include "config.h"
       #include "dir.h"
     +@@
     + #include "quote.h"
     + #include "pathspec.h"
     + #include "parse-options.h"
     +-#include "repository.h"
     + #include "submodule.h"
     + #include "write-or-die.h"
     + 
      
       ## builtin/check-mailmap.c ##
      @@
     @@ builtin/checkout-index.c
        * Copyright (C) 2005 Linus Torvalds
        *
        */
     +-
      +#define USE_THE_REPOSITORY_VARIABLE
     - 
       #include "builtin.h"
       #include "config.h"
     + #include "gettext.h"
     + #include "lockfile.h"
     + #include "quote.h"
     +-#include "repository.h"
     + #include "cache-tree.h"
     + #include "parse-options.h"
     + #include "entry.h"
      
       ## builtin/checkout.c ##
      @@
     @@ builtin/clean.c
       #include "builtin.h"
       #include "abspath.h"
       #include "config.h"
     +@@
     + #include "parse-options.h"
     + #include "path.h"
     + #include "read-cache-ll.h"
     +-#include "repository.h"
     + #include "setup.h"
     + #include "string-list.h"
     + #include "quote.h"
      
       ## builtin/clone.c ##
      @@
     @@ builtin/clone.c
      -
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
     ++
       #include "abspath.h"
       #include "advice.h"
       #include "config.h"
     @@ builtin/clone.c
       ## builtin/column.c ##
      @@
      +#define USE_THE_REPOSITORY_VARIABLE
     -+
       #include "builtin.h"
       #include "config.h"
       #include "gettext.h"
     @@ builtin/commit-graph.c
       #include "builtin.h"
       #include "commit.h"
       #include "config.h"
     +@@
     + #include "gettext.h"
     + #include "hex.h"
     + #include "parse-options.h"
     +-#include "repository.h"
     + #include "commit-graph.h"
     + #include "object-store-ll.h"
     + #include "progress.h"
      
       ## builtin/commit-tree.c ##
      @@
     @@ builtin/commit-tree.c
       #include "builtin.h"
       #include "config.h"
       #include "gettext.h"
     + #include "hex.h"
     + #include "object-name.h"
     + #include "object-store-ll.h"
     +-#include "repository.h"
     ++
     + #include "commit.h"
     + #include "parse-options.h"
     + 
      
       ## builtin/commit.c ##
      @@
     @@ builtin/commit.c
      -
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
       #include "advice.h"
       #include "config.h"
     - #include "lockfile.h"
      
       ## builtin/config.c ##
      @@
     @@ builtin/config.c
       #include "builtin.h"
       #include "abspath.h"
       #include "config.h"
     + #include "color.h"
     + #include "editor.h"
     + #include "environment.h"
     +-#include "repository.h"
     + #include "gettext.h"
     + #include "ident.h"
     + #include "parse-options.h"
      
       ## builtin/count-objects.c ##
      @@
     @@ builtin/count-objects.c
       #include "builtin.h"
       #include "config.h"
       #include "dir.h"
     + #include "environment.h"
     + #include "gettext.h"
     + #include "path.h"
     +-#include "repository.h"
     + #include "parse-options.h"
     + #include "quote.h"
     + #include "packfile.h"
      
       ## builtin/credential-cache--daemon.c ##
      @@
     @@ builtin/diff-files.c
       #include "builtin.h"
       #include "config.h"
       #include "diff.h"
     + #include "diff-merges.h"
     + #include "commit.h"
     + #include "preload-index.h"
     +-#include "repository.h"
     + #include "revision.h"
     + 
     + static const char diff_files_usage[] =
      
       ## builtin/diff-index.c ##
      @@
     @@ builtin/diff-index.c
       #include "builtin.h"
       #include "config.h"
       #include "diff.h"
     + #include "diff-merges.h"
     + #include "commit.h"
     + #include "preload-index.h"
     +-#include "repository.h"
     + #include "revision.h"
     + #include "setup.h"
     + 
      
       ## builtin/diff-tree.c ##
      @@
     @@ builtin/diff-tree.c
       #include "builtin.h"
       #include "config.h"
       #include "diff.h"
     +@@
     + #include "hex.h"
     + #include "log-tree.h"
     + #include "read-cache-ll.h"
     +-#include "repository.h"
     + #include "revision.h"
     + #include "tmp-objdir.h"
     + #include "tree.h"
      
       ## builtin/diff.c ##
      @@
     @@ builtin/diff.c
      -
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
       #include "config.h"
       #include "ewah/ewok.h"
     - #include "lockfile.h"
      
       ## builtin/difftool.c ##
      @@
     @@ builtin/difftool.c
      -
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
     ++
       #include "abspath.h"
       #include "config.h"
       #include "copy.h"
     @@ builtin/fast-export.c
        */
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
       #include "config.h"
       #include "gettext.h"
     - #include "hex.h"
      
       ## builtin/fast-import.c ##
      @@
     @@ builtin/fast-import.c
       #include "builtin.h"
       #include "abspath.h"
       #include "environment.h"
     + #include "gettext.h"
     + #include "hex.h"
     +-#include "repository.h"
     + #include "config.h"
     + #include "lockfile.h"
     + #include "object.h"
      
       ## builtin/fetch-pack.c ##
      @@
     @@ builtin/fetch.c
       #include "builtin.h"
       #include "advice.h"
       #include "config.h"
     + #include "gettext.h"
     + #include "environment.h"
     + #include "hex.h"
     +-#include "repository.h"
     + #include "refs.h"
     + #include "refspec.h"
     + #include "object-name.h"
      
       ## builtin/fmt-merge-msg.c ##
      @@
     @@ builtin/for-each-repo.c
       #include "builtin.h"
       #include "config.h"
       #include "gettext.h"
     + #include "parse-options.h"
     + #include "path.h"
     +-#include "repository.h"
     + #include "run-command.h"
     + #include "string-list.h"
     + 
      
       ## builtin/fsck.c ##
      @@
     @@ builtin/fsck.c
       #include "builtin.h"
       #include "gettext.h"
       #include "hex.h"
     +-#include "repository.h"
     + #include "config.h"
     + #include "commit.h"
     + #include "tree.h"
      
       ## builtin/fsmonitor--daemon.c ##
      @@
     @@ builtin/fsmonitor--daemon.c
       #include "builtin.h"
       #include "abspath.h"
       #include "config.h"
     +@@
     + #include "compat/fsmonitor/fsm-health.h"
     + #include "compat/fsmonitor/fsm-listen.h"
     + #include "fsmonitor--daemon.h"
     +-#include "repository.h"
     ++
     + #include "simple-ipc.h"
     + #include "khash.h"
     + #include "run-command.h"
      
       ## builtin/gc.c ##
      @@
     @@ builtin/gc.c
       #include "builtin.h"
       #include "abspath.h"
       #include "date.h"
     + #include "environment.h"
     + #include "hex.h"
     +-#include "repository.h"
     + #include "config.h"
     + #include "tempfile.h"
     + #include "lockfile.h"
      
       ## builtin/grep.c ##
      @@
     @@ builtin/grep.c
       #include "builtin.h"
       #include "abspath.h"
       #include "gettext.h"
     + #include "hex.h"
     +-#include "repository.h"
     + #include "config.h"
     + #include "tag.h"
     + #include "tree-walk.h"
      
       ## builtin/hash-object.c ##
      @@
     @@ builtin/hash-object.c
        */
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
       #include "abspath.h"
       #include "config.h"
     - #include "gettext.h"
      
       ## builtin/help.c ##
      @@
     @@ builtin/index-pack.c
       #include "config.h"
       #include "delta.h"
      
     + ## builtin/init-db.c ##
     +@@
     +  *
     +  * Copyright (C) Linus Torvalds, 2005
     +  */
     ++#define USE_THE_REPOSITORY_VARIABLE
     + #include "builtin.h"
     + #include "abspath.h"
     + #include "environment.h"
     +@@
     + #include "parse-options.h"
     + #include "path.h"
     + #include "refs.h"
     +-#include "repository.h"
     + #include "setup.h"
     + #include "strbuf.h"
     + 
     +
       ## builtin/interpret-trailers.c ##
      @@
        * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
     @@ builtin/log.c
       #include "builtin.h"
       #include "abspath.h"
       #include "config.h"
     +@@
     + #include "mailmap.h"
     + #include "progress.h"
     + #include "commit-slab.h"
     +-#include "repository.h"
     ++
     + #include "commit-reach.h"
     + #include "range-diff.h"
     + #include "tmp-objdir.h"
      
       ## builtin/ls-files.c ##
      @@
     @@ builtin/ls-files.c
        */
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     - #include "repository.h"
     +-#include "repository.h"
       #include "config.h"
     + #include "convert.h"
     + #include "quote.h"
      
       ## builtin/ls-remote.c ##
      @@
     @@ builtin/ls-tree.c
        */
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
     ++
       #include "config.h"
       #include "gettext.h"
       #include "hex.h"
      
     + ## builtin/mailinfo.c ##
     +@@
     +  * Another stupid program, this one parsing the headers of an
     +  * email to figure out authorship and subject
     +  */
     ++#define USE_THE_REPOSITORY_VARIABLE
     + #include "builtin.h"
     + #include "abspath.h"
     + #include "environment.h"
     +
       ## builtin/merge-base.c ##
      @@
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
       #include "config.h"
       #include "commit.h"
     +@@
     + #include "hex.h"
     + #include "object-name.h"
     + #include "parse-options.h"
     +-#include "repository.h"
     + #include "commit-reach.h"
     + 
     + static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
      
       ## builtin/merge-file.c ##
      @@
     @@ builtin/merge-index.c
       #include "builtin.h"
       #include "hex.h"
       #include "read-cache-ll.h"
     +-#include "repository.h"
     + #include "run-command.h"
     + #include "sparse-index.h"
     + 
      
       ## builtin/merge-ours.c ##
      @@
     @@ builtin/merge-ours.c
       #include "git-compat-util.h"
       #include "builtin.h"
       #include "diff.h"
     +-#include "repository.h"
     ++
     + 
     + static const char builtin_merge_ours_usage[] =
     + 	"git merge-ours <base>... -- HEAD <remote>...";
      
       ## builtin/merge-recursive.c ##
      @@
     @@ builtin/merge-recursive.c
       #include "builtin.h"
       #include "advice.h"
       #include "gettext.h"
     + #include "hash.h"
     + #include "merge-recursive.h"
     + #include "object-name.h"
     +-#include "repository.h"
     + 
     + static const char builtin_merge_recursive_usage[] =
     + 	"git %s <base>... -- <head> <remote> ...";
      
       ## builtin/merge-tree.c ##
      @@
     @@ builtin/merge-tree.c
       #include "builtin.h"
       #include "tree-walk.h"
       #include "xdiff-interface.h"
     +@@
     + #include "object-name.h"
     + #include "object-store-ll.h"
     + #include "parse-options.h"
     +-#include "repository.h"
     + #include "blob.h"
     + #include "merge-blobs.h"
     + #include "quote.h"
      
       ## builtin/merge.c ##
      @@
     @@ builtin/merge.c
      -
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
     ++
       #include "abspath.h"
       #include "advice.h"
       #include "config.h"
     @@ builtin/mktree.c
        */
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
       #include "gettext.h"
       #include "hex.h"
     - #include "quote.h"
      
       ## builtin/multi-pack-index.c ##
      @@
     @@ builtin/mv.c
       
       #include "builtin.h"
       #include "abspath.h"
     +@@
     + #include "string-list.h"
     + #include "parse-options.h"
     + #include "read-cache-ll.h"
     +-#include "repository.h"
     ++
     + #include "setup.h"
     + #include "strvec.h"
     + #include "submodule.h"
      
       ## builtin/name-rev.c ##
      @@
     @@ builtin/name-rev.c
       #include "builtin.h"
       #include "environment.h"
       #include "gettext.h"
     + #include "hex.h"
     +-#include "repository.h"
     + #include "config.h"
     + #include "commit.h"
     + #include "tag.h"
      
       ## builtin/notes.c ##
      @@
     @@ builtin/notes.c
       #include "builtin.h"
       #include "config.h"
       #include "editor.h"
     +@@
     + #include "object-name.h"
     + #include "object-store-ll.h"
     + #include "path.h"
     +-#include "repository.h"
     ++
     + #include "pretty.h"
     + #include "refs.h"
     + #include "exec-cmd.h"
      
       ## builtin/pack-objects.c ##
      @@
     @@ builtin/pack-objects.c
       #include "builtin.h"
       #include "environment.h"
       #include "gettext.h"
     + #include "hex.h"
     +-#include "repository.h"
     + #include "config.h"
     + #include "attr.h"
     + #include "object.h"
      
       ## builtin/pack-redundant.c ##
      @@
     @@ builtin/pack-redundant.c
       
       #include "builtin.h"
       #include "gettext.h"
     + #include "hex.h"
     +-#include "repository.h"
     ++
     + #include "packfile.h"
     + #include "object-store-ll.h"
     + 
      
       ## builtin/pack-refs.c ##
      @@
     @@ builtin/pack-refs.c
       #include "builtin.h"
       #include "config.h"
       #include "gettext.h"
     + #include "parse-options.h"
     + #include "refs.h"
     +-#include "repository.h"
     + #include "revision.h"
     + 
     + static char const * const pack_refs_usage[] = {
      
       ## builtin/patch-id.c ##
      @@
     @@ builtin/push.c
       #include "builtin.h"
       #include "advice.h"
       #include "branch.h"
     +@@
     + #include "transport.h"
     + #include "parse-options.h"
     + #include "pkt-line.h"
     +-#include "repository.h"
     + #include "submodule.h"
     + #include "submodule-config.h"
     + #include "send-pack.h"
      
       ## builtin/range-diff.c ##
      @@
     @@ builtin/range-diff.c
       #include "builtin.h"
       #include "gettext.h"
       #include "object-name.h"
     + #include "parse-options.h"
     + #include "range-diff.h"
     + #include "config.h"
     +-#include "repository.h"
     ++
     + 
     + static const char * const builtin_range_diff_usage[] = {
     + N_("git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
      
       ## builtin/read-tree.c ##
      @@
     @@ builtin/read-tree.c
       #include "builtin.h"
       #include "config.h"
       #include "gettext.h"
     +@@
     + #include "cache-tree.h"
     + #include "unpack-trees.h"
     + #include "parse-options.h"
     +-#include "repository.h"
     + #include "resolve-undo.h"
     + #include "setup.h"
     + #include "sparse-index.h"
      
       ## builtin/rebase.c ##
      @@
     @@ builtin/rebase.c
      -
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
     ++
       #include "abspath.h"
       #include "environment.h"
       #include "gettext.h"
     @@ builtin/receive-pack.c
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
       #include "abspath.h"
     - #include "repository.h"
     +-#include "repository.h"
     ++
     + #include "config.h"
     + #include "environment.h"
     + #include "gettext.h"
      
       ## builtin/reflog.c ##
      @@
     @@ builtin/reflog.c
       #include "builtin.h"
       #include "config.h"
       #include "gettext.h"
     +-#include "repository.h"
     + #include "revision.h"
     + #include "reachable.h"
     + #include "wildmatch.h"
      
       ## builtin/refs.c ##
      @@
     @@ builtin/refs.c
       #include "builtin.h"
       #include "config.h"
       #include "fsck.h"
     + #include "parse-options.h"
     + #include "refs.h"
     +-#include "repository.h"
     + #include "strbuf.h"
     + 
     + #define REFS_MIGRATE_USAGE \
      
       ## builtin/remote.c ##
      @@
     @@ builtin/replace.c
        * and Carlos Rica <jasampler@gmail.com> that was itself based on
        * git-tag.sh and mktag.c by Linus Torvalds.
        */
     +-
      +#define USE_THE_REPOSITORY_VARIABLE
     - 
       #include "builtin.h"
       #include "config.h"
     + #include "editor.h"
     +@@
     + #include "object-name.h"
     + #include "object-store-ll.h"
     + #include "replace-object.h"
     +-#include "repository.h"
     + #include "tag.h"
     + #include "wildmatch.h"
     + 
      
       ## builtin/replay.c ##
      @@
     @@ builtin/rerere.c
       #include "builtin.h"
       #include "config.h"
       #include "gettext.h"
     + #include "parse-options.h"
     +-#include "repository.h"
     ++
     + #include "string-list.h"
     + #include "rerere.h"
     + #include "xdiff/xdiff.h"
      
       ## builtin/reset.c ##
      @@
     @@ builtin/reset.c
      -
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
       #include "advice.h"
       #include "config.h"
     - #include "environment.h"
      
       ## builtin/rev-list.c ##
      @@
     @@ builtin/rev-parse.c
      -
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
     ++
       #include "abspath.h"
       #include "config.h"
       #include "commit.h"
     @@ builtin/revert.c
       #include "git-compat-util.h"
       #include "builtin.h"
       #include "parse-options.h"
     + #include "diff.h"
     + #include "gettext.h"
     +-#include "repository.h"
     + #include "revision.h"
     + #include "rerere.h"
     + #include "sequencer.h"
      
       ## builtin/rm.c ##
      @@
     @@ builtin/rm.c
       #include "builtin.h"
       #include "advice.h"
       #include "config.h"
     +@@
     + #include "object-name.h"
     + #include "parse-options.h"
     + #include "read-cache.h"
     +-#include "repository.h"
     ++
     + #include "string-list.h"
     + #include "setup.h"
     + #include "sparse-index.h"
      
       ## builtin/send-pack.c ##
      @@
     @@ builtin/shortlog.c
       #include "builtin.h"
       #include "config.h"
       #include "commit.h"
     +@@
     + #include "environment.h"
     + #include "gettext.h"
     + #include "string-list.h"
     +-#include "repository.h"
     + #include "revision.h"
     + #include "utf8.h"
     + #include "mailmap.h"
      
       ## builtin/show-branch.c ##
      @@
     @@ builtin/show-branch.c
       #include "builtin.h"
       #include "config.h"
       #include "environment.h"
     +@@
     + #include "strvec.h"
     + #include "object-name.h"
     + #include "parse-options.h"
     +-#include "repository.h"
     ++
     + #include "dir.h"
     + #include "commit-slab.h"
     + #include "date.h"
      
       ## builtin/show-index.c ##
      @@
     @@ builtin/show-index.c
       #include "builtin.h"
       #include "gettext.h"
       #include "hash.h"
     + #include "hex.h"
     + #include "pack.h"
     + #include "parse-options.h"
     +-#include "repository.h"
     + 
     + static const char *const show_index_usage[] = {
     + 	"git show-index [--object-format=<hash-algorithm>]",
      
       ## builtin/show-ref.c ##
      @@
     @@ builtin/sparse-checkout.c
       #include "builtin.h"
       #include "config.h"
       #include "dir.h"
     +@@
     + #include "object-name.h"
     + #include "parse-options.h"
     + #include "pathspec.h"
     +-#include "repository.h"
     + #include "strbuf.h"
     + #include "string-list.h"
     + #include "lockfile.h"
      
       ## builtin/stash.c ##
      @@
     @@ builtin/submodule--helper.c
       #include "builtin.h"
       #include "abspath.h"
       #include "environment.h"
     + #include "gettext.h"
     + #include "hex.h"
     +-#include "repository.h"
     ++
     + #include "config.h"
     + #include "parse-options.h"
     + #include "quote.h"
      
       ## builtin/symbolic-ref.c ##
      @@
     @@ builtin/tag.c
      -
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
       #include "advice.h"
       #include "config.h"
     - #include "editor.h"
      
       ## builtin/unpack-file.c ##
      @@
     @@ builtin/update-index.c
        *
        * Copyright (C) Linus Torvalds, 2005
        */
     +-
      +#define USE_THE_REPOSITORY_VARIABLE
     - 
       #include "builtin.h"
       #include "bulk-checkin.h"
     + #include "config.h"
     +@@
     + #include "pathspec.h"
     + #include "dir.h"
     + #include "read-cache.h"
     +-#include "repository.h"
     + #include "setup.h"
     + #include "sparse-index.h"
     + #include "split-index.h"
      
       ## builtin/update-ref.c ##
      @@
     @@ builtin/update-ref.c
       #include "builtin.h"
       #include "config.h"
       #include "gettext.h"
     +@@
     + #include "object-name.h"
     + #include "parse-options.h"
     + #include "quote.h"
     +-#include "repository.h"
     + 
     + static const char * const git_update_ref_usage[] = {
     + 	N_("git update-ref [<options>] -d <refname> [<old-oid>]"),
      
       ## builtin/update-server-info.c ##
      @@
     @@ builtin/upload-archive.c
       #include "builtin.h"
       #include "archive.h"
       #include "path.h"
     + #include "pkt-line.h"
     + #include "sideband.h"
     +-#include "repository.h"
     + #include "run-command.h"
     + #include "strvec.h"
     + 
      
       ## builtin/var.c ##
      @@
     @@ builtin/var.c
        */
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
     ++
       #include "attr.h"
       #include "config.h"
       #include "editor.h"
     @@ builtin/verify-commit.c
       #include "builtin.h"
       #include "config.h"
       #include "gettext.h"
     + #include "object-name.h"
     +-#include "repository.h"
     + #include "commit.h"
     + #include "parse-options.h"
     + #include "gpg-interface.h"
      
       ## builtin/verify-pack.c ##
      @@
     @@ builtin/verify-tag.c
        */
      +#define USE_THE_REPOSITORY_VARIABLE
       #include "builtin.h"
     -+#include "repository.h"
       #include "config.h"
       #include "gettext.h"
     - #include "tag.h"
      
       ## builtin/worktree.c ##
      @@
     @@ builtin/worktree.c
       #include "builtin.h"
       #include "abspath.h"
       #include "advice.h"
     +@@
     + #include "read-cache-ll.h"
     + #include "refs.h"
     + #include "remote.h"
     +-#include "repository.h"
     + #include "run-command.h"
     + #include "hook.h"
     + #include "sigchain.h"
      
       ## builtin/write-tree.c ##
      @@
     @@ builtin/write-tree.c
       #include "builtin.h"
       #include "config.h"
       #include "environment.h"
     +@@
     + #include "tree.h"
     + #include "cache-tree.h"
     + #include "parse-options.h"
     +-#include "repository.h"
     + 
     + static const char * const write_tree_usage[] = {
     + 	N_("git write-tree [--missing-ok] [--prefix=<prefix>/]"),
 3:  bc909046934 ! 3:  6956d3fe897 add: pass in repo variable instead of global the_repository
     @@ Commit message
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## builtin/add.c ##
     +@@
     +  *
     +  * Copyright (C) 2006 Linus Torvalds
     +  */
     +-#define USE_THE_REPOSITORY_VARIABLE
     + #include "builtin.h"
     + #include "advice.h"
     + #include "config.h"
      @@ builtin/add.c: static int pathspec_file_nul;
       static int include_sparse;
       static const char *pathspec_from_file;
       
      -static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
     -+static int chmod_pathspec(struct pathspec *pathspec,
     ++static int chmod_pathspec(struct repository *repo,
     ++			  struct pathspec *pathspec,
      +			  char flip,
     -+			  int show_only,
     -+			  struct repository *repo)
     ++			  int show_only)
       {
       	int i, ret = 0;
       
     @@ builtin/add.c: static int chmod_pathspec(struct pathspec *pathspec, char flip, i
       }
       
      -static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
     -+static int renormalize_tracked_files(const struct pathspec *pathspec, int flags, struct repository *repo)
     ++static int renormalize_tracked_files(struct repository *repo,
     ++				     const struct pathspec *pathspec,
     ++				     int flags)
       {
       	int i, retval = 0;
       
     @@ builtin/add.c: static int chmod_pathspec(struct pathspec *pathspec, char flip, i
       }
       
      -static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec, int prefix)
     -+static char *prune_directory(struct dir_struct *dir, struct pathspec *pathspec, int prefix, struct repository *repo)
     ++static char *prune_directory(struct repository *repo,
     ++			     struct dir_struct *dir,
     ++			     struct pathspec *pathspec,
     ++			     int prefix)
       {
       	char *seen;
       	int i;
     @@ builtin/add.c: static char *prune_directory(struct dir_struct *dir, struct paths
       }
       
      -static int refresh(int verbose, const struct pathspec *pathspec)
     -+static int refresh(int verbose, const struct pathspec *pathspec, struct repository *repo)
     ++static int refresh(struct repository *repo, int verbose, const struct pathspec *pathspec)
       {
       	char *seen;
       	int i, ret = 0;
     @@ builtin/add.c: static int refresh(int verbose, const struct pathspec *pathspec)
       }
       
      -int interactive_add(const char **argv, const char *prefix, int patch)
     -+int interactive_add(const char **argv, const char *prefix, int patch, struct repository *repo)
     ++int interactive_add(struct repository *repo,
     ++		    const char **argv,
     ++		    const char *prefix,
     ++		    int patch)
       {
       	struct pathspec pathspec;
       	int ret;
     @@ builtin/add.c: int interactive_add(const char **argv, const char *prefix, int pa
       	return ret;
       }
       
     --static int edit_patch(int argc, const char **argv, const char *prefix)
     -+static int edit_patch(int argc, const char **argv, const char *prefix, struct repository *repo)
     +-static int edit_patch(int argc,
     ++static int edit_patch(struct repository *repo,
     ++		      int argc,
     + 		      const char **argv,
     +-		      const char *prefix,
     +-		      struct repository *repo UNUSED)
     ++		      const char *prefix)
       {
     - 	char *file = git_pathdup("ADD_EDIT.patch");
     +-	char *file = git_pathdup("ADD_EDIT.patch");
     ++	char *file = repo_git_path(repo, "ADD_EDIT.patch");
       	struct child_process child = CHILD_PROCESS_INIT;
     -@@ builtin/add.c: static int edit_patch(int argc, const char **argv, const char *prefix)
     + 	struct rev_info rev;
     + 	int out;
     + 	struct stat st;
       
     - 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
     +-	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
     ++	repo_config(repo, git_diff_basic_config, NULL);
       
      -	if (repo_read_index(the_repository) < 0)
      +	if (repo_read_index(repo) < 0)
     @@ builtin/add.c: static void check_embedded_repo(const char *path)
       }
       
      -static int add_files(struct dir_struct *dir, int flags)
     -+static int add_files(struct dir_struct *dir, int flags, struct repository *repo)
     ++static int add_files(struct repository *repo, struct dir_struct *dir, int flags)
       {
       	int i, exit_status = 0;
       	struct string_list matched_sparse_paths = STRING_LIST_INIT_NODUP;
     @@ builtin/add.c: static int add_files(struct dir_struct *dir, int flags)
       				die(_("adding files failed"));
       			exit_status = 1;
      @@ builtin/add.c: static int add_files(struct dir_struct *dir, int flags)
     - 	return exit_status;
     - }
     - 
     --int cmd_add(int argc, const char **argv, const char *prefix, struct repository *repository UNUSED)
     -+int cmd_add(int argc, const char **argv, const char *prefix, struct repository *repo)
     + int cmd_add(int argc,
     + 	    const char **argv,
     + 	    const char *prefix,
     +-	    struct repository *repo UNUSED)
     ++	    struct repository *repo)
       {
       	int exit_status = 0;
       	struct pathspec pathspec;
     -@@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
     +@@ builtin/add.c: int cmd_add(int argc,
     + 	char *ps_matched = NULL;
     + 	struct lock_file lock_file = LOCK_INIT;
     + 
     +-	git_config(add_config, NULL);
     ++	repo_config(repo, add_config, NULL);
     + 
     + 	argc = parse_options(argc, argv, prefix, builtin_add_options,
     + 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
     +@@ builtin/add.c: int cmd_add(int argc,
       			die(_("options '%s' and '%s' cannot be used together"), "--dry-run", "--interactive/--patch");
       		if (pathspec_from_file)
       			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
      -		exit(interactive_add(argv + 1, prefix, patch_interactive));
     -+		exit(interactive_add(argv + 1, prefix, patch_interactive, repo));
     ++		exit(interactive_add(repo, argv + 1, prefix, patch_interactive));
       	}
       
       	if (edit_interactive) {
       		if (pathspec_from_file)
       			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--edit");
     --		return(edit_patch(argc, argv, prefix));
     -+		return(edit_patch(argc, argv, prefix, repo));
     +-		return(edit_patch(argc, argv, prefix, the_repository));
     ++		return(edit_patch(repo, argc, argv, prefix));
       	}
       	argc--;
       	argv++;
     -@@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
     +@@ builtin/add.c: int cmd_add(int argc,
       	add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
       	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
       
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, stru
       
       	/*
       	 * Check the "pathspec '%s' did not match any files" block
     -@@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
     +@@ builtin/add.c: int cmd_add(int argc,
       		 (!(addremove || take_worktree_changes)
       		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
       
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, stru
       
       	if (add_new_files) {
       		int baselen;
     -@@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
     +@@ builtin/add.c: int cmd_add(int argc,
       		}
       
       		/* This picks up the paths that are not tracked */
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, stru
      +		baselen = fill_directory(&dir, repo->index, &pathspec);
       		if (pathspec.nr)
      -			seen = prune_directory(&dir, &pathspec, baselen);
     -+			seen = prune_directory(&dir, &pathspec, baselen, repo);
     ++			seen = prune_directory(repo, &dir, &pathspec, baselen);
       	}
       
       	if (refresh_only) {
      -		exit_status |= refresh(verbose, &pathspec);
     -+		exit_status |= refresh(verbose, &pathspec, repo);
     ++		exit_status |= refresh(repo, verbose, &pathspec);
       		goto finish;
       	}
       
     -@@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
     +@@ builtin/add.c: int cmd_add(int argc,
       
       		if (!seen)
       			seen = find_pathspecs_matching_against_index(&pathspec,
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, stru
       
       		/*
       		 * file_exists() assumes exact match
     -@@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
     +@@ builtin/add.c: int cmd_add(int argc,
       			    !file_exists(path)) {
       				if (ignore_missing) {
       					int dtype = DT_UNKNOWN;
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, stru
       								path, pathspec.items[i].len);
       				} else
       					die(_("pathspec '%s' did not match any files"),
     -@@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
     +@@ builtin/add.c: int cmd_add(int argc,
       
       	ps_matched = xcalloc(pathspec.nr, 1);
       	if (add_renormalize)
      -		exit_status |= renormalize_tracked_files(&pathspec, flags);
     -+		exit_status |= renormalize_tracked_files(&pathspec, flags, repo);
     ++		exit_status |= renormalize_tracked_files(repo, &pathspec, flags);
       	else
      -		exit_status |= add_files_to_cache(the_repository, prefix,
      +		exit_status |= add_files_to_cache(repo, prefix,
       						  &pathspec, ps_matched,
       						  include_sparse, flags);
       
     -@@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix, struct repository *
     +@@ builtin/add.c: int cmd_add(int argc,
       		exit(128);
       
       	if (add_new_files)
      -		exit_status |= add_files(&dir, flags);
     -+		exit_status |= add_files(&dir, flags, repo);
     ++		exit_status |= add_files(repo, &dir, flags);
       
       	if (chmod_arg && pathspec.nr)
      -		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
     -+		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only, repo);
     ++		exit_status |= chmod_pathspec(repo, &pathspec, chmod_arg[0], show_only);
       	end_odb_transaction();
       
       finish:
     @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char
       		setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
       
      -		if (interactive_add(argv, prefix, patch_interactive) != 0)
     -+		if (interactive_add(argv, prefix, patch_interactive, the_repository) != 0)
     ++		if (interactive_add(the_repository, argv, prefix, patch_interactive) != 0)
       			die(_("interactive add failed"));
       
       		the_repository->index_file = old_repo_index_file;
      
       ## commit.h ##
     -@@
     - #define COMMIT_H
     - 
     - #include "object.h"
     -+#include "repository.h"
     - 
     - struct signature_check;
     - struct strbuf;
      @@ commit.h: struct oid_array;
       struct ref;
       int for_each_commit_graft(each_commit_graft_fn, void *);
       
      -int interactive_add(const char **argv, const char *prefix, int patch);
     -+int interactive_add(const char **argv, const char *prefix, int patch, struct repository *repo);
     ++int interactive_add(struct repository *repo,
     ++		    const char **argv,
     ++		    const char *prefix,
     ++		    int patch);
       
       struct commit_extra_header {
       	struct commit_extra_header *next;

-- 
gitgitgadget

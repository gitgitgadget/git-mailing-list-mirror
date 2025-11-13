Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0184B2FC861
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057438; cv=none; b=BCwollFUVJisWK1eXyQCasS8yc2YhsNe7X+uq5QJDm8hOpFioUWIwvtIBleDu4XGr6eU8BuWPtPTmnLSojPIX6myR3QEyvVvYnLzZUEKh37AfyaCcndUml7hLmOlz5Ywl/zZTPe/7dxHBFHipCxzJTQZjqc1LOKR1TpI4bMYKkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057438; c=relaxed/simple;
	bh=wY2zolmMoSDh1N2UaC6D3ugwYd66BrNGPd2niVWpu4o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eWSIn9pbGj9TM07skwxagGxXj+q9AO449bsP4vfPZdYCLXuPv9//BvIYV2WqG4FbCw3MMf24CgHIG3NnRXcLvuJrtfEI2HZLVoRh6KySLjqmuqf7fgm4VYxgl5VMW1glntcoboWaqjKKUQpHMjv3pf2R4ERD/uQQjOGpD1JcI0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7IpciXC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7IpciXC"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29844c68068so9991045ad.2
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763057435; x=1763662235; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlx1/3hWN1E+2xeFamL0BsPYXj2PYzusMt2TKTPKMqE=;
        b=R7IpciXC8hZTXHEcu9zjE1pAV5rqANtjuhINl280GhgQe5gmJTLJS4QZEoXrSB2Nr+
         5ao0Hti77QQLp+fYj3jdMCbTBXdwWZ+Y2rN5MdEKT0SsvAgFaj+1kct2AcJgsCIdFrUo
         +qWuoQiAA2Lolqa3JnAg2cvipBx7+c7BrwLwHN5QZKEIuDwlwnCtCAHSErOxWg2Emwy3
         R5TXGiVi87cZMXz9ng8TDg430XxlRf8IC4hO8JZ+Hb/wE2XNbYdyk6PyHhpzGIlmlr8w
         owxizwAf/HEy5MA6zjHmXeNJnVtkJcF/MCVCdULXBBjMwsGCQj9PZZOY5xpjD1j/y5Uy
         jDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057435; x=1763662235;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nlx1/3hWN1E+2xeFamL0BsPYXj2PYzusMt2TKTPKMqE=;
        b=W3gVhBSUc7P2Za/XS20XFrZfp1MVeqFlGvuOBY5wxtbD4ylcq4ecykamhEoyvs3OSf
         MqlJS8OyFz2JREIfWBUZrI0Us+j0E1sidpYunLPE2LBiwKcZ/HtTyWeor/yqYn61RR4v
         zFNgKkrdmrnSlkVcOTgSGg1Bw61gpHHwRb/zNIGWsUO3pYDHLEzHMwYnoU8WMD3rxVno
         KLR3IFFnIdkshB/zyyBqJopcgXF0/YgPc4WZo9pJH34BQQHi9MuaVwA3wdXvxu95OmAX
         nU/xD00YUj3HVtrC7viqeQ/VI2vqvO1LJrverfu3ISGGIyhF0zpR8vlcHIZoJpl8iAkx
         4a8A==
X-Gm-Message-State: AOJu0Yx9yG6LIxdfsdNPc/wGPsl0jwOJseRDwYgZjISZS8wH6MCoNpFR
	IVefQLoVubfEVZJQkI1AYr8BzXClLdA+CLe85mnHX4+Mh2H5JEiXoF1ivxp1Qg==
X-Gm-Gg: ASbGncsgjc4uy4Kukd5GKLoQoEGufiBDuNMRmu56c+m+/86qvGlwNje5UlEHRFNfNX1
	/TIk7NWgXuf4P0uzUNegkXNE/YvjoZvufMTZP6FskN2cF+VTDNY7YF7z40K1qvh2nZ49Mw8VbPU
	LrE3JqNYD7V2ZWqsKnCS1LsVyutOkVCE5eZ1ogqqfywDoXhEG72IMJ4z+73zJpnSOFo9bMGal+Q
	yrnHyO+iVFDDfKpzOWwFQAGjKMJA2LQVgrWbzKg4DCwEtPxGDtz6+ZtwrXgZ+gBk42f98uVinIT
	2I0SUEGCLtPjdbwql5F7KWKGXZLBzQgfzx2HxqyUIUjFcLDD23vbKxyeBO7C0C41U3G3+EmeSgt
	LNAe4XJlgdh4HLww8uWWrkaTf28LHE5D0kUJ+Mhyvz97Y9q+16/iwW3dlZt3So/EC/JxfYshewi
	rXwuMm25i+RBLm
X-Google-Smtp-Source: AGHT+IEaRYVgOY6tfloprntted6AsINq+Kiyc9iHs0+PpeaGD1wTIZhlxKuRvoyu7WjNfmOsx0++aA==
X-Received: by 2002:a17:903:28c:b0:294:f70d:5e33 with SMTP id d9443c01a7336-2984ed281b2mr115325705ad.12.1763057434541;
        Thu, 13 Nov 2025 10:10:34 -0800 (PST)
Received: from [127.0.0.1] ([104.209.7.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccb60sm31556445ad.104.2025.11.13.10.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:10:33 -0800 (PST)
Message-Id: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
From: "Claus Schneider via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Nov 2025 18:10:28 +0000
Subject: [PATCH v2 0/5] git-add : Respect submodule ignore=all and only add changes with --force
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bmwill@google.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Claus Schneider <claus.schneider@eficode.com>

The feature of configuring a submodule to "ignore=all" is nicely respected
in commands "status" and "diff". However the "add" command does not respect
the configuration the same way. The behavior is problematic for the logic
between status/diff and add. Secondly it makes it problematic to track
branches in the submodule configuration as developers unintentionally keeps
add submodule updates and get conflicts for no intentional reason. Both adds
unnecessary friction to the usage of submodules.

The patches implement the same logical behavior for ignore=all submodules as
regular ignored files. The status now does not show any diff - nor will the
add command update the reference submodule reference. If you add the
submodule path which is ignore=all then you are presented with a message
that you need to use the --force option. The branch=, ignore=all (and
update=none) now works great with update --remote, but developers does not
have to consider changes in the updates of the submodule sha1. The
implementation removes a friction of working with submodules and can be used
like the repo tool with branches configured. The submodule status report
could be used for build/release documentation for reproduction of a setup.

A few tests used the adding of submodules without --force, hence they have
been updated to use the --force option.

Claus Schneider(Eficode) (5):
  read-cache: update add_files_to_cache take param
    include_ignored_submodules
  read-cache: add/read-cache respect submodule ignore=all
  tests: add new t2206-add-submodule-ignored.sh to test ignore=all
    scenario
  tests: fix existing tests when add an ignore=all submodule
  Documentation: add --include_ignored_submodules + ignore=all config

 .devcontainer/Dockerfile            |  70 +++++++++++++++
 .devcontainer/Dockerfile.standalone |  76 ++++++++++++++++
 .devcontainer/devcontainer.json     |  25 ++++++
 Documentation/config/submodule.adoc |  13 +--
 Documentation/git-add.adoc          |   5 ++
 Documentation/gitmodules.adoc       |   5 +-
 builtin/add.c                       |   4 +-
 builtin/checkout.c                  |   2 +-
 builtin/commit.c                    |   2 +-
 read-cache-ll.h                     |   2 +-
 read-cache.c                        |  54 ++++++++++-
 t/lib-submodule-update.sh           |   6 +-
 t/meson.build                       |   1 +
 t/t2206-add-submodule-ignored.sh    | 134 ++++++++++++++++++++++++++++
 t/t7508-status.sh                   |   2 +-
 15 files changed, 384 insertions(+), 17 deletions(-)
 create mode 100644 .devcontainer/Dockerfile
 create mode 100644 .devcontainer/Dockerfile.standalone
 create mode 100644 .devcontainer/devcontainer.json
 create mode 100755 t/t2206-add-submodule-ignored.sh


base-commit: 81f86aacc4eb74cdb9c2c8082d36d2070c666045
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1987%2FPraqma%2Frespect-submodule-ignore-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1987/Praqma/respect-submodule-ignore-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1987

Range-diff vs v1:

 1:  d98cca698d ! 1:  5796009122 read-cache: update add_files_to_cache to take param ignored_too(--force)
     @@ Metadata
      Author: Claus Schneider(Eficode) <claus.schneider@eficode.com>
      
       ## Commit message ##
     -    read-cache: update add_files_to_cache to take param ignored_too(--force)
     +    read-cache: update add_files_to_cache take param include_ignored_submodules
      
     -    The ignored_too parameter is added to the function add_files_to_cache for
     -    usage of explicit updating the index for the updated submodule using the
     -    explicit patchspec to the submodule.
     +    The include_ignored_submodules parameter is added to the function
     +    add_files_to_cache for usage of explicit updating the index for the updated
     +    submodule using the explicit patchspec to the submodule.
      
          Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
      
       ## builtin/add.c ##
     +@@ builtin/add.c: N_("The following paths are ignored by one of your .gitignore files:\n");
     + static int verbose, show_only, ignored_too, refresh_only;
     + static int ignore_add_errors, intent_to_add, ignore_missing;
     + static int warn_on_embedded_repo = 1;
     ++static int include_ignored_submodules;
     + 
     + #define ADDREMOVE_DEFAULT 1
     + static int addremove = ADDREMOVE_DEFAULT;
     +@@ builtin/add.c: static struct option builtin_add_options[] = {
     + 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
     + 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
     + 	OPT_BOOL(0, "sparse", &include_sparse, N_("allow updating entries outside of the sparse-checkout cone")),
     ++    OPT_BOOL(0, "include-ignored-submodules", &include_ignored_submodules, N_("add submodules even if they has configuration ignore=all")),
     + 	OPT_STRING(0, "chmod", &chmod_arg, "(+|-)x",
     + 		   N_("override the executable bit of the listed files")),
     + 	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
      @@ builtin/add.c: int cmd_add(int argc,
       	else
       		exit_status |= add_files_to_cache(repo, prefix,
       						  &pathspec, ps_matched,
      -						  include_sparse, flags);
     -+						  include_sparse, flags, ignored_too);
     ++						  include_sparse, flags, include_ignored_submodules);
       
       	if (take_worktree_changes && !add_renormalize && !ignore_add_errors &&
       	    report_path_error(ps_matched, &pathspec))
     @@ read-cache.c: void overlay_tree_on_index(struct index_state *istate,
       	int include_sparse;
       	int flags;
       	int add_errors;
     -+	int ignored_too;
     ++	int include_ignored_submodules;
       };
       
       static int fix_unmerged_status(struct diff_filepair *p,
      @@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
     + 		default:
     + 			die(_("unexpected diff status %c"), p->status);
     + 		case DIFF_STATUS_MODIFIED:
     +-		case DIFF_STATUS_TYPE_CHANGED:
     ++		case DIFF_STATUS_TYPE_CHANGED: {
     ++			struct stat st;
     ++			if (!lstat(path, &st) && S_ISDIR(st.st_mode)) { // only consider submodule if it is a directory
     ++				const struct submodule *sub = submodule_from_path(data->repo, null_oid(the_hash_algo), path);
     ++				if (sub && sub->name && sub->ignore && !strcmp(sub->ignore, "all")) {
     ++					int pathspec_matches = 0;
     ++					char *norm_pathspec = NULL;
     ++					int ps_i;
     ++					trace_printf("ignore=all %s\n", path);
     ++					trace_printf("pathspec %s\n",
     ++							(data->pathspec && data->pathspec->nr) ? "has pathspec" : "no pathspec");
     ++					/* Safely scan all pathspec items (q->nr may exceed pathspec->nr). */
     ++					if (data->pathspec) {
     ++						for (ps_i = 0; ps_i < data->pathspec->nr; ps_i++) {
     ++							const char *m = data->pathspec->items[ps_i].match;
     ++							if (!m)
     ++								continue;
     ++							norm_pathspec = xstrdup(m);
     ++							strip_dir_trailing_slashes(norm_pathspec);
     ++							if (!strcmp(path, norm_pathspec)) {
     ++								pathspec_matches = 1;
     ++								FREE_AND_NULL(norm_pathspec);
     ++								break;
     ++							}
     ++							FREE_AND_NULL(norm_pathspec);
     ++						}
     ++					}
     ++					if (pathspec_matches) {
     ++						if (data->include_ignored_submodules && data->include_ignored_submodules > 0) {
     ++							trace_printf("Add ignored=all submodule due to --include_ignored_submodules: %s\n", path);
     ++						} else {
     ++							printf(_("Skipping submodule due to ignore=all: %s"), path);
     ++							printf(_("Use --include_ignored_submodules, if you really want to add them.") );
     ++							continue;
     ++						}
     ++					} else {
     ++						/* No explicit pathspec match -> skip silently (or with trace). */
     ++						trace_printf("pathspec does not match %s\n", path);
     ++						continue;
     ++					}
     ++				}
     ++			}
     + 			if (add_file_to_index(data->index, path, data->flags)) {
     + 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
     + 					die(_("updating files failed"));
     +@@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
       
       int add_files_to_cache(struct repository *repo, const char *prefix,
       		       const struct pathspec *pathspec, char *ps_matched,
      -		       int include_sparse, int flags)
     -+		       int include_sparse, int flags, int ignored_too )
     ++		       int include_sparse, int flags, int include_ignored_submodules )
       {
       	struct update_callback_data data;
       	struct rev_info rev;
     @@ read-cache.c: int add_files_to_cache(struct repository *repo, const char *prefix
       	data.include_sparse = include_sparse;
       	data.flags = flags;
      +	data.repo = repo;
     -+	data.ignored_too = ignored_too;
     ++	data.include_ignored_submodules = include_ignored_submodules;
      +	data.pathspec = (struct pathspec *)pathspec;
       
       	repo_init_revisions(repo, &rev, prefix);
 2:  d1b02617e6 ! 2:  9ec79b9a11 read-cache: let read-cache respect submodule ignore=all and --force
     @@ Metadata
      Author: Claus Schneider(Eficode) <claus.schneider@eficode.com>
      
       ## Commit message ##
     -    read-cache: let read-cache respect submodule ignore=all and --force
     +    read-cache: add/read-cache respect submodule ignore=all
      
     -    Given the submdule configuration is ignore=all then only update the
     -    submdule if the --force option is given and the submodule is explicit
     -    given in the pathspec.
     +    Submodules configured with ignore=all are now skipped during add operations
     +    unless overridden by --include-ignored-submodules and the submodule path is
     +    explicitly specified.
      
          A message is printed (like ignored files) guiding the user to use the
     -    --force flag if the user has explicitely want to update the submodule
     -    reference.
     +    --include-ignored-submodules flag if the user has explicitely want to update
     +    the submodule reference.
      
          The reason for the change is support submodule branch tracking or
          similar and git status state nothing and git add should not add either.
     @@ Commit message
          the submodule is already tracked.
      
          The change opens up a lot of possibilities for submodules to be used
     -    more freely and a like the repo tool. A submodule can be added for many
     +    more freely and simular to the repo tool. A submodule can be added for many
          more reason and loosely coupled dependencies to the super repo which often
          gives the friction of handle the explicit commits and updates without
          the need for tracking the submodule sha1 by sha1.
     @@ read-cache.c
       /* Mask for the name length in ce_flags in the on-disk index */
       
      @@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
     - 		default:
     - 			die(_("unexpected diff status %c"), p->status);
     - 		case DIFF_STATUS_MODIFIED:
     --		case DIFF_STATUS_TYPE_CHANGED:
     -+		case DIFF_STATUS_TYPE_CHANGED: {
     -+			struct stat st;
     -+			if (!lstat(path, &st) && S_ISDIR(st.st_mode)) { // only consider submodule if it is a directory
     -+				const struct submodule *sub = submodule_from_path(data->repo, null_oid(the_hash_algo), path);
     -+				if (sub && sub->name && sub->ignore && !strcmp(sub->ignore, "all")) {
     -+					int pathspec_matches = 0;
     -+					char *norm_pathspec = NULL;
     -+					int ps_i;
     -+					trace_printf("ignore=all %s\n", path);
     -+					trace_printf("pathspec %s\n",
     -+							(data->pathspec && data->pathspec->nr) ? "has pathspec" : "no pathspec");
     -+					/* Safely scan all pathspec items (q->nr may exceed pathspec->nr). */
     -+					if (data->pathspec) {
     -+						for (ps_i = 0; ps_i < data->pathspec->nr; ps_i++) {
     -+							const char *m = data->pathspec->items[ps_i].match;
     -+							if (!m)
     -+								continue;
     -+							norm_pathspec = xstrdup(m);
     -+							strip_dir_trailing_slashes(norm_pathspec);
     -+							if (!strcmp(path, norm_pathspec)) {
     -+								pathspec_matches = 1;
     -+								FREE_AND_NULL(norm_pathspec);
     -+								break;
     -+							}
     -+							FREE_AND_NULL(norm_pathspec);
     -+						}
     -+					}
     -+					if (pathspec_matches) {
     -+						if (data->ignored_too && data->ignored_too > 0) {
     -+							trace_printf("Forcing add of submodule ignored=all due to --force: %s\n", path);
     -+						} else {
     -+							printf(_("Skipping submodule due to ignore=all: %s"), path);
     -+							printf(_("Use -f if you really want to add them.") );
     -+							continue;
     -+						}
     -+					} else {
     -+						/* No explicit pathspec match -> skip silently (or with trace). */
     -+						trace_printf("pathspec does not match %s\n", path);
     -+						continue;
     -+					}
     -+				}
     -+			}
     - 			if (add_file_to_index(data->index, path, data->flags)) {
     - 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
     - 					die(_("updating files failed"));
     + 					}
     + 					if (pathspec_matches) {
     + 						if (data->include_ignored_submodules && data->include_ignored_submodules > 0) {
     +-							trace_printf("Add ignored=all submodule due to --include_ignored_submodules: %s\n", path);
     ++							trace_printf("Add submodule due to --include_ignored_submodules: %s\n", path);
     + 						} else {
     + 							printf(_("Skipping submodule due to ignore=all: %s"), path);
     + 							printf(_("Use --include_ignored_submodules, if you really want to add them.") );
     +@@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
     + 						}
     + 					} else {
     + 						/* No explicit pathspec match -> skip silently (or with trace). */
     +-						trace_printf("pathspec does not match %s\n", path);
     ++						trace_printf("Pathspec to submodule does not match explicitly: %s\n", path);
     + 						continue;
     + 					}
     + 				}
     +@@ read-cache.c: static void update_callback(struct diff_queue_struct *q,
       				data->add_errors++;
       			}
       			break;
 3:  8f3d5f7ec1 ! 3:  399a153b95 tests: add new t2206-add-submodule-ignored.sh to test ignore=all scenario
     @@ Commit message
          config with ignore=all also behaves as intended with configuration in
          .gitmodules and configuration given on the command line.
      
     -    Testfile is added to meson.build for execution.
     +    The usage of --include_ignored_submodules is showcased and tested in the
     +    test suite.
     +
     +    The test file is added to meson.build for execution.
      
          Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
      
     @@ t/t2206-add-submodule-ignored.sh (new)
      +# This test covers the behavior of "git add", "git status" and "git log" when
      +# dealing with submodules that have the ignore=all setting in
      +# .gitmodules. It ensures that changes in such submodules are
     -+# ignored by default, but can be staged with "git add --force".
     ++# ignored by default, but can be staged with "git add --include-ignored-submodules".
      +
      +# shellcheck disable=SC1091
      +. ./test-lib.sh
     @@ t/t2206-add-submodule-ignored.sh (new)
      +'
      +
      +#6
     -+# check that 'git add --force .' does not stage the change in the submodule
     ++# check that 'git add --include-ignored-submodules .' does not stage the change in the submodule
      +# and that 'git status' does not show it as modified
     -+test_expect_success 'main: check --force add . and status'  '
     ++test_expect_success 'main: check --include-ignored-submodules add . and status'  '
      +	cd "${base_path}" &&
      +	cd main &&
     -+	GIT_TRACE=1 git add --force . &&
     ++	GIT_TRACE=1 git add --include-ignored-submodules . &&
      +	! git status --porcelain | grep "^M  sub$" &&
      +	echo
      +'
     @@ t/t2206-add-submodule-ignored.sh (new)
      +'
      +
      +#8
     -+# check that 'git add --force sub' does stage the change in the submodule
     -+# check that 'git add --force ./sub/' does stage the change in the submodule
     ++# check that 'git add --include-ignored-submodules sub' does stage the change in the submodule
     ++# check that 'git add --include-ignored-submodules ./sub/' does stage the change in the submodule
      +# and that 'git status --porcelain' does show it as modified
      +# commit it..
      +# check that 'git log --ignore-submodules=none' shows the submodule change
     @@ t/t2206-add-submodule-ignored.sh (new)
      +test_expect_success 'main: check force add sub and ./sub/ and status'  '
      +	cd "${base_path}" &&
      +	cd main &&
     -+	echo "Adding with --force should work: git add --force sub" &&
     -+	GIT_TRACE=1 git add --force sub &&
     ++	echo "Adding with --include-ignored-submodules should work: git add --include-ignored-submodules sub" &&
     ++	GIT_TRACE=1 git add --include-ignored-submodules sub &&
      +	git status --porcelain | grep "^M  sub$" &&
      +	git restore --staged sub &&
      +	! git status --porcelain | grep "^M  sub$" &&
     -+	echo "Adding with --force should work: git add --force ./sub/" &&
     -+	GIT_TRACE=1 git add --force ./sub/ &&
     ++	echo "Adding with --include-ignored-submodules should work: git add --include-ignored-submodules ./sub/" &&
     ++	GIT_TRACE=1 git add --include-ignored-submodules ./sub/ &&
      +	git status --porcelain | grep "^M  sub$" &&
      +	git commit -m "update submodule pointer" &&
      +	! git status --porcelain | grep "^ M sub$" &&
 4:  58563a7b90 ! 4:  93c95954f1 tests: fix existing tests when add an ignore=all submodule
     @@ Metadata
       ## Commit message ##
          tests: fix existing tests when add an ignore=all submodule
      
     -    There are tests that rely on "git add <submodule>" also adds it. A --force
     -    is needed with this enhancement hence they are added accordingly in these
     -    tests.
     +    There are tests that rely on "git add <submodule>" to add updates in the
     +    parent repository. A new option --include-ignored-submodules is introduced
     +    as it is now needed with this enhancement.
      
          Updated tests:
          - t1013-read-tree-submodule.sh ( fixed in: t/lib-submodule-update.sh )
     +    - t2013-checkout-submodule.sh ( fixed in: t/lib-submodule-update.sh )
          - t7406-submodule-update.sh
          - t7508-status.sh
      
     @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
       			git push origin modifications
       		) &&
      -		git add sub1 &&
     -+		git add --force sub1 &&
     ++		git add --include-ignored-submodules sub1 &&
       		git commit -m "Modify sub1" &&
       
       		git checkout -b add_nested_sub modify_sub1 &&
     @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
       		git -C sub1 submodule add --branch no_submodule ../submodule_update_sub2 sub2 &&
       		git -C sub1 commit -a -m "add a nested submodule" &&
      -		git add sub1 &&
     -+		git add --force sub1 &&
     ++		git add --include-ignored-submodules sub1 &&
       		git commit -a -m "update submodule, that updates a nested submodule" &&
       		git checkout -b modify_sub1_recursively &&
       		git -C sub1 checkout -b modify_sub1_recursively &&
     @@ t/lib-submodule-update.sh: create_lib_submodule_repo () {
       		git -C sub1 add sub2 &&
       		git -C sub1 commit -m "update nested sub" &&
      -		git add sub1 &&
     -+		git add --force sub1 &&
     ++		git add --include-ignored-submodules sub1 &&
       		git commit -m "update sub1, that updates nested sub" &&
       		git -C sub1 push origin modify_sub1_recursively &&
       		git -C sub1/sub2 push origin modify_sub1_recursively &&
     @@ t/t7508-status.sh: test_expect_success 'git commit will commit a staged but igno
       test_expect_success 'git commit --dry-run will show a staged but ignored submodule' '
       	git reset HEAD^ &&
      -	git add sm &&
     -+	git add --force sm &&
     ++	git add --include-ignored-submodules sm &&
       	cat >expect << EOF &&
       On branch main
       Your branch and '\''upstream'\'' have diverged,
 5:  416695f439 < -:  ---------- Documentation: update add --force and submodule ignore=all config
 -:  ---------- > 5:  ee84190cd8 Documentation: add --include_ignored_submodules + ignore=all config

-- 
gitgitgadget

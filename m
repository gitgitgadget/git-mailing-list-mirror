Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DA6C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 07:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378786AbhLCHF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378763AbhLCHFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 02:05:22 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69A9C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 23:01:58 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so1513202wmb.0
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 23:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=BGoEwpce2lzk+PLRj6EJqf03Okj4XJrZer+phNrz7pw=;
        b=NbGz+ArNiTEDcc2F+QKdY6Jmfz07ER2k20m8w9v6B3rzDVfMw3iGtu60FJzUMABxKf
         7wChLfdA3ay0ZJPUiG0d8zLmNB+YtJ+5V1/pwB8OjLPDKDl/Qss/elqya3bjipn7JObd
         c5AnM+EHiVzOtD0aQWiwhBVA4UtVm0IP0NO9EGnvzie2L0E7B+82TcrYEnt04Vc/blLR
         QyvnBCtTjEipmDsPbratIs3ULDS80bXTPPY94VsrKnCeo3d41rTSaH/Xbx6Y2Vl9NMt1
         YiAY37h0m8ROs7ZLqUpoDx7zlULrKaj7JKOolPU/gqGhPcSS9VocXhV1xIL1BXO505ab
         DN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=BGoEwpce2lzk+PLRj6EJqf03Okj4XJrZer+phNrz7pw=;
        b=HXm7Kb5BEkFl9EriX0HD8pmX34CCX67fZ6LwAbQWla19ZpJI4/L4C3vvCQH3AhLF2P
         2eyZEnp02gJ1UfXx/vL3siSC66pjSgS/12I9d0+f0sIWkogjgAGkQViYurtkcR0Zji5j
         BZQtAp/Z/hQq+sS5EVCNeboaGu5MJv/BT7lsYtZ0gN/WStCSDaDtsE+N/gIWDaOeAfBF
         sOJZTu+zzxwMvkbf511rQ1f0d1sDhOemw67WyutLHnnsZav7bwz0ktkMSC6n9feYJrri
         6lwu1sQswdj6VmHU+EPLcqt5urFUASjr0T+3hWrjhAwjch7qHz+Pexzw9f69VSGbmcPj
         T+hA==
X-Gm-Message-State: AOAM531gc12AG193EV6/g4fIbtZ/wIreXpsijw2QwSAesvdRak/nHfMc
        WjA3hXM8WrlhTAoG9BnnBUSfR6SV8Kc=
X-Google-Smtp-Source: ABdhPJxN76G5p4TD8hgV/lXYzR2WvJH3DihXsDdniZ5TiYrx+g1anO8JRTVqy2PyHx+or6tmynHoXA==
X-Received: by 2002:a1c:1c1:: with SMTP id 184mr12746780wmb.1.1638514917159;
        Thu, 02 Dec 2021 23:01:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h16sm1919594wrm.27.2021.12.02.23.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 23:01:56 -0800 (PST)
Message-Id: <653e33f799531ccdc21212238c2f404ccf9e970c.1638514910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 07:01:45 +0000
Subject: [PATCH 06/10] i18n: factorize "--foo requires --bar" and the like
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 archive.c             | 2 +-
 builtin/add.c         | 4 ++--
 builtin/checkout.c    | 2 +-
 builtin/commit.c      | 2 +-
 builtin/fast-export.c | 2 +-
 builtin/index-pack.c  | 2 +-
 builtin/log.c         | 2 +-
 builtin/reset.c       | 4 ++--
 builtin/rm.c          | 2 +-
 builtin/stash.c       | 2 +-
 builtin/worktree.c    | 2 +-
 fetch-pack.c          | 2 +-
 http-fetch.c          | 4 ++--
 13 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/archive.c b/archive.c
index f1208beacff..0d96217b4d4 100644
--- a/archive.c
+++ b/archive.c
@@ -577,7 +577,7 @@ static int parse_archive_args(int argc, const char **argv,
 	if (remote)
 		die(_("Unexpected option --remote"));
 	if (exec)
-		die(_("Option --exec can only be used together with --remote"));
+		die(_("%s requires %s"), "--exec", "--remote");
 	if (output)
 		die(_("Unexpected option --output"));
 	if (is_remote && args->extra_files.nr)
diff --git a/builtin/add.c b/builtin/add.c
index de1547b3dcd..1be22f8c287 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -544,7 +544,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		die(_("%s and %s are mutually exclusive"), "-A", "-u");
 
 	if (!show_only && ignore_missing)
-		die(_("Option --ignore-missing can only be used together with --dry-run"));
+		die(_("%s requires %s"), "--ignore-missing", "--dry-run");
 
 	if (chmod_arg && ((chmod_arg[0] != '-' && chmod_arg[0] != '+') ||
 			  chmod_arg[1] != 'x' || chmod_arg[2]))
@@ -576,7 +576,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 				    PATHSPEC_SYMLINK_LEADING_PATH,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (require_pathspec && pathspec.nr == 0) {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index ca444e9c177..825e753f607 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1740,7 +1740,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 				    0,
 				    prefix, opts->pathspec_from_file, opts->pathspec_file_nul);
 	} else if (opts->pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	opts->pathspec.recursive = 1;
diff --git a/builtin/commit.c b/builtin/commit.c
index cb7b9a38daa..37e8cf09bd5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -367,7 +367,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 				    PATHSPEC_PREFER_FULL,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (!pathspec.nr && (also || (only && !allow_empty &&
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 31157e966d6..b0302a75374 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1254,7 +1254,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		usage_with_options (fast_export_usage, options);
 
 	if (anonymized_seeds.cmpfn && !anonymize)
-		die(_("--anonymize-map without --anonymize does not make sense"));
+		die(_("%s requires %s"), "--anonymize-map", "--anonymize");
 
 	if (refspecs_list.nr) {
 		int i;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f9b40349f41..ed16230fa99 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1845,7 +1845,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (!pack_name && !from_stdin)
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
-		die(_("--fix-thin cannot be used without --stdin"));
+		die(_("%s requires %s"), "--fix-thin", "--stdin");
 	if (from_stdin && !startup_info->have_repository)
 		die(_("--stdin requires a git repository"));
 	if (from_stdin && hash_algo)
diff --git a/builtin/log.c b/builtin/log.c
index c39b974ea37..ea54576f38b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2097,7 +2097,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (creation_factor < 0)
 		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	else if (!rdiff_prev)
-		die(_("--creation-factor requires --range-diff"));
+		die(_("%s requires %s"), "--creation-factor", "--range-diff");
 
 	if (rdiff_prev) {
 		if (!cover_letter && total != 1)
diff --git a/builtin/reset.c b/builtin/reset.c
index 6e80e5c5a51..7efa95e0529 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -337,7 +337,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				    PATHSPEC_PREFER_FULL,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	unborn = !strcmp(rev, "HEAD") && get_oid("HEAD", &oid);
@@ -395,7 +395,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		    _(reset_type_names[reset_type]));
 
 	if (intent_to_add && reset_type != MIXED)
-		die(_("-N can only be used with --mixed"));
+		die(_("%s requires %s"), "-N", "--mixed");
 
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
diff --git a/builtin/rm.c b/builtin/rm.c
index 3d0967cdc11..38ac3c71252 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -278,7 +278,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 				    PATHSPEC_PREFER_CWD,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	if (!pathspec.nr)
diff --git a/builtin/stash.c b/builtin/stash.c
index 080572cc608..84a0a4667e6 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1653,7 +1653,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 				    PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
 				    prefix, pathspec_from_file, pathspec_file_nul);
 	} else if (pathspec_file_nul) {
-		die(_("--pathspec-file-nul requires --pathspec-from-file"));
+		die(_("%s requires %s"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
 	return do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 73ee505234c..c6d64dc8dfa 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -506,7 +506,7 @@ static int add(int ac, const char **av, const char *prefix)
 	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
 		die(_("%s, %s and %s are mutually exclusive"), "-b", "-B", "--detach");
 	if (lock_reason && !keep_locked)
-		die(_("--reason requires --lock"));
+		die(_("%s requires %s"), "--reason", "--lock");
 	if (lock_reason)
 		opts.keep_locked = lock_reason;
 	else if (keep_locked)
diff --git a/fetch-pack.c b/fetch-pack.c
index a9604f35a3e..0bdef8877c1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -296,7 +296,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 	struct packet_reader reader;
 
 	if (args->stateless_rpc && multi_ack == 1)
-		die(_("--stateless-rpc requires multi_ack_detailed"));
+		die(_("%s requires %s"), "--stateless-rpc", "multi_ack_detailed");
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
diff --git a/http-fetch.c b/http-fetch.c
index fa642462a9e..68cbfc1979d 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -131,7 +131,7 @@ int cmd_main(int argc, const char **argv)
 
 	if (packfile) {
 		if (!index_pack_args.nr)
-			die(_("--packfile requires --index-pack-args"));
+			die(_("%s requires %s"), "--packfile", "--index-pack-args");
 
 		fetch_single_packfile(&packfile_hash, argv[arg],
 				      index_pack_args.v);
@@ -140,7 +140,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (index_pack_args.nr)
-		die(_("--index-pack-args can only be used with --packfile"));
+		die(_("%s requires %s"), "--index-pack-args", "--packfile");
 
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
-- 
gitgitgadget


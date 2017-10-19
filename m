Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DA5A202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 16:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbdJSQGT (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 12:06:19 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:54448 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753759AbdJSQGR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 12:06:17 -0400
Received: by mail-qk0-f196.google.com with SMTP id n5so10943423qke.11
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Phktf7gSA5VgyQ2K7vgfVDz00Pa7o3bAOpAhL7Q5m1Q=;
        b=jGRBtFxDmZIJLbx5TFwUpUyJ0UnBQE4jrCMJLCnIl+fw9UF3Zg5q915NDoZoF4MEZh
         Kaedb4Wh5WRYuWIDoIBUDmQlJ81eF9ekVzf2AG2+xyM4mbZPVbWRdKGa/afTnIDZKvH5
         +jiWGIOwdXlKCV7fjoUtOTbmJE6ibA6KrNbJSlCkDlp68vVeLODNPxJ3nr8Llt0o5Et2
         aGdLCPEUzptTfIyQJKGippLZg2UZi6GdSRIUY2Hvpf1D0/YC7Vrou5w2qoO/hi1+4fDn
         bNW6HpV2kNHTcheWbQFF0bpEcTS/b4GnKgRm9TM9CKGMLxgXOZ2gU/7oXc/zmI6JD5bZ
         PwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Phktf7gSA5VgyQ2K7vgfVDz00Pa7o3bAOpAhL7Q5m1Q=;
        b=HNCUaAT2ccQHCiTLkmYECUUXLaMIvbHG4bxxU/DvXk03IVngwhKSXW15jiHpkMCAHR
         43Gyt+UeSXqajuXoLUnNJH+/mmDuMgnOcWLg0pGHZzSgjDbbHczv8hrl0Pe11E6B8tRc
         kkmtHMw25sQ2McGNc6jwC529q5p8lPVhO+GWEL77SXtqCIV15A3CPvdIHDaBCZgC1Woq
         cnhwixFx8B6aYhiFSDj3RwOrivN6on9tQw5ldYoSJhKCc1QCRalTWfp8uM+Af62segoF
         5R3YEQRVbJOZDpVHh24ijj1khvZRFE6fjZ8e5xUdwGC7NzVLtsV7cIld9YQ5PPvWTQN/
         fQIw==
X-Gm-Message-State: AMCzsaVUYpgKQnV1SS+jG90iuCj4+g3VHIY/GJMmrGu7h5JyVp5F9P16
        P/rgzCtbAJj9fRTo6xv4RbI=
X-Google-Smtp-Source: ABhQp+QqzgjN1YFozrYU82+qLtsKB+tLwi96WFPg6U/6smIGnRpZgBCzXTmbf8Quw2wADSD0BHNJ+w==
X-Received: by 10.55.124.7 with SMTP id x7mr2440105qkc.54.1508429177036;
        Thu, 19 Oct 2017 09:06:17 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id c13sm9377085qka.50.2017.10.19.09.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Oct 2017 09:06:16 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v3 1/4] status: add option to show ignored files differently
Date:   Thu, 19 Oct 2017 12:05:58 -0400
Message-Id: <20171019160601.9382-2-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171019160601.9382-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171019160601.9382-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach the status command more flexibility in how ignored files are
reported. Currently, the reporting of ignored files and untracked
files are linked. You cannot control how ignored files are reported
independently of how untracked files are reported (i.e. `all` vs
`normal`). This makes it impossible to show untracked files with the
`all` option, but show ignored files with the `normal` option.

This work 1) adds the ability to control the reporting of ignored
files independently of untracked files and 2) introduces the concept
of status reporting ignored paths that explicitly match an ignored
pattern. There are 2 benefits to these changes: 1) if a consumer needs
all untracked files but not all ignored files, there is a performance
benefit to not scanning all contents of an ignored directory and 2)
returning ignored files that explicitly match a path allow a consumer
to make more informed decisions about when a status result might be
stale.

This commit implements --ignored=matching with --untracked-files=all.
The following commit will implement --ignored=matching with
--untracked=files=normal.

As an example of where this flexibility could be useful is that our
application (Visual Studio) runs the status command and presents the
output. It shows all untracked files individually (e.g. using the
'--untracked-files==all' option), and would like to know about which
paths are ignored. It uses information about ignored paths to make
decisions about when the status result might have changed.
Additionally, many projects place build output into directories inside
a repository's working directory (e.g. in "bin/" and "obj/"
directories). Normal usage is to explicitly ignore these 2 directory
names in the .gitignore file (rather than or in addition to the *.obj
pattern).If an application could know that these directories are
explicitly ignored, it could infer that all contents are ignored as
well and make better informed decisions about files in these
directories. It could infer that any changes under these paths would
not affect the output of status. Additionally, there can be a
significant performance benefit by avoiding scanning through ignored
directories.

When status is set to report matching ignored files, it has the
following behavior. Ignored files and directories that explicitly
match an exclude pattern are reported. If an ignored directory matches
an exclude pattern, then the path of the directory is returned. If a
directory does not match an exclude pattern, but all of its contents
are ignored, then the contained files are reported instead of the
directory.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 builtin/commit.c | 31 +++++++++++++++++++++++++------
 dir.c            | 24 ++++++++++++++++++++++++
 dir.h            |  3 ++-
 wt-status.c      | 11 ++++++++---
 wt-status.h      |  8 +++++++-
 5 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d75b3805ea..98d84d0277 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -118,7 +118,7 @@ static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message;
-static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
+static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit;
 
 /*
@@ -139,7 +139,7 @@ static const char *cleanup_arg;
 static enum commit_whence whence;
 static int sequencer_in_use;
 static int use_editor = 1, include_status = 1;
-static int show_ignored_in_status, have_option_m;
+static int have_option_m;
 static struct strbuf message = STRBUF_INIT;
 
 static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
@@ -1075,6 +1075,19 @@ static const char *find_author_by_nickname(const char *name)
 	die(_("--author '%s' is not 'Name <email>' and matches no existing author"), name);
 }
 
+static void handle_ignored_arg(struct wt_status *s)
+{
+	if (!ignored_arg)
+		; /* default already initialized */
+	else if (!strcmp(ignored_arg, "traditional"))
+		s->show_ignored_mode = SHOW_TRADITIONAL_IGNORED;
+	else if (!strcmp(ignored_arg, "no"))
+		s->show_ignored_mode = SHOW_NO_IGNORED;
+	else if (!strcmp(ignored_arg, "matching"))
+		s->show_ignored_mode = SHOW_MATCHING_IGNORED;
+	else
+		die(_("Invalid ignored mode '%s'"), ignored_arg);
+}
 
 static void handle_untracked_files_arg(struct wt_status *s)
 {
@@ -1363,8 +1376,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		  N_("mode"),
 		  N_("show untracked files, optional modes: all, normal, no. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
-		OPT_BOOL(0, "ignored", &show_ignored_in_status,
-			 N_("show ignored files")),
+		{ OPTION_STRING, 0, "ignored", &ignored_arg,
+		  N_("mode"),
+		  N_("show ignored files, optional modes: traditional, matching, no. (Default: traditional)"),
+		  PARSE_OPT_OPTARG, NULL, (intptr_t)"traditional" },
 		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
 		  N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
@@ -1383,8 +1398,12 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	finalize_deferred_config(&s);
 
 	handle_untracked_files_arg(&s);
-	if (show_ignored_in_status)
-		s.show_ignored_files = 1;
+	handle_ignored_arg(&s);
+
+	if (s.show_ignored_mode == SHOW_MATCHING_IGNORED &&
+	    s.show_untracked_files == SHOW_NO_UNTRACKED_FILES)
+		die(_("Unsupported combination of ignored and untracked-files arguments"));
+
 	parse_pathspec(&s.pathspec, 0,
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
diff --git a/dir.c b/dir.c
index 1d17b800cf..b9af87eca9 100644
--- a/dir.c
+++ b/dir.c
@@ -1389,6 +1389,30 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	case index_nonexistent:
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
+		if (exclude &&
+			(dir->flags & DIR_SHOW_IGNORED_TOO) &&
+			(dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
+
+			/*
+			 * This is an excluded directory and we are
+			 * showing ignored paths that match an exclude
+			 * pattern.  (e.g. show directory as ignored
+			 * only if it matches an exclude pattern).
+			 * This path will either be 'path_excluded`
+			 * (if we are showing empty directories or if
+			 * the directory is not empty), or will be
+			 * 'path_none' (empty directory, and we are
+			 * not showing empty directories).
+			 */
+			if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
+				return path_excluded;
+
+			if (read_directory_recursive(dir, istate, dirname, len,
+						     untracked, 1, 1, pathspec) == path_excluded)
+				return path_excluded;
+
+			return path_none;
+		}
 		if (!(dir->flags & DIR_NO_GITLINKS)) {
 			unsigned char sha1[20];
 			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
diff --git a/dir.h b/dir.h
index e3717055d1..57b0943dae 100644
--- a/dir.h
+++ b/dir.h
@@ -152,7 +152,8 @@ struct dir_struct {
 		DIR_COLLECT_IGNORED = 1<<4,
 		DIR_SHOW_IGNORED_TOO = 1<<5,
 		DIR_COLLECT_KILLED_ONLY = 1<<6,
-		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7
+		DIR_KEEP_UNTRACKED_CONTENTS = 1<<7,
+		DIR_SHOW_IGNORED_TOO_MODE_MATCHING = 1<<8
 	} flags;
 	struct dir_entry **entries;
 	struct dir_entry **ignored;
diff --git a/wt-status.c b/wt-status.c
index 6f730ee8f2..8301c84946 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -660,10 +660,15 @@ static void wt_status_collect_untracked(struct wt_status *s)
 	if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
 		dir.flags |=
 			DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
-	if (s->show_ignored_files)
+	if (s->show_ignored_mode) {
 		dir.flags |= DIR_SHOW_IGNORED_TOO;
-	else
+
+		if (s->show_ignored_mode == SHOW_MATCHING_IGNORED)
+			dir.flags |= DIR_SHOW_IGNORED_TOO_MODE_MATCHING;
+	} else {
 		dir.untracked = the_index.untracked;
+	}
+
 	setup_standard_excludes(&dir);
 
 	fill_directory(&dir, &the_index, &s->pathspec);
@@ -1621,7 +1626,7 @@ static void wt_longstatus_print(struct wt_status *s)
 	}
 	if (s->show_untracked_files) {
 		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
-		if (s->show_ignored_files)
+		if (s->show_ignored_mode)
 			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
 		if (advice_status_u_option && 2000 < s->untracked_in_ms) {
 			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
diff --git a/wt-status.h b/wt-status.h
index 64f4d33ea1..fe27b465e2 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -27,6 +27,12 @@ enum untracked_status_type {
 	SHOW_ALL_UNTRACKED_FILES
 };
 
+enum show_ignored_type {
+	SHOW_NO_IGNORED,
+	SHOW_TRADITIONAL_IGNORED,
+	SHOW_MATCHING_IGNORED,
+};
+
 /* from where does this commit originate */
 enum commit_whence {
 	FROM_COMMIT,     /* normal */
@@ -70,7 +76,7 @@ struct wt_status {
 	int display_comment_prefix;
 	int relative_paths;
 	int submodule_summary;
-	int show_ignored_files;
+	enum show_ignored_type show_ignored_mode;
 	enum untracked_status_type show_untracked_files;
 	const char *ignore_submodule_arg;
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
-- 
2.13.6


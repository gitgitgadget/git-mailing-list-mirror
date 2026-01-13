Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E7D2C859
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320974; cv=none; b=olqFVwc6Jn4SbMtRxSvWs9N43pRbj6DxPcTvTmnLk+cOikiaYp8TmCIAhwz9ZC2TkXeRNpoARYb/UDaevw1vC2acfbNEl+X4wWB8YY1aH5OHXJsbexqJbkMbk9yIg5evQNHUiKoE/0+Z6XTbVAoElr+fqOKCgZyZToQDD7gHIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320974; c=relaxed/simple;
	bh=K7Ps5fVpwwUWx5oR6K25fqwIFjeFgQx/bUiTNZ0M2WA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DFkDa9q8OcyepwfoOJqw6opmJsD2bhJFwczWiS66h6WSQ+/ab72AjIppmWHmB8XaEIdnGmE46NeUNl1V3+TiP6JOlQDVCOvSkOYcu/WJDkzWW8wRcmU3g6bklRKox2juFuM1bFR+0+wH3mD9zNdNORMb4nO1h+8bTccQcTPRF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQiPnT4T; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQiPnT4T"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so48536835e9.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 08:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768320971; x=1768925771; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SynXAVNKYkXVMKP48Mh6Jif+Rvbd/76FMGrYEHV3yIc=;
        b=FQiPnT4Ty+bnFLXWJo7Xj/azT+2oVYKTqQx86AViK7RZcEnF93mLD0mSjXaLUOTV2N
         DIPakI7VFOi3WG9Dc+48uoAHmuEq+Mo2y7ku/ORnyk4V35VbmT1vcHfp5I0KEROVpxGA
         14xNvL26bKxYotd0z3fwZsdyJlC+7n8YQAniqf4oqQL2rPYdAEPISReTOOLx0OtWcrU1
         rsRuE7ih9WaOwW9lOTakofcPwrb1EWuvJLbUm8N4pUnAxi0kYgToa9We97GQ0eREgKyP
         a6swpjp/r3ROW8VkLFA4V3e0jfY7Q8zvdPATEoIu2veBPFE75TtDJWIgNriatgTvd7LP
         SWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768320971; x=1768925771;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SynXAVNKYkXVMKP48Mh6Jif+Rvbd/76FMGrYEHV3yIc=;
        b=LqQYW+RMpLQ5x7wR1DA413KZ1fPHnwUAooWm3n/TXRWGVsHg4DwKFQka/9YSf8Jy/w
         HvDZdr9+tZ5tHiLcAvQXjNZTFjXHwda+OmVgeu6tOv+e8RItm5jj4p4lMkOmswebE8EY
         8VcizMWi+Fh/4mQF3Y1QVVaXSM5oAAmoxlwgjgXwJn/LWiiIMogsbMlvWAic9D+s8Pm7
         miOfcqN9xc96kWWsHB/vuoctdFWmvrO03six7xy9OsJfsblnV5BMkQZf/RtIEEarH2kD
         noS45K57gfU0GCy5hLBeJjH6CufKqx5h0z0rYGWOrCivkHJ+R966lR87J9OQkeku2tbG
         CVnQ==
X-Gm-Message-State: AOJu0YyodbKOOnZ4EDGLiVDj95ZXNAlPvegTV6gAVqNqvYf0QvA+cZ77
	klu9VjIGhdoARXBW+CBlcg0mifYNFi8osjYZMhoCflMAeUEqS6+7qnS7Qkye/pGr
X-Gm-Gg: AY/fxX4QotVoIYCdt7lD3AYL9r5HSGZXW9AyuOa/SGRGJbV4LZeUp9xmW0hj1Hum8hM
	afgKqVsNt9VWo3fyCD9o0YnuhG7ia199AQW02bimcwqL/A9evtOo+H9StEj0PGUGN9h6NmYZoJp
	h97R7WKLleMYfVJD/Gu834y19JQP/LdbqYPxdzPailzZLetxg+IqbrCsvt/PomQXuodHLGzZDOZ
	ADnB7IUWFpt5Jt9g2o5FHiVN0oblkfEcrwnYehHQUpzAXZPXDyX9Pt7CNSZhaQx9i83Y7Rrrieh
	OSyzePpV2da0TIF4q8o4pSEwbGoHioSWHmKQA1nJufgAJcQg0klnwLoiaqRM1cDCoDBPrbujOvX
	UvOpC0ULFfE+TPrpUUQD6H1uqTmksuTAQJo/LGwlPlbm2RK4JiaS0zNf+XRoiHV8Gx2yegGdiRo
	MmbNXdfwg133kJj+BVg3cS
X-Google-Smtp-Source: AGHT+IEpeuLyRyUzfYQCOrgOJMnweajEoVz/c98DKxEgQDPM4R0VJnIHgIJ9jWs+tKHChc+5U/Ccfg==
X-Received: by 2002:a05:600c:444c:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-47d84b5b51amr288399585e9.31.1768320970964;
        Tue, 13 Jan 2026 08:16:10 -0800 (PST)
Received: from localhost ([102.91.81.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ecf6a5466sm131755515e9.11.2026.01.13.08.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:16:10 -0800 (PST)
Date: Tue, 13 Jan 2026 17:16:20 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v1] builtin: stop using the_repository
Message-ID: <aWZkEYHhcIhdAjkh@Adekunles-MacBook-Air.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The builtins use the_repository global variable which might
not work well when running many repos in the same process at once.

Stop using the_repository in these builtins to align with the goal of
libification of Git.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 builtin/bugreport.c    | 13 ++++++-------
 builtin/bundle.c       | 13 ++++++-------
 builtin/check-attr.c   | 26 +++++++++++++-------------
 builtin/check-ignore.c | 27 +++++++++++++++------------
 4 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index f78c3f2aed..77eb8bd9c1 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "editor.h"
@@ -37,7 +36,7 @@ static void get_system_info(struct strbuf *sys_info)
 		    shell ? shell : "<unset>");
 }
 
-static void get_populated_hooks(struct strbuf *hook_info, int nongit)
+static void get_populated_hooks(struct repository *repo, struct strbuf *hook_info, int nongit)
 {
 	const char **p;
 
@@ -50,7 +49,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 	for (p = hook_name_list; *p; p++) {
 		const char *hook = *p;
 
-		if (hook_exists(the_repository, hook))
+		if (hook_exists(repo, hook))
 			strbuf_addf(hook_info, "%s\n", hook);
 	}
 }
@@ -93,7 +92,7 @@ static void get_header(struct strbuf *buf, const char *title)
 int cmd_bugreport(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  struct repository *repo)
 {
 	struct strbuf buffer = STRBUF_INIT;
 	struct strbuf report_path = STRBUF_INIT;
@@ -141,7 +140,7 @@ int cmd_bugreport(int argc,
 	}
 	strbuf_addstr(&report_path, ".txt");
 
-	switch (safe_create_leading_directories(the_repository, report_path.buf)) {
+	switch (safe_create_leading_directories(repo, report_path.buf)) {
 	case SCLD_OK:
 	case SCLD_EXISTS:
 		break;
@@ -158,7 +157,7 @@ int cmd_bugreport(int argc,
 		strbuf_addftime(&zip_path, option_suffix, localtime_r(&now, &tm), 0, 0);
 		strbuf_addstr(&zip_path, ".zip");
 
-		if (create_diagnostics_archive(the_repository, &zip_path, diagnose))
+		if (create_diagnostics_archive(repo, &zip_path, diagnose))
 			die_errno(_("unable to create diagnostics archive %s"), zip_path.buf);
 
 		strbuf_release(&zip_path);
@@ -171,7 +170,7 @@ int cmd_bugreport(int argc,
 	get_system_info(&buffer);
 
 	get_header(&buffer, _("Enabled Hooks"));
-	get_populated_hooks(&buffer, !startup_info->have_repository);
+	get_populated_hooks(repo, &buffer, !startup_info->have_repository);
 
 	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
 	report = xopen(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 1e170e9278..ef21ccfd89 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
@@ -68,7 +67,7 @@ static int parse_options_cmd_bundle(int argc,
 }
 
 static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
-			     struct repository *repo UNUSED) {
+			     struct repository *repo) {
 	struct strvec pack_opts = STRVEC_INIT;
 	int version = -1;
 	int ret;
@@ -101,7 +100,7 @@ static int cmd_bundle_create(int argc, const char **argv, const char *prefix,
 
 	if (!startup_info->have_repository)
 		die(_("Need a repository to create a bundle."));
-	ret = !!create_bundle(the_repository, bundle_file, argc, argv, &pack_opts, version);
+	ret = !!create_bundle(repo, bundle_file, argc, argv, &pack_opts, version);
 	strvec_clear(&pack_opts);
 	free(bundle_file);
 	return ret;
@@ -125,7 +124,7 @@ static int open_bundle(const char *path, struct bundle_header *header,
 }
 
 static int cmd_bundle_verify(int argc, const char **argv, const char *prefix,
-			     struct repository *repo UNUSED) {
+			     struct repository *repo) {
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int quiet = 0;
@@ -152,7 +151,7 @@ static int cmd_bundle_verify(int argc, const char **argv, const char *prefix,
 		goto cleanup;
 	}
 	close(bundle_fd);
-	if (verify_bundle(the_repository, &header,
+	if (verify_bundle(repo, &header,
 			  quiet ? VERIFY_BUNDLE_QUIET : VERIFY_BUNDLE_VERBOSE)) {
 		ret = 1;
 		goto cleanup;
@@ -193,7 +192,7 @@ static int cmd_bundle_list_heads(int argc, const char **argv, const char *prefix
 }
 
 static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix,
-			       struct repository *repo UNUSED) {
+			       struct repository *repo) {
 	struct bundle_header header = BUNDLE_HEADER_INIT;
 	int bundle_fd = -1;
 	int ret;
@@ -221,7 +220,7 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix,
 	if (progress)
 		strvec_pushl(&extra_index_pack_args, "-v", "--progress-title",
 			     _("Unbundling objects"), NULL);
-	ret = !!unbundle(the_repository, &header, bundle_fd,
+	ret = !!unbundle(repo, &header, bundle_fd,
 			 &extra_index_pack_args, NULL) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 51ed48ce43..cdeef0656d 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -61,7 +61,7 @@ static void output_attr(struct attr_check *check, const char *file)
 	}
 }
 
-static void check_attr(const char *prefix, struct attr_check *check,
+static void check_attr(struct repository *repo, const char *prefix, struct attr_check *check,
 		       int collect_all,
 		       const char *file)
 
@@ -70,16 +70,16 @@ static void check_attr(const char *prefix, struct attr_check *check,
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 
 	if (collect_all) {
-		git_all_attrs(the_repository->index, full_path, check);
+		git_all_attrs(repo->index, full_path, check);
 	} else {
-		git_check_attr(the_repository->index, full_path, check);
+		git_check_attr(repo->index, full_path, check);
 	}
 	output_attr(check, file);
 
 	free(full_path);
 }
 
-static void check_attr_stdin_paths(const char *prefix, struct attr_check *check,
+static void check_attr_stdin_paths(struct repository *repo, const char *prefix, struct attr_check *check,
 				   int collect_all)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -94,7 +94,7 @@ static void check_attr_stdin_paths(const char *prefix, struct attr_check *check,
 				die("line is badly quoted");
 			strbuf_swap(&buf, &unquoted);
 		}
-		check_attr(prefix, check, collect_all, buf.buf);
+		check_attr(repo, prefix, check, collect_all, buf.buf);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	strbuf_release(&buf);
@@ -110,7 +110,7 @@ static NORETURN void error_with_usage(const char *msg)
 int cmd_check_attr(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   struct repository *repo)
 {
 	struct attr_check *check;
 	struct object_id initialized_oid;
@@ -119,15 +119,15 @@ int cmd_check_attr(int argc,
 	if (!is_bare_repository())
 		setup_work_tree();
 
-	repo_config(the_repository, git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
 
-	if (repo_read_index(the_repository) < 0) {
+	if (repo_read_index(repo) < 0) {
 		die("invalid cache");
 	}
 
@@ -189,16 +189,16 @@ int cmd_check_attr(int argc,
 	}
 
 	if (source) {
-		if (repo_get_oid_tree(the_repository, source, &initialized_oid))
+		if (repo_get_oid_tree(repo, source, &initialized_oid))
 			die("%s: not a valid tree-ish source", source);
 		set_git_attr_source(source);
 	}
 
 	if (stdin_paths)
-		check_attr_stdin_paths(prefix, check, all_attrs);
+		check_attr_stdin_paths(repo, prefix, check, all_attrs);
 	else {
 		for (i = filei; i < argc; i++)
-			check_attr(prefix, check, all_attrs, argv[i]);
+			check_attr(repo, prefix, check, all_attrs, argv[i]);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 644c9a414f..68a05562fa 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -70,8 +70,10 @@ static void output_pattern(const char *path, struct path_pattern *pattern)
 	}
 }
 
-static int check_ignore(struct dir_struct *dir,
-			const char *prefix, int argc, const char **argv)
+static int check_ignore(struct repository *repo,
+			struct dir_struct *dir,
+			const char *prefix,
+			int argc, const char **argv)
 {
 	const char *full_path;
 	char *seen;
@@ -95,21 +97,21 @@ static int check_ignore(struct dir_struct *dir,
 		       PATHSPEC_KEEP_ORDER,
 		       prefix, argv);
 
-	die_path_inside_submodule(the_repository->index, &pathspec);
+	die_path_inside_submodule(repo->index, &pathspec);
 
 	/*
 	 * look for pathspecs matching entries in the index, since these
 	 * should not be ignored, in order to be consistent with
 	 * 'git status', 'git add' etc.
 	 */
-	seen = find_pathspecs_matching_against_index(&pathspec, the_repository->index,
+	seen = find_pathspecs_matching_against_index(&pathspec, repo->index,
 						     PS_HEED_SKIP_WORKTREE);
 	for (i = 0; i < pathspec.nr; i++) {
 		full_path = pathspec.items[i].match;
 		pattern = NULL;
 		if (!seen[i]) {
 			int dtype = DT_UNKNOWN;
-			pattern = last_matching_pattern(dir, the_repository->index,
+			pattern = last_matching_pattern(dir, repo->index,
 							full_path, &dtype);
 			if (!verbose && pattern &&
 			    pattern->flags & PATTERN_FLAG_NEGATIVE)
@@ -126,7 +128,8 @@ static int check_ignore(struct dir_struct *dir,
 	return num_ignored;
 }
 
-static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
+static int check_ignore_stdin_paths(struct repository *repo,
+			struct dir_struct *dir, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -143,7 +146,7 @@ static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
 			strbuf_swap(&buf, &unquoted);
 		}
 		pathspec[0] = buf.buf;
-		num_ignored += check_ignore(dir, prefix,
+		num_ignored += check_ignore(repo, dir, prefix,
 					    1, (const char **)pathspec);
 		maybe_flush_or_die(stdout, "check-ignore to stdout");
 	}
@@ -155,12 +158,12 @@ static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
 int cmd_check_ignore(int argc,
 		     const char **argv,
 		     const char *prefix,
-		     struct repository *repo UNUSED)
+		     struct repository *repo)
 {
 	int num_ignored;
 	struct dir_struct dir = DIR_INIT;
 
-	repo_config(the_repository, git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, check_ignore_options,
 			     check_ignore_usage, 0);
@@ -184,15 +187,15 @@ int cmd_check_ignore(int argc,
 		die(_("--non-matching is only valid with --verbose"));
 
 	/* read_cache() is only necessary so we can watch out for submodules. */
-	if (!no_index && repo_read_index(the_repository) < 0)
+	if (!no_index && repo_read_index(repo) < 0)
 		die(_("index file corrupt"));
 
 	setup_standard_excludes(&dir);
 
 	if (stdin_paths) {
-		num_ignored = check_ignore_stdin_paths(&dir, prefix);
+		num_ignored = check_ignore_stdin_paths(repo, &dir, prefix);
 	} else {
-		num_ignored = check_ignore(&dir, prefix, argc, argv);
+		num_ignored = check_ignore(repo, &dir, prefix, argc, argv);
 		maybe_flush_or_die(stdout, "ignore to stdout");
 	}
 
-- 
2.39.5 (Apple Git-154)


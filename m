Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81DA38A728
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035808; cv=none; b=VklZeS7ZeYO2z/nz59xE9lvklRIUR/jE2mI7wxBKIMqINJE0nYwjNXeRwzz8785YEFk5jzvgx8kWdFzygXB1an+5wgcq/70EUMTqoX0uN88iHKxssYT9f8r/WtAkmJytKvmXSQ/0mf+FOvbZU0rLnWOo5AO0XJ6o762KdaCj950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035808; c=relaxed/simple;
	bh=VqEOWJQGrFiPXrh2rJ2Y0yvAib6iThNY9pexTk2G2sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSw8qE9py7nBCv6CuThudHZchQ0lddeRaBtrBAU+2iu5jN2PfhXCqs9krVYVh24cS8bIWajHYnjnj7yIhGw9Bx31tSCTfvLDU97MPeXfMzPJVkp/Y8M3O79oShFp+M1fp3NxjcaWkHTKqUP73XS2diz3QaONLuQaZdsELOKF7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNx/PvDE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNx/PvDE"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69c20ba892eso1467798a12.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 06:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035805; x=1784640605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNqcn9YcX+0tzQ5mrzPhs3RtWneyP8wffyWnhpN/loY=;
        b=HNx/PvDEUKA5YcMQC8XjMgx3hKkS4OkC8DlQKzUG2koO/lOAFdHR68K4sfpeEO9zq8
         6VlpAOr2IhdoYH5qeRz+nrceSJBlIA6EtodbD5L+wXM6P4MRiuqoTsrpzuUBP7Pks/jF
         aPn7iGBn20MCXxE9WnZ9s/Jgs5BzQkObG2F3Y2LTB8LY5yHx2puxTycRDi0GnE47Li2w
         FWlrUl37wsieFUl9YmnUpcVn0NESEbxhVGyeFc75jVwUgRbt2bwUj6cfBJkTTVAjgJ+X
         jsW8DBN4wBOdFGGxXR3x/eDKI06Faol61tJmyK5dhX6RHtb7bFD1S0hb5V14HFaSy2+8
         rDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035805; x=1784640605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JNqcn9YcX+0tzQ5mrzPhs3RtWneyP8wffyWnhpN/loY=;
        b=Np8GPSf3KvxS5m5iPYOBqspSp8AU5bCaHjzVk90yzYkz1m0HJP0ishS+gzgIRcG3Ci
         KaU7F0EcvtNXVa/O++uUA8dObrRnmtYf1nmJyG5keFVQUO8gLRhlFqX3/fBMp80HWXF8
         gi1T1Lw5E6zzr1XBpbmxPEv7Uv1D7+3b0YIEEcFQrboFTkuRn3gFF9aTNq0mBpVdavle
         bbZvjxeXknPhGxYsL4+mqIc0ThBwps6aZY3U6QEQr92wU+c0C2C8ej2o0gvX8WBVYE8o
         wTssBVaP+0mrc/ipEe0QwnuO3jz/NtabY93/PyOMvr0Jgr3KVmJS5foqfJj3PLfl6rfe
         f7YA==
X-Gm-Message-State: AOJu0YxpBi4FlrX+cFYYqaH0dVXXfnD7MnfjXRKVBGy6IsbKDsSqUSpH
	4of+q0eaeRKjsjpfg1uyjz+0M4Zb5He31BtAkPGnVNRWQkEOFDJiR/RCM10lyfja
X-Gm-Gg: AfdE7cmVPp1EpI89ZcOZ8bmlXPOGU0GTmJtV+b/miQoRkilD/tS+4z2YSywk+V0P5uD
	Lr1i6akZD3I54NqHGrThrdIk8lX/XcIwSjL201EAclwRUl6lD4Car4yKicxfAqFve7cPFviEq7u
	9wvtUHULbvLRGUp48L3eZg11lqa66EZVH0OchU4Cig3DNYpYwJKckq5pSJSVDOb0QCtYivEoCko
	j3DCCbX8ZuZ5EtjKbVkNBBB1cb+vtIwZGae6zH8s2O+AvJN5yIKFXAkvDX5zD7/9StJ7ChhmB2d
	VW8Y/UplplB3lB2wIyVcrN/Gn158u5dqRuCeUHYeAIiTOceTzThLbCACOceZRFptBgy/GEpRY0u
	RVb/pFaM8IZ+KkPZ+/c6I11SxMRjbMc2gSI8tdO6m6zekoTMGiHzIGYBPERN5BqD64FmPi9SSOE
	MuKqTzY9C1pEI7dfc4Z4wKwQVmG/vAFHnob0xpoJttgYsBZ4J52294KtJcaaPXu2lQrTckULYJC
	FkUgJJhG/jz/y338O6fGBivzDSejg==
X-Received: by 2002:a17:907:d587:b0:c12:58c0:db2 with SMTP id a640c23a62f3a-c15fe781907mr823090966b.18.1784035804754;
        Tue, 14 Jul 2026 06:30:04 -0700 (PDT)
Received: from M-K2012N0113010 ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd288757esm1616877a12.9.2026.07.14.06.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:30:04 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Glen Choo <glencbz@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 2/2] fetch: add fetch.submoduleErrors to make submodule fetch errors non-fatal
Date: Tue, 14 Jul 2026 16:29:57 +0300
Message-ID: <20260714132959.3368867-3-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714132959.3368867-1-paulius.zaleckas@gmail.com>
References: <20260710122655.3066377-1-paulius.zaleckas@gmail.com>
 <20260714132959.3368867-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fetching with --recurse-submodules, a submodule commit that is not
yet reachable from any of the submodule's remote refs causes the entire
fetch to fail.  This is overly strict when the missing commit belongs to
an upstream branch that is still being prepared (e.g. an in-progress
merge topic): the local branch does not need that commit, so there is no
reason to treat its absence as fatal.

Add a new config key fetch.submoduleErrors (values: fail/warn) and a
corresponding --submodule-errors=(fail|warn) command-line option that
control this behaviour.  The default remains fail (existing behaviour);
setting the value to warn causes submodule fetch failures to be reported
on stderr without affecting the overall exit status of git fetch / git
pull.

Forward the option to child fetches in add_options_to_argv() so that it
also takes effect for `git fetch --all` / `--multiple` (where per-remote
child processes handle the submodule recursion themselves) and for
nested submodule recursion.  The resolved value is forwarded whenever it
was set explicitly, in either direction: the per-remote children re-read
the repository configuration, so a command-line --submodule-errors=fail
must be passed down to them to override fetch.submoduleErrors=warn from
the configuration.  When neither the configuration nor the command line
sets a value, nothing is forwarded and the child processes fall back to
their own configuration.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 Documentation/config/fetch.adoc  | 14 +++++
 Documentation/fetch-options.adoc |  8 +++
 builtin/fetch.c                  | 46 ++++++++++++++++-
 submodule.c                      |  8 ++-
 submodule.h                      |  7 ++-
 t/t5526-fetch-submodules.sh      | 89 ++++++++++++++++++++++++++++++++
 6 files changed, 168 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
index 04ac90912d..5c9c942a70 100644
--- a/Documentation/config/fetch.adoc
+++ b/Documentation/config/fetch.adoc
@@ -10,6 +10,20 @@
 	reference.
 	Defaults to `on-demand`, or to the value of `submodule.recurse` if set.
 
+`fetch.submoduleErrors`::
+	Controls how errors from submodule fetches are handled when
+	`--recurse-submodules` is in effect. When set to `fail` (the default),
+	any submodule fetch error causes the overall `git fetch` or `git pull`
+	to exit with a non-zero status. When set to `warn`, submodule fetch
+	errors are reported to standard error but do not affect the exit
+	status of the command. This is useful when working in repositories
+	where some branches reference submodule commits that are not yet
+	available on the submodule remote, but those commits are not needed
+	for the currently checked-out branch.
++
+The value of this option can be overridden by the `--submodule-errors`
+option of linkgit:git-fetch[1].
+
 `fetch.fsckObjects`::
 	If it is set to true, git-fetch-pack will check all fetched
 	objects. See `transfer.fsckObjects` for what's
diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
index 035f780e58..78525f6848 100644
--- a/Documentation/fetch-options.adoc
+++ b/Documentation/fetch-options.adoc
@@ -294,6 +294,14 @@ ifndef::git-pull[]
 `--no-recurse-submodules`::
 	Disable recursive fetching of submodules (this has the same effect as
 	using the `--recurse-submodules=no` option).
+
+`--submodule-errors=(fail|warn)`::
+	Control how errors from submodule fetches are handled when
+	`--recurse-submodules` is in effect. When set to `fail` (the default),
+	any submodule fetch error causes the overall `git fetch` to exit with a
+	non-zero status. When set to `warn`, submodule fetch errors are reported
+	to standard error but do not affect the exit status of the command. Can
+	also be configured via `fetch.submoduleErrors`. See linkgit:git-config[1].
 endif::git-pull[]
 
 `--set-upstream`::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c1d7c672f4..41122e17b3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -110,6 +110,7 @@ struct fetch_config {
 	int recurse_submodules;
 	int parallel;
 	int submodule_fetch_jobs;
+	int submodule_errors;
 };
 
 static int git_fetch_config(const char *k, const char *v,
@@ -152,6 +153,19 @@ static int git_fetch_config(const char *k, const char *v,
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.submoduleerrors")) {
+		if (!v)
+			return config_error_nonbool(k);
+		else if (!strcasecmp(v, "fail"))
+			fetch_config->submodule_errors = SUBMODULE_ERRORS_FAIL;
+		else if (!strcasecmp(v, "warn"))
+			fetch_config->submodule_errors = SUBMODULE_ERRORS_WARN;
+		else
+			die(_("invalid value for '%s': '%s'"),
+			    "fetch.submoduleErrors", v);
+		return 0;
+	}
+
 	if (!strcmp(k, "fetch.parallel")) {
 		fetch_config->parallel = git_config_int(k, v, ctx->kvi);
 		if (fetch_config->parallel < 0)
@@ -2205,6 +2219,10 @@ static void add_options_to_argv(struct strvec *argv,
 		strvec_push(argv, "--no-recurse-submodules");
 	else if (config->recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
 		strvec_push(argv, "--recurse-submodules=on-demand");
+	if (config->submodule_errors == SUBMODULE_ERRORS_FAIL)
+		strvec_push(argv, "--submodule-errors=fail");
+	else if (config->submodule_errors == SUBMODULE_ERRORS_WARN)
+		strvec_push(argv, "--submodule-errors=warn");
 	if (tags == TAGS_SET)
 		strvec_push(argv, "--tags");
 	else if (tags == TAGS_UNSET)
@@ -2464,6 +2482,19 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	return exit_code;
 }
 
+static int option_parse_submodule_errors(const struct option *opt,
+					  const char *arg, int unset)
+{
+	int *v = opt->value;
+	if (unset || !strcasecmp(arg, "fail"))
+		*v = SUBMODULE_ERRORS_FAIL;
+	else if (!strcasecmp(arg, "warn"))
+		*v = SUBMODULE_ERRORS_WARN;
+	else
+		die(_("invalid value for '%s': '%s'"), "--submodule-errors", arg);
+	return 0;
+}
+
 int cmd_fetch(int argc,
 	      const char **argv,
 	      const char *prefix,
@@ -2477,6 +2508,7 @@ int cmd_fetch(int argc,
 		.recurse_submodules = RECURSE_SUBMODULES_DEFAULT,
 		.parallel = 1,
 		.submodule_fetch_jobs = -1,
+		.submodule_errors = -1, /* unset */
 	};
 	const char *submodule_prefix = "";
 	const char *bundle_uri;
@@ -2491,6 +2523,7 @@ int cmd_fetch(int argc,
 	int max_jobs = -1;
 	int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
 	int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
+	int submodule_errors_cli = -1; /* -1: not set on command line */
 	int fetch_write_commit_graph = -1;
 	int stdin_refspecs = 0;
 	int negotiate_only = 0;
@@ -2527,6 +2560,10 @@ int cmd_fetch(int argc,
 		OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-demand"),
 			    N_("control recursive fetching of submodules"),
 			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
+		OPT_CALLBACK_F(0, "submodule-errors", &submodule_errors_cli,
+			    N_("(fail|warn)"),
+			    N_("control how submodule fetch errors are handled"),
+			    0, option_parse_submodule_errors),
 		OPT_BOOL(0, "dry-run", &dry_run,
 			 N_("dry run")),
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
@@ -2616,6 +2653,9 @@ int cmd_fetch(int argc,
 	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
 		config.recurse_submodules = recurse_submodules_cli;
 
+	if (submodule_errors_cli != -1)
+		config.submodule_errors = submodule_errors_cli;
+
 	if (negotiate_only) {
 		switch (recurse_submodules_cli) {
 		case RECURSE_SUBMODULES_OFF:
@@ -2819,11 +2859,14 @@ int cmd_fetch(int argc,
 	if (!result && remote && (config.recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		struct strvec options = STRVEC_INIT;
 		int max_children = max_jobs;
+		int submodule_errors = config.submodule_errors;
 
 		if (max_children < 0)
 			max_children = config.submodule_fetch_jobs;
 		if (max_children < 0)
 			max_children = config.parallel;
+		if (submodule_errors < 0)
+			submodule_errors = SUBMODULE_ERRORS_FAIL;
 
 		add_options_to_argv(&options, &config);
 		trace2_region_enter_printf("fetch", "recurse-submodule", the_repository, "%s", submodule_prefix);
@@ -2833,7 +2876,8 @@ int cmd_fetch(int argc,
 					  config.recurse_submodules,
 					  recurse_submodules_default,
 					  verbosity < 0,
-					  max_children);
+					  max_children,
+					  submodule_errors);
 		trace2_region_leave_printf("fetch", "recurse-submodule", the_repository, "%s", submodule_prefix);
 		strvec_clear(&options);
 	}
diff --git a/submodule.c b/submodule.c
index 8bcef68a42..da4ace751f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1409,6 +1409,7 @@ struct submodule_parallel_fetch {
 	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;
 
 	struct strbuf submodules_with_errors;
+	int submodule_errors;
 };
 #define SPF_INIT { \
 	.args = STRVEC_INIT, \
@@ -1565,7 +1566,8 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 static void record_fetch_error(struct submodule_parallel_fetch *spf,
 			       const char *name)
 {
-	spf->result = 1;
+	if (spf->submodule_errors == SUBMODULE_ERRORS_FAIL)
+		spf->result = 1;
 	strbuf_addf(&spf->submodules_with_errors, "\t%s\n", name);
 }
 
@@ -1851,7 +1853,8 @@ int fetch_submodules(struct repository *r,
 		     const struct strvec *options,
 		     const char *prefix, int command_line_option,
 		     int default_option,
-		     int quiet, int max_parallel_jobs)
+		     int quiet, int max_parallel_jobs,
+		     int submodule_errors)
 {
 	struct submodule_parallel_fetch spf = SPF_INIT;
 	const struct run_process_parallel_opts opts = {
@@ -1871,6 +1874,7 @@ int fetch_submodules(struct repository *r,
 	spf.default_option = default_option;
 	spf.quiet = quiet;
 	spf.prefix = prefix;
+	spf.submodule_errors = submodule_errors;
 
 	if (!r->worktree)
 		goto out;
diff --git a/submodule.h b/submodule.h
index b10e16e6c0..c80b687d2a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -90,12 +90,17 @@ int should_update_submodules(void);
  */
 const struct submodule *submodule_from_ce(const struct cache_entry *ce);
 void check_for_new_submodule_commits(struct object_id *oid);
+/* Values for the submodule_errors parameter of fetch_submodules(). */
+#define SUBMODULE_ERRORS_FAIL 0  /* submodule fetch errors are fatal (default) */
+#define SUBMODULE_ERRORS_WARN 1  /* submodule fetch errors are non-fatal warnings */
+
 int fetch_submodules(struct repository *r,
 		     const struct strvec *options,
 		     const char *prefix,
 		     int command_line_option,
 		     int default_option,
-		     int quiet, int max_parallel_jobs);
+		     int quiet, int max_parallel_jobs,
+		     int submodule_errors);
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int submodule_uses_gitfile(const char *path);
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 188c674c89..504ab200ef 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1307,6 +1307,57 @@ test_expect_success 'setup for submodule fetch error tests' '
 	git config --global protocol.file.allow always
 '
 
+test_expect_success 'fetch --recurse-submodules fails when submodule commit is unreachable (default)' '
+	test_when_finished "rm -fr env_default" &&
+	create_err_env env_default &&
+	push_unreachable_commit env_default &&
+	test_must_fail git -C env_default/clone fetch --recurse-submodules 2>err &&
+	grep "Errors during submodule fetch" err
+'
+
+test_expect_success 'fetch.submoduleErrors=warn: unreachable submodule commit is non-fatal' '
+	test_when_finished "rm -fr env_warn_cfg" &&
+	create_err_env env_warn_cfg &&
+	push_unreachable_commit env_warn_cfg &&
+	git -C env_warn_cfg/clone -c fetch.submoduleErrors=warn \
+		fetch --recurse-submodules 2>err &&
+	grep "Errors during submodule fetch" err
+'
+
+test_expect_success '--submodule-errors=warn: unreachable submodule commit is non-fatal' '
+	test_when_finished "rm -fr env_warn_cli" &&
+	create_err_env env_warn_cli &&
+	push_unreachable_commit env_warn_cli &&
+	git -C env_warn_cli/clone fetch --recurse-submodules \
+		--submodule-errors=warn 2>err &&
+	grep "Errors during submodule fetch" err
+'
+
+test_expect_success '--submodule-errors=fail: unreachable submodule commit is fatal' '
+	test_when_finished "rm -fr env_fail_cli" &&
+	create_err_env env_fail_cli &&
+	push_unreachable_commit env_fail_cli &&
+	test_must_fail git -C env_fail_cli/clone fetch --recurse-submodules \
+		--submodule-errors=fail 2>err &&
+	grep "Errors during submodule fetch" err
+'
+
+test_expect_success 'fetch.submoduleErrors=warn does not suppress successful fetch' '
+	# A new reachable submodule commit (pushed to sub_bare) should be
+	# fetched without any error summary.
+	test_when_finished "rm -fr env_ok" &&
+	create_err_env env_ok &&
+	test_commit -C env_ok/sub_work reachable_ok &&
+	git -C env_ok/sub_work push &&
+	git -C env_ok/super_work submodule update --remote &&
+	git -C env_ok/super_work add sub &&
+	git -C env_ok/super_work commit -m "point sub to reachable commit" &&
+	git -C env_ok/super_work push &&
+	git -C env_ok/clone -c fetch.submoduleErrors=warn \
+		fetch --recurse-submodules 2>err &&
+	! grep "Errors during submodule fetch" err
+'
+
 test_expect_success 'failed submodule fetch is fatal even when its commits are present locally' '
 	# Create the same commit (unreferenced, via commit-tree with fixed
 	# dates) in both super_work/sub and clone/sub, point the gitlink at
@@ -1334,4 +1385,42 @@ test_expect_success 'failed submodule fetch is fatal even when its commits are p
 	grep "Errors during submodule fetch" err
 '
 
+test_expect_success '--submodule-errors=warn is honored by fetch --all' '
+	# A second remote forces fetch_multiple(), which hands the submodule
+	# recursion off to per-remote child processes; the option must be
+	# forwarded to them.
+	test_when_finished "rm -fr env_all" &&
+	create_err_env env_all &&
+	push_unreachable_commit env_all &&
+	git -C env_all/clone remote add second "$pwd/env_all/super_bare" &&
+	git -C env_all/clone fetch --all --recurse-submodules \
+		--submodule-errors=warn 2>err &&
+	grep "Errors during submodule fetch" err
+'
+
+test_expect_success '--submodule-errors=fail overrides warn config for fetch --all' '
+	# The per-remote child processes re-read the repository config, so
+	# the command-line override must be forwarded to them explicitly.
+	test_when_finished "rm -fr env_override" &&
+	create_err_env env_override &&
+	push_unreachable_commit env_override &&
+	git -C env_override/clone remote add second "$pwd/env_override/super_bare" &&
+	git -C env_override/clone config fetch.submoduleErrors warn &&
+	test_must_fail git -C env_override/clone fetch --all --recurse-submodules \
+		--submodule-errors=fail 2>err &&
+	grep "Errors during submodule fetch" err
+'
+
+test_expect_success 'fetch.submoduleErrors=warn: inaccessible submodule is non-fatal' '
+	test_when_finished "rm -fr env_access" &&
+	create_err_env env_access &&
+	rm env_access/clone/sub/.git &&
+	rm -r env_access/clone/.git/modules/sub &&
+	git -C env_access/clone -c fetch.submoduleErrors=warn \
+		fetch --recurse-submodules 2>err &&
+	grep "Could not access submodule" err &&
+	test_must_fail git -C env_access/clone fetch --recurse-submodules 2>err &&
+	grep "Could not access submodule" err
+'
+
 test_done
-- 
2.54.0


Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7DB32BF41
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686431; cv=none; b=No6LJCvNrdosGYtgWRoApMDcXkvNMSqfw+vQWcrUD8ngC62NCjgLMQVg/ZfHnZjDjkUalMiAI3mZi5VVUtj3Ig9mPpVKZnwsoeeWD1D/23jMspxm5K6a9ETCx54GgujGqNXZ35i4QKYII8B610VRcv5y7aqOo5CL7nrrhvDjnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686431; c=relaxed/simple;
	bh=ORQO5DwPWZ8x//NRSHD72UP620z4itL0yRdgslU6J8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVmf5Idh/irpwkPgGPEgH+rmkajN1SKMlkw9uJGabrs71w7tNfIYeW7Kpz4OCK44iIqCMYP03k0jY/NiHk6MYJRk+pyYFzMfzf3nwIobSqn+tAhDL6KkTucWk7nPbr7/jc0DpaRzeIxyDkGqyxiyRlkQO141VIIMFQ+Fk6XsKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdEyi6+c; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdEyi6+c"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15d5468673so119639166b.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 05:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783686427; x=1784291227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nC/FaidRePA5EHh219joaeUoIPV26yFrciI+8xxeRdk=;
        b=RdEyi6+cHRLFLH9nWCM6TLxpRAacEnJmhnrwpH5RQLtGLyFlfXs6U8chaPWJFZQQdv
         RXQGmi1wHvvvxN2PUBazQYa22xAWZ7zIwHhZRZGI18fdCnMhzsGt+LCNqK0P7kLnS6zs
         Lf71Jcdzy3BJPC6qkX2HOhqej/z4mXLFelo+ofSAEfBG5kyquwAgvFa+xvg9GYsyuEW0
         5+GsVpLzOX3SYKRzIs5+WVEZgKSs3zY0QVkExLaEJZFdlhMIP6M8JtSSMeeNNhTl/Qna
         H5yztgeEIx9qnNIPBglRHePCsaBsIcZ3h71O6dDYzlv5UIckEtwYi/8gW34gjiEOY7bM
         5/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783686427; x=1784291227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nC/FaidRePA5EHh219joaeUoIPV26yFrciI+8xxeRdk=;
        b=LFIT1aIPTkFAxSa7jNSrOJrAOga19bX7W0qbFXxWRjLD0vzhP/E2qsysDrcjIxOOoY
         Flvc4I42i6q9RZITlwQuGuUH+T0oBD6IjT9K5oeYbwgxlWR2nYM5k8FXeUDzvS5bGccN
         O9JdslvXqZREFauX51OFaL5d/Nk/6NzlO5lQGZU5mhrwZqM7UCiOB5lJyLR7YmYx2TEE
         30wC/+UpSwG6isSvN1Ed21nvc8fsuhBHRcGjY7tjWgHawsZVTIsEX+Aq5ihZbr4nqXs9
         OkWRoMwpvpYvAw+X6E4XRfI2gogiNk/5rXt2wam6iLsBeGC2VHAiaJ7aGl9nYEJY4WR1
         wYng==
X-Gm-Message-State: AOJu0YxAAnnRX0uuwtSFiqsagLCUVFkseLre4qCvwX44scaHN6JDAgv7
	uLLivthtmgPUwZHv0Sv39kUv2LcEZjyWBvOGlwV1DqOelfHunyhL2MVl48aM4e9n
X-Gm-Gg: AfdE7cmsMbNet8T43Rkd1feL3YHRhelieYOEmsqboNegNJgRbHJVjJS0Cn+4AIXSYsC
	XVk7loOn+1ZQkD9ipDWEhE8wqMBxR+hf1/JJoqWLTalWazkrpsAuu3PKog+vEYws49kklxoK69l
	gXfD8yQEQwbIuk82j/dORuLHWmokAXGdEyu7zMg9/BUyp4RTAcK5F2woaZfqjbmcd2eYLUDfYvY
	ZfX1dwStnpN3I1wtS3OZr+LNOndNvvnkcmM4yZgLMkCZwFE6/umLxTVNqu/fxZk9MZQAtdxYgpp
	3WF57fdUNGN2xla5gYarjfat3/lEE0vckpTQ663KxLQjeFimSKzpwoQArrCp+i4WB+1gupl/V7p
	JoMXuiG8L0sje53HCSeS1cUFyUqYxnCZ5ti1+/QFqB3ZTEAxer1Exr0chQTIMaurUoxMnC5PiG2
	fycb5YYmBhjrk0ErQBbXxT62GnBwwPbnIXYenGdfQbSTTDbhUnE2xVCoUZ9iAfzupxR9P7sXWbC
	WzVnbnQXhzIf3tdspHJYZUNlrMYSgRTUHAEY+q4ofo4Gg==
X-Received: by 2002:a17:907:bd81:b0:c12:a469:c with SMTP id a640c23a62f3a-c15cded3365mr493365366b.9.1783686427317;
        Fri, 10 Jul 2026 05:27:07 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ce1b374asm405212966b.60.2026.07.10.05.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 05:27:06 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: git@vger.kernel.org
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Glen Choo <glencbz@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/2] fetch: add fetch.submoduleErrors to make submodule fetch errors non-fatal
Date: Fri, 10 Jul 2026 15:26:53 +0300
Message-ID: <20260710122655.3066377-3-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710122655.3066377-1-paulius.zaleckas@gmail.com>
References: <20260710122655.3066377-1-paulius.zaleckas@gmail.com>
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
nested submodule recursion.

Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 Documentation/config/fetch.adoc  | 14 ++++++
 Documentation/fetch-options.adoc |  8 ++++
 builtin/fetch.c                  | 41 ++++++++++++++++-
 submodule.c                      |  8 +++-
 submodule.h                      |  7 ++-
 t/t5526-fetch-submodules.sh      | 76 ++++++++++++++++++++++++++++++++
 6 files changed, 150 insertions(+), 4 deletions(-)

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
index c1d7c672f4..40daaf5cc7 100644
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
@@ -2205,6 +2219,8 @@ static void add_options_to_argv(struct strvec *argv,
 		strvec_push(argv, "--no-recurse-submodules");
 	else if (config->recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
 		strvec_push(argv, "--recurse-submodules=on-demand");
+	if (config->submodule_errors == SUBMODULE_ERRORS_WARN)
+		strvec_push(argv, "--submodule-errors=warn");
 	if (tags == TAGS_SET)
 		strvec_push(argv, "--tags");
 	else if (tags == TAGS_UNSET)
@@ -2464,6 +2480,19 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
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
@@ -2477,6 +2506,7 @@ int cmd_fetch(int argc,
 		.recurse_submodules = RECURSE_SUBMODULES_DEFAULT,
 		.parallel = 1,
 		.submodule_fetch_jobs = -1,
+		.submodule_errors = SUBMODULE_ERRORS_FAIL,
 	};
 	const char *submodule_prefix = "";
 	const char *bundle_uri;
@@ -2491,6 +2521,7 @@ int cmd_fetch(int argc,
 	int max_jobs = -1;
 	int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
 	int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
+	int submodule_errors_cli = -1; /* -1: not set on command line */
 	int fetch_write_commit_graph = -1;
 	int stdin_refspecs = 0;
 	int negotiate_only = 0;
@@ -2527,6 +2558,10 @@ int cmd_fetch(int argc,
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
@@ -2616,6 +2651,9 @@ int cmd_fetch(int argc,
 	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
 		config.recurse_submodules = recurse_submodules_cli;
 
+	if (submodule_errors_cli != -1)
+		config.submodule_errors = submodule_errors_cli;
+
 	if (negotiate_only) {
 		switch (recurse_submodules_cli) {
 		case RECURSE_SUBMODULES_OFF:
@@ -2833,7 +2871,8 @@ int cmd_fetch(int argc,
 					  config.recurse_submodules,
 					  recurse_submodules_default,
 					  verbosity < 0,
-					  max_children);
+					  max_children,
+					  config.submodule_errors);
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
index 188c674c89..b5db8fb5c2 100755
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
@@ -1334,4 +1385,29 @@ test_expect_success 'failed submodule fetch is fatal even when its commits are p
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


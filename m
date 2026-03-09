Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82A3CC9EE
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063546; cv=pass; b=Cci5UvakD+xTifa8ZEWWOXmXOKFIaVlGW/IKntqHT5zEdWOS96J7ixvIbSIDV2TGZ9/6AAW5UA66o7LyRxw8O68mb0145h6h+laDRiOoUELepuVNAVFC0a6iFx37QaTxC2Gr2+LS9dGsuiFxt3/ySLnuEeg5lmWpCozs4Lh9Ej0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063546; c=relaxed/simple;
	bh=TO8Smm0wTZPlWMk6aDpOEzODaBNlx8dhGQznT+5s4PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PThSEQmkGdXjCsI9i3Bz88UPk0m3E/8f30rwYFsJ1RwCqVMVCdxdYbOY/52LTKsuMKHfE7dKZ5xrCebwtT6xe36CK8vgpr17WC8ftw2iHdjPX8Vmjj6ybhIEEje2FMzx6NIUHiNXj2IAjY9IYMBugHhR9+szkSghzxEpV7Bfk30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=hRqChBrE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="hRqChBrE"
ARC-Seal: i=1; a=rsa-sha256; t=1773063521; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=feSnGj1exbsQlXVF8XttsOf53ONyPMhEu+IEt1bfolMhOSMe5nImHE9nbtyZLkDPvuy9cuXa9nH0sBarfeTQt5NBEEFzZinBkee5t7YM1gxPKkqb+dj/hdbAZU/MZRnlO9pLdED/k4YAEHBNjzieu83EGYuOWm5orhJ4Svss2ow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773063521; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nc1sOhVgkkIvFDXwYZmuFsJa02uGFlf/+JeEaQsgos4=; 
	b=EDvqUn0wB6NYAfTyU2zyhBNaryfKx4aIZacltlpWP2Y2Shs8iomAkHHbIWLf2Uu5GWKEEl0aDm1VHNQdPt9NXr4McommNYm8Ovjn96XC2YVDlxGYQb+t+e9O0juZNTNFn7IQBYI5x3A+UhErzRbWzQNOt2Ua4xAXRfXvRBzsMrE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773063521;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nc1sOhVgkkIvFDXwYZmuFsJa02uGFlf/+JeEaQsgos4=;
	b=hRqChBrEzZ3vZ9TV3yGzNCuJ7D/WGhSjKJwkRMyD0IgOMe6PeSQv8Og9cPZ6fStC
	HQHxAR7Pdi/N9BOKjjaGz2rSCwbVp9AFpXv9iJLWCpYlBLe5JOJQKYBmMd5osWxMNrb
	fqTnDd1Nev5ISiuKFrHxcYwnoGnFkMtKjLeb4KC4=
Received: by mx.zohomail.com with SMTPS id 1773063518353148.54498004842424;
	Mon, 9 Mar 2026 06:38:38 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Emily Shaffer <nasamuffin@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 4/9] hook: allow parallel hook execution
Date: Mon,  9 Mar 2026 15:37:34 +0200
Message-ID: <20260309133739.294555-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260309133739.294555-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <nasamuffin@google.com>

Hooks always run in sequential order due to the hardcoded jobs == 1
passed to run_process_parallel(). Remove that hardcoding to allow
users to run hooks in parallel (opt-in).

Users need to decide which hooks to run in parallel, by specifying
"parallel = true" in the config, because git cannot know if their
specific hooks are safe to run or not in parallel (for e.g. two hooks
might write to the same file or call the same program).

Some hooks are unsafe to run in parallel by design: these will marked
in the next commit using RUN_HOOKS_OPT_INIT_FORCE_SERIAL.

The hook.jobs config specifies the default number of jobs applied to all
hooks which have parallelism enabled.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc |  13 +++
 hook.c                         |  66 +++++++++++++--
 hook.h                         |  25 ++++++
 t/t1800-hook.sh                | 142 +++++++++++++++++++++++++++++++++
 4 files changed, 240 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index b7847f9338..45811d1032 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -23,6 +23,19 @@ hook.<friendly-name>.enabled::
 	in a system or global config file and needs to be disabled for a
 	specific repository. See linkgit:git-hook[1].
 
+hook.<name>.parallel::
+	Whether the hook `hook.<name>` may run in parallel with other hooks
+	for the same event. Defaults to `false`. Set to `true` only when the
+	hook script is safe to run concurrently with other hooks for the same
+	event. If any hook for an event does not have this set to `true`,
+	all hooks for that event run sequentially regardless of `hook.jobs`.
+	Only configured (named) hooks need to declare this. Traditional hooks
+	found in the hooks directory do not need to, and run in parallel when
+	the effective job count is greater than 1. See linkgit:git-hook[1].
+
 hook.jobs::
 	Specifies how many hooks can be run simultaneously during parallelized
 	hook execution. If unspecified, defaults to 1 (serial execution).
++
+This setting has no effect unless all configured hooks for the event have
+`hook.<name>.parallel` set to `true`.
diff --git a/hook.c b/hook.c
index e6e44a5fcb..815b299bf8 100644
--- a/hook.c
+++ b/hook.c
@@ -120,6 +120,7 @@ struct hook_config_cache_entry {
 	char *command;
 	enum config_scope scope;
 	int disabled;
+	unsigned int parallel:1;
 };
 
 /*
@@ -127,12 +128,14 @@ struct hook_config_cache_entry {
  * commands: friendly-name to command map.
  * event_hooks: event-name to list of friendly-names map.
  * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
+ * parallel_hooks: friendly-name to parallel flag.
  * jobs: value of the global hook.jobs key. Defaults to 0 if unset.
  */
 struct hook_all_config_cb {
 	struct strmap commands;
 	struct strmap event_hooks;
 	struct string_list disabled_hooks;
+	struct strmap parallel_hooks;
 	unsigned int jobs;
 };
 
@@ -223,6 +226,10 @@ static int hook_config_lookup_all(const char *key, const char *value,
 		default:
 			break; /* ignore unrecognised values */
 		}
+	} else if (!strcmp(subkey, "parallel")) {
+		int v = git_parse_maybe_bool(value);
+		if (v >= 0)
+			strmap_put(&data->parallel_hooks, hook_name, (void *)(uintptr_t)v);
 	}
 
 	free(hook_name);
@@ -268,6 +275,7 @@ static void build_hook_config_map(struct repository *r,
 	strmap_init(&cb_data.commands);
 	strmap_init(&cb_data.event_hooks);
 	string_list_init_dup(&cb_data.disabled_hooks);
+	strmap_init(&cb_data.parallel_hooks);
 
 	/* Parse all configs in one run, capturing hook.* including hook.jobs. */
 	repo_config(r, hook_config_lookup_all, &cb_data);
@@ -285,6 +293,7 @@ static void build_hook_config_map(struct repository *r,
 			enum config_scope scope =
 				(enum config_scope)(uintptr_t)hook_names->items[i].util;
 			struct hook_config_cache_entry *entry;
+			void *par = strmap_get(&cb_data.parallel_hooks, hname);
 			char *command;
 
 			int is_disabled =
@@ -307,6 +316,7 @@ static void build_hook_config_map(struct repository *r,
 			entry->command = command ? xstrdup(command) : NULL;
 			entry->scope = scope;
 			entry->disabled = is_disabled;
+			entry->parallel = (int)(uintptr_t)par;
 			string_list_append(hooks, hname)->util = entry;
 		}
 
@@ -316,6 +326,7 @@ static void build_hook_config_map(struct repository *r,
 	cache->jobs = cb_data.jobs;
 
 	strmap_clear(&cb_data.commands, 1);
+	strmap_clear(&cb_data.parallel_hooks, 0); /* values are uintptr_t, not heap ptrs */
 	string_list_clear(&cb_data.disabled_hooks, 0);
 	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
 		string_list_clear(e->value, 0);
@@ -392,6 +403,7 @@ static void list_hooks_add_configured(struct repository *r,
 			entry->command ? xstrdup(entry->command) : NULL;
 		hook->u.configured.scope = entry->scope;
 		hook->u.configured.disabled = entry->disabled;
+		hook->parallel = entry->parallel;
 
 		string_list_append(list, friendly_name)->util = hook;
 	}
@@ -541,21 +553,67 @@ static void run_hooks_opt_clear(struct run_hooks_opt *options)
 	strvec_clear(&options->args);
 }
 
+/* Determine how many jobs to use for hook execution. */
+static unsigned int get_hook_jobs(struct repository *r,
+				  struct run_hooks_opt *options,
+				  struct string_list *hook_list)
+{
+	unsigned int jobs;
+
+	/*
+	 * Hooks needing separate output streams must run sequentially. Next
+	 * commits will add an extension to allow parallelizing these as well.
+	 */
+	if (!options->stdout_to_stderr)
+		return 1;
+
+	/* An explicit job count (FORCE_SERIAL jobs=1, or -j from CLI). */
+	if (options->jobs)
+		return options->jobs;
+
+	/*
+	 * Use hook.jobs from the already-parsed config cache (in-repo), or
+	 * fall back to a direct config lookup (out-of-repo).  Default to 1.
+	 */
+	if (r && r->gitdir && r->hook_config_cache)
+		/* Use the already-parsed cache (in-repo) */
+		jobs = r->hook_config_cache->jobs ? r->hook_config_cache->jobs : 1;
+	else
+		/* No cache present (out-of-repo call), use direct cfg lookup */
+		jobs = repo_config_get_uint(r, "hook.jobs", &jobs) ? 1 : jobs;
+
+	/*
+	 * Cap to serial any configured hook not marked as parallel = true.
+	 * This enforces the parallel = false default, even for "traditional"
+	 * hooks from the hookdir which cannot be marked parallel = true.
+	 */
+	for (size_t i = 0; jobs > 1 && i < hook_list->nr; i++) {
+		struct hook *h = hook_list->items[i].util;
+		if (h->kind == HOOK_CONFIGURED && !h->parallel)
+			jobs = 1;
+	}
+
+	return jobs;
+}
+
 int run_hooks_opt(struct repository *r, const char *hook_name,
 		  struct run_hooks_opt *options)
 {
+	struct string_list *hook_list = list_hooks(r, hook_name, options);
 	struct hook_cb_data cb_data = {
 		.rc = 0,
 		.hook_name = hook_name,
+		.hook_command_list = hook_list,
 		.options = options,
 	};
 	int ret = 0;
+	unsigned int jobs = get_hook_jobs(r, options, hook_list);
 	const struct run_process_parallel_opts opts = {
 		.tr2_category = "hook",
 		.tr2_label = hook_name,
 
-		.processes = options->jobs,
-		.ungroup = options->jobs == 1,
+		.processes = jobs,
+		.ungroup = jobs == 1,
 
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
@@ -571,9 +629,6 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	if (options->path_to_stdin && options->feed_pipe)
 		BUG("options path_to_stdin and feed_pipe are mutually exclusive");
 
-	if (!options->jobs)
-		BUG("run_hooks_opt must be called with options.jobs >= 1");
-
 	/*
 	 * Ensure cb_data copy and free functions are either provided together,
 	 * or neither one is provided.
@@ -584,7 +639,6 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
-	cb_data.hook_command_list = list_hooks(r, hook_name, options);
 	if (!cb_data.hook_command_list->nr) {
 		if (options->error_if_missing)
 			ret = error("cannot find a hook named %s", hook_name);
diff --git a/hook.h b/hook.h
index a7eab00480..a0f6a9db47 100644
--- a/hook.h
+++ b/hook.h
@@ -35,6 +35,13 @@ struct hook {
 		} configured;
 	} u;
 
+	/**
+	 * Whether this hook may run in parallel with other hooks for the same
+	 * event. Only useful for configured (named) hooks. Traditional hooks
+	 * always default to 0 (serial). Set via `hook.<name>.parallel = true`.
+	 */
+	unsigned int parallel:1;
+
 	/**
 	 * Opaque data pointer used to keep internal state across callback calls.
 	 *
@@ -73,6 +80,8 @@ struct run_hooks_opt
 	 *
 	 * If > 1, output will be buffered and de-interleaved (ungroup=0).
 	 * If == 1, output will be real-time (ungroup=1).
+	 * If == 0, the 'hook.jobs' config is used or, if the config is unset,
+	 * defaults to 1 (serial execution).
 	 */
 	unsigned int jobs;
 
@@ -153,7 +162,23 @@ struct run_hooks_opt
 	hook_data_free_fn feed_pipe_cb_data_free;
 };
 
+/**
+ * Default initializer for hooks. Parallelism is opt-in: .jobs = 0 defers to
+ * the 'hook.jobs' config, falling back to serial (1) if unset.
+ */
 #define RUN_HOOKS_OPT_INIT { \
+	.env = STRVEC_INIT, \
+	.args = STRVEC_INIT, \
+	.stdout_to_stderr = 1, \
+	.jobs = 0, \
+}
+
+/**
+ * Initializer for hooks that must always run sequentially regardless of
+ * 'hook.jobs'. Use this when git knows the hook cannot safely be parallelized
+ * .jobs = 1 is non-overridable.
+ */
+#define RUN_HOOKS_OPT_INIT_FORCE_SERIAL { \
 	.env = STRVEC_INIT, \
 	.args = STRVEC_INIT, \
 	.stdout_to_stderr = 1, \
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index cbf7d2bf80..57733e8a73 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -21,6 +21,57 @@ setup_hookdir () {
 	test_when_finished rm -rf .git/hooks
 }
 
+# write_sentinel_hook <path> [sentinel]
+#
+# Writes a hook that marks itself as started, sleeps for a few seconds, then
+# marks itself done. The sleep must be long enough that sentinel_detector can
+# observe <sentinel>.started before <sentinel>.done appears when both hooks
+# run concurrently in parallel mode.
+write_sentinel_hook () {
+	sentinel="${2:-sentinel}"
+	write_script "$1" <<-EOF
+	touch ${sentinel}.started &&
+	sleep 2 &&
+	touch ${sentinel}.done
+	EOF
+}
+
+# sentinel_detector <sentinel> <output>
+#
+# Returns a shell command string suitable for use as hook.<name>.command.
+# The detector must be registered after the sentinel:
+# 1. In serial mode, the sentinel has completed (and <sentinel>.done exists)
+#    before the detector starts.
+# 2. In parallel mode, both run concurrently so <sentinel>.done has not appeared
+#    yet and the detector just sees <sentinel>.started.
+#
+# At start, poll until <sentinel>.started exists to absorb startup jitter, then
+# write to <output>:
+# 1. 'serial'   if <sentinel>.done exists (sentinel finished before we started),
+# 2. 'parallel' if only <sentinel>.started exists (sentinel still running),
+# 3. 'timeout'  if <sentinel>.started never appeared.
+#
+# The command ends with ':' so when git appends "$@" for hooks that receive
+# positional arguments (e.g. pre-push), the result ': "$@"' is valid shell
+# rather than a syntax error 'fi "$@"'.
+sentinel_detector () {
+	cat <<-EOF
+	i=0
+	while ! test -f ${1}.started && test \$i -lt 10; do
+	    sleep 1
+	    i=\$((i+1))
+	done
+	if test -f ${1}.done; then
+	    echo serial >${2}
+	elif test -f ${1}.started; then
+	    echo parallel >${2}
+	else
+	    echo timeout >${2}
+	fi
+	:
+	EOF
+}
+
 test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook &&
 	test_expect_code 129 git hook run &&
@@ -626,4 +677,95 @@ test_expect_success 'server push-to-checkout hook expects stdout redirected to s
 	check_stdout_merged_to_stderr push-to-checkout
 '
 
+test_expect_success 'hook.jobs=1 config runs hooks in series' '
+	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
+
+	# Use two configured hooks so the execution order is deterministic:
+	# hook-1 (sentinel) is listed before hook-2 (detector), so hook-1
+	# always runs first even in serial mode.
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command \
+	    "touch sentinel.started; sleep 2; touch sentinel.done" &&
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+
+	test_config hook.jobs 1 &&
+
+	git hook run test-hook >out 2>err &&
+	echo serial >expect &&
+	test_cmp expect hook.order
+'
+
+test_expect_success 'hook.jobs=2 config runs hooks in parallel' '
+	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
+	test_when_finished "rm -rf .git/hooks" &&
+
+	mkdir -p .git/hooks &&
+	write_sentinel_hook .git/hooks/test-hook &&
+
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+	test_config hook.hook-2.parallel true &&
+
+	test_config hook.jobs 2 &&
+
+	git hook run test-hook >out 2>err &&
+	echo parallel >expect &&
+	test_cmp expect hook.order
+'
+
+test_expect_success 'hook.<name>.parallel=true enables parallel execution' '
+	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command \
+	    "touch sentinel.started; sleep 2; touch sentinel.done" &&
+	test_config hook.hook-1.parallel true &&
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+	test_config hook.hook-2.parallel true &&
+
+	test_config hook.jobs 2 &&
+
+	git hook run test-hook >out 2>err &&
+	echo parallel >expect &&
+	test_cmp expect hook.order
+'
+
+test_expect_success 'hook.<name>.parallel=false (default) forces serial execution' '
+	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command \
+	    "touch sentinel.started; sleep 2; touch sentinel.done" &&
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+
+	test_config hook.jobs 2 &&
+
+	git hook run test-hook >out 2>err &&
+	echo serial >expect &&
+	test_cmp expect hook.order
+'
+
+test_expect_success 'one non-parallel hook forces the whole event to run serially' '
+	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command \
+	    "touch sentinel.started; sleep 2; touch sentinel.done" &&
+	test_config hook.hook-1.parallel true &&
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+	# hook-2 has no parallel=true: should force serial for all
+
+	test_config hook.jobs 2 &&
+
+	git hook run test-hook >out 2>err &&
+	echo serial >expect &&
+	test_cmp expect hook.order
+'
+
 test_done
-- 
2.52.0.732.gb351b5166d.dirty


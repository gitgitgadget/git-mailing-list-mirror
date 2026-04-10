Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC733B4EA1
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812041; cv=pass; b=HuJqRWRBUM7psFghy9/Kcj7hIzLWCmrssGuvQ9g6FF/FU2S9nDQN8PeSyJa2Ct1RspHLU4wfJ+WOB7yhgcZ+rpqYIEediS/8/+McSnFSgeVV+QkySYmH3NhOrhQEgGWDxEKovAVbCMPKQ0BK8QlMUktlBG/xKh0pSV+p4MXOFVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812041; c=relaxed/simple;
	bh=ZkSiXTEo2u5UjKxxPXOnITMvyLcyHk1hVY9Mtj1k1ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzDiui7Dl7YiwI7GxXaysq0CkzmLPqXBhhmWPpCMxwE5lf5SU+xIJT/ef8XyzefEGMdBmCXbuhNlum1iSRnO3ktD2Wk7K3H7+lfFr+zheKRuO3TN2toRcXMj6tlGyrQuhS6EkHFN9IKbdnz9GKVcNawQBtlNsBw3j090bvU7MZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=az9/A6f6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="az9/A6f6"
ARC-Seal: i=1; a=rsa-sha256; t=1775812023; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GvGr7HJOmPULSEep2c2MNr6qqjPDYuMsIgSlwvnC1a+WcF+voPGOLoUqzbhALUmiY+9aWcweZJ4HXusYXFF3zlkziNlh5lalJuZI7JfguoXBwt7cRg9lv9+IpojAK8k4aCkppePdXepsIDRM1F2Nqpw9KPbWMWGDKgJdUr9hF24=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775812023; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SA1O/BJ/VzqzO5u+Kxy+ug/DyvY5gwLCAGXhSfCdorw=; 
	b=WSKnom8LHnKue/5AOxacJMclLVXGZk8L9vyMxJfSiI5T2BOUMmy62M/nYRjp1KibZoYKNoloU3c+8fCb60Vz0ckUPWAknkcXPANFEydk4I7eB7ZuivHsEQRj1pSNO8R1xay2SThnM0XnOrehoNFbcPKdjhB/RnDyuufkMZPeOI8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775812023;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SA1O/BJ/VzqzO5u+Kxy+ug/DyvY5gwLCAGXhSfCdorw=;
	b=az9/A6f64avb/uoVwlBkarSOGzanAjHRkhpMgusa6azgDj5FPsJfX5/etf4XATGs
	ucAi6bxwjVgGqzDWksdMoog+xmIZKBVuPG6jk+11FkitnFMOvXYLYwrAVXISjUfa6rZ
	chK0OK6KJkbgsiuiieXtU/W51SwGzr1ABVd6EW5Q=
Received: by mx.zohomail.com with SMTPS id 1775812021955466.8271004295161;
	Fri, 10 Apr 2026 02:07:01 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v7 07/13] hook: add -j/--jobs option to git hook run
Date: Fri, 10 Apr 2026 12:06:02 +0300
Message-ID: <20260410090608.75283-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410090608.75283-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260410090608.75283-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

Expose the parallel job count as a command-line flag so callers can
request parallelism without relying only on the hook.jobs config.

Add tests covering serial/parallel execution and TTY behaviour under
-j1 vs -jN.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/git-hook.adoc |  23 +++++-
 builtin/hook.c              |   5 +-
 hook.c                      |  17 +++++
 t/t1800-hook.sh             | 135 ++++++++++++++++++++++++++++++++++--
 4 files changed, 170 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 318c637bd8..46ea52db55 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -8,7 +8,8 @@ git-hook - Run git hooks
 SYNOPSIS
 --------
 [verse]
-'git hook' run [--allow-unknown-hook-name] [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
+'git hook' run [--allow-unknown-hook-name] [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]
+	<hook-name> [-- <hook-args>]
 'git hook' list [--allow-unknown-hook-name] [-z] [--show-scope] <hook-name>
 
 DESCRIPTION
@@ -147,6 +148,23 @@ OPTIONS
 	mirroring the output style of `git config --show-scope`. Traditional
 	hooks from the hookdir are unaffected.
 
+-j::
+--jobs::
+	Only valid for `run`.
++
+Specify how many hooks to run simultaneously. If this flag is not specified,
+the value of the `hook.jobs` config is used, see linkgit:git-config[1]. If
+neither is specified, defaults to 1 (serial execution).
++
+When greater than 1, it overrides the per-hook `hook.<friendly-name>.parallel`
+setting, allowing all hooks for the event to run concurrently, even if they
+are not individually marked as parallel.
++
+Some hooks always run sequentially regardless of this flag or the
+`hook.jobs` config, because git knows they cannot safely run in parallel:
+`applypatch-msg`, `pre-commit`, `prepare-commit-msg`, `commit-msg`,
+`post-commit`, `post-checkout`, and `push-to-checkout`.
+
 WRAPPERS
 --------
 
@@ -169,7 +187,8 @@ running:
 git hook run --allow-unknown-hook-name mywrapper-start-tests \
   # providing something to stdin
   --stdin some-tempfile-123 \
-  # execute hooks in serial
+  # execute multiple hooks in parallel
+  --jobs 3 \
   # plus some arguments of your own...
   -- \
   --testname bar \
diff --git a/builtin/hook.c b/builtin/hook.c
index c0585587e5..bea0668b47 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -8,7 +8,8 @@
 #include "parse-options.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
-	N_("git hook run [--allow-unknown-hook-name] [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
+	N_("git hook run [--allow-unknown-hook-name] [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]\n" \
+	   "<hook-name> [-- <hook-args>]")
 #define BUILTIN_HOOK_LIST_USAGE \
 	N_("git hook list [--allow-unknown-hook-name] [-z] [--show-scope] <hook-name>")
 
@@ -132,6 +133,8 @@ static int run(int argc, const char **argv, const char *prefix,
 			 N_("silently ignore missing requested <hook-name>")),
 		OPT_STRING(0, "to-stdin", &opt.path_to_stdin, N_("path"),
 			   N_("file to read into hooks' stdin")),
+		OPT_UNSIGNED('j', "jobs", &opt.jobs,
+			    N_("run up to <n> hooks simultaneously")),
 		OPT_END(),
 	};
 	int ret;
diff --git a/hook.c b/hook.c
index 25762b6c8d..c0b71322cf 100644
--- a/hook.c
+++ b/hook.c
@@ -568,6 +568,22 @@ static void merge_output_if_parallel(struct run_hooks_opt *options)
 		options->stdout_to_stderr = 1;
 }
 
+static void warn_non_parallel_hooks_override(unsigned int jobs,
+					     struct string_list *hook_list)
+{
+	/* Don't warn for hooks running sequentially. */
+	if (jobs == 1)
+		return;
+
+	for (size_t i = 0; i < hook_list->nr; i++) {
+		struct hook *h = hook_list->items[i].util;
+		if (h->kind == HOOK_CONFIGURED && !h->parallel)
+			warning(_("hook '%s' is not marked as parallel=true, "
+				  "running in parallel anyway due to -j%u"),
+				h->u.configured.friendly_name, jobs);
+	}
+}
+
 /* Determine how many jobs to use for hook execution. */
 static unsigned int get_hook_jobs(struct repository *r,
 				  struct run_hooks_opt *options,
@@ -611,6 +627,7 @@ static unsigned int get_hook_jobs(struct repository *r,
 
 cleanup:
 	merge_output_if_parallel(options);
+	warn_non_parallel_hooks_override(options->jobs, hook_list);
 	return options->jobs;
 }
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 63fa25bca2..aa37a5181a 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -268,10 +268,20 @@ test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
 '
 
 test_hook_tty () {
-	cat >expect <<-\EOF
-	STDOUT TTY
-	STDERR TTY
-	EOF
+	expect_tty=$1
+	shift
+
+	if test "$expect_tty" != "no_tty"; then
+		cat >expect <<-\EOF
+		STDOUT TTY
+		STDERR TTY
+		EOF
+	else
+		cat >expect <<-\EOF
+		STDOUT NO TTY
+		STDERR NO TTY
+		EOF
+	fi
 
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -289,12 +299,21 @@ test_hook_tty () {
 	test_cmp expect repo/actual
 }
 
-test_expect_success TTY 'git hook run: stdout and stderr are connected to a TTY' '
-	test_hook_tty hook run pre-commit
+test_expect_success TTY 'git hook run -j1: stdout and stderr are connected to a TTY' '
+	# hooks running sequentially (-j1) are always connected to the tty for
+	# optimum real-time performance.
+	test_hook_tty tty hook run -j1 pre-commit
+'
+
+test_expect_success TTY 'git hook run -jN: stdout and stderr are not connected to a TTY' '
+	# Hooks are not connected to the tty when run in parallel, instead they
+	# output to a pipe through which run-command collects and de-interlaces
+	# their outputs, which then gets passed either to the tty or a sideband.
+	test_hook_tty no_tty hook run -j2 pre-commit
 '
 
 test_expect_success TTY 'git commit: stdout and stderr are connected to a TTY' '
-	test_hook_tty commit -m"B.new"
+	test_hook_tty tty commit -m"B.new"
 '
 
 test_expect_success 'git hook list orders by config order' '
@@ -709,6 +728,108 @@ test_expect_success 'server push-to-checkout hook expects stdout redirected to s
 	check_stdout_merged_to_stderr push-to-checkout
 '
 
+test_expect_success 'parallel hook output is not interleaved' '
+	test_when_finished "rm -rf .git/hooks" &&
+
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo "Hook 1 Start"
+	sleep 1
+	echo "Hook 1 End"
+	EOF
+
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+		    "echo \"Hook 2 Start\"; sleep 2; echo \"Hook 2 End\"" &&
+	test_config hook.hook-2.parallel true &&
+	test_config hook.hook-3.event test-hook &&
+	test_config hook.hook-3.command \
+		    "echo \"Hook 3 Start\"; sleep 3; echo \"Hook 3 End\"" &&
+	test_config hook.hook-3.parallel true &&
+
+	git hook run --allow-unknown-hook-name -j3 test-hook >out 2>err.parallel &&
+
+	# Verify Hook 1 output is grouped
+	sed -n "/Hook 1 Start/,/Hook 1 End/p" err.parallel >hook1_out &&
+	test_line_count = 2 hook1_out &&
+
+	# Verify Hook 2 output is grouped
+	sed -n "/Hook 2 Start/,/Hook 2 End/p" err.parallel >hook2_out &&
+	test_line_count = 2 hook2_out &&
+
+	# Verify Hook 3 output is grouped
+	sed -n "/Hook 3 Start/,/Hook 3 End/p" err.parallel >hook3_out &&
+	test_line_count = 2 hook3_out
+'
+
+test_expect_success 'git hook run -j1 runs hooks in series' '
+	test_when_finished "rm -rf .git/hooks" &&
+
+	test_config hook.series-1.event "test-hook" &&
+	test_config hook.series-1.command "echo 1" --add &&
+	test_config hook.series-2.event "test-hook" &&
+	test_config hook.series-2.command "echo 2" --add &&
+
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo 3
+	EOF
+
+	cat >expected <<-\EOF &&
+	1
+	2
+	3
+	EOF
+
+	git hook run --allow-unknown-hook-name -j1 test-hook 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook run -j2 runs hooks in parallel' '
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
+	git hook run --allow-unknown-hook-name -j2 test-hook >out 2>err &&
+	echo parallel >expect &&
+	test_cmp expect hook.order
+'
+
+test_expect_success 'git hook run -j2 overrides parallel=false' '
+	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command \
+	    "touch sentinel.started; sleep 2; touch sentinel.done" &&
+	# hook-1 intentionally has no parallel=true
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+	# hook-2 also has no parallel=true
+
+	# -j2 overrides parallel=false; hooks run in parallel with a warning.
+	git hook run --allow-unknown-hook-name -j2 test-hook >out 2>err &&
+	echo parallel >expect &&
+	test_cmp expect hook.order
+'
+
+test_expect_success 'git hook run -j2 warns for hooks not marked parallel=true' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "true" &&
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command "true" &&
+	# neither hook has parallel=true
+
+	git hook run --allow-unknown-hook-name -j2 test-hook >out 2>err &&
+	grep "hook .hook-1. is not marked as parallel=true" err &&
+	grep "hook .hook-2. is not marked as parallel=true" err
+'
+
 test_expect_success 'hook.jobs=1 config runs hooks in series' '
 	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
 
-- 
2.52.0


Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AFB242D67
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 00:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065662; cv=none; b=B1jmMAsKhhbg70F9U/gKeRQoZsVlXWOG/eBzuzroDUPv03ggd8RW/JMwxd4upHEGZzi/H3dJeMtUtlextek0McQNh67yXEmLo+62Q1HOaJdrxCM7oRRo8tJ+Im8vNvi+OJbMABM3uSVrLxL/iIOAEGUXv3BXX1CVr2Ok0Y8LsD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065662; c=relaxed/simple;
	bh=Sz7Lt7pJP+zXlWyOyieOr2OBnfkRJy2aiI3ybYsMWCg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=M0uBQUgIglExY8l3sCUjEo9ArNUfmuuGPTM8zq5d2zg+rr50qlmwQnf03iIOhA6QdPrUmMw94Pc9hC6K1O8d7msP/hXTWESMVTdSmeNo6Qc45uXvcVxocNyS1ECiCso1oCRd02tFV5CUmQ1G2Zz0XQwOcvYcBZHY4fgyAZhVAEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj+Ukox1; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj+Ukox1"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12776bebe9fso601179c88.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772065659; x=1772670459; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LYtMiJ64hOo8+lkj+izFgE4rdJNmMrlfm8z/RrZBl4=;
        b=nj+Ukox1Gebdak7ZcPuSf8UnYkHtBvLSLQr81fnpWBslVYvB39eX4GPuSUHVSFGbu0
         OB3SypxKmnV294l8VnuUVUm/H/k7iS0Aj1fTLgnqBvqlr7e5JK+WjY6yMgqHgyAgWUnJ
         NY3g+7bvbY9tsTJQYAIx4bJNJEtXhQqV7Q+26gj1T8NNoM5TL/09YAus3aaH1mEiS+Yz
         Uxo/49dOMT43k8/iXMDj+s4ZIyN01EZb2odZyu3lpkWpmsrSZ8KvvBfOehK/RkOWFURu
         0KAMNRHDRJSg+lrPjcC9STb4wSLE0SgQvb2Wdulo0mx8lxxD6wMDgWEsfuS0I4L5HotA
         4xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772065659; x=1772670459;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LYtMiJ64hOo8+lkj+izFgE4rdJNmMrlfm8z/RrZBl4=;
        b=kic96mCUg8WgJkQjVa780XJ80CcdcIX/uYpRcBcVZ1UEDaGxwzFO4vzqjO6FMkBJa+
         RyMuuQ8VjleCPdh3LFukkxnV53g6R8vcQSGDr+wZQAoBlCENcWnk5Uh41364Xquu6l+T
         3mo59Gtr9WblzSrWpUBJiil9Equ1IJXpks/vVvdhzoKtwX8m1/hxpzeHPhoFqRU4zulo
         C3hINa4ntjaZnELZlGZMiXW0uxGBIRwo6EvUNixnh2I+9etFbZye+DnrtTtV5osYXInX
         brJYnPUEBoj5FkFZn5vVH5C4bJP7HpwVGkVExCPi7bSjGxz5rLTTVUU/8z4M1W/ub6Z4
         AwZw==
X-Gm-Message-State: AOJu0YwV7ZnhT/LSYEKgz21vR/9C22o3HTRhn/ACd2Jg/82zeBd6xrtM
	0/WeOFTk+RsFqPW1k6p9a+pbN3TkXEdfCSUDTIGYv8K6qeDlJUPF4v2VFX6tJ46+
X-Gm-Gg: ATEYQzx/2PKlFAMPaUL7Qe4t9iF9D64rH3tjDq4rm0NV3tAoHezBuvtQ91xSjltY4Wj
	2sB+B4FWRYswkI+5rBlujvQdcKXARHTVnZ0acK7WTVMQ/BHdzjlfBrJDNU8KxRVZdR1ihDOLmrh
	yy6RnYIQa0Hto5Tw4hRpV5bkycO+lhrj8/OpvjaY3vDCWw4acxSh8yBcum/C/SH0ezW4mB1MVY2
	t3GdzXNbJs9A8qOzwSD39C296AqlSW4Ju8Xz0QGBJ3LgV7NeGnNyqzlUc5wO/thnMewT8mBYjOo
	YCswVqIJ6uX3SanFeGYkqLEMqu/OdXQcbse7enIvHsUauiFF8Zi4Bqr0ODNQ+nTomeEmBaEmobC
	RocUp3bLh30BL696E47QCMGp/uNX19lWMDUMwKElA/Bfk6F3lDf7KIiHfbp8jxBCcacT6MG9il+
	OlehXMoiKQs1SZGO5QkL0LYVa41w==
X-Received: by 2002:a05:7022:4196:b0:11b:ceee:b760 with SMTP id a92af1059eb24-12786990b10mr989729c88.23.1772065659392;
        Wed, 25 Feb 2026 16:27:39 -0800 (PST)
Received: from [127.0.0.1] ([52.159.229.150])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1bcea4esm508712eec.5.2026.02.25.16.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 16:27:38 -0800 (PST)
Message-Id: <fad2f0a81ab5fcdced2cdf3c02877fbb00244efa.1772065643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 00:27:21 +0000
Subject: [PATCH v7 08/10] fsmonitor: add tests for Linux
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
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

Add a smoke test that verifies the filesystem actually delivers
inotify events to the daemon.  On some configurations (e.g.,
overlayfs with older kernels), inotify watches succeed but events
are never delivered.  The daemon cookie wait will time out, but
every subsequent test would fail.  Skip the entire test file early
when this is detected.

Add a test that exercises rapid nested directory creation to verify
the daemon correctly handles the EEXIST race between recursive scan
and queued inotify events.  When IN_MASK_CREATE is available and a
directory watch is added during recursive registration, the kernel
may also deliver a queued IN_CREATE event for the same directory.
The second inotify_add_watch() returns EEXIST, which must be treated
as harmless.  An earlier version of the listener crashed in this
scenario.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 t/meson.build                |  8 +++-
 t/t7527-builtin-fsmonitor.sh | 89 +++++++++++++++++++++++++++++++++---
 2 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/t/meson.build b/t/meson.build
index 19e8306298..85ef2ae2fa 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1210,12 +1210,18 @@ test_environment = script_environment
 test_environment.set('GIT_BUILD_DIR', git_build_dir)
 
 foreach integration_test : integration_tests
+  per_test_kwargs = test_kwargs
+  # The fsmonitor tests start daemon processes that in some environments
+  # can hang.  Set a generous timeout to prevent CI from blocking.
+  if fs.stem(integration_test) == 't7527-builtin-fsmonitor'
+    per_test_kwargs += {'timeout': 1800}
+  endif
   test(fs.stem(integration_test), shell,
     args: [ integration_test ],
     workdir: meson.current_source_dir(),
     env: test_environment,
     depends: test_dependencies + bin_wrappers,
-    kwargs: test_kwargs,
+    kwargs: per_test_kwargs,
   )
 endforeach
 
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 409cd0cd12..774da5ac60 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -10,9 +10,58 @@ then
 	test_done
 fi
 
+# Verify that the filesystem delivers events to the daemon.
+# On some configurations (e.g., overlayfs with older kernels),
+# inotify watches succeed but events are never delivered.  The
+# cookie wait will time out and the daemon logs a trace message.
+#
+# Use "timeout" (if available) to guard each step against hangs.
+maybe_timeout () {
+	if type timeout >/dev/null 2>&1
+	then
+		timeout "$@"
+	else
+		shift
+		"$@"
+	fi
+}
+verify_fsmonitor_works () {
+	git init test_fsmonitor_smoke || return 1
+
+	GIT_TRACE_FSMONITOR="$PWD/smoke.trace" &&
+	export GIT_TRACE_FSMONITOR &&
+	maybe_timeout 30 \
+		git -C test_fsmonitor_smoke fsmonitor--daemon start \
+			--start-timeout=10
+	ret=$?
+	unset GIT_TRACE_FSMONITOR
+	if test $ret -ne 0
+	then
+		rm -rf test_fsmonitor_smoke smoke.trace
+		return 1
+	fi
+
+	maybe_timeout 10 \
+		test-tool -C test_fsmonitor_smoke fsmonitor-client query \
+			--token 0 >/dev/null 2>&1
+	maybe_timeout 5 \
+		git -C test_fsmonitor_smoke fsmonitor--daemon stop 2>/dev/null
+	! grep -q "cookie_wait timed out" "$PWD/smoke.trace" 2>/dev/null
+	ret=$?
+	rm -rf test_fsmonitor_smoke smoke.trace
+	return $ret
+}
+
+if ! verify_fsmonitor_works
+then
+	skip_all="filesystem does not deliver fsmonitor events (container/overlayfs?)"
+	test_done
+fi
+
 stop_daemon_delete_repo () {
 	r=$1 &&
-	test_might_fail git -C $r fsmonitor--daemon stop &&
+	test_might_fail maybe_timeout 30 \
+		git -C $r fsmonitor--daemon stop 2>/dev/null
 	rm -rf $1
 }
 
@@ -67,7 +116,7 @@ start_daemon () {
 			export GIT_TEST_FSMONITOR_TOKEN
 		fi &&
 
-		git $r fsmonitor--daemon start &&
+		git $r fsmonitor--daemon start --start-timeout=10 &&
 		git $r fsmonitor--daemon status
 	)
 }
@@ -520,6 +569,28 @@ test_expect_success 'directory changes to a file' '
 	grep "^event: dir1$" .git/trace
 '
 
+test_expect_success 'rapid nested directory creation' '
+	test_when_finished "git fsmonitor--daemon stop; rm -rf rapid" &&
+
+	start_daemon --tf "$PWD/.git/trace" &&
+
+	# Rapidly create nested directories to exercise race conditions
+	# where directory watches may be added concurrently during
+	# event processing and recursive scanning.
+	for i in $(test_seq 1 20)
+	do
+		mkdir -p "rapid/nested/dir$i/subdir/deep" || return 1
+	done &&
+
+	# Give the daemon time to process all events
+	sleep 1 &&
+
+	test-tool fsmonitor-client query --token 0 &&
+
+	# Verify daemon is still running (did not crash)
+	git fsmonitor--daemon status
+'
+
 # The next few test cases exercise the token-resync code.  When filesystem
 # drops events (because of filesystem velocity or because the daemon isn't
 # polling fast enough), we need to discard the cached data (relative to the
@@ -910,7 +981,10 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
 start_git_in_background () {
 	git "$@" &
 	git_pid=$!
-	git_pgid=$(ps -o pgid= -p $git_pid)
+	git_pgid=$(ps -o pgid= -p $git_pid 2>/dev/null ||
+		awk '{print $5}' /proc/$git_pid/stat 2>/dev/null) &&
+	git_pgid="${git_pgid## }" &&
+	git_pgid="${git_pgid%% }"
 	nr_tries_left=10
 	while true
 	do
@@ -921,15 +995,16 @@ start_git_in_background () {
 		fi
 		sleep 1
 		nr_tries_left=$(($nr_tries_left - 1))
-	done >/dev/null 2>&1 &
+	done >/dev/null 2>&1 3>&- 4>&- 5>&- 6>&- 7>&- &
 	watchdog_pid=$!
 	wait $git_pid
 }
 
 stop_git () {
-	while kill -0 -- -$git_pgid
+	test -n "$git_pgid" || return 0
+	while kill -0 -- -$git_pgid 2>/dev/null
 	do
-		kill -- -$git_pgid
+		kill -- -$git_pgid 2>/dev/null
 		sleep 1
 	done
 }
@@ -944,7 +1019,7 @@ stop_watchdog () {
 
 test_expect_success !MINGW "submodule implicitly starts daemon by pull" '
 	test_atexit "stop_watchdog" &&
-	test_when_finished "stop_git; rm -rf cloned super sub" &&
+	test_when_finished "set +m; stop_git; rm -rf cloned super sub" &&
 
 	create_super super &&
 	create_sub sub &&
-- 
gitgitgadget


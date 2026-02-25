Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE0E2F60CC
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050650; cv=none; b=pQqXB2SXn09+hOpQc7a3t7qV8IPvsc+1NyZu6bhKxFZ9OkWN9TCO5hVeNhvoXN9d61KfKcUK9A5yvH4ZNX22Kk+D+AmfKvHoemcIbM89s9tvCXfLtFs00C4kiS+cjE+NwC4PDCbpBntzwI9BD+m/cA0WUH5Re0syCIIW+43n8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050650; c=relaxed/simple;
	bh=Sz7Lt7pJP+zXlWyOyieOr2OBnfkRJy2aiI3ybYsMWCg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jZ4oisPviidyZsqB9ryq599PQP+sXrQXmtF0BGY6caNR527S04eyZ67zaHtCF0U2i6iQ9M+dUSe0s3xCPo+c0KwvxEos3oIjTLukY3PU7pN1JahpbqYZ+ddSsmF/IAovTMQ4jRQar04FOoaVdHNYH7w04NPoPbDpElT14jJ20/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/NUf0EC; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/NUf0EC"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb40030be5so2032285a.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 12:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772050648; x=1772655448; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LYtMiJ64hOo8+lkj+izFgE4rdJNmMrlfm8z/RrZBl4=;
        b=S/NUf0ECwdguu3mtHbdIZwrDNhC49BZ2T9kWOR2njNaw7EzyjNlyZtZyx6+K87CZGz
         KdApf63YOQW10+PY94QiHYS3q3ocaDwpwXwjy/aEzw9ERP4Jsdlqn64lexJwJElDicvp
         xkRE0ja2GPNO5H8RgIwfNkms5QHrkgIe2phcFGTzfTMFymGSiU6hEEzCkL+9TiiRCcaM
         ze3SLHOkkaXpPUpIr2gibBiLcsetViLCTFP8OJbTq5MNS74JporePj6H+ILpM6lHgTdE
         H1CrZg0YzzFZ0qlx29cLyJwfmc3FZHI1zHUv7AVu9ultjhBrosKx0bar6/TjaIXzhmbf
         sfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772050648; x=1772655448;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4LYtMiJ64hOo8+lkj+izFgE4rdJNmMrlfm8z/RrZBl4=;
        b=ZkCjd6nIrfYg0YACIpaMNCYAytz1JHAEDOcT18HHd3kQpfBff+xgS4mlqB6AXJRMhU
         NhJE7Ee4Nju5LRirrvCtA2ayNmIsL+Ayfp18Tg7PDI3gHcdOg+gF+6E7seFMme0xhLVU
         TIhLf1WCCN/r7lIizHK59O/BeRtavTRdv99rQFrVlYLfWCAYaEKs3FydhgHxG5q3B4p3
         /3DQy5MpwZoeGbysJbVwDWnfRUna9iU93x0roy0RdDUTy5URgzP7Z3ykZwGvNg3yUoT0
         fAqZnDqUfzfdm3skgC9NiTg8/q1y7KCuFnJcRlwbv6ueZEsv4B1pLJcck18sRIxrULZ7
         KCYw==
X-Gm-Message-State: AOJu0Yx60AyvyHReUpQUdUNfSETMtoND28WQjdK+kbrKmO0QOdvCby8O
	BDoKijIKJjVuqtc2ELk3MKu8dxbVpWv7NRFOuiDwz9jaHTvTDssgbYiLdvM7EA==
X-Gm-Gg: ATEYQzyd2peYn6eW6eGfKkX+H1v6VtpN/wYr4xFqN+/ViCjHzAypRbZP2NH5WAHnVVj
	FCBg0C0g7jtPyFNJP4m8ms9xTRoCuhhIiuhmMQHox48niBD5BwTDyLKLRNGNBBERo6jOql1RdZN
	LpNECKYiK9XXCYHxr3KeStprKKzO+SiZMpW2UhoEbgL+xUkOYbsRGNKNKgRW2On0MmIQ3LAyXvR
	59aIE4fJO496bGbREy+jT2xD51P4DCh8nr0q3MHP2O8Bo1A7Rl3Zm6bNTYjEMyqphs+glZ22QBe
	SJkYwC99+c//jnIdZf2Sxo1sggojToi5JadaCYkvMfgG3yDw9uPrfORw2jb5RJwtr78itb2/jEX
	tUMzHA1NxRAz5VtrChUMb4T4POq1mne7OMm+As/2gjPWkh22WzcqZuODrCIiahYGgU295JDSRhF
	TwWpuX97s8v0VnUMYQQB5x/jH/Zw==
X-Received: by 2002:a05:620a:3943:b0:8b2:2066:ffca with SMTP id af79cd13be357-8cb8cab0d39mr1986053485a.82.1772050647926;
        Wed, 25 Feb 2026 12:17:27 -0800 (PST)
Received: from [127.0.0.1] ([135.119.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf7319bdsm13465885a.43.2026.02.25.12.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:17:27 -0800 (PST)
Message-Id: <8fec92d5b4c86da5f85797516c10812150fed557.1772050636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 20:17:14 +0000
Subject: [PATCH v6 08/10] fsmonitor: add tests for Linux
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


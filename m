Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB45034CFCF
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937990; cv=none; b=MjY1jz9FV5SbiRUVgi3gLRNgNaxYJDPmZBc/rea7ofU5BGhkitE/Fi0HGb6wL0RdUqBbMfFn1jceCPoN2nO6cqKFLfvXzHfgku0lpKSZfJijlEM3id0hIskHnLHBGRbeREzXi4EqEgrsBiJOIDF9j3t5NS72pWQs+YqBr0KhpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937990; c=relaxed/simple;
	bh=UccY8KkQmmzRVJjPmUNw0+5cfcnWQd4PGNhkKpKIa64=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JrkR52ZiEp3rSCVABIFI1P6XqTfruqLVaXyAC4EC+SgpwOLt2APikA06mNzIlqeMWBlIRBoUt0eDSaBgDPSqhU1tPfkDrOZR5T9zXCJ6WBo97Lfub7dMx7fRw49ezREmefZ8/La4q8fWev4GLHZyUzqpVkevjtbMhooqGXTnwts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAig5Byp; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAig5Byp"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-46a9ae3f857so1065220b6e.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937987; x=1775542787; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGZZpQUs2JU6feqN07JnIijdY7YhuFyGOr34QG2qB8A=;
        b=TAig5Byprgzo8ZzvnkXty64WGQmS158V9cnYE89c0GSguynnxevu+C8/UkV7SuGYC4
         hfzBVLfU3yaQq/LfcXn1kxm2J+TzF5jSAVWbrmXD11uyjTemeryF2HvNMFEfFWAbgcQm
         3oQ3VUbbpNfbvKWZ+GNtLyauMmbxOj+vuTiZEePWxDdOVBLhdUMd78oxvmmQO6e+6QBI
         0MgEmLFS3AYgkINPwkPwBB5HTSUsyGpNL3AyftyoZzJgsz/jZuBYUkIXaVq2DaZkTUll
         d/CF8cyzmfnVMruHxxnGtMKEHrEq2U9QUes3aKf/4/9UIhVKYDcz16f4bOR7BVWw8+y2
         Ttxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937987; x=1775542787;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGZZpQUs2JU6feqN07JnIijdY7YhuFyGOr34QG2qB8A=;
        b=k8QBjQiL4JREVm5VP0B6shO/C88dQx69Q4hFtiX/fMJVmBLGeaMIb1RHW84flwbDaW
         dA9NKm9p0Jc8iD9GS4QwmIZ1xFLUOA7gYifj8EFwaEqUMiGjWLGnC41Vh8R7h0oMvdat
         YvlYnmIHMcXdFfgIGp8OfRv2uHbLCYbD9qO/Jhkdr8A1UJKU78hCnmOiGfQsE2ik1ZjB
         wUMRkdYTjx1yX9Ii+UtPRIVfGaAOVyd2A/uZd/csFE6KTtLvcJmBtOvME8/E/Z0lUyFJ
         HHb9ttaSbCqCS5Kdu4FexGyAghGd60GObsDLA6UlU0gQqif+BnUbgp0FtUy1lDLe1qUF
         6SLA==
X-Gm-Message-State: AOJu0YznNTc9ReZvlkGVW+hejyocm0fN3xz4zNqABgF2qzXIr1wVrB/r
	6+z9kgAIkADSBNzJjBPBrAqbJiPpYAWrJhoJVCein4hXegsU4msi87VvagSzGuGu
X-Gm-Gg: ATEYQzyaGf+VGoAtYo4SmzjbaCKsVzvV5EDPoxGrgZy+E56OD+6VKvUxWpQDYr2VZk/
	b4fNrMu+aqJubtNq0nr8GZV0abHMsSbWdR37weFJcwSKGesR07b5zfB2I2MhTxu3fkP3oZPAbRH
	2WkafzgeKVFscY80XkkaB1Y+/M7rX/y+h/UFXPvY9ZyHBM0GhZDFbzzrqDBySVVBOnb3UpMCvGy
	jonW8KZXNG1s6ePjlHUPG/jUf6vYY+hqCVo1FTa9aFYDPLzNEmi83Pbo0qy8IxEzzFUoOWmEmFo
	7HQiAAWqjSTZLsyzhbBAJYapt9XguKorUpoLDEGIq14nbwR3c1pUiQldJnZFimyyViEzXoJITnm
	IghDwomdtlPA5R1S2z4XHFriNUY5SbuQf3J23DduS+WU3AoCaZNk1623HrsTzDh1tMJ/PjPSEvy
	sjrcQVHwzhgzmsli4z8n10Qhap0ek=
X-Received: by 2002:a05:6808:4f2b:b0:44d:bcb0:1409 with SMTP id 5614622812f47-46a8a41933amr7306702b6e.22.1774937987325;
        Mon, 30 Mar 2026 23:19:47 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.162])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da3356d8c5sm1957337a34.14.2026.03.30.23.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:19:46 -0700 (PDT)
Message-Id: <81f8cd159945463927dfd2f78645f55f23b9498c.1774937958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 06:19:16 +0000
Subject: [PATCH v12 11/13] fsmonitor: add tests for Linux
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
    Paul Tarjan <paul@paultarjan.com>,
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

Reduce --start-timeout from the default 60 seconds to 10 seconds so
that tests fail promptly when the daemon cannot start.

Harden the test helpers to work in environments without procps
(e.g., Fedora CI): fall back to reading /proc/$pid/stat for the
process group ID when ps is unavailable, guard stop_git() against
an empty pgid, and redirect stderr from kill to /dev/null to avoid
noise when processes have already exited.

Use set -m to enable job control in the submodule-pull test so that
the background git pull gets its own process group, preventing the
shell wait from blocking on the daemon.  setsid() in the previous
commit detaches the daemon itself, but the intermediate git pull
process still needs its own process group for the test shell to
manage it correctly.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 t/t7527-builtin-fsmonitor.sh | 89 +++++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 7 deletions(-)

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


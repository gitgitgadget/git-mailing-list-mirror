Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A8313545
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693741; cv=none; b=t99CLQpkyjKqIIh5pCB9B8wVFPgGj3qqWryehj1O+hdVELhB2EJ3M8lUTRLtBGuwda4cFbNyGz6PEoxvCZWorhE2oZVm5XfOHuqoHXHwsYZnzyXOZpXADDE01AAXpausJmFq+YGOBdZUGaEBk/Nd5HZjm3m0NakHbSin/kAPSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693741; c=relaxed/simple;
	bh=UccY8KkQmmzRVJjPmUNw0+5cfcnWQd4PGNhkKpKIa64=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i4k3r3sbUkZHHYWTu7SUGfBvck8d66rPUwJPGizO7v0dR8kniteqNHz0mNQpfRXOLmMmdEbBhg4uVdS4M4p6I5e5w7n6nD+paF2FSURzJAPiaCj2X+DQQko1Tr6WhMTLCfkurQln0uI4pil0w8hY0EfEyQpW1bpfcpVs1E2/mzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2sU0L3e; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2sU0L3e"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1275750cfc7so1333325c88.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772693739; x=1773298539; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGZZpQUs2JU6feqN07JnIijdY7YhuFyGOr34QG2qB8A=;
        b=Y2sU0L3eb6uqjdW5nvymwADp02AmPPB2Ri7jhjyml78aoTGxZ0mZR5aE813d6/O5o6
         egYkiBdiW/W9DAbniuzo6yPYikb1nH321+VReBjV06UIc2edUqraYK4yfUsWZ03uigMP
         RPuTrlxf+fQhBtBjVGWry3b6EZcTn4bdCbH5seX0bY8ftr2/NwI8lLv8vQtuOmFNNDKo
         FtKQq1UZytjDu9oo0MMgLJMeIo7jgpSigrJaV5VLe+HpgZ+Zs8Wli+hzWHAk976yEzjW
         FMN1TLGWzSJu53hkQVK29RaynIw/mEQ1jokg7bHy2ohzmUvMePGYFyLudyJX3W/vCmye
         RO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693739; x=1773298539;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGZZpQUs2JU6feqN07JnIijdY7YhuFyGOr34QG2qB8A=;
        b=kyA/H1gOpBRul/VMgapAIJdO3K/oURCJEH1DspxHAdWw5U8P3BbRXXFhqHG4Zm6kez
         blgeqZ7P9cetQy83Ha3mXoAVxhhUYlyM9I0ruHQuwWqREJ2KD6byoZyntcTswooZiP7r
         8JLrthGetAApnNaM8/Wvvz0PNvPM2rOPSkfBylthqacCcMv4XoD3DkNvx/tnLkMnLNq+
         FIQ2Y++UjnOWGFeiLOg4Gf88QsxCdneWcvXgaLfQMC8zOjHwQXVZk5xhEwOgcrLKLtg7
         OA3lhGFz+BtZflJRBz43AaWKrRGtYv79o6J6HvtsPlVDfjgz5wX7Or7gdyDF9aD6VOsR
         nvqQ==
X-Gm-Message-State: AOJu0YyXswTdts5VuHOte5R/LDDC7L61/7HYozfe6lzeOWxabVOvvsPi
	JciXAUsxxUl6Bc+NVZZ+fycwRZzCLHqg3L+REuWGLdrOwHQ7Ti2/SDVPRJkA8w==
X-Gm-Gg: ATEYQzzSbXlF6+J9i1GPthGvP03ual2Rxdkh8I/19VN9JhycBAZuR1MclftaJnD1G8u
	Y6LRe+8hhJHTD35pSxOKPz//703o+m1BM8IQZpNagVe1KozPqcdwPJ35ywy0M53D+ooEUVDpzVj
	B4Cqrjmwki8uMWDaSycA3CAkndJr9Cuzlue6nL1w1zRjQSX2Lt/UKrkvnueA/5LxHh+J64b/yT+
	Cpepg1J5jxrskcxWoXSS/rzXQdkCptcyiDR1qdnaJPTFIRA8G+x3sNNImz+/phmHf+Qs9JLaBoJ
	uXcnK+wMirz2p+jBOwcrqZBRNClDxWg9Ws9Sz50gjXWS2ipEh0zsMZKaO02XzCXfMavet9vsmO4
	lznifodvpiuOJuU8HvmgLzZNrn7PQNAsGga5ml1ApvcxDk9MhKUXjIWOLVjJfmu8EdlkrZw5wVT
	XSE4QyhsA3QGvqQxBwi8S15rhrog==
X-Received: by 2002:a05:7022:689d:b0:122:153:d161 with SMTP id a92af1059eb24-128b70805a2mr2071890c88.17.1772693739036;
        Wed, 04 Mar 2026 22:55:39 -0800 (PST)
Received: from [127.0.0.1] ([52.190.182.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43a18sm25662390c88.13.2026.03.04.22.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:55:38 -0800 (PST)
Message-Id: <81f8cd159945463927dfd2f78645f55f23b9498c.1772693712.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 06:55:11 +0000
Subject: [PATCH v11 11/12] fsmonitor: add tests for Linux
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


Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC0E23817E
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671942; cv=none; b=s5OGPBE4yCkcLS6IofUibUefhLnAznfo1VNpw/TX6KxOkuTeTkRV8U65QX7PSgfgLotoMzd6mWyfo5I+q1+9/iiPGHcxKw7jTTyhK1VRenohkfIArOmTin81ZcT31KMpKTY/I6NDoIRvpi28Q4aYZdyaldWbhN7eHKmeHZxmNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671942; c=relaxed/simple;
	bh=UccY8KkQmmzRVJjPmUNw0+5cfcnWQd4PGNhkKpKIa64=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ax8RhcWo3D8AjqO41xJ3uQTxSwkhHlXGFmfDvF5RKsWE3zBLneR/QqIsCb/bfsK5XiWoRyfVMG42KwZmvWjUyOAzb4bDeysnjRX9kdEhX1nAumJY9K7uJCBDxJVXdMw3YFgwPnbeANcaVDs4KW7+ZjmoIF4Gou3+feo+1HhaGkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KncR1u5U; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KncR1u5U"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-127380532eeso1396555c88.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671939; x=1773276739; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGZZpQUs2JU6feqN07JnIijdY7YhuFyGOr34QG2qB8A=;
        b=KncR1u5UzYU6XmFY6ZErFhULLcHuuXGUiHaPiGCGSK9WlKgd3WgJwS+jOJnemsg5p/
         kCE90MyJ2Q4cz95YB70qIaSzTMYvfw1Qd0NWU4hH7nwCblcO/NFmcjJAaZl83/jr9fO4
         5DjbdMVnaZg88yf0gQnddbR+dPNfDW8K/oB5OrLZ2Il8VAl/33JVQXXUzyGDty9FqTXx
         cOZqhcrXUTfghLoaeTEWWhf4IIh3eAJfwYCTNbZN9xQ1pJ0AbfXsaSEBTpbHvSF0JTJ2
         0oR64FF50w43YAE1WtkKGb5huNdslOObO5cvGWc2ZLHaloUKFGhnPipihXhobyUSJPai
         3Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671939; x=1773276739;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGZZpQUs2JU6feqN07JnIijdY7YhuFyGOr34QG2qB8A=;
        b=rjRYFP4X+pyxTV1xitbo+HU8/yEjuFr+BvLPlzTLWACKZni87UpWyLVt4N1Fynrtjv
         a4DHpQaZ5LkqTOC/JB2O03+zKw5SVW+lyL70zgq8b/72huZ54N4EOOOR+kIX9GO5ywCd
         HNKgB9IKlbfYZIUGbM8XmrwgNonuBLjm7lF/Ij31P3gReAz/vbvKdkHMvh4HxkEO1jij
         Ae1u6JYUdUu3D0us3wL1gmIn9r7IiinL0OmEu44uOcBoNq87tqsAleYoZblUE7canWFm
         I54aXrD1nbYyUp4tjj4awKoSNNduxoOHF7a8iA6hQ3i+PkyFX6KVWz93gaisYMSdgp9z
         NhSQ==
X-Gm-Message-State: AOJu0YzCUdfPyFmACeoPdZyYp5ZlNvvoNg5gVXbYl42+CI4hi47GjZql
	LZ0K1LtgGJoUjEoIgv6CdqfVL8ZTdH1K1X8kZAtMzr6qiefjtKq3l4lOQ5affw==
X-Gm-Gg: ATEYQzxz4A/aht/GtbQPXlxo4F+EqgVYIgffcinO0Q9USBz5NEKxJ70ZI/vXzokK0Lw
	2BlF6HnyK2cz5D7f9UXOeU2yOMU6ngmLmgFavtRmepLUPWVrN7YLGqMbTzf/j+EAJgoMmrU/dAC
	p2OeUG9aU1K5onCMkK4ST/4Z/XqvkD36H7hjPMegjxYXWedwiGpVQtae6JPzRq0O/ZzQd3eijeH
	dpZnYvRaTWP03QvQGN+q73fo/D9tvAch0ec7DbmYIyNagZA8T6tGxbuHxNUafSflKCSz/7dsRPz
	wf53XmxLL+BN6EBfo0OLE2JHd+6rmaMUYTVX+hyZdGDfhqAX4KXhslJutQfJL0K7kljyQWgrq6Z
	xdPnRcAzESj9lULUxG7bLi2Ko4KlxyBVBm+VO4vPcJ2cKEkls1WQeq8+SwBcmPZzrPQAEu3NKH/
	lZ5nsZc7DKJyBDMhYLl/p65cPk
X-Received: by 2002:a05:7022:689d:b0:122:153:d161 with SMTP id a92af1059eb24-128b70805a2mr1735716c88.17.1772671939491;
        Wed, 04 Mar 2026 16:52:19 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df36asm19809013c88.4.2026.03.04.16.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:52:18 -0800 (PST)
Message-Id: <54bd8f604a1432df497d19e9a48e96393517d632.1772671920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
References: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
	<pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 00:51:59 +0000
Subject: [PATCH v9 11/12] fsmonitor: add tests for Linux
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


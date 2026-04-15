Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9583A759E
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259684; cv=none; b=cjca9rAcBW9HxgPe2g22SMm4nyu5mLIsjk7eD5en741KKbqN+83mpo/301SRAPhRmyiZcPnZ0zsZuhi2qJAo9GEFi9bC2heek/p4o2QwzKs92oc/8ukb+xOCaP6rpMRhRF8QovMlL5qEdkBfbj/m/KAVLyHYsYNIn1uEapJ+GBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259684; c=relaxed/simple;
	bh=AthjLXGw3+JQv5jrvP9j00195+uoie8t55VU2IW5Tb4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uc6fRZ/NCoT27wyGs0FVBg6lmsLF4T+Cz36bWZLxUz7kxiRpgAsKPK/8CgZKjUIkPdzVAzOMnTYOoVfvX+Z9sJFzLI/q9xcF5A/c2DkHG2wX5VHnnvGdqYxu3UFHujE7koJLsPlljcX7KI4hvJMxj9fXPg8mpXtt2Krj5TlTL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFgYrRe/; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFgYrRe/"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-95697b46831so1400284241.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259681; x=1776864481; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JovJV0cSWkK42FIWxhbq/SIhCPsw/aYORDbdlXJUdL8=;
        b=cFgYrRe/mGx64qJwjwmUZLkP6noMGjRrRlf/FvHPdj18PawgoCz/Xadxw6DCqW+rho
         4L0D2z5OpLkm1FL2AAfW70+29G3sQy6rKKxI6Fr3O3M0fYNFkGA/9InuOAPac7f8AYnc
         NKOurizUVNZ3+8yStLzzjoDKkmwvMLfLNydv9KsOZtjQTm8u7hUYVe8ofrpRGi0DqaHE
         M0Ct4a2ikMwebeEVoKesw21F8cWZanRRFo4wTMWxDm6WhOGWvCILDGZznQ+20KQdi5R5
         gEE1UHcbrUB1lbzzCa5lz7AHCzseVmdOin/8ye5SfjY9cK98EXxUzE0LkLJe4GcKYLec
         qJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259681; x=1776864481;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JovJV0cSWkK42FIWxhbq/SIhCPsw/aYORDbdlXJUdL8=;
        b=CYPUk8JgeFOgXLOaFt0+yw3DY7Pddk3y5gb/k2RtpjvLY3/bL6exngZtwUE1e/DXbZ
         ZOg80DBL2kEHl5dsbo2mGYlGweHF5ZprMw3qLiXcDovViIxFVFvnCOSjBz9aLT+ffIl6
         AzpRlUV3sUN38qQBmc71LkI65fgrJLbB2aFJBBpDT+dD3zsY0dpxMbng/Ei13e+FOPU+
         rUBGaNOzKc67auuKf6M/iPjZS1m9FAR59IFYkqtTZvnLvOD76CNUnlXtBzqNGpJ1UQON
         xEJx8+aYRVhHVJewh4BZtg6Ns+0c0w5lNABvFaF1ZZQcNsUUyl2FrvGWBvhOKlOzuwRC
         O/5Q==
X-Gm-Message-State: AOJu0YxHbgXf28WzWo6fum6xw7Yx7//F1JuQwqtnplJCflvEvsg0QpPu
	MDyWBYD5dMny0OJk1z/jgPECeGgVfbVScxGRxiA+ynrBadfITOOfwpw7lV0KLg==
X-Gm-Gg: AeBDiesoRT09jhhVFP84/ayG4Xfl58f8iWAbOKUKbZ739xj5/UuMfRfgBaCrtE8BVPb
	eP2lF0iCPITjflyC293GUxITuTRjq7bpD/DiLDglT8WUU3EH5kEZxyduoznSIyL4SArUqnG/2XX
	Quz7QGzUf/PIqTKfR/BnbHQWtIXG8Lq1oxIfgoSz+Ld3aVfn3AMZYpZ9PE8Qs3W0tKjpcjRjMzC
	x3z3yvzAe3GxIo6acLThOnmpx2e6OVAwhU5g/piljkMzHUwyuVKF5Nj1NacBYAFmPGEe93aF7GK
	FnZw1iztwgwSfPa3NdpyebfEMx8HQcWW8rpizguI5zbdiMX4tBpCQ7xee7CYKOfCZqA8lfahVVh
	/yTMpEbYGv4zbDBieHa1u3dLakQhz0XTgbTeEe5qC2paHNrjyNkCnHWFK2eYg20T4ixj+4wLslm
	WW2GWzebotPtSPzaYhpPRWzmyqTg==
X-Received: by 2002:a05:6102:2914:b0:611:3bcb:aef6 with SMTP id ada2fe7eead31-6113bcc014amr3600100137.0.1776259680745;
        Wed, 15 Apr 2026 06:28:00 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceb891csm11362476d6.48.2026.04.15.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:28:00 -0700 (PDT)
Message-Id: <ffffd64a4baab2c6884cb07cebdc40e5e7c4f0a2.1776259657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 13:27:36 +0000
Subject: [PATCH v15 12/13] fsmonitor: add tests for Linux
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
    Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Jeff King <peff@peff.net>,
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
 t/t7527-builtin-fsmonitor.sh | 88 +++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 409cd0cd12..ed12f218de 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -10,9 +10,57 @@ then
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
+	{ maybe_timeout 30 git -C $r fsmonitor--daemon stop 2>/dev/null || :; } &&
 	rm -rf $1
 }
 
@@ -67,7 +115,7 @@ start_daemon () {
 			export GIT_TEST_FSMONITOR_TOKEN
 		fi &&
 
-		git $r fsmonitor--daemon start &&
+		git $r fsmonitor--daemon start --start-timeout=10 &&
 		git $r fsmonitor--daemon status
 	)
 }
@@ -520,6 +568,28 @@ test_expect_success 'directory changes to a file' '
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
@@ -910,7 +980,10 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
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
@@ -921,15 +994,16 @@ start_git_in_background () {
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
@@ -944,7 +1018,7 @@ stop_watchdog () {
 
 test_expect_success !MINGW "submodule implicitly starts daemon by pull" '
 	test_atexit "stop_watchdog" &&
-	test_when_finished "stop_git; rm -rf cloned super sub" &&
+	test_when_finished "set +m; stop_git; rm -rf cloned super sub" &&
 
 	create_super super &&
 	create_sub sub &&
-- 
gitgitgadget


Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188322D7D27
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710799; cv=none; b=eqTO4nXIzSPQn9Byu8wzpiujyM9FteAFoK7Axd3cPb3N+eElV+gkJDrd4o9VYOb43h6f9Ej9hZqHFSwx/UE0FUaZGI0GmnvcZL6EUAcvOXl7C1BzsCzJuA1+kB4hV2ivWk70JHPzaxa3r07LmLCnWxRyraAej6Kb8TZYOr/dFzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710799; c=relaxed/simple;
	bh=UccY8KkQmmzRVJjPmUNw0+5cfcnWQd4PGNhkKpKIa64=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Cnm0AzECAvrl6T1/EhsJu/Z4j/iJsWt2DGRLI3eMGp0X6mD/LRirx4GknZHaHXddJ0PeBOLGk8wW6VaY7rEibbyDbVWr6elEicKbkPoQYxp6A6NzzE8D2uAfJnyZnlAw0RG3KIIhCQrxD4ELYjeMbnP+vCNJ2ms+t2t3CiPP2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asUSxfQg; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asUSxfQg"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89e8e352dc1so2541636d6.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710797; x=1776315597; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGZZpQUs2JU6feqN07JnIijdY7YhuFyGOr34QG2qB8A=;
        b=asUSxfQgilp3MkCCm+GRJozXGt+HtsNEVpcGX3tVryHi6PhnVaLxuJpzhrXcLYbfRN
         1L7+Lxq1X50hipvBwgnX+OgU1ZPVln8ozt08IplBu82vW8ZAXiN3uQfpv8NRcnC6O742
         i2iCijSC9tmb40iNRIv4N0hVj2wBFakX6jttikWRVD3xDJqd2M+XoK+sB7ZiM1U9J6Tq
         B2+BlSSns3OJinwIu5sdS1xYDS+LH7OvqO19OEvJcWESP668coVbB9xKSZbkjdoKIYyP
         bae06w6sBCJDLcDMkp+qoFmAU+u9GKaeN8Ik4AuQwtAbqb6esw75mvyJkb9TdPFRO+es
         jUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710797; x=1776315597;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGZZpQUs2JU6feqN07JnIijdY7YhuFyGOr34QG2qB8A=;
        b=psxwI3lrPBLE+1ZLUPkv801vhiMFgTK+OUVzFOxxTqWyBzzYBrYNGr4xVAEB3QXepk
         qh5C1SCxOCQDN3hzTBBeorpYuJa80tpy3o786dPOCgjJX5lTz09or8HdipBzNhgrEz/V
         zO2hsmUVpJpkqsB/S8sZcIxME/NNITgQogZ80ZmsAvTPHxEm8bGqd8vLQQoMq2jmrWoQ
         by9PhHhcOLFL1CjdbyiJFJqFjvctV3feo1/41mhPHboC8lL0TrlMk0KQkQ3BxQuzE4Nz
         YWd8yczWqNskvD1mMqNkHTLJHLuS3XSrUzvvA3YZpqTsqD4jQlLrDJ9yJr3KaYYCygRK
         vODw==
X-Gm-Message-State: AOJu0Yzvpb2+LJ+KpRNiuuqEkfYxGbeOgaCRA/y3RLbNWAiiWtMlgDX1
	9hMAYz76/ogVG1iJaftmlb+Ei8Wt1O8ICW1D7X+8j238XhsdaFgFQ/AJQ2zdPw==
X-Gm-Gg: AeBDieunbV+kV1yTa1swpxufuloTOO6B4SoNP8/6xd54xr+hvXKCRRhfM1gIt1m/Mvk
	CaLSbJcPPTC6HcVM8LcU3C2ELtqjpI1DClEJDxIvR8yZKHIIeXg5s2cfCj6k9UdkWvAcDX9CKZz
	Q+VLuHSKEWucLzCm2mi7+z3yzekkcm8MN7OQuRahOIxtFlrwgCWIhV44Da3DKbe49rRZcH/vJnW
	KHUCPgXU40rljJmeXSZRwq1vX0AC3XBgPS7m4SRfeaoF6N6UvRKR3voRCCsEyMVppu8R51v+0um
	1WvowlZFexITf89gD+tCAYC4fmPnl1h9BBrLzyFKia4gv0Yi5EGuOjeosHEdLV37h1FSm65cT9c
	cP2GPdNuFCieRXCHFD87kvUZCCfan/dcs1y3dsLumnM3KH51Y6F3N6SRZqpPToLKhPzca0Gr7oY
	almwbU3nlBRwerH6vyhMAt+XEnUQk=
X-Received: by 2002:a05:6214:3116:b0:8a3:a172:46b0 with SMTP id 6a1803df08f44-8a705194a7cmr377954956d6.44.1775710796589;
        Wed, 08 Apr 2026 21:59:56 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac74e58f7dsm12489646d6.17.2026.04.08.21.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:56 -0700 (PDT)
Message-Id: <f85983ca93761bf6cec115d680af8c7d2938505d.1775710775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:34 +0000
Subject: [PATCH v14 12/13] fsmonitor: add tests for Linux
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


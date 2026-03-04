Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2D3DEAF6
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648148; cv=none; b=jZOb/s27yVe+lYjqdm9PKa/L9gqp4h/hsswXL4KgQWgZL38oFeZzyvERuUyMhh1Kos7Hl7xVMAV/7F/gvhHuzWFIqd0UeDXRVBuQ6cZQoKDAwYElkopGOFXp+tnTBsutJS31ybJ/77++gy78InK5ITJlxHhVURuTVymE3sBqPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648148; c=relaxed/simple;
	bh=UccY8KkQmmzRVJjPmUNw0+5cfcnWQd4PGNhkKpKIa64=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OrzCz1py8T3ObiuN0HsG9TaT08uQ+ThD4tv0+EHobpP5ymUlRUOCzQ3tEiAoMK6Mg5hITMRwCSOhj19jb39xVm1Dm5B5O04V/eq9Zzvd5yuH3rFuDNYt5w7n4Cq2jft7Xau0rGNUlemK2UATSFgrJA/iwzY21wUdwzT2jhYcOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6xoRpQy; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6xoRpQy"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2be19f05d7dso6155129eec.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648144; x=1773252944; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGZZpQUs2JU6feqN07JnIijdY7YhuFyGOr34QG2qB8A=;
        b=W6xoRpQy42gh6KyQvyR31htqpz9zY4LHQCJlHroBOxDpPzHN3CYzgm3rijK/ka3Pr1
         hyPXO3yynQPAR6MBwQxE9PSTo9/nWJDOlVWU704xgVWwdXgyNW+477zM06BO0RfCDBr0
         I5mE1kdImzfzCaRkI1j/gbHRxAjUd8fFCzBNwR6C4B4BNxwnHGpxfzh6WWFHzQIf1mnz
         KeLlcfidWhyUyoELKepzkeZ1I8DSv308DLwOLHNR1NrJhXi7WEmTfJYs9JCYZ22K1j3F
         1w7yXHyV2qzM4jiH7HW82z0s0FGkLtQrxywtmT3dlwRkEWvbOysHPQELgnC8tfZidCId
         sQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648144; x=1773252944;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGZZpQUs2JU6feqN07JnIijdY7YhuFyGOr34QG2qB8A=;
        b=IBE+zRG4srgKB5q11uwiSzTvCJZ9KTkHNnHrWcUryl/GYXIc3CiXNSXAOavtx340Ch
         CIbLu0r8/qJ/nii1TOJbkgqTGBZPMCZGFpM98Q+FO9PyGEZaEMbQbN5yTBNgkTXmR0yO
         k0kXJp+IFJC32Gm/eu7qEONSV8ZVCCwNh1OrMfInGaSBQOZDxGMoDxlEQyxicu978Zbh
         qAEv2OgYQAzX3QFnnC0tR++QLfgDuMjJbws51Ttgy2TtVNPSI1VWdoOfC/R//XNi+gAQ
         FfGyMBpolmnSVGlo+oWvc6dzuQRStMeKmRMFrrRFRU6d7DUh17S0hlbPyVY4/x0j+QRH
         QiaA==
X-Gm-Message-State: AOJu0Yyry4SYXOnTzCveTTsBU4OogUTrlamesBGH/Pvs9mkWRHkUQL8b
	cJkKhvHdaMQldeQ3Cm/yFu5wL5ZVQt9Q7hfC9+GSPZQ9WYCRdvfCg/Ax/YAYvBaq
X-Gm-Gg: ATEYQzzTTGHuAaKyzD7t4NSTGTiYywDIdi6/mLjrsJJ+ACDI1GRcN8wUwFYe86ogrep
	qeCsnTXwY+Wxiua2TuVV2d/44OdjRqZMKDBwhYAmaG9IpKo7KDR18gy1iVtrWEVQIRyQPxFpvzA
	n4F1JeLjDpUt7hqJA1ex+Ub0orx9lGht+HYySfqPnBFq6PvVjcoAwzSP95lfkRV2RhBi9gIrLRo
	K4knThQ0XaukuPr4G3HJl+T/+flqy1cw79eaTGm4VQgO4jsW761VzkIPrYxYm2HCo6LSYs36qa9
	bGxx0JEcsEg1WSEvm2Uykbx+ZhZ9EjG0OmA0U105YxPa6V3PZfhI3zwtOzLCw/TCV33NTbtS2vJ
	sBCbHJFGVZuq1NDXkthGjHkbN4I5kngYm5s7IuD0ulgfx6ZLw970WJkis6ZsmhuHDr4StaIXR6h
	idCR25mqQeAGEGYgbXeDYtdy8Qcc5qcPHWDdjG
X-Received: by 2002:a05:7300:ef97:b0:2bd:fff8:c7ea with SMTP id 5a478bee46e88-2be311d2377mr1170465eec.38.1772648144375;
        Wed, 04 Mar 2026 10:15:44 -0800 (PST)
Received: from [127.0.0.1] ([57.154.172.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be09bc9ec4sm8841182eec.24.2026.03.04.10.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:15:43 -0800 (PST)
Message-Id: <76b171ab5c3d367e8f8fd825a7e296c399d26a95.1772648125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
References: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
	<pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 18:15:24 +0000
Subject: [PATCH v8 11/12] fsmonitor: add tests for Linux
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


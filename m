Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2F47AF63
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 15:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277989; cv=none; b=UHm29yl4+r/8xfAuh2ZW8TAEcgYh+FWEkAp0j1jUWUUCGK4TgkNre83kSs63tjf+3EQa+y8VU8F7F7uATpG7SMzF3wJQabU2oryAetL0O3usI4wVvHp1tFoxcyNp+CTqb29NzsytSseexnR16gVH0D0FTcq3Fs/Elv0mS5t/m90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277989; c=relaxed/simple;
	bh=qjUJ/7V7AxWjs2aczvuOdhFzxx816TwPue8YAKrIiZQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XO7SswLCz7hs+ONMENhAmZkjDKxdk8y+vGfxd+9+2hwHMx+VlXW4X5hkhyKxek7YKd/zUx8b8uPICv3bTdHXpnairMqxWNh1imdAnKiZKEtGco9iVCMstBgVL5BFKcaJnDGmMTdJJUeCan+zrhgPp4nNB7Ha237s/BXo+180XCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFiU7i+s; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFiU7i+s"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so6848809a91.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788277987; x=1788882787; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XWABB9docqJ4DARDbcyv+S7U3X01an+YMBzPqf2ySlY=;
        b=kFiU7i+sGoZSZ9YcN2FCVmG0KiBROZRLRZLMvbvt+EDIKM7xn697sfauV1Af3otYKH
         i/ELxj9d38pDA0jXAevK7g/NNGRk+YYJDg9f4jC7S/KZJ+gVI8n7kahwld/VvFtYN9Pm
         DGPpyrTU2NH+y/DMclUfJuPYsG/BdHadZVNMcBZP5iuz0El4m2bncw3EE/1R/ejdZYIR
         4pvUpebM9ySb/YMy79Wk4aIGzjxkewuSGPhKsInOsSOgNOX/9tfCzUxUZ9wHn+0zf0L1
         MGOY+zp55Pgts2YIdh+hzobw+0J5EwUuPogeu8mjxCOVnSkHY461xgQg5k4DzukrMLlR
         y15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277987; x=1788882787;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XWABB9docqJ4DARDbcyv+S7U3X01an+YMBzPqf2ySlY=;
        b=OGkRVzejGJyVC9mRk0MfFe7GWEz35vcofQWyj1rs4/DqtVu+sdDrdT/aaG8UYFNv8Y
         XxRKTU8JqkYoIwyP8N7K4svFnQVAol+mxJ/nb4Ib6hP9X5giZuQ2QKN0xJwfKWPbjx2Q
         1PWc0P+Bs+VulxG6aADcTRqkUYFax1JFOqPMy5HSdjWLI3xAtRATZO3K8orPBckdhe7u
         vGVANsVWvZ2EkxzE8W+tcmo/Bhpa8GIrR+zUtq5Z0GCd94ZiSantoli+UUwW5WJh4+QX
         gsaGozJAFzP7hCgUDWEJ6wIx+lWsC6vyLWie18YuIR4f9XYBxWeMc7e9efRe7c6x92ec
         kLkQ==
X-Gm-Message-State: AFuF++nZkp0G5xX4cXmVOMD7F87caTXYmqMDX0Njkh34w6L27MUZemN8
	5odVgJcUrSRArJn4MAB40pmNLkBd5bS+U50Wl4Y7bsslRaEG5AoX6nYnwtWvNg==
X-Gm-Gg: AYBFou3b92584XkBVYlVnH4Hc4HHdkfXd1A9NOrib3ZMzcCYCEosn0blDmn9lqQolBT
	grvONVq49LTE7BHpHdoo6k3opVToHmYq9UeScQbqkEd1LrS/lpodfWnE8SGvMvwo0fXRS7UN3Oi
	KRvUsSI7kZMhfkgRO5tjS8r8uduu5eF3V18qaarzeRgzDuG6cDW7zq2vVDuU9GZW8KTCE0K5Wui
	WPYPJy/1CkyUEo/sHCM9YdK9zIs9CcK1AKDlU43nvzerpugSIhd+eSjVl3iYMLCPA0QE8//9wUY
	jGQD+uoCKDA+nHTcWEKXoYhJBcDEOY2abK2RVSMhC+9enjiNcYg/ra/8ATgZ7zaN2u3Jl2/h9mR
	cb+y9mLJRhVhbj+QCTU6yf858tlrP/1F6v9LQnUmDxTR+1j9krsvwRAvZIAkpziX9TcUrN55PLu
	DbuNmYGkJJgZ0UfO7M/ukx4U7bgZzDTmiya2kRWP65eL0Yszv26Ilo+6x1CV5mXw==
X-Received: by 2002:a17:90b:4a42:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-3990723f576mr13065540a91.0.1788277986940;
        Tue, 01 Sep 2026 08:53:06 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.3.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f784857sm38314495eec.3.2026.09.01.08.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:53:06 -0700 (PDT)
Message-Id: <e202142f1999a57d485cae0d50a1a7c1afa50763.1788277983.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.v5.git.1788277983.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v5.git.1788277983.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 15:53:01 +0000
Subject: [PATCH v5 1/3] t/lib-httpd: fix apply-one-time-script race under
 concurrent requests
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
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

apply-one-time-script.sh is a test helper that executes a
"one-time-script" responsible for modifying the response normally
returned by git-http-backend. apply-one-time-script.sh should run
"one-time-script" once and return a modified response once. However,
sometimes a race between multiple concurrent requests causes
apply-one-time-script.sh to misbehave and return multiple modified
responses or an empty response that results in:

  fatal: ... The requested URL returned error: 500
  fatal: could not fetch <oid> from promisor remote

This can be seen in the flaky failure of t5616.47 on the macOS CI
runners.

Fix the logic that checks if "one-time-script" has returned its modified
response by chaining "rm one-time-script" with its execution. This
ensures a racing script does not also have the opportunity to execute
"one-time-script".

Add t/t5567-one-time-script.sh to verify the race is fixed. Implement a
stub "git-http-backend" that intentionally invokes a concurrent request,
and check that only one modified response is returned without error.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-httpd/apply-one-time-script.sh | 38 +++++++----
 t/meson.build                        |  1 +
 t/t5567-one-time-script.sh           | 96 ++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 14 deletions(-)
 create mode 100755 t/t5567-one-time-script.sh

diff --git a/t/lib-httpd/apply-one-time-script.sh b/t/lib-httpd/apply-one-time-script.sh
index b1682944e2..eac21a3a8e 100644
--- a/t/lib-httpd/apply-one-time-script.sh
+++ b/t/lib-httpd/apply-one-time-script.sh
@@ -6,21 +6,31 @@
 #
 # This can be used to simulate the effects of the repository changing in
 # between HTTP request-response pairs.
-if test -f one-time-script
-then
-	LC_ALL=C
-	export LC_ALL
+test -f one-time-script || exec "$GIT_EXEC_PATH/git-http-backend"
+
+LC_ALL=C
+export LC_ALL
 
-	"$GIT_EXEC_PATH/git-http-backend" >out
-	./one-time-script out >out_modified
+out=out.$$
+modified=out-modified.$$
+"$GIT_EXEC_PATH/git-http-backend" >"$out"
 
-	if cmp -s out out_modified
-	then
-		cat out
-	else
-		cat out_modified
-		rm one-time-script
-	fi
+# Since Apache can execute this script for multiple requests
+# concurrently, we chain "rm one-time-script" with the logic
+# for generating a modified response. If the "rm" ran separately,
+# a concurrent request could pass the "test -f" above and
+# erroneously result in multiple modified responses or an empty
+# body depending on the race state.
+#
+# We discard stderr for ./one-time-script since it is possible
+# ./one-time-script has been removed already, which is expected
+# sometimes. In this case, the unmodified response will be returned.
+if ./one-time-script "$out" 2>/dev/null >"$modified" &&
+   ! cmp -s "$out" "$modified" &&
+   rm one-time-script 2>/dev/null
+then
+	cat "$modified"
 else
-	"$GIT_EXEC_PATH/git-http-backend"
+	cat "$out"
 fi
+rm -f "$out" "$modified"
diff --git a/t/meson.build b/t/meson.build
index a25f37d2f5..e4d0b6dc4e 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -716,6 +716,7 @@ integration_tests = [
   't5564-http-proxy.sh',
   't5565-push-multiple.sh',
   't5566-push-group.sh',
+  't5567-one-time-script.sh',
   't5570-git-daemon.sh',
   't5571-pre-push-hook.sh',
   't5572-pull-submodule.sh',
diff --git a/t/t5567-one-time-script.sh b/t/t5567-one-time-script.sh
new file mode 100755
index 0000000000..a8429ef3c3
--- /dev/null
+++ b/t/t5567-one-time-script.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+
+test_description='apply-one-time-script CGI helper is safe under concurrent requests'
+
+. ./test-lib.sh
+
+HELPER="$TEST_DIRECTORY/lib-httpd/apply-one-time-script.sh"
+
+test_expect_success PIPE 'helper only serves one rewritten response for concurrent requests' '
+	mkdir workdir fakebin &&
+	ENTERED="$PWD/entered" &&
+	GATE="$PWD/gate" &&
+	export ENTERED GATE &&
+	mkfifo "$ENTERED" "$GATE" &&
+
+	# A stub git-http-backend that returns a response based on
+	# $ROLE. For $ROLE = modify, return the response string
+	# "packfile", which ends up being modified by the example
+	# one-time-script below.
+	#
+	# Otherwise, run the branch returning a response that
+	# should be passed through, and block until released
+	# by "read -r $GATE".
+	write_script fakebin/git-http-backend <<-\EOF &&
+	printf "Status: 200 OK\r\n"
+	printf "Content-Type: application/x-git-result\r\n"
+	printf "\r\n"
+	if test "$ROLE" = modify
+	then
+		printf "packfile\n"
+	else
+		echo entered >"$ENTERED"
+		read -r released <"$GATE"
+		printf "refs\n"
+	fi
+	EOF
+
+	# An example one-time-script for apply-one-time-script
+	# to execute. Checks for "packfile" in the response
+	# that will be returned, and replaces it with a
+	# modified response. Passes through responses without
+	# "packfile" in them.
+	write_script workdir/one-time-script <<-\EOF &&
+	if grep packfile "$1" >/dev/null
+	then
+		sed "/packfile/q" "$1" &&
+		printf "REPLACED\n"
+	else
+		cat "$1"
+	fi
+	EOF
+
+	GIT_EXEC_PATH="$PWD/fakebin" &&
+	export GIT_EXEC_PATH &&
+
+	# Ensure $GATE has a reader so the test does not block indefinitely if
+	# the helper is buggy and "echo released >&9" below does not unblock
+	# the unmodified response gate.
+	exec 9<>"$GATE" &&
+
+	# Launch the passthrough request in the background. Record its pid
+	# so it can be killed when the test finishes if, for some reason, the
+	# request stays blocked and would stall a test runner.
+	{ (
+		cd workdir &&
+		ROLE=passthrough sh "$HELPER" >../passthrough.out 2>../passthrough.err
+	) & } &&
+	passthrough_pid=$! &&
+	test_when_finished "kill $passthrough_pid 2>/dev/null || :" &&
+
+	# Wait until the passthrough request is "in-flight" and paused
+	# mid-response.
+	read -r entered <"$ENTERED" &&
+
+	# Launch the request for a modified response while the passthrough
+	# request is concurrently "in-flight" and paused.
+	(
+		cd workdir &&
+		ROLE=modify sh "$HELPER" >../modify.out 2>../modify.err
+	) &&
+
+	# Unblock the passthrough request, allowing git-http-backend to
+	# complete its response.
+	echo released >&9 &&
+	{ wait "$passthrough_pid" || :; } &&
+
+	test_must_be_empty passthrough.err &&
+	test_must_be_empty modify.err &&
+	test_grep "Status: 200 OK" passthrough.out &&
+	test_grep "Status: 200 OK" modify.out &&
+	test_grep REPLACED modify.out &&
+	test_grep ! REPLACED passthrough.out &&
+	test_grep refs passthrough.out
+'
+
+test_done
-- 
gitgitgadget


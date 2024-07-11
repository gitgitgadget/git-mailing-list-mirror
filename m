Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46F416132B
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707057; cv=none; b=guh+fNwXG2ndiQ1HvmhVGsovmNGDki8o3I54f1qL7DXBtv+fOxIEk+EgQ7IjJKMB6EdRz3m+roMgxA/mdWxc8B0obObm/mGInj0kQ/IorNoOxiHeUxQDGXyQaNjt5yLM46eh5ccWqz2vsXy6Hz0a9WUVTU0ophR1Q5QAmPFALsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707057; c=relaxed/simple;
	bh=mft5DohuCmJtFySt0yUQbXsMPL3Qr+0RYldSok9K5e0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sa0LNR/gp+AtQ2QgdJawE65yKQuwz89VlIreo0ieBfCOLyrdU4bZKBBx7KCKNnR4zdElVPPqSZCZVnVziJUwqm2yvL7AHRe+wD/q3kFb7HhLDeHSVcgI1h0ycUjToHmhCrrnFRZcrkNbKl7N+XKm70GHW4LogK+fgpA+I5gwauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0JeTHYZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0JeTHYZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c97aceb6e4so741004a91.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720707055; x=1721311855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RKGwSxqxUTze8JjYMb4KHZce39QwVcV29VnD6PfgJ0A=;
        b=F0JeTHYZMAb8Hqif5w7BPKHhEsHTEzBV1L7RTDtE4Aqo7hKJrI50zD7uuPlIeqELE6
         PfYhO2SKfvuQlJOGmHIYdPl56JlYCb1BvfnvuoL+hvjUyPGEojtUVAeQ/Iq8Fe7QKi6w
         2m+uvCbnASw2GWiz2kXzimaWzh15Ik33APWAyVcDFrnWU7PQTejsZHmbjpDjh5GG6jWN
         O/pa7W2i5PMaZReC5QRJplpd777obrX/4YHlhaoyE2CgVVJYree2wNEDUb/r85cCr0pZ
         5VewO5Qt4e1aLID5NUA0xEn7jqAA+1SVN8tKnkHjncxueQvTUmD5c59e5M1vwGhpAc9s
         9cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720707055; x=1721311855;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKGwSxqxUTze8JjYMb4KHZce39QwVcV29VnD6PfgJ0A=;
        b=t4vR1BgpPgYmC6zwfrEY31lESeUhU7HALfHi74QnLlO0uaMueyFLiLu5Oy1ocN+srr
         iHjH4V8mUQrxhZ8tMX29enBY5z4cskdPFfWdTIpUlkZ7s2+/9xkJAKZloaT5RIYWqZQL
         rXfBduGMei0Ogo5skKs2I50aA3V+LKpBo1rIZHzFb04p5Mw0JGs2M3+A8gbmTwk4Q8xY
         m52xwMdIJujjfGi0c0It676WZK6Y+qhv7B5EEG1+G3C7jaqq6jwVuu8Z2+azMCyNeC5z
         AH3lAJFmTLuJZSSK+nuuUgOhMmdpsiVbZ9u6szIyWsev62vPskhVl7wqA30syq1VymRa
         T0DA==
X-Gm-Message-State: AOJu0YxgTINnQiEW/HLPQeSBrzKVwq323FDDODbQdB+RtTr/MwwediAh
	TmhqmpNLnl/Wz02grMLPuk0ARdLiK4R3XZlfu43vlJKSuc7ywgQLVQDaNg==
X-Google-Smtp-Source: AGHT+IHtCUdzrA0vIkiRevsNeJpxViK/v0Mys+/wjIm2Tt1VRBBDt8h5d7pQvBFuEVGnw0kWLTlCiA==
X-Received: by 2002:a17:90a:3901:b0:2c2:e97f:89d8 with SMTP id 98e67ed59e1d1-2ca35c30bf1mr6921662a91.13.1720707054786;
        Thu, 11 Jul 2024 07:10:54 -0700 (PDT)
Received: from [192.168.43.32] (200.149.159.133.rev.vmobile.jp. [133.159.149.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca888286d1sm2835358a91.45.2024.07.11.07.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 07:10:54 -0700 (PDT)
Message-ID: <fe8cd0d1-e451-43d0-b033-11bbb6d1ed56@gmail.com>
Date: Thu, 11 Jul 2024 23:10:51 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] test-lib: GIT_TEST_SANITIZE_LEAK_LOG enabled by default
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <598149bf-6541-4c9e-8c94-a108e3ee7fd7@gmail.com>
 <d5c307e3-79c5-4795-838d-4a425b012ec0@gmail.com>
Content-Language: en-US
In-Reply-To: <d5c307e3-79c5-4795-838d-4a425b012ec0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As we currently describe in t/README, it can happen that:

    Some tests run "git" (or "test-tool" etc.) without properly checking
    the exit code, or git will invoke itself and fail to ferry the
    abort() exit code to the original caller.

Therefore, GIT_TEST_SANITIZE_LEAK_LOG=true is needed to be set to
capture all memory leaks triggered by our tests.

It seems unnecessary to force users to remember this option, as
forgetting it could lead to missed memory leaks.

We could solve the problem by making it "true" by default, but that
might suggest we think "false" makes sense, which isn't the case.

Therefore, the best approach is to remove the option entirely while
maintaining the capability to detect memory leaks in blind spots of our
tests.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

This iteration mainly reduces the noise introduced in the previous
iteration. 

 ci/lib.sh     |  1 -
 t/README      | 26 +-------------------------
 t/test-lib.sh | 37 ++++++++++++++++---------------------
 3 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index ff66ad356b..fe52954828 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -374,7 +374,6 @@ linux-musl)
 linux-leaks|linux-reftable-leaks)
 	export SANITIZE=leak
 	export GIT_TEST_PASSING_SANITIZE_LEAK=true
-	export GIT_TEST_SANITIZE_LEAK_LOG=true
 	;;
 linux-asan-ubsan)
 	export SANITIZE=address,undefined
diff --git a/t/README b/t/README
index d9e0e07506..ea620de17e 100644
--- a/t/README
+++ b/t/README
@@ -382,33 +382,9 @@ mapping between "TEST_PASSES_SANITIZE_LEAK=true" and those tests that
 pass under "SANITIZE=leak". This is especially useful when testing a
 series that fixes various memory leaks with "git rebase -x".
 
-GIT_TEST_SANITIZE_LEAK_LOG=true will log memory leaks to
-"test-results/$TEST_NAME.leak/trace.*" files. The logs include a
-"dedup_token" (see +"ASAN_OPTIONS=help=1 ./git") and other options to
-make logs +machine-readable.
-
-With GIT_TEST_SANITIZE_LEAK_LOG=true we'll look at the leak logs
-before exiting and exit on failure if the logs showed that we had a
-memory leak, even if the test itself would have otherwise passed. This
-allows us to catch e.g. missing &&-chaining. This is especially useful
-when combined with "GIT_TEST_PASSING_SANITIZE_LEAK", see below.
-
 GIT_TEST_PASSING_SANITIZE_LEAK=check when combined with "--immediate"
 will run to completion faster, and result in the same failing
-tests. The only practical reason to run
-GIT_TEST_PASSING_SANITIZE_LEAK=check without "--immediate" is to
-combine it with "GIT_TEST_SANITIZE_LEAK_LOG=true". If we stop at the
-first failing test case our leak logs won't show subsequent leaks we
-might have run into.
-
-GIT_TEST_PASSING_SANITIZE_LEAK=(true|check) will not catch all memory
-leaks unless combined with GIT_TEST_SANITIZE_LEAK_LOG=true. Some tests
-run "git" (or "test-tool" etc.) without properly checking the exit
-code, or git will invoke itself and fail to ferry the abort() exit
-code to the original caller. When the two modes are combined we'll
-look at the "test-results/$TEST_NAME.leak/trace.*" files at the end of
-the test run to see if had memory leaks which the test itself didn't
-catch.
+tests.
 
 GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
 default to n.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7ed6d3fc47..54247604cb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1271,10 +1271,10 @@ check_test_results_san_file_ () {
 		invert_exit_code=t
 	elif test "$test_failure" = 0
 	then
-		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!" &&
+		say "Our logs revealed a memory leak, exit non-zero!" &&
 		invert_exit_code=t
 	else
-		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak..."
+		say "Our logs revealed a memory leak..."
 	fi
 }
 
@@ -1578,33 +1578,28 @@ then
 		test_done
 	fi
 
-	if test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
+	if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
 	then
-		if ! mkdir -p "$TEST_RESULTS_SAN_DIR"
-		then
-			BAIL_OUT "cannot create $TEST_RESULTS_SAN_DIR"
-		fi &&
-		TEST_RESULTS_SAN_FILE="$TEST_RESULTS_SAN_DIR/$TEST_RESULTS_SAN_FILE_PFX"
+		BAIL_OUT "cannot create $TEST_RESULTS_SAN_DIR"
+	fi &&
+	TEST_RESULTS_SAN_FILE="$TEST_RESULTS_SAN_DIR/$TEST_RESULTS_SAN_FILE_PFX"
 
-		# In case "test-results" is left over from a previous
-		# run: Only report if new leaks show up.
-		TEST_RESULTS_SAN_DIR_NR_LEAKS_STARTUP=$(nr_san_dir_leaks_)
+	# In case "test-results" is left over from a previous
+	# run: Only report if new leaks show up.
+	TEST_RESULTS_SAN_DIR_NR_LEAKS_STARTUP=$(nr_san_dir_leaks_)
 
-		# Don't litter *.leak dirs if there was nothing to report
-		test_atexit "rmdir \"$TEST_RESULTS_SAN_DIR\" 2>/dev/null || :"
+	# Don't litter *.leak dirs if there was nothing to report
+	test_atexit "rmdir \"$TEST_RESULTS_SAN_DIR\" 2>/dev/null || :"
+
+	prepend_var LSAN_OPTIONS : dedup_token_length=9999
+	prepend_var LSAN_OPTIONS : log_exe_name=1
+	prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
+	export LSAN_OPTIONS
 
-		prepend_var LSAN_OPTIONS : dedup_token_length=9999
-		prepend_var LSAN_OPTIONS : log_exe_name=1
-		prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
-		export LSAN_OPTIONS
-	fi
 elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
      test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
 then
 	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
-elif test_bool_env GIT_TEST_SANITIZE_LEAK_LOG false
-then
-	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_SANITIZE_LEAK_LOG=true"
 fi
 
 if test "${GIT_TEST_CHAIN_LINT:-1}" != 0 &&

base-commit: 47c6d4dad22a751068a4975f1c4177cc6c0c41d2
-- 
2.45.1

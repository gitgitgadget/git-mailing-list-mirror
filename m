Received: from mail-qk2-f38.google.com (mail-qk2-f38.google.com [74.125.230.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9783BCD1A
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621703; cv=none; b=A5+7m6dw9wlj9EUReUeBC8bOnMKjQ2Tfs/K5Q95DIJEOf5sjhwje/kqjT3Bo5wZ13EaJ56ttFkcna/v2+B2QSQ4Jvr7yCwFv5gKGf1lhsiJzDneOB1ca37rgNKeSkpg7YMLVkTjoIK980NrlyK61cYB7UTSAmDpUFfQrxXBR9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621703; c=relaxed/simple;
	bh=qbiWE9203B2LGXIhCHZ6M03pPYvZwztSV48QpXIa0H0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CE9KbikCtxWwzR9Z6gnpO8EjxyvChCOESE0AFtZNh2LNZDqyM+pGGkPAS8mTJsg2b81jqT0YjymBUYqym6ZZoSU2LfaLOGh3xyq3kWBviaBWRLrPa6b4KCyK4rntLax98TasBE9n7/MRb6Fvc95/Q7o/0eKAR3hQ4daqfl4Isq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1jEOLd4; arc=none smtp.client-ip=74.125.230.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1jEOLd4"
Received: by mail-qk2-f38.google.com with SMTP id d75a77b69052e-53336049862so15566001cf.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621697; x=1791226497; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2Sf9S4LQxos0qTSB5PCL6N+RyYim9O4JWrapri5LjsI=;
        b=b1jEOLd4RKin5RDrijxHXUeBGoCLmrMo84HOEFYAHGTzQa/w0jqm/tm7C0t6PwlUK+
         XGONW1s6XDKqvtrR0ht0KYH0u1cahN2Y7rsgJGY12uYYSwS2RrdZZmQgx9zieyGTPL83
         GSDtRVHPv0FWbg8IY9SirEiCfjKTeygzOjpFYk60YO+yDUQSy9UNc0dWH9tNi7LaBf+7
         IREEchvUaa3hwqpwnnQuT42vAbQHFp4Pof5ibTuFRvpEkL9j96j3yEXLId/vrMKCgyE7
         yAmbin5zzbm2/MZeaYiUQa7H/f3dhf36iu8BPdvPhZwQCDiQlbdXMA+kv/mNbNPKmVoD
         FU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621697; x=1791226497;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Sf9S4LQxos0qTSB5PCL6N+RyYim9O4JWrapri5LjsI=;
        b=ZIQdFDtdJdv+UhVsHnZ8v74rpGZfpg42Vp6YP9Xqj5pCjSj95s7uPA9kinctrLY6YL
         jV6uV5lJI9jbAzEUpV+CZizRgPFIYetphd5Iodl/14jyiuqa+Gmg4gJqGgEBHwmsGIlF
         5TtM4Dxr7ye3syFvNYsyXsFgX57WHlNPkPiOMLiJS6yWNI7PcoPMDW8Am/hJw2FBT+/b
         96Cyqi/HZEl8+oTTra3SiMtefBbTAYQs4MhSf81uAMyTjKRFxxOddru0ZgK87u3Ky9BN
         MReBqiho22d8eIu4U1YIARcty4rCe3mad6Wy76iuyuJzYC7OPAyQ7srMTf7Gfsd4QSkQ
         /DfQ==
X-Gm-Message-State: AFuF++kTHIVHKWhSdo45KLatIKI+zwFjZQ8olV05UZpo66N91Rrz7+lB
	vCbgsGPZ8n5vfnU2DEzssjwCdjSpaWwjlc8CM3xKYHIamdlruW6c0A1MMrLDFQ==
X-Gm-Gg: AYBFou1VSA3mlIymcq7ML1P8ydWRgntPqbB6hMo4Mk3Fhhfh4BfsXE2D6j/si+ssjtg
	f/HKAaqmjscYJHckJdH9yT3nPtkHDd+b3Rwb6cZ4s2ekn0T92vGMHQvZvZpDh91PswI8WAlSJhR
	OmaZJFfA7dgf0jSo8cM2ARwebUE8ejIoyjDq8Cu3G/p+D57af17lXsNtgWe1i1C8PJpr25gUzUN
	bIC+OQw0tSqh+xUq081lbTAmcIpqh9xdg7HlG8XEJQItAMVRLPg6e6u4zoQFugdhqT5O78r1qew
	wBH/sS5Lf9K58m2fgDv0q6EFrvUBijnDSFwbkUCjg7e3v2yrQ5Dik73kySD5T7aMIREptuvPBQZ
	AzH34/+CshrWIvxz5DRn7jNQZMNooEfBIgEXkB7jYAtuZCEnhM8QYoDgd3MbjpOhnjHCda8aYj1
	580NP5LkiJ0qnagiu2JIAajDg+w2mChgjPFf1zscUsEiRo8ad50ZDL7AbAC7nxmOPulbKUfaM4b
	9ldX+yxuUBuFQo=
X-Received: by 2002:a05:620a:4492:b0:939:2c5c:7977 with SMTP id af79cd13be357-93c43c75a3emr2253356585a.20.1790621695598;
        Mon, 28 Sep 2026 11:54:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.213.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813dca59sm217177285a.22.2026.09.28.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:54:55 -0700 (PDT)
Message-Id: <46e13a6e77f0c1c23a0dfe6183e8c3dac405da89.1790621693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.v2.git.git.1790621693.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v2.git.git.1790621693.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 18:54:52 +0000
Subject: [PATCH v2 1/2] ci: annotate leaks and stop a leak-sanitizer script at
 its first failure
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A leak is only discovered once, at the end of a whole script, well
after every test has already reported ok, and it gets no annotation at
all, so a leak-sanitizer job's only visible failure is:

    Process completed with exit code 1.

Give a leak its own annotation. Point it at the test script, the exact
line isn't known, only which script the leak turned up in, and put the
full sanitizer report in a log group next to it, so it stays visible
and isn't capped to a handful of lines.

Once a script has one leak, it keeps running: the sanitizer log
directory is never cleared between tests, so every later test in the
same script sees the same leftover log entries and also reports "not
ok", burying the one real failure in copies of itself. Stop a
leak-sanitizer script at its first failure with --immediate instead.

A failing test already gets its own annotation once its script
finishes, but --immediate exits as soon as that test fails, before
reaching the code that writes it. Write the annotation first, so
turning on --immediate here does not silently drop it.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 ci/lib.sh                            |  1 +
 t/test-lib-github-workflow-markup.sh | 16 ++++++++++++++++
 t/test-lib.sh                        | 21 +++++++++++++--------
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index c6ccbf8c17..a89f480a78 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -382,6 +382,7 @@ linux-leaks|linux-reftable-leaks)
 	export NO_CVS_TESTS=LetsSaveSomeTime
 	export NO_SVN_TESTS=LetsSaveSomeTime
 	export NO_P4_TESTS=LetsSaveSomeTime
+	GIT_TEST_OPTS="$GIT_TEST_OPTS --immediate"
 	;;
 linux-asan-ubsan)
 	export SANITIZE=address,undefined
diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
index fa29a62aa3..0d54496358 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -28,6 +28,11 @@ start_test_output () {
 	github_markup_output="${GIT_TEST_TEE_OUTPUT_FILE%.out}.markup"
 	>$github_markup_output
 	GIT_TEST_TEE_OFFSET=0
+	github_markup_script_name=${0##*/}
+}
+
+github_annotation_ () {
+	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
 }
 
 # No need to override start_test_case_output
@@ -53,4 +58,15 @@ finalize_test_case_output () {
 	echo >>$github_markup_output "::endgroup::"
 }
 
+finalize_test_leak_output () {
+	# The exact line the leak turned up on isn't known, only the script,
+	# so point at line 1.
+	github_annotation_ error "t/$github_markup_script_name" 1 \
+		"memory leak logged in $this_test"
+
+	echo >>$github_markup_output "::group::leak: $this_test.$test_count"
+	cat "$TEST_RESULTS_SAN_FILE".* >>$github_markup_output
+	echo >>$github_markup_output "::endgroup::"
+}
+
 # No need to override finalize_test_output
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1f0505e412..3552a19323 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -199,6 +199,7 @@ mark_option_requires_arg () {
 start_test_output () { :; }
 start_test_case_output () { :; }
 finalize_test_case_output () { :; }
+finalize_test_leak_output () { :; }
 finalize_test_output () { :; }
 
 parse_option () {
@@ -822,20 +823,23 @@ test_failure_ () {
 	say_color error "not ok $test_count - ${pfx:+$pfx }$1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
+	if test -n "$immediate" && test -n "$invert_exit_code"
+	then
+		say_color error "1..$test_count"
+		finalize_test_output
+		_invert_exit_code_failure_end_blurb
+		GIT_EXIT_OK=t
+		exit 0
+	fi
+	# Write the annotation before the --immediate exit paths below,
+	# which call exit and would otherwise skip it.
+	finalize_test_case_output failure "$failure_label" "$@"
 	if test -n "$immediate"
 	then
 		say_color error "1..$test_count"
-		if test -n "$invert_exit_code"
-		then
-			finalize_test_output
-			_invert_exit_code_failure_end_blurb
-			GIT_EXIT_OK=t
-			exit 0
-		fi
 		check_test_results_san_file_ "$test_failure"
 		_error_exit
 	fi
-	finalize_test_case_output failure "$failure_label" "$@"
 }
 
 test_known_broken_ok_ () {
@@ -1218,6 +1222,7 @@ check_test_results_san_file_ () {
 		return
 	fi &&
 	say_color >&4 error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
+	finalize_test_leak_output &&
 
 	if test "$test_failure" = 0
 	then
-- 
gitgitgadget


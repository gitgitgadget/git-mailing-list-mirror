Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6993672A8
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362448; cv=none; b=EAPjnYjdSSJPWJQY64aL71q5g3tKexykYGneVXfpV5MwUs4OurHCBIF0Bnzoje+olNkszjIMTZcMYKkie/HVbo84UdSAgmjqJhPfNDH2MizbZXFkJPV6b7DHWAzwRP2SKUKA9i3bVi1sDNRbuBf+ueGMLdbISKWkYFtHQdKOdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362448; c=relaxed/simple;
	bh=7k/+ZrHeqxS4pLsfZO+5pQhmasnDunnksVwPTFaG/YI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=AFRTGEb0qatWSk3dDvrOjsB+/o6vL1/4niHjdXTzYq0ToB4FcJqyIvoCtk2ImVU1TA/BiAg2VHMvYnf/fx8Mv2LXITMFC+C9mx69X6D9DwGYkEJobdOPMIiRfhPyiKs/H91WB0EVerLl7tycKsoUmV8cyMUUyBOpneHmFn8smbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIovDX7l; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIovDX7l"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b34face6d0so579200eaf.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 11:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790362445; x=1790967245; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ui5rxMtyXG57bK2sODSfTMbDgkk2pAXP33KnF9ku3uI=;
        b=pIovDX7lgeOWgElSru8FtH9m91uJzpikoTiUut/8s4/3jiWY57BylDx7hXOXxdmrl0
         bpL+p9hqvYj/6PlmhoIksLqy/Fu5SgxKDPcj6IDblW5dBhWO2ykrEOKiLXgPp6Ddi/V9
         rf6bpYOhb0UUK4JI9+KioxbDg7wuj9Fh3mW35yfa03ykbRfF+GeX4kgK+ZPPrlA6S6od
         sFDVyFxvsSPM+vhb9QvbbIb9cTKWDUp7Jtb6QlxsOzZ51iLrbhWGpdnQs9wzg43n7O+D
         SfBSR0zukCMDPspsZlsJ1e5GRjO3+ZRjzjjmRdR+L9aFkjT+x3mXY5ojNG5MdGsNl782
         jMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790362445; x=1790967245;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ui5rxMtyXG57bK2sODSfTMbDgkk2pAXP33KnF9ku3uI=;
        b=YcwoR+X3c8GrBpV8sIPEztlTFg6J929fb2jNQf2TwkTaL4EsMBJ9mu9szCTKMJxGnS
         BaavGTHqg+W3KDup4tIqo9gDUKwASJilpUMQDEjTm2GU8pKMIkUFJ6K3ExIb2i/UGivx
         Ufd8E3r25Uv6EUUQJ7UIQkgVKIVLdX8bveGCd8eroDf5N81B+MM9MuPeKG4UcfBBQJit
         R5DLrLxG5wPxdrh5U5k8HnaWaX3S+gm4aoZAaN1SLCkt+XEGW4PIBXu6R/HzFS81Aow1
         OewzeVqf373rLxOR8w8TJ5XHUWBJs9IQCxJEL2npSAi4BokweBYk2Gh5uhdGJPXv7TPc
         zpqw==
X-Gm-Message-State: AFuF++nR9RAH3400Mp+FxOknvOKscwIhr+d1YxIGb8yBvv8YebydWyBY
	nni70dMs/yuVfonFMHw6ayKaTpCYr/bf6+vC+bTyHsdRYCyQqCEOVHpqcqTB1A==
X-Gm-Gg: AYBFou3yweB240nPxiYTEymW9ILdNVNFparuBgn/75wNSvzuprbZEAr4/hoUg2PVKIN
	skhHSfv+04dj1Y7UenzsyUX5uC9BcQ8ehwHRTuW99I39neLld377uahs7KU0HreUCvCs51x2y+B
	MTdeZqpskW/RM2aAU47CxTaEf/PWQQAvE13VqT05sn9V8p6SrQiTZ19MD6pkwmwmifUP9muTFr7
	HgHcRa+e6k1BZGcGRDCz28pK/SZP3gge06IhsBvC1WMdYN5Ne2HoKUa4RluoRXkls95jjHD9VX5
	4rAlG2yrw4UQ5OxS0+i4yikvxxLBO+uxlVHGaxGul8xCBeWJhg6QWy5hXo0lKDIAWjZ93e/1Cbg
	Z9ZL6GxhRwKJ7+JqEZJFPSJFVlKqa/cI1VnYkQyrLpRHzquQrm0yqwVaJDW6pT/5HmWwWSDkHsU
	cJhefAzx9EYEdBX0LwrhUxGool7bf9oOhRXixGPDCCAyca0617Ulf0pK6FHkPAZQmZAMACx1BF8
	Chk
X-Received: by 2002:a05:6820:81c2:b0:6b5:ec2f:3567 with SMTP id 006d021491bc7-6d43f4bb74fmr5521500eaf.24.1790362445159;
        Fri, 25 Sep 2026 11:54:05 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.134.180])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-493350123ffsm2605524fac.6.2026.09.25.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 11:54:04 -0700 (PDT)
Message-Id: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Sep 2026 18:54:03 +0000
Subject: [PATCH] ci: point leak-sanitizer failures at the actual test and
 error
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A leak is only found once, at the end of a whole script, well after
every test already reported ok, and the failure annotation carried
no file or line, so all a reviewer ever saw was:

    Process completed with exit code 1.

with nothing to click through to. Stop each leak-sanitizer script at
its first failure instead of running the rest of an already-tainted
script, and have both failure and leak annotations point at the real
file and carry the actual error, for example:

    t/t1507-rev-parse-upstream.sh, line 1:
    memory leak logged around t1507.1
    ==ERROR: LeakSanitizer: detected memory leaks
    Direct leak of 60 byte(s) in 1 object(s) allocated from:
        ...
        #5 in add_branch builtin/remote.c:135

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    ci: point leak-sanitizer failures at the actual test and error
    
    I discovered while running CI on another GitHub pull request that it's
    very hard to see where the error is for the leak tests.
    
    This will stop each leak-sanitizer script at its first failure and
    points annotations at the real file and error.
    
    Proof that it works:
    https://github.com/git/git/actions/runs/35871180948/job/107215430244

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2419%2FHaraldNordgren%2Fci-annotation-file-line-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2419/HaraldNordgren/ci-annotation-file-line-v1
Pull-Request: https://github.com/git/git/pull/2419

 ci/lib.sh                            |  1 +
 t/test-lib-github-workflow-markup.sh | 49 +++++++++++++++++++++++-----
 t/test-lib.sh                        |  2 ++
 3 files changed, 44 insertions(+), 8 deletions(-)

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
index fa29a62aa3..4f6460a0ad 100644
--- a/t/test-lib-github-workflow-markup.sh
+++ b/t/test-lib-github-workflow-markup.sh
@@ -28,6 +28,7 @@ start_test_output () {
 	github_markup_output="${GIT_TEST_TEE_OUTPUT_FILE%.out}.markup"
 	>$github_markup_output
 	GIT_TEST_TEE_OFFSET=0
+	github_markup_script_name=${0##*/}
 }
 
 # No need to override start_test_case_output
@@ -35,22 +36,54 @@ start_test_output () {
 finalize_test_case_output () {
 	test_case_result=$1
 	shift
+
+	case "$test_case_result" in
+	ok|broken)
+		# Exit without printing the "ok" or "broken" tests
+		return
+		;;
+	esac
+
+	test_case_line=$(find_test_case_line_ "$1")
+	test_case_output=$(test-tool path-utils skip-n-bytes \
+		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET)
+
 	case "$test_case_result" in
 	failure)
-		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
+		test_case_summary=$(printf '%s\n' "$test_case_output" |
+			tail -n 20 | github_escape_message_)
+		github_annotation_ error "t/$github_markup_script_name" "${test_case_line:-1}" \
+			"failed: $this_test.$test_count $1%0A%0A$test_case_summary"
 		;;
 	fixed)
-		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
-		;;
-	ok|broken)
-		# Exit without printing the "ok" or ""broken" tests
-		return
+		github_annotation_ notice "t/$github_markup_script_name" "${test_case_line:-1}" \
+			"fixed: $this_test.$test_count $1"
 		;;
 	esac
+
 	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
-	test-tool >>$github_markup_output path-utils skip-n-bytes \
-		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
+	printf '%s\n' "$test_case_output" >>$github_markup_output
 	echo >>$github_markup_output "::endgroup::"
 }
 
+finalize_test_leak_output () {
+	test_leak_summary=$(head -n 40 "$TEST_RESULTS_SAN_FILE".* |
+		github_escape_message_)
+	github_annotation_ error "t/$github_markup_script_name" 1 \
+		"memory leak logged around $this_test.$test_count%0A%0A$test_leak_summary"
+}
+
 # No need to override finalize_test_output
+
+github_escape_message_ () {
+	sed -e ':a' -e 'N' -e '$!ba' -e 's/%/%25/g' -e 's/\r/%0D/g' -e 's/\n/%0A/g'
+}
+
+find_test_case_line_ () {
+	grep -n -F -- "$1" "$TEST_DIRECTORY/$github_markup_script_name" |
+	head -n 1 | cut -d: -f1
+}
+
+github_annotation_ () {
+	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
+}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1f0505e412..a52589c6a2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -199,6 +199,7 @@ mark_option_requires_arg () {
 start_test_output () { :; }
 start_test_case_output () { :; }
 finalize_test_case_output () { :; }
+finalize_test_leak_output () { :; }
 finalize_test_output () { :; }
 
 parse_option () {
@@ -1218,6 +1219,7 @@ check_test_results_san_file_ () {
 		return
 	fi &&
 	say_color >&4 error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
+	finalize_test_leak_output &&
 
 	if test "$test_failure" = 0
 	then

base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
-- 
gitgitgadget

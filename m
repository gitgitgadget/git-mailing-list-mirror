Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D43ECBED
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880265; cv=none; b=Noy630NkkuIiwjl/gGOS/MGcuw4SxMshJFbbFwUFApOx3xiMyOxea/RvwPAoYAMqqac4HngKFxErHtXCfRnQI0uth0yuFwoSDzEbFUR8asz0t4CuRm1SGGl7l66GoZZKNOW8SDNyk4NfUMl24+Hi7zKVKpW0JWDYi7KDN1Y82Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880265; c=relaxed/simple;
	bh=rn7Am0Imdb6+0kfgYBFjJnq5ZhXwBhlAYRBMSH59nio=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S+K/ktvSqto0pVZa0yICeKBS3d0jwT3VMItOXhSMulatkDSxSHqGszPFlsw9XYq5kPyfdio9TvM3uEZ0DSqwLDpCTTk4mWtICg68q6cxmsNJT0qa2CoAZyQnHE/ixPNsmEDfJjtOSmHInEkgkYgrksrFYV/MTmJC9Y415BhcfXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyzaKiw5; arc=none smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyzaKiw5"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14f381f0424so98465c88.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 11:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790880259; x=1791485059; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bWNgS2thBxopOiSOZjeGda8tT5rEzF+/RTFv4vReYtM=;
        b=fyzaKiw5e/kDolnUPgjNpP8WAN7hJEHpAAW8zQesCktHdqTv9akyZMoyqTQXFDuxqW
         /sfJ9uRaGPKKzOo0CUj0cNiZskDTG5moq7dAmF1GD7t6SuIsw58O76iwMwf9+S41rAFf
         DXHZzKUaanvedKBaWDnJHxAq8gfFjgdwDKHuyEjesZgii3rObeRbIqquiDw/qZA8IniZ
         7UMbLDQgL2y04YksvluzfMOw7nIM6L1sCdUKXIoKJ8pdPJKYYpXIdSU9WjFSlTEA1dTN
         19wbllinXVCpbItEFsvKc/Uh/8qhdReAnQDlz+pBjIhvUwYht9KZr7m35C1SxhkacyrB
         NIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790880259; x=1791485059;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWNgS2thBxopOiSOZjeGda8tT5rEzF+/RTFv4vReYtM=;
        b=KWsmQnWtN+skc9CJnSFGCqyQLFo4abl+Tp3GjbgySXgG/43hLT/z8Q4K4i1gjdz/PK
         9vZfke8sfJzLgpp3/Un8K4rLoOzOveapkheN/1AmhsN61LrKNn41qoMZb7jirINy48Wt
         WEDz2aHBAemc/xDrCAznbiFhgw4G3ZgvZoEcC7MVEk7ndTqeYrIIEgquMA0rYWjekVI3
         gmMF4Dh83TUCtxQtuU0j5R00WXgNiuktaXkzBYmM+chFtYdDu8w5vAmIA6vaoTKrVMZR
         Hb7pSWx1NZLZDM4HmqWj4PlkE21UTTfCuWQ2l8db01pp/seQ7Ufhuz9TuNkGU55StWz8
         MgEg==
X-Gm-Message-State: AFuF++nCkgVfXMOBW8T0E/shTx8BhdaLnxzVqupabKqTZ+UUnzCtFECH
	NOZLu4W7Y66ZcDnKKfELuSQvg8a+fAmWb5oATCSv1PuKF9q2ph+tEWIlxioOdw==
X-Gm-Gg: AYBFou04C3TTulJ9gNxmRGqfIU96V07ABoRgv4P0QY9XujEhRMKZ2Q0/w/RJcESub1+
	+yjYEU+5Lj80CAv0YGWsYQSdZJr6qWwVp1OsotKvAwFmLSFU7M2SWoPBxJO7RWBVLq3QyUwqBXi
	9nnluXUpIgCUesWyfwtVz4YdAzgHWHAHpYHSCoRhCRPuI/c279UqiqoETYDGQC99RVlQ+BiXDSt
	+5IflRAYirOAYQXRLxf6HEKMKfXFwN35+bAkWdMCLwDeYkoB5zhmtxifTOqvYFFYKfV9IzEHU0v
	hPp4l4KvRl7xy/ILa2daMBRdCJopvDk5J+AgOmHE0AgKVIPlLiUZQHbFXdlJVjoZ70yQk5C6+TL
	8+DUu6B+nakuU3jKZIZsscPGMRvuQRJWrs8kcsWvjN3A2FyjuhhGTkAF34cWe6FBxhEw8f+2XoB
	+co9AjaYcYHX7L7cUNEko6ubQyJbD1GWb9DjHIqlZWr+XW0pVHl6wP0tZmed2t34CP92SWdLvpy
	/I=
X-Received: by 2002:a05:7022:7e0d:b0:149:ef22:2fa2 with SMTP id a92af1059eb24-14f5bbfac18mr24244c88.8.1790880258921;
        Thu, 01 Oct 2026 11:44:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.247.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f47092f39sm292609c88.11.2026.10.01.11.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:44:18 -0700 (PDT)
Message-Id: <138394b48b2422a54fe6862c8701b8869f9dcb4a.1790880255.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.v4.git.git.1790880255.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v4.git.git.1790880255.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Oct 2026 18:44:14 +0000
Subject: [PATCH v4 1/2] ci: annotate leaks and stop a leak-sanitizer script at
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
sanitizer report in a log group next to it, so it stays visible.

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
 t/test-lib.sh                        |  6 +++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

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
index 1f0505e412..e74a12f1dd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -199,6 +199,7 @@ mark_option_requires_arg () {
 start_test_output () { :; }
 start_test_case_output () { :; }
 finalize_test_case_output () { :; }
+finalize_test_leak_output () { :; }
 finalize_test_output () { :; }
 
 parse_option () {
@@ -822,6 +823,9 @@ test_failure_ () {
 	say_color error "not ok $test_count - ${pfx:+$pfx }$1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
+	# Write the annotation before either --immediate exit path below,
+	# both of which call exit and would otherwise skip it.
+	finalize_test_case_output failure "$failure_label" "$@"
 	if test -n "$immediate"
 	then
 		say_color error "1..$test_count"
@@ -835,7 +839,6 @@ test_failure_ () {
 		check_test_results_san_file_ "$test_failure"
 		_error_exit
 	fi
-	finalize_test_case_output failure "$failure_label" "$@"
 }
 
 test_known_broken_ok_ () {
@@ -1218,6 +1221,7 @@ check_test_results_san_file_ () {
 		return
 	fi &&
 	say_color >&4 error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
+	finalize_test_leak_output &&
 
 	if test "$test_failure" = 0
 	then
-- 
gitgitgadget


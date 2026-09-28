Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22E3C1D6F
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621702; cv=none; b=CxIW+5EbOAlF6Sx7KG9Y/dvujZyoegikdjMm4WUH9cSw0zOZeG8P1CFJlupEtZmsf6s1PZy9GmW/d0UTPIEJgKx9F2hiIN85cIJHZ+adaInjxRCOekIoqs2K5xJAh+P2xczCCr25Ym6eKGoLpRBSAxOxkO0BRHD+PkSmmhC0FhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621702; c=relaxed/simple;
	bh=NYydxF9FMIzasxbvuiJ2LL7ZsCTHDXaYfI6ZfsOotfU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lfDgmuVBkf0KVmYKdlEkFQGWTkZx2McJLzvtMvIQ2wkHQQwh1srWCbPj32v3UbxTf5H/MVW7xhvVbDJzlaNuo5TPskVWRXPNMtNrhVUwn6/kEui1W4vRzpQ8EM4eTgE/TKJIFYGFkfDs6zFFSkLjwq92Aga4msC3+XJH5hw2PPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpVYtU8S; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpVYtU8S"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5ce9914dso228546385a.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621695; x=1791226495; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VCea+HQVABqLo6SjbuGrPdhaAf61J/PtakVJ1erDzuM=;
        b=dpVYtU8SGy6TG2lU0OtKWPuaAr88hK2oVaLegNYiZ5t8FF6tEpj5IO10vfURQ46M3e
         /RY/UCYwhgA++qm7iKHXuojDPLOsDF1pjW2q55CbR+tYv8DF/Mc1ASecLduvIH2f/6vg
         3sO3m/I4Vea1cIdAJ3mzmnbDr0B2W4adnPZSAfx3PvgwoWV9As59d53g3svWuO0Qzm1O
         wYQgaJHe5r1EAaxMUu7ybpApJUGGSSk64qBuotO8X40xeixvKruaSE86uk5FX+qZvh/A
         Lb1qM4sHGaSOP0A1TPtMdtLY5Gkz/pIpayO2we0TsRGkffGhEBUhKcJItnmzR1yLTGBd
         /t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621695; x=1791226495;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VCea+HQVABqLo6SjbuGrPdhaAf61J/PtakVJ1erDzuM=;
        b=L5WsFUIco4gq6PvmyKdUUoA9Ho5Si0tVV72Y0A9HnFUQoi8jiM2ZuVH10OwbxF+R+K
         tg8TukBK+Q9EKVIf01PrKzt+pX7SNL4vR6zXcMm0/HX70fnUQ9VRVjDewPweKG/BVdrT
         oJfnS4jI8XW/QDP+NoSgnbTGvdHINR/sWKEViVQzyEOmvfk21v4bNRwRuPDsPH0a4Uik
         qatB5HJqpqTnwNp1MsL3h+Q+rlRyAfNBB8WX7dfOTd1xYyug0VgDu/KZ+EqroEOJz6b8
         HYoehY4G/etUblTPXGBqmTl/e0wPUvxVKpAC4UrIPjDSlzfVf9P1lUq8e8Utjp4gRRTT
         Gb4g==
X-Gm-Message-State: AFuF++nLp+6STMhn8wXwq/XtB1UwQsXbRAw9rz2DhbE7be7t3L0WG7wR
	ZSFzEpjJ5WqJzKwr0BLS3UYwVYiFr3PnKqozRQdx9VyS1cc3gFYYpcwTWkqGrw==
X-Gm-Gg: AYBFou0KBJ9gBNmWSLGnfxD8rzp2iWfV6E/hk2ZKNeNeuOWnc5hGsvQiIrlfiHcG34r
	46PYGzmoFtPKJqZSvoa1Ju61ae2fPb7l/4L+iKxvJuxP1+Pz/deoKHhoumgfunsV+chkrh+IwcM
	ky9d5d8jSvlaxItfHLZT0l5x9KyaKbmTizvVzbhOTWOqxxwukGAqr21wtnt0LnNKxfVq3Ow0CPg
	JTwGa2qvtCrNnMrTC57BbTS3sp9ISAyB+y1zSlJ5CLoHVzX3DdrxQyZb+waq6uHjmvq/u8SJnDv
	QOsa5aN77YUxZII5FAhCyIWvZS8aL8k88IbDdb8W6c5v1DKixTZDIHfLZl3+R+hS2WCP5+FGrx+
	U+6mmJIeSPw8ZRpeWBoCqw43lP72pBgPCLpmLlcJE8VjOgw+mBseaO4ktXwPZ/x4aXK53I4TDbk
	WapFXBgXK6grwfMuAe3nJpDKvzU5ggijut6eq5MLmrPjJTxQzlFteEEd82RlFHKx7sO8vr3QpxS
	es=
X-Received: by 2002:a05:620a:1b99:b0:93a:18f7:5aa9 with SMTP id af79cd13be357-93c43b7e09amr2174313885a.4.1790621694685;
        Mon, 28 Sep 2026 11:54:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.213.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813a5ae6sm216647485a.13.2026.09.28.11.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:54:54 -0700 (PDT)
Message-Id: <pull.2419.v2.git.git.1790621693.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 18:54:51 +0000
Subject: [PATCH v2 0/2] ci: link failure and leak annotations to the test script
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
    Harald Nordgren <haraldnordgren@gmail.com>

Link failure and leak annotations in CI to the test script, so both can be
found from the job summary.

CI Job where failures and leaks are reported:
https://github.com/git/git/actions/runs/36449319996/job/109020434364?pr=2426

Changes in v2:

 * Split into two commits, each explaining its own reasoning.
 * Leak output is no longer capped or embedded in the message, it's now an
   uncapped fold, so multiple leaks in the same test both show in full. A
   second leak in a different test still won't show in the same run,
   --immediate stops the script at the first failure, but it no longer gets
   buried under every later test falsely reporting "not ok" either.
 * Drops the giant unfolded message that annotations used to carry, which is
   what probably caused the scrolling behavior.

Harald Nordgren (2):
  ci: annotate leaks and stop a leak-sanitizer script at its first
    failure
  ci: point test failures and fixed known breakages at their file and
    line

 ci/lib.sh                            |  1 +
 t/test-lib-github-workflow-markup.sh | 57 ++++++++++++++++++++++++----
 t/test-lib.sh                        | 21 ++++++----
 3 files changed, 63 insertions(+), 16 deletions(-)


base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2419%2FHaraldNordgren%2Fci-annotation-file-line-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2419/HaraldNordgren/ci-annotation-file-line-v2
Pull-Request: https://github.com/git/git/pull/2419

Range-diff vs v1:

 1:  61b0355780 ! 1:  46e13a6e77 ci: point leak-sanitizer failures at the actual test and error
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    ci: point leak-sanitizer failures at the actual test and error
     +    ci: annotate leaks and stop a leak-sanitizer script at its first failure
      
     -    A leak is only found once, at the end of a whole script, well after
     -    every test already reported ok, and the failure annotation carried
     -    no file or line, so all a reviewer ever saw was:
     +    A leak is only discovered once, at the end of a whole script, well
     +    after every test has already reported ok, and it gets no annotation at
     +    all, so a leak-sanitizer job's only visible failure is:
      
              Process completed with exit code 1.
      
     -    with nothing to click through to. Stop each leak-sanitizer script at
     -    its first failure instead of running the rest of an already-tainted
     -    script, and have both failure and leak annotations point at the real
     -    file and carry the actual error, for example:
     +    Give a leak its own annotation. Point it at the test script, the exact
     +    line isn't known, only which script the leak turned up in, and put the
     +    full sanitizer report in a log group next to it, so it stays visible
     +    and isn't capped to a handful of lines.
      
     -        t/t1507-rev-parse-upstream.sh, line 1:
     -        memory leak logged around t1507.1
     -        ==ERROR: LeakSanitizer: detected memory leaks
     -        Direct leak of 60 byte(s) in 1 object(s) allocated from:
     -            ...
     -            #5 in add_branch builtin/remote.c:135
     +    Once a script has one leak, it keeps running: the sanitizer log
     +    directory is never cleared between tests, so every later test in the
     +    same script sees the same leftover log entries and also reports "not
     +    ok", burying the one real failure in copies of itself. Stop a
     +    leak-sanitizer script at its first failure with --immediate instead.
     +
     +    A failing test already gets its own annotation once its script
     +    finishes, but --immediate exits as soon as that test fails, before
     +    reaching the code that writes it. Write the annotation first, so
     +    turning on --immediate here does not silently drop it.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ t/test-lib-github-workflow-markup.sh: start_test_output () {
       	>$github_markup_output
       	GIT_TEST_TEE_OFFSET=0
      +	github_markup_script_name=${0##*/}
     ++}
     ++
     ++github_annotation_ () {
     ++	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
       }
       
       # No need to override start_test_case_output
     -@@ t/test-lib-github-workflow-markup.sh: start_test_output () {
     - finalize_test_case_output () {
     - 	test_case_result=$1
     - 	shift
     -+
     -+	case "$test_case_result" in
     -+	ok|broken)
     -+		# Exit without printing the "ok" or "broken" tests
     -+		return
     -+		;;
     -+	esac
     -+
     -+	test_case_line=$(find_test_case_line_ "$1")
     -+	test_case_output=$(test-tool path-utils skip-n-bytes \
     -+		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET)
     -+
     - 	case "$test_case_result" in
     - 	failure)
     --		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
     -+		test_case_summary=$(printf '%s\n' "$test_case_output" |
     -+			tail -n 20 | github_escape_message_)
     -+		github_annotation_ error "t/$github_markup_script_name" "${test_case_line:-1}" \
     -+			"failed: $this_test.$test_count $1%0A%0A$test_case_summary"
     - 		;;
     - 	fixed)
     --		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
     --		;;
     --	ok|broken)
     --		# Exit without printing the "ok" or ""broken" tests
     --		return
     -+		github_annotation_ notice "t/$github_markup_script_name" "${test_case_line:-1}" \
     -+			"fixed: $this_test.$test_count $1"
     - 		;;
     - 	esac
     -+
     - 	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
     --	test-tool >>$github_markup_output path-utils skip-n-bytes \
     --		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
     -+	printf '%s\n' "$test_case_output" >>$github_markup_output
     +@@ t/test-lib-github-workflow-markup.sh: finalize_test_case_output () {
       	echo >>$github_markup_output "::endgroup::"
       }
       
      +finalize_test_leak_output () {
     -+	test_leak_summary=$(head -n 40 "$TEST_RESULTS_SAN_FILE".* |
     -+		github_escape_message_)
     ++	# The exact line the leak turned up on isn't known, only the script,
     ++	# so point at line 1.
      +	github_annotation_ error "t/$github_markup_script_name" 1 \
     -+		"memory leak logged around $this_test.$test_count%0A%0A$test_leak_summary"
     -+}
     ++		"memory leak logged in $this_test"
      +
     - # No need to override finalize_test_output
     -+
     -+github_escape_message_ () {
     -+	sed -e ':a' -e 'N' -e '$!ba' -e 's/%/%25/g' -e 's/\r/%0D/g' -e 's/\n/%0A/g'
     -+}
     -+
     -+find_test_case_line_ () {
     -+	grep -n -F -- "$1" "$TEST_DIRECTORY/$github_markup_script_name" |
     -+	head -n 1 | cut -d: -f1
     ++	echo >>$github_markup_output "::group::leak: $this_test.$test_count"
     ++	cat "$TEST_RESULTS_SAN_FILE".* >>$github_markup_output
     ++	echo >>$github_markup_output "::endgroup::"
      +}
      +
     -+github_annotation_ () {
     -+	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
     -+}
     + # No need to override finalize_test_output
      
       ## t/test-lib.sh ##
      @@ t/test-lib.sh: mark_option_requires_arg () {
     @@ t/test-lib.sh: mark_option_requires_arg () {
       finalize_test_output () { :; }
       
       parse_option () {
     +@@ t/test-lib.sh: test_failure_ () {
     + 	say_color error "not ok $test_count - ${pfx:+$pfx }$1"
     + 	shift
     + 	printf '%s\n' "$*" | sed -e 's/^/#	/'
     ++	if test -n "$immediate" && test -n "$invert_exit_code"
     ++	then
     ++		say_color error "1..$test_count"
     ++		finalize_test_output
     ++		_invert_exit_code_failure_end_blurb
     ++		GIT_EXIT_OK=t
     ++		exit 0
     ++	fi
     ++	# Write the annotation before the --immediate exit paths below,
     ++	# which call exit and would otherwise skip it.
     ++	finalize_test_case_output failure "$failure_label" "$@"
     + 	if test -n "$immediate"
     + 	then
     + 		say_color error "1..$test_count"
     +-		if test -n "$invert_exit_code"
     +-		then
     +-			finalize_test_output
     +-			_invert_exit_code_failure_end_blurb
     +-			GIT_EXIT_OK=t
     +-			exit 0
     +-		fi
     + 		check_test_results_san_file_ "$test_failure"
     + 		_error_exit
     + 	fi
     +-	finalize_test_case_output failure "$failure_label" "$@"
     + }
     + 
     + test_known_broken_ok_ () {
      @@ t/test-lib.sh: check_test_results_san_file_ () {
       		return
       	fi &&
 -:  ---------- > 2:  bffa8fb030 ci: point test failures and fixed known breakages at their file and line

-- 
gitgitgadget

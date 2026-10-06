Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679E390981
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269802; cv=none; b=DaxcwWt0pcwqbeoTqZa51erdaygV3NAgkHi/L30HcGr3sjIoKhdqbVLJMIJBij25l9vUSTKC4RXYYBpjOx+xLHrsmMPJNquKO7SIYAK5HX/JS8ubJDxKu2WKv89A0sbtjmtKPirOCaeuGmu64f3Bp1ETKuQpvJDnwsjW6CXjrYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269802; c=relaxed/simple;
	bh=VKFR7JpBgyemmNp0BcNX3sVCVppg4QEp6yXYHCGUUks=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jlDSPv0bihMjLLAHNZDv+CwzPjJHRENEOm29YLsQhKMC6KmZgfGPR+G4CGlXJYF6usDY92oR1Yr/FwirnUJhZhbpJTR0d0D8+pFX85U4WCpquitxlz+A8IJH+31uKBUz0PAXzggASg2yvfhsvnI+PBZBsbBHB3YqBrxb9F7SUew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY6pEToR; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY6pEToR"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-9179dd18658so5863906d6.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 23:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791269800; x=1791874600; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rrj61mX6fXG7MbSGsteCF+mCmRYrqRog3lHD6rlyLR4=;
        b=DY6pEToRM9xu7NURS/xlPi+YVPIsPiGCskB/I8lq1dPoyuErN97JbmAmAUh04WAsM9
         3AYM7kY4xW7U+QsG7FWpSuIwZJ3edld+8Lxcm+/IYDQCpDFPrvIhme2gor0QmzTgb19K
         ARXKhQd49rY/PdNL/A2w91gCwvCMdR5GBETOGGa0xVgG66wUBYPfZxzxn8pAJ58zqUsJ
         bbAUf1+YlwpVhiP1wcD/O6OQsj2YdYnqqkHfm2smfv91+0V1buPAZ0rIfYm7u7lcqauR
         aW+eVH/9XSB6x7YAoxiR18NhQ6eFc9VexW974jUbtNIDXsaxKk97jnIbilU8csYcDWgM
         6GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791269800; x=1791874600;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rrj61mX6fXG7MbSGsteCF+mCmRYrqRog3lHD6rlyLR4=;
        b=2nzjBQ4nybQqChyksVod1VJK+OEbCq2HsflS/PViF2yIAh4q1wkRR3DyYyG3Rg/Hb8
         rB9zH9onWiV4G3y9JWrk4egnd+YSGLyAkCW9566RaB706Er+6MTi85vC+ILPnnfAbPky
         MKIydtoKf21W8yDkGRxv4ocXYtK+a24TElVum/jBOikw/tBkR1cydAX1JghBklAJ5qkS
         /3+X4gHhqjH8nHxJ60CXP7rNpE0KEEtqoyP5ScHP/Ch2Dq3MZy+jpFOl0iNcO3HA9Chn
         qgqywMedXb+KpQcm279wUfdozvBeobli+p2VIw8RgemA9Tn5WrAvBsVmL+aC2a7VX7WD
         oIqg==
X-Gm-Message-State: AFuF++maAvxHwH2QKBZ9RNYLbyHnans1oKWEfw12btQiMNcZdj0zZSHF
	4zZNdoeTUaR78Iics5XmYrjs+k1GDGp/5lJiLraHA67fYvjO9cCzbP8ukHPRUw==
X-Gm-Gg: AYBFou2KcbkRv4b6/OFq954Y2mtAYrC6rAMyL2m0IwaQCaJRvuWWkSpwtfgW3rjkcag
	T89Fifnv8dehnOfL1bXS6TgZYmpDbTp9XWIyMufHjYk7Yn9Gfi7TRzH/hI5M9eqm7/y+4+cSzzg
	FFKg5r7B9QnT87+nk/zUtZCHYO7EQNqDnANax7pMObBHWFy81xiK+NP6nlRLBTDWvja18ei2xec
	hETGz4vCZ3I7TUDlUZ2OFYus6goJWY8bpXiKBLs0JwfE2NRsM3+8EPAYZ2jNLnETvVlJJTIfaiY
	HXxkN55OQnm/zKHhRi8FbdLD+gNmCmORJWrLfVtD9CMilXoDKN/u5JVFtX8KCUlYyAmxJPcCDz2
	R0dZN6gUPpOsSEI6ISs6O5efcA64H/JmZxfMa3pSKInCZsbr3nFVw/93ESfNiXe4DriqjXogJh6
	GUl+HZot5bEC5v0INmKnIPRqzdx6yH4wwgY+pf1xWE/2BrfY/j54yXdS73G6yNT8hcj7V8gS9Vl
	Q==
X-Received: by 2002:a05:620a:2625:b0:93e:5016:e3a6 with SMTP id af79cd13be357-93e8f35e939mr90791585a.26.1791269799905;
        Mon, 05 Oct 2026 23:56:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.60.104])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca297e84sm1063996885a.37.2026.10.05.23.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:56:39 -0700 (PDT)
Message-Id: <pull.2419.v6.git.git.1791269798.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Oct 2026 06:56:36 +0000
Subject: [PATCH v6 0/2] ci: link failure and leak annotations to the test script
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

V7 CI job where failures and leaks are reported:

 * https://github.com/git/git/actions/runs/37205086805?pr=2426

Changes in v7:

 * Revert the linking in annotation message, direct direct line fails when
   error pointed to an unchanged file in that PR, which regresses the
   experiences in many cases. Instead now show the file and line as plain
   text in the annotation.
 * Don't name the the line number as 1 for leaks, where it's never
   available, just omit the line number.

Changes in v6:

 * Update commit message.

Changes in v5:

 * Removed % escaping entirely, verified on CI that it isn't needed. Every
   existing test description that uses % renders correctly unescaped.
 * Rewrote the file/line commit message with a concrete example (failed:
   t1060.17 partial clone of corrupted repository).

Changes in v4:

 * Clarify commit messages and simplify escaping logic.

Changes in v3:

 * Fixed bug in the --immediate exit ordering: the --immediate &&
   --invert-exit-code path called exit 0 before the test's annotation was
   written, now a single unconditional call covers both exit paths.
 * github_escape_message_ no longer relies on \r being a portable sed escape
   sequence (not POSIX-guaranteed and BSD sed implementations can differ),
   it splices in the literal carriage-return byte via printf instead.
 * Reverted unrelated test-tool line back to its original form.

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
 t/test-lib-github-workflow-markup.sh | 39 +++++++++++++++++++++++-----
 t/test-lib.sh                        |  6 ++++-
 3 files changed, 39 insertions(+), 7 deletions(-)


base-commit: 8103b446517e0c44e67561b9d0ccce56efa60a71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2419%2FHaraldNordgren%2Fci-annotation-file-line-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2419/HaraldNordgren/ci-annotation-file-line-v6
Pull-Request: https://github.com/git/git/pull/2419

Range-diff vs v5:

 1:  851efeec8b ! 1:  917f373f91 ci: annotate leaks and stop a leak-sanitizer script at its first failure
     @@ Commit message
      
              Process completed with exit code 1.
      
     -    Give a leak its own annotation. Point it at the test script, the exact
     -    line isn't known, only which script the leak turned up in, and put the
     -    sanitizer report in a log group next to it, so it stays visible.
     +    Give a leak its own annotation, naming the script it turned up in, the
     +    exact line isn't known, only which script:
     +
     +        memory leak logged in t1060 (t1060-object-corruption.sh)
     +
     +    Put the sanitizer report in a log group next to it, so it stays
     +    visible.
      
          Once a script has one leak, it keeps running: the sanitizer log
          directory is never cleared between tests, so every later test in the
     @@ t/test-lib-github-workflow-markup.sh: start_test_output () {
       	>$github_markup_output
       	GIT_TEST_TEE_OFFSET=0
      +	github_markup_script_name=${0##*/}
     -+}
     -+
     -+github_annotation_ () {
     -+	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
       }
       
       # No need to override start_test_case_output
     @@ t/test-lib-github-workflow-markup.sh: finalize_test_case_output () {
       }
       
      +finalize_test_leak_output () {
     -+	# The exact line the leak turned up on isn't known, only the script,
     -+	# so point at line 1.
     -+	github_annotation_ error "t/$github_markup_script_name" 1 \
     -+		"memory leak logged in $this_test"
     ++	echo >>$github_markup_output \
     ++		"::error::memory leak logged in $this_test ($github_markup_script_name)"
      +
      +	echo >>$github_markup_output "::group::leak: $this_test.$test_count"
      +	cat "$TEST_RESULTS_SAN_FILE".* >>$github_markup_output
 2:  46f93a9e16 ! 2:  acf1fbd250 ci: point test failures and fixed known breakages at their file and line
     @@ Metadata
       ## Commit message ##
          ci: point test failures and fixed known breakages at their file and line
      
     -    When a test fails, GitHub shows an annotation naming it, for example:
     +    A failing test gets an annotation in the Annotations list on its job's
     +    summary page, naming it, for example:
      
              failed: t1060.17 partial clone of corrupted repository
      
     -    but the location GitHub attaches to that annotation is the CI
     -    workflow file itself, not the test script, so there is nothing
     -    pointing at where the test actually lives.
     +    with no indication of where that test lives.
      
          Find the line a test is defined on by searching its script for the
          test's own description as a fixed string, using the first match, and
     -    attach that file and line to the annotation instead. Fall back to
     -    line 1 when the description is not found verbatim, which happens when
     -    a test builds its description at runtime instead of writing it out
     -    literally.
     +    add the file and line to the annotation's own message text:
     +
     +        failed: t1060.17 partial clone of corrupted repository (t1060-object-corruption.sh:141)
     +
     +    Fall back to naming just the script, with no line, when the
     +    description is not found verbatim, which happens when a test builds
     +    its description at runtime instead of writing it out literally.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ t/test-lib-github-workflow-markup.sh: start_test_output () {
      +	head -n 1 | cut -d: -f1
      +}
      +
     - github_annotation_ () {
     - 	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
     - }
     -@@ t/test-lib-github-workflow-markup.sh: github_annotation_ () {
     + # No need to override start_test_case_output
     + 
       finalize_test_case_output () {
       	test_case_result=$1
       	shift
     @@ t/test-lib-github-workflow-markup.sh: github_annotation_ () {
      +	esac
      +
      +	test_case_line=$(find_test_case_line_ "$1")
     ++	test_case_where="$github_markup_script_name${test_case_line:+:$test_case_line}"
      +
       	case "$test_case_result" in
       	failure)
      -		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
     -+		github_annotation_ error "t/$github_markup_script_name" "${test_case_line:-1}" \
     -+			"failed: $this_test.$test_count $1"
     ++		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1 ($test_case_where)"
       		;;
       	fixed)
      -		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
     @@ t/test-lib-github-workflow-markup.sh: github_annotation_ () {
      -	ok|broken)
      -		# Exit without printing the "ok" or ""broken" tests
      -		return
     -+		github_annotation_ notice "t/$github_markup_script_name" "${test_case_line:-1}" \
     -+			"fixed: $this_test.$test_count $1"
     ++		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1 ($test_case_where)"
       		;;
       	esac
      +

-- 
gitgitgadget

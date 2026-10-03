Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7006393DF5
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791015122; cv=none; b=W8UO6dw6eivIxE1HNxMBfqykkI0WWnnKrmgtRYCL9PoZyI7an/Ohku8R3p04JM4FDp1sTHtBFtRL+BkVWHLHvDPYmc/vfQ2P1m/uUM2n6igq7BxiJdJHLTEnNU79DDBoYe5jHFsosEtN3ksF9xfXrNSxvd5YlzT+hpqdPL8zE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791015122; c=relaxed/simple;
	bh=mGoLhgv9wL/TGlA+qTN5ZFjWy6vngRAHn8lWQNhvddI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=B0vaIKI2HhHMdD0PgcsQvJgWfsAt0mSh/KpabECKCNFIdqtkydftKkiFLb+TIDVxfyOaFFFioMflt5+HkKUK1j7r6XuFlJDsz9ex83cuM8ctUikY+7P7kXfXtAQT152PtVH5HFSVQ2pzExwzyo9gYPwFJe91N+pKnlcP2704tG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frq9QcvG; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frq9QcvG"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-149241d04f5so386789c88.0
        for <git@vger.kernel.org>; Sat, 03 Oct 2026 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791015119; x=1791619919; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U0l1oPdfhfWl9XBCKu7o+mSej2NLK9gLzU6iqid+xDU=;
        b=frq9QcvGjpcoEe5L6ooj2G2+B5cZ1Nq6RV8bWTv4E0CDzhuUee/wkuc2cRnxdngXrU
         iejVrXCk50Lx5o4eyaZ9fveK8b4Bf+v19cxPNhkt9HeXAnhPtwiSSVxvtl17DzlMXeDh
         yLXJqoReYYxapIyEHZb20sImaYeBx0YBx2s6MWBhVAWMRFJHwz93l38YdXTgh9Qd2zBC
         slJjMezDCf+YLuQe7aCzj3VD4NrDIcymhN7cUepdJkO50rpvo4uIvFjeZEG9ASlPBJPC
         w5HiOott9WZor5oXxaSTdYyDRE/Z0S05G6D/4MpKmwp7X/mGZE/dV1HmTnzBUK4y0SiZ
         llvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791015119; x=1791619919;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0l1oPdfhfWl9XBCKu7o+mSej2NLK9gLzU6iqid+xDU=;
        b=bobGsBl4hbjOGZB8Rd4z+fn7F6nPxv/CSn56yQr+c6sEBcyCCNzUluxrjnzGeotFDQ
         Mmaye/PGt96POIbgSgf98dJAarEZpqVCY79kuIBYqRAD2wMgnJHx8dihUVa3UYGKfFrr
         0xus/1U4jd1YciJuOIuqIczLBhvudFDLdcIHDcswoKkwrHHUlvABSYCmtHCSPISt2BW+
         nvYhPRm59Eka2vWCek885N69+grWwJv7x2rys4ftaFQ+CPxgpEboonEAnlpgwQv41lZC
         1zpJV7fjaE64Lr2QOyodL+zk9D+Dri9CoF09d6rGVEYapUujyB6LkK3hwWdL/vs7LrWI
         ncBQ==
X-Gm-Message-State: AFuF++lCvpC8KCOwdCCEIhadLeIE4xQ+difspAvBDQ6E+L2NoQYU/zmu
	lJNMTQPDfWy0Y0cdGZKVkFzG5GQaRlwv9VUA0Ev+Di54kzVYbyagR9lVH3zfHQ==
X-Gm-Gg: AYBFou3SVwpLMAHuBLtHpbXfRnep287pYKy/hOICb4o74uU5PRWj14Bnmr+M8e8yFS1
	yY1CfYS6FfrGuA83K4k+M00lv0UmHq0vO0ad6vTll4uvRWn9ktVdF/f+CNP3TlcUKKb4H/G6fnJ
	eK1vg0yzbUYNmu04y1dkapX/v5xH5ic6PNNWw4I8/5kWxAS7AwXBugXEVBERPLamB+Vc9+ZTvw/
	ZlRiAv/lT/iM4Bws5P4JdG4MgHVSh1+oMNKlLTZo1jCoIVFwb39/039O/pNBX6J0HidKedGjBdt
	hxGTxmjOoIfrnXElk/ZOs58jbf40e+/rBM7h0thBY9gkHWte1/wiLsdZwezrucL3debqU46vW9m
	wr30SFB1f5z0UuunzYqBmnsQ9oROCYrabQ0aHmk0kNtzLBjPzUJ/zgRqHI/K6nyyWrr40rJouaW
	teomrANp3/z4LlYlbgstwe7r397mYiS9lvGH3SqPl2vS4+PpK63iLowCO5RlYuwC6U2nGxZ9ABx
	NSFdV8TPQQy7w==
X-Received: by 2002:a05:701b:2703:b0:14c:637d:682d with SMTP id a92af1059eb24-151c4356c8emr2591562c88.43.1791015119181;
        Sat, 03 Oct 2026 01:11:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.189.187.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f150248b4sm11992057eec.30.2026.10.03.01.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 01:11:58 -0700 (PDT)
Message-Id: <pull.2419.v5.git.git.1791015117.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 03 Oct 2026 08:11:55 +0000
Subject: [PATCH v5 0/2] ci: link failure and leak annotations to the test script
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

V5 CI Job where failures and leaks are reported:
https://github.com/git/git/actions/runs/36979818141/job/110752027863?pr=2426

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
 t/test-lib-github-workflow-markup.sh | 46 ++++++++++++++++++++++++----
 t/test-lib.sh                        |  6 +++-
 3 files changed, 46 insertions(+), 7 deletions(-)


base-commit: c46c1e37724f0478939de636ab8ea5a89086d532
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2419%2FHaraldNordgren%2Fci-annotation-file-line-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2419/HaraldNordgren/ci-annotation-file-line-v5
Pull-Request: https://github.com/git/git/pull/2419

Range-diff vs v4:

 1:  138394b48b = 1:  851efeec8b ci: annotate leaks and stop a leak-sanitizer script at its first failure
 2:  8ec2b53d82 ! 2:  46f93a9e16 ci: point test failures and fixed known breakages at their file and line
     @@ Metadata
       ## Commit message ##
          ci: point test failures and fixed known breakages at their file and line
      
     -    A test failure or a fixed known breakage gets an annotation that names
     -    the test but says nothing about where it's defined, so a reviewer has
     -    to search the script by hand to find it.
     +    When a test fails, GitHub shows an annotation naming it, for example:
      
     -    Find the line a test is defined on by searching the script for its
     -    description as a fixed string, using the first match. Fall back to
     +        failed: t1060.17 partial clone of corrupted repository
     +
     +    but the location GitHub attaches to that annotation is the CI
     +    workflow file itself, not the test script, so there is nothing
     +    pointing at where the test actually lives.
     +
     +    Find the line a test is defined on by searching its script for the
     +    test's own description as a fixed string, using the first match, and
     +    attach that file and line to the annotation instead. Fall back to
          line 1 when the description is not found verbatim, which happens when
          a test builds its description at runtime instead of writing it out
          literally.
      
     -    A GitHub annotation is a single line, so a `%` in a test description
     -    has to be percent-encoded as `%25`, or GitHub misreads it as its own
     -    escape sequence. for-each-ref's format atoms use plenty of them, e.g.
     -    `%(raw)`.
     -
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## t/test-lib-github-workflow-markup.sh ##
     @@ t/test-lib-github-workflow-markup.sh: start_test_output () {
       	github_markup_script_name=${0##*/}
       }
       
     -+github_escape_message_ () {
     -+	# % has to be escaped or GitHub misreads it as the start of its own
     -+	# percent-encoding (e.g. a literal %(raw) in a for-each-ref test
     -+	# description).
     -+	sed -e 's/%/%25/g'
     -+}
     -+
      +find_test_case_line_ () {
      +	# A description can contain characters like [ or * that would
      +	# corrupt a regex search, so match it literally and take the first
     @@ t/test-lib-github-workflow-markup.sh: github_annotation_ () {
      +	esac
      +
      +	test_case_line=$(find_test_case_line_ "$1")
     -+	test_case_description=$(printf '%s' "$1" | github_escape_message_)
      +
       	case "$test_case_result" in
       	failure)
      -		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
      +		github_annotation_ error "t/$github_markup_script_name" "${test_case_line:-1}" \
     -+			"failed: $this_test.$test_count $test_case_description"
     ++			"failed: $this_test.$test_count $1"
       		;;
       	fixed)
      -		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
     @@ t/test-lib-github-workflow-markup.sh: github_annotation_ () {
      -		# Exit without printing the "ok" or ""broken" tests
      -		return
      +		github_annotation_ notice "t/$github_markup_script_name" "${test_case_line:-1}" \
     -+			"fixed: $this_test.$test_count $test_case_description"
     ++			"fixed: $this_test.$test_count $1"
       		;;
       	esac
      +

-- 
gitgitgadget

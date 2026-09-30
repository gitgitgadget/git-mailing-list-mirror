Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED283B3C1A
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748587; cv=none; b=cUrAKJTMRQYDjakiMHsr6MRl+X8hhDAN4OkTjrdVcSCaBjwaJy3AaGKAZeI6HYEaaBqSWWYlZnEIQfEznpOafE7nMStzlwK2Fc7pFDl60SE3jomKDqIJdrIe28zervtXQBOVhIN6G56YglVnDr2VXc7ODzhc0S+xRQqMaiSwtFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748587; c=relaxed/simple;
	bh=okEBWDT0uuO6eeeDuprpd4XgiR5avrpnqRrYS5FwoW8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z8zms73lLwNBLBqs+Cvof0WgurrUlpok2PnVNszL7NRYJu8ptRx9sakcHmWYT6Nyw2VVMzdPmj/3Nc3HjdddKBLKO998Jv8gUHFooXOJeO6Ra026yvUo2ToIDAV0tFPuwxUjTH4IUQuD3SmGdspknjLQgH/aIVVOyNmDEa3qnvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEY5LI66; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEY5LI66"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so6427811eec.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 23:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790748585; x=1791353385; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dl0QavTPl2k9cjl720n7848b21A6PSSOOduZ9U09uBQ=;
        b=HEY5LI66rwxNRPTXwAj79oz1oncuj9rHIzViMqXoavm/bq+UubOvkk/jk8xeu4rQ2y
         aGOIUc4cfIHn7N7xSd0MOwZnBqcLyl1J5mypBxwYXYj6fSa1bMk8hBD1ZIjxPIkbKFlK
         W2lkQ4ntkgzVI5eK11G2bybgiZX0xPB/Kcghqca01DWfnKIyDSuob9+rCc5bNcO2sGsF
         I/18EvlxDXA+UPy9OYB9hs7TJlGpFqnJ9r9oSXbm8SeYpaeJfXwU+j4unyoLQSQp8xEz
         kXNvR+5AQVdaZQLElbDTOU5TzJnv0HAGdi9+OFMOc5QAQnm/9qUyPO2ejZ476NBuiZqt
         ofxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790748585; x=1791353385;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dl0QavTPl2k9cjl720n7848b21A6PSSOOduZ9U09uBQ=;
        b=soogSAkxXzaGjGNOB+cBC2OwwPRD5ApIaxi9EJ2eWnWD6vn1NTx5V4fevZ14ZcCzWA
         r2Ko7cdI1MsXD7cgnoNDHl7rOL/N6oGUXmwWWwuC5fbbR9PnzVhkwCJVkwFpc3W+aDMX
         3bWWar/KQldUaLRAUwdwBlwcOMLmlc+Vi7daJljjfEBHh71XPh45eeqORnb9XoJLAVf2
         sZP0Q96+bIyJ6bA6kghc42ZVmECCNRd3eZHIRsgNcLQrTk64oiMuKfE8l3VWw02skiwN
         b9fu2qdYTOlKnRljENys2cZfSA7pdUSBKhpPfGO6cIHo7upnzcV4KV3DzhFQuwEYqpre
         iJKA==
X-Gm-Message-State: AFq9FYLaEAqRfWXEcUOKn8PGsUm+Vmd6X4/owIoW8La4OKd0xOdORoRK
	pIBsIi3MIVZeFZMKQqGDI77+2loAsHNIltHLXREPJqHHFSVmy4ZxXFucYVuI2g==
X-Gm-Gg: AYBFou3oSBEnST1q98u4mIadvyBzMRX/VTxc8gm9y9pc+b5aHrZve7gwREIjq/pbblz
	4QMp4iu/BD/ZCXA86C0v4Js5veZhJt9t94hRcqa3NCo8CedKdOTtisQ3Wdwp97dPj3z3zymVgdu
	cAY09gx+tYn60UCmpXHpm43QrBONmXGXDP8nwu4aC1Q0fagBHoLEqa715voqdm9UbhQolkTn1cl
	dr4JuE4IYHCYnYkAvG+Umcj3UWtb+LvvNf7nbnZFUuMEFEurt0QIUoBabHc8kO41AZZEX0J6kqr
	pRCckvDIfxWyISIxtSe+8O59ZB6C1dQuT9JoQYzB97HE78T2SySqAH+xeH2Sswo+0yCvVBnYYko
	T8L/Xh6lenaNPHn/AQX6BtCwPytxMJW2JiyAzi1myP4V1AcKxhlzO4FJT+LoPuDd6y44Uf/oSlF
	VCzAFqQ3QZnzTKg2u4cvLMNzH0P1RkvLKBhypihZrx8Ogz0JAFsHSLEMGvqBajuoUm06Uad1mAD
	A==
X-Received: by 2002:a05:7301:da84:b0:34b:c18d:c28e with SMTP id 5a478bee46e88-34cdf8513cfmr643185eec.7.1790748585116;
        Tue, 29 Sep 2026 23:09:45 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.137.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5639339sm1063838eec.18.2026.09.29.23.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 23:09:44 -0700 (PDT)
Message-Id: <pull.2419.v3.git.git.1790748583.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 30 Sep 2026 06:09:41 +0000
Subject: [PATCH v3 0/2] ci: link failure and leak annotations to the test script
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

V3 CI Job where failures and leaks are reported:
https://github.com/git/git/actions/runs/36537917146/job/109306215909?pr=2426

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
 t/test-lib-github-workflow-markup.sh | 54 ++++++++++++++++++++++++----
 t/test-lib.sh                        |  6 +++-
 3 files changed, 54 insertions(+), 7 deletions(-)


base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2419%2FHaraldNordgren%2Fci-annotation-file-line-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2419/HaraldNordgren/ci-annotation-file-line-v3
Pull-Request: https://github.com/git/git/pull/2419

Range-diff vs v2:

 1:  46e13a6e77 ! 1:  b6a36820ae ci: annotate leaks and stop a leak-sanitizer script at its first failure
     @@ t/test-lib.sh: test_failure_ () {
       	say_color error "not ok $test_count - ${pfx:+$pfx }$1"
       	shift
       	printf '%s\n' "$*" | sed -e 's/^/#	/'
     -+	if test -n "$immediate" && test -n "$invert_exit_code"
     -+	then
     -+		say_color error "1..$test_count"
     -+		finalize_test_output
     -+		_invert_exit_code_failure_end_blurb
     -+		GIT_EXIT_OK=t
     -+		exit 0
     -+	fi
     -+	# Write the annotation before the --immediate exit paths below,
     -+	# which call exit and would otherwise skip it.
     ++	# Write the annotation before either --immediate exit path below,
     ++	# both of which call exit and would otherwise skip it.
      +	finalize_test_case_output failure "$failure_label" "$@"
       	if test -n "$immediate"
       	then
       		say_color error "1..$test_count"
     --		if test -n "$invert_exit_code"
     --		then
     --			finalize_test_output
     --			_invert_exit_code_failure_end_blurb
     --			GIT_EXIT_OK=t
     --			exit 0
     --		fi
     +@@ t/test-lib.sh: test_failure_ () {
       		check_test_results_san_file_ "$test_failure"
       		_error_exit
       	fi
 2:  bffa8fb030 ! 2:  750c360512 ci: point test failures and fixed known breakages at their file and line
     @@ t/test-lib-github-workflow-markup.sh: start_test_output () {
      +github_escape_message_ () {
      +	# A test description is always one line, so only % and CR need
      +	# escaping here. Escape % first, or CR's own %-encoding gets mangled.
     -+	sed -e 's/%/%25/g' -e 's/\r/%0D/g'
     ++	# \r is not a portable sed escape, so splice in the actual byte.
     ++	sed -e 's/%/%25/g' -e "s/$(printf '\r')/%0D/g"
      +}
      +
      +find_test_case_line_ () {
     @@ t/test-lib-github-workflow-markup.sh: github_annotation_ () {
       	esac
      +
       	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
     --	test-tool >>$github_markup_output path-utils skip-n-bytes \
     --		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
     -+	test-tool path-utils skip-n-bytes \
     -+		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET >>$github_markup_output
     - 	echo >>$github_markup_output "::endgroup::"
     - }
     - 
     + 	test-tool >>$github_markup_output path-utils skip-n-bytes \
     + 		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET

-- 
gitgitgadget

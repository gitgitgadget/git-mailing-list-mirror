Received: from mail-dy2-f40.google.com (mail-dy2-f40.google.com [74.125.229.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07373EA968
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880263; cv=none; b=Evo264zEYKU/lcq/1+luqu3KrmLJ7wUlfk718z4D4vMp2aH7q/RV3GkRMwaAMRBADKOI/UTMTRAZgWjcNWo/t8VEJ/ceqAkr7npARZp63hJHCBdqAcy0K97vm7zLrvOfzk5GowyDpOzi/KlwRnc/l3s0SWy3wJ2hUAQ6lwfk9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880263; c=relaxed/simple;
	bh=ddE/E7HZmtpYadX+CPi+AD2hL3RlBCQoOo0ixscY/7c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uEI+R+6hTab9qGRdyUhyg0kOrv2UvaQDNW8d7DqZaIFpZejJA4gDuszlEftFbluXZJldLwaeRxi5Kv2gw99xWlqjGhe7bZrep4XHQ64UF1Svey1NAlaHMriWX/NTeH3Eo4J/1WYclSteUxpydIwK0VK+C2uE0LB9OTKuB32CpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aScoqkc/; arc=none smtp.client-ip=74.125.229.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aScoqkc/"
Received: by mail-dy2-f40.google.com with SMTP id 5a478bee46e88-34ea9118159so789349eec.3
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790880257; x=1791485057; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b6o2hVYvY8+eUllgqEJelU6E8FG9NdmKGm4/413ugZM=;
        b=aScoqkc/2Tx89u2dVp5t7uluIJaKcvuzajCT60CwUIhKRLmMw0lV6x0SpJcFmod9s7
         zjFUqwAeHWoEBhfOT2wVgetS2m3Hu/oQH8zTNAC59QmAMSk3tVW+lKpahrfiryXynmYd
         24ZDmh0KVqJoidZJMkqonZZj3LY9ADItE5VYc93//xqMuRvvqqLMfsDlGJ66/+N89LWx
         q0W5hqDDySjOXeQvjiYhalaUMphLnqLFONnYBMkvl0ayo01OuprrHiSpDBM2u+GrOkfd
         oMHE/QleqpjwXTAOLcBdVouB4yDClez+Od3FLienvi1qOayk+8QF23e4ntduvQQ58FKi
         ychw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790880257; x=1791485057;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6o2hVYvY8+eUllgqEJelU6E8FG9NdmKGm4/413ugZM=;
        b=vjTsKLT/rVXTq1MjEQTHAQpueYJkSq032/1Vha0C8BNv9AQGp1MzjitacJBVlGv8jK
         sT3IwVc4NNwxVSq8EWNOyRS3oYYJmeMT5I96DhI7FX4oNNtzFOAFMDY7ZzjHLLQJID3I
         1RpoxTxdjz8IZ3gzRK7NZahpNQQLPWKv7Bg3n9DyUypb9rbtSwj3UvA5HA63WDP8sfqV
         rSjt11UOvR8FoK+nGkAMd+xAgQotBcvSuDoQLpCMAivL/rwL8lW4HNnjj+DStyNqH67P
         uLlxGvHOkXa4RyqjuG/Lr5lEi0rxgPQZpBd7WWV2/qmhhr6gvnqyItKsLwIeL24+4IFc
         SBoQ==
X-Gm-Message-State: AFuF++mNFM0ZE5YolRXJd6QqYlIFYIy6vYoTCQwhuY4bcSR+Y+JHp0Da
	B+TYdQLrc58auQFcNbTuDhf/xtKtLWhUpbVSlNr9qIJGcl+5SVKm4dpYdRc+Yw==
X-Gm-Gg: AYBFou2N75YBZaukLfjCKHxJLU54M3Cz6Kco3e10g/MSVDBj6lQgKozH2yd1/acNX+f
	ewCBlTXIIyWzu7JHD1MdROYFCtHG2zkdaUjlneZxJrm1QbjyTwxVedqVhFkXf+OkKRxSdH1Mlud
	NV9u7g8d3Xq5TlhL5SkbvkeseZWP76/L3sSzeoNRa82kKYUXzP8Gt35kTlsON9aS7XwTTCD6RH9
	qsguDeb3ANiA5RR6GlBF4yEFHIKZ20p0rqsOblYEy1mQmi3CeXLn2GAnVd1SEGmtvXvf97KLPdW
	PxJOPVCI+mAWSucbB7mocOeEFTfJV0pO0bwja3obe1MvX1+18EyOFUFJZGFuHmdv5VJaZEXrXs5
	0Of8XFfqsaQLlzYI+KGwQDrnShnQOL928uCeiixHbhOXvWrFR5ZhG5U2bF7hFHwUfa3/DuWBCO6
	STDVtBYmIbBRQS9ms9esEKVmN6oYMksOfq96xPBrvZi84uqNTXStkJv6Oi9hOQ7YfuTSJV/bh5I
	+Y=
X-Received: by 2002:a05:701b:2503:b0:148:8aa2:91cb with SMTP id a92af1059eb24-14f5c0f713emr21411c88.30.1790880257164;
        Thu, 01 Oct 2026 11:44:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.247.10])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f4756bea5sm317419c88.13.2026.10.01.11.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:44:16 -0700 (PDT)
Message-Id: <pull.2419.v4.git.git.1790880255.gitgitgadget@gmail.com>
In-Reply-To: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Oct 2026 18:44:13 +0000
Subject: [PATCH v4 0/2] ci: link failure and leak annotations to the test script
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

V4 CI Job where failures and leaks are reported:
https://github.com/git/git/actions/runs/36760014277/job/110039964565?pr=2426

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
 t/test-lib-github-workflow-markup.sh | 54 ++++++++++++++++++++++++----
 t/test-lib.sh                        |  6 +++-
 3 files changed, 54 insertions(+), 7 deletions(-)


base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2419%2FHaraldNordgren%2Fci-annotation-file-line-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2419/HaraldNordgren/ci-annotation-file-line-v4
Pull-Request: https://github.com/git/git/pull/2419

Range-diff vs v3:

 1:  b6a36820ae ! 1:  138394b48b ci: annotate leaks and stop a leak-sanitizer script at its first failure
     @@ Commit message
      
          Give a leak its own annotation. Point it at the test script, the exact
          line isn't known, only which script the leak turned up in, and put the
     -    full sanitizer report in a log group next to it, so it stays visible
     -    and isn't capped to a handful of lines.
     +    sanitizer report in a log group next to it, so it stays visible.
      
          Once a script has one leak, it keeps running: the sanitizer log
          directory is never cleared between tests, so every later test in the
 2:  750c360512 ! 2:  8ec2b53d82 ci: point test failures and fixed known breakages at their file and line
     @@ Commit message
          ci: point test failures and fixed known breakages at their file and line
      
          A test failure or a fixed known breakage gets an annotation that names
     -    the test but carries no file or line, so there is nothing to click
     -    through to from the GitHub UI.
     +    the test but says nothing about where it's defined, so a reviewer has
     +    to search the script by hand to find it.
      
          Find the line a test is defined on by searching the script for its
     -    description as a fixed string, using the first match. A description
     -    can contain characters like `[` or `*` that a regex search would
     -    misread, so match it literally. Fall back to line 1 when the
     -    description is not found verbatim, which happens when a test builds
     -    its description at runtime instead of writing it out literally.
     +    description as a fixed string, using the first match. Fall back to
     +    line 1 when the description is not found verbatim, which happens when
     +    a test builds its description at runtime instead of writing it out
     +    literally.
      
     -    A GitHub annotation is a single line, and a test description is always
     -    one line too, so only a `%` or a stray carriage return in it needs
     -    percent-encoding to keep the annotation intact. Escape `%` first, or a
     -    carriage return's own encoding would be mangled by a `%` substitution
     -    that ran after it.
     +    A GitHub annotation is a single line, so a `%` in a test description
     +    has to be percent-encoded as `%25`, or GitHub misreads it as its own
     +    escape sequence. for-each-ref's format atoms use plenty of them, e.g.
     +    `%(raw)`.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ t/test-lib-github-workflow-markup.sh: start_test_output () {
       }
       
      +github_escape_message_ () {
     -+	# A test description is always one line, so only % and CR need
     -+	# escaping here. Escape % first, or CR's own %-encoding gets mangled.
     -+	# \r is not a portable sed escape, so splice in the actual byte.
     -+	sed -e 's/%/%25/g' -e "s/$(printf '\r')/%0D/g"
     ++	# % has to be escaped or GitHub misreads it as the start of its own
     ++	# percent-encoding (e.g. a literal %(raw) in a for-each-ref test
     ++	# description).
     ++	sed -e 's/%/%25/g'
      +}
      +
      +find_test_case_line_ () {
      +	# A description can contain characters like [ or * that would
      +	# corrupt a regex search, so match it literally and take the first
     -+	# hit; -- keeps a description starting with "-" from being read as
     -+	# an option.
     ++	# hit. The -- keeps a description starting with "-" from being read
     ++	# as an option.
      +	grep -n -F -- "$1" "$TEST_DIRECTORY/$github_markup_script_name" |
      +	head -n 1 | cut -d: -f1
      +}

-- 
gitgitgadget

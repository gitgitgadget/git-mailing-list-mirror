Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14B03002AB
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786066724; cv=none; b=SOzqkQ5nUOEwsNMYo0VbTlc3RAWDLPBmXhjx0q2P0qnBjzcHqbL65H4WX2Oyy1jHJ9taA0x1XUjuoslViP0e8dT57r+xD0valfZVKsYXM4k61r+pKJEbw3lOnt88CIpoZKKwYRkM86NAZuArVPOb7H6wRydviwpUxCmKq2b4/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786066724; c=relaxed/simple;
	bh=OwuT6Dznn0RG4xAlbI18gh5/DtnBYMUAMiUJN8i2aJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhA2jE8S6ahxdbHm2CRO+xIp4dtds3yoA5lYSWSozRs3ngPCPip6eG0NSyY8duZ5clKde1LrmqXl6VEKQKgGa1JoX1KeSoRgQWAl+HEdvPshSOAW1iQ4yEKU6kmvRftwkzdhTEzISM6vb578LIcLaolvB69nNqDTWaZhEDpoYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c8xcpBkg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTtPCRJ0; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c8xcpBkg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTtPCRJ0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0CFC91D000B3;
	Thu,  6 Aug 2026 21:38:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 21:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786066711; x=
	1786153111; bh=7XZC9Odc8cAxn8eMvGeLmZRmQMNcd4RRUnoqS0cv2aE=; b=c
	8xcpBkgKlHdDbsrCnlmVEJThfzdWRJo9BVLO7MKvNpx/rW42wa6+V4AM8DLt3Zld
	cXBW2f08uTabkG1RkOS7k+iDrfAWIaLu1gb8LZWi8EKZ2umyeeSpYhpLIZWJs+Ja
	NPmzmVoi2RXRH3RLfM5i394q8zgTQH6VRFMIldtM9LUUfViyPpqkpAhX0KZExNWN
	mghYcB8Ps9cxRUKw/sR9XM9t+VR1l7geO9ARO5ymBvbROvSXwArCNQSApQ3HVdpF
	PTN+PNmtWQWbYIl1N3uQUJwfj4RXhwyP5MZKpSn+D0QDeb4xiEu6J4VVRee9bfCW
	PkmwIqFhPE/3ysohYse5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786066711; x=1786153111; bh=7
	XZC9Odc8cAxn8eMvGeLmZRmQMNcd4RRUnoqS0cv2aE=; b=jTtPCRJ0Yt/5h7Q94
	bDaB5q7X+wnxJfK5NFGehHHq6I4KKAkuoIdSpE0k+jtvKmFGJgbu5Q1w8VcXsvlT
	Bpd26fji09COrdRlvZGPmQADuJda5ytK1LzatXx0evDR9i8uQQT92362w1FaB/lU
	YIXjY92/+/w5y4l1KkY/5xNCFkAesARiExSAavk2bSe06Yztz4NK+hb44wEhndF1
	cr2EyC0q4/rGLgElZ89poTR6TpPb5a7n+0xp7e0I843GniejSnVbs2CECHhuO/mv
	8isn4tFI+7H5W7S/JSRZ5okQXrvp/5N31BklGeGIMBRhLanPGUMT2ZMBL8aV3Vsr
	9NETQ==
X-ME-Sender: <xms:Fzd1at1AnjWxj9h9BANsAhmt1R8DjbU_-jOa00V5ocpPSos_XWUl-w>
    <xme:Fzd1amoMGKe0dBlqOyQZuEww0Ebk1NTzR4lnG6h4-ZIM70IPVojHEDRUrxfGBMKyU
    1rwMkCMDB1o35kOMAJn9vvxZph6hpG1mI2VV_VYhGsk0YGp66CPig>
X-ME-Received: <xmr:Fzd1ahhaOqUXVIBRSUS_ncYCLzIhI9yhuDv9VSuKFaAlE4QSjNrwq4qDoNuVbtX1Juf1sCQWd1DnAWEhrt2NHDSsrbKO5JFk_A>
X-ME-Proxy-Cause: dmFkZTFq7MzKWLxG+4X43Fk1A+9+V44cVi14HmRnlZI3MPpq0IXmpruKrxVv3EBIxIBKPP
    jGWkcZ1SfvzfgAZqhyYXPJhiexxo4v20CG8uf5ATK5plYBugOG7rVR9zbDzeeQ06XeAZ3c
    2xIJvlyaLhvEmLOoJVwNI1e9Eih3SPcNk+clOEydmVRIe09dtZs3cRi6WsO8rRs0leHQJh
    h0CD+jxxGRxSHYDfyAe4OoJPtMxecAcr0vz2jF5EWiuoyarsJe9bl9xfK7cGU+kvOkJLQr
    2xQfrEoMlwoHhIGtRjiKLNC9/olDxKb9Ai3/ZlxO1afrgzsIfdkKaWB2MkyVyhPZ0EiXVB
    14oXBTqdjM5kb8oW38PohcsDyoVlMErzQ+KCQmIVlwyZSwAj4i0ZPxhmwjBJFIomf8ezST
    yQfx8fp8hOtqMpoODxbUHxzEWdFHiiAfhm+uI7M5sHBBHSEWDQbwRdLaU8ThnKN7dbcuc4
    DkYps7QwScfhgfO9oMPrE71tMnwWrJrpGgXMooaVdg2E/k177rB/YIOsbJ5UpESdzzYlpg
    c1qubG8zICi7c7Caz3XR3y338eV+SFtyqSZUEAJCTX2YgLa81UY67I+58FYd9u8+FHARt3
    zm/V624g+uH1wqX1PJNjzyfE/HIlCjNk1FZfTU2IdWUCmM8idkvfcqVyHWWA
X-ME-Proxy: <xmx:Fzd1aq-hdrKGcojy2nOwB8AVtDTx_kgVWCmbU5ATfLj4MAuP9IzgjQ>
    <xmx:Fzd1alVBmuJRgVPAtE5nUtgJA77ZSSZN0MBordL23JtoyT-Tdos4qA>
    <xmx:Fzd1amDlXRSfjD5s4bjDw_01IfMvtOCwfsg_KqGERvDZ4HfpKumidw>
    <xmx:Fzd1aiHmlYVf3hPfAd5Qp1IlgEfzD445kQQkjZ1jk_W4x-sHWkeLEg>
    <xmx:Fzd1aiwRt-LCafs0DTvOm3zrzKeqRu6kCisuYqIpkEv0_-Ie5WLX8UbI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 21:38:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
	Britton Leo Kerin <britton.kerin@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 0/3] completion of 'git [-C <dir>] diff'
Date: Thu,  6 Aug 2026 18:38:27 -0700
Message-ID: <20260807013830.698340-1-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-655-g8b87133eb9
In-Reply-To: <xmqqcxw010me.fsf@gitster.g>
References: <xmqqcxw010me.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary motivation for this topic is that the command-line
completion of 'git diff' does not handle paths (unlike 'git status'
and 'git add') and instead relies on the default behavior of Bash
command-line completion, which completes files in $PWD; this does
not work at all with the '-C <directory>' option.

This series teaches the completion machinery to complete revisions
(unless '--' exists), then tracked paths, and then untracked paths,
before letting the Bash default kick in.  This way, we correctly
complete 'git diff' command line even when '-C <directory>' is in
effect.

The tests are the only changes relative to v2.  In the step where
tracked paths are completed, v2 did not demonstrate that untracked
ones are *not* completed at the same time.  Now we do by having
untracked 'file3' next to 'file1' and 'file2' that are tracked.  In
the last step, we demonstrate untracked paths that do not share
prefix with refs or tracked paths are completed, with or without the
"-C <dir>" option.

 1/3: completion: no-op refactoring of diff completion
 2/3: completion: complete tracked paths for 'git diff'
 3/3: completion: 'git diff' completes untracked paths as a last
        resort

 contrib/completion/git-completion.bash | 69 +++++++++++++++-----------
 t/t9902-completion.sh                  | 49 ++++++++++++++++++
 2 files changed, 90 insertions(+), 28 deletions(-)

Range-diff against v3:
1:  d3c51c042c = 1:  3b99b45fee completion: no-op refactoring of diff completion
2:  c3658d6ca2 ! 2:  bcc24b6bda completion: complete tracked paths for 'git diff'
    @@ contrib/completion/git-completion.bash: _git_diff ()
      __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
     
      ## t/t9902-completion.sh ##
    +@@ t/t9902-completion.sh: test_expect_success 'setup for integration tests' '
    + 	echo content >file1 &&
    + 	echo more >file2 &&
    + 	git add file1 file2 &&
    ++	echo untracked >file3 &&
    + 	git commit -m one &&
    + 	git branch mybranch &&
    + 	git tag mytag
     @@ t/t9902-completion.sh: test_expect_success 'git -C <path> checkout uses the right repo' '
      	EOF
      '
      
     +test_expect_success 'git diff completes tracked paths when no refs match' '
     +	# file1 and file2 are tracked but file3 is not
    -+	test_completion "git diff f" <<-\EOF
    ++	# there is no ref that begins with f
    ++	test_completion "git diff f" <<-\EOF &&
     +	file1
     +	file2
     +	EOF
    -+'
    -+
    -+test_expect_success 'git diff -- completes tracked paths' '
    -+	# file1 and file2 are tracked but file3 is not
     +	test_completion "git diff -- f" <<-\EOF
     +	file1
     +	file2
     +	EOF
     +'
     +
    -+test_expect_success 'git -C <path> diff completes tracked paths in specified repo' '
    ++test_expect_success 'git -C <path> diff completes in the specified repo' '
     +	test_when_finished "rm -rf repo-for-diff" &&
     +	git init repo-for-diff &&
    ++
    ++	# otherfile is tracked, oops is untracked
     +	echo content >repo-for-diff/otherfile &&
     +	git -C repo-for-diff add otherfile &&
    -+	echo untracked >repo-for-diff/oops &&
     +	git -C repo-for-diff commit -m otherfile &&
    -+	test_completion "git -C repo-for-diff diff o" <<-\EOF
    ++	echo untracked >repo-for-diff/oops &&
    ++	test_completion "git -C repo-for-diff diff o" <<-\EOF &&
     +	otherfile
     +	EOF
    -+'
    -+
    -+test_expect_success 'git -C <path> diff -- completes pathspecs in specified repo' '
    -+	test_when_finished "rm -rf repo-for-diff" &&
    -+	git init repo-for-diff &&
    -+	echo content >repo-for-diff/otherfile &&
    -+	git -C repo-for-diff add otherfile &&
    -+	git -C repo-for-diff commit -m otherfile &&
     +	test_completion "git -C repo-for-diff diff -- o" <<-\EOF
     +	otherfile
     +	EOF
3:  ba5dc6f164 ! 3:  34720a30ab completion: 'git diff' completes untracked paths as a last resort
    @@ contrib/completion/git-completion.bash: _git_diff ()
     
      ## t/t9902-completion.sh ##
     @@ t/t9902-completion.sh: test_expect_success 'setup for integration tests' '
    - 	echo content >file1 &&
      	echo more >file2 &&
      	git add file1 file2 &&
    + 	echo untracked >file3 &&
     +	echo untracked >ufile &&
      	git commit -m one &&
      	git branch mybranch &&
      	git tag mytag
    -@@ t/t9902-completion.sh: test_expect_success 'git diff -- completes tracked paths' '
    +@@ t/t9902-completion.sh: test_expect_success 'git diff completes tracked paths when no refs match' '
      	EOF
      '
      
     +test_expect_success 'git diff [--] completes untracked paths, too' '
    ++	# there is no ref or tracked path that begin with u
     +	test_completion "git diff u" <<-\EOF &&
     +	ufile
     +	EOF
    @@ t/t9902-completion.sh: test_expect_success 'git diff -- completes tracked paths'
     +	EOF
     +'
     +
    - test_expect_success 'git -C <path> diff completes tracked paths in specified repo' '
    - 	test_when_finished "rm -rf repo-for-diff" &&
    - 	git init repo-for-diff &&
    -@@ t/t9902-completion.sh: test_expect_success 'git -C <path> diff -- completes pathspecs in specified repo
    + test_expect_success 'git -C <path> diff completes in the specified repo' '
      	test_when_finished "rm -rf repo-for-diff" &&
      	git init repo-for-diff &&
    + 
    +-	# otherfile is tracked, oops is untracked
    ++	# otherfile is tracked, oops and ufile are untracked
      	echo content >repo-for-diff/otherfile &&
    -+	echo untracked >repo-for-diff/untracked &&
      	git -C repo-for-diff add otherfile &&
      	git -C repo-for-diff commit -m otherfile &&
    + 	echo untracked >repo-for-diff/oops &&
    ++	echo untracked >repo-for-diff/ufile &&
    + 	test_completion "git -C repo-for-diff diff o" <<-\EOF &&
    + 	otherfile
    + 	EOF
     -	test_completion "git -C repo-for-diff diff -- o" <<-\EOF
    -+	test_completion "git -C repo-for-diff diff o" <<-\EOF &&
    -+	otherfile
    -+	EOF
     +	test_completion "git -C repo-for-diff diff -- o" <<-\EOF &&
      	otherfile
      	EOF
     +	test_completion "git -C repo-for-diff diff u" <<-\EOF &&
    -+	untracked
    ++	ufile
     +	EOF
     +	test_completion "git -C repo-for-diff diff -- u" <<-\EOF
    -+	untracked
    ++	ufile
     +	EOF
      '
      
-- 
2.55.0-655-gb2c071042d


Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC5513AD38
	for <git@vger.kernel.org>; Tue, 27 May 2025 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375226; cv=none; b=Li1bv0JNE+Vvtrj+G1CSAHVXaTjihKeMxDANvB0OHi585QiJZQ0AhHs0ow1ktSY3EEAiWrXfnNlrxL96MH+S3bznoqoghmfDZv4C78P0VVbhFfsqQD5RHabMojEs2H9JbtDj9GSdAeRgA9OMdBVrZiLBMuXhf4wZDFj18cpsuR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375226; c=relaxed/simple;
	bh=t5Vl8hYJBha4mlmzPQkOyKLxkO/Ri0/HYyzbdeLgE1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qLbbeyr5Nq2sw3VOvHeNZUo0EOePfQrQzTkCr4Nbk4nQRGapEvAvQpWE+AcNWf8GpwW62UKz0b3tbj1awkggHV3iiOmNJhZByzIkhK4o11d6KUJ/xJHB4jESukBIYq1JLjTi2XhxkWmrhmkD60vKkZxY4L0pKzptKlualKmp/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M8c6C/oq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BX0FAG1P; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M8c6C/oq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BX0FAG1P"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8980F1140152;
	Tue, 27 May 2025 15:47:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 27 May 2025 15:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748375223; x=1748461623; bh=XCxCArr2zM
	BoskIjYKhqgGwKni2wsLTXpF3hFwgDz14=; b=M8c6C/oqNX4RnEnF9zGsOvzlEI
	lM+t/QNO1/7YvMY/KkHrqPnzRnQ/RvJs41vHEw9Ant3NvW5QOAz/pOmco+g3WyKT
	abViTcYY2ZD9NUzw9WRyR1ZADgXu/B11xlQe0K0LIMISK2OrLb3/M2GzUl2LIs2n
	Ctv93eUvhvwwzXgTvP6HHpxsNQQW3dWAzvi5s3vJqW0CljIz4+slt8oVQf5ulNXM
	Z5jRp3vXnPeA5LcCVhF8/a89RAamn73DRBaCCk18InCqrOjsT18Ua1K5cMP/8yNP
	e9MntYVdfnzjXrY/NBlRV9H/0LYJDzPW2CfsCfmKCEDeYcbSUo3GxfLrZtjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748375223; x=1748461623; bh=XCxCArr2zMBoskIjYKhqgGwKni2wsLTXpF3
	hFwgDz14=; b=BX0FAG1PrtomUHHRxzfV9UDU52n7s0bTD8xx0Wn/XFd4dt3XQQ+
	UznD/yHby7nZXu0vlSmp1+961xYUbksl+3Acy0apq21RjVYTYATNuX9DP7OoDeNJ
	ATO5oAbLJ81VVCFGIselkGVD1TeCBJ1b/1Iue9xBw8yMWjEeAP0Of5QuviW7GzOI
	k5xf3hvNkFxLSggud3aky/JRDpQfehs+Pc0N3rzA0G3PMDr6KzxRP4nAb8KRBQsw
	k3ZEbWGh8SFH9++IsyK3z8JQuyMcGf8JQHba9fHUYqg8l1N+HLSFCWCzD5601GmF
	LkkG++pRTePiiBWXjydZ16x5eID7ONj2yoA==
X-ME-Sender: <xms:thY2aIeQEQ2m1J-M-hggtyTmXA0ikiyHHYIsZYZ56irrsaz-WJIFgQ>
    <xme:thY2aKPvve48ALFZXCyk-YEBQTaJadyJzbXt3qYA3Cv8NODoOtqDd6u0qGhTZgDpm
    rh5lQjB_jG7Heru6w>
X-ME-Received: <xmr:thY2aJjSz4c-Kp8IGSxg4xaOzUkFnqUjqJ24DmotRM-FPaDTVlCbciyjlPUjGRcSNNStpZEs4m3pSjhLnnn0Vh3VMIgoSg-sibFZ4Ds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvuddvieculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtg
    hpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepthhm
    iiesphhosghogidrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:thY2aN-mtMP_v7swKUnr0IWWRnCrJbx6Li8dn6PQnHS7U6_8sJWz2g>
    <xmx:thY2aEsrrxW8WCDggyE-zXIXtzGsoM2uGGAOVXteJxDDjf_b7mP_ww>
    <xmx:thY2aEFthRBgMt9QdSxbctQvJK0IGwrW5r2oTqKd4jWjocp6udTe4A>
    <xmx:thY2aDN8gXFfgGn5KiTfACe_jVvrwO0pYg4InIucXq6WCgG65OvpwA>
    <xmx:txY2aNnZdWG6OhjW7s2TMrE-ufhounHyaJPVDfS10ARawwua38zKHjt_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 15:47:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Karthik
 Nayak <karthik.188@gmail.com>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Todd
 Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 2/6] t/test-lib: don't print shell traces to stdout
In-Reply-To: <20250527-pks-meson-tap-v2-2-ae360f77786e@pks.im> (Patrick
	Steinhardt's message of "Tue, 27 May 2025 16:02:50 +0200")
References: <20250527-pks-meson-tap-v2-0-ae360f77786e@pks.im>
	<20250527-pks-meson-tap-v2-2-ae360f77786e@pks.im>
Date: Tue, 27 May 2025 12:47:00 -0700
Message-ID: <xmqqh615vnt7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We have several flags like "--verbose", "--verbose-only" or "-x" that
> cause us to generate shell traces. The generated tracing output is split
> up in these cases so that the test's stdout is printed to file
> descriptor 3 whereas its stderr is printed to file descriptor 4.
> Depending on which options have been given, we then end up either:
>
>   - Redirecting both file descriptors to a file.
>
>   - Redirecting them to stdout and stderr, respectively.
>
>   - Closing them in case we're running in none-verbose mode.
>
> The second case causes problems though when passing output to a TAP
> parser. We print the test's stdout to the console's stdout, and that
> results in broken TAP output.
>
> Fix the issue by instead redirecting the test's stdout to the shell's
> stderr. This makes it impossible to discern stdout from stderr, but
> going by my own experience I never came across a usecase where I would
> have needed this distinction.

OK, so both stdout and stderr go to stderr, mixing everything into a
single stream.  Do we need to worry about funny buffering making the
test output harder to verify?  I mean, we only have to care about
the ordering of lines within the original standard output (or
standard error) stream independently, but now if the test thinks it
wrote A to its stderr, then B to its stdout, and then C to its
stderr, would we get them in the single output stream as A followed
by B followed by C, or can sometimes buffered output can give us A
then C then finally B?

Just an idle thought.  What makes me more confused is that the
updated t0000 tests seem to say that we now check standard output
and standard error separately.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0000-basic.sh | 35 +++++++++++++++++++----------------
>  t/test-lib.sh    |  4 ++--
>  2 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 35c5c2b4f9b..16b785f3b91 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -219,41 +219,44 @@ test_expect_success 'subtest: --verbose option' '
>  	test_expect_success "failing test" false
>  	test_done
>  	EOF
> -	mv t1234-verbose/out t1234-verbose/out+ &&
> -	grep -v "^Initialized empty" t1234-verbose/out+ >t1234-verbose/out &&
> -	check_sub_test_lib_test t1234-verbose <<-\EOF
> -	> expecting success of 1234.1 '\''passing test'\'': true
> +	mv t1234-verbose/err t1234-verbose/err+ &&
> +	grep -v "^Initialized empty" t1234-verbose/err+ >t1234-verbose/err &&
> +	check_sub_test_lib_test_err t1234-verbose \
> +		<<-\EOF_OUT 3<<-\EOF_ERR
>  	> ok 1 - passing test
> +	> ok 2 - test with output
> +	> not ok 3 - failing test
> +	> #	false
> +	> # failed 1 among 3 test(s)
> +	> 1..3
> +	EOF_OUT
> +	> expecting success of 1234.1 '\''passing test'\'': true
>  	> Z
>  	> expecting success of 1234.2 '\''test with output'\'': echo foo
>  	> foo
> -	> ok 2 - test with output
>  	> Z
>  	> expecting success of 1234.3 '\''failing test'\'': false
> -	> not ok 3 - failing test
> -	> #	false
>  	> Z
> -	> # failed 1 among 3 test(s)
> -	> 1..3
> -	EOF
> +	EOF_ERR
>  '
>  
>  test_expect_success 'subtest: --verbose-only option' '
>  	run_sub_test_lib_test_err \
>  		t1234-verbose \
>  		--verbose-only=2 &&
> -	check_sub_test_lib_test t1234-verbose <<-\EOF
> +	check_sub_test_lib_test_err t1234-verbose <<-\EOF_OUT 3<<-\EOF_ERR
>  	> ok 1 - passing test
> -	> Z
> -	> expecting success of 1234.2 '\''test with output'\'': echo foo
> -	> foo
>  	> ok 2 - test with output
> -	> Z
>  	> not ok 3 - failing test
>  	> #	false
>  	> # failed 1 among 3 test(s)
>  	> 1..3
> -	EOF
> +	EOF_OUT
> +	> Z
> +	> expecting success of 1234.2 '\''test with output'\'': echo foo
> +	> foo
> +	> Z
> +	EOF_ERR
>  '
>  
>  test_expect_success 'subtest: skip one with GIT_SKIP_TESTS' '
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index af722d383d9..6ce8570226c 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -707,7 +707,7 @@ then
>  	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
>  elif test "$verbose" = "t"
>  then
> -	exec 4>&2 3>&1
> +	exec 4>&2 3>&2
>  else
>  	exec 4>/dev/null 3>/dev/null
>  fi
> @@ -949,7 +949,7 @@ maybe_setup_verbose () {
>  	test -z "$verbose_only" && return
>  	if match_pattern_list $test_count "$verbose_only"
>  	then
> -		exec 4>&2 3>&1
> +		exec 4>&2 3>&2
>  		# Emit a delimiting blank line when going from
>  		# non-verbose to verbose.  Within verbose mode the
>  		# delimiter is printed by test_expect_*.  The choice

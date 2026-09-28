Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348014F70
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628418; cv=none; b=i9SXAOUnxLYgnKAV3i4MJEcNLNnIkdycIbyd0gWiR9eFNo17QwT0pW7YydvQQzniqeuswRKU7lBz2NJOCSGgs82z4JFcO8OBYdZUZH97IBTo2jQFRfw/xmZcN8/OnPUfSOujDoWaDJE/AdwFPmij2hTpPh0bnZOWvrcwf4PVBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628418; c=relaxed/simple;
	bh=kwydsidGTnaP94vgFP/lsj141vkcaHcjmgLrJ12xS54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPWodKJkv+GkA6PULc+zRAXB334l+vqBvF55bP7b7OAox5lESkm5ey/pFLtzjNz/vEdMaVB12dW/onIWpqia4mTFU3lDbluPPor5wh4SsEpaN8EvjWt6h2zpQRyaGEG39SPgAV3IgmIF+BiXuHixIw3a5jnZeIH0DMrqRSUZ0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T5/3o+b0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KIvY30sQ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T5/3o+b0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KIvY30sQ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 763321D00019;
	Mon, 28 Sep 2026 16:46:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 28 Sep 2026 16:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790628415; x=1790714815; bh=KrQUNC7sxr
	KrzZPTHB5tvlnzLulbbb5S8WkeAz/ektw=; b=T5/3o+b0WFeWiEOiS5SnSWmWuu
	Ob1vn31VdxEO+EANleMmJQ/ttE2mZ9MV+/KOBPVVmy94tOX8RBSPskLYvah9T/BP
	LvKdOftmdswRUdpjZDQ4SKHF4PLTNc8dKTlQ3MNnIf+LuoAhvWKBwxn/7wY6AJcq
	uBGPrcqo0zpnWCW4G5B4fu1ndjx/nYlnryHPeu6EAinRPxaOEatwLwEb+XB29wnc
	tpC3Mn98cTKtKHwm+UJXkH102MQxyjRBsu0zZJmk2cQ+jPOPUH12Nsetp/4e+Muv
	xP/SW8I1tgl6lOGuxqCeirH5voc5yulMc/hHi3QgLwJ5Nbz7NAuXKnKZB4+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790628415; x=1790714815; bh=KrQUNC7sxrKrzZPTHB5tvlnzLulbbb5S8Wk
	eAz/ektw=; b=KIvY30sQAGdmwQrbD6s0bLWk4+eCiiCaOs8GhllApY2w0aXVxTM
	4+KkPlVhtX/UzY31LLI4jJ0FSdyO8fiG6M2/rdiaiRYbxEubLqQS18va97aBuUyQ
	Xlu88CkKH5O73TrcilS4/yj5yflAEQjde9igFKrtKEew/fBgL5H7FeMpxaelt6dU
	39zJuQZezEXdPirBJAKKVuEfG0LUWjjKwRBWd5uxTcFjf/DbAXz7uPzxzeWjNvCg
	5ZvQr9uSN7SK8K3kFcAoBgyCEUAOjMhFOIxk5xUZVDeltCMpzM5XJhhBBz9op4hD
	y8s+4I+a0i0t8DsBxYq7huswCunrmCJ4/bw==
X-ME-Sender: <xms:P9K6as1RzkMsNoUbSxBNCw8VVQUaCq1K_AQ5pnCEYOeGdVuk0Qy1gg>
    <xme:P9K6aqxDxGKjn9YbYClFkqaq2mP4UIkp8W6NdrY4sD7v-S407C01FxigxhsgPsONU
    mzAnAu2Pajdt2IKMXdSCtiOW8jnYm0jVq5VJB5aDOGJAD2V-q93FoE>
X-ME-Received: <xmr:P9K6auuysDVUhaAnNfUEx2V0Wn_M_3kLlZL9qxoAEwalNK5PGLHw16K5c3bvyGhlFWwNStPqk0p_YpUiESa1s1DUUUnyAWhnz0Dr>
X-ME-Proxy-Cause: dmFkZTFbxY4ifm7GoR1qg9m29yOL/fH+QYdjHrgkM8XYkKbwpXw7mjijeRRSaWTwyhoJBF
    GORKcKiJwqEVtym/X++S4qF1CvxxNWDYwGSGUbs050EdYC9OD4VXb4Sh5Dk6WrH5qnn7k8
    rkQXIsDSIdGpLKAva1TSZw5AvgPmKekFgyA2uOQn+tHX1MyJjcqYIa5g6/aFhYU926mN2g
    +6OAU/opPxPsBlRMKc5yLIMAd2TTdwyslIATiso9oMw442xlYy2Xd4pSqyE7qEdSewELjD
    bpAJs1D7Y5vGOL+wCAv+r9vRaOgo9OEYYfpkvhWDI5FkyzOrgAVrmxl/Q+yduPWWovL4oi
    K+go4Ak4BIK3tneHLhqUVCeu6B10v9FIFH6ADH1mb5vg30gr21y4FnFHV96DrAUmZL3LkE
    UP705L55Mza3ccdMnz+1cbAIsQ+ZI7C+sR9eD9h1qoaYlkuHsA3KfA3ppEWVI9MwNHnOV/
    d0bSK0yNnnnKtA+BjZlCfJjGMZcnxBc4GLWA0zyf9ASHN68Hg++YpH4GK0SeZRXbcQahen
    TIXed9m96MFuSMi7nLUrEcAuRjRoLGzVi8C5vfodOOIzchyqyfyQBgVJRO6UMnn1hzdbZA
    JI7IpJ2X4FUfaSz2MeWAgFsgQ73IFo/CYhzgAvS5n2Q8gbH5TiC7dF+WJpdw
X-ME-Proxy: <xmx:P9K6asy_jDtn-TtdYfnu0VVNGMPwROVNppP6nrmmFuSFHIUOH3Ea1A>
    <xmx:P9K6ahDBxO1xhTKkTLiu7PsuwuQ0-51S7BGXT8Me6fmwXXh_3ZwbXA>
    <xmx:P9K6aqeyKmycunoG8ou88apsTU6ongrWyc6p2GdCplDkHbq2-kbcSw>
    <xmx:P9K6armRrPwgTlQcShBcPq7QYfQgWXp7GOU7VNP_ADfAa3nEOCyx9A>
    <xmx:P9K6ajZZlDSUspvvYz0vmAyj6-te8f0TdqmGOx6mkRF2T6xLFnsUM2Xj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 16:46:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 1/2] ci: annotate leaks and stop a leak-sanitizer
 script at its first failure
In-Reply-To: <46e13a6e77f0c1c23a0dfe6183e8c3dac405da89.1790621693.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 28 Sep 2026
	18:54:52 +0000")
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v2.git.git.1790621693.gitgitgadget@gmail.com>
	<46e13a6e77f0c1c23a0dfe6183e8c3dac405da89.1790621693.git.gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 13:46:53 -0700
Message-ID: <xmqqtsn9kssi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A leak is only discovered once, at the end of a whole script, well
> after every test has already reported ok, and it gets no annotation at
> all, so a leak-sanitizer job's only visible failure is:
>
>     Process completed with exit code 1.
>
> Give a leak its own annotation. Point it at the test script, the exact
> line isn't known, only which script the leak turned up in, and put the
> full sanitizer report in a log group next to it, so it stays visible
> and isn't capped to a handful of lines.
>
> Once a script has one leak, it keeps running: the sanitizer log
> directory is never cleared between tests, so every later test in the
> same script sees the same leftover log entries and also reports "not
> ok", burying the one real failure in copies of itself. Stop a
> leak-sanitizer script at its first failure with --immediate instead.

OK.  So the idea is that we do not have sanitizer report per
test_expect_* block but showing the single one over and over,
whether the next test_expect_* block has leaks, is not helpful, so
we just immediately kill the test script after the first leak?

> @@ -53,4 +58,15 @@ finalize_test_case_output () {
>  	echo >>$github_markup_output "::endgroup::"
>  }
>  
> +finalize_test_leak_output () {
> +	# The exact line the leak turned up on isn't known, only the script,
> +	# so point at line 1.
> +	github_annotation_ error "t/$github_markup_script_name" 1 \
> +		"memory leak logged in $this_test"
> +
> +	echo >>$github_markup_output "::group::leak: $this_test.$test_count"
> +	cat "$TEST_RESULTS_SAN_FILE".* >>$github_markup_output
> +	echo >>$github_markup_output "::endgroup::"
> +}
> +


> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1f0505e412..3552a19323 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -199,6 +199,7 @@ mark_option_requires_arg () {
>  start_test_output () { :; }
>  start_test_case_output () { :; }
>  finalize_test_case_output () { :; }
> +finalize_test_leak_output () { :; }
>  finalize_test_output () { :; }
>  
>  parse_option () {
> @@ -822,20 +823,23 @@ test_failure_ () {
>  	say_color error "not ok $test_count - ${pfx:+$pfx }$1"
>  	shift
>  	printf '%s\n' "$*" | sed -e 's/^/#	/'
> +	if test -n "$immediate" && test -n "$invert_exit_code"
> +	then
> +		say_color error "1..$test_count"
> +		finalize_test_output
> +		_invert_exit_code_failure_end_blurb
> +		GIT_EXIT_OK=t
> +		exit 0
> +	fi
> +	# Write the annotation before the --immediate exit paths below,
> +	# which call exit and would otherwise skip it.
> +	finalize_test_case_output failure "$failure_label" "$@"
>  	if test -n "$immediate"
>  	then
>  		say_color error "1..$test_count"
> -		if test -n "$invert_exit_code"
> -		then
> -			finalize_test_output
> -			_invert_exit_code_failure_end_blurb
> -			GIT_EXIT_OK=t
> -			exit 0
> -		fi
>  		check_test_results_san_file_ "$test_failure"
>  		_error_exit
>  	fi

The two-line comment in the middle made me puzzled to see "exit 0"
just above it.  If "--immediate" is asked and we are checking leaks,
shouldn't we be doing finalize_test_case_output regardless of the
"invert" setting?

> -	finalize_test_case_output failure "$failure_label" "$@"
>  }
>  
>  test_known_broken_ok_ () {
> @@ -1218,6 +1222,7 @@ check_test_results_san_file_ () {
>  		return
>  	fi &&
>  	say_color >&4 error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
> +	finalize_test_leak_output &&
>  
>  	if test "$test_failure" = 0
>  	then

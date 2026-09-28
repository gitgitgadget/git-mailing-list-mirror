Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EFF4F5E16
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790628812; cv=none; b=ddp53UZEEEZ5SWwx14EX6zLNTPeFoCNdc1/AGSre1DBE6kTukB2g2/j1fZRxfvq6PIXBvlBdE66ERYVaCI/Yn1dQlFfBsRPAKNPZDzfEmIYHuC3YRYhAau/wp7qGe+bOeWOMqkrS3AOAse/TwjoGttZIY3u0AQP3sBSdzRh8swY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790628812; c=relaxed/simple;
	bh=Go68U8yd6LhRUpALRoyw4GZ3/nhWGW+K+gr8c/6XvWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PWqQyHyWM+54WG51Aa3fCdMmPQwK0Bt0I5Acyl4pdd7sZEqMcAEin0amr9GB/cfd+M9gc3/fiBXmAwdQYFympKDdAwfLPqHZzKEBHXVUOoHGyyLjdufJpIRvoKY4+CGu9RVm88SsidJDenq3NDtqyanRkqj6ti7HSRP1X8gMDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XI4ly+Pt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nUJJISq3; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XI4ly+Pt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nUJJISq3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D65877A0086;
	Mon, 28 Sep 2026 16:53:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 16:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790628809; x=1790715209; bh=FBSO1yUh20
	rtc33uI7CNIf7oyq4xx/M0bFSQaqy3sTE=; b=XI4ly+PtYwZZ3Kxe6Jjb4Xps/x
	ks3ZZQvmBjXNu987ZS8l2ciz+diX4SfdRtUoiprcViSSItzf3iEYijquvDb9m/k3
	Tn0H0InRi8PVfNUcjzPKdWN+L3PEYvkcrXbMl5FIRjeHPRuyQnrzodtGQhVdewvK
	Otp3Le3QaF2u5rPWiRbi3F5+3Fyof5dRPsW4Iz2X91sgO5bZ5luOs2wa+8naDXE+
	heijxaaiCEbcpDbO9p0rG+hjqdlmdPLLZeXPHO/7ywal9ER0FHsvv7hFjUOpT0XS
	r6Me/6q01bO/Eup1Lsl9xQY5eunHwPviFoXFT91cwvA1n1lVWB0RCyWzox2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790628809; x=1790715209; bh=FBSO1yUh20rtc33uI7CNIf7oyq4xx/M0bFS
	Qaqy3sTE=; b=nUJJISq3uD3a4NIf1hjgdH/QOO+lhHszzdTsWygtFGCB8eFM7hW
	tY0h0OiC33Ump5Bl7/Qfkq6QaJVejZ/g8rKec0KMIyafw8TZnyls6da+n1MawOOB
	Tj0QZCpZ7Ae8+3Qz84p0nz7WL02+SBVk6mKrjdlD9JNjmKfV0+dYJ2ZO5Yg0Nkfq
	Wi58sqCH+WaAvdhpuwvOPUH5kU06IpI9LMCvenjRKgB/fGAPdmIGLtf2rKmW3mph
	4m8jE/6d+Y6Riz+/mLFq3nY6Ce/v5FkK3bELOXTE6ubA0KCN7cxnkc7J9bXTkt1c
	GAmTDH1AF68BAe0mXDYYjBJbZ1XPqhCQSFg==
X-ME-Sender: <xms:ydO6ar8ABtU0M8QDabn18VuOh9eR-Ny9NJlARYSXz1pojPWu0Yza4g>
    <xme:ydO6arYsv2GA9SwaQXuiTpACiwN2MD2YY9fZy9MbpXY22lIJJN1D29-zuwKRS7h9n
    YzLQEcgUOh3l7xwJXTrpZfAk8NUuKEhyH_3ujYy5kFzuLZaOH6rmSMt>
X-ME-Received: <xmr:ydO6ai3oHLXrJmMgkN1dnsc4apg7Nl_6xjF0YQaTsIllzEM0dyfq5ymOncl4mNHj60z8VPJoNRcQobt_E_f7eGVbRzC-ywN6QMgI>
X-ME-Proxy-Cause: dmFkZTGat8Vm2gZyqsOHQeXx2TI7gYeBY6xAfz1rU75ouEtMun9ei1tBWFt3NB74SBg6cy
    iNS7OsIDegz9l8ODTJXUfgaqjFgOgNNQqYidg6q4lwrSQCbTnYrO9aHIZ0Aw64py+IiNms
    20BB4jEr2gZQBtvhHeAn6eO2S+Nl2kWgwuKgLkTnPLH9vJyKCHVwgkQH/WHlyJ0Quy6KhT
    N+GkJzJuPh9G/BxVszxGCF3qGFp9TflkAMzH4XxU6/CT03g7D4zPN31CzUndoLq5f7Bi7R
    Ip5J9zrOhzN1Hu7FeLpIgC70GdG0Oh921nMZ5xMjZaM9fkp+sk8acH9Uo3AcvxjbH5Y3aI
    F+Bulxw7MuZ+T94S0DQRxxnaNYvHGw6dZ9m0rs1Q8Dj5/PDJpRU6GyivXRTsD1TGtSQUZs
    Setiu+DhBefuevEF8AsASqk+XqdG5hexN1E0nJZRS7ax2rD0e9F5UkEKCGX873eW74E03o
    hTk113L6Fe72wRZv5XCNi1ly0axeq7kH+3M69o3/Wz07IczvYhfjfyNPDDV7Xy1cgN//+n
    WFcZbhgJO/dJ4Nf0Jl/IrBRHpZGrrE5EJWEAwd8gmVC23ShQZn5G/RVbdBA5/rga8ZmQ+b
    6jB5FXaOQANudN0kE0npsfpC/6/AKXo1WayXjYTqtp3PC3cydp6CgfHORZMQ
X-ME-Proxy: <xmx:ydO6aua4UAmDXsPee4DKroipvBVgcXH_6874kkPh64q4KBt43dUz8Q>
    <xmx:ydO6aiIt-8uIgNWco9RgSrUKGUSiKpXS1Ca2BsNNgOX9U7_FzW3TSQ>
    <xmx:ydO6alHiBisPxhWtrvVpYOwT7D5CbbBkRDdRu-QKH_tM1ZGsnpiAqQ>
    <xmx:ydO6ahuZ92-HZyk58KYE5g0IfAMCDLyKHlGNO0yNeK7LXMEsa9pscg>
    <xmx:ydO6asjPMbNcagyuNvtmDabs9JBo_jEeV9laDcjMRDOvlWcPFQOLe0RU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 16:53:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 2/2] ci: point test failures and fixed known
 breakages at their file and line
In-Reply-To: <bffa8fb0309b3698bebaa9b4d4763acdea52a7a2.1790621693.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Mon, 28 Sep 2026
	18:54:53 +0000")
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
	<pull.2419.v2.git.git.1790621693.gitgitgadget@gmail.com>
	<bffa8fb0309b3698bebaa9b4d4763acdea52a7a2.1790621693.git.gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 13:53:28 -0700
Message-ID: <xmqqpkxxkshj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  t/test-lib-github-workflow-markup.sh | 41 ++++++++++++++++++++++------
>  1 file changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
> index 0d54496358..67c5c3461c 100644
> --- a/t/test-lib-github-workflow-markup.sh
> +++ b/t/test-lib-github-workflow-markup.sh
> @@ -31,6 +31,21 @@ start_test_output () {
>  	github_markup_script_name=${0##*/}
>  }
>  
> +github_escape_message_ () {
> +	# A test description is always one line, so only % and CR need
> +	# escaping here. Escape % first, or CR's own %-encoding gets mangled.
> +	sed -e 's/%/%25/g' -e 's/\r/%0D/g'
> +}

Is it portable to feed a two-letter sequence "\r" to "sed" and
expect it to be interpreted as Carriage Return?  Implementations of
BSD lineage "sed" don't grok it if I recall correctly.

> +find_test_case_line_ () {
> +	# A description can contain characters like [ or * that would
> +	# corrupt a regex search, so match it literally and take the first
> +	# hit; -- keeps a description starting with "-" from being read as
> +	# an option.
> +	grep -n -F -- "$1" "$TEST_DIRECTORY/$github_markup_script_name" |
> +	head -n 1 | cut -d: -f1
> +}
> +
>  github_annotation_ () {
>  	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
>  }
> @@ -40,21 +55,31 @@ github_annotation_ () {
>  finalize_test_case_output () {
>  	test_case_result=$1
>  	shift
> +
> +	case "$test_case_result" in
> +	ok|broken)
> +		# Exit without printing the "ok" or "broken" tests
> +		return
> +		;;
> +	esac
> +
> +	test_case_line=$(find_test_case_line_ "$1")
> +	test_case_description=$(printf '%s' "$1" | github_escape_message_)
> +
>  	case "$test_case_result" in
>  	failure)
> -		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
> +		github_annotation_ error "t/$github_markup_script_name" "${test_case_line:-1}" \
> +			"failed: $this_test.$test_count $test_case_description"
>  		;;
>  	fixed)
> -		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
> -		;;
> -	ok|broken)
> -		# Exit without printing the "ok" or ""broken" tests
> -		return
> +		github_annotation_ notice "t/$github_markup_script_name" "${test_case_line:-1}" \
> +			"fixed: $this_test.$test_count $test_case_description"
>  		;;
>  	esac
> +

All of the above may make sense, but ...

>  	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
> -	test-tool >>$github_markup_output path-utils skip-n-bytes \
> -		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
> +	test-tool path-utils skip-n-bytes \
> +		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET >>$github_markup_output
>  	echo >>$github_markup_output "::endgroup::"

What is this change about?  In the original, all surrounding code
has redirection early on the command line, and breaking that pattern
is the only difference between the removed and added lines here as
far as I can see.

>  }

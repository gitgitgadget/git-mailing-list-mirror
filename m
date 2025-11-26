Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44427145F
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183035; cv=none; b=TyzYsi1N/+Ac6l5NC9N7Qb3KNgG2DDsuRrXF8nXHXEtu8VWdcaCpBlqUmGrE8MxVB+LWjONiq8Z24wu6jt5GTv5G/O7Y/BUCpUD0JIpvOJ02xsTdko+IxJ19ELScW/4RUCoA+kv9o0CZ8hyw7V8xucI13mmd+FK1I8um3B/77TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183035; c=relaxed/simple;
	bh=UWI/TOYwnPbeud7x+kC4+WA0GbfGIZOTeHOMrdewIYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eSf26K5C7i1eCAzIXnAqWcab9ICRRYrH7eBihmmX2sJqaPxni51Vi03ZYoXM5svTxT45VE9Ps7FOBeyIcDOGFAhKG+6bHLWMBTXQ4fx3yurV7LI6vuz1npo3uUqdMHbQQ79QnJ8wb+EjbYoGYPM8tWb9qMN/vQYcgnXYsdLPSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AaWO9XLG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2GQp8Fp4; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AaWO9XLG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2GQp8Fp4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9EE447A01CB;
	Wed, 26 Nov 2025 13:50:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 26 Nov 2025 13:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764183032; x=1764269432; bh=je1mrMOrs+
	4xgnl5uSSLIbNQkWzGutsiXRVAvac0O3I=; b=AaWO9XLGkzm2g0joXISqo+tlS2
	bmtnkW//0HhtDLjimcFHc9TVaeW3vwpZDaGFnbAxFM9n4f2QwJ1oY0n4BufvUYIZ
	6xhg+/AadlThIx96oD8f1AlkqRj+4qizIun2IZXkbCp/DJ1YmOhyFFYH5iI74ct4
	8f3B1gJ190fr7h5UNSTzzgh6QEaNyMNETJ86N8u6hsB3HMb8p8yOq1Poa/NQE+Om
	SQZU3Z4skqijv6O40NtaXqViHpzZ/fOQJRcj1j/XwacTbwkMvI/a9GP6V3Y1t3O0
	iW1Zg6KAuNWEDAYhCSRdpD8cRAdbpR/zNxRV6fkHgV157kV8kkBLyBL16JYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764183032; x=1764269432; bh=je1mrMOrs+4xgnl5uSSLIbNQkWzGutsiXRV
	Avac0O3I=; b=2GQp8Fp4/8eYXTkIMgKxME6CLiHS4tMVCr6xxNwHsuybRj/x+vA
	DtUGnAzEFkoDbq6QGka/XEG7jOMlyTCXCJtpo7hZqmYSfmhnairus8koNcscd4ft
	CFQyBT/BxO1F7y95WyG22B+7KJLSd03XXRQk/WhWo7QTNpFKJ95d9VM9gtC5g5Rt
	Qc11AkFY71L8MBMdlmiijffNepDMxrGfsWhUZA88ecrhgKLniNFudFEAbJxZoDDu
	C+GhoIotEcHtEDLHwz75q2EpZMF37edXmR6DJnwADJNZNeXQZFqeTVgMoTGCBRMg
	M1/8ukpH1zaOSHWYB0jPwnuqPSWoiWN9y2A==
X-ME-Sender: <xms:-EsnaTzuoYONEy1rhTDuDaDCtGzQ7s9TBwLnUnX5IZpnNQ4MBY9rkw>
    <xme:-EsnaSQYe5IWd7jVgQGk6LSto884rBWaYxrXt3nTu9ta1p2YfCHcjkmWHZbi-eyn2
    LpbKGLnTBMIt-NBM8ZsJ8vUj1jqCVQd7akcTbgod3P3LC2lp-mGp6E>
X-ME-Received: <xmr:-EsnaSWtM924Ny3FjS7937tSbItW0QnlP8HiYouA2l8-yvaIR7Ec1gZQTDhmTaARUZMfOrL4S7Oy-1BuORR_XwU_J3eUKGTvsrqX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    peihtghhihhnrdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:-EsnacYEzClYswIpQUXmA-7bjFCbLvhsRD4gPH-DsFrr03vcvnOF2A>
    <xmx:-EsnaQ0i8d-ouXmW1FiojPFCvThvNDnlFyRcpa8j8RhzTVTxWgHzEw>
    <xmx:-EsnaWh71fblh1ZlQkhY1_QP8LLLU8KNC-oKl7kdMSA8jsVputzuSg>
    <xmx:-EsnacYOkGGi2FNn08K-RpsnL2zcSZqKru1DgtnfWlvsoizNkyUylw>
    <xmx:-EsnaZ3T_02sIWlMEOCrFNoz9WKPXZn8cIKAlQBzjPEwehRXUxXrdC1j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 13:50:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>
Subject: Re: [PATCH] xdiff: optimize patience diff's LCS search
In-Reply-To: <pull.2109.git.git.1764152756908.gitgitgadget@gmail.com> (Yee
	Cheng Chin via GitGitGadget's message of "Wed, 26 Nov 2025 10:25:56
	+0000")
References: <pull.2109.git.git.1764152756908.gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 10:50:30 -0800
Message-ID: <xmqqy0nsmxvt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The find_longest_common_sequence() function in patience diff is
> inefficient as it calls binary_search() for every unique line it
> encounters when deciding where to put it in the sequence. From
> instrumentation (using xctrace) on popular repositories, binary_search()
> takes up 50-60% of the run time within patience_diff() when performing a
> diff.
>
> To optimize this, add a boundary condition check before binary_search()
> is called to see if the encountered unique line is located after the
> entire currently tracked longest subsequence. If so, skip the
> unnecessary binary search and simply append the entry to the end of
> sequence. Given that most files compared in a diff are usually quite
> similar to each other, this condition is very common, and should be hit
> much more frequently than the binary search.

This is a "stupid and obvious" optimization that is quite clever ;-)

> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index 669b653580..13ab0d591c 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -211,7 +211,10 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
>  	for (entry = map->first; entry; entry = entry->next) {
>  		if (!entry->line2 || entry->line2 == NON_UNIQUE)
>  			continue;
> -		i = binary_search(sequence, longest, entry);
> +		if (longest == 0 || entry->line2 > sequence[longest - 1]->line2)
> +			i = longest - 1;
> +		else
> +			i = binary_search(sequence, longest, entry);

OK.  If we have nothing, or if the thing sorts after the existing
ones, then we do not have to run binsearch to find where to insert
it.  We know we want to append.

Nice.

Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B4199FAC
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758466380; cv=none; b=DHD6bJtWbs5pX19LlUPtL9ZEQYr0RYZcUHHtMJIyrA06BKrrfGpWAG/WoN+zKTL26u34dUdyHQPo7nOWUQhK+44expoqOqojWW7z03qmI0nSHa7obNP6bgmsv/r61ESETNAnmBKH9VMlYaohAmeEcguihhP1DAw6YiOV839m2mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758466380; c=relaxed/simple;
	bh=KwNk+by8UvO9ZD9UqPGHDoTiYSe/oRJGbmxbN0YWAqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UdYvNUndXjoS3yARY62FChE82TK9WPXvashDYOg1V337hP7KwR9J52Ijp6QJdjRM0slQd9KtmHwak9nPDoHiSto/fjXbDDWfNiYfTSWdnWoXqlzvruyr/VQDZX4vhC+/QMMmlituqbhUPfts0Q2w7yIHMkk2bjFWZ36ZCtuYpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nyG3sVtm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G4vuY3Zi; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nyG3sVtm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G4vuY3Zi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 6973A1D0007D;
	Sun, 21 Sep 2025 10:52:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 21 Sep 2025 10:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758466376; x=1758552776; bh=6DbqhZ2kQ9
	UR7jvOPjZ33KN95MLjzTJtFh+4n2PDU1s=; b=nyG3sVtmPZSRoOtFLiREnvGmGm
	4WSJ0P9PhwXE8Ru7Qgxn1ciKw0I49QGRbW0oDlBX85tpkjegwwK6yXbCTxmlBB/B
	vG0UaCVvUTjSJbA5pDZpTk3LmluS3JDjAW7YfBPGIQLTYS9rFs6hGjWeasKK2HjZ
	wtX4mNP0CuvcYMjt7Y32AlD6mFw+vBL1SJuc2ExgD8CY9PVPswvFeFfzabRJOeDb
	f3U2wG32VOUStBPekwGB+827fTFGpjddKIxgq2j5jWIPHYFpDPAlPgn5cOly/VOo
	agtTblA4w9eyO5cxhEojTpDxgyQsVXU6RUfM2TSRgvW/+TLq9wXIh8OQ/TRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758466376; x=1758552776; bh=6DbqhZ2kQ9UR7jvOPjZ33KN95MLjzTJtFh+
	4n2PDU1s=; b=G4vuY3ZiIv9G/0N6sJpE5vMkwDagBg1zxYtcqVwZsHyD/G5Cva2
	HaNnEadxMa1fyHOii76y9WVwgC2HBnaHSHgLyRBLIvV/CeqEli2uzNCKg68Hr+O1
	i02AsONB3ZYz6Coao/TG9vMGbNvUyOtokxk/bNKaTyg4U5E/AGpuZC3x5JUfBaBT
	eCv9+0wCAZJXl5ZGVjhzvv5UsyQQbUpTsj9EEOZBz6Ap6HfeFy1LNs5+JghwtGL8
	9wm31KU8qM122K2IeV3E7RuPM5NncoEbStvfrRfsFpNm6gUp2v7ESTX0JJQ/WCFD
	GfbQQWROEi5huQFW2YfgtDl1lGYW7JS+EpA==
X-ME-Sender: <xms:SBHQaCR_LhQkZ5w1uoibEEPZzp0LznbI1_e0Kcxv1lbhetfsJFw5iA>
    <xme:SBHQaCWIIDltb1xFopuBgXPBKmYFjsUej2nxUwKYtmdX0Zp8v3edzV-KQPDOAc6xt
    qaSDcEqo_hhyssSnw>
X-ME-Received: <xmr:SBHQaMZDZ_5dbQeo0hnSSVjG5nfhI4ZT39uNCYCFHpc3X_YZeQLS_YDMOQjTsZS9VODgBPvJ6gqa8vvHvjebLo-6AO1V2LPujNxy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehhedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SBHQaA31pPTahNO8wse_gZmhGCzs6DZVormtlgS-lKf4Vs7d9uJNFg>
    <xmx:SBHQaGhS-NovRUUNT4BTXsD2NV4wJSIS3NP1kvBj97dmWHPTVMurjQ>
    <xmx:SBHQaMaZjwVnVLrYheuO3EUSFSTm4xfIJ7qXK0RDinZiGF6YPdh9kg>
    <xmx:SBHQaORDAfT8hP2CHiR7MWGeqL2TC1sWxAIeFfDwtst6M9IcUwi9Bw>
    <xmx:SBHQaHuQpecSxznA_7nnk_fjoIJSHA6X8ADAl9pLVwTz3-N5i3FFvUOv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Sep 2025 10:52:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] http: offer to cast `size_t` to `curl_off_t` safely
In-Reply-To: <7caaec91020687f09764bbd50477c3fe889fcfed.1758457356.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Sun, 21 Sep 2025
	12:22:34 +0000")
References: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
	<7caaec91020687f09764bbd50477c3fe889fcfed.1758457356.git.gitgitgadget@gmail.com>
Date: Sun, 21 Sep 2025 07:52:54 -0700
Message-ID: <xmqqfrcfx3g9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This commit moves the `xcurl_off_t()` function, which validates that a
> given value fits within the `curl_off_t` data type and then casts it, to
> a more central place so that it can be used outside of `remote-curl.c`,
> too.
>
> At the same time, this function is renamed to conform better with the
> naming convention of the helper functions that safely cast from one data
> type to another which has been well established in `git-compat-util.h`.

OK.  The code inside the renamed function is the same with an
updated message to show the value.

> With this move, the error message can unfortunately no longer be renamed
> because the `_(...)` function is not available at the time of
> definition.

It is not clear to me what change (or lack thereof?) in this patch
this paragraph refers to.  Who wants to rename what error message
and why?

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  http.h        | 10 ++++++++++
>  remote-curl.c | 14 +++-----------
>  2 files changed, 13 insertions(+), 11 deletions(-)

Thanks; will queue.

> +static inline curl_off_t cast_size_t_to_curl_off_t(size_t a)
> +{
> +	uintmax_t size = a;
> +	if (size > maximum_signed_value_of_type(curl_off_t))
> +		die(_("number too large to represent as curl_off_t "
> +		      "on this platform: %"PRIuMAX), (uintmax_t)a);
> +	return (curl_off_t)a;
> +}
> +
> -static curl_off_t xcurl_off_t(size_t len)
> -{
> -	uintmax_t size = len;
> -	if (size > maximum_signed_value_of_type(curl_off_t))
> -		die(_("cannot handle pushes this big"));
> -	return (curl_off_t)size;
> -}


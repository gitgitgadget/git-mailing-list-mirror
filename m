Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F82236EB
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445754; cv=none; b=Pwq2HyYqrD6cXR6CGKefR6SWUZ5em7OmV3hdfxwfh3n9xDobDrtXGQGG4zj92/0GxWLiAVQZPS0TOlhS1t+dVHrB7Ztyh8MA/I+1b+yUSZiqDEZygArO97ut+ClFX5jztTIo+ng+dPpJgICGelZ0WSsxM1R85dzUcrr846xqEcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445754; c=relaxed/simple;
	bh=ofrQxV6i0RgX2lJtz5EPJuUnWWYKLlBLyOgRgg9Qh5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aJCr5SSyBW9LHeQD14/fYhUctaFoM6uo39LG9eZO+yE9YFdcSTYa/9gP0xYVgXlaxhtdAd76+8XgUe+KImuEo3boBTfDFYOMTErj/VyhzCKjOZ+7w2jg7zbszggJjEeHkQllO6PZTVq9HpP1bK7B9KhBGYz+JZ4VVReW06HpZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o0vO943S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WLcxnJ8h; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o0vO943S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WLcxnJ8h"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B1BDEC00AB;
	Tue,  2 Jun 2026 20:15:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 20:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780445752; x=1780532152; bh=WLY4LkfEUf
	RkJNDCaOMKLrDD2qxhq1B0TTLxB3SliDs=; b=o0vO943Se+52Jkv+L8ct+Xv88s
	SMWiKreq7HY4OgZYxoBEo27xQ3oDXLNO1I4IzqyWRUX/m5E+1364Pu4pK3C26j/n
	tLsSLMcLbvsAaFOIMSL6OJsfUsPSvtSz975c+2ZDm8HcGv1VuzkDPfO0SPPM5S4g
	6z1313I4tm8iZ+SvIkt9FKKtYSObl2TWtHpWOR1LmEwYD5DMqqNzfWwID9hkTyg/
	EeLAK4RoMw4dKF4RZsPpDQN7r5TaQpLIpPeH5896a/hGXG8jtiEcq8HGufRQc0ht
	f3oyrcmS29GoxiATJ7Tc70zN99vCxFSuh/X78Ii5g7r0GKe7kuCWKii72q9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780445752; x=1780532152; bh=WLY4LkfEUfRkJNDCaOMKLrDD2qxhq1B0TTL
	xB3SliDs=; b=WLcxnJ8h1uDyC34hXE5U+P0GCwwbKNwX+QfQnogdhf+V8Uc/a0b
	1WIbxxcp4DU6ZYqf+Kyf1dn7gEkG/Dg3yTTT0Lfk85r5Eq3/sbE8M5j8zXh5mTiz
	TXE8Vb/azIP0K0LpYVrapwaNHgHV9wf7YH/DH2ejVfkAheqBzbBiHJtw2W/VXJkO
	zco1dnATF8Tu5015DIZuAdzhldf3C3V379KP050ZitNhGcInB89rzt8Igi+z2sQY
	SIrihKorfEyE85rq8mN0sKud8PgaHku8UX+elBi5n2LuBx/7Fm/GnbjUJ5vRlR4I
	WvWRmV2170Zdb+CoyU00KXRBfXZzsCCHyWA==
X-ME-Sender: <xms:N3IfagYUfJqWEsLVxPAznT229bxxdW_CXtZp71375ef-zuWUSrXmTg>
    <xme:N3IfaiariE3iHNRM5ycvp9QZT423kxVLhTyRYBvjZP5VpY8ERb8ZW98l2jwVInY_4
    LAm-WLDmm2y1sTGJGNOdvptMsP-O-I78MXcCmzHF8PIykTpfFxomQ>
X-ME-Received: <xmr:N3Ifav8Q5_XyYTLcZHaEh9Hkn0QnART3_nECqJ-5363aHcKuvjmFwDuefd72NQDxT--Qh9v9qD76YsQKYRTUCazUqskoNJcCskb6>
X-ME-Proxy-Cause: dmFkZTFYWVkPJfFj8Xwe6aIhRJ0Q9jjsddcZvoZ9xs0iFInbXSAgCdUO69RBDcOHBN7LJ5
    Qbmhyz0nGB9slkbEoxzfSPBxtHbCkKEW0QKteoyFsV1fCSlYA9AJxle1nsxWO3HOaMIvhM
    ux9p+WlB16r95P9eqb7lG05LxfJLoDBajsdQPU8J2J1nKxrwBhmq6kAaVRmGcn3SD4eDyO
    lUfvIT+rxU+weLjv9/8elwjn09WrFcmXbU71Uv8eiimQNmPOwrBEwCF9h0mVl92JMBDxiU
    uJvfRStHCWjZcAj99bhvgd7/EkMW+3Fnjy89FRo3gMYlD1+/gLBdAmhJthSEXfXan68Blk
    Cz+Im64JlRiTdoYN4dp7gYmp1Fsw6R77bHQFv1AYWDfbtkafeYS99NwuPEjRc9YYzfSB/1
    a8jDSZuEi38YS7YLUFprcceUQUtueZK71nASo4I4CloOwHFnXr2wNZFRX7kVUvkUNJyCvm
    yyl7u7uXFhMEyz5JLWsot/RgrWTzBX1k/2QjcpUEaTZE/Zk2MljuQoXlHmU9SiCiO1rsY8
    FtuLQNvoIk3eHqfuChUo0YeXTdsjVv3rs8yCsWCB7QCBe/BuXuC+e/TY5diGxaT3Dna8GZ
    ES97ct2oDfRCKdcZtvj9MaKjxovErUYbq4LkYpxKwRe/p0MXYZVKL0lR394w
X-ME-Proxy: <xmx:N3Ifaphk2_IM2pSHwHGApNPSCsZwZB3br1mhXo6aQLXwQ-YetFy2qg>
    <xmx:N3IfaneaK73VvmpUZGIXTO5WGBIFcSY3K8GtwnyyQazPRBFmUPb3WA>
    <xmx:N3Ifaor8oZ4jgA3KfNTEH_REsD99kGup1BZJtpuXmsfljocmsgy0Lg>
    <xmx:N3IfakCW_xZSGWh70Nu2XdvSC2Mj9ldZLGi8CfNoLrfF0nnKnGjZZQ>
    <xmx:OHIfalB3OVpHOuC2NzZ4yuSw71yeDdaU8kWADrqlIwrSfvAzTu6wEaNz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 20:15:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: <git@vger.kernel.org>,  Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH] http: preserve wwwauth_headers across redirects
In-Reply-To: <20260602161150.1527493-1-aplattner@nvidia.com> (Aaron Plattner's
	message of "Tue, 2 Jun 2026 09:11:48 -0700")
References: <20260602161150.1527493-1-aplattner@nvidia.com>
Date: Wed, 03 Jun 2026 09:15:50 +0900
Message-ID: <xmqqpl28scll.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Plattner <aplattner@nvidia.com> writes:

> diff --git a/http.c b/http.c
> index ea9b16861b..cac8c9bfc9 100644
> --- a/http.c
> +++ b/http.c
> @@ -2425,7 +2425,21 @@ static int http_request_recoverable(const char *url,
>  	if (options->effective_url && options->base_url) {
>  		if (update_url_from_redirect(options->base_url,
>  					     url, options->effective_url)) {
> +			struct strvec wwwauth_headers = STRVEC_INIT;
> +
> +			/*
> +			 * Preserve wwwauth_headers across the call to
> +			 * credential_from_url(): if the effective URL doesn't
> +			 * specify its own credentials, a credential helper
> +			 * might need the wwwauth[] array from the server's
> +			 * redirect response in order to authenticate.
> +			 */
> +			strvec_pushv(&wwwauth_headers,
> +				     http_auth.wwwauth_headers.v);
>  			credential_from_url(&http_auth, options->base_url->buf);
> +			strvec_pushv(&http_auth.wwwauth_headers,
> +				     wwwauth_headers.v);
> +			strvec_clear(&wwwauth_headers);
>  			url = options->effective_url->buf;
>  		}
>  	}

As strvec_pushv() makes copies of the strings contained in .v[]
array, the above will

 - make a deep copy of http_auth.wwwauth_headers.v[] and store it away
   in wwwauth_headers.v[];

 - let credential_from_url() get rid of
   http_auth.wwwauth_headers.v[] (the original is freed here, but we
   have a deep copy stashed away safely), and perhaps add some of
   its own there; then

 - add what we stashed away back to http_auth.wwwauth_headers.v[].

So it does not leak and it does not have use-after-free, either,
which is good, even though it may be a bit inefficient having to
copy these strings so many times.

I briefly wondered if it is unconditionally adding back the original
wwwauth_headers always the right thing to do, but I think this is
good.  In the context of http_request_recovorable(), the redirect
has already happened, and the request to the redirect target has
failed with a 401. The wwwauth_headers currently in http_auth were
populated from this 401 response from the redirect target. Since we
are updating http_auth's URL to match this redirect target (in order
to query the helper for the correct host), the headers we currently
have are the active challenges for this new URL. Thus, they must be
preserved and passed to the helper.

A few design questions that came to my mind are:

 - Is wwwauth_headers the _only_ thing that needs to be preserved in
   the existing credential in http_auth?  Will it stay to be the
   only thing, or will we need to rethink what this patch did in the
   future when we add such a new member to "struct credential"?

 - If we need to preserve some other members in "struct credential",
   or if we add such members to the struct in the future, what would
   be the recommended way to extend what this patch does to cover?

If we add new members in the future to store other transient
response-based authentication state (e.g. Authentication-Info
headers, or proxy authentication states), they will be wiped by
credential_from_url() and will need to be preserved the same way,
no?  This observation and thought experiment may hint that the
manual save-and-restore approach is not robust against future
extensions of struct credential.

The current approach of manually saving and restoring
wwwauth_headers in http.c creates a tight coupling between the HTTP
layer and the internals of struct credential. If new transient
fields are added in the future, developers must remember to update
http.c to preserve them, which may be error-prone.

I wonder if it would make the design more robust and future-proof to
encapsulate this logic in credential.c instead.  For example, we
could introduce a helper function:

    void credential_update_url(struct credential *c, const char *url)

that does what the new code added around credential_from_url() by
this patch does, perhaps?

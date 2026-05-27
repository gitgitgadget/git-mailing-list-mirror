Received: from fhigh-c7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD330F55F
	for <git@vger.kernel.org>; Wed, 27 May 2026 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915614; cv=none; b=O3fJ1JzX0I/iP2DDdW7qrq2sLFEgzSYCl5ClSFxFZWsxhXhx++GwDgZ5JhtMaNGLCjksPliOQAlwHfIh2nG0ubK00HlXzaWw20idJvmVzQLA3l/nphEZMBdkhi6wFzxnkbotqWEpBHDKoqbJ+4s+I6z8d9CNyldAHvVYMI+nLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915614; c=relaxed/simple;
	bh=LzjAYONP9oPG837sD4N38s1jyNTQzS+TpgGF5AQS6Qc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BBNEUKQKXJM1pU5h4F1d5ISRZpFAL2JIaTsB3sgOPcgBvjnsldMh1spA8JftP6RAt30F4eIzfYIQ3Za+r0iiQJyW/BiZqmSbAFr6aBzcSdGopoBB9TPeQjwy7+2QU3Lbj9YvTQlRY+TAadwWP8nxvRgKZDKBJlTjF/TFzrQuooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kMvmHbYh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WP2+fWw+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kMvmHbYh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WP2+fWw+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 96E8B7A0130;
	Wed, 27 May 2026 17:00:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 27 May 2026 17:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779915610; x=1780002010; bh=xICH8jmeTE
	0wc+G8S9gXK/urkjNj80a9kXDlszFuCOo=; b=kMvmHbYhBtOLMlN/8SvXropShT
	Jx6RYZkMKB4CI9CDce1eX07g4KnWZTXoHTl6zmAuU82+oqix5mlrxpeqR+/AFj//
	Jt5qHOVM+Lphrh6KEYP2L+sPKj+iKDZL+728ZUatKpp3ZPcrnR32qjupLpHxlp8L
	lgVTDlaF4kvxG6f6SqP86uFNlmJylKueDXS3/0gU/LUF+l3EpXHQAc1K9DwQT7gw
	6nQIWK3g2rlxz7PxAYLHgVQzEfmxwktUNOp73s0fTYEktmtB04ggT78nS6+mQ9Fm
	ZiAL3KIzXoQMzHPR1o5NpPMZ8UW0MarRxog8s469aSRTMldNzb9k2pv1lsTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779915610; x=1780002010; bh=xICH8jmeTE0wc+G8S9gXK/urkjNj80a9kXD
	lszFuCOo=; b=WP2+fWw+sM1qwvYYZyeWoLmCbP1Yv45xTkjMn6dK9OYFvSz4XRe
	OiX4UyQ1xXM9BFqqadZe8md0E5tEkFc0xFLhcJ8Ic+jXfpDETHxu+633gEaMqBpW
	fdEHx/g6etTX8XI3NhKzUvtu/n48mpoPfWjAEYkfZwzkalrMLZhljK+sUaHCan1x
	AFidzKzrScH+k3hAUs6Hnb/V4hQ7xQm0evqQM2yUO0ckKNBCAK3Z9x7/lyscmqzd
	3IpdIjjGALWGOXdOiuea7HJyfILzzVeiF6hc+sruwyY35Y5H2HKvLFyTHQe55+Qj
	h6JhNcMK3H0f6TUwZNMBZvdUreuamAf4jSA==
X-ME-Sender: <xms:WlsXajaL58RamkoCCiGG2Ayhirr6Ny8KH72coFjGKyo3FGeNvfaOIg>
    <xme:WlsXapSwnSIs5s2CbaG5cdWBg8MnZmaT4GAWWoo8dEBKrnOsgZUX9xOfca1W-RGWG
    qTJbV4fVgb7EKzetoNmnVPjoiGG3VbmidGUlnkVnR-mKPknqxGkdg>
X-ME-Received: <xmr:WlsXauS5Sy2ps3wx5lnRXg8efmACQaGUa1z76FLzaEC-dA6eQxdrIBcq48vuZp6VrExbf_ipFii53JVKYALxK4Qk8zFcdXKNSMfu>
X-ME-Proxy-Cause: dmFkZTGeBKgco9WbQxdlk34LBOg2l/7v997GntXE4o1u75tJ8/fZPP9DVxUu5h0YKU+JQ1
    hPDBF0WZkYJE6WQH4Ajre7CgsXbIMlTYQOwIq6uxpZLHptA8UjKes5HqIWa/SosFjdT/6B
    i+r2AX5eUObyQo+gWvfIBRIDDm8y1GF0AM+YLiD5m/bj5pZFBufW4TOdOcYSqCqnVpq5ec
    Iq2XwxhhZ+95pQGbSuYF1bcB0UPGp4o1HIjD8Ybu3nwH+XsaI/yrZjrs+XtItGICFIOb7k
    HJjTpiACxjAHYf9NF2cKIdwMeuiIBM0JhOkXMnotjseGTJXJ2zjDVn7jqcH9L72e32KFr2
    XbiVIOFNC68OQntBCQ/vsGekS5ZRKPSlEQPX6D0wP+dvn7ETnV6CDoCy5286ZFD4Lbz8vj
    mzSG/8VtpLc6gaY+zzYYPaVrupVSSHPunzwoM/ludv4AeTVQn8XJwA8f+CiagKuTnrQ95Q
    0UYFJMnchWLgF9Rg4jmj56CU3nPLSmclww6uj7O2AJUOs/ZxVI3ciiS/4bc9E3nArYdLH9
    dpwXTdqm8XNnZSBi+fyxGmo2UrT7Kxm8Vu3TmPnT+7dnv+Aohb/Opjz9btQVwaKuGzb1Om
    m5yOxYf8SaAt1g0xZCS9SV/SwLABX4+7HSV2I1018ZSsp0Z1JHGBIlafgfpg
X-ME-Proxy: <xmx:WlsXalQoEu5Yvuac-AVcEb7mZovJWQ79Q-EsR6leIyR-XEAPH-0BmQ>
    <xmx:WlsXar5gfOhdwgu1w-i7DmdnXsyXyoQodsG2HtdrFbQYoPw2iW5QLw>
    <xmx:WlsXap0-BLOOiqi6GPlH-Q5wY-4U3CkE5yDL6j-ZUjQa6HgBWWtXtQ>
    <xmx:WlsXauD-BD4sAeMoPxAbSSXGc7rlagxmRLM1Y1AZYBrWtUP5Z74dZA>
    <xmx:WlsXanHizFYIh9r2fzy2g-J5wYKf3v--o3QbnbG00uVPpMT7Q7Z9l5ZC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 17:00:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Sebastien Tardif
 <sebtardif@ncf.ca>
Subject: Re: [PATCH v2 0/3] daemon: fix network address handling bugs
In-Reply-To: <pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
	(Sebastien Tardif via GitGitGadget's message of "Wed, 27 May 2026
	18:18:28 +0000")
References: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
	<pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 06:00:07 +0900
Message-ID: <xmqq1pewlga0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Fix three related issues in daemon.c's network address handling:
>
> IPv6 address corruption in lookup_hostname(): getaddrinfo() is called with
> AF_UNSPEC hints, so it may return IPv6 results. However, the code
> unconditionally casts ai_addr to sockaddr_in and passes AF_INET to
> inet_ntop(). On IPv6-only hosts, this reads from the wrong struct offset,
> producing garbage IP addresses. Fixed by checking ai_family and handling
> both AF_INET and AF_INET6.
>
> IPv6 address truncation in ip2str(): The sockaddr struct size (ai_addrlen)
> is passed as the output buffer size to inet_ntop(). For IPv6,
> sizeof(sockaddr_in6) is 28 bytes but INET6_ADDRSTRLEN is 46, so long IPv6
> addresses are silently truncated. Fixed by passing sizeof(ip) instead, and
> dropping the now-unused len parameter.
>
> NULL pointer in execute() logging: REMOTE_PORT environment variable is used
> in a format string without a NULL check (only REMOTE_ADDR was checked). If
> REMOTE_PORT is unset, NULL is passed to printf's %s, which is undefined
> behavior. Fixed by using a fallback string.
>
> Changes since v1:
>
>  * Split the single patch into three separate commits, one per fix, per
>    Patrick's review.

This, and all the other items in this list, are differences between
the version before v1 and v2, isn't it?  It is OK to pretend that
the pre-v1 version v0 didn't officially exist, but it would be
helpful to see the inter-version improvements for *this* version.

Indeed, range-diff tells us that the commit log improvement is the
only change since the previous iteration.

> Range-diff vs v1:
>
>  1:  b2d8143811 = 1:  b2d8143811 daemon: fix IPv6 address corruption in lookup_hostname()
>  2:  5c01ec3cad = 2:  5c01ec3cad daemon: fix IPv6 address truncation in ip2str()
>  3:  1b2f9d1a07 ! 3:  e312735716 daemon: guard NULL REMOTE_PORT in execute() logging
>      @@ Metadata
>        ## Commit message ##
>           daemon: guard NULL REMOTE_PORT in execute() logging
>       
>      -    The REMOTE_PORT environment variable is used in a format string
>      -    without a NULL check, while REMOTE_ADDR is checked. If REMOTE_PORT
>      -    is unset, NULL is passed to printf's %s, which is undefined behavior.
>      +    REMOTE_ADDR and REMOTE_PORT are both set by the same code path in
>      +    handle(), so neither should be NULL independently. However, the
>      +    existing code checks REMOTE_ADDR before the loginfo() call but not
>      +    REMOTE_PORT. If REMOTE_PORT were unset, NULL would be passed to
>      +    printf's %s, which is undefined behavior.

This is easier to read than the previous, but it is unclear what the
change is trying to achieve.  You first say if addr is set port can
never be unset.  So by checking addr before calling loginfo(), the
code effectively is ensuring that addr and port are set.  

 (1) The word "However" in "However the existing code checks" does
     not make much sense to me (I would think "Therefore" is less
     confusing, but if what you first said is correct, then it is
     quite obvious and can be left unsaid).

 (2) It is unclear why "If REMOTE_PORT were unset NULL would be ..."
     needs to be brought up.  Yes, you are not supposed to pass NULL
     to printf that expects "%s" to format it.  But isn't the whole
     point of checking that addr is not NULL because the caller
     knows that loginfo() accesses both, and the caller also knows
     that if addr is not NULL, port will never be NULL?  Or is this
     comment about something other than loginfo() where port is used
     without checking neither addr or port?  Then it would not make
     much sense to bring up "addr is checked before calling
     loginfo()".

IOW, the sentence structure got vastly improved than the previous
round, but it made it clearer that what these sentences say is
unclear ;-).

>      -    Add a fallback string for the NULL case.
>      +    Add a fallback string for the NULL case, matching the existing
>      +    REMOTE_ADDR guard for consistency.

I tried to find if there is any existing case (addr ? addr : "") to
match, but I didn't find any.  Probably that is because it is not
needed (instead the code does "if (addr) ..." to protect itself).

I think the only valid justification you could give to this change
is to say that even though the current code is perfectly fine as-is
(i.e. as you said, addr and port are both exported at the same time
so it will never happen that addr is non NULL and port is NULL),
somebody who is not so careful can break that arrangement in the
future, and it is a prudent thing to double check that port is not
NULL before using will future-proof this part of the code.

Thanks.

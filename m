Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E54B8DD0
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927043; cv=none; b=fkQE9X7U/oVsIqsOIBWPLzC7FWC08Z19kbPm+c/RRvz4j3F714/HqzMzPMSeu8yDyGQS4F9opE+t1oyCeup1kn+U96zj8bZ9J9NBjTPIafb5NcS32G3SshKkPrdmEbKyNRuAozF1iXrv3VCCTQij+eePFiig9BVrmyCz/0WxSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927043; c=relaxed/simple;
	bh=53PDZZ4/qaeHMf0gO4VW8dTZ6SXyRtYKa6ijC8+8knU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H0T0W9k1O29JIm7nW9R/uqMj4Ij41S8mSW7OTbYimdHUwuxrSklozwE5h5zzTrEUDNYC/1Gn2q17msSmBKc+fPwyROkdjTK7n0xAdwGEXk1Y8zlC9kst40h+gplNFM0rsA773Xb2/9Yr2A5E7OASoE4DuAmM/BtZs3SIjY0OZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=enDd5o6f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VmXFJqo9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="enDd5o6f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VmXFJqo9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7553BEC00F8;
	Wed,  1 Jul 2026 13:30:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 13:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782927041; x=1783013441; bh=OXSEDYjWzX
	VRQSajERh9MMxofceXw/1B5H6IOJG2PwU=; b=enDd5o6fEA4IzbTvlBO4WqwcBi
	MFb/z+rmS/fpDuqQrfAJ0LYOa6OT9WwFSn3vlnZLSH8eNtPLq5nM7mm4NQn4nJGo
	k2Gc7+2XCvOlAgNE8jLwoWRX68mpFyy1ufu1juJaX+mRkpBXS9PGCY69SxowegGE
	wVk0DL/0BXDyT9Lax7q0bPzExg+40T1QMwnTY6G6EMq9CtlBPoTm834aywQAy91J
	XFqOWYzrcaS+CH7FA6hRCS0jG/tsS2NDzW9K5S1LRwp3gKCh0aq/+JWGSy4O9YGD
	0Ff/x5sRXC7kVZDnYQFVaCPMzl5uIWWpzVAcCXM7+o6Aa/bhcNJ/IAS8rwXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782927041; x=1783013441; bh=OXSEDYjWzXVRQSajERh9MMxofceXw/1B5H6
	IOJG2PwU=; b=VmXFJqo9nBHNn0aBVU6rL6bmbswjqYoTJz+wH1sO0UYBlC3NTyM
	oVomDYt9bu8iM5wyr9AdldhLKZTwqpFtSLvRkCjnpHfDelzTaqlMZdMAKxse6hUZ
	ON5aF9bKwaKEjVwUJdslW/QzFwrCmkLgwsMMR1z0eFWkqscp9CXl58jX32QoAvIv
	8PteSClnKIZXG8wyPSjVyO3blieo9OmWt3REjQtpB+6+OnnUDaMWmyVhf5o59QIS
	lTJFxJ0w7yqwHpNPrifTdHAeVSIGxLnbgQAhpIsySaxMmXbcISyx1OtsuCeF+ehZ
	ERbSK384W8YBM+zyXpiwhUMRo9xV8VCoTfQ==
X-ME-Sender: <xms:wE5FaijhRglBP_UlWGJPi_C6MoNYGqm5tq8Ac_nuVUR5UnpBvXqY9Q>
    <xme:wE5Favm0I1qPCoBrSjNqO9Lqz8WuYIs_2b8KE4T9iN6SuZvkJ9ZM6tor8LLjmROuC
    ZrM2lVnvrqqYgSAlEAQRHYNv6_4_2tTTcGkGUxD3vXh5x1enVFYMWE>
X-ME-Received: <xmr:wE5Fauj8_ayUuEl-SudQ55WztRDweIUHalu9tG4YZemcm3PCuL5Mj_Jjxj37hVXeiyFQ7tl6JkBwsvdlVQ3clEMCe7EAVq3CsC2qqks>
X-ME-Proxy-Cause: dmFkZTG3f/obuU748wfnx7V6BketF0mTI4D1rB1nUBDPcqnk/tlCUYD8s0bJyYZUJKO0DX
    TOsCXgpceMdE7vJYPjGZUS+rxwJuTJO0er8PZ03wvycB/hFYTsGrpUBgo1FefCzLE9qJ3y
    oq2VcdP/y8dSWofVUSj9IlkUgJ+RajJKl3NLpT+YIEnQNoVPMstsWWuj+iGKXUR36izbox
    ojogkwnZy8cv6bR/bQlF4nIts+JIPewG6biN1/MAy9WSQsNOf5u3cjHGdy1iXbnYSYi+Qo
    K0mt0Mo9kOyvkkf6FjT8rt1do8SSzkzdtq/IVtSq1fRjReY7cv1ox/tZLCscyfygxOkif0
    otapA/fMm3ANUM+A1kDLezkY4MRHbeMDUCPADBl3hXyu+7sSt3kNTZ63nNl5uEkdKJSYhe
    5G1h7vFWvZx2u7nLVZdxmRLXn7d5OpPTJUNI6sz4VJRJiM2V0OOEAfwPYNBuOefoMGWhkT
    G0WgCEthD/t2iuz93vyEQKCreuHoQQ+pZFcZeORQL9/IlOBvnZ78JKIxpOfTL41DIK/Hpj
    hZxo2LfIqjSGDADa7Ah36AbqGtiI0BLQ0CU4iiNwTRir++7rMuzJSc5Fjqo2zi6Sf06aDk
    A/lgmko+BGbk6msAzs+BWwuJ6ueiA8ePPLYQHRTfCcY5FXQNZeLAZ8RPlcVg
X-ME-Proxy: <xmx:wE5FaiEgsl8uKleVrjEKqj_pcYxElcN04_PMnkMyz_a40e2Pqd_iyg>
    <xmx:wE5FagssP2B_7FWcO3uIes5p7VFHoxIITHyInaw8ge9QrkxZDvYXSA>
    <xmx:wE5Fajcanrm8gEt23plVe5W48Rvt2h-5CrcthI-BslhOrqUOS75bHQ>
    <xmx:wE5Famn8UoSpOKaMWB5l3HV-QRkCBn5ql2b-UHsgz-NPSKh1XzxGlw>
    <xmx:wU5FatTCXmfOvR76KzNA_xprQyRPXpmrM5mYfmJtozIeD3CVjhB8HjQx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 13:30:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  chriscool@tuxfamily.org,  eric.peijian@gmail.com,  jltobler@gmail.com,
  karthik.188@gmail.com,  peff@peff.net,  toon@iotcl.com
Subject: Re: [PATCH GSoC v15 02/13] git-compat-util: add `strtoumax_szt()`
 with error handling
In-Reply-To: <20260701-ps-eric-work-rebase-v15-2-c88a43b63917@gmail.com>
	(Pablo Sabater's message of "Wed, 1 Jul 2026 14:18:36 +0200")
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
	<20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
	<20260701-ps-eric-work-rebase-v15-2-c88a43b63917@gmail.com>
Date: Wed, 01 Jul 2026 10:30:38 -0700
Message-ID: <xmqqse62obwh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> From: Eric Ju <eric.peijian@gmail.com>
>
> We already have `strtoul_ui()` and similar functions that provide proper
> error handling using `strtoul` from the standard library. However,
> there isn't currently a variant that returns a `size_t`.
>
> Using `strtoul` is unreliable because `size_`t is platform-dependent,
> `unsigned long` could be too big to fit into a `size_t` or too small to
> hold a `size_t`.

It is somehow annoying to see that the commit log desciption, which
is *clearly* meant to be plaintext, is so heavily riddled with
backquoted references to code/program symbols.  Yes, `literal` is a
correct way to format them in both AsciiDoc and Markdown, so we very
much welcome them in our documentation, but not in proposed log
messages.

In any case, you dropped 't' in 'size_t' outside the pair of
backquotes.

> Use `strtoumax` which returns a `uintmax_t` guaranteed to be at least as

`strtoumax()`, as the convention you used above for strtoul_ui() is
to suffix function names with ().

> large as `size_t`, add a range check against `SIZE_MAX` to prevent
> `size_t` overflow.

OK.

> This variant is needed in a subsequent commit to enable returning a
> `size_t` with proper error handling.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  git-compat-util.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 8809776407..5ecce5bbd2 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -975,6 +975,26 @@ static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>  	return 0;
>  }
>  
> +/*
> + * Convert a string to a size_t using the standard library's strtoumax, with
> + * additional error handling to ensure robustness.
> + */
> +static inline int strtoumax_szt(char const *s, int base, size_t *result)
> +{
> +	uintmax_t uim;
> +	char *p;
> +
> +	errno = 0;
> +	/* negative values would be accepted by strtoul */
> +	if (strchr(s, '-'))
> +		return -1;

Hmph, wouldn't 

	if (*s == '-' || !*s)
		return -1

cut it?  Since your call to strtoumax() checks that the string was
parsed to the end by insisting *p is NUL?

If you are trying to more explicitly insist that s[] has only
digits, which may not be a bad idea, as that is what we generally
expect, then

	if (!s[0] || s[strspn(s, "0123456789")])
		return -1;

perhaps.

> +	uim = strtoumax(s, &p, base);
> +	if ((errno || *p || p == s) || uim > SIZE_MAX)
> +		return -1;

And with !s[0] upfront, we can discard (p==s) case from here.  Other
strto*() wrappers we have may need the "cannot be empty" check,
because they do not need any upfront validation of s[] like we do
here (we do so to reject negative numbers), but since we do need to
check s[] before calling the system strto*() function anyway, it is
OK to be different here from the others.

If uintmax_t and size_t are of the same width, then (SIZE_MAX < uim)
becomes mathmatically impossible, but hopefully no compiler or
static checker is stupid enough to warn against it.

> +	*result = uim;
> +	return 0;
> +}
> +
>  static inline int strtol_i(char const *s, int base, int *result)
>  {
>  	long ul;

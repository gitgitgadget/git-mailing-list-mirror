Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A33D3FB04C
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467446; cv=none; b=BtV4AMUWxUOS5G49aFbhFydM4+/AhK016oRy3TFQ7naDWJNxdaaYQjlNWvHPYjR5omB9yfl0/dacfkCU9A7SaGe5OPN5Hhq2WD/oFF3Ivmj2RE5cYp/FOxhjMU0uBrdWXJyIV6supJB3Z4sEHW/V6hJ90RkIpk8LRddXfxbnM0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467446; c=relaxed/simple;
	bh=16lEmTf208kzYkq9sOWjMhxwBMixB5qq51V3mpX7Ef4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NXu7L2IS2/4ybrZDThBwcv6CnbeWMuH0sDPGsWO24SNsAmVgY8t+jjm8524pvtCmDFqwHBBhKN5fsjjtO9Z4X3tqzpvxVDqtSR9Qu+a3TZrVcJ6W45rDVqB1X8cWYOhDLXP+thkFdyy08wJJeDeuAH43A0ZM1XZnU9k2sFpjp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lsl3BpwY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2xaKcXDQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lsl3BpwY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2xaKcXDQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C9CE7A0177;
	Mon,  2 Mar 2026 11:04:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 11:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772467443; x=1772553843; bh=bk9sMi3e2r
	1ULbzk8T4yVk31RrM5SMxPlxzVEcpYyt8=; b=Lsl3BpwYpeMaqkEkxsBIqEe213
	vat6IKKKriki4we98ch/gNWKu4rMnWZi+WSPURBUjZaxFYM2Qd4XRHagdue+UhQ9
	+zREFFGWtVkpzfsA1NW20Yb4xYc1hx0apGoXsCpnZ+xdfAO2BkJcBP1qKg076uV4
	bP4Q//nEDfrCIlcrbnmD6VttLLnTjHZ2FbnxDCD0p9mYxuHM7t3rIvFXMWwsq+db
	mwN6JsdDNGjqEqX3j/XYvs1fsIjF8xpEKNtYCmC7goJI79edFG8JbRRumag135mZ
	EQaX+IyPrfTWaHAyNtyBJocAmJGZzCGkh/34JrsnSYFJSXmU+mteHToaiznw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772467443; x=1772553843; bh=bk9sMi3e2r1ULbzk8T4yVk31RrM5SMxPlxz
	VEcpYyt8=; b=2xaKcXDQH446L6qalGG0NyO5aWVAtM+Q5umPSXbUb75Po5+fot5
	vhDA9DNaagwleipWGCFfNoObdLyD2WgzSSkxhpX4ZTuoKHSHuLhjgk/aGZnybPIB
	Qkm+AwmqDLsexWn8EffjW8T5BDvf7I78qinuBaNLzSKebc1pp/4Lm/xKllA/44AD
	+HZRutsF4A7qKiK3+aoNcSy0hUZHvAKUPQGnyEXD4lCHqgoarzsjFMAWf2a+ekr8
	86UV41PmpwgrTNI2phbcmgkD6syQiRKOaj8zjJqKvtiwYTh8okTD55nglr1z3NAO
	IK/SgoTfQ92oamlU8SvowT63IqmUBIZBTQQ==
X-ME-Sender: <xms:87SlaaCvg2Edykr0UqbHfkRxyVnzr4HdVdehk1GQHqJ_z5S66wX2-A>
    <xme:87SlaYPIzHMI3CzxmnGghnZIPLskkr4P9grGCFaSv4-CLNYsSeV1xU6mlF23xEs03
    p0HLhHLRjUhaJZj0S8hfQVDqT4_q6NCTAZMKBrO_ZjU8w0Lnum0Qw>
X-ME-Received: <xmr:87SlaXZs3gUV05a_75ic8EmFr65q8I3mnZ2kKLv5nhWNKipfjSlRLXklouDmAG9lez2nVTCgdOmqHlSMDzl0rLHAuLRzLQaidw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhishhh
    hhhhrggrrggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:87Slafuh24ls9y5Qrayn2EH8TSYHA1aJkkMoDjqoSSWR9oP95waK-Q>
    <xmx:87SlaRNJ5WlT8qLTIjJ3xEmH3ZL5rGWrkSW-4uInoDvtsMj-5M2L0w>
    <xmx:87Slae5N-3wj7GsKzGQ0WNnPVJUWiVDdrThNgBuD2ZFPWtCl__P8Pw>
    <xmx:87SlafR4dEi1kIQ04yJZusl6r38B0Cakq0sRtzHG5r-6Lf7-BOF0GQ>
    <xmx:87SlaZw6FN7wb2asgmNLb4jbl05wH5hpj-7XyaEAsOiN_oxTjaaJK9cP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 11:04:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,  avarab@gmail.com,  peff@peff.net,  stolee@gmail.com
Subject: Re: [PATCH v4 1/1] help: cleanup the contruction of keys_uniq
In-Reply-To: <20260228104654.80831-2-amishhhaaaa@gmail.com> (Amisha Chhajed's
	message of "Sat, 28 Feb 2026 16:16:54 +0530")
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
	<20260228104654.80831-1-amishhhaaaa@gmail.com>
	<20260228104654.80831-2-amishhhaaaa@gmail.com>
Date: Mon, 02 Mar 2026 08:04:02 -0800
Message-ID: <xmqqwlzu43rh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> index d3a0967e9d..03104b3bf4 100755
> --- a/t/t0012-help.sh
> +++ b/t/t0012-help.sh
> @@ -141,20 +141,20 @@ test_expect_success 'git help -c' '
>  
>  	'\''git help config'\'' for more information
>  	EOF
> -	grep -v -E \
> -		-e "^[^.]+\.[^.]+$" \
> -		-e "^[^.]+\.[^.]+\.[^.]+$" \
> +	sed \
> +		-e "/^[^.]*\.[^.]*$/d" \
> +		-e "/^[^.]*\.[^.]*\.[^.]*$/d" \
>  		help.output >actual &&

We used to require at least one non-dot byte between each dot in the
original, but now we do not.  Is this change in semantics intended?

You could fix it with "sed -E" and keeping the ERE in the original,
I guess?

It was in a distant past when I tried benchmarking them for the last
time, but I recall "sed" was a lot slower than "grep" on a "match
and print" job that "grep" could be an alternative.  So I am not
sure what the point of the change in this hunk is.

>  	test_cmp expect actual
>  '
>  
>  test_expect_success 'git help --config-for-completion' '
>  	git help -c >human &&
> -	grep -E \
> -	     -e "^[^.]+\.[^.]+$" \
> -	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
> -	     sed -e "s/\*.*//" -e "s/<.*//" |
> -	     sort -u >human.munged &&
> +	sed -n \
> +	     -e "/^[^.]*\.[^.]*$/p" \
> +	     -e "/^[^.]*\.[^.]*\.[^.]*$/p" human |
> +	sed -e "s/\*.*//" -e "s/<.*//" |

Ditto.

>  test_expect_success 'git help --config-sections-for-completion' '
>  	git help -c >human &&
> -	grep -E \
> -	     -e "^[^.]+\.[^.]+$" \
> -	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
> -	     sed -e "s/\..*//" |
> -	     sort -u >human.munged &&
> +	sed -n \
> +	     -e "/^[^.]*\.[^.]*$/p" \
> +	     -e "/^[^.]*\.[^.]*\.[^.]*$/p" human |
> +	sed -e "s/\..*//" |

Ditto.

Just like piping "grep" output to "sed" is an anti-pattern, piping
"sed" output to an invocation of "sed" is often an anti-pattern.

Perhaps something like this would replace the original "grep | sed"
pipeline?

	sed -E -e "
		/^[^.]+\.[^.]+$/b out
		/^[^.]+\.[^.]+\.[^.]+$/b out
		d
		: out
		s/\..*//
	" human |
	sort -u



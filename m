Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA581C0DD1
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 23:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711755335; cv=none; b=rXbJM/VT/Y2dYKedFHsWASn0mSz3M31EGjzb7i1NxUdCJbxltf6WC4ayRgcNcyjxdAHR4yrz/9THvwVoOw8+41kcumPA8Em9YKTe5bv+XSn9Odphj6NMLH+VlZHOEqo71V/AGiBNpUSY9o0bW/sKBrT1RzxWSX0A2VwuOFRlBwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711755335; c=relaxed/simple;
	bh=+4cc+LAVEtPtu3ZVQowmHolTkogivIRhquqMJYrJDNg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qsh1kuG44uwzMqjHaSvvvTFUZotCTwIAMFNLTjp5+2DGB5C9yXeW5vggO2hPjJs4UuXn9VNmCeGgUe0C3przPGPl5ZXdBuaXqd/5cDkQTD4NImiLis/sLKVl35E+D0WfdIhl/G86SKM/wZooCvGxClZXojFtc60id5y3NukWEEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=w87D2PkZ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="w87D2PkZ"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711755324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zf5qWCOeloTI4K9rCyeyaDhAJE01WAGkKvRHr8pOWqM=;
	b=w87D2PkZlMYnFfjolP6DADVNZcXdkbQlH9ZkndKc10PqqyYQdQ0B4FCQWjxULkX5LQTXNI
	Iba/2F3DoTZLr285NU3I97tzfqUa4Ju871wfF4B3BzS+AwdB1VNs9o8aBnnR39Btyi20Wz
	20a8exN6+H2HvSXd/bpKWdt+HQ50oexghWCYtHAYAth7ilt1IALLewXj7GmRYn6afbXbzO
	ueaUhKH3PNlBozUQOLyoU9jk021eu6iwLjWh6ZVc+xGcAoZZfOraXEvOquF0f1c9G79MfG
	JwzN344BQzrKtagN4ha9E6KUWR4jN9jKi+/KlgeRcVir5eV6Zr2fLPAyiSYleg==
Date: Sat, 30 Mar 2024 00:35:22 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] advice: omit trailing whitespace
In-Reply-To: <xmqq4jcooddp.fsf@gitster.g>
References: <xmqq4jcooddp.fsf@gitster.g>
Message-ID: <50ca23f79bc0588cf6d99a56415eee2d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-29 23:57, Junio C Hamano wrote:
> Git tools all consistently encourage users to avoid whitespaces at
> the end of line by giving them features like "git diff --check" and
> "git am --whitespace=fix".  Make sure that the advice messages we
> give users avoid trailing whitespaces.  We shouldn't be wasting
> vertical screen real estate by adding blank lines in advice messages
> that are supposed to be concise hints, but as long as we write such
> blank line in our "hints", we should do it right.
> 
> A test that expects the current behaviour of leaving trailing
> whitespaces has been adjusted.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looking good to me.  Consistency is always good.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  advice.c          | 3 ++-
>  t/t3200-branch.sh | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git c/advice.c w/advice.c
> index d19648b7f8..75111191ad 100644
> --- c/advice.c
> +++ w/advice.c
> @@ -105,8 +105,9 @@ static void vadvise(const char *advice, int
> display_instructions,
> 
>  	for (cp = buf.buf; *cp; cp = np) {
>  		np = strchrnul(cp, '\n');
> -		fprintf(stderr,	_("%shint: %.*s%s\n"),
> +		fprintf(stderr,	_("%shint:%s%.*s%s\n"),
>  			advise_get_color(ADVICE_COLOR_HINT),
> +			(np == cp) ? "" : " ",
>  			(int)(np - cp), cp,
>  			advise_get_color(ADVICE_COLOR_RESET));
>  		if (*np)
> diff --git c/t/t3200-branch.sh w/t/t3200-branch.sh
> index d3bbd00b81..ccfa6a720d 100755
> --- c/t/t3200-branch.sh
> +++ w/t/t3200-branch.sh
> @@ -1154,9 +1154,9 @@ test_expect_success 'avoid ambiguous track and 
> advise' '
>  	hint: tracking ref '\''refs/heads/main'\'':
>  	hint:   ambi1
>  	hint:   ambi2
> -	hint: ''
> +	hint:
>  	hint: This is typically a configuration error.
> -	hint: ''
> +	hint:
>  	hint: To support setting up tracking branches, ensure that
>  	hint: different remotes'\'' fetch refspecs map into different
>  	hint: tracking namespaces.

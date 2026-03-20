Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2742D3A69
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773971204; cv=none; b=g0dpxP+d/575JasriXFeOAYRMYeRMCYZ30JakqYv6skZGQQVViZIQ13f7F+GotoW7chHTUfLyy7LooD8I6Df7yEkNNQy5384ysMIcZ7/vOfnQhQA4o7dzyBjhXiN2QGiHvW2xAv+kncYwfsvMOaUlwpWAf1pbEJ8/asF8UcsCY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773971204; c=relaxed/simple;
	bh=EhNnXoBalyRO9cHtX4NXJaEt/yKFnrVqIXzXJcnh9DI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DaaNj7klLMcgDcjaP6fbJQT9O8IG0MrxJ/w1r2+XVt6uPjffT3aGyn0BmBfoemT1wPmVeUqrYY3fXf72IBRx4ctbImjeI/8QUK7grTZkXNnQnQklVrBTjRtCSgMVfLl74NmQPrwJ/2g/MgypV4eRHyK0sMYHTm7g+4Xn3HuzX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kk+ERq3p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=it7wyWmZ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kk+ERq3p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="it7wyWmZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC54C1400182;
	Thu, 19 Mar 2026 21:46:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 21:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773971194; x=1774057594; bh=cAEdeX6cHF
	VbGK4SvaiiesBEfrLMpBbTWV/wUnL5wZY=; b=kk+ERq3pkgduhyI/S24bOm1GE7
	DlAle04hPqEMuOBhv75yLdfHObNY5nvjUwE+OY8hlOPtfASgbZp9K0df2bKP4Rwh
	j8nK4/+Qh9wAZvFow96SSBcrjeHYhbP6aAO7WetGmMZz2nCwJiZamGkGYCJhYudm
	AFGfmycWvdRX7Sk4v2pKJvMslQC6cYcRiGnM8LeWhx/edIwtJgEM2fds/V5kfK1E
	bAiw++fLgLcFD5hw3xU+EtIO1UMZwgfsB+qUyn6n2ddbcuRGUugZP6C7V8AXayx2
	6hiyH+nrOl2G9ND2+b28HUW29Az3+EDCTYvMs9tNCktqBDIEoM3NvpAuk3lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773971194; x=1774057594; bh=cAEdeX6cHFVbGK4SvaiiesBEfrLMpBbTWV/
	wUnL5wZY=; b=it7wyWmZgtIWbk4lFY2cFDWIZaUxI4EdvfioYxma8XmpCx9GqZY
	ZXII3bPAKQEsL/dQo+mvIFgXeetXo9Fe9LpazeTeMZV/QAXhzrCpmBvUgmftIgpr
	Ddieyvj+2lreTZbHQZAhf6h7Q5jJK5NXrYNhpMXsZiDjI0VGKd4ehdOGtuy7/5TR
	/tXpJxaadQOraTyrpz50g7Y+mpwS5PVDjBUYUh4M/Ny/oigqnQeGuW3Ri6jiGUGX
	ek0LEm1R+wHXnMTqWJlLYWQBFSGzFZJ1Df9AtzhsTPoKFdV1LTNAOi7goiQ8BeT8
	V8Q13tnpqZg9JKpUOKJeGwSqj0LYQy2ym/A==
X-ME-Sender: <xms:-qa8aW_6JBv8xXOYupBEFX4FariOyQGaLL2U5qXrukAgHcYQLpS3Qw>
    <xme:-qa8aeJS5JkHir1aNr3hj_mumF3FPzf9u8YV4vztJLYNNI5IPpnr8jWP1U3zFsK0_
    mfSTFRq3F9_NqG67qOHaHW6mxhFNAa80CSQ8cJ8DboZR9w_vndorw>
X-ME-Received: <xmr:-qa8aZZehEE2vHltCIhlAJQcu-5JcQOpsw_bSRpOaCAg77QhdN39FMAyNdxvHbe58kT-aEiwMOw4oiVixVCS5VqJUSmjpqAV4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-qa8aYKNaQE9vwqjRyy9AWQwV9KClpUC1yuUKA22NueKgKNFWPrCtA>
    <xmx:-qa8afCHTQkRwJtjs47dFKz0T0_cg2PHbzWkplVmax8RqSkXLA2LrQ>
    <xmx:-qa8aVoC9hmSVweC8n5xLfI_Si9fF-hwJW-6Ky2C3M-PUaAdHr2JVQ>
    <xmx:-qa8aSjmprgJsg8mzRf6NixP-jqysazZilaNosawLEy8CYL5l8kf6Q>
    <xmx:-qa8aW4GkSENwWiyrk4hSJdRb5OqgfRaTLZPKv_l6KkjZsgI_FzhC3Og>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 21:46:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
In-Reply-To: <20260319233546.GA3632561@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 19 Mar 2026 19:35:46 -0400")
References: <xmqq341wnvbk.fsf@gitster.g> <xmqqcy0zii0s.fsf@gitster.g>
	<20260319233546.GA3632561@coredump.intra.peff.net>
Date: Thu, 19 Mar 2026 18:46:33 -0700
Message-ID: <xmqqcy0zgtmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Because strbuf_getwholeline() discards what is originally in sb and
>> replaces it with what getdelim() returns, I have a suspicion that
>> working with bare char * and size_t to interact with getdelim() and
>> then using strbuf_attach() on the success case would be simpler to
>> read and maintain.  Once such a rewrite of this function is done
>> (#leftoverbits), the special case we see in the Coccinelle rule can
>> be lifted.
>
> Hmm. I think that is something like this:
>
> diff --git a/strbuf.c b/strbuf.c
> index 3939863cf3..0333aea261 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -631,6 +631,8 @@ int strbuf_getcwd(struct strbuf *sb)
>  #ifdef HAVE_GETDELIM
>  int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
>  {
> +	char *buf;
> +	size_t alloc;
>  	ssize_t r;
>  
>  	if (feof(fp))
> @@ -639,12 +641,14 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
>  	strbuf_reset(sb);
>  
>  	/* Translate slopbuf to NULL, as we cannot call realloc on it */
> -	if (!sb->alloc)
> -		sb->buf = NULL;
> +	alloc = sb->alloc;
> +	buf = alloc ? sb->buf : NULL;
>  	errno = 0;

I actually was hoping that all lines in this hunk before this point
can be removed, i.e., strbuf_release(sb), buf = NULL, alloc = 0.

> -	r = getdelim(&sb->buf, &sb->alloc, term, fp);
> +	r = getdelim(&buf, &alloc, term, fp);
>  
>  	if (r > 0) {
> +		sb->buf = buf;
> +		sb->alloc = alloc;
>  		sb->len = r;
>  		return 0;
>  	}

Yes.

> @@ -669,10 +673,13 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
>  	 * we can just re-init, but otherwise we should make sure that our
>  	 * length is empty, and that the result is NUL-terminated.
>  	 */
> -	if (!sb->buf)
> +	if (!buf)
>  		strbuf_init(sb, 0);
> -	else
> -		strbuf_reset(sb);
> +	else {
> +		sb->buf = buf;
> +		sb->alloc = alloc;
> +		strbuf_reset(&sb);
> +	}

I do not get all these conditionals.  This is an EOF code path; we
have no data in buf to return.  We resetted the caller's strbuf
already.  Can't we return buf (if allocated) to the system and
return without doing any further damage to sb at this point?

>  	return EOF;
>  }
>  #else
>
> So I don't know that it makes anything simpler. We have to copy the
> values back into the strbuf either way, and we still have to handle
> restoring the strbuf invariants. Even the strbuf_init() case is still
> needed, because we don't know whether getdelim() just didn't allocate
> (in which case we could leave the strbuf alone) or if it actually ate
> the allocation we passed in (which was just a copy of sb->buf).
>
> -Peff

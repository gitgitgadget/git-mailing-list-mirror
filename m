Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5CAD4B
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 05:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989357; cv=none; b=SSQ9Y3/chWGLaEXaA2K0NjJfjGe8LRhnEIkKYSDQdtR+WnPQMexgLtaRp1c9lW7dLfLxW5VarmJjz3cFjx8uBlDaK/QkGRmzUE6auV/OjRzLgtAfbWLh2gQythgLK3jYAfYjvZ23Mfx4hQQ4U0nKZ26KuoS3q0pJHg9E+aqdJKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989357; c=relaxed/simple;
	bh=HR9tdft0Ox/NHzpLn6CujefXLg6jWplDqg28KwXez2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLZmNVRfwlkA6K63k1S5eIkyiV3QZNi9GMfMXtPCcLvUvqhoR1MgeHSV6nX3fY0v8x+i9Y4rGntEWhteSGwQzr1kyA/nPOlTw6YK2TE5hzWmvIqgIR7YJxRZ1sOcw/yR4PXOhbMNYnEYU10LMsGYO91yiH/mr+K/iqBkf4Y2Hsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H0evl0MB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H0evl0MB"
Received: (qmail 174588 invoked by uid 109); 9 Oct 2025 05:55:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HR9tdft0Ox/NHzpLn6CujefXLg6jWplDqg28KwXez2Q=; b=H0evl0MBCb30rU4116IM0vs0gn9Pe/sQ6jN7+sJ8Ex9qrAsYSE934DE4f/3Ojg+pM0ZSUvyxryJi1QKYd1qb7BFNjZx1vZX0zqPLA7jlSoRUOkDG1QMfHnL6np/I7qKUt9+eqSVhI9BG6gNi+hTnYsO5WfbqbZKqmgUTdzJp96Fw9808mre/Nx0kcZQrjfijcR6BBQcR06kCCuiJgu/XgXZq/T88IhNo5hdkySpm9rKyM0iavJsVZygImbSWSkUKvXorfmuhggNlFG3unl+NNj7zPMNW1H2gLQ0uxu7TS8QdApFFmsX12ame+DE1t0F4tluMBfl1O53SeEi2gIwt2A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Oct 2025 05:55:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 265741 invoked by uid 111); 9 Oct 2025 05:55:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Oct 2025 01:55:54 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Oct 2025 01:55:54 -0400
From: Jeff King <peff@peff.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <20251009055554.GD1614343@coredump.intra.peff.net>
References: <aMp8yNFiXDyk2hP4@ArchLinux>
 <aMp9OtXLfRw7dEwA@ArchLinux>
 <CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
 <xmqq348dovi3.fsf@gitster.g>
 <20250924053601.GC1173044@coredump.intra.peff.net>
 <xmqqwm5om1gy.fsf@gitster.g>
 <87jz16dux5.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jz16dux5.fsf@gmail.com>

On Tue, Oct 07, 2025 at 06:49:42PM -0700, Collin Funk wrote:

> In GNU Coreutils and Gnulib we often use 'idx_t', which is a typedef to
> the standard signed type 'ptrdiff_t', when we refer to allocation of
> objects or indexes.
> 
> The rational is written in the header file where it is defined [1].
> However, I want to highlight one part that I find most useful:
> 
>      * Security: Signed types can be checked for overflow via
>        '-fsanitize=undefined', but unsigned types cannot.
> 
> On common platforms, you will never need to allocate more memory than
> PTRDIFF_MAX anyways:
> 
>     $ numfmt --to=iec-i `echo $(((1 << 63) - 1))`
>     8.0Ei
> 
> I think that addresses Jeff's point that 'int' is too small, which I
> agree with.

Yeah, absolutely. I do not love size_t (and certainly switching signed
"int" to unsigned "size_t" is an easy way to introduce bugs when you
cross the "0" boundary). I'd be very happy with everything using
something like ptrdiff_t, and even hiding it behind idx_t or count_t or
whatever.

-Peff

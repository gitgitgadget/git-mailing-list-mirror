Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E8372B36
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183793; cv=none; b=e2rU9RPItzknP5XmmV+tOC9FBRZfZC3ebJSiZGcs3RDVjZsxlse14pWCuYVhiZqfAet3UTOqb//aFeagW+BDNTm9jcdXHJI6vwvHaV3mniA3doc8Ay2XqC5mso1srCAd6TN5PVsHYor2xX5zZKIirZbBIk1+PzYjybvkljSZIqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183793; c=relaxed/simple;
	bh=Q4fHAn5+oJsZCVUH8LbIlc3PVCZxM9/3AcEelbwt/0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+ODTNsbbaAXmJXVRAVBah0ENbGhuBfGo0mYpTxME986BtdsYtuA98ZRdQthUa+DWzqFHGxuf27bDS+L+yRGwfW5TZNEs1YwSYcuY1koYcnO7zlEK9d+2H0WlABf5gpWtN7aQQ0gGlHmbQx8s9IWXVFoiEiFfXRl3jxWi2N2htc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hnr86hzV; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hnr86hzV"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4645dde00a7so413502b6e.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 16:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773183791; x=1773788591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oDti+7yo8ELEIl6L1gr1nziqLeQU4ZXMI40Y16FoRwE=;
        b=Hnr86hzVy4YZOg039dOsjM6YLMJUxqzNejmc/NndgfymVBxsjNzXeDEo1oJdyT8Jvi
         ABI8HyAUSL/6nEnZHQpl8BLlsXLYqFzpo/tux2pmEjZ+Cu5/GkQZ0yeSPdJd0xigv9eg
         Sz0fux5pEfEo9/KCXLmpHs3YiW/tmppLYZL5Y/b4fNAkmyv9IgD2gc1CZoWwgiltQS3s
         vojOwejs5SXqyiOX6c8m4F30r8KYPMJgQoZhmXSO+SndFzHM5x9Cv/2108SUHKjQSEnf
         F1pfA4K1Bu6UoK9b5fKhP31YGQujccYd0uS/INUE1ZQIqdcKH4ejVx7EnNcTRkrYgS+M
         eb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773183791; x=1773788591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDti+7yo8ELEIl6L1gr1nziqLeQU4ZXMI40Y16FoRwE=;
        b=MuOW9H5URLXRoZYQ5IcGEzHNS9qU6tGfB8ymqHFSbaw9JjIYqo2YTom3VyPW6mhO0A
         wF/78826newp+UniJBhWs5IfJBF2rfJMLyyVpPyAY4R7ps46e5o25oU7wy6MzY5Q4CT1
         X4R3ijmiIrIuDsM6zzkelF4MhNYkOyPYlcBrqIh27IAYWhTSJDN1+U9CcnAUa1trCqGg
         vsnitTGUl98eXtLfQXC3MJ58+pkz6SkhKJrFvXW27FX1B8psTGHhvqUgf9t8C8ACgGG4
         ElLjx9vJE2FF25jaFhCfbrrjUrbMnVTS7FLZkJzFI2MJNgXBwd6gmDPeLIngvclJuWlm
         f0zw==
X-Gm-Message-State: AOJu0YwED+leu8MDQ1E6ZZrz4NCc/VnYoqTVZf8hX7Uo9xALf2BcN31F
	V2WMEA2ouwz9tjRGIzfVxPpVtY7zO+Btm5RyEkqT28RmvtlA5B7VJyEd
X-Gm-Gg: ATEYQzxhrLHMbrg+izcC+BVFjFtSDscRcrgQSglWCy7uL+NSV1HY9OxvQAs8P+cN9lb
	D/Vmp0n2eqNJJOf1MQ2YgJGKyuLlEDJqTIyZD1C4GfmwkAwt35ZcYyBnPAttsD9isd8DEZPsV0t
	iiNtBoLKHeUnn8YvKmtzb2kVkj2DwuHf3on4vGE7c4/T3T3fKK/PiTFTnVyWxa1BrdvSHGFb+nQ
	CiStrbDjTpoOFOpAVpJCqP7a/tGE4o/DN7Xkzcxa2W5542sz3voMzL+skSxSRxTQ3+y4VWzNaVk
	hpevlt+OnzsqQF4o1hXq8u5rcCJ7bruwuvWrPevUYYHYTlyJRnR6HaasBb9BHuLg1Rl8g8CPHIp
	l9S6BgB/OJ6E3tvK6nsExZ8TZDHv7cFY3ezyoNei125qIIiDhiURzTdibAxx0cHrLh05TEDHNnh
	OUJ88AFV5YMrV8oEKD
X-Received: by 2002:a05:6820:1689:b0:67a:222e:ae6f with SMTP id 006d021491bc7-67bc9118c61mr247538eaf.26.1773183791023;
        Tue, 10 Mar 2026 16:03:11 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1f9f86sm379588fac.2.2026.03.10.16.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:03:10 -0700 (PDT)
Date: Tue, 10 Mar 2026 18:03:08 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, 
	christian.couder@gmail.com, ps@pks.im
Subject: Re: [PATCH v3 0/3] fast-import: add mode to re-sign invalid commit
 signatures
Message-ID: <abCgIt6X72UR2vbU@denethor>
References: <20260306205359.1723254-1-jltobler@gmail.com>
 <20260310201116.1130160-1-jltobler@gmail.com>
 <xmqqv7f3s93l.fsf@gitster.g>
 <abCFKEHxu7OZr9bm@denethor>
 <xmqqqzprs7o3.fsf@gitster.g>
 <abCTTaYCQIub_xjW@denethor>
 <xmqq8qbzs40p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qbzs40p.fsf@gitster.g>

On 26/03/10 03:39PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > This certainly seems like a reasonable use case, but if we want to
> > support leaving previously unsigned objects unsigned too,
> > `--signed-commits=strip-if-invalid --signed-commits` wouldn't be
> > granular enough.
> 
> Yes, --signed-commits=(re-)sign-if-invalid is a perfect match for
> that use case.  I am just saying that if you add the machinery
> needed to re-sign, you would be able to reuse it to sign objects
> that weren't signed in the first place, so that is wherea yet
> another feature "--sign-commits=all" may fit.

Ah ok. Ya, adding a signed-commits mode to cover signing all rewritten
objects could make sense. I am planning to also add an
--abort-if-invalid mode in a followup series. I'll may explore adding
this other mode too.

Thanks,
-Justin

Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79786236453
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765246438; cv=none; b=J3f611EDfDaR0WyhjQKfdskbEE+WCAFI5jxel2G63b4pRj8gG6dyQSJM9BadCKSezJ6ZG9PyAu+8ofTL/8qGVcYV6p1ROCHfLpMMhJ3Od22PAz2YClgnTIaoc0ipkN3ReNgLVgv0Wk/vGs4QEytN80zZrvpvVEs6jl9xUI0HFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765246438; c=relaxed/simple;
	bh=lWTxSZp7AX84ePfJ3i3tNaFNWC5RhSdcWlu6gfS3M8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKnclVo8cv9iu42F+gzXsPGKk5GnsO53cylZsNiuMileUgw6FODxBFyVWH7IT2u0ny2PMN5CuempfprJ24PgunlAk+K+4hGWo9ELqpKVl6XFZg6FWT9jS1wemru7BdcUImdg7KZ9OdhkBzJUQkPPiHGWTOjyO4ag9R+Qn7cP8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=WO5EHsAX; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="WO5EHsAX"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78c5b5c1eccso5649757b3.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 18:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765246435; x=1765851235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVudD3i8H8+vahNmmQ0gBI9dMlqbtwoJC6kmTjTqkbM=;
        b=WO5EHsAXtZ0f43bh/4R3sAbFHuqD8Phmt2q7glqHkLhfhrer45NSL6q5J2vWUqc2E6
         r5vUI602ey806szVZpNyCAEMOTpNzcApeBm2ugNLYDytEME1y2FEMqbmq8xdAKBkN6kP
         VfHQ1Rtn48gbCPwxnaQXML+J1ZMF9Oc6yN5fOr9LQ64nU/sHeR2yPZHefF2Ij+yAbU9s
         5kM8qfdJjVPWr6S5cbAXZEv7bRCPXTqsxtScwvJAWBUmA2Zp5H45ZyKl3pTpbXGx9bcH
         VA3xiWur/PQw/WKvn/KQtu3WchrFZC+gxqL+55gNrBELWDhwRxlSx1IVAVierG2Uovfh
         T77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765246435; x=1765851235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVudD3i8H8+vahNmmQ0gBI9dMlqbtwoJC6kmTjTqkbM=;
        b=g6FN0MrKqmN8vg0VYoEoglXsssDhXi+iXVeuWujOmx2e5LAtnMY043S4QRczFIGOya
         1Nv5rpG1dgs0+MyJPn+hz2Y/V5lenf4p+3OOr+5JAkew9I9/wHzCEPz4EWjoTETIV6c6
         iwHf8x7Ij8MSjCotMBDvoDX3qUugY5S6lqKB0Zdwev5ZcrZCgUmqjB0FCrFHUrDDyVvP
         BKSW3MhpmC8ITXlEvBd+efmISf/K4eZ56cs5un6rwyo5sqmAl6igdwUt8yfTSAmKhn+0
         qjz2c3qaPH4vH3e3YzU96Aw46JiHazZ+Lp3BWqGO3JOw6+AspWfDIk9FrH3sRz7yv1kF
         A9ag==
X-Gm-Message-State: AOJu0YyNi9u4vS4pu/72Yezk7vwx0I/bSod6co/NkwuvfndnmKAgZ4ND
	wZE3jhzB7/DmFt48VKlORmJNpfuHKBkLwXVmgFayLxzaC94aokaxAtMz0oG9SbYiBEI=
X-Gm-Gg: ASbGncsrR42o63eIdRPnHhnmLSmBihIZBjFpYFtahpo9xP9yQVSwC3BfKNQwx67BG4+
	OkUfGXiLku0T3vroh0VbUQ7ygYH0hxWF+4IqvoFUb/s+BkubyXBuAOfPKraFD23q/k75krlDPze
	sAXyHZPinbLhFRZTGnOIx5DqAW0O6AHuwsBk+hI4ZN7hn/+BsbBxEGaYEwxMLioCiEFfPMlQczM
	fj6TorHp6U2A1/KocGYbLvaDDFST3qbvYdHI7BsYuFlx5WziL4GsYy83Ls80xySc/dqQhrgA5Xk
	ZAFV0x6YSXKusNaznPz+bvHC6CymkShl0JntEUrEI4MFkRVljdSCtNZ0lLQcDN+YY04Bk+hV0kP
	cCQEyalDFVbHtjk/fGJyJFxf5jU3m5/mqAb1ea2Sx7wYahjUg8O6AAkkhFUju54ESffs9StkdMv
	ZRTiBUrSK/utOMtfa19yAf5TG8P5cHnmoB1VUKpZvClv+4MyIx8WmMRi5/QJK6rxg+F207PbaBv
	Z+DNaD95zUp4p+mIg==
X-Google-Smtp-Source: AGHT+IGdMIIKeJXvMhMsaICrLBZwzQ1d/eMpK1e9gsi+CCFmJdbz4wt8Gbl6lkWtWM/q2oppYglNyg==
X-Received: by 2002:a05:690c:e3ee:b0:786:5d0a:c273 with SMTP id 00721157ae682-78c5a952fd1mr13561687b3.23.1765246435538;
        Mon, 08 Dec 2025 18:13:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c3a6d889esm29422067b3.25.2025.12.08.18.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 18:13:55 -0800 (PST)
Date: Mon, 8 Dec 2025 21:13:54 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/17] git-compat-util.h: introduce `u32_add()`
Message-ID: <aTeF4rn6h1gc6Kgl@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <776eb88905f53dd929e5b7cb23593976a2f1aad3.1765053054.git.me@ttaylorr.com>
 <aTcYdebOuUfrAAJJ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTcYdebOuUfrAAJJ@pks.im>

On Mon, Dec 08, 2025 at 07:27:01PM +0100, Patrick Steinhardt wrote:
> On Sat, Dec 06, 2025 at 03:31:28PM -0500, Taylor Blau wrote:
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 398e0fac4fa..a7aa5f05fc9 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -670,6 +670,14 @@ static inline int cast_size_t_to_int(size_t a)
> >  	return (int)a;
> >  }
> >
> > +static inline uint32_t u32_add(uint32_t a, uint32_t b)
> > +{
> > +	if (unsigned_add_overflows(a, b))
> > +		die("uint32_t overflow: %"PRIuMAX" + %"PRIuMAX,
> > +		    (uintmax_t)a, (uintmax_t)b);
> > +	return a + b;
> > +}
>
> We already use PRIu32 in our codebase, so why is the cast necessary?

I don't think it is; we could easily write this as:

    die("uint32_t overflow: %"PRIu32" + %"PRIu32, a, b);

instead, but this matches the convention of other similar functions in
the compat-util header.

(It's possible that there is some reasoning here that using PRIuMAX
really *is* necessary, but it isn't clear to me that's the case.)

Thanks,
Taylor

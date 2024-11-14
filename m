Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D51CABA
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591617; cv=none; b=JKyz8+OLyPb1gk1kAMSR0be0rQ9zs8tNV4iRPD+r6iFYVjgjfmFRZlbBlPnTOC08dQBIJx2wP9ycWMNx2ZmpHs2/vyck2TaHpL35ieg7vLlWtT7qiXFqTyMD2/g+dI1XJvOLVC+6qzKREq0E24//0PkJehI+tNVdTQrEKhtEMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591617; c=relaxed/simple;
	bh=iE1GpTPQSwu2zOO1OlMAZ/2RPBapnTpWjmvRd5fxFCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqL5ZXNHP34xL8X4myGs2e3+88549vB9ynRLBVKc3ZhTka8o0dx+TfcJykZQ1ST/A8mKGppVa3WvGJHOmBTrQSNV+wXgy+Ck+61t398OaZOAFpDIxQ/SCzdDbyJCMdbZmnWnsfPRJLsVcSPDcxZ9DE+Xu/gSAUoHPuZIhwETUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=b5mT5I7Q; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="b5mT5I7Q"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e38ebcc0abso7269457b3.2
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 05:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1731591615; x=1732196415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iE1GpTPQSwu2zOO1OlMAZ/2RPBapnTpWjmvRd5fxFCM=;
        b=b5mT5I7QftgeEVZ7I5SyLE7mx0v7zc3MnBcSXjyccyNYMqhp6ljwNBeE12zRFwTWMM
         5Yt6ssqNxk9DAcZUX8fPoP7E0zPKzwKzOGcH1rx/HRGvbC8G1lnN/xJ8EHaEwdGLdsA+
         sUmiFIyydc3jYSv8qvx2M3O6/BiMlQS2FllI7QrB43ffgdDGjVld5wa19JlD1FenabRC
         XeuY1H2TApHNYy5+GWZTSjteebhu1y3kR+9zjYuKRAaVhTK3qydSx9LKHxP+h/bm9g/+
         sQ1wav8MVNfY3w+v8qfh8REGQ5MvDgDY6Rw57DnUy9dJBKd8CenxMw5vCbNKy8A/6Xfb
         xWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731591615; x=1732196415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iE1GpTPQSwu2zOO1OlMAZ/2RPBapnTpWjmvRd5fxFCM=;
        b=urlwoC2vt5BGX49UMARf1XbLWw3cpjdGI8mWlF+SaP0L4PBOT1BtAv6oyLRa6zHDWW
         PY/A5SHAINmHItbWRFoXaNlbE7Ig1S8OaRYg7zCR0+MDjMMd+CxGGC/zRei20FEhC/UI
         Cwm+Xbp3Cwk5SSOqGCn3zwocz3M/AgYpXXuYLTtDVa1h+LfOQpoYJ+Mr/7IXpw8GGR5K
         OIkBTpQvLTX36WDysE3zMW40cN9JxdDrUQCkAKb9tftmLDRRutcXJZP+CeFDO0RybERa
         lZhgq4ZZdcSJQSZwkt+LzY13R0Okige9+16/YlGhY+53UQGstEaRE2dsfdYyr+6FAtGU
         SddQ==
X-Gm-Message-State: AOJu0YynMvNVShw8YZA3CHUr/iRPBq/uxt/QzCglnq2KCEB6nwsURtPe
	8xnZ0htjxCFbOAs1X7aqxSTjdGAStz0tWuZtlgfYZbyKIUhnWh+FbEYv9lXIJUI=
X-Google-Smtp-Source: AGHT+IGy9R9dWXzmtBGY/RI7wIeTwOt0Mwaogx/tqacWbpYmI3RYkvdmHeYEjO0WvjdkpX1qLZdUQA==
X-Received: by 2002:a05:690c:48c8:b0:6e3:2192:e0e6 with SMTP id 00721157ae682-6eaddda2d9fmr261642617b3.14.1731591615030;
        Thu, 14 Nov 2024 05:40:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee444132fdsm2322737b3.81.2024.11.14.05.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 05:40:14 -0800 (PST)
Date: Thu, 14 Nov 2024 08:40:13 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: only perform verbatim reuse on the
 preferred pack
Message-ID: <ZzX9vT4GVqCyfFUE@nand.local>
References: <cover.1731518931.git.me@ttaylorr.com>
 <2520abf24a8a194b3f7040e218f878dc88a740a0.1731518931.git.me@ttaylorr.com>
 <20241114002504.GB1140565@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114002504.GB1140565@coredump.intra.peff.net>

On Wed, Nov 13, 2024 at 07:25:04PM -0500, Jeff King wrote:
> On Wed, Nov 13, 2024 at 12:32:58PM -0500, Taylor Blau wrote:
>
> > Instead, we can only safely perform the whole-word reuse optimization on
> > the preferred pack, where we know with certainty that no gaps exist in
> > that region of the bitmap. We can still reuse objects from non-preferred
> > packs, but we have to inspect them individually in write_reused_pack()
> > to ensure that any gaps that may exist are accounted for.
>
> Yep. With the disclaimer that I'm biased because I helped a little with
> debugging, this change is obviously correct. Forgetting the bug you saw
> in the real world, we know this function cannot work as-is because of
> the potential for those gaps.

Yep, and thanks again for your help ;-).

> > This allows us to simplify the implementation of
> > write_reused_pack_verbatim() back to almost its pre-multi-pack reuse
> > form, since we can now assume that the beginning of the pack appears at
> > the beginning of the bitmap, meaning that we don't have to account for
> > any bits up to the first word boundary (like we had to special case in
> > ca0fd69e37).
> >
> > The only significant changes from the pre-ca0fd69e37 implementation are:
> > [...]
>
> Thanks for this section. My first instinct was to go back and look at
> the diff to the pre-midx version of the function, and this nicely
> explains the hunks I see there.
>
> So this patch looks good to me. I was able to follow your explanation in
> the commit message, but that may not count for much since I'm probably
> the only other person with deep knowledge of the verbatim-reuse code in
> the first place. ;)

Heh.

> I do think the explanation in the message of the first commit would be a
> lot simpler if it were simply combined into this patch. With them split
> you effectively have to explain the problem twice. I don't feel that
> strongly about changing it, though.

I always seem to go back and forth on that. I feel somewhat strongly
that for complicated regression fixes that we should demonstrate the
existing failure mode in a separate commit with a test_expect_failure.
That forces the author to ensure they really understand the bug and can
produce a minimal (or close to it) reproduction.

It also makes it easier to demonstrate that the fix actually does what
it says, instead of assuming that the test fails without the fix applied
(and passes with it applied).

That does force the author to potentially explain the bug twice. In my
experience, I tend to keep the explanation in the first patch relatively
brief, hinting at details that will appear in the subsequent patch
instead of explaining them in full detail.

So I dunno. It's a tradeoff for sure, but I think having an explicit
point in the log that demonstrates the existing bug is valuable.

Thanks,
Taylor

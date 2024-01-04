Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEDC2CCAD
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 22:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="CfELsh8z"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbd6e37a9bso668048b6e.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 14:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704407088; x=1705011888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZE4vewcVwZ5tyo9iXMSjGUvPfI5Iap9otn+Fe+gIW2k=;
        b=CfELsh8z84ybEpdteENxYXWCoaWbAOVhPXpAZLA84yihOhBlw7rJrMWjohaGAUjc4e
         qxXzhXz0Dk/+fSI+b5WHvUO9rDrOnsYlQeUgNZl1FDLuNd37xgwhfqmjImp1TIWnAyr8
         XxXH4IaOFXp/wVEP2rrU9Erv4NEYV7e4AEVxFf28n77EZEHQHZ+qEX/EOx0wDXkr8be6
         vGENQtTv2FTrh9iqhXIXowzLkrFdSaNpoV0DNCUUI5UXUtVLHy/VSZiOjhlw2/Sx8eU6
         zQUElEn05iivJf5qqjV62ltgihqeFNIck1DFxE5Ojyrqhf4vhAcLMFqmpEg8D9bC2XvK
         nyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704407088; x=1705011888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE4vewcVwZ5tyo9iXMSjGUvPfI5Iap9otn+Fe+gIW2k=;
        b=rFHfBSOu6FXTjGqKuRh6WlsUIu1Gmg6xol2kHFLjveskUaq6VntnoNApWG9ZYeiTws
         pINMb6XUWSu9gy1ELkPA0UgA297iO15WIC78emC6cI1mbfaej+V791K0wvD7xVZN96O8
         CzPrCN9D/srajkjx+uF/J2P3JYlrVRZeBNeA3qvhFxKPOeiQlLV37nkEAUl5hMxkzbei
         gsWMhz11o1lBdEK4wLg0ys5QW4HPeOgbS5DkV8iL3W8gUWlK2LO+9jmJEX50LjXzy2yA
         xjA0L5f7peFyfOqbqkb2r0vjAffLMSHK6F00pxPArDuY2NvTwH2mhvSXTV9/EwmkgGdr
         gLzw==
X-Gm-Message-State: AOJu0YxTQKtbcujzkKLAKItNI4zWgQE8EGL8IiZktqCzE2pl/N1BevM4
	4O0EL1y2Mw9RtOPvi0EyDDlb07G6SLIzs6hNJf2n+69W8TV2OA==
X-Google-Smtp-Source: AGHT+IG/iJDhGXSkdkb5GHAxVdSj4osyGKI4AoZB4uORzgVy1MuNmuYCZNtzmM8xJmw5qUE9qAu88w==
X-Received: by 2002:a05:6808:171c:b0:3bb:9b28:96c9 with SMTP id bc28-20020a056808171c00b003bb9b2896c9mr1279909oib.86.1704407087889;
        Thu, 04 Jan 2024 14:24:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f16-20020a0cf3d0000000b0067fa3a7770csm129082qvm.82.2024.01.04.14.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 14:24:47 -0800 (PST)
Date: Thu, 4 Jan 2024 17:24:46 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 00/26] pack-objects: multi-pack verbatim reuse
Message-ID: <ZZcwLu8TO7Cxs6TZ@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
 <xmqqbkasnxba.fsf@gitster.g>
 <xmqq7clgnvqv.fsf@gitster.g>
 <ZXurD1NTZ4TAs7WZ@nand.local>
 <20231221105124.GD570888@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231221105124.GD570888@coredump.intra.peff.net>

On Thu, Dec 21, 2023 at 05:51:24AM -0500, Jeff King wrote:
> I suspect this is a race in LSan caused by a thread calling exit() while
> other threads are spawning. Here's my theory.
>
> When a thread is spawned, LSan needs to know where its stack is (so it
> can look for points to reachable memory). It calls pthread_getattr_np(),
> which gets an attributes object that must be cleaned up with
> pthread_attr_destroy(). Presumably it does this shortly after. But
> there's a race window where that attr object is allocated and we haven't
> yet set up the new thread's info. If another thread calls exit() then,
> LSan will run but its book-keeping will be in an inconsistent state.

Thanks for digging. I agree with your theory, and am annoyed with how
clever it is ;-).

> So it's a pretty easy fix, though I don't love it in general. Every
> place that spawns multiple threads that can die() would need the same
> treatment. And this isn't a "real" leak in any reasonable sense; it only
> happens because we're exiting the program directly, at which point all
> of the memory is returned to the OS anyway. So I hate changing
> production code to satisfy a leak-checking false positive.
>
> OTOH, dealing with false positives is annoying for humans, and the
> run-time cost should be negligible. We can work around this one, and
> avoid making the same change in other spots unless somebody sees a racy
> failure in practice.

Yeah... I share your thoughts here as well. It's kind of gross that we
have to touch production code purely to appease the leak checker, but I
think that the trade-off is worth it since:

  - the false positives are annoying to diagnose (as you said, and as
    evidenced by the time that you, Junio, and myself have sunk into
    discussing this ;-)).

  - the run-time cost is negligible.

So I think that this is a good change to make, and I'm happy to see it
go through. I don't think we should necessarily try too hard to find all
spots that might benefit from a similar change, and instead just apply
the same treatment if/when we notice false positives in CI.

Thanks,
Taylor

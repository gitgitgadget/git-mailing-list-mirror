Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5298BC433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 02:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbiBSC5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 21:57:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbiBSC5q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 21:57:46 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C94A24092
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 18:57:28 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id p7so18438083qvk.11
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 18:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Jo6BG6/b03N1saTlZ0A2a3TJSvZE8IH4vp/x53NOTE8=;
        b=sVV7AbToVaYUzYapj3Eu6ASIUwon8nttWiNbZkcKx+7gk7ZIRvq2cv72wRyV582VSP
         yV33WTbg4ldYoTNdxRLwHP3pgGaybM+77ntJWfiJUi0eHPVmjVhHff/Su+xESAOZ4cRV
         Xect/2uaxiYxYIH+6Zt5Flyrff+10bIKokwPI1NsbmZFwxg93ZRJs2oY46lhveKSlFta
         W/iFkM+MITvXtHr9lQDMA1s31w+RKauhP3ZvHMC2RaVh6x8dPnOiGBmz9x5/jyihVcSb
         y0L5WrgqTLdU9oyOJCEwxCvMKRmO1i2Qh4kvR2xyQjmzx5YD/dSn+PB+nFf+XdsioE/q
         3RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Jo6BG6/b03N1saTlZ0A2a3TJSvZE8IH4vp/x53NOTE8=;
        b=7ozNnDnm6w1seXmihNHIhCEJ7M8shP5Oq2hLsIPW6jNHqvyZFwlcW/DCMDHKaQNEf0
         3Knbk/Rf3ezKRlXoNw1QdNQbesmrF/qA66c6YOpUS6k01AsC1KYjWQIbgqwLiavSU0F8
         T/F6+jCuddysCutSpI92YrAx6IkLIoSPX6SN8yh2uYU8y1mv1k8Z4IBBDF5vRu4Dxx/k
         mBOZQaU/QAIXXvIcoR0YKZmGtzEFaxMWOFdYGpZW4RsbUvjBhHT0Z/nXbCoqy2nRin/T
         QmN4uzpMu35aFqd7U9gN+xRDEYzWS6PTP3cUEN/misljqhCgkH+AglNwQWcMo1fdVbEn
         xzPg==
X-Gm-Message-State: AOAM5303tm5dLGH7Hkpdtyk7nBL7Ei2t0ZQlBVYS9o1+pIyhLzw6lxjS
        eQPEeQq9ZgTx31XIbX6dLc/8dg==
X-Google-Smtp-Source: ABdhPJxO4D7YW+IYRpzcm7Gtp+7K3XRo39K3+TmT0gD1lCTz+h3QUERCNXcLY3IKlKQU9r2rjg+Neg==
X-Received: by 2002:a05:622a:14ce:b0:2dc:8d9f:61c7 with SMTP id u14-20020a05622a14ce00b002dc8d9f61c7mr9204617qtx.631.1645239447554;
        Fri, 18 Feb 2022 18:57:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j19sm20347020qkp.120.2022.02.18.18.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 18:57:27 -0800 (PST)
Date:   Fri, 18 Feb 2022 21:57:26 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/4] test-lib: add XSAN_OPTIONS, inherit [AL]SAN_OPTIONS
Message-ID: <YhBclvZUYcsTabye@nand.local>
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
 <patch-1.4-75c8f7a719c-20220218T205753Z-avarab@gmail.com>
 <xmqqley7yd6e.fsf@gitster.g>
 <YhBY8oD/xJZUQsj9@nand.local>
 <220219.86ley7fu3k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220219.86ley7fu3k.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 19, 2022 at 03:48:42AM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> > +}
> >> > +
> >> > +# If [AL]SAN is in effect we want to abort so that we notice problems.
> >> > +prepend_var XSAN_OPTIONS : abort_on_error=1
> >>
> >> XSAN_OPTIONS stands for "options that are common to all ?SAN", I
> >> guess.
> >
> > I was also unclear on this. Looking around in the google/sanitizers
> > repository, I don't see something called "XSAN_OPTIONS" mentioned
> > anywhere (neither in documentation nor in the actual source code).
> >
> > Is this a convenience variable that we use to store options that are
> > common to both ASAN_OPTIONS and LSAN_OPTIONS? If so, I am not sure the
> > extra confusion is worth it, since it only contains abort_on_error=1.
> >
> > I guess it makes it (along with the prepend_var function introduced by
> > this patch) possible for a caller to write XSAN_OPTIONS=... into their
> > environment and then run a test script and have their settings feed into
> > ASAN_OPTIONS and LSAN_OPTIONS. But I don't know that callers would find
> > this super useful (or, at least not dramatically more convenient than
> > setting both variables).
> >
> > I could be wrong, and I'm obviously biased towards my own usage of the
> > ASAN/LSAN builds, but to me this patch might be clearer without the
> > extra variable.
>
> Sorry, yes it's just a git.git invention to refer to "common LSAN and
> ASAN' things. Perhaps GIT_ASAN_AND_ASAN_COMMON or something would be
> much less confusing & better? Bikeshedding most welcome :)

Yeah, I would be fine with something like GIT_ASAN_AND_LSAN_COMMON if it
makes things easier. I think it definitely is clearer, and does make it
easier to add new options to both.

I probably wouldn't ever tweak its value myself, so I don't think I have
a strong opinion here. If it were me, I'd probably just as soon
duplicate setting `abort_on_error=1` in the ASan- and LSan-specific
variables. But I don't have strong feelings here, so whatever makes the
most sense to you is fine with me.

Thanks,
Taylor

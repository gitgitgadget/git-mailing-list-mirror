Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2C0C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 02:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87904611CC
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 02:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhJUCWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 22:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhJUCWn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 22:22:43 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4EFC06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 19:20:26 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id w10so24200843ilc.13
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 19:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pUJZF6ekaPeEcd0g0Dhjf0qZ81gATcmW3Zc6Hoinkgo=;
        b=jikc0WAHXRIpEaEty6jNvvWoC548LSkdWk+JYTk7EN6c5rx2EXzkOzpXEYX51SpD23
         D3mqBIMg6MGZOQE1ZdgpqsQPLs6j64a0i3S+DnxynA10lzTSX8MMzLB82RGmFbJjq/+o
         4LgJi3d42RY/ZXkRfe5rcUz4UWWc0ph6sthcPCSHQg8MG0my16+a+YK5xCNrY1aBZyRa
         lJ5CWxoIZslF4AwcD3A8UbiakGvK0H27Ikplr9Nm9lx8C+8+uQvw1X0yWTq5JE0hRg3+
         6Ojh7UNu07PVKSp6fI5T6GVtreN69nrHRw6jWW92ROctTDhjsQljXnne5kyvSr0Lizqi
         0HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pUJZF6ekaPeEcd0g0Dhjf0qZ81gATcmW3Zc6Hoinkgo=;
        b=lBuhKHAIbFDw8nn5jG8rATccFF+2Ohad6VKcQgVxD4OC9oVVZ8cW8lK4m63anNNuU3
         K7zo1ouE8M/0pSQJbpQYGvAvxfNKgu26HigBelhupPW0xxqHrJHqPIL+SR164FcVfUxU
         TIhdE7VT8TosUxrkAvgKsZqeH6VaqHDf4FjsZkCl6s4QxRFNg1kF2XX/5hVWb8SBcUGo
         RC+ciCjIcRLNQ7V8pFJ6vF374+zfn/5xFbxNud0rSa7fxNAkUVzPkVLT80+g0zlFGgaU
         YHp8VP16vsG0MNXkHW7pxJhnFrImkwv1Nvw9s80c2lnWnWsC4WArzX73GaRAnMSZ+iwZ
         XOVA==
X-Gm-Message-State: AOAM530oFahJ2pYwnIJngoOxg7I3EWgOs/8/0GFQZn8HHGhZ4R72RoMs
        c2ZhecQJKv8NkRHIRPGF6xEYqgwRZ6r6tw==
X-Google-Smtp-Source: ABdhPJyqzWVpiQpJabFyoKAyWpDeArBZwRfM5bLZEtWorPCjI/z4dpqHs5zzB10paQAj5VzXTfMoGQ==
X-Received: by 2002:a05:6e02:152b:: with SMTP id i11mr1822747ilu.166.1634782825256;
        Wed, 20 Oct 2021 19:20:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f13sm2112527ilu.82.2021.10.20.19.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 19:20:24 -0700 (PDT)
Date:   Wed, 20 Oct 2021 22:20:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
Message-ID: <YXDOaNsu8CaytBbr@nand.local>
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
 <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <YXB9moNHRj+nrnX9@coredump.intra.peff.net>
 <YXCKqAEwtwFozWk6@nand.local>
 <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
 <YXCqO7WFET6J7gGf@coredump.intra.peff.net>
 <211021.86ilxrmbb9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211021.86ilxrmbb9.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 02:48:24AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> Per Eric's Sunshine's upthread comments an awk and Perl implementation
> >> were both considered before[1].
> >
> > Ah sorry, I thought it was just a perl one that had been the
> > show-stopper. I hadn't noticed the awk one. However, the point of my
> > patch was to use perl if available, and fall back otherwise. Maybe
> > that's too ugly, but it does address the concern with Eric's
> > implementation.
>
> I think carrying two implementations is worse than just having the one
> slightly slower one.

I have no opinion on whether or not assuming that awk or Perl exists and
can be relied upon during the build is reasonable or not. It seems like
the former might be a slightly safer assumption than the latter, but in
all honesty it seems like both are always likely to be around.

In any case, I think the point was that we could improve upon Peff's
patch by just having a single implementation done in awk. And when I
wrote that I definitely was in the mindset of being able to rely on awk
during compilation.

> >> I.e. I think if you e.g. touch Documentation/git-a*.txt with this series
> >> with/without this awk version the difference in runtime is within the
> >> error bars. I.e. making the loop faster isn't necessary. It's better to
> >> get to a point where make can save you from doing all/most of the work
> >> by checking modification times, rather than making an O(n) loop faster.
> >
> > FWIW, I don't agree with this paragraph at all. Parallelizing or reusing
> > partial results is IMHO inferior to just making things faster.
>
> I agree with you in the general case, but for something that's consumed
> by a make dependency graph I find it easier to debug things if
> e.g. changing git-add.txt results in a change to git-add.gen, which is
> then cat'd together.
>
> IOW if we had a sufficiently fast C compiler I think I'd still prefer
> make's existing rules over some equivalent of:
>
>     cat *.c | super-fast-cc
>
> Since similar to how the *.sp files depend on the the *.o files now,
> declaring the dependency graph allows you to easily add more built
> things.

This seems like an unfair comparison to me. I might be more sympathetic
if we were generating a more complicated artifact by running
generate-cmdlist.sh, but its inputs and outputs seem very well defined
(and non-complicated) to me.

In any case, I agree with Peff that this isn't the approach that I would
have taken. But I also think that *just* parallelizing isn't necessarily
a win here. There are two reasons I think that:

  - The cognitive load required to parallelize this process is
    complicated; the .build directory seems like another thing to keep
    track of, and it's not clear to me what updates it, or what the
    result of touching some file in that directory is.

  - But even if the parallelization was achievable by more
    straightforward means, you still have to do the slow thing when
    you're rebuilding from scratch. So this is strictly worse the first
    time you are compiling, at least on machines with fewer cores.

In any case, this is all overkill in my mind for what we are talking
about. I agree that 'cat *.c | super-fast-cc' is worse than a competent
Makefile that knows what to build and when. But the problem here is a
slow loop in shell that is easily made much faster by implementing it
in a language that can execute the whole loop in a single process.

Thanks,
Taylor

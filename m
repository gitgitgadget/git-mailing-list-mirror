Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9DEC07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27DD56113A
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhGTVHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 17:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhGTVHB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 17:07:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE2DC061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:47:38 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id x10so121907ion.9
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PZuUXSzXWw7C57+zueaLsdXxRbYM112gvfd9USuealg=;
        b=UDQQIYld+5WsMYLghHyvo55ZyqOtplMDlk4f2znlsWQs1sLEOYPeTrtzOVfc7awmTF
         E341z98LyiasTm7KnOM0rg0XTg+1vOV8HY6LXJWOUqPyd/n0F2d6nUy6oif/wo48qKzR
         H1azEO3iV5zMj8QvfRsSOas8yBbUQaoiMO2UJDZw4PY7eX4YdhukQK5UYIisYSPXoSJF
         mSKIeo/DiLBr0f2UK2G4lionoZbHxvR/HejnYM7sgPCa8V7HlYDhDFP6SH1rq0RvKqB0
         LUQDghf9iDbBNIy0264R0XsZ+U1oJiGrP/gFxYMMTrn1rCtoJGzE/ANjguAnccsslB4l
         btvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PZuUXSzXWw7C57+zueaLsdXxRbYM112gvfd9USuealg=;
        b=iOFAc56hwv0Rsf97FATK8J2i5uBdGvBuuEgLS1K40uypP2U3EwaNGtrtfrbMcSCDoa
         lZiAfbZDz/n9hboz+YJSGYM4Ygxp6h9Ijkf3uI3BeXSRLvK5rS2CogHS/D0LDdwpewOi
         rqc2IQIVCMujostUI9yj+PDGWGmn1whNAY6sV2JWRABcYC7DuEjagrzVP46qfkfZmFdk
         7VeJM3c8FDhD5NHhZg+6DOZ9MLaWGP/MpLEHcfS2GJk9Grgs0DUcaGa2trsQ6VxA1Xj4
         mrqM6fJ+7/letRRaLY8YyjoXIXGpuAFwt3fCLvk69tPJv6gGOoOASsVEuHn1ny6f2gpj
         20mQ==
X-Gm-Message-State: AOAM533PfiV1qH9K6PN9LSt2tGQ4vd7kpO83UUx+7TqxZsT++u4rqjQ0
        jA6ylbKjW9O8WZ2vTQhRRKbTCw==
X-Google-Smtp-Source: ABdhPJx0E5/cdyv8wGkW+8X6xaqr2PedyS5hpw0jpyQSAcpS1OOvhrNHpugSPJinUugHOfYvEpNlGA==
X-Received: by 2002:a5d:818d:: with SMTP id u13mr4643702ion.92.1626817657807;
        Tue, 20 Jul 2021 14:47:37 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:9f71:89c7:e095:b8eb])
        by smtp.gmail.com with ESMTPSA id m12sm11817865iln.43.2021.07.20.14.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 14:47:37 -0700 (PDT)
Date:   Tue, 20 Jul 2021 17:47:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 6/6] commit-graph: show usage on "commit-graph
 [write|verify] garbage"
Message-ID: <YPdEeBGi3RVrB/fu@nand.local>
References: <cover-0.5-00000000000-20210718T074936Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
 <patch-6.6-5c1694e071e-20210720T113707Z-avarab@gmail.com>
 <20210720174739.GA2025@szeder.dev>
 <20210720175530.GA23408@szeder.dev>
 <YPcU3LSpa/r5nFCP@nand.local>
 <87lf60vfyn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lf60vfyn.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 11:17:13PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > So we should definitely fix this instance via a reroll of this series,
> > but that still leaves the others up for grabs. Ævar, are those (the ones
> > in the 'multi-pack-index' and 'env--helper' builtins) something that you
> > want to clean up while you're working in this area, or would you rather
> > that I take care of it?
> >
> > I don't mind either way, just want to make sure that we don't duplicate
> > effort.
>
> I'm all for you picking it up :)
>
> If you wanted to pick up these patches (or some of them) and
> partially/entirely replace this series I'd be happy with that too,
> i.e. if it makes conflicts etc. easier.

I think either is fine; there shouldn't be any conflicts in the
multi-pack-index code just eyeballing based on what you wrote.

I started working on it (which I suppose can count for me volunteering
to patch it up myself ;-)), but I wondered why we have env--helper at
all. When you wrote it back in b4f207f339 (env--helper: new undocumented
builtin wrapping git_env_*(), 2019-06-21), you said that it wasn't added
as a test-tool because it had some uses outside of tests.

But I can't find any locations. We do use env--helper (via
test_bool_env, which you also introduced) in a couple of t/lib-*.sh
files, but this would be far from the first test-tool that has been used
in a test library.

So ISTM that this could be converted to a test-tool and removed from the
list of builtins. *And* we could do that without a deprecation warning,
because it was never documented in the first place.

Can you double check my thinking and/or let me know if there is a
compelling reason to keep it as a builtin?

> I just re-submitted this now because it's been staring at me in my
> "should re-roll at somep point" list for a while...
>
> FWIW if you're poking at this area more generally we really could do
> with some standardization around these built-in sub-commands:
>
>     git built-in --here subcommand
>     git built-in subcommand --or-here

That's probably a step too far for this loose end for me, so if you want
to work on that please be my guest, but I probably don't have time for
it in the near future.

Thanks,
Taylor

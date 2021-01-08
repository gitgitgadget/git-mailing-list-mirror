Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B52C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 21:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D7223A9D
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 21:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbhAHV4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 16:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbhAHV4f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 16:56:35 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A05BC061574
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 13:55:53 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n4so11214881iow.12
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 13:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c/U4oiFwPh9ah5nE0Mjegn1Dtw4I7rPeyBdD8Ft6mio=;
        b=GcPJE1SDMwKfb3P6sXw74z4UQTBVWxk4/J66++LUN0FmajiJQBtAZPpH/yQvgb9bk1
         VmCmhnmTHRz7qiw1MdbhoB5QDZV7/F+jVfm5f5KoNKQhBPVEg7603JtuwZflOr2BVnqB
         k4je4DA9/ObWfTqdPGUjXJwD8YRlYJM7odrUkHOWCVjYfdmuplneCe01ao6+Xl+PvTrQ
         bGEdMF4aH0xbnUNNRyO7VkbOF9b+/JYIPytMobEiDXhDghJaPaXBP/Cs4B1UDORkpDmw
         zs4RhWEQm/JcMgzJB40wLzlXFw2tw0SJNo1TC22afsd9+apETRuWTCU9qUoO8tGQyCf9
         VflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c/U4oiFwPh9ah5nE0Mjegn1Dtw4I7rPeyBdD8Ft6mio=;
        b=kCPEciOGbmIrp5mMZvrdciLyc1RFzLeugi0/lKVG7blBgxCW8dxPuZMdrB8cOZJv5V
         ROh/sc4MJ+syuOw4vuxVb0eiuRxy3svzkgKFkYHyKCSxKxJoEX8ePkGFx9wph+o7MXj+
         4gbDsLSEgfOMo9+U9sN+J7yiaPwjgUf2pn9ZQNoKE1fd6adVhsUIMX24Kco8WKrRo8AT
         zO/ioPEz5R6pRgF42ycLW51H+JAutTjHKM2ZGEysdX0hVPDRdrjFaN2M+kYlLkdL9Bti
         SLT2MzQi7CWt5/6B0bdSlHXDFiVgNpn8thigohfIlm2KDyzm82wICd8ho2po1V+YeJMO
         TciA==
X-Gm-Message-State: AOAM532OPE9WkcQiOwYuLpCCsqETAvll3xW0t3+pPSHmR6i0nJX7c26M
        sGQg8VeT+NET6BtqY0fcTVJU9g==
X-Google-Smtp-Source: ABdhPJyrRxyBAC8OMMEgz1EMn5BYuDgJG7O9vDLRaspgJP+SoecYUsWsYibIVqbEtUEhl+3mpEtMOg==
X-Received: by 2002:a6b:f90f:: with SMTP id j15mr6963571iog.89.1610142952833;
        Fri, 08 Jan 2021 13:55:52 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id 1sm8281735ilv.37.2021.01.08.13.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 13:55:52 -0800 (PST)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Fri, 8 Jan 2021 16:55:49 -0500
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] merge-ort: begin performance work; instrument with
 trace2_region_* calls
Message-ID: <X/jUykDe8hfPDqv4@nand.local>
References: <20210108205111.2197944-1-newren@gmail.com>
 <20210108205111.2197944-2-newren@gmail.com>
 <X/jHpZlSxwAxoUyq@nand.local>
 <CABPp-BE4zyGa7=dOKifWhv-46__0YtfRZ39Q1JYT0JZ2HT0itA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BE4zyGa7=dOKifWhv-46__0YtfRZ39Q1JYT0JZ2HT0itA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 01:50:34PM -0800, Elijah Newren wrote:
> On Fri, Jan 8, 2021 at 12:59 PM Taylor Blau <ttaylorr@github.com> wrote:
> >
> > On Fri, Jan 08, 2021 at 12:51:11PM -0800, Elijah Newren wrote:
> > > Overall timings, using hyperfine (1 warmup run, 3 runs for mega-renames,
> > > 10 runs for the other two cases):
> >
> > Ah, I love hyperfine. In case you don't already have this in your
> > arsenal, the following `--prepare` step is useful for measuring
> > cold-cache performance:
> >
> >     --prepare='sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'
>
> /proc/sys/vm/drop_caches is definitely useful for cold-cache
> measurements and I've used it in other projects for that purpose.  I
> think cold-cache testing makes sense for various I/O intensive areas
> such as object lookup, but I ignored it here as I felt the merge code
> is really about algorithmic performance.

Yes, I agree that the interesting thing here is algorithmic performance
moreso than I/O.

> So, I instead went the other direction and ensured warm-cache testing
> by using a warmup run, in order to ensure that I wasn't putting one of
> the tests at an unfair disadvantage.

I often use it for both. Combining that `--prepare` step with at least
one `--warmup` invocation is useful to make sure that your I/O cache is
warmed only with the things it might want to read during your timing
tests. (Probably one `--warmup` without dumping the cache is fine, since
you will likely end up evicting things out of your cache that you don't
care about, but I digress..)

Thanks,
Taylor

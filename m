Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7166C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 18:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95FE22DFA
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 18:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392944AbhALSSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 13:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392936AbhALSSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 13:18:42 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C7DC061786
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 10:18:02 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id r9so2178704qtp.11
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kHjhqjBZDdosos08hwPlZTXlcLhSKaneEKKMsjGxXwQ=;
        b=Vl56cu2DTM95B+Qm75RC2Lcmr85VyfTZabovpBz39XcH4Ef3F1Lf0XTur9Zc+0mpLH
         E0QSf57gVcb+gij4JBpI4K0ZAi+F2RgJa/7zpqxEm8+FMSfKkqsxxHDJkd9tyQqmWEaY
         pyOxnf0isBqAV7N45TVgZSISFnH0QCnls3QmMJID/7WRQJD4D+P/HlvAZUmJMzmJD6DR
         x9fK7RiogzyYqToRml93GlMU3QxsQESofsIQTWUvBEd295HOq3CMDALh2tKXEk8fKot2
         9RB2GXVYDratnzquepHcsmgNNQ0OuzBXtq/d2EwFndpdHo6abQkmIRPoVuIk/H9Laf9v
         9+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kHjhqjBZDdosos08hwPlZTXlcLhSKaneEKKMsjGxXwQ=;
        b=r7Isi9BhcKnyUA/zgfCH2Fg5vG+knFRoiBF8HJ7IQwuNcUE1ejjZ9HgV6bNpizhrJ3
         UUwYv+VosSCxfwbaGqK5GLm2Ht2dkfB3pMiLsrticoszJ//4iI8gANdh3ZJi7N58JJEI
         SZkwDXnA6NplgIK1mYsTuFqq4s0MktAcXgx5MdZJB9mGK8vVIiGpg3sOSF2hjDdOAVpL
         67LQ2+i9dmXniie6OxClAIabwDLNfemqq3m2p9RZ2vsZGZ0s43YAfmZ+RJFGhkK21ezz
         c1bvGV1vgbRPJ99eI5e8FeCqYKr3cO/oPUK5prE7KiNcMuAYRorcxRoQqvbmfA/IU0zo
         GQ7A==
X-Gm-Message-State: AOAM532kUvXFrk6q6k8pw08a9CEwUZmjfmnnTup1A+h4i0IIMQRHvPrv
        OSaQPu48zEij3LDMLorLCsZhxQ==
X-Google-Smtp-Source: ABdhPJyoeVk8oszeYDu104KJLvYI8MrUdaJJ05EaBQtHJ6OlCt2RB5MF9mc72LdzATzPoEWVq85h/g==
X-Received: by 2002:ac8:37f4:: with SMTP id e49mr227325qtc.193.1610475481271;
        Tue, 12 Jan 2021 10:18:01 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id b67sm1669297qkc.44.2021.01.12.10.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 10:18:00 -0800 (PST)
Date:   Tue, 12 Jan 2021 13:17:58 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH 7/8] t: support GIT_TEST_WRITE_REV_INDEX
Message-ID: <X/3n1pbZuNOIfmSr@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <3525c4d114c8655953aca44d8effa1652ccc93d3.1610129989.git.me@ttaylorr.com>
 <875z425b17.fsf@evledraar.gmail.com>
 <077f1a42-f37a-c7b4-b05f-fba424ac7f17@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <077f1a42-f37a-c7b4-b05f-fba424ac7f17@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 12:39:37PM -0500, Derrick Stolee wrote:
> On 1/12/2021 12:18 PM, Ævar Arnfjörð Bjarmason wrote:
> >
> > On Fri, Jan 08 2021, Taylor Blau wrote:
> >> -	rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
> >> +	if (git_env_bool(GIT_TEST_WRITE_REV_INDEX, 0))
> >> +		rev_index = 1;
> >> +	else
> >> +		rev_index = !!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV));
> >
> > Why not make an explicit GIT_TEST_WRITE_REV_INDEX=false meaningful? It's
> > also sometimes handy to turn these off in the tests.
> >
> >     rev_index = git_env_bool("GIT_TEST_WRITE_REV_INDEX",
> >     	!!(opts.flags & (WRITE_REV_VERIFY | WRITE_REV)));
>
> This will cause tests that explicitly request a rev-index to fail when
> GIT_TEST_WRITE_REF_INDEX=false. I'm not sure that's a good pattern to
> follow.

I agree that this wouldn't work; the second parameter is the default
value, not a substitute for "false".

It _would_ work currently, since there aren't any tests in this series
that explicitly

    export GIT_TEST_WRITE_REF_INDEX=false

t5325 does 'sane_unset GIT_TEST_WRITE_REV_INDEX', which accomplishes
the same thing without setting a value. If we instead used the export
form, this would break, so I think the implementation is more robust
as-is.

> >> +#define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
> >
> > Micro style nit: FWIW I'm not a fan of this macro->string indirection a
> > few GIT_TEST_* names have had since 859fdc0c3c (commit-graph: define
> > GIT_TEST_COMMIT_GRAPH, 2018-08-29).
> >
> > Most of them just use git_env_bool("GIT_TEST_[...]") which IMO makes it
> > easier to eyeball a "git grep"
>
> In the case of GIT_TEST_COMMIT_GRAPH, there are multiple places that
> check the environment variable, and it is probably best to have the
> strings consistent through a macro.
>
> For something like GIT_TEST_WRITE_REV_INDEX, this macro is less
> important because it is checked only once.

FWIW, I'm not a huge fan of the indirection either, but I think that its
use here is warranted, since it is checked twice (in index-pack, and
pack-objects).

It _could_ be checked lower in the call stack, but I tried this when
developing this series and it ended up being far messier than what is
presented here. The trickiness is with the extra verification mode
(which ensures that an existing '.rev' file was written correctly), and
having to indicate that at each caller.

> Thanks,
> -Stolee

Thanks,
Taylor

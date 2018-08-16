Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E581F404
	for <e@80x24.org>; Thu, 16 Aug 2018 02:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387858AbeHPFms (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 01:42:48 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35185 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731184AbeHPFmr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 01:42:47 -0400
Received: by mail-pl0-f68.google.com with SMTP id g1-v6so1338298plo.2
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 19:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8wwN7mLghH5dfgMvd/vUrC+jfqxSiT8Z8FmwtTH62Ak=;
        b=C/MgEkM6pSQnc/H+wwAicp/MdnIV2cfxRjff9bclP4/RWLE8f88tpGbEFkEhQumo/l
         gK1MntCq8TZGaAAlMk6uXsNBsDX+BcrJ49Hv1B/b342IMQvL77WebHiqG06SoXB3Oqad
         ssNEgH1NwCG/CHfwPxgYTtVQiH2w5iV7r+UNNef1dWfwcePCYRpAnpMBiDFmofgTzmuC
         zA23EvV4qDbRTyK12xwNt4RooyCRWx/saigAfFVorfV/uKXNEfg5UfezCTGzZ5I3gvks
         syDeswMvzohicxftt89wvrPytcAGJyUdof+pVzrkKJpV2kZL0fTe2jni1JsIhsF3OiWB
         8iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8wwN7mLghH5dfgMvd/vUrC+jfqxSiT8Z8FmwtTH62Ak=;
        b=DaUlD/eV4XArsLzvcu5tPM/2gf95nLbCa43mlaSOJHn8lsuBZXKmfRQYr1VkYeWcXW
         +cHIoBE9n3dSdu/kY/APIQNNLU2pV1i3QfVBDDF2+SK4Kk45SNlXHrdPzxKMoYzZvepu
         qjCsm2vOJG93AbS0xIRogLMijnxFZyMY8UluQx1pzWeHSqQxqOxR3cZa2yFByQm1GzmC
         M2pFLTYrNHH6AumfonyIftJ0RlkCFGgcL7w6MgiZ4Q40bKYybk+PUfcaTmFgbzMo36Gw
         urlQjbxp3xeVuNWB/HfkLL71RDdg5HaN/MFxPAPiTRwqmowuvbsI8BOpvlAz0zCMIPyk
         gt/g==
X-Gm-Message-State: AOUpUlGR77nkopFMXxzJvkED+7BUdKSL/zqHO9boTiNLf4I9ZguOm4tX
        aKLUhJHUgWgJBfEk1xJGX9E=
X-Google-Smtp-Source: AA+uWPxrVGZgAr05UqODjpH24pt1e0KmuVbSW3GjQo1IST/b76rL5BDWWRjLUEfBrkWn1FjigHViIA==
X-Received: by 2002:a17:902:7c89:: with SMTP id y9-v6mr26862838pll.187.1534387656134;
        Wed, 15 Aug 2018 19:47:36 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i62-v6sm35262611pge.66.2018.08.15.19.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 19:47:35 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:47:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
Message-ID: <20180816024733.GB127655@aiede.svl.corp.google.com>
References: <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com>
 <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com>
 <20180814185743.GE142615@aiede.svl.corp.google.com>
 <CAGZ79kZUq5jPqyb=B1ppEi1QhNGmhLXeV6vPn8ouR=YGEN32pg@mail.gmail.com>
 <20180814211211.GF142615@aiede.svl.corp.google.com>
 <CAGZ79kYfoK9hfXM2-VMAZLPpqBOFQYKtyYuYJb8twzz6Oz5ymQ@mail.gmail.com>
 <20180816023446.GA127655@aiede.svl.corp.google.com>
 <CAGZ79kamoPjX_yWYABLoyTh8jqAPV4iVX0r46q=41B12zku=tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kamoPjX_yWYABLoyTh8jqAPV4iVX0r46q=41B12zku=tg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> Jonathan Nieder wrote:

>> All at the cost of recording a little configuration somewhere.  If we
>> want to decrease the configuration, we can avoid recording it there in
>> the easy cases (e.g. when name == gitdirname).  That's "just" an
>> optimization.
>
> Sounds good, but gerrit for example would not take advantage of such
> optimisation as they have slashes in their submodules. :-(
> I wonder if we can optimize further and keep slashes if there is
> no conflict (as then name == gitdirname, so it can be optimized).

One possibility would be to treat gsub("/", "%2f") as another of the
easy cases.

[...]
>> And then we have the ability later to handle all the edge cases we
>> haven't handled yet today:
>>
>> - sharding when the number of submodules is too large
>> - case-insensitive filesystems
>> - path name length limits
>> - different sets of filesystem-special characters
>>
>> Sane?
>
> I'll keep thinking about it.

Thanks.

> FYI: the reduction in configuration was just sent out.

https://public-inbox.org/git/20180816023100.161626-1-sbeller@google.com/
for those following along.

Ciao,
Jonathan

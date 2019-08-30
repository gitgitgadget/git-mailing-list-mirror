Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C921F461
	for <e@80x24.org>; Fri, 30 Aug 2019 16:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfH3Q4x (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 12:56:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40065 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfH3Q4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 12:56:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id f10so6735748qkg.7
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9Rmldi4N+BAbN4KL91DR7tsx+DR4dKZjz4N28QNoIpk=;
        b=tz/KeWfK8HovN/cREtHmc6AlLdQXBbOMcMZZ69nxPtpZZ3cyKFv+vFNM5eIE43Nnkr
         n0OJv8CPEkvLxvABN6eHVIeINo9CuTpS56Luaz+WDOTMDcolsA8Ra3z0NFlF0rn3eOln
         UmLEoHvImBzhO2E2d8sFBslFXr+wHphF/WfAE4XA/RwlOtuf3EnENevy0KEKpxbRmWYk
         QrwbpMspjvwkRfLEaPEimEMqUQvVRfqyJmdc6G+akh0alQ226bhtujs6skZaeSj2aoXg
         YnYcVGGYGJWYs2gbEEROEqh3uO95VdrDLyIyCI+OkC5+PNwQIRDws3km1N5+xfcSjEp2
         H31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Rmldi4N+BAbN4KL91DR7tsx+DR4dKZjz4N28QNoIpk=;
        b=Cf6Fy76DvAgyyObvU5mtJodul4k/jnTRSGAt4iMZoMiFPmo9nMbGUX4IW6oCTNWrd2
         7+rY3IWaZWmjad0P13v5tr3vkyA1z3BY1qrOnXzwJfbP4cDYWwYD5vdsieAccuK+Ypvf
         SSsiQXPBZ5E5jKPH2GVIzdqFCaKH0KMHujJ4Z4XYv0NKIYAS4JyLr+NGf5rPWklfMMps
         4JuO3DGGBDJoD2xpNUgt6DWs2K/1hipg7sPK+VgrKFNDsRrr2ifKhO5EOj3OBdca51iM
         gpsAexAsJberLaxd4eXI9aohxoXifjJZBzq68iYiBdpcku7hxc9YQT3x0L3THpHH+Yo6
         qpxg==
X-Gm-Message-State: APjAAAWdrpACD8TBG4MvzBdSFj6B14MWSZhr2v8rwo8ZP0mAXMRnoYWy
        /UKhuMikbKUT2aAFqQK03Ig=
X-Google-Smtp-Source: APXvYqxpBlwpQbJ7/T9ny2VNjnRA8k/c2L8wgKDgzNttgm4xEv646tzUoluIMt1xadcPNCShGU/fxQ==
X-Received: by 2002:a37:985:: with SMTP id 127mr16055022qkj.43.1567184211529;
        Fri, 30 Aug 2019 09:56:51 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:cd4a:2491:4437:f3ba? ([2001:4898:a800:1010:7e80:2491:4437:f3ba])
        by smtp.gmail.com with ESMTPSA id w34sm97579qth.84.2019.08.30.09.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2019 09:56:50 -0700 (PDT)
Subject: Re: [PATCH 1/1] checkout: add simple check for 'git checkout -b'
To:     Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.325.git.gitgitgadget@gmail.com>
 <dcf5c60c69d8275a557ffe3d3ae30911d2140162.1567098090.git.gitgitgadget@gmail.com>
 <7e406b35-9ff6-348f-bdee-7540381f000e@gmail.com>
 <206819d0-8066-e8e8-8967-8a1db05eea26@gmail.com>
 <20190829203037.vzxuaxpsghbdc6vl@yadavpratyush.com>
 <20190829214014.vijdotp4g65a5mk3@yadavpratyush.com>
 <CABPp-BF_uBTKT_5YmoMNoToiujuMdQia-OfxOPAJPrhT6jPbdA@mail.gmail.com>
 <20190830004339.GA34082@syl.lan>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8bf76fcf-539c-6fea-170e-61fc81822ef0@gmail.com>
Date:   Fri, 30 Aug 2019 12:56:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190830004339.GA34082@syl.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/29/2019 8:43 PM, Taylor Blau wrote:
> Hi Elijah,
> 
> On Thu, Aug 29, 2019 at 05:19:44PM -0700, Elijah Newren wrote:
>> Personally, although I understand the desire to support any possible
>> cases in general, *this is a performance hack*.  As such, it should be
>> as simple and localized as possible.  I don't think supporting
>> old-style stuck flags (-b$BRANCH) is worth complicating this.  I'm
>> even leery of adding support for --track (do any users of huge repos
>> use -b with --track?  Does anyone at all use --track anymore?  I'm not
>> sure I've ever seen any user use that flag in the last 10 years other
>> than myself.)  Besides, in the *worst* possible case, the command the
>> user specifies works just fine...it just takes a little longer.  My
>> opinion is that Stolee's patch is perfect as-is and should not be
>> generalized at all.
> 
> I wholeheartedly agree with this, and pledge my $.02 towards it as well.
> Now with a combined total of $.04, I think that this patch is ready for
> queueing as-is.

Thanks, both!


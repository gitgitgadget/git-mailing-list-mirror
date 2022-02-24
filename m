Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94314C433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 10:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiBXKOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiBXKOL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 05:14:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268DE1A615C
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:13:42 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c6so2039093edk.12
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 02:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jd/ZbpbgU2gPG19lMZ+JsNxZL45ay9WnB50Fs38Q4vI=;
        b=WbTbhyoG3pX+7NOXJa9gtZsSyOVsHRIVydWrA7AD78W08xCz3l8miYird+62lR5eT+
         pzvcObfME24Jsjela7wT3262R10bpe4nmjQAI11bR1JPrWnkwa0r6IGiTacp5goWs+2C
         57LYRKuPl7rJur7RjBATGmU0C175dWUeL38iXSLtkP2o28f7KDufQout1NvMkWE19SWh
         uCLKklnUEdZotzd61T0Pz3vIaewpMfUQct531SVuq8f2KsVtk/W8fNRduBamb/5LWVZa
         zcdEjtsNgggAp6geXbyUT59KZmjspf0mec3R1lqhTTEWWf0ZDeM1dLSloZQ9mm+HATZY
         x+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jd/ZbpbgU2gPG19lMZ+JsNxZL45ay9WnB50Fs38Q4vI=;
        b=MBTWLg+nEKXaIgSZ7bXDzCWHUdyXKl+u3W9nXRWpTezTjsfA3EA1miws+OHY9ZX8qJ
         Y+0RP0AeTUGlgCjfPVfr+AkLiKNNAxo9WMx+tXc9ybdqqFIKhcN1qM4UNeYFo2w6GTv4
         oyFGOjzKU3vd7UyMm0CAJiRznii48F9GcTvF6rhZkmrab9cTqLfS6pawiRWj6KHzY/T/
         59ypwqEQOFDOsMMmMRydBdD3kNGkRCT97N3j+TH2TExz5dxdhiIG/V6/+JiNNYTzgcdN
         KcyaGDW+SZI022JhF1xX7FLGUSSNmqoVgiO9outfYE3bBbKpY5BmVbsiOqUEPHj2ErM6
         cPWw==
X-Gm-Message-State: AOAM530pDnQaPxBqcBZARZnr1a2V5hiWcHSY3tHaMLKcxUPXD+Sy6frb
        JE5nLbIMosSnTFyvYry3UVnKjAttUddj4oJnyw9Q2Pm8gEHwJ7+yzp8=
X-Google-Smtp-Source: ABdhPJwKvsPJIHzG2YwMTvk3L8rg7CWqnWl+VYhC3KZRX14xEW7FFlfxO8MKZ97CdNm8Ppn8K1xgL2J7KYbgyMO6vnY=
X-Received: by 2002:aa7:c7c4:0:b0:407:52cc:3b32 with SMTP id
 o4-20020aa7c7c4000000b0040752cc3b32mr1572907eds.397.1645697620571; Thu, 24
 Feb 2022 02:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <CAP8UFD2wNSJmiohfAGrihm5sO_q4a6UpLMsVNAF5uWyuWt7R9Q@mail.gmail.com>
 <CAC316V5x54Ah566haa5wZ8zE=gkhYtziC+FVjXoBXn7xY_-WsQ@mail.gmail.com> <CAP8UFD1dfXHYudpT=0e_2DZdmZMKyqKO13EbPozwpZkEYewxNw@mail.gmail.com>
In-Reply-To: <CAP8UFD1dfXHYudpT=0e_2DZdmZMKyqKO13EbPozwpZkEYewxNw@mail.gmail.com>
From:   Shubham Mishra <shivam828787@gmail.com>
Date:   Thu, 24 Feb 2022 15:43:28 +0530
Message-ID: <CAC316V42eP2GEuT+=yvi+Rbdni4KTJzhzUGHgCtcdWkGE9O-Ug@mail.gmail.com>
Subject: Re: [PATCH 0/2] microproject: avoid using pipes in test
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> So, no, we really prefer you to focus on 1 file (or 2 files when they
> are strongly related) and then move on to your application or regular
> patches, reviews, discussions, etc.

I misunderstood this :(. I will not submit any further patches related
to microprojects but I already sentone patch at Morning -
https://lore.kernel.org/git/20220224054720.23996-1-shivam828787@gmail.com.
Can I finish this?.
Thank you for clarifying.

Thanks,
Shubham.

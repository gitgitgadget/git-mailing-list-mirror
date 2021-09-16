Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486B1C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 15:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E5C6120E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 15:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbhIPPtl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 11:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbhIPPtk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 11:49:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF4C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 08:48:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h17so18550632edj.6
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=k+oTmiJUcDFqH69qOYJES0s8qeQ/hlewz6WLWpFYwno=;
        b=kSR1n5tN/OQWRMv9FVN7/UFlWaUWY2MwSYhfLat3Cza/W97vRTYCcfeBrJU1vt5J0t
         gpGHmhjmhUFzlg4bbMK1lGgUcWVVVbcj3UZpWmPRV18Ag83QnNYe8lGcl5O3EIKrssKg
         8gfEv/vUrY/PrZKWYlNHGiqNja/bT6jiuQQmrQunwHNEPI1mGmgpV6W+LU0c/I0aDq9o
         xk1CaU4ZqZteYF7OV6mrClq+qQUamQSZHRtrXWyBBOY8czCybYvns+XS6VulmuxmI5zP
         QngI/3EqHxM9wrCQEJhRryOfpoHx75piHohfxLUCKesIEjUUbGmgGtYwsWs094S2jK27
         3YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=k+oTmiJUcDFqH69qOYJES0s8qeQ/hlewz6WLWpFYwno=;
        b=5YAG9zwcabVVfuq66X8sMAtzzRa+QZdT5yUykN5EnRmr4Pjw+O6I+4JP04X+Mgs+Ln
         l5eWTi8YdTMcjTp3US5deVFzKz1kG7AvSAsw04WqJ31n3TVjB3+KWe3G+x4JqKu3sRiH
         Z7bp75W9IDybMdSTMLZb7WCuMcjkzWBTM+CfCq8Eo1GgBS+iF2mPr/cPrn/fKB4tKjwI
         VA+cwQhTI7q0Sl4bnT9i0vHE2/rh+wNXFenyyhaZdPDmPd+zngvu3u4oCyF4TVmLCNx6
         Pa5oYqGobh5h4Xx6eFchWPo3EfMrTMfZZZtxl8/DCuq+Zls+FgkOwC+YcZxuScejiVjA
         /now==
X-Gm-Message-State: AOAM530y1z9HdLF8mazB51Q8Xc+BGSGNEDQCXA/e93jsnfN/0mNuLRd7
        lSzIj0cAYbsSArSCxkBDmDE=
X-Google-Smtp-Source: ABdhPJxNAkeid6qXlfdmlCAFKc6vxTPnh0hdIzsHABePYQBCck8ex5u4wFXtpxWis9Faj3eBj3r+jg==
X-Received: by 2002:aa7:cb0f:: with SMTP id s15mr7303157edt.190.1631807296981;
        Thu, 16 Sep 2021 08:48:16 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c10sm1303515eje.37.2021.09.16.08.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 08:48:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/7] trace2: fix memory leak of thread name
Date:   Thu, 16 Sep 2021 17:47:57 +0200
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <5f557caee004f22cee33e8753063f0315459d7e1.1631738177.git.gitgitgadget@gmail.com>
 <87fsu5m649.fsf@evledraar.gmail.com> <YULZbQgxuyw8iJ/R@nand.local>
 <87ilz1gd24.fsf@evledraar.gmail.com>
 <285a279f-85c4-06df-04cf-b998e4accbe5@jeffhostetler.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <285a279f-85c4-06df-04cf-b998e4accbe5@jeffhostetler.com>
Message-ID: <87o88sfrnk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 16 2021, Jeff Hostetler wrote:

> On 9/16/21 4:01 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Sep 16 2021, Taylor Blau wrote:
>>=20
>>> On Thu, Sep 16, 2021 at 07:35:59AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>>>> So I think this patch can be dropped from this series, since it's exact
>>>> duplicate of my 48f68715b14 (tr2: stop leaking "thread_name" memory,
>>>> 2021-08-27) in ab/tr2-leaks-and-fixes, currently in "next" and marked
>>>> for a merge with master.
>>>
>>> I agree it can be dropped.
>>>
>>>> When submitting a series that depends on another one it's best to reba=
se
>>>> it on top of it & indicate it as such in the cover letter, Junio can
>>>> queue such a series on top of another one.
>>>>
>>>> In this case I'm still not sure why this fix is here, i.e. surely
>>>> nothing later in the series absolutely needs this stray memory leak
>>>> fix...
>>>
>>> But there's no need for Jeff to depend on your branch, since (as you
>>> mentioned) this cleanup isn't relevant for anything else in this series,
>>> which is a sort of grab-bag of miscellaneous clean-ups.
>> Indeed, to be clear it was just general advice about queue-on-top.
>> But to clarify what I was getting at here: If we just came up with
>> the
>> same diff I'd have assumed Jeff just hadn't need the change in "next",
>> but since he clearly has I was confused by it being here.
>> I.e. it doesn't *seem* like anything in the rest of the series
>> depends
>> on it, so why have it here at all since the bug is being fixed anyway?
>> Or if it does depend on it in some subtle way I've missed, perhaps it
>> does need to be queued on top of ab/tr2-leaks-and-fixes, and the
>> relevant commit/subtle dependency needs to be called out in a commit
>> message.
>> Or maybe Jeff had just come up with this independently, noticed it
>> just
>> before submission and just updated the CL, not the patch or series
>> itself :)
>>=20
>
> I'll drop this commit since your version is already queued up
> and headed to master.  I've been carrying it in my dev branch
> for a while and was using it to make leak reporting a little
> quieter.
>
> And yes, I just noticed that yours had advanced when I wrote the
> cover letter and ACKd it rather than dropping it.
>
> And no, nothing in the rest of the whole FSMonitor series depends
> on this, so I can leave my series based upon master rather than
> your branch.
>
> Thanks
> Jeff

Sounds good, thanks for clarifying.

In any case by the time you'll re-roll this (or soon thereafter) Junio
will probably have merged it down anyway.

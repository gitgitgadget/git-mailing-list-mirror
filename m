Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B84C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 11:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiHKLJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 07:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiHKLJq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 07:09:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4837C183
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 04:09:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w3so22551043edc.2
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 04:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=iU2mISdNhvA4wArk3H3PEG8izuEK2L+wqfVYHAptPio=;
        b=itxtv6uC+Uiy0sRBPZNgVKYEQgnyiZ/hdxEQykKag7wXh0htQDz3UzUyRmqfc3N/NH
         FSjdDDLpi9Nxuop49x4FJyibrNDuipHE6xIme63itrroI8jQS4gqbYgJ3BxJCdla+EdW
         8v0QShcbQUyp13BEPcpTq72oXdDfmndvIuqKQc/UjGPt30RD+S+Iym7M/4Mnx3UP5iYQ
         bNdkKF1E5mlmH+qWJv+E7qPXaPArikooS0eu6ptxXsJ8hCg1A8TdaVbI7PBF8M5dxiDR
         N1shJVQ8Z2ibAlXCgL/CPcOEQKPB+EyHikuUEcKEM6oYO+lfdj2PULCozdJyuo+zyrYt
         Amcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=iU2mISdNhvA4wArk3H3PEG8izuEK2L+wqfVYHAptPio=;
        b=P6ICHa+h916esuWe2zXOST5innox8EZZNzaFzbEPV29jKiH9wdTpqq693gSlhG+YcN
         qVVX+ojvdhzDdqyrCp27BjD5UhOJ2oz/RpJF00gsHpdp4WA2btpCqsvoj9eElXrra1Ct
         eCNze6WinJJblvk0lJ7pqn0EI27Kr0+IbgDMF2CntkuALeoG5ePZLqf907D6GhaX9F9Q
         0790emkDw7M3TmO3xcd5IUitRXggU+gtleD8nB25XmztMbR3v+pMCSE1UCxL4Xc0zwF/
         rRui5JqbOxeSAheiIL+gVJ8/TLp3FEIkhEasNs6ll3goSNiCyqIrO6Vje+wD49lWtsAL
         96ZA==
X-Gm-Message-State: ACgBeo3BCk2LU1Qm+lXPrK764XIjZmLE27NWzethUwQhd/XiMuhyWHtO
        jJgOfiqK+KxJHMllEnJJORU=
X-Google-Smtp-Source: AA6agR5sJHxRMycaMRPS/rU2t592aCsgTjyeGM8yq/mfgX2lbilYU8r9TSUKHG9acltitpxxPRDKog==
X-Received: by 2002:a05:6402:3594:b0:440:5036:ec6b with SMTP id y20-20020a056402359400b004405036ec6bmr23334303edc.117.1660216183406;
        Thu, 11 Aug 2022 04:09:43 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709061bb100b00732fac1fcbcsm2712530ejg.112.2022.08.11.04.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 04:09:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oM64M-001B9h-0s;
        Thu, 11 Aug 2022 13:09:42 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 06/10] builtin/diagnose.c: create 'git diagnose' builtin
Date:   Thu, 11 Aug 2022 13:06:24 +0200
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <73e139ee377f9c50e671b0d94a28b93c1db28a69.1659577543.git.gitgitgadget@gmail.com>
 <220804.86zggkecmk.gmgdl@evledraar.gmail.com>
 <41f85d57-596a-5e42-756c-93fe0f45185f@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <41f85d57-596a-5e42-756c-93fe0f45185f@github.com>
Message-ID: <220811.865yizqbnt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 05 2022, Derrick Stolee wrote:

> On 8/4/2022 2:27 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, Aug 04 2022, Victoria Dye via GitGitGadget wrote:
>>=20
>>> From: Victoria Dye <vdye@github.com>
>>>
>>> Create a 'git diagnose' builtin to generate a standalone zip archive of
>>> repository diagnostics.
>>=20
>> It's good to have this as a built-in separate from "git bugreport",
>> but...
>>=20
>>> +git-diagnose - Generate a zip archive of diagnostic information
>>=20
>> ...I'd really prefer for this not to squat on such a common name we
>> might regret having reserved later for such very specific
>> functionality. I'd think e.g. these would be better:
>>=20
>> 	git mk-diagnostics-zip
>>=20
>> Or maybe:
>>=20
>> 	git archive-interesting-for-report
>
> These are not realistic replacements.

Maybe:

	git diagnose create-zip

?

>> If I had to guess what a "git diagnose" did, I'd probably think:
>>=20
>>  * It analyzes your config, and suggests redundancies/alternatives
>>  * It does some perf tests / heuritics, and e.g. suggests you turn on
>>    the commit-graph writing.
>
> These sound like great options to add in the future, such as:
>
>    --perf-test: Run performance tests on your repository using different
>    Git config options and recommend certain settings.
>
> (This --perf-test option would be a great way to get wider adoption
> of parallel checkout, since its optimal settings are so machine
> dependent.)

...

> The thing is, even if we did these other things, it would result in
> some kind of document that summarizes the repository shape and features.
> That kind of data is exactly what this version of 'git diagnose' does.

I think a command like "git diagnose" that had options to do other
unrelated stuff, but by default created a zip archive when given no
options would be rather confusing.

Yes, it makes sense to emit some human-readable summary, but to zip it
up as well? That's something we just need for the "git bugreport"
case...

> For now, it leaves the human reader responsible for making decisions
> based on those documents, but they have been incredibly helpful when we
> are _diagnosing_ issues users are having with their repositories.

This is orthagonal to what I'm pointing out. You're basically saying the
user can just read the documentation to find out what this built-in
does.

That's true, what I'm pointing out is that it's unfortunate that such
highly specific functionality is squatting on such a short & generic
name, but just e.g. adding a "create-zip" sub-command would address
that.

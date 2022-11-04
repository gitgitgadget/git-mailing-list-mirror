Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58D8C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 11:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKDLh0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDLhY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 07:37:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427B925EBF
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 04:37:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l14so6688830wrw.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FuucHG4g6AWjsGAHVSwtsJSfM5XiwfYOpASL83DlzNw=;
        b=gBPthFxq4pHgh8Is7IW8lxROhccGqiZYqM7HQrWKVybNhQ6ybAZw9cT6ATaV9IbEDs
         cLqKm8Bdmu7gI9suGKy+u6t8DuRVO/64Svx9EQdiRhWDhTlTCp5g+rGuWIfm4HxmO0kW
         cqhL6CFL63Vumv3/hPWXfxjfnHo4NELVlduOqRrtARK+xl5VArFboo6uLLsM5kL7VLRL
         AVkZihNJLpUehcP9YSlpEv5WavlJTf08X4NlhuHWpGfM0zAKTlEFr8gRrcK2GAuM6tvb
         GMEVBUy+SMVem5oychsF1l5SpRZVOA8AB1wseEAhWa0QnZXPnof+xAoppb6ce+W040Jz
         WzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FuucHG4g6AWjsGAHVSwtsJSfM5XiwfYOpASL83DlzNw=;
        b=ncwxy1i/sa1pOXAyQNdY2WV7tVRndrJaPpzR8PeV/t9aoouSgdFnIOzSnHPe6DMktL
         CwGMrZKpXfJTu4cEeRucnBXlROd6SujjYip9bYXPWdVroM4DxIdeWbNfR0GhwKgypK6B
         HnY+ZulVqyj/Ranq4kBqeCDsGVddVjvmzGY5cUtoqLgy3VYMwkZvsB1cZnprfHzCBA1L
         YSIewNVgp2J3wyOlhPsSA1pwSDCYL2RN6wmTQW3qidHEau5ITFXMzlmaV1DVAK1mvJyT
         gzXZO7kiQnHJrd+hqoW3HW8YGBnZlkm8ssDzm7smjuqayInrZeNoV8cVeMGoaBFZAn2Y
         uzvg==
X-Gm-Message-State: ACrzQf0JK6c8DiHaZa9Y3f4YPndl/sUT/AiI29QOQOwiKUHbbOW1qGu0
        +O/M0NXyOpMCcDdMt4KHghU=
X-Google-Smtp-Source: AMsMyM4lDOjkGehfho8RSS89s3Y/fCW42ueQvW5YAeUQh4qANUUSy5pRDh3vcN4yHdbm9NZfYkilig==
X-Received: by 2002:adf:e4cb:0:b0:236:dce2:3604 with SMTP id v11-20020adfe4cb000000b00236dce23604mr14437875wrm.525.1667561841674;
        Fri, 04 Nov 2022 04:37:21 -0700 (PDT)
Received: from gmgdl (j99119.upc-j.chello.nl. [24.132.99.119])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c502300b003c6b874a0dfsm3352629wmr.14.2022.11.04.04.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 04:37:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqv0i-000Ah1-0Q;
        Fri, 04 Nov 2022 12:37:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
Subject: Re: "git bisect run" strips "--log" from the list of arguments
Date:   Fri, 04 Nov 2022 12:36:12 +0100
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <Y2TfUFkLUa2tHdS7@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2TfUFkLUa2tHdS7@coredump.intra.peff.net>
Message-ID: <221104.86zgd7x85r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, Jeff King wrote:

> On Fri, Nov 04, 2022 at 07:31:26AM +0100, Luk=C3=A1=C5=A1 Doktor wrote:
>
>> Steps to Reproduce:
>>=20
>> 1. git bisect start BAD GOOD
>> 2. git bisect run ./myscript arg1 --log arg2 --log -- arg3 --log arg4
>>=20
>> Results with 2.34.1:
>>=20
>>     running  './myscript' 'arg1' 'arg2' '--' 'arg3' '--log' 'arg4'
>>=20
>> Results with 2.33.0:
>>=20
>>     running ./myscript arg1 --log arg2 --log -- arg3 --log arg4
>
> Thanks for an easy reproduction recipe. I used this as an easy-to-see
> test case, which works in any repo:
>
>   git bisect start HEAD HEAD~2 >/dev/null 2>&1
>   git bisect bisect run echo --log 2>&1 | grep running
>
>> Is this expected? In https://bugzilla.redhat.com/show_bug.cgi?id=3D21398=
83 Todd suggested it might be related to
>>=20
>>     d1bbbe45df (bisect--helper: reimplement `bisect_run` shell function =
in C, 2021-09-13)=20
>>=20
>> but I haven't tried it myself.
>
> Yes, it bisects to that commit. +cc Christian, who mentored this gsoc
> project.
>
> I think the problem is that we are now feeding the arguments to
> parse_options() in git bisect--helper, and it doesn't realize that it
> needs to stop after seeing that we are in "run" mode.  And because
> "--log" is an option to git-bisect--helper (it is the opposite of
> "--no-log"), it is consumed there.
>
> As you noticed, the "--" stops parsing, so the one between "arg3" and
> "arg4" is preserved.
>
> It feels like the invocation of bisect--helper ought to be passing "--"
> itself to indicate the end of options, like:

Normally you'd be righ, but there's a much easier way to do it in this
case: cherry-pick
https://lore.kernel.org/git/05262b6a7d1b20a0d2f2ca2090be284ffb8c679c.166188=
5419.git.gitgitgadget@gmail.com/

I.e. we're eating "--log" in particular, but could just stop
understanding that option.

I'll submit alternate fixes for this soon, I've been poking at various
"bisect" behavior changes, and the commit that rewrote "run" introduced
a few other regressions....

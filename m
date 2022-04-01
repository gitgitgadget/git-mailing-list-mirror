Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BB9C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 13:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiDAOBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346613AbiDAOBC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:01:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423AB5C641
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 06:59:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h1so3094819edj.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=swfl4/sEivlMR47DH6unsO1Adgkc/kxQe1VVqhLh4nc=;
        b=QAQgG0mjoB5PtrPwq5Mq5fTyatu6akl155WoHkRIrCKGU9HGpYQleSdNV7hcMbCgqc
         EW0kUI+XQoYFxYDzGJBdUxuynb8XyQZKZKxJkcJ05cE4tyN+O174FkMHkO3y5DHX3dbE
         6kd/70oHltP620Z3EGW7/vFaZKPeWylAVkwotbuTPkBU3TjHKbD9r8KsrErBW3shrsXt
         waLX75wFxQDVncEqOvx5zRmAYdnkb6v0tU67LL3T5KK6leew8TnGyoekCVMOPcbRZeVX
         1F6eUwkMk1Qm3TEDsxiCgyOTJch+R+OxEVe1o69OF8w76uHRIUf+sph/VQTSYregMMtG
         m3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=swfl4/sEivlMR47DH6unsO1Adgkc/kxQe1VVqhLh4nc=;
        b=ywnbNl/Tw2QBZS7up7DJUWnbH1W8sjnUjkvlUef/WAVzMBVGC1wxr3NELzOcDt34vo
         6q0H4XMHR2vtrvv1G2dTFVQL41BS/0O0Bkx1pBHbHH0CgDXCWOY9clJScGO3gXVKxWw2
         p6aFQ5471sBvaKg5IQSDS2GgkNrv+NQOHW5dp2xgdCEgDLYN1nHJZCADUT9swSa7BMkZ
         tRFdrg7M2SVRIAPtSf8U0KskkrcgT4Wn5ohsx6qTPa1lKVokl8LjDGY7/D1n1Oali4zq
         umZs/GVU4D3qeY8L9r6y4vBbhrpuur+t4XsmOBjZJl0+gxjv/LjpDselsIW1vsEAph7e
         Byqg==
X-Gm-Message-State: AOAM5303UKQ3KNHfhj4vvJ7P3J42ATw824wy55THjztpjPZamkqQt2cd
        O8TIvoRsuPbSl0E3eTY4hWqRtjh6uZU=
X-Google-Smtp-Source: ABdhPJxsSYtk46ZOq6xlqgHF4JFqcQf0U/cbMvZl9rf3mH4xPdO2c/URgceY5dv+XxUaBDUCQEhbJw==
X-Received: by 2002:a50:d711:0:b0:410:a51a:77c5 with SMTP id t17-20020a50d711000000b00410a51a77c5mr21121945edi.154.1648821551397;
        Fri, 01 Apr 2022 06:59:11 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906490700b006b2512921b2sm1071828ejq.48.2022.04.01.06.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 06:59:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1naHny-0018tO-6e;
        Fri, 01 Apr 2022 15:59:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Miklos Vajna <vmiklos@vmiklos.hu>
Cc:     git@vger.kernel.org
Subject: Re: git log --since to not stop after first old commit?
Date:   Fri, 01 Apr 2022 15:51:38 +0200
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu>
 <220401.86pmm1nmvh.gmgdl@evledraar.gmail.com>
 <YkbQnnB8GSzuAROh@vmiklos.hu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YkbQnnB8GSzuAROh@vmiklos.hu>
Message-ID: <220401.86czi0oqfl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 01 2022, Miklos Vajna wrote:

> Hi =C3=86var,
>
> On Fri, Apr 01, 2022 at 11:57:33AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason <avarab@gmail.com> wrote:
>> So (just making sure I understand this) in this case the --since option
>> is behaving as expected in the sense that the information in the commit
>> itself matches what it's finding, but what you'd really like for it to
>> consider some "adjusted" commit date?
>>=20
>> I.e. to be smart enough to spot that it should include a commit from
>> 2021 if all the preceding commits are from 2022, or some other similar
>> heuristic?
>
> No heuristics. Just a way to not stop at the first commit that doesn't
> match the --since criteria. Here is an example:
>
> Given:
>
> rm -rf .git file
> git init
> echo a > file
> git add file
> git commit -m init
> echo a >> file
> git add file
> GIT_COMMITTER_DATE=3D"2021-01-01 0:00" git commit -m second
> echo a >> file
> git add file
> git commit -m third
>
> When I do:
>
> git log --pretty=3Doneline --since=3D"2022-01-01"
>
> Then current I get:
>
> 91a24b6ccba6b1d26c3bd5bcea7ff86e6997b599 (HEAD -> master) third
>
> And I would like to have an opt-in way to instead get:
>
> 91a24b6ccba6b1d26c3bd5bcea7ff86e6997b599 (HEAD -> master) third
> e259a40784d3d70f3878105adac380c8e8a8ae52 init
>
> Arguing that both "init" and "third" was committed this year.

Indeed.

> The question is if there is a way to do this already (perhaps I missed
> something in the docs or didn't notice it while I briefly researched the
> commit walk code), or in case I want to do this, then would it make
> sense to have this feature in git or this is more a "run git rev-list
> and do your own filtering" case?

I think it might make sense to have it as feature, but hopefully we
could piggy-back on the date adjustment that the commit-graph needs to
do already, I'm not sure if we save that information anywhere though...

The assumption with --since was that this sort of timestamp drift
wouldn't be this bad, so mostly it works out. It could be made to work
like --grep, but then it needs to walk the whole history if no other
limit is provided.

So it'll be very slow if you just want --since=3D2.weeks.ago, but
accurate.

I think an alternate solution to this in the meantime is to use "git
replace" as a band-aid, I haven't tried, but you should be able to
replace the relevant commit with one that has adjusted dates.

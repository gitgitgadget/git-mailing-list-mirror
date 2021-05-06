Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48DEC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A87B61C58
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhEFPbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbhEFPbc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:31:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4037C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:30:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id s20so3380706ejr.9
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=d5ZsxTPcdE+ZzrdrM+kkjbhx9nylP2ECyCkzvZibQ0M=;
        b=j2XDt1xjL56+FWMrbd74iDRh3nw6Ll9kUyiLjUukVTCldH2fuibet2lkm333T4SgEd
         h8Z47o9y/3y+RZfK/FYNKwWbzWZAUi98f0i6Op6NtfXi2lpbdY2Om5vkr7AqoYs8QEPT
         llth9iHv4ydtCRhJZv7fQOfilvCdqMfxixtBFH7xGLfoJafUrIS5hlmvZA/ogn/fOhqd
         EZhm8406K9MDzsB2lGPBIMxnJCy0Sso645Ry3EYkWDTEU/ZfB+5cxu6sCgrmtjxHb89+
         CiYhVBsCelsHg7jxeKHyt2FPv3Vk7jv2jVC3tPjJF2IyFP20PBZWq9ztChYUi0HbmYrR
         7pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=d5ZsxTPcdE+ZzrdrM+kkjbhx9nylP2ECyCkzvZibQ0M=;
        b=gKevcNzBacaJyrl81ot/ykiLRvrQ4QzBGnExuaJEGZqCRiRmuXMdI0TlPZlcFaI4dx
         LST8Y7XlwwBv32zYSnFG48qBrGpKPxR/+h6Aa0viXqPLPqBh+8Ule3nAtmSIW1wmHHEt
         ZYzlV+oprNGUYvFPymPIKPhHRS7bseuu44MS1kOOjNt5sBtiy9pkqtY9gpLEsIdCdbMW
         Ul6IKPRLUWh+rnjhGVA186qIXxmnNSorm6flzOAPEDYLMMmbUzf1GqOWGI20ZQvKu8KS
         ITGyVWHtw+qKw0LChRxnwD/Q/qtdCfjO5kkaAfxO0WL1Pst2anSzxJQvIaNdoJB5EaXw
         Iong==
X-Gm-Message-State: AOAM533OUhL5SpUuhFLNQY/erbU7yxcFBc4ZK5ehYKK54RfH1sy5QI0F
        tE+PtU9lfRl0nAd+S0N5Gdmq2NyD6mQT6A==
X-Google-Smtp-Source: ABdhPJzTh97jihD6FdEDhvOBHraY4QxGqY5iQtKm/QEh8225rB8gsEll/xF2kAKRw0OVBCoZxCkUdw==
X-Received: by 2002:a17:906:551:: with SMTP id k17mr5085452eja.69.1620315032351;
        Thu, 06 May 2021 08:30:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z22sm2166553edm.57.2021.05.06.08.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:30:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?G=C3=A1bor?= Farkas <gabor.farkas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git switch/restore, still experimental?
Date:   Thu, 06 May 2021 17:26:37 +0200
References: <CAPiPmQnb=XMaF2+YkryEbiX8zA=jwa5y=fbAGk9jpCExpbS4Rw@mail.gmail.com>
 <CABPp-BHBcjSQbkotrzwDtVRSC-qqjEyP4m=biY-0+=Jdg9ETQw@mail.gmail.com>
 <877dkdwgfe.fsf@evledraar.gmail.com> <xmqq35v01ua3.fsf@gitster.g>
 <6093cc63a4e81_325720840@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <6093cc63a4e81_325720840@natae.notmuch>
Message-ID: <87h7jfvq09.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 06 2021, Felipe Contreras wrote:

> Junio C Hamano wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>=20
>> > I mean, I see why. You don't want a typo of "master" as "maaster" to
>> > create a new "maaster" branch, so really that's out. But it really
>> > should be:
>> >
>> >     # -n or -N for --new / --new --force (the latter just in case of a
>> >     # race, and just for consistency)
>> >     git switch -n doesnotexist
>>=20
>> I do not see why --new is better than --create;
>
> I do. Different languages equal different minds.
>
> New in this context is an adjetive: it is a modifier of a noun, in this
> case, a branch.
>
> Create is a verb; it's an action.
>
> Linguistically speaking they could not be more different.
>
>
> You don't do two verbs at a time. Either you sleep, or you eat, but you
> don't do both. Similarly you don't switch and create. Doesn't make
> sense.
>
> If you use natural language:
>
>   1. Git, switch to a new branch
>
>   2. Git, switch, create, branch
>
> One of these simply flows, the other is complete gibberish. I think
> anyone familiar with English can identify which is which.

Well, there's "Git, create a new branch and switch to it"

Also, there's the verb "make" in common use in git's command set
e.g. git-mktag, git-mktree, as well as mkdir(1), mkfifo(1) etc.

Perhaps we'd be better off with a git-mkbranch in this case & leave "git
branch" as an interrogation/change command.

In any case, unless we're talking about rewamping git's entire command
set (e.g. having a git-newtree or whatever) I'd like to think that it's
more productive to focus on making the commands/switches we have
internally consistent when possible, which is what I'm advocating in the
E-Mail that started this sub-thread.

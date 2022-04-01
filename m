Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D938C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 16:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350277AbiDAQwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 12:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350115AbiDAQwd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 12:52:33 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43DBBB089
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 09:41:50 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s16-20020a170902ea1000b00156547b6480so1726203plg.6
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UYa4sLbW/yYrJgymF+WEvBfOjzwg689BUBmoV/tPoZ0=;
        b=qn5+zkdipEcz+xOR2yecHMKDMJtJ41dmcf8ouOltbGQTCNtGPEbLaZRHVt3REtNbv6
         T2ft6O4FHNUjG+lndKNq0g3psvbcorVNBz61bmEpwze0T4LH9wvNz8ikPcNvf+idTmBV
         w13uh/WfFlPF+Dx+oMc07PmlFHZpBdO4CaXDN69uZ8yd/SH4fZ1A8/iag6BxjEz3MokB
         Gao46UVupScAm424A4nAgQ2Nlav6aLz32pfE8WOdxqoQgNNMPoVs7bz3j5rwaMY2HAPJ
         qTGf/F5YkbZO/7ozDe2tlFC4k44gpMYZ3Pdl+0yQjM0JnqNma8hO2ha1R/hFQii/L5im
         8TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UYa4sLbW/yYrJgymF+WEvBfOjzwg689BUBmoV/tPoZ0=;
        b=5HMAwfIis16ZLUogJ4O3Juz8P//YTgIdby6zPTQUczcnpBhRuMoP0NwGk07sfWpy5o
         qrmboP5omdfMlPlolgGOL+LLh79ujznX9hEvIJrbpk0CbnbZmYxX2u8rEGR4MJ81J/A4
         dzFjYAHkQUFEbEfGyXjkdVztq5KcklTGCmLUVqTlf7/mL4d6L3miGaR9El7Myy8wbjfr
         zcZ56rxseD0OqI39/BK7AUjfFJS3RLjujCGrv16qz1n8Jwh5WE4q8kaeiTUUVxuKgZ8g
         oVrIC+UE40Zg1S+GQHoNcJiGjzhub2MQ/SyV7LwUaxjsiOkjiYoDNeU990gsEmq3OMBV
         YccA==
X-Gm-Message-State: AOAM530HamhTO1dq9wrmtR3RxKbYU6NaGgsPuImRhkxwyw9lT5PxNfBC
        xnBtKVXr3Ggg0+F6AFWAHlUuStTDYJc2Vg==
X-Google-Smtp-Source: ABdhPJyd8kHO+laOkmHtgT09VVrcSGCmTPBrzEOZgPLLolEtbqeOEjw2ZoILqMZNVEL44GS+CZYMF9GK/Ja1Eg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:10c2:b0:4fd:a140:d5a9 with SMTP
 id d2-20020a056a0010c200b004fda140d5a9mr11836235pfu.77.1648831310264; Fri, 01
 Apr 2022 09:41:50 -0700 (PDT)
Date:   Fri, 01 Apr 2022 09:41:47 -0700
In-Reply-To: <CAPMMpojb7-tD2kFNZPiaC0MpB8GNXtYqpJs796pRcM7pE=ksmg@mail.gmail.com>
Message-Id: <kl6lpmm0sqlw.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
 <pull.1183.v6.git.1648742485887.gitgitgadget@gmail.com> <xmqqpmm13okb.fsf@gitster.g>
 <kl6lsfqxsmj3.fsf@chooglen-macbookpro.roam.corp.google.com> <CAPMMpojb7-tD2kFNZPiaC0MpB8GNXtYqpJs796pRcM7pE=ksmg@mail.gmail.com>
Subject: Re: [PATCH v6] tracking branches: add advice to ambiguous refspec error
From:   Glen Choo <chooglen@google.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> On Fri, Apr 1, 2022 at 1:57 AM Glen Choo <chooglen@google.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> >
>> >>      if (!remote_find_tracking(remote, &tracking->spec)) {
>> >> -            if (++tracking->matches == 1) {
>> >> +            switch (++tracking->matches) {
>> >> +            case 1:
>> >>                      string_list_append(tracking->srcs, tracking->spec.src);
>> >>                      tracking->remote = remote->name;
>> >> -            } else {
>> >> +                    break;
>> >> +            case 2:
>> >> +                    /* there are at least two remotes; backfill the first one */
>> >> +                    string_list_append(&ftb->ambiguous_remotes, tracking->spec.src);
>> >> +                    /* fall through */
>> >> +            default:
>> >> +                    string_list_append(&ftb->ambiguous_remotes, remote->name);
>> >>                      free(tracking->spec.src);
>> >>                      string_list_clear(tracking->srcs, 0);
>> >> +            break;
>> >
>> > Just to sanity check this part,
>> >
>> >  - During the first iteration, we append tracking->spec.src to
>> >    tracking->srcs, and set tracking->remote to remote->name;
>> >
>> >  - In later iterations, we do not want to touch tracking->srcs, and
>> >    want to collect remote->name.
>> >
>> > And "backfill" assumes that tracking->spec.src at that point in the
>> > second iteration is the same as what we got in remote->name in the
>> > first round.  If that were a correct assumption, then it is curious
>> > that the first iteration uses tracking->spec.src and remote->name
>> > separately for different purposes, which makes me want to double
>> > check if the assumption is indeed correct.
>> >
>> > If it were tracking->remote (which was assigned the value of
>> > remote->name during the first iteration) that is used to backfill
>> > before we append remote->name in the second iteration, I wouldn't
>> > find it "curious", but the use of tracking->spec.src there makes me
>> > feel confused.
>> >
>> > Thanks.
>>
>> Thanks for bringing this up, I also found this unusual when I was
>> reading v5.
>
> If you never hear from me again, please know it's because I crawled
> back under the rock I had crawled out from. This is clearly a bug from
> a silly typo, and I've managed to look at the resulting output twice
> without noticing the wrong thing was printed. I'm guessing the use of
> the word "unusual" here is a polite euphemism for "you numskull, what
> you wrote makes no sense!" :)

Please don't take it that way! I use it the way I think most others use
it, which is a more charitable "Hm, I trust the author, but this looks
confusing to me and let me ask just to be sure that all our bases are
covered."

After all, even the best of us make mistakes, so I don't think it's a
big deal. Plus, if the mistake managed to sneak past review, the fault
is on all of us :)

> I did not think adding an automated test for advise() output made
> sense, but I guess I have proved myself wrong.

Heh, nearly every time I think that a test isn't necessary, I find a way
to prove myself wrong too.

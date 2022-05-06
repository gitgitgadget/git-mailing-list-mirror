Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55ABC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 22:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444833AbiEFXBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 19:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391458AbiEFXBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 19:01:09 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D7C10D2
        for <git@vger.kernel.org>; Fri,  6 May 2022 15:57:25 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id f13so3306961uax.11
        for <git@vger.kernel.org>; Fri, 06 May 2022 15:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDFA50hcJESJnboDgAPVEIdQKFBTXLIJmvU4UJlT49M=;
        b=H0iUUwE6fCAInLB0urh+QzNINXRXS6FimWYy5IkNo4bC+c8YTEtT9VACcA54LhmZAx
         GiIu1wfMMb2cMFYeN1oCz0as5qqBnVqkrnSEMun2bU15f+1aCSf2HADh9mlgzYiQmu08
         wO3tt1LB73xmegILGBYLdNNTd2gCrJq7/Ms5LR7CXe03l/XaYCHy7IJljclWq5wreXwA
         TPhYqGDlW3RsDZIGGkqPYBww1z281G1gxBugwPejVn+rhMYbC8uqIteTnaO56o38O6Yq
         PfcLqurPekYlMLLkN8czxeLVMfN29kvmYObzZDqqdP3UlevijVLk+1rotAEluvzGfEPE
         TNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDFA50hcJESJnboDgAPVEIdQKFBTXLIJmvU4UJlT49M=;
        b=T1tQ08b4wNXv2hYP+PAKixNUUq9096XDbMw5H2nFm7+7uhkpgyfwab/U2oyTFxXaeg
         9h/PX1sf/IYJgOgcBOhQqtEEo2lRddz0VQLp2qE58+Vxb906lpQYVhM3DSNbbJIdvVJY
         ReemOrfxj7LsPoMLvW8pL0gyHhyrnozclOuQObTyEFIqv5Atd8B8y2MFdc6okiAgyQc1
         gtFroZWlynWEcp4qZH9I0KN+UIWS5+ytAgZ3FvMZ/Dr5hXHd0jeTgwlO6DYeMqEwih1f
         2dTnUFskXaFQmSmO9ByeZPC5fbfl/Hh7IP6BBuMGJ6a0he4+RGNqaohBZ7dRXFTMH5U2
         cKmg==
X-Gm-Message-State: AOAM532OQwhFeNLhQUZteooHrxH/tUx2binvhh0NP6Kc2kK7bbMq3BoS
        8blPsvBr5DkPHMHUx5Uag4vhDJrpdTpAW9kappQ=
X-Google-Smtp-Source: ABdhPJwSfgXLbRZruYgpGHMWqT8LbKhqS5PosO3LP2Vdk1u4mDe+JsFT7JvXvkihSluB16qnA9ULQ5/yjRqK8Q14KVs=
X-Received: by 2002:a05:6130:3a1:b0:365:84fa:2f57 with SMTP id
 az33-20020a05613003a100b0036584fa2f57mr2308084uab.62.1651877844211; Fri, 06
 May 2022 15:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220428033544.68188-1-carenas@gmail.com> <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-4-carenas@gmail.com> <xmqq7d79du6c.fsf@gitster.g>
 <5493b2f1-e59d-d91d-ac21-47c93d2996f2@gmail.com> <xmqq7d79gjre.fsf@gitster.g>
 <CAPUEspibV6LKVAGpUPBoDYWvF7cjBJUJOSMDzLY6ErMF8s-Eng@mail.gmail.com> <xmqq1qx6jq0b.fsf@gitster.g>
In-Reply-To: <xmqq1qx6jq0b.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 6 May 2022 15:57:13 -0700
Message-ID: <CAPUEspjOPNTMrBdLQMKcbXYY7G+Vm1br++7C3rq6Bs+5xZ4yHg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 6, 2022 at 2:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Arenas <carenas@gmail.com> writes:
>
> > Since I am renaming it anyway as part of this topic with RFC v4, would
> > it be a good idea to require both?
> >
> > I see the "IKNOWHATIAMDOING" not as a normal GIT_TEST flag, but as a
> > "here be dragons!" warning, and I later found that I either
> > misremembered it being enabled in the CI, or it was dropped with one
> > of those refactors we do often there.
> >
> > My RFC v4 includes a new nice looking GIT_TEST variable as suggested
> > by Phillip which I am also enabling in the CI to hopefully make it
> > even more clear that this is only meant to run there, but sadly that
> > also means that this patch will likely have a conflict when merged
> > upwards.
>
> This must build from the older mainteance tracks like maint-2.30, so
> let's keep the changes to absolute minimum

makes sense, but I still unsure about the two questions I had above:

* would it make sense to make it run ONLY if both variables are set to
YES or is it enough to use one (most likely the GIT_TEST one) that we
would enable independently in CI?

the advantage I see of having both variables is that it is even less
likely to even run accidentally in a desktop somewhere and maybe break
that test, and also keeps the meaning I wanted to attach to it with
that ugly looking flag that no one should ever try to enable in their
workstations unless they really know what they are doing.

The advantage of ONLY having the GIT_TEST one is that it will be
easier to enable in CI and for whoever wants to play with it on their
workstation as well, but might still encourage people trying to make
it work and wasting their time.

* since we have to enable CI for these to be useful, would that be
something to be done in an additional patch as part of this topic
branch and you will only pull the commits before it to maint to avoid
conflicts, or should it be done completely independently as a mini
feature branch that depends on this one that will be pulled to seen
and merged downwards from it?

somehow offtopic but just curious about your process, presume that if
we go with a single topic branch adding it instead as 2/4 would break
your flow/scripts since the only way to get that merged would be to
cherry-pick, right?

> I actually think 1/3 and 3/3 are OK.  Are there remaining issues in
> these two patches (which only are tests)?

The versions of them in RFCv4 have more documentation and are cleaner
since they mostly include most of the feedback that was collected on
them (even if I am still unsure because it is spread around and
difficult to track, hence why I was planning an RFC)

I don't think there is anything significantly different though but
they are and will need another review (which I am hoping would be
uncontroversial)

> As to 2/3, I think the code is basically already fine, but a
> simplification like the following on top would be a good idea.
>
>  * We clear errno before making strtoul() call, so any non-zero
>    errno must have happeneed in strtoul(), which includes ERANGE.
>    There is no point checking the returned value env_id; if it is
>    ULONG_MAX but errno is 0, then the SUDO_UID legitimately is
>    naming a user whose UID is that special value, and it is not an
>    indication of an overflow.

true, but the apparent check for ULONG_MAX (which should have a
comment added) was really a check not to overflow when assigning the
value we got into uid_t, by sacrificing an unlikely to be valid
ULONG_MAX as an uid.

it also has the intentional side effect of breaking this code if uid_t
is signed and hopefully triggering a warning in the process since it
would be always false, that way whoever has a system where this type
is signed will have to carry their own version of the code and we
don't have to deal with the portability of it.

lastly (since it really made me proud and would be sad to see it go)
it ALSO avoids someone trying to sneak a value that would overflow in
one of the most common configurations we will run where sizeof(long) >
sizeof(uid_t) && MIN_UID_T >=0, by using an equivalent to MAX_UID_T
(which only exists in a few systems and therefore can't be relied on)
to discard values that would overflow the range uid_t has.

without it, we would probably find ourselves in the future having to
deal with an embarrassing bug that others before us had suffered.

Carlo

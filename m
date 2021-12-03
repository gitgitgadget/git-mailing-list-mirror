Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D14C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 18:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhLCSlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 13:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhLCSlX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 13:41:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202E8C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 10:37:59 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so15295477edu.4
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 10:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=cIprm/6NQX1JhMzrnLzxQwmbSaTmI07hcy3bO1evZ8U=;
        b=HjgB3PiflvwxPRHS1bUC1C9Yr2I+Gfk7nd4SBLf/A7f8ae3Z3CfxxUrwGaFL3GoFE9
         5iO2CXOFylaXv79j5FahbcnF24th2w4C7PSqHXm5gEyBdRAT+TI8urPonb69aamLUp28
         hUq9m7qylxc8Vv5IVAwc1dwadEn4MHhf1t30Wbp1v8bvAPS7z3dZM2SQVCXsU0sNEC6/
         6Qg3u2raJAYkkI+A6ZX7h+Rnxz5xpYIIkDHIABwsbJUrX1TM5CuXt8OQVpbSP9LoE/74
         zWy4EvI+EvN4ZLvYFYC/OO9H2Y3KfF90QdSFMfoYHL4psoCkst5aghX2bxF6D+PPxKZ6
         Fbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=cIprm/6NQX1JhMzrnLzxQwmbSaTmI07hcy3bO1evZ8U=;
        b=3EotTnkb7pobCpuwND2IJ388d1Pdt7ViF7yB2gI+zpKXw3ypVSCeVjqWjaX61I6Jm8
         0t1/qKlhEgB0JTVaa1THYfkA9SyoFWQtRnJC3rcftI/BU8jw16cEtStDCun+AyE7vGvK
         ghWpUZwhqd4vp5js4GCOKYA58mgP/Nz8l0ISBCgXTxDzAaS/TOVB1Q2SBNK+scA2Nd3p
         PO9nzR5QC7iyXmj6lPD+bIKQjoPMy+nbLA3bBySrPV/Zu6EfVeaXDXuOd/qGFHz4fS3r
         DIU4oH1dxOiQdDFT9uX6xUwXucaoKxUp0YQf4YDzZQuu8JtJgcSgUEC+8KtDK1O+cZZ8
         HbZg==
X-Gm-Message-State: AOAM531oiJgazaHzaG3ZtkElsB4ATg7A1/VUKhTEK14y7mO+KCRHXWkj
        TXjuau5jLT5AV/xu7a7beRxPd/PmDrjqqA==
X-Google-Smtp-Source: ABdhPJwVmGco5xUbgpysWOL0R6KtaKUg+jKisWcDR7e83JdlDLAjfIojtpOexekcDD7LqTZ1nlltjw==
X-Received: by 2002:a05:6402:84b:: with SMTP id b11mr27706549edz.69.1638556677354;
        Fri, 03 Dec 2021 10:37:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id aq6sm2406557ejc.41.2021.12.03.10.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 10:37:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mtDRU-000G4G-5g;
        Fri, 03 Dec 2021 19:37:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>,
        Aleen via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
Date:   Fri, 03 Dec 2021 19:21:57 +0100
References: <xmqqzgpm2xrd.fsf@gitster.g>
 <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
 <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn>
 <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
Message-ID: <211203.861r2tsfej.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 01 2021, Elijah Newren wrote:

> On Tue, Nov 30, 2021 at 5:42 PM Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <pwxu@c=
oremail.cn> wrote:
>>
>> > Please don't, at least not this version.  There have been newer
>> > submissions with three commits.
>> >
>> > I also still find the word 'die' confusing, since to me it suggests
>> > aborting the whole am operation, and the documentation does not dispel
>> > that concern.  Even if you don't like 'ask' (for consistency with
>> > git-rebase), I think 'stop' or 'interrupt' would be much better
>> > options than 'die'.  If you really want it to be 'die', I think the
>> > behavior needs to be explained in the documentation, rather than just
>> > assumed that users will understand it (because I didn't understand it
>> > until I read the code).
>>
>> Dears Newren,
>>
>>     I don't think 'stop' and 'interrupt' words are better to explain mor=
e than 'die'
>>     because they still indicate that it will stop or interrupt the whole=
 am session,
>>     rather than stop in the middle of it.
>
> Since you've been through several rounds of revisions already, if this
> is the only remaining issue with your series, I wouldn't try to hold
> it up for this issue; I just thought it could be fixed while you were
> working on the --allow-empty stuff.

FWIW I think it's worth getting the UX issue right, tweaking it is
relatively easy, and if we can decide on what the thing is called
then...

> However, while I don't think it's worth holding up your series for
> just this issue, I would definitely submit a follow-up RFC patch to
> fix the wording, because I do disagree with your assertion here pretty
> strongly.  Let's look at the meanings of the terms:
>
> die: connotes something pretty final and irreversible -- people tend
> not to revive after death as far as recorded history goes; most such
> recorded instances tend to be causes for people to debate the
> definition of 'dead'.
>
> stop: could be final, but is often used in a transitory setting: "stop
> and go traffic", "stopped to catch my breath",  "the train will stop
> at this station", "stop! I want to get out", etc.
>
> interrupt: seems to nearly always be used as a transitory thing
>
> Now, in the computer science context, all three terms come up relative
> to processes.  You can interrupt a process (the kernel does all the
> time), but it'll usually continue afterwards.  Or you can give it a
> SIGINT (interrupt from keyboard signal), which the process can catch
> and ignore.  You can stop a process (and SIGSTOP cannot be caught),
> but you can also continue it later.  die essentially means the process
> is going to be gone for good (at least short of some kind of black
> magic like a reversible debugger such as rr).
>
> So, I think it's much more likely that 'die' will be misunderstood to
> mean abortion of the entire am-process, than that 'stop' or
> 'interrupt' would.

Why are we exposing an --empty=3Ddie at all? It's what we do by default,
so why have it? The user can just not provide the "--empty" option, then
they'll get the current behavior of die_user_resolve(), which seems to
have inpired the name for this "die" (it exits with code 128, just like
die()).

Once we get rid of "die" the rest of the UI can follow the example of
the existing "git rebase" options:

    --empty=3D{drop,keep,ask}

I.e. the "drop" and "keep" will be the same, no "ask" currently, but it
can be implemented in the future.

Maybe I'm missing something, I haven't used "am" in this way (or rebase
with --empty=3D*), but this just seems to me to be needlessly exposing a
"die" (or "stop" or whatever) because it's how we implement this.

Whereas for the UX we don't need to call it anything except the absence
of an --empty option, or perhaps --no-empty.

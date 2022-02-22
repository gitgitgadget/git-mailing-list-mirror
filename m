Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320D0C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 14:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiBVOVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiBVOVb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 09:21:31 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA01E151C66
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 06:21:05 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s14so19931827edw.0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 06:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=iT+TWDaYtmGsjwlaEdaBg7CST3EcR9dB/zSHS7vojFA=;
        b=m42TnGR0WEq+BEpjvvW0Blkbx99Ni5fyvpfe1NVuR3y29RevOBHhG7Dz1dhcRe2Cvw
         Big+WRCu9PfCAoAb96RkcaPqPic4KT1wPJf4e6W6MLqztlAwpQkxSdJqX+K5huDuW3gF
         C6QnYd4dy5fskMeaDu3pAA18hK58B0YbwB6g6ZLnBfNGgI40J8yOKwfWH0LgHbJDVuDs
         xyMI7X1oiNzuj0sc9HsbxGfQsPsvzBCsiTBswtnZIuwirfVNEvlfApMQF45Dban+kSqI
         w6e+n7Lu/4b52d58x7eVu0JzId4r6ZM3aonMuYWhUwdpuK2CfYw0na1QLqhMuw76DiCK
         i63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=iT+TWDaYtmGsjwlaEdaBg7CST3EcR9dB/zSHS7vojFA=;
        b=7x0VV5i3M7WJNJm6sn98O13xTLRb85lNk+Gf8y7Dl3QtsGmZ2Z46ut1+nm7p//+Iqr
         vrI5BOUPeTt3I0JZoasITaAPOzoshH6hvOgo7nRDxQXvcmhlUQOpV+FfTOAbU6oxWKtN
         5ysGRXyyqvvsxfIBhZD2VqdeBg8KgwtUEH5HQH6TxiispQCVpA3QKh5bcHC+C5j5oscT
         iKR2i4jbxV0QYvrdJoEuYapLRkyNckBCnX857Es1lacHPf5zvRLU9GwMwtNbgtUcsqYH
         05NgLQyyyXt8t2/41/wXqymFI3XefprDdlBvniQQQY/wXIIkMNz3jautzFsMAg7r8y6U
         O6Fw==
X-Gm-Message-State: AOAM532ZRcS1IpHniX6I+y6pCoRg5iR83AsdCPULlH97o/lg0bD+x52r
        JGgmjMq9MWLH7+isM+PGn5VGQe4ocdKOqzpS
X-Google-Smtp-Source: ABdhPJw1DphQy4WsgoWqAwVB6DjIoq06Wa/vhmaRCnruzY3S8Qf3tSMHZF+zO+P1zbXcoHOGF6sXvQ==
X-Received: by 2002:a05:6402:38e:b0:410:c1a9:60aa with SMTP id o14-20020a056402038e00b00410c1a960aamr27074803edv.336.1645539663938;
        Tue, 22 Feb 2022 06:21:03 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z13sm3678822ejb.131.2022.02.22.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:21:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMW2I-0067i6-SL;
        Tue, 22 Feb 2022 15:21:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Tue, 22 Feb 2022 14:31:10 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
 <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
Message-ID: <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Sun, 20 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Sun, Feb 20 2022, Johannes Schindelin wrote:
>>
>> > I notice that you did not take this into `seen` yet. I find that a lit=
tle
>> > sad because it would potentially have helped others to figure out the
>> > failure in the latest `seen`:
>> > https://github.com/git/git/runs/5255378056?check_suite_focus=3Dtrue#st=
ep:5:162
>> >
>> > Essentially, a recent patch introduces hard-coded SHA-1 hashes in t300=
7.3.
>>
>> I left some feedback on your submission ~3 weeks ago that you haven't
>> responded to:
>> https://lore.kernel.org/git/220127.86ilu5cdnf.gmgdl@evledraar.gmail.com/
>
> You answered my goal of making it easier to figure out regressions by
> doubling down on hiding the logs even better. That's not feedback, that's
> just ignoring the goal.

I think it's clear to anyone reading my feedback that that's either a
gross misreading of the feedback I provided or an intentional
misrepresentation.

I don't mention the second one of those lightly, but I think after some
months of that pattern now when commenting on various patches of yours
it's not an unfair claim.

I.e. you generally seem to latch onto some very narrow interpretation or
comment in some larger feedback pointing out various issues to you, and
use that as a reason not to respond to or address any of the rest.

So just to make the point about one of those mentioned in my [1] with
some further details (I won't go into the whole thing to avoid repeating
myself):

I opened both of:

    https://github.com/git-for-windows/git/runs/4822802185?check_suite_focu=
s=3Dtrue
    https://github.com/dscho/git/runs/4840190622?check_suite_focus=3Dtrue

Just now in Firefox 91.5.0esr-1. Both having been opened before, so
they're in cache, and I've got a current 40MB/s real downlink speed etc.

The former fully loads in around 5100ms, with your series here that's
just short of 18000ms.

So your CI changes are making the common case of just looking at a CI
failure more than **3x as slow as before**.

That's according to the "performance" timeline, and not some abstract
"some JS was still running in the background". It lines up with the time
that the scroll bar on the side of the screen stops moving, and the
viewport does the "zoom to end" thing in GitHub CI's UI, focusing on the
error reported. It was really slow before, but it's SLOOOOOW now.

All of which (and I'm no webdev expert) seems to do with the browser
engine struggling to keep up with a much larger set of log data being
thrown at it, which despite the eliding you're adding can be seen in the
~1.7k lines of output growing to beyond ~33k now.

Once it loads the end result after all of that (re your "doubling down
on hiding the logs even better") is that I need to (and I've got a
sizable vertically mounted screen) scroll through around 6 pages of
output, each of which takes around 3 seconds of Firefox churning on more
than 100% CPU before it shows me the next page.

And even *if* it was instant the names of the failing tests are now
spread across several pages of output, whereas in the "prove" output we
have a quick overall summary separated from the
"ci/print-test-failures.sh" output

Does that mean the current output is perfect and can't be improved? No,
I also think it sucks. I just think that the current implementation
you've proposed for improving it is making it worse overall.

Which doesn't mean that it couldn't be addressed, fixed, or that the
core idea of using that "group" syntax to aggregate that output into
sections is bad. I think we should use it, just not as it's currently
implemented.

If that's "not feedback" I don't know what is. It's all relevant, and
while I'm elaborating further here [1] sent almost a month ago notes the
same issues.

> You answered my refactor of the Azure Pipelines support with the question
> "why?" that I had answered already a long time ago. That's not feedback,
> that's ignoring the answers I already provided.

I think it's clear what the gap between that answer is and what I was
asking you was in the parallel follow-up discussion at [2].

But even your answer there of just wanting to keep it in place doesn't
really answer that question for this series. You're not just keeping
that stale code in place, but actively changing it.

I.e. even if you run with all that how are others meant to test and
review the changes being proposed here?

I.e. is resurrecting Azure CI required to test this series, or should
reviewers ignore those parts and just hope it all works etc?

> I don't know how to respond to that, therefore I didn't.

I think whatever differences in direction for this CI feature that we
have, or troubles understanding one another, that your update after 3
weeks of not replying to that feedback [3] asking why Junio didn't pick
up your patches being indistinguishable from there having been nothing
said about your patches at all is, I think, not a good way to proceed
with that.

I.e. we're not the only people talking here, there's presumably others
who'll read these threads and will want to comment on the direction of
any CI changes.

Knowing from you that you read outstanding feedback and didn't
understand it, or read it and summarized but ultimately decided to
change nothing etc. makes for much of a flow on the ML than just
ignoring that feedback entirely.

1. https://lore.kernel.org/git/220126.86sftbfjl4.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/220222.86y2236ndp.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/nycvar.QRO.7.76.6.2202200043590.26495@tvgsbe=
jvaqbjf.bet/

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DB2C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 17:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjB0RSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjB0RSA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 12:18:00 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA50430C5
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:17:57 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m6so9510555lfq.5
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e03duANOFKcnIX6kiw1XsfbKVdv6T4OYhofArwowoLU=;
        b=R6zPVKBraDNRxtYTizYVVratf6muoGF+3A4w7z7uIYiuhpEyOh+o/gaVRhTz5wuGSU
         hsBdMs2XXt9trGqAzMF3AfL7RHsgwcL7iwzfaadxu3HRK/PuRRoF+VnX73qPJYsMWS1t
         xwVDAuZ3FS9v8jDf0PDPGXMOnXHodtJlpCG4a7rzDfm5Im7u8GKIV7D7isNA/jsxsodK
         mZBvpgwP/POYNA08Awx8OYpcQ6NFZ7ICC9ZbRwJWCdhBwA5Vp5PxIc+w4BS4U6RyUHhi
         3oujXAe1RoO6yQcD0zQhLa1f9rRmRCxYOoQ2/9spbjG8lyNSGLlkW/myfW+bY0pox3P0
         tfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e03duANOFKcnIX6kiw1XsfbKVdv6T4OYhofArwowoLU=;
        b=RtNFsvD7c5BFx9AMBh2eluxRIyWDvm97a1zo1EMa5SlI5bBrOYJzsI0fk53vp1REps
         vouJGk4ofXXfopFeKGpXVvRVWWfe6gtVsQFcPeMEeHlTyrmZL8DT34TgWMA2losMCZTs
         qx3Ys/EeVnGojtpBBZK487KaWJNdjDUzmrPdKCMfubUVQgPgE/7AbnpBiykh5958GI91
         YH6xlYRqqpvLMGsFaC85GIWCGU0jY7rYrpzGjxyLEo22r897S6gPqI0lM+O6kYylg9lK
         jvgFG5kZ/JQ8UrBr3j0umNgQdSgUh4xcMkHavonke0dFbrHnh+Y9Qd/Ql4ZzdeC9Me+n
         hjJA==
X-Gm-Message-State: AO0yUKVaAEQGlyvVBUaXK8BkQ8M9aJIE6laO+wnI+zbT1oyJvg5U6Xk8
        SJhvev2HTke0X/y85Q/l6mLsz51OSRa3MA==
X-Google-Smtp-Source: AK7set8c6xPK+01gZjGVlGHGcQ+G1Z5X1SVX2CYxK89kTfxzAALixjvBd0/XMH20pJeyaw1Ien6ufA==
X-Received: by 2002:a05:6512:12c4:b0:4db:5123:c271 with SMTP id p4-20020a05651212c400b004db5123c271mr2944898lfg.29.1677518275983;
        Mon, 27 Feb 2023 09:17:55 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w1-20020a19c501000000b004db50b52c08sm957940lfe.102.2023.02.27.09.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 09:17:55 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Tao Klerks <tao@klerks.biz>, phillip.wood@dunelm.org.uk,
        Alex Henrie <alexhenrie24@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
        <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
        <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
        <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
        <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
        <c3ef69e0-c37a-01fe-a40a-c2940e329793@dunelm.org.uk>
        <CAPMMpogi_QoGKD824JW+85v_Sgaf5d3TAd_P55YyT5NF6AUJ=w@mail.gmail.com>
        <87a615vkqk.fsf@osv.gnss.ru>
        <CABPp-BH2XPB4BN5Oo=VnLav_wvAGGUAyZC4HRHRRmES5k75P1Q@mail.gmail.com>
        <87bklilnvp.fsf@osv.gnss.ru>
        <CABPp-BHRbKG_cXdwaPT0-Rj6QTkkJRcT4N0f45==i7oAqiTC+w@mail.gmail.com>
        <87fsatixnn.fsf@osv.gnss.ru>
        <CABPp-BF3JUg4jThS8Y_3v-tOEey55V_9KpXRZ3HvfaC3S2m=GQ@mail.gmail.com>
        <87lekklqpi.fsf@osv.gnss.ru>
        <CABPp-BGJ+jdwizBNyYr-st58F6BPbyrJ+DwRX81_0NjgU6LhzA@mail.gmail.com>
Date:   Mon, 27 Feb 2023 20:17:53 +0300
In-Reply-To: <CABPp-BGJ+jdwizBNyYr-st58F6BPbyrJ+DwRX81_0NjgU6LhzA@mail.gmail.com>
        (Elijah Newren's message of "Mon, 27 Feb 2023 07:20:54 -0800")
Message-ID: <87pm9v6n9a.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Sun, Feb 26, 2023 at 1:29 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Sat, Feb 25, 2023 at 7:15 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> Elijah Newren <newren@gmail.com> writes:
>> >>
>> >> > On Fri, Feb 24, 2023 at 2:06 PM Sergey Organov <sorganov@gmail.com> wrote:
>> >> >>
>> >> >> Elijah Newren <newren@gmail.com> writes:
>> >>
>> >> [...]
>> >>
>> >> > Please, go read at least [1] to see Johannes comments about how the
>> >> > prior proposals don't work beyond simple cases.
>> >>
>> >> It's exactly handling of simple cases that we need most. We can get
>> >> fancy afterwards, if feasible.
>> >
>> > If we can handle just the simple cases without making common cases
>> > significantly worse, that'd be a potential path forward.  Any proposal
>> > involving the diff between a merge commit and either of its parents
>> > (or an equivalent such as a three-way merge involving the merge commit
>> > and one of its parents) doesn't achieve that, IMO.
>>
>> Except the method discussed does achieve exactly that according to the
>> evidence gathered at the time of debates, and here is confirmation (from
>> Johannes himself) from the reference you provided:
>
> I'm glad you read it.  :-)

In fact I didn't read it, I rather re-read it ;-)

(I'm in the CC list there, so it should not have been a surprise I did
read it then.)

>
>> "This strategy, while it performed well in my initial tests (and in
>> Buga's initial tests, too), *does* involve more than one 3-way merge,
>> and therefore it risks something very, very nasty: *nested* merge
>> conflicts."
>>
>> So, overall, the method performs well in general,
>
> Jumping from "performed well on initial tests" to "performs well in
> general" seems to me to be quite a large and unwarranted logical leap.

There were quite a few tests performed and methods were polished before
Johannes has been persuaded to give the feature a try, some of the tests
being complex enough, and both methods did perform rather well. That is
what he calls "initial tests" there I believe, and then he found the
case that is very important to him, but lead him to nested merge
conflicts, that is indeed quite bad.

>
>> and we just need to avoid driving ourselves into nested merge
>> conflicts
>
> I'm glad you're discussing a disadvantage and how to address it, but I
> don't understand how you can jump to the implication that this is the
> only one.

Well, it was you who gave me the reference to comment on, and that was
the only disadvantage I was able to find being discussed there. I also
don't recall any other objections back then when the problem has been
discussed a lot.

>> Setting this back into perspective, in comparison to blind re-merge,
>> that fails to keep user changes even when no conflicts at all exist, and
>> even when it's applied at the same place in the history, the discussed
>> method is a *huge* step forward, especially if re-merge is kept as a
>> fallback strategy.
>
> The use of superlatives and asterisks doesn't change my opinion; I'm
> still skeptical that the given strategy is overall a step forward, let
> alone a large one.

You just repeat saying the same thing, without any further arguments?
OK, thank you for your opinion anyway.

> (I do agree we have a huge problem and thus that a huge step forward
> theoretically could be taken, I just don't see this as it.)

It works. Really.

>
>> P.S. BTW, where this hate for using of diffs with respect to parents
>> come from, I wonder, provided we do use them all the time anyway?
>
> I have no hate for such diffs; I just firmly believe they are
> inappropriate as a solution for the particular problem space being
> discussed.

From my POV particular problem space (rebasing commits) already uses the
diffs, and only them, that's why I can't figure how you end up coming to
such conclusion.

>
> But I've stated that more than enough, and no one is producing patches
> on this topic right now, so I'll drop out of this thread.

OK, I participate only in hope that there will be somebody who actually
cares enough to implement it. Maybe it will be me, maybe not, and I
already got it that neither you nor the original author of git-rebase
are interested.

> I still believe in my proposed solution, and I'll implement it as I
> get time for it.

Sure it'd be nice. Fortunately there is nothing mutually exclusive here.

Thanks,
-- Sergey Organov

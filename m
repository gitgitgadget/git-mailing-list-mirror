Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78C2C25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 17:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiHNRTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 13:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNRT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 13:19:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD6A17E14
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 10:19:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r4so7028154edi.8
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 10:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=n8/ZsV2QkoKOqdPjtarc61edc1Os4D2TVSSSqi/MB7s=;
        b=XrQU5Vopszkz9dn7rdB0mXuj9fds6I9Uw5UCfjiHt+x7mnfAl1e+4+cqguY9s9qwTB
         /kvs3Gkmkq8JliAtXLK2CkMnjTJf6fgUeaXZW2jmKi/rVZt31plBGt6v78Uec65A9XWh
         yLUbnj+a76Uc7P5SH9voOOYj6CGqZCaSPRlghlJ/q27RjGaSXBnUN+aDfAbwWQTvrvzU
         Ymn3P2Nu7yUFDDXzQ24WqaOtXScTevPboEgjNWcwZtfAR0CSBmegMuc0bNQZMLyS7bNG
         8Iqo04Mi4DP0RPCYynnZStS6auIiHWzyv2iQItBml5TItzywpCml0dTw6gueOAapcYxg
         Tk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=n8/ZsV2QkoKOqdPjtarc61edc1Os4D2TVSSSqi/MB7s=;
        b=J/FUaGuE3fmfPrXNwq9dMBnWOy9Dsz3pfi57fPD8DLtjfCXBDWvrxyEqVTyYUGaIXe
         YeublpQB3f+Fe7x06cKOC9s/AkOJx7lIAHTZTKp+83v3wUje2MKWUeV90iAsoe61s2rl
         7q0cYvR6rjD24Q7dv7kpAwzJXCbPh6k85MOeRppfH10yyAnlqy4hr3JOrSZzlGrGXC+y
         mlTnrzr64zwoBn2Qls2KZv3qwoJEy3wBYqE3DWYbAVW8BvzYJcV4j8CTZOiK6TQbizW6
         1LmwYUIPGdRnBEiNNwp85nw7BuVajzQhzqU0wIBlZ/yOQqyofbgTQ7RbSnEPPXfx2fX9
         hjig==
X-Gm-Message-State: ACgBeo36NvMrxbcZnGuq0bXPmvPfJ7q4nuh6SyTCYOt9s9pLqFCO5CgZ
        rpTrJ9sBjAx0UanysitS4F3hcjF0Hjjb01FrzSk=
X-Google-Smtp-Source: AA6agR6McyTgXtIC1k2lQQ6GVyPVCAuSkmSI551nrgSaDZMRnmEWb8TpRUrrSQ+HNbiZfdq9InZrZma6nC6n5lFZb+M=
X-Received: by 2002:a05:6402:2792:b0:43f:6873:7497 with SMTP id
 b18-20020a056402279200b0043f68737497mr12039493ede.175.1660497566159; Sun, 14
 Aug 2022 10:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <6896FBE4-9160-4969-8969-D92F9FE19F14@gmx.com> <CAMP44s2A7nJDVRPbixPPPtTedg_Q53CEdw+sBpGZwOfQG4EZSg@mail.gmail.com>
 <0dddb367-ebf9-930f-1b9c-000a532774d3@iee.email> <CAMP44s1XOyMgX+4hHzNXpUmJ0DURn93=B9dH0pBm5Fk5YRfdvg@mail.gmail.com>
 <CANgJU+U_xgghdX58XsAY7dNUj1dE8STviTAL0ygycnAesZ+VxQ@mail.gmail.com>
In-Reply-To: <CANgJU+U_xgghdX58XsAY7dNUj1dE8STviTAL0ygycnAesZ+VxQ@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 14 Aug 2022 12:19:15 -0500
Message-ID: <CAMP44s11TqNPvH3EuzRu-hjB7zOT9zqOquopUS6tk16mjJGQKQ@mail.gmail.com>
Subject: Re: "master" term - no one cares
To:     demerphq <demerphq@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>, Ryan <rmrmail@gmx.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 14, 2022 at 3:26 AM demerphq <demerphq@gmail.com> wrote:
>
> On Sun, 14 Aug 2022, 04:35 Felipe Contreras, <felipe.contreras@gmail.com> wrote:
> >
> > On Sat, Aug 13, 2022 at 11:55 AM Philip Oakley <philipoakley@iee.email> wrote:
> > > There is a confusion between the use of the term that refers to the
> > > *personal* mastery of a _craft_ or _artisan_ technique and, at least one
> > > of, the historical choices for the usage of the term 'master', which was
> > > a direct reference to slave servitude. That was for the use of
> > > electrical circuits which would detect the 'tick' of a primary timing
> > > pendulum and then have all the actual clock faces that indicated the
> > > time be _driven_ from that 'master'.
> >
> > This may be the reason why some people used that name in the past, but
> > it's not the reason I use it.
> >
> > For me if I was cloned there wouldn't be two equally valid versions of
> > me, *I* am the original one, I am the "master" copy. This doesn't
> > change if my clone is cloned in turn.
> >
> > This is exactly how master branches in git are used. I have a master
> > branch of git.git, but it's not *the* master branch. *The* master
> > branch is the branch from which all the other branches came from,
> > including "maint" and "next", and all the dozens of branches in
> > thousands of other repositories. If the word "master" makes it sound
> > more important than all the other branches in all the other
> > repositories, it's because it is.
> >
> > Regardless of what name people use and for what reason, the reality is
> > that "master" is still very widely used, despite of the campaign
> > against it which was clearly driven by ideological reasons.
>
> FWIW, I was a part of ensuring two large codebases did not use the
> term "master" when they migrated to git long before it became a
> subject of controversy.  Not because I had concerns over the
> master/slave word association (it really wasnt on my mind) but simply
> because the word "master" is too overloaded, and its use as a name
> leads to all sorts of weird sentences involving the phrase "master
> master", which for newbies especially can be really confusing.  I
> found that introducing newbies to the concepts of distributed version
> control goes much more smoothly when the "primary" branch is not
> called "master", as it avoids the need to understand that there are
> various different copies of the "master" branch where either only one
> or none of them are actually master branches. Just writing this
> paragraph makes me itch from having to distinguish the different uses
> of the word master.

Sure, each person's mileage may vary, but personally I've never used
the phrase "master master", it's always "master's upstream", or
"origin's master", or something else. And I have no trouble realizing
that "master" is different from "origin/master".

> So while it is indisputable that what you call "ideological reasons"
> really pushed this initiative into the public consciousness I think
> there were and are a lot of us who are quite happy to support the
> movement simply because we think using a word which (in English) has
> multiple Noun, Adjective and Verb definitions is a poor choice for the
> *name* (Proper Noun) of an arbitrary artifact, especially when those
> definitions will likely be applied to thing being named. That the
> phrase "master master" is in our vocabulary is a horrorshow. To me it
> is not unlike naming someone's two children "Run" and "Slowly". Who is
> going to understand what the heck "Run, Slowly, run slowly!" means?

I disagree. English speakers have no problem with words that have
multiple meanings, the word "run" has hundreds of them, and people
keep using it. And as I said, "master master" is not in my vocabulary.

Moreover this usage is already part of the English language, there's
master key, master bedroom, master copy, master record. Somehow the
music industry doesn't have a problem dealing with multiple master
records.

If you personally want to use another name, go right ahead, but for
many of us "master" is a perfect name, and more importantly: a
perfectly fine default name.

Cheers.

-- 
Felipe Contreras

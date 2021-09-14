Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ED1C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455B161178
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhINTMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhINTMS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3DDC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 12:11:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hx25so658446ejc.6
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SJhxg18OFjUYiBxr4GSj+Wm0cidzo9ggZj3gp69UMwU=;
        b=FsNaX6r/LPN3BOaI4MIuXroUYUWS52bvCBDXnm2eeVbAUnLxOshoHJ7eRCIPlUMW4d
         DsDUfhSah6Bo5tw4YTt1P72OKUpdq+mjf7ph2qeVuC+MbIN7TCGtN1jvWhmPLpezeYf4
         jAlk9al7xl+8cYgIdkEsB7yTC4LX+KGlOVD3lJyCr31j8SAEnTEc3siW17oqHFCqpRje
         LbAHtsH5lcU5LPJqGo6iFk4IpY0/sRLIDB2QfIxQKneMedC5Ef0XtQDYW12rS0S1yTQ0
         9qvShLqBwwT5cw0Emgyz9v/cj+ujurhjcVokZj3PoBGIzCpkRkqc06/o5WW6ZwEJMcXa
         NdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SJhxg18OFjUYiBxr4GSj+Wm0cidzo9ggZj3gp69UMwU=;
        b=tQ2FiikJUf2tgkBb3J8dyKgMnfvBqC4w1eNX5iHD9JC96Jxe3eKesKgS9BkVTCmeWX
         1WCB9eILxQAQAOwvNBLV/UStwz1/IBOxtlIEYfXZVzzl0kmuieFR0j6Fl+1Kr8uCkYwg
         g0sthWcKu2+73cht3n2rfTHNJ0U2J/cY1zxwklFq+405JrPHGYTSvEvCw6RSvWSQl7T/
         +kpxU/ra/Eb/tBFbM28jIUE3z6d/CWyM3LLAPpYoX//2sDHuXN3y+EF+7urO4TKMuUiX
         IoQ5q/W3ssAz7BuxsoL3UBvMQEcbxCcuqnnmzgYHyMv9n/DIYjf7df1EXntq5sTxNvch
         gs/w==
X-Gm-Message-State: AOAM531CBMhWDB5iDCH2HiCKNY9gCsUQaQYIUpDWGq7vcoUT5Y/mX+iq
        lNwLcl5tfHf71N88j2TAhM0=
X-Google-Smtp-Source: ABdhPJwcihgrIlpndw6LbN55hoRZJldlU5RlbCostLN8ZKC1wkArMWvQPsiMmRThW4k7It6qKqe/fg==
X-Received: by 2002:a17:906:38db:: with SMTP id r27mr20632946ejd.338.1631646659059;
        Tue, 14 Sep 2021 12:10:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e21sm235145edj.47.2021.09.14.12.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:10:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: Train station analogy, was Re: [PATCH v3 00/15] [RFC]
 Upstreaming the Scalar command
Date:   Tue, 14 Sep 2021 20:25:10 +0200
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
        <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <87r1dydp4m.fsf@evledraar.gmail.com>
        <87ilz44kdk.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
        <87mtofnzv1.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet>
Message-ID: <87ee9rnfb1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 14 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Tue, 14 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Mon, Sep 13 2021, Johannes Schindelin wrote:
>>
>> > On Mon, 13 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >
>> >> On Thu, Sep 09 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >>
>> >> > In the summary I had on v1->v2 points 1-3 are for v2->v3,
>> >> > respectively, outstanding, addressed, outstanding:
>> >> >
>> >> >     https://lore.kernel.org/git/877dfupl7o.fsf@evledraar.gmail.com/
>> >> >
>> >> > In addition the discussion ending here:
>> >> > https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109082112270.55@tvgs=
bejvaqbjf.bet/
>> >> >
>> >> > For that point: I think it's fair enough not to properly handle the
>> >> > cleanup case in "scalar clone", but perhaps add a note in the
>> >> > commit message that unlike "git clone" this is known not to clean
>> >> > after itself properly on ctrl+c?
>> >>
>> >> Seeing [1] about the planned re-roll I have the above a shot a few
>> >> days ago, see the original discussion at [2] (indirectly linked
>> >> above).
>> >
>> > There is a good reason why I did not engage in that tangent about
>> > deviating from the established `contrib/*/Makefile` paradigm: I find
>> > it particularly unrelated to what this here patch series is trying to
>> > accomplish, and I cannot bring myself to be interested in the proposed
>> > build system changes, either, because I do not see any benefit in the
>> > changes, only downsides.
>> >
>> > I find the distraction unnecessary.
>>
>> Perhaps I'm reading too much between the lines here, so forgive any
>> undue knee-jerk reaction.
>
> Okay, let's try an analogy.
>
> Imagine that a person is asking for directions to the train station. And
> the other person is replying by asking "did you know that this train
> station was built in 1878? It is actually quite interesting a story...
> [and then goes on to describe the history and what excites them about
> it]". Now, the first person tries again to ask for directions, again does
> not get an answer to that question, and is slowly starting to look at
> their watch. The second person, being completely oblivious to all of this,
> goes on with their wonderful story about the train station and its
> cultural heritage. So the first person walks a bit further to ask a third
> person, but the second person is not done yet and says "but you haven't
> heard me out! That's disrespectful!".

To be clear that's not what I said or meant. I wasn't saying you had to
exhaustively hear out some argument or participate in a discussion
you're not interested in.

I am saying that if you're soliciting feedback and you get some, and the
person giving you the feedback sends you pings back, as I did here:

    https://lore.kernel.org/git/871r6axban.fsf@evledraar.gmail.com/
    https://lore.kernel.org/git/87mtoxwt63.fsf@evledraar.gmail.com/
    https://lore.kernel.org/git/877dfupl7o.fsf@evledraar.gmail.com/
    https://lore.kernel.org/git/87r1dydp4m.fsf@evledraar.gmail.com/

That it would be nice to at least reply with some brief comment to the
effect that you're not personally interested in improving this area.

Now, shortly after you send this you re-rolled the v3
(https://lore.kernel.org/git/pull.1005.v4.git.1631630356.gitgitgadget@gmail=
.com/)
with a note of:

 * Removed the [RFC] prefix because I did not hear any objections against
   putting this into contrib/.

I don't know if you wrote that after this reply, or really didn't see
any of above, but that's a really inaccurate/misleading comment
considering that context.

> Just imagine for a minute how you would feel if you were the first person.
>
> And that is how I feel asking for reviews about the Scalar patch series
> and then being forcefully dragged into that tangent about the build
> process.
>
> I find the well-established paradigm to keep contrib/'s build procedures
> as confined to their own directory as possible the most reasonable way to
> handle the build by virtue of _not_ polluting the top-level Makefile
> unnecessarily. All of your objections strike me simply as personal
> viewpoints, not as technical arguments, and they fail to address this
> "pollution of the top-level Makefile" problem. I therefore strongly
> disagree with your suggestion that the build system should be changed, I
> would even argue that your suggestion should been dismissed on purely
> technical grounds, and I wish you hadn't forced me to say this as
> forcefully.
>
> And even if I looked more favorably on your suggestion to change the build
> procedure, I find this distraction about the build as little constructive
> as the explanations about the train station's history above.

If we're indulging each other, here's my version of that train analogy:

We're in the business of selling a sugary drink that comes in a red can.

We've got a big factory with an attached train station, and all the
trains that move our product are also red.

Now, some of our customers want the new purple colored sugary drink
we've cooked up. A new purple factory's all set up for making them.

But for some reason the part of the business and distribution plans call
for building a new purple train station parallel to our existing one.

All purple sugary drinks are expected to be moved on purple trains, all
our conductors will need some slight re-training and switchover time to
flip-flop between red and purple trains. Issues with purple production
floors and purple workflows will need to be ironed out.

We did a survey of our customers and most of them weren't even aware
that there was such a thing as train. Or perhaps they've seen other
trains, but most haven't seen our trains.

Trains occasionally need field servicing, luckily our fleet of red
trains is set up to carry its own spare parts. Purple trains can only be
serviced with the assistance of a red train.

A product survey asking customers whether their enjoyment of the red or
purple sugary drinks might be impacted by the color of the train they
were shipped on only resulted in puzzled blank looks from the
participants.

The current state of the purple train station and its fleet of purple
trains is that it somewhat works with some hiccups. The currently built
purple train station omitted any sort of train track for leaving the
station though. It should be easy to add one, but...

The manager of the purple train project has been asked whether we can't
just have our red machines in our red factory make the purple sugary
drink, which we can then load on our fleet of red trains. Why do we need
a new parallel rail system when we really care about customers drinking
our delicious sugary drinks?

In case it's not obvious:

   {red,purple} sugary drink  =3D /usr/bin/git & /usr/bin/scalar
   {red,purple} train station =3D ./Makefile & ./contrib/scalar/Makefile
   train track for leaving the station =3D make install (AFAICT your
                                         current patches have no
                                         installation mechanism)

> Those
> suggestions do succeed in derailing the conversation about how Git could
> scale better, how Scalar _does_ teach Git how to scale better, and about
> how to teach Git itself more and more of Scalar's tricks.
>
> If you have ideas how to teach, say, `git clone` to perform a couple of
> Scalar's tricks, by all means, let's hear them, or even better, let's see
> those patches. If you want to change the build system, still, I cannot
> stop you from sending patches to that end to the Git mailing list, but
> please expect me to be uninterested in them in any way, and to prefer to
> spend my efforts to improve Git elsewhere. If you have other ideas how to
> improve on Scalar in a user-perceptible way, however, I am all ears again.
>
> I hope this clarifies it, without the need to read between the lines,
> Johannes

Whatever the end goal of the patches you're sending part of them is
proposing a given approach to go from A to B.

I find it odd to be claiming that the end-state is so important that we
can't spare time to discuss some of the implementation
details.

Particularly in this case, where I've sent a mostly working patch-on-top
which I think should be clear from context I'd be willing to finish up,
so it's not like it's just pointless nitpicking with no end-goal of a
code improvement in sight.

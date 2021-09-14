Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F0BC433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 18:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD42661151
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhINS0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhINS02 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 14:26:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3722BC061764
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 11:25:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q3so176647edt.5
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SeDUFu0xxvfouIUgtUXMo6mg4JAX/3pWfb/PfZRhHjU=;
        b=Uhqc4gf8lIVJM9PdtDyrUdhc7sPmpztFI5xFuJX18z/+qOZnYiAI4hkP2T3IedRkRP
         lifnB7Ql9Ikmxs/mGA+bteCVBOv3kS/4Z77D3H5op4M0lcBqO5n6mAxho0Ag8jmjFtvF
         u+2+Z1wZk1jhPkfxpV7lrlRDVwxF7FQbvPK3zKfiuZerjsIowPHDZKmdKdf9zYJiHGsE
         5EgjSlDuUjX5qBrw6cx2sMvMRJK8dUeer4hsTaHTcWmCrnlZCeAq6smuO94tGS3HtRoN
         UmUas108bTILNazv9cX39YE3ROkVfU50L3jD6CMaNPKd/dmooc+541xR4MTk/G333oy2
         C5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SeDUFu0xxvfouIUgtUXMo6mg4JAX/3pWfb/PfZRhHjU=;
        b=7d9LrT5qPsBVIpczPhcH+C9QmAn3L5uy3eyekpHEYvH27FKkz1TNvI73uusLgfUJpY
         v5H3I/vd5zs4QllWPwrLVlAa+z/+Zc3TiBkk9QoJpRgXAH47q6yDi3LQep26BYI3FoA0
         BxF2BEy0OuFdkbp/PP2lNpslfcwPSTnuQO1kRQZtVUc40RtulLPx2t9g+pOXB43SQl0H
         NMIlYRqq6+1HEwBUQ31Tx+66TIQoKEvH18Htb4oBMikQoTGIbT9eh8eNctNE767FHJdJ
         t/WXtLCVfjFGtXgtXw0qYXl83s5ZvATENlUkwlNZpLk6zjmZpZptFuEnuNioaqdxvDAB
         3O+g==
X-Gm-Message-State: AOAM532DpapmlakPW3mxiJSCHWj3N9OCPnyxSw9oO0E8/nrprdwb6KID
        LJ7Dlc4lgIcuWp3DE71BnS4=
X-Google-Smtp-Source: ABdhPJzXNSK47/+Dm8WPtjIFMY5b0TQlXnFY8KJ4+Y3xxSQOLnsBOSq5pJDT40RHJowhxGxGOptDFQ==
X-Received: by 2002:a50:fb06:: with SMTP id d6mr20379694edq.31.1631643908704;
        Tue, 14 Sep 2021 11:25:08 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w25sm5928386edi.22.2021.09.14.11.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:25:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: Train station analogy, was Re: [PATCH v3 00/15] [RFC]
 Upstreaming the Scalar command
Date:   Tue, 14 Sep 2021 20:09:21 +0200
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
 <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <87r1dydp4m.fsf@evledraar.gmail.com> <87ilz44kdk.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
 <87mtofnzv1.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109141432520.59@tvgsbejvaqbjf.bet>
 <xmqqilz32hhr.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqilz32hhr.fsf@gitster.g>
Message-ID: <87ilz3nhfg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 14 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Okay, let's try an analogy.
>>
>> Imagine that a person is asking for directions to the train station. And
>> the other person is replying by asking "did you know that this train
>> station was built in 1878? It is actually quite interesting a story...
>> [and then goes on to describe the history and what excites them about
>> it]". Now, the first person tries again to ask for directions, again does
>> not get an answer to that question, and is slowly starting to look at
>> their watch. The second person, being completely oblivious to all of thi=
s,
>> goes on with their wonderful story about the train station and its
>> cultural heritage. So the first person walks a bit further to ask a third
>> person, but the second person is not done yet and says "but you haven't
>> heard me out! That's disrespectful!".
>>
>> Just imagine for a minute how you would feel if you were the first perso=
n.
>>
>> And that is how I feel asking for reviews about the Scalar patch series
>> and then being forcefully dragged into that tangent about the build
>> process.
>
> At least to me, how this Makefile for Scalar should interact with
> the overall build process does not mesh well with the story about
> hwo direction to and history of the station are unrelated.  If we
> plan to start from contrib/ and eventually want to make it a part
> of the core Git (i.e. "git scalar <subcmd> ..." becomes just like
> "git bisect <subcmd> ..."), we would eventually need to see the
> recipe needed for including "bisect" and "scalar" work the same
> way, no?
>
> I am getting the impression that such a unified build process is
> =C3=86var wants to see at the end, I am not even sure if you do from
> the above "analogy".  Cool down a bit, perhaps?
>
> The following assumes that you share the goal of making "git
> scalar" just like "git bisect"---another first class citizen of
> Git toolbox, the user can choose to use it or the user may not
> have a need to interact with it, but it exists there by default
> and is not an opt-in add-on component.
>
> I would understand it if your plan is to convert to a unified
> build procedure at the very end of the upstreaming process, and
> not while you populate contrib/ with more and more scalar stuff,
> because the Makefile bits for the entire scalar, while not yet
> upstreamed, has already been written as a separate procedure and
> having to convert the whole thing upfront before you can start
> trickle parts would mean you need to (re)start the process.  And
> I would even be sympathetic if you felt it like a distraction.
>
> But at least I view it as a step that needs to happen sometime
> between now and at the end.  I do not yet have an opinion on
> which one is more pleasant, between (1) having to deal with a
> single Makefile that needs to be aware of two different locations
> *.[ch] lives in, and (2) having to deal with two Makefiles that
> duplicates definitions and risks them needlessly diverging.

For what it's worth what I had on top of this is not (1) or (2), but a
(0): I.e. there isn't a contrib/scalar anymore, I moved:

    contrib/scalar/scalar.c -> scalar
    contrib/scalar/scalar.txt -> Documentation/scalar.txt
    contrib/scalar/t9099-scalar.sh -> t/t9099-scalar.sh

We build, test, and otherwise check (e.g. "make check-docs") it by
default, what we don't do is install it unless you ask. You need to run:

    # Or any other install* target
    make install install-doc INSTALL_SCALAR=3DYesPlease

It could be be kept in contrib/scalar/ even with that sort of approach,
and it would still be simpler than the two-Makefile approach.

But just moving the code, tests and documentation where everything else
lives cuts down an all sorts of special cases, file globs in various
places (e.g. doc lints) will just work and won't need adjustment.

> I also would understand it if the reason why you want to keep the
> top-level Makefile as intact as possible because you sense a high
> probability that scalar will stay in contrib/ and even turn out
> to be a failure.  Keeping the build procedure separated certainly
> will keep it easier to yank it out later.  But I do not think
> such a case is quite likely.

For what it's worth the WIP patch(es) I have on top of it will probably
make such a thing even easier, not that removing it from the tree would
be much of a problem in either case. It's mostly a few lines added to
lists in various places in the Makfile.

If I were to clean this up properly most of the changes would be
teaching the Makefile that it can build N number of named top-level
"special" commands that get dropped into bin/, not just the "git" we
hardcode now.

If you're interested I could try to clean that up and send something on
top, but given the tense-ness of the discussion & unrelated but relevant
patch queue I've got outstanding wouldn't do so otherwise...

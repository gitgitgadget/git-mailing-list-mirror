Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1299C2BBCA
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 14:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9712423A79
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 14:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgLHOiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 09:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgLHOiX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 09:38:23 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3169C0613D6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 06:37:42 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r7so5203449wrc.5
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 06:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XhZP1VgiwuHFDARvl6ViawM1ChKZRj0E3fCaZzWEoSI=;
        b=prjeFBn8f9YsjIFjo+htrvIgIouEz1Azv9XxPB7zbDWjyH+U5tv/FQB7ujHUOz6UX9
         Tb/o20vol/BvUVnt/4/tPckczzGR60G8Eo7r9PYO8Vz6m3asYjD14br38UIUAkFv/51N
         FCKHDPIrmSX+3zK3VVAYU2Nkci0xEhtaZBdLFz6zsRK8gxgM2d+seXwpsUeLj2cNwkfL
         dXG1uBM3NoQKedjO9+JyV99aJtBDOwTXwkMgFiju1PST2XQMTRr3RWa/jBkspd2yoYIY
         YjoflHn8lzT2otwYqQF2zerVuA/g3qdG1oIrl5j3X14nmbl6XX5ucQeFcdTE8M+0Ps2O
         eMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhZP1VgiwuHFDARvl6ViawM1ChKZRj0E3fCaZzWEoSI=;
        b=PzJQEgr+g6M51JSIBL65SRbWnSoD4iKIiUNLAt3NihttOWbfXbLO7Laj1qWZ2NjO+E
         c1g2wI5oLjUaQholR8ImIyvuGSJz5/Plp78V/HK9I8QEz0GX49mnv0zynq70V62iBRgT
         QYoQMjTrEF3zNqVKOr10g6uTDBgMmkyp4SfS0RyedItiG9HcnV3cKwLYd9RA07OyIS8X
         LRaR0M79WD/VfGj9tUt+pTxgfWHzyeVQwfPsbigVqyDoR7kWrXKWp1HTT6wNUCGnwwnx
         dRmE3PnuBkfwOFJsgIjlt9FfynhW1qw0KV9iV92ayqUBPVgjoRbdXX8QDieZTzG7GNZV
         RB8A==
X-Gm-Message-State: AOAM532QT/I3N2CeqMU2YfDgDE9jIhTZmq6lEMIztxbsA1ZVrQ8m2bdz
        I/H2UAD0fxYLXXhi8A/l0cwIHHew4gk/mpAX9q0=
X-Google-Smtp-Source: ABdhPJwJCzmZzx6N/48PLF6/h/Qs8ef+3zqjQl3rIY5Ku+1ZYRiFlzb1Xggqii4VUYJVUA+cREVxWLdscC6Y5aVWyj0=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr24718994wrr.319.1607438261659;
 Tue, 08 Dec 2020 06:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
 <20201205195313.1557473-2-felipe.contreras@gmail.com> <xmqq8sa99wh3.fsf@gitster.c.googlers.com>
 <CAMP44s1ZDXzGfEqpTeiG=aGAYK40ebnBLQKAbA7KGtcePGARfw@mail.gmail.com>
 <CABPp-BEkKMuZHWJ8mrFUFm3okDDsMHeZZNxtGzgq-RLLddMxdw@mail.gmail.com>
 <CAMP44s0g7JLTZZs=O3gUcEiPt--p3gXEPHL0GsBqoqweKA=9Rw@mail.gmail.com> <CABPp-BESMs1tuVoLFMy-BahSChFz7oANqTaeJShFa_zDbEnvBA@mail.gmail.com>
In-Reply-To: <CABPp-BESMs1tuVoLFMy-BahSChFz7oANqTaeJShFa_zDbEnvBA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 8 Dec 2020 08:37:30 -0600
Message-ID: <CAMP44s2JMNML2a8ckdrorgMH6x+NduvWsvRn-p6O=XbYBofNgg@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] doc: pull: explain what is a fast-forward
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 7, 2020 at 7:23 PM Elijah Newren <newren@gmail.com> wrote:

> Yeah, and the number of "fast-forward merge" instances suggest I'm
> losing the battle on "fast-forward" not being a merge but a different
> thing.  So maybe I'm losing multiple battles here.  :-)

In theory it could be both. I just don't see how.

> You have very compelling arguments that fast-forward often serves as
> an adverb (and if I'd thought a little closer, I would have remembered
> that I use "fast-forward update" myself).  You have me convinced.

Great!

> However, I am somewhat less convinced that "fast-forward" doesn't also
> serve as a noun or a verb.

I'm not saying it doesn't serve as a noun or a verb. It is certainly
used in that way *in addition* to being an adverb. I'm just saying in
my opinion it's primarily an adverb.

> Perhaps you are trying to argue how it
> *should* be used rather than how it *is* used, in which case I don't
> have any counter-arguments for you (I'm less well linguistically
> trained).

Not quite. I agree it is used both as a noun and a verb. And I
wouldn't attempt to mandate how words should be used (I'm against
prescriptiveness).

I'm just arguing from the point of view of the mental model. There is
no such thing as a fast-forward object.

Take for example the word "calibration". It is a noun, but you can't
point to any calibration thing. It comes from the verb calibrating,
and such conversions are called nominalizations.

I'm currently re-reading The Sense of Style, and it's interesting that
in Chapter 2 Steven Pinker mentions precisely these nouns, which he
calls "zombie nouns". They certainly do exist, and people use them,
but they suck the lifeblood out of prose. Take for example
"comprehension checks were used as exclusion criteria" (zombie nouns),
compared to "we excluded people who failed to understand the
instructions" (live verbs).

This article from writing expert Helen Sword does a great job of
explaining them:

https://opinionator.blogs.nytimes.com/2012/07/23/zombie-nouns/

Yes, "a merge done in a fast-forward way", is a "fast-forward merge",
which can be nouned as "a fast-forward". It's just not very alive.

> The fact that Junio expressed surprise upthread ("I thought
> that the idea that the word can be used as a verb...was given and not
> something anybody needs to be explained about") also suggests that
> usage of fast-forward as a verb is common.  Anyway, I think trying to
> treat "fast-forward" as solely an adverb results in awkward phrases
> like "in a fast-forward way" instead of just using the much simpler
> verb form.

Yes, it is common also. I'm just saying unless there's a "git
fast-forward" command you can't really tell git "do a fast-forward",
what you tell git is: "do a merge in a fast-forward way". It's a valid
way of thinking, just not the way I think.

BTW, I find it interesting that there are many instances of
"fast-forward update" in the documentation, and back then I did create
a "git update" tool (essentially a copy of "git pull"), so this
suggests there's a void that such a tool certainly would fill.

With such a tool we would have "fast-forward merge", "fast-forward
pull", and "fast-forward update", which indicates that adverb is the
most natural notion.

> Also, re-reading my earlier email, it looks like it could easily come
> across as curt.  My apologies if it did read that way.

No worries. I didn't take it as such. Same from my side; I'm just
stating my opinion.

Cheers.

[1] https://github.com/felipec/git/commit/d38f1641fc33535aa3c92cf6d3a30334324d3488

-- 
Felipe Contreras

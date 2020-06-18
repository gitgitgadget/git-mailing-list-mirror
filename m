Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F86CC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 07:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F91208D5
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 07:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4zLNaSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgFRH55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgFRH5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 03:57:55 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7AFC06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 00:57:55 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id v19so1273117qtq.10
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 00:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=liEQ1ucRMtGZ58Kfbs4/tFGRiGPd/EJ/V/gDBNx//uM=;
        b=d4zLNaSiGIvhYSVl2llapNIK7wjAuqb74uHndix0AeKzPM6zP9ahNkEDi2JxIUf1XD
         YwHuqlTp3lBaLZWgnEteTM7ZNhCuDuMwYdBD32yOhkHfyR1WbnfzEddQNBNLNy0LaeOb
         KcQ6e8mvRcZEicLIe9Axmi0SQ6NLZBekqVVw62Rc+PmDXpEFmmyiI/wcSqIMLnKBoE+s
         0DcN1XVJWhQ/QGbzSVhOp5J319ijfhI/DSwx3BB6QrIJQaZbd3nnjsZQqsyDL2WqYnOJ
         3zZWT+dh/UCs1p+uX08Au+QCwjFGYXn//XZA8KhXMV4k5wMyHKaB4IqzPFD9qND2ClNL
         Vp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=liEQ1ucRMtGZ58Kfbs4/tFGRiGPd/EJ/V/gDBNx//uM=;
        b=mIuDt7Ob4cLBUzENbAcmzLHgPySgrPvLLtPszveoifSRbvv3H3bUxbI2OIGvnfXUT6
         S8QfD62AACl3fcbkGHEXNtVZh5yn1bvorV1bpmjZVaDwMhoimvEt3oUg9ybOI/q+G0qi
         sP9fZHGGhPuCC8tpTOmO+MOr12f7R6Nl2T84xocIgIRGmhnS4Ur4u897XOgCSXcb3EqC
         2gTWdKV94Wf4E8HXsLT+Ehv9yJkvNTL7nhg7fLBOSxwaMvwQ+MYN97pq+rxK5ecQi2vX
         ZP0UjIeiFkWexA2sBHrabOTmc2mp/4JBvK5/q4Y9pIlhDO23VoTs8Ck3H+omwi5MVlj7
         oWPQ==
X-Gm-Message-State: AOAM533KMFUd2Ht1rja/vT4mWvJ3+YgU7zAIeQsXTVtPbifVoIWeh6z0
        kkcWjbWhcnG4o4mwPzG7kRNEBgdbecPoAVWC2G0=
X-Google-Smtp-Source: ABdhPJwHqPjEI94NVlPYOotDeqC79Ec+mfnQQ386e6YKX8YuK9bDCCBEuDJ8S6uSHXw8FOF3UcsvtnafQ9SpSUJiuw8=
X-Received: by 2002:ac8:664a:: with SMTP id j10mr2971940qtp.85.1592467073813;
 Thu, 18 Jun 2020 00:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
 <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com> <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
 <20200616074316.GA21462@kitsune.suse.cz> <CANgJU+XzD9Nnnu4qWExpOUBy+u1=23SRCQy-=6aAVFJAowkjYg@mail.gmail.com>
 <xmqq5zbpv53g.fsf@gitster.c.googlers.com> <20200617201037.GA86579@google.com> <20200617201709.GB86579@google.com>
In-Reply-To: <20200617201709.GB86579@google.com>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 18 Jun 2020 09:57:42 +0200
Message-ID: <CANgJU+WbPgSTxQ=G3sFSvNFQ1cL3onYk5yKLBR=3AqWeEUCfZQ@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        =?UTF-8?Q?S=C3=A9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Git <git@vger.kernel.org>, newren@gmail.com,
        philipoakley@iee.email,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 17 Jun 2020 at 22:17, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Jonathan Nieder wrote:
> > Junio C Hamano wrote:
> >> demerphq <demerphq@gmail.com> writes:
>
> >>> kind of confusion. Consider how this conversation goes for us:
> >>>
> >>> A: "No you need to fetch trunk from the remote, then you need to merge
> >>> it to your local trunk and then push it to the master trunk".
> >>> B: "Ok."
> >>
> >> Hmph, why isn't the last one "trunk trunk"?
> [...]
> >> What I am trying to get at is, after changing the name that is given
> >> by default to the primary branch in a newly created repositories by
> >> "git init" to 'main' (which I am OK with, and it seems that the
> >> major projects and repository hosting services will be doing anyway
> >> with or without getting themselves in this discussion on this list),
> >> wouldn't we risk the same "master master" confusion caused by and to
> >> those newer users who learn 'main' is the word given to the primary
> >> thing?
> >
> > I think Yves's point is that when the tool you are building has a
> > component named $FOO, it's confusing to also have a branch named $FOO.
> [...]
> > In particular when building distributed systems, historically it has
> > been common to have one of the components being built be named
> > 'master'.
>
> Of course I missed the other point --- hostnames like master.<domain>
> (e.g., a hypothetical master.kernel.org), refering to the source of
> truth for something that then gets replicated.
>
> I don't think we're likely to see hostnames like main.kernel.org
> because it's just *so generic* as a word.

Yep, you summarized my point well. I would say master.kernel.org is a
correct use of the term "master copy", and the use in the branch name
is simply not. My "master branch" for git.git is NOT *the* master. It
doesn't make sense to call something "master" and say it means "master
copy" when there are actually multiple copies of the master. That
isn't what "master copy" means.

So I would say that since in practice very often there will exist a
repo which is considered to be *the* master copy of the repo having
"master" as a default branch name is unhelpful.

And as you say "main" does not have this problem to quite the same
extent. Although frankly I could see "main" being a common term in
more distributed development processes where there might not be the
same concept of a "master" repo, but there might be a "main" repo
where people commonly share their work.

Ultimately if I was the decision maker here I would be choosing terms
that are as workflow agnostic as I can find. "main", "master" and
"primary" are not workflow agnostic, they are if anything a bit
workflow opinionated. "trunk" on the other hand seems pretty
self-descriptive and doesn't have much baggage. It's bark is worse
than its byte however. :-)

cheers,
Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"

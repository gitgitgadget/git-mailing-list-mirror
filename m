Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19026E92FFD
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 07:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343669AbjJGHUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Oct 2023 03:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343670AbjJGHUk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2023 03:20:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6F2BF
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 00:20:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so478978666b.3
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696663237; x=1697268037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XFDlK4XncZ+sK17dScX31VD/QukNMiH3vsqrHHogpc=;
        b=L+b9Q74mT/givUn8jlUcublqrx1cr+sFO5zqFGJoxihni348OlJCsJ+kYTUUBdvlLP
         Xpa4t218nBebmntGj45dLzG47wHNWDiga9PvPupYy1HtOv77SlfjopU3WdLv1gGkm4xF
         L5alPdRsSqF349CeC876vyG5q/Jh4OSX1NEmJuNdsenVSartkPq74oUsw4TKSV1W/22d
         gt0oryLqEdbsI9W8vvF+5QJbCMmQtd6FxkB3m4VRUkZG1dQir7MBTwVaUO5PZRxYgeTk
         kThU8B4p1JRUF6b4y8Ki0WE6t37GeCmjma7ma0qxg6diVOuRm9aAwHoiTYOhRbrFuYLP
         lK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696663237; x=1697268037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XFDlK4XncZ+sK17dScX31VD/QukNMiH3vsqrHHogpc=;
        b=e8M2RrJbmlfbRJOo8fdXBJtS6CIgj4EpkmqxpxozaMtBZDR33K9b5DLSbf7mt9A6x1
         fjit6feCnCqGu70HaxXLZd23AiIMvJmTcyYp6x5+f9RFNU8kYAVyXonxF21IdVPLKAO7
         CC5vUQDX49MFr9Hue4cGbl9rDYrEHYtDSraXNl7eTBbLl24aiE9799fBqNjGdaVitTXW
         72mrPv8HsoMeLN64AXhfU/YyzPnHV3hg7GcXmyexL06MsxhYmha/VYvOSHdlHp74Rm4q
         u02C089WIVJRb/T7mN2SUZmq+h+bTSZJp/R/ItQrUf+iQVk+vEkjIAB1MaibIm6oDTJQ
         p3sg==
X-Gm-Message-State: AOJu0YyznvzCN8H0QHTvtYcJjI9RY4ZnAblC8tRrk3IhADtut7v3M9uw
        wGHOj6GgDnp6AhsWwGKHfxzfvgxINfms54wgz77PMbmzmyA=
X-Google-Smtp-Source: AGHT+IFWo0xmIdZOJ9Ncis1YVIyhPQZ+fhyYtK+kidkG3o4lZFGNOdC1Gi2LLVsxfyLrLtObIlvzuV3sQivIOOLhAlw=
X-Received: by 2002:a17:907:2cef:b0:9ae:3d17:d5d0 with SMTP id
 hz15-20020a1709072cef00b009ae3d17d5d0mr8523163ejc.31.1696663236891; Sat, 07
 Oct 2023 00:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <CACS=G2zsJxP+NWuosZyrFGctJptHNYTrULErRo_Ns41KeMuMqA@mail.gmail.com>
 <xmqqr0m75o0b.fsf@gitster.g>
In-Reply-To: <xmqqr0m75o0b.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 7 Oct 2023 09:20:24 +0200
Message-ID: <CAP8UFD0PKAGchx5iqyZqCdua-KYJcrmO2FfNf_vt7xs=+7YL4Q@mail.gmail.com>
Subject: Re: [OUTREACHY] Permission To Work On Tasks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Naomi Ibe <naomi.ibeh69@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 7, 2023 at 1:29=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Naomi Ibe <naomi.ibeh69@gmail.com> writes:
>
> > First issue is here https://github.com/gitgitgadget/git/issues/635 ,
> > involving changing the "die()" error msg outputs to all lowercase. I
> > found a few files here https://github.com/git/git/tree/master/builtin
> > where the "die()" error msg had some uppercase in them (add.c in lines
> > 185, 203, 205, 211 and 571) (branch.c in lines 521, 525, 581, 597,
> > 599, 627, 629, 643, 650, 652, 776, 926, 954 and 968). If I'm allowed
> > to work on this issue, how many files should I edit? The last closed
> > issues related to this issue had edited five files.
>
> As the "general microproject information" page says, it is a good
> idea to do just one quality-focused microproject per applicant.
>
> If I were on the receiving end to review such a patch, I would
> probably find it is too boring a burden if it had several unrelated
> commands covered by a single patch, and would stop reading in the
> middle.
>
> If I were on the sending end to work on them for real (not as "dip
> my toe in the water and say hello to the more experienced
> developers" exercise), I would probably prepare a series of patches,
> one for each git subcommand (e.g. "add", "branch", "log", etc.), and
> for shared infrastructure files, one for each subsystem that they
> are part of (this is harder to do for a new person who do not know
> what subsystems exist, and which files implement which subsystem),
> but for a microproject, I would say a single file under builtin/*
> hierarchy would be a good size.

Yeah, I agree. In my opinion, a single patch focused on a single file
like builtin/add.c or builtin/branch.c is the best.

> > Second issue is this https://github.com/gitgitgadget/git/issues/302 .
> > Is it still available to be worked on? I notice it was opened in 2019
>
> Stepping back a bit, do you agree with what the issue says?
> Remember, these "issue"s are merely one person's opinion and not
> endorsed by the community.
>
> Before you ask "is it still available", do you know the current
> status (not the status of the "issue")?  Have you looked at "git
> commit --help" to find it out yourself to see if "now" is singled
> out?  Here is what we say in our documentation:
>
>     In addition to recognizing all date formats above, the --date
>     option will also try to make sense of other, more human-centric
>     date formats, such as relative dates like "yesterday" or "last
>     Friday at noon".
>
> So apparently it is still "available".  It is a different matter how
> well a patch that adds "now" to the examples listed there will be
> accepted, though.  During a microproject, one of the things new
> contributors are expected to learn is to convince others the cause
> of their patches with the proposed commit log message well.

Yeah, I think this issue, if it is indeed an issue, is not something
easy to "fix" for a newcomer as it requires to be familiar with our
documentation and perhaps our code too, or to research them enough to
understand what a good improvement would be. So you could perhaps do
it, but it would likely require more work.

> Finally, you do not need to obtain permission to work on anything
> around here.  You work on what interests you, send the result (or
> send request for help, to which others may offer advices if the
> problem you are solving looks interesting) to be reviewed, and will
> be thanked for working on it when your patch is applied.  To avoid
> duplicated work, you might want to say "I'm interested in doing
> this, but is anybody already doing it?  If so I'll avoid stepping on
> their toes", but otherwise, you are expected to go wild on your own
> ;-)

I think it's a good idea to ask if the task would be too difficult,
too time consuming, too big or otherwise not appropriate for a
microproject. But true, we don't want applicants to ask for some kind
of permission. We prefer if they just ask for advice.

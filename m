Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3137CC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8BF207F7
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8kQAi6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHLP4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgHLP4R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 11:56:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5375CC061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 08:56:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a15so2504753wrh.10
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KwjmmZBpjd2llWnjXAm6719h/Addfal5B+CJJ2X+IA=;
        b=X8kQAi6R23rcXn9HR2BsZeanwM0PJGYFBzqhwIjLLLznm27Hctj2iU96wUklqBesGj
         AeLeE2e9P7F46RG8x7wQvXYW/9yHGuh0f6aNCiB9pGUd0iHgpQWqF4LhfLvEoR++EtIh
         B/vs9wbo+AcanJt2mjkMNJhWjp7SDFOz/NNKTdZiHgMfYW+UBjqDwxR0v0GGdeD6hn8p
         aKVlp7sgdUH0S0q4HJp3sqQdOiWTYOTwDMM6t6xvC7qFthversdR+oHzZzzTRedvM2Tv
         RYopauCqvA2cHHUhfIM85RlIEU1B6eFHkmBUZbejzTP0dXf7X18qz3Gqb7dzH337yUf1
         ODkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KwjmmZBpjd2llWnjXAm6719h/Addfal5B+CJJ2X+IA=;
        b=WnoJAShDLrnyaDNuTfxXpAYirne/BQkYkAQIS9vxYHv6Ajfd4vvj5p+RbR+skaUxjR
         y1eT0ODml7f38pJE+HWTvGp2hZG92LJ/MyCNBta41Cln2JMICtJAPjciY+yy1ltpgNY5
         YOsChOsYCFlEwOk0pt7qtTgQWVheOMFrrQm9swOKs29dtabrqKWn1aTKPpQPCh+TutpU
         ofBAmUzM+CwEupR3zLezBMF2FAvrh5y2zP6b0okFsO1bCq+HdfJ3/hsf7s1eMS+Ig3Wf
         9ZaYJjGJwKikj41CCrKdSTkWXfBF54PSqG/ANFI8mi5diUvb26ytyAY1Uomrt9WbgVs3
         x0Gg==
X-Gm-Message-State: AOAM533Xklu12K0SYvok+In+fgTm+5G629nSn3WlpPRbF8fg9b4cM1rY
        6Ci8+5IK45amjB9bUoAXB0xgc/acqdKxJ7KsEiE=
X-Google-Smtp-Source: ABdhPJxcJNzENurJdM5T6nXwXJz90sIASvTTIf/QGuCIVTFv88MWbUd9H5kQwXXP9cXXhi6cseo5Eu/E3xMcC6r0zLk=
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr242899wrn.231.1597247776000;
 Wed, 12 Aug 2020 08:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com> <20200804185057.GA1400256@coredump.intra.peff.net>
 <xmqqr1sms0f0.fsf@gitster.c.googlers.com> <20200804192053.GA1400936@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2008121516560.50@tvgsbejvaqbjf.bet> <20200812141958.GA32453@coredump.intra.peff.net>
In-Reply-To: <20200812141958.GA32453@coredump.intra.peff.net>
From:   Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
Date:   Wed, 12 Aug 2020 21:26:05 +0530
Message-ID: <CAKw82xxOZFcsMw47TSrD7-pXpqO7O0_m84o96iH6+ZVeN9j1uw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 7:50 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Aug 12, 2020 at 03:35:06PM +0200, Johannes Schindelin wrote:
>
> > > That was my philosophy, too, but it's annoying in the meantime as I get
> > > a notification for "your build is broken" every time I run CI. So it
> > > becomes a game of chicken over who gets annoyed first. ;)
> >
> > I am a bit sad to read all this, as I thought that we had reached
> > consensus that the `Makefile` _is_ the source of truth.
> >
> > But then, most of the source files that need to be compiled _are_ parsed
> > from the Makefile.
> >
> > So I wonder what problems you ran into; Maybe we can come up with a
> > strategy how to preempt future instances of the same nature?
>
> There are definitely a lot of lists that are copied from the Makefile
> into CMakeLists. For some concrete data, here are the patches I needed
> for two of my topics.
>
> This first one is for a topic that remotes git-remote-testsvn and
> associated code.

The reason for verbosely specifying the test programs (test-tool,
test-fake-ssh,etc)
was that test-tool required all the objects specified by
TEST_BUILTIN_OBJS, whereas
test-fake-ssh requires only test-fake-ssh.o.

> This second one is for a topic which moved some credential programs into
> builtins (since they link libgit.a and nothing else, there's no reason
> for them to take up extra space on disk). Even if we read more lists
> from the Makefile, I think these hunks still would have needed to be
> modified in CMakeLists because I changed the way they interact with
> NO_UNIX_SOCKETS (instead of not building credential-cache in that case,
> we get a builtin that says "sorry, this was built with
> NO_UNIX_SOCKETS").
>

For git programs like git-bugreport, git-imap-send which are specified
with PROGRAM_OBJS,
we don't know which of them require to be linked with libcurl or
libexpat. That was the reason
these programs were specified verbosely in the CMakeLists. In the
future if a new program would be added
we need to add them to the PROGRAMS_BUILT list in CMakeLists as well
and link it with its library dependencies.

Changing the interaction with NO_UNIX_SOCKETS variable will require a
change in the CMakeLists file as well.

The CMake script was not intended to be a write once and forget
situation, it tries to pull from the Makefile as much
as possible. A few changes are needed, which I intend to do.

Thank You,
Sibi Siddharthan

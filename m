Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB8AC433FE
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D2461153
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbhIVSpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 14:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhIVSpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 14:45:43 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889FEC061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 11:44:13 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id f18so4038765vsp.2
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FvkG4WLHUyyKCmAF81WEElQ6vwMeU9SW6AnGLeEvg0w=;
        b=dKVCA4pctFGttljhMGE74Vx1VVF3Dbmhk/2eD900FJvhFF/ddR2epcmx2lRVebCeas
         C+FaS8QnIRHEQ4n+5HuxU3aroNZmPPu33TBkZB4knJQ8yCMX+LH61OEdnM56SEBMEMtR
         bhn7UPgoENVKj6E6Pp0JCbgh5K0ByHgSx9XuSem9CuMqvxRp/njhT32eZFPURGlnIw/A
         rfKaTPjvMtKnp31vHYzmCH+fIQecnkipFHoWFoxHKsvTX/nJAoWxK55yUhWwGLVUEN1w
         6Y6Il5m4CVXXBl7fEcvYnUX5jBf1ot5xs246ZFJkg9S2ghIlxb4S/G3xJZWocdyRP87y
         EOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FvkG4WLHUyyKCmAF81WEElQ6vwMeU9SW6AnGLeEvg0w=;
        b=PqyiHXfUMtWQbBr4J8/rK96yoglrt5qzVQNJxry70T7i6hutP+AS/J9Hn41J7BuKFd
         97TAltZ5L0ehiuofvGV+8Z9LG+ezngBpQ3GZwFKDBWMKt1XqZzV7QCMBg3ZZ+opxSidW
         ZIA7ZTGqa/rMsWX8NuGqSmb0XvXuLApsO+8yI1eYH95T5h+nSm1fhJ8z/tx9Fg5WO06j
         mwFArTosLKG/f5Onljrc81s4tb58EXUU2p7dl3obqGy1ZI23tbRae6V79mAkxnRGH2sm
         Qc8TxiOwE0WIOhQ8NO5SUnDnJhHrNPctLsOTvgqVEZi4/nZNvodxqkpPxMukJYC8QcDZ
         cVCg==
X-Gm-Message-State: AOAM532DoNmQQZ9pXCcwpZTR3Xy4uAACmHd/UNVEJY4llXthMrJb/WPx
        jNMB0lfVlF4AFYIiwIlcLnqBNIKQXEk1kXvD7d4=
X-Google-Smtp-Source: ABdhPJyvjmDbEYTQeKbzHhz/rLxmHqElAeHltg5xmb5/+o+8pdcfA2Ge7jlb+ex8IZNEWfpINuI21X3Xd0+1ZeKgfFc=
X-Received: by 2002:a67:d51d:: with SMTP id l29mr819111vsj.46.1632336252521;
 Wed, 22 Sep 2021 11:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
 <xmqqmto48ufz.fsf@gitster.g> <YUtiNuUiBU4Xg4gw@coredump.intra.peff.net> <xmqqzgs479d5.fsf@gitster.g>
In-Reply-To: <xmqqzgs479d5.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 22 Sep 2021 11:44:01 -0700
Message-ID: <CAPUEspjjfTJGaPUxvaNeGFFyKJYRurxoraX+2DNg2GF02WXn-g@mail.gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work with DEVOPTS=pedantic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 11:28 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >> I wonder if the attached (with clean-up to remove the tracing cruft)
> >> would show us a better direction.  It feeds a single line
> >>
> >>      int dummy_for_dep_check;
> >>
> >> C "program" from the standard input of the compiler to tackle the
> >> "you are not supposed to be compiling an empty compilation unit"
> >> problem in a more direct way.
> >
> > That feels a bit like we're playing a game of chicken with the compiler
> > in terms of what it may complain about. For example, sparse will
> > complain:
> >
> >   foo.c:1:5: warning: symbol 'dummy_for_dep_check' was not declared. Sh=
ould it be static?
> >
> > Might compilers ever learn to warn of the same thing?
>
> Certainly.  That is the reason why I said "direction", not
> "solution", and I do not think it is beyond our capability to come
> up with a minimal "C program" that would be lint clean to make it
> as a part of the "solution".
>
> For example, would sparse or compilers complain about this?
>
>     extern int incr(int); int incr(int i) { return i + 1; }
>
> > So I'd argue we should go even simpler, like:
> >
> > diff --git a/Makefile b/Makefile
> > index 3628d14f16..4597a126d0 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1277,7 +1277,7 @@ COMPUTE_HEADER_DEPENDENCIES =3D auto
> >  endif
> >
> >  ifeq ($(COMPUTE_HEADER_DEPENDENCIES),auto)
> > -dep_check =3D $(shell $(CC) $(ALL_CFLAGS) \
> > +dep_check =3D $(shell $(CC) \
> >       -c -MF /dev/null -MQ /dev/null -MMD -MP \
> >       -x c /dev/null -o /dev/null 2>&1; \
> >       echo $$?)
>
> I am all for this simplification.  It takes us back to the state
> before 1816bf26 (Makefile: Improve compiler header dependency check,
> 2011-08-30).  But I think that is more or less orthogonal to the
> "you are not supposed to feed an empty compilation unit" issue.

the problem really is IMHO, that we are passing around CFLAGS that
indicate 2 things:

1) attributes that are relevant to how we build and what
2) which diagnostics we want to use

=C3=86var's approach addresses implicitly part of it (most of the
diagnostics are added in config.mak.dev), but I think it still feels
like a knee jerk reaction to the problem, while creating an
maintaining something like "DIAGNOSTIC_FLAGS" which we will only pass
to the compiler when we want to use diagnostic (including -pedantic,
-Wpedantic and -Werror) would be a better approach.

Carlo

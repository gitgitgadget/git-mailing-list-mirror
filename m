Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174F6C43603
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 00:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC9D2072B
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 00:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIEYlpU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfLUAcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 19:32:51 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33157 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfLUAcv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 19:32:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so14063491otp.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 16:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hno4sLic4jbgRvFpCMxQ5/x8r3FWXi+tVUnX1hmwHcI=;
        b=CIEYlpU/kdKKVIk/wOFQ5My8I8aL+IZwXmYWrSL7AfyiXb6Ww5U9F9o+06DyuJOcns
         LCOGKRFqghT75BgscowEocAFnCmrT8DREpqcoJVmIpp1FATs0soPi4Jf/YNMyFh2bLjU
         ONakUSjIZRNdPwuQs3G5ksGg2RGTSqXI9by/bCTVoHjuqMRBwbmEkVGVPE8GI3uwXDEM
         ckEqpWgU1Rh3r5I4LFa/48jvZeV0VaXJ6bNcOGLCJVGKoxLrnyEVqGrdFVJMaYaLeH63
         v+A+0T9iDWo2Nnc2s9YZavfbiq7Shk1lGFi59trcJxAI/TKA31sLUbJrmMrfZjKZlvdt
         4aSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hno4sLic4jbgRvFpCMxQ5/x8r3FWXi+tVUnX1hmwHcI=;
        b=jn1itqXxTDuMTztu9KODN4ry1bHfxGC+3owaZIeVnP/7VEX+JhJ5Wus1DsLWSruPL/
         3+JHGtogYNme3p2KRO7ygoZeSYLvzopy97pkQcqPaGY4bYOYJRGXXNXafS+PgLxV1+xc
         1li1Dn5pWk1UTbjs1SzCp6tnPY9mbETmczLk7oWdWbIIbSa/BTmT5b6afGCiI3jY1qBr
         xE5UA4/Z9u0YwLMUmPFHuwdqwDIyQTqOeYKa2HYCnUrHhzcWLzoZB7Kz1I45rxQPsbg4
         XjNJ5s/rBO6HeP2U09zgk//q7UqFyn5QiDhjk1hiOaO6alzgnU51Q35tVkssY7WtJ82R
         Twzw==
X-Gm-Message-State: APjAAAUhFRTabgkUIyvMZyRpjxrDviFoq07WlSDiEhShpISxAsR1a2qI
        6t5k1JR1sw4zPT7tirp4X/4cVEGEFhdGTTBz+wA=
X-Google-Smtp-Source: APXvYqxSyItzMJyOF6sgYxjVqcgHVyNJJQg0Yrbo88AI5t9MemOZRKcXqasjay73xRcOPGN4SHkWO5VsEW2O1ChNRgs=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr17549031otq.112.1576888370805;
 Fri, 20 Dec 2019 16:32:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
 <13e2056e780b00baf86d4020c0974b6b05ce115b.1576861788.git.gitgitgadget@gmail.com>
 <xmqqimma8z3t.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimma8z3t.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Dec 2019 16:32:39 -0800
Message-ID: <CABPp-BF5MaO60GAXbqYPfEePKyn_K-B_hQXNvTN_L4S6iA_93w@mail.gmail.com>
Subject: Re: [PATCH 01/15] rebase: extend the options for handling of empty commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 1:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Extend the interactive machinery with the ability to handle the full
> > spread of options for how to handle commits that either start or become
> > empty (by "become empty" I mean the changes in a commit are a subset of
> > changes that exist upstream, so the net effect of applying the commit is
> > no changes).  Introduce a new command line flag for selecting the
> > desired behavior:
> >     --empty={drop,keep,ask}
> > with the definitions:
> >     drop: drop empty commits
> >     keep: keep empty commits
> >     ask:  provide the user a chance to interact and pick what to do with
> >           empty commits on a case-by-case basis
>
> This looks like a logical and natural extension of the --keep-empty
> option.
>
> After seeing the stress on "empty from the beginning and ending up
> to be empty" in the description, I somehow expected that we may be
> able to specify what happens to the empty commit separately, but
> that does not seem to be what the patch is about, which was somewhat
> disappointing.

My main reason for stressing both was that I've commits and code that
talked about "empty" commits, but which often only dealt with one of
the two types (sometimes when I would expect both to have been
addressed), so I was just trying to be careful in my explanation of
what it was about.

If wanted, we could implement finer control, but I don't know what the
UI would look like or what the range of options we might want.  Do we
want to mix all possible permutations and have two flags, e.g.
--become-empty=drop --start-empty=keep or --start-empty=ask
--become-empty=keep?  Would --empty=<whatever> imply both
--become-empty=<whatever> and --start-empty=<whatever> or would users
need to specify both?  Do we think all the permutations make sense, or
would we want to limit users to some subset?

The current choice of three covered the things that I had wanted in
the past, and which I think made for good defaults for various
different flags, so I just implemented it.  We could always extend it
later.

>
> > +static long parse_empty_value(const char *value)
> > +{
> > +     if (!value)
> > +             return EMPTY_UNSPECIFIED;
> > +     else if (!strcasecmp(value, "drop"))
> > +             return EMPTY_DROP;
> > +     else if (!strcasecmp(value, "keep"))
> > +             return EMPTY_KEEP;
> > +     else if (!strcasecmp(value, "ask"))
> > +             return EMPTY_ASK;
>
> Not an error but just silently ignored?

Oops, I'll switch it to an error.

> > +     return EMPTY_UNSPECIFIED;
> > +}
> > +
>
> > +static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
> > +{
> > +     struct rebase_options *options = opt->value;
> > +     long value = parse_empty_value(arg);
>
> Ahh, OK.
>
> Wouldn't it be better to make the variable and the parsing helper
> function of type "enum empty_type", not "long", just like the field
> in the rebase_options struct?

Indeed, I'll fix this up.

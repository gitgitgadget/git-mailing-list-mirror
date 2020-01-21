Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CCAC33CAA
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 06:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283C820663
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 06:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBGB4Bpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgAUGkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 01:40:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33524 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUGkn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 01:40:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id r21so1937034edq.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 22:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ej8stRHHj1JRMnxGjIAABQMsdf2QiWzPydZKpdBmAGA=;
        b=qBGB4BpoJryikjOsNcZpibu9azwKmosQKJPmg2OjuKiFRH5YpAm4wKE6HFNWitlHKM
         WhZsM4bZOzpxJuo5J5mUHBjZluVXsVM6xDppH5iMKnVGoROJYt2uMNw8F2ELZUgk9HW9
         annwlmH6/vspYHxxn//49agHg781LM7gLJH2Qg3ooB0+rpcn3uHesKqtSjLLUxzf96KA
         zUC3jZ+RZmfA8ECbG8uUP2Q1MIDNmy5aHBKgdL6E+HMXQQITKfMEAkInmQ9ooNJuz9bB
         UK5+TKN5m+wdoacCUo7ZtNL0rVewjhVvdCkrp01PrNFSaOwg2OLjGfnZnVbQLMvieICO
         4swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ej8stRHHj1JRMnxGjIAABQMsdf2QiWzPydZKpdBmAGA=;
        b=kj9zyaIewAT5vMKRjpcIxno0hZ9veJUQ6NcCXzu+BcwkFG+Su6UZsg6txr8RHWA6zI
         9Utc3Y2+vikQaLOwFN34wfRx6dq840GtPbF7FPLFV9frfyWaNZmV0MfOSNarFArvRCfZ
         TmppmcjxMXdBAlugB0elNE7HPzKzk6ikpnjxv4iFWTor7nXaL4s46Y0GWhRZLc8Emcgv
         PtWbZDSWwB9S7qUf2H0lI30fy82OQ5pM5fpzHBal5FWK0sf9bVxvOfAALpOvFN7RKAGi
         DEBgpsRa50SEIlGKE81+I2UY9Kxs9nGH8donysrLzkgZcf3GFrjFuxqx+Vhcwm95cSRR
         /5Kw==
X-Gm-Message-State: APjAAAXDK2F79DHjADRFQHE9zhh4EeStp+jHv31v6a4+UUPKZaL2hQtw
        K7vCNtptQuf3VH9Q24hkttYLiehaoHHxXZK9Rf4=
X-Google-Smtp-Source: APXvYqzzQ/Cat8ch0mqpiEma5xi44EqlO6HpJL/Hj6NiEEX1FgLE/9v/+d/79Hd167HvOta0Jm35AGacs9IAKkRCoSA=
X-Received: by 2002:a17:906:ce38:: with SMTP id sd24mr2914174ejb.237.1579588840944;
 Mon, 20 Jan 2020 22:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-7-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001202253450.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001202253450.46@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Jan 2020 07:40:29 +0100
Message-ID: <CAP8UFD1T3_1t0Qf3jP1GttNHvaLEWoaeAVeZid6AMH_MAKPjSw@mail.gmail.com>
Subject: Re: [PATCH 06/29] bisect: libify `exit_if_skipped_commits` to
 `error_if_skipped*` and its dependents
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Mon, Jan 20, 2020 at 10:57 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Mon, 20 Jan 2020, Miriam Rubio wrote:

> >       printf("There are only 'skip'ped commits left to test.\n"
> >              "The first %s commit could be any of:\n", term_bad);
> > @@ -676,7 +676,13 @@ static void exit_if_skipped_commits(struct commit_list *tried,
> >       if (bad)
> >               printf("%s\n", oid_to_hex(bad));
> >       printf(_("We cannot bisect more!\n"));
> > -     exit(2);
> > +
> > +     /*
> > +      * We don't want to clean the bisection state
> > +      * as we need to get back to where we started
> > +      * by using `git bisect reset`.
> > +      */
> > +     return -2;
>
> This comment is a good indicator that the constant `-2` here is a "magic"
> number and it would most likely make sense to turn the return type from an
> `int` into an `enum` instead.

Many functions use `return error(...)` and error codes from these
functions and from exit_if_skipped_commits() are going to get mixed.
So I am not sure that using an enum for only some of the error codes
will make things clearer.

> >  static int is_expected_rev(const struct object_id *oid)
> > @@ -949,7 +955,7 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
> >  {
> >       struct rev_info revs;
> >       struct commit_list *tried;
> > -     int reaches = 0, all = 0, nr, steps;
> > +     int reaches = 0, all = 0, nr, steps, res;
> >       struct object_id *bisect_rev;
> >       char *steps_msg;
> >
> > @@ -972,8 +978,9 @@ int bisect_next_all(struct repository *r, const char *prefix, int no_checkout)
> >                * We should exit here only if the "bad"
> >                * commit is also a "skip" commit.
> >                */
> > -             exit_if_skipped_commits(tried, NULL);
> > -
> > +             res = error_if_skipped_commits(tried, NULL);
> > +             if (res)
> > +                     exit(-res);
>
> So we still `exit()` in `libgit.a`? I hoped for a more thorough
> libification.

The exit() calls are removed in later patches.

> Besides, the `if (res)` probably wants to be an `if (res < 0)`, right?

Yeah, I agree.

Thanks for your review,
Christian.

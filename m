Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F113EC4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 07:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B15323B85
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 07:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391532AbgLKH4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 02:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgLKH4i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 02:56:38 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F90C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 23:55:57 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id a11so294591wrr.13
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 23:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwRFdCq/118O1vLtW0eDmXxXy3fwf56VBFG8VfX5zjU=;
        b=DAv+zLzXJg2jc/BflMAlSNP11I5kV1tmmaA/X2TMi28PZlbjIsnP/wcT0jXVuq8Czx
         w8wv79DNOUBoBchTBjhTNJoHYmxyTptIdrVEqWM1lF9sa5Xtm9/7mn6lqnx9DDZDkxgn
         TOHHP4wNkgJawL44fZU2TBF05Ze/tlKwBI2gM2BsfNVpabf3lnsY0+LEsWMjGKGnvvCe
         XUFeHs7k3AhMKHqjtTT3BCeDQwV227Zxbdbp5e5FK+G73D9Rr1nBkXNHeBbHnURIPGN9
         7NXpRLfKJZ2qaDbW6oSVJe8kTRCH3FP1pC7ex4shO17gdaBnBknghgbBpK7MwLzZ1PBD
         8O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwRFdCq/118O1vLtW0eDmXxXy3fwf56VBFG8VfX5zjU=;
        b=l6KZytiaMBsIV/ap2M6WOt+OsmWKejVlxf2uniB3lQY6Qremw13dX4fMANJZpKmE3L
         Dox9PvgssTstjg6vRrQF/xmkp7JC94SKNtcmJHhX16/GEr1mi1sv63MzhL+ZIkKaLAFN
         ClVLWLkxB2W8QTqkwIn6sEiVJ1OWxInQIpK1zWm4wyerAs9b/KnTOyYLZw4Xl8uDYi+E
         LLb8s+JBzBTE2oy20dyOqGGq9d2sqgut1QOPrp/rvizVU1rjR0Q9q1VaHgCAMLDKghDl
         jP7WpWtXzQxhD5Bme14g3qp0hcJTmqKk81VclAWfc8u1qxShKRxuoGPDYkmb2CxjnPBZ
         uI2Q==
X-Gm-Message-State: AOAM533r2K8u5F4S63Cntil9AfnBXj/bfG1bdJ/+3jL3GIzqC9+9dSrk
        cEZZ0PSWuBd1G8GFw5w3g7O5qDd46AuapP63sT8=
X-Google-Smtp-Source: ABdhPJzngr68fPBjP8Z7JEuqpX8VzlqGnWLg94vEC9vOU6g265X4p1ir5zggPcq2/fJnX/KelWZNdiUJoCwzwdkRs9A=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr12430814wrv.255.1607673356432;
 Thu, 10 Dec 2020 23:55:56 -0800 (PST)
MIME-Version: 1.0
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
 <20201210100538.696787-3-felipe.contreras@gmail.com> <xmqqy2i4ltnv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2i4ltnv.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 11 Dec 2020 01:55:45 -0600
Message-ID: <CAMP44s170qZuZqmh_gVLGgJJ5005HzDM0fdQKQamjHkZCOu7_Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] pull: move default warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 11, 2020 at 12:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > Eventually we want to be able to display the warning only when
> > fast-forward merges are not possible.
> >
> > In order to do so we need to move the default warning up to the point
> > where we can check if we can fast-forward or not.
>
> Makes sense.
>
> > Additionally, config_get_rebase() was probably never its true home.
>
> I agree with this point.  I've always found it suboptimal.
>
> > This requires a temporary variable to check if we are in the
> > "default mode" (no --rebase or --no-rebase specified).
>
> Two points:
>
>  - "mode" is so overused a word; a more focused word is preferrable.

There's literally only one instance in the file, and it's a call to an
external function.

Plus, it refers to "git pull" without any --merge or --rebase (that's
the default mode in my book).

>  - by introducing a local variable in cmd_pull() and passing a
>    pointer to it to config_get_rebase(), we can easily avoid having
>    to rely on an extra global variable.
>
> I'd suggest addressing the above along the following lines.

...

> to possibly cause it to set to true, and use that instead of the
> global variable to decide if we want to give the help text.

Yeah, there's only 38 global variables. We wouldn't want another one
which makes the code pretty straightforward.

> > @@ -1040,6 +1029,21 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >       if (opt_rebase && merge_heads.nr > 1)
> >               die(_("Cannot rebase onto multiple branches."));
>
> And this is the point where we finish various error checks and
> starts to run either rebase or merge.  It is as late as we could
> delay the "non-ff and you are not configured" message.  In other
> words, the place chosen in cmd_pull() to move this code to is
> optimal.

Which is right before the fork between rebase and merge.

> > +     if (default_mode && opt_verbosity >= 0 && !opt_ff) {
> > +             advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> > +                      "discouraged. You can squelch this message by running one of the following\n"
> > +                      "commands sometime before your next pull:\n"
> > +                      "\n"
> > +                      "  git config pull.rebase false  # merge (the default strategy)\n"
> > +                      "  git config pull.rebase true   # rebase\n"
> > +                      "  git config pull.ff only       # fast-forward only\n"
> > +                      "\n"
> > +                      "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > +                      "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> > +                      "or --ff-only on the command line to override the configured default per\n"
> > +                      "invocation.\n"));
> > +     }
>
> Either as a part of this step, as a part of the next step, or a
> separate follow-up patch, we should
>
>  - create a single-purpose helper function that only calls advise()
>    with the message and returns; name it show_advice_pull_non_ff().

If we are going for low-hanging fruit there were many in v4 of this
series, which actually improve behavior, not just code organization,
but OK.

>  - correct the if() statement above, so that regardless of verbosity
>    level, we can do _something_ common when the history does not
>    fast-forward.  I.e.
>
>         if (rebase_unspecified && !opt_ff) {
>                 if (opt_verbosity >= 0)
>                         show_advice_pull_non_ff();
>         }
>
> These would allow us to further turn the logic to
>
>         if (rebase_unspecified && !opt_ff) {
>                 if (opt_verbosity >= 0 && advice_pull_non_ff)
>                         show_advice_pull_non_ff();
>                 die("not a fast-forward; must merge or rebase");
>         }

Should actually be something like:

        if (rebase_unspecified && !can_ff)
                die("Not a fast-forward; must either merge or rebase");

But yeah.

-- 
Felipe Contreras

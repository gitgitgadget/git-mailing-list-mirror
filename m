Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FE4C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 10:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BA064EAF
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 10:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhBZKj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 05:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhBZKjV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 05:39:21 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B043C061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 02:38:40 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id l5so2086045ooj.7
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0u9b/6IRn69kkrMFEzVBHxa/0Qswdc574JBhLSK5aik=;
        b=Un9Rqw8/2DUFZOAhxQop+cDQffACi1giak8S7G8V4J5toh60TYWVw3dr6Nhg7GFScy
         8Qxw90LqIpa0WyYud5ll3EmcICz3Vq2/a4vZ9kTfRzjYEfvecQ/F/ZMIYd+gxpwO5p8S
         xoB419ElmJwRb1s1NgLw2PZYYOBo+wafmmWigoYb4g6VFuyglqeKUmpYT1JaQ1ht7rtp
         UyEZmpGNf9wjHpIKuCRmY0Njcnse7zg7e2pHnmD2Kcif07/pQHJ+HAd8kNDoo+EjXZoT
         O4AhS18JBnaeRsjiQHUUP5McbAtH86momOFHdFXfbTkAQC+B0SFCYOY4BorXOYKiWHUB
         3A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0u9b/6IRn69kkrMFEzVBHxa/0Qswdc574JBhLSK5aik=;
        b=HNN0xA2tORgTxm28cdBdoM/UPhj3IebSyKPkwTlet1GD9sMyNRuoDw+L2Ip/QMEJ+1
         liCVDMEVH8dlH6/MIVV4xJ0d77Lv6NXOs//dbjeiFn4rClaL7snoTJ6ewlvcg2btAnnv
         1oY54sBIM1j/cB82JZaFDm7qWYnff2wEQslwbb1/w5mru+kbkqw6E4t3X364lodczB7H
         lyAMmVP/RDSpuNhwKYfjvNykcHCa57IPlgPy8bcF4x8NsYwHop+UX0cAIlrKZz/gY+BB
         rq764HIyM5DwRSOnfMfqjbLfwh/+24lrYFwADM8NO2H1hFWCjOvPaZ67Fr6u6deIpH9C
         ZaBw==
X-Gm-Message-State: AOAM531s1SRC6fHkdrNqP6bpcTyfHalYiQgmdqYlhVvRp0gJ2QYiXN1t
        kzK2y2Lmdcir6XtI3YqONSGhIKno+3rH2m98Td5vAdaW55s=
X-Google-Smtp-Source: ABdhPJwjpxX95fXDLmV7OiscWVaimpDLW0ZcpQ5V8nVunU4K5hiQVuProMQw361myDhk2O6aiW42TG6gx9gnwOBP08o=
X-Received: by 2002:a4a:88ee:: with SMTP id q43mr1818775ooh.61.1614335919849;
 Fri, 26 Feb 2021 02:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210225100855.25530-3-charvi077@gmail.com>
 <xmqqwnuvsw0d.fsf@gitster.g>
In-Reply-To: <xmqqwnuvsw0d.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 26 Feb 2021 16:08:29 +0530
Message-ID: <CAPSFM5eKnqOhDrZWEd-c_sDNMbQkqtMwpFM0zT-gOVHvMtcZnQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 26 Feb 2021 at 02:30, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:

> > Inorder to prevent rebase from creating commits with an empty
>
> In order to prevent ...
>
> > message we refuse to create an "amend!" commit if commit message
> > body is empty.
> > ...
> > +static int prepare_amend_commit(struct commit *commit, struct strbuf *sb,
> > +                                                             struct pretty_print_context *ctx) {
>
> Don't indent the second line unnecessarily too deep.
>

Okay, I will fix the above changes.

> > +     /*
> > +      * If we amend the 'amend!' commit then we don't want to
> > +      * duplicate the subject line.
> > +      */
> > +     const char *format = NULL;
> > +     if (starts_with(sb->buf, "amend! amend!"))
> > +             format = "%b";
> > +     else
> > +             format = "%B";
>
> I am not sure how well this strategy of special case only two amend!
> scales.  What would happen when we --fixup another "fixup!"commit?
>

This is applied for more than one "amend!" or in other words, "amend!"
commit chain. On the other hand we don't need to skip any subject if we
--fixup another fixup! commit because the resulting commit message is
just one liner. But yes if "fixup!" commit is combined with `--squash`
then it comments the complete "fixup!" commit line by finding its length
and increasing pointer.

> Shouldn't the caller, when it called format_commit_message() to
> prepare sb it passed to us, have stripped out existing prefix, if
> any, so that we can always use the same %B format, or something like
> that?
>

I am not sure about this, because I think in the way you have suggested, we need
to strip off the complete subject line instead of prefix. I am saying
this because the
commit message body of "amend!" commit contains the complete commit message
of the commit we are fixing up.
for example :
$ git commit --fixup=amend:HEAD will create commit with log message :
amend! subject of head

subject of head
body of head

and again if we `--fixup:amend` the HEAD commit then :
$ git commit --fixup=amend:HEAD (by default) will create commit with
log message:
amend! amend! subject of head

amend! subject of head /* we need to comment this complete line */

subject of head
body of head

So, I am not sure about the other option to implement it ?

> > ...
> > +             format_commit_message(commit, fmt, &sb, &ctx);
> > +             free(fmt);
> >               hook_arg1 = "message";
> > +
> > +             if ((have_option_m) && !strcmp(fixup_prefix,"fixup"))
>
> Unnecessary () around have_option_m, and missing SP after ",".
>
> > +                     strbuf_addbuf(&sb, &message);
> > +
> > +             if (!strcmp(fixup_prefix,"amend")) {
>
> Missing SP after "," (I won't repeat---please re-check the whole
> patch series before rerolling).

Apologies for this. I will take care of it.

>
> > +                     if (have_option_m)
> > +                             die(_("cannot combine -m with --fixup:%s"), fixup_message);
> > +                     else
> > +                             prepare_amend_commit(commit, &sb, &ctx);
>
> Hmph, why is -m so special?  Should we allow --fixup=amend:<cmd>
> with -F (or -c/-C for that matter), or are these other options
> caught at a lot higher layer already and we do not have to check
> them here?
>

yes, those options are caught earlier and give the error as below:
"Only one of -c/-C/-F/--fixup can be used."
and only `-m` is checked over here.

> >       if (also + only + all + interactive > 1)
> >               die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
> > +
> > +     if (fixup_message) {
> > +             /*
> > +              * As `amend` suboption contains only alpha
> > +              * character. So check if first non alpha
> > +              * character in fixup_message is ':'.
> > +              */
> > +             size_t len = get_alpha_len(fixup_message);
> > +             if (len && fixup_message[len] == ':') {
> > +                     fixup_message[len] = '\0';
> > +                     fixup_commit = fixup_message + ++len;
>
> It would be easier to follow to write it this way, no?
>
>                         fixup_message[len++] = '\0';
>                         fixup_commit = fixup_message + len;
>

I agree and will update it .

Thanks a lot for the reviews. I will do the fixes and update in the
next revision.

Thanks and Regards,
Charvi

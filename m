Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1850BC33CAA
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 06:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEFF24653
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 06:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phc/j/k4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgAUG7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 01:59:16 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45529 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgAUG7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 01:59:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id v28so1884266edw.12
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 22:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXt1RccXxyLKfLBuRe7nvsr1AO0DJuWVph9SCEZdXeM=;
        b=Phc/j/k4YOYDajOAGdt9V/LO09GPcAchjKJQUEy8sN1jbnXUQp0e4KxzszQK8kNX0a
         H55e3idvfIhdnK6DzrehFW0mTQNvGjiI8nOTb2TLTRGb8UQyU8FHtfHqKFpGmnon2FJX
         LtRxktOdDEb5p3iMIBthxRUUQBfH1LcmZTVGGRWuxOVuIQkeXLKdGO3VlkjhR4Z28SxP
         OQP6qnibg4sX+BfD1AsS9uEHlBPjJhrInihoSuV7WvXKblhfU17EHFauw7FlrzBedr3m
         QvU/LymE0VltKmVLBl8OxAy68YvI98C4Gklnmh3LkK0WdU4g/x8DE64gG9qLsy7oukk+
         DZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXt1RccXxyLKfLBuRe7nvsr1AO0DJuWVph9SCEZdXeM=;
        b=Tdr8W3ffKTYZ8N833KwuYhN0Qivmh026nR3wQRukLGpkyN+SFvu862TaAmBNRPqeaI
         7jPH82Sl8bj6cPkNhBRWc5KNbxF7TvF+IjnklHiXMIYJqFaDd5OqV36ZI+m2mRF+HSXj
         0Zl9eSN52UYZXEfqOjoQdld4KEeT8sLUs92nfMNBu/RTfwhCIPK8NSAfOd2ZFgEUXC6O
         L8dxhQf+/Af/Ua/+s4KCJ0BGCMj7nXO6UmtqETVhmHU4utPbunjAXjOepRDeSINT5iWK
         n369IXxgbrWNpKVawSXWMqjEsqS3OQ16AqJbPS2PgD5gRY3r6inGA2KayPuln+I4Tvvf
         KLnw==
X-Gm-Message-State: APjAAAU3nu6bfK3osSKMzgOv6zYInNn2xS9EYr+8NGapktrVjQNbqdK7
        5GkaEpLiYWpPXNQ1mgjh34ewBU2J4VE37nuMsNM=
X-Google-Smtp-Source: APXvYqy8LnnzUVFEUr5Io4NZSqbISmLMmDb1cYjP64SEEcvtWJhWdq3WxW0VlpwHdBiA8hzvDxSb1LVmZOvY9tw+sQM=
X-Received: by 2002:a05:6402:38c:: with SMTP id o12mr2576976edv.273.1579589953554;
 Mon, 20 Jan 2020 22:59:13 -0800 (PST)
MIME-Version: 1.0
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-10-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001202313130.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001202313130.46@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 21 Jan 2020 07:59:02 +0100
Message-ID: <CAP8UFD0MO9wEc=ErEAFm4kSabLKUTp1a5VTPxgDS2yqt+rxXag@mail.gmail.com>
Subject: Re: [PATCH 09/29] bisect: libify `check_good_are_ancestors_of_bad`
 and its dependents
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

On Mon, Jan 20, 2020 at 11:20 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Mon, 20 Jan 2020, Miriam Rubio wrote:

> > @@ -876,8 +877,15 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
> >       int fd, rev_nr, res = 0;
> >       struct commit **rev;
> >
> > -     if (!current_bad_oid)
> > -             die(_("a %s revision is needed"), term_bad);
> > +     /*
> > +      * We don't want to clean the bisection state
> > +      * as we need to get back to where we started
> > +      * by using `git bisect reset`.
> > +      */
> > +     if (!current_bad_oid) {
> > +             res = error(_("a %s revision is needed"), term_bad);
> > +             goto done;
> > +     }
>
> Why not just return here? Ah, there is a `filename` that was allocated...
> it is too bad that we have a mailing-list based review, as the hunk
> context simply cannot be extended in a mail.
>
> Personally, I think it would be nicer to split the definition of
> `filename` from its declaration and move it _after_ this conditional code,
> so that we can `return` right away.

Yeah, I agree.

> However, there is a more pressing issue than that: `die()` exits with exit
> code 128, so in keeping with the idea to hand down negative exit codes as
> return values, should we not assign `res = -128` here?

I think it has been ok when converting git-bisect.sh to C to just
convert `die(...)` into `return error(...)`.

> >       /* Check if file BISECT_ANCESTORS_OK exists. */
> >       if (!stat(filename, &st) && S_ISREG(st.st_mode))
> > @@ -893,18 +901,20 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
> >       if (check_ancestors(r, rev_nr, rev, prefix))
> >               res = check_merge_bases(rev_nr, rev, no_checkout);
> >       free(rev);
> > -     if(res)
> > -             exit(res == -11 ? 0 : -res);
> > -
> > -     /* Create file BISECT_ANCESTORS_OK. */
> > -     fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> > -     if (fd < 0)
> > -             warning_errno(_("could not create file '%s'"),
> > -                           filename);
> > -     else
> > -             close(fd);
> > +
> > +     if (!res)
> > +     {
>
> We usually put the `{` on the same line as the `if` condition (like you
> did in the `if (!current_bad_oid)` line above.
>
> The rest looks reasonable. Thank you,

Thank you for your review,
Christian.

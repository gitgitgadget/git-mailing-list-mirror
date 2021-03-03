Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7D5C433E9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0327C64E56
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376447AbhCDAWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842735AbhCCILP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 03:11:15 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F4EC061788
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 23:37:49 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id h22so22685813otr.6
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 23:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X34Cy9x3FYMnlbxn7OC4ETcMHOGGC5YKkpNUIN/COyM=;
        b=atPN/92lz9apxdPdLU5eh7LrwnS/K6XvnDBdLdMVRGL3zVjXbn9UadekgSwO7nckYr
         9J6Y822tFAhYPmTmo2OTD9NOiuQGn9bWcuvr6h5EonKC64g0gq7BqyZkH+HknzsWBoe3
         pKgGUq75vUBi24ZtxzQr9PImEIUV0WyCEKdgZIKsC2UsxGY5Y5RV+t5zj0ylkUOOg16y
         LSVljqDO8qdRY2eFZmucA+OJB9+K6gpXUi8tv1uvr/USKMHMxa/ueCkoNKhgkmGtyu9i
         m+idAFnhVK2kkeLg9bSVedH2VMGSudGuz79YAq6ZqkaOme/WNypvzFJj7XW8Hv1YKL80
         CBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X34Cy9x3FYMnlbxn7OC4ETcMHOGGC5YKkpNUIN/COyM=;
        b=Afz5dHDmZcougzmXI8QIlQF/Ysf25bZQdx9GJUWrxvi/1HGQP0jlnpRPZcm7KqT3wh
         4g50RmpKHhuDxVlRouNLYOr/zI65r9z2pLtSi42mFljjYHeNe8luD9662E0PV9Xqkh0c
         kOhwY9KziSEeUho8Izx2j1E2h1TcVtXfcwLCBOW5G8tzqeoWyxcHlQTxKDzBwjC65vyz
         L7xGku1rALGHaSshhjfqSted1XZb2IkmsgMdnjuhILpHOAEZnHN6VYf6CsPShTyS83gW
         NiV9nCf/ZOEJ7tnolMfzPK0GSMxvxj2eIN0XUE71MrDBhjTnGeMCCSp4ASN0+p8gi1rL
         gDmw==
X-Gm-Message-State: AOAM532wTN4A3DgRgo3m4jpWD9lxqZIwRujwgNQCn4lXeSEtr2uQEhhH
        pd6pCcjqG3q775jxTXNZWPHPclabokDWt7yk+JQ=
X-Google-Smtp-Source: ABdhPJyNRPrqAx0eQ/ZvH0BKg/oQKNZmdZXDs9agUKil+P7Fms9KwApDdurLE+iUWHNTfZgkjoJygExzd9Fukmu2GlU=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr21542141otq.210.1614757068884;
 Tue, 02 Mar 2021 23:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-3-charvi077@gmail.com>
 <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com>
In-Reply-To: <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 3 Mar 2021 13:07:38 +0530
Message-ID: <CAPSFM5dm7vD8pszCG+JKNb7Hu6Zp48wKXaj9ayxe6yaf6swePA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     20210217072904.16257-1-charvi077@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Mar 2021 at 03:45, Eric Sunshine <sunshine@sunshineco.com> wrote:

> > @@ -105,7 +105,8 @@ static const char *template_file;
> > +static int prepare_amend_commit(struct commit *commit, struct strbuf *sb,
> > +                                                                struct pretty_print_context *ctx) {
> > +       /*
> > +        * If we amend the 'amend!' commit then we don't want to
> > +        * duplicate the subject line.
> > +        */
> > +       const char *format = NULL;
> > +       if (starts_with(sb->buf, "amend! amend!"))
>
> Is the content of the incoming strbuf created mechanically so that we
> know that there will only ever be one space between the two "amend!"
> literals? If not, then this starts_with() check feels fragile.
> (Compare with the code in sequencer.c which checks for this sort of
> duplication but is tolerant of one or more spaces, not just a single
> space.)
>

Yes, so for preparing each "amend!" commit we add prefix "amend! '' to
the subject of the specific commit. And further if we amend the
"amend!" commit then this above code is checked before creating a
"amend! amend!" commit for the user. So I think maybe we don't need to
check for multiple spaces ?

> > +               format = "%b";
> > +       else
> > +               format = "%B";
>
> It's subjective and minor, but this could be expressed more compactly as:
>
>     const char *fmt = starts_with(...) ? "%b" : "%B";
>
> Also, no need to initialize `format` to NULL since it gets assigned in
> all code paths.
>
> Not worth a re-roll.
>

I agree, I will fix it.

> > @@ -745,15 +761,33 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
> > +               if (!strcmp(fixup_prefix, "amend")) {
> > +                       if (have_option_m)
> > +                               die(_("cannot combine -m with --fixup:%s"), fixup_message);
> > +                       else
> > +                               prepare_amend_commit(commit, &sb, &ctx);
> > +               }
>
> This is minor, but the way this is written, the error case and the
> normal case appear to have the same significance, whereas, if you
> write it like this:
>
>     if (!strcmp(...)) {
>         if (have_option_m)
>             die(...);
>         prepare_amend_commit(...);
>     }
>
> then it's easier to see that you're checking for and getting an error
> case out of the way early, which allows the reader to concentrate
> without distraction on the normal case. As a minor benefit, you also
> get to eliminate an indentation level for the normal case, which could
> be important if more code is added to that case.
>
> Not worth a re-roll.
>

Thanks for pointing this out, I will remove the unnecessary `else`.

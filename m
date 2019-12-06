Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2219C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D2C2464E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+G9DLxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfLFNN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:13:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41513 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfLFNN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 08:13:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so7602067ljc.8
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 05:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7tp18kGM5OIwEQWcDibsIQQwlMJnfdXHlF326L3o5I=;
        b=W+G9DLxlLhWS8Az2XcYiO/ADZ5SKOdM5N6l3NIBWTln1WxcuDzIcK3OMh1WFYtrgXq
         mydgGL5kGxPzedTOSlERqvrk2Z0yuXCpx4Lp5fGhuc/f3uYGNBoozlDFdLTUnJwL8Bw7
         7P0QpzKNwVT4q9u5Q/v9JxfpbO/C1tlX3RFn9bmlKY879hH2l+VxTU1b/emJOpYJ7wqa
         wLp65tQYVnHAyEuVUU3sw2J3vnAhjUcQtpAwv+tEIqIwQ4BsSwgBj7Yi6d9g0eS9FE8L
         N0cUuNYb/yBdTWiL0hIoEZuPefHgw5E2dlei49XRk0QgMyk/w8eSQTsC3EAHXeVS3SLO
         mI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7tp18kGM5OIwEQWcDibsIQQwlMJnfdXHlF326L3o5I=;
        b=iRQVP2Ab6Kv4CcfWkGrV5KkQl+tL/ofCxQlQCCKHZFAgYKBelQ8F3QsLCZT2hXlbgk
         lKD25MStfY62p1GeTLYS4BUsCVHVv57mUeRptbO5XLGddLxbmUvuy7lqubO/0GFvrCbU
         7mvLlxqhUNvmoqr1yDOgx22yGmERCY5sqEZcASBuaQjAywMLJlCDwQvAYLjo3CXewgjY
         gyX+awaqYki5z7CYOzyG4q1Yy4QOHwfhwifmR0Fnj4wg2yR7GEo0m+dkmLf4kYnxOVrp
         k0ABmcFNqMtHaWZtk42WGwf0fJbxlPwlDtkKWxDgvuA18A2OdBijhQ6MHwNg8iUxICBC
         anTA==
X-Gm-Message-State: APjAAAWaQcjBQ3UMQQcetWhVH9AQ0rojSO0DEmx5UsAeFWB3POwir7bQ
        lL1vs1dWJy804waHvY/Oi8Mi9eo8RBti+9WYkEMi0YyN
X-Google-Smtp-Source: APXvYqxL2pgMBbjyNipiJ0shYyblqUmnHRZ5hRsuUpHWvHrq9PX5cQF6LaJSNu5yjb1iiC9XbuZNqhnsfgey7reJMa4=
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr8588612ljq.109.1575638006402;
 Fri, 06 Dec 2019 05:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20191205225322.5529-1-alext9@gmail.com> <20191205235704.31385-1-alext9@gmail.com>
 <20191205235704.31385-2-alext9@gmail.com> <20191206012335.GA16183@generichostname>
In-Reply-To: <20191206012335.GA16183@generichostname>
From:   Alex Torok <alext9@gmail.com>
Date:   Fri, 6 Dec 2019 08:13:15 -0500
Message-ID: <CANmPhj1vSQYmwix7FMMBAksSTUJpz0izJyehmOhThkUfyUBy+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rebase: refactor dwim_ref_or_die from merge-base.c
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 5, 2019 at 8:23 PM Denton Liu <liu.denton@gmail.com> wrote:
> The remaining paragraphs shouldn't end up going into the commit message
> since they're more like "notes to reviewers". You should place these
> notes under the `---` below so that they won't end up in the final
> commit message.

Thank you for the info! I'll keep that in mind for my next patch submission.

> > +void dwim_ref_or_die(const char *str, int len, char **ref)
> > +{
> > +     struct object_id discard;
> > +     switch (dwim_ref(str, len, &discard, ref)) {
> > +     case 0:
> > +             die("No such ref: '%s'", str);
>
> I see that this code is copied so I'm fine with leaving it as is. But if
> you need to do any rerolls, it would be nice to, as a prepatory step,
> introduce a patch which 1. marks these strings for translation and 2.
> lowercases the first letter of the sentence which is the convention for
> messages that are seen by the end-user.
>
> Perhaps:
>
>         die(_("no such ref: '%s'"), str);
>

Sounds good! I'll add a patch to the end of this series that addresses
these strings not being translated.

Thank you for your feedback.
~Alex

> > +     case 1:
> > +             break; /* good */
> > +     default:
> > +             die("Ambiguous refname: '%s'", str);
>
> Same comment here.
>
> Thanks,
>
> Denton
>
> > +     }
> > +}
> > +
> > +
> >  int expand_ref(struct repository *repo, const char *str, int len,
> >              struct object_id *oid, char **ref)
> >  {
> > diff --git a/refs.h b/refs.h
> > index 730d05ad91..a961662382 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -154,6 +154,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
> >  int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
> >  int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
> >
> > +void dwim_ref_or_die(const char *str, int len, char **ref);
> >  /*
> >   * A ref_transaction represents a collection of reference updates that
> >   * should succeed or fail together.
> > --
> > 2.17.1
> >

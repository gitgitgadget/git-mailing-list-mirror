Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD533C433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 00:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9972120738
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 00:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhzHmwof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgHXAz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Aug 2020 20:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgHXAzz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Aug 2020 20:55:55 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EC9C061573
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 17:55:55 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id x1so1576237oox.6
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 17:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2spYR9Rzk2AIWPrjv67zbfVd6rGF5+4D/YiBUYn9jcY=;
        b=FhzHmwofoKJAixR+ucysNu+T8uEDhHgdqLjdxnABLBR57m6PFb8uDtncujXWStue1V
         tscIYg5SJzWcZVH/X21kZeQhgyWaT5YcC5tzNMv3HaYdzSrm8yO8Ajz68Uq90Vn5Nmgy
         YWXASR0KNZEVmpF4wzAA5GPwWmvnyeTNnFKEfUhldZ1DlngkVXcGQrdnNkNqlCHfmZB8
         iqCiiGeUbwZrwkTBUp1IsffElHbr2iUMidezqEq9rnw7zIXy3Jt8Dp6QLNDLGkjJfrSS
         m7vAb5eDThurG/qh1mtqnvE7ceJiQMUngmJzcAyYRhKC40iWhjY8iSFMwa66ijd776Jb
         jJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2spYR9Rzk2AIWPrjv67zbfVd6rGF5+4D/YiBUYn9jcY=;
        b=I+yAoialhIyrXvkKSA43rFfn0/41dCFaFqK09VEVhACak7Aud8tY+2umheQO2XosUl
         xLM7K0F0MWXOGkQHFDr48GHV7+10AoBR7JATT8k38jfwDIhqgltP+eC74NrqTSEn7Qg1
         1JB2GLrD2ZgITuE8BXUKRHJ0pFHwnWTO8va3V3MwyOHBJ61tIWd6BvYDIkXqvOlaxcA8
         XzLNoBHNXdZ4PRarUf3TDJiUpe9Eesl+djVnoHzvAFJ8zbtC1bSyj9+7BwVGtm1x4jOy
         Cfv0vC1dae7h7uned6MlJ6uSzumSEUfE3TmPvCCief2bBCr7ij3X+PkG5UQzOrzK51lb
         Slww==
X-Gm-Message-State: AOAM530F17RUDXS2oMbXASi5KsK77WdCpPRH5byQ/5s/VjqTqsLnU4iT
        mJsqH8w1ZLAuf4PnqcOYkQhY32pFndgZuQCzqTQ=
X-Google-Smtp-Source: ABdhPJwvF05EHEN463GK6RgkFRA64QlvhLOK2vd7MhbWHJ20HpJn3s2s2e3fEMgV+QIU0Mzv3yVhAxAqpjzYBjkdfFk=
X-Received: by 2002:a4a:98ed:: with SMTP id b42mr2285330ooj.32.1598230553614;
 Sun, 23 Aug 2020 17:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
 <pull.707.v2.git.1598004663.gitgitgadget@gmail.com> <39aa46bce700cc9a4ca49f38922e3a7ebf14a52c.1598004663.git.gitgitgadget@gmail.com>
 <CAPig+cRxCvHG70Nd00zBxYFuecu6+Z6uDP8ooN3rx9vPagoYBA@mail.gmail.com> <xmqqeenz95bj.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeenz95bj.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Mon, 24 Aug 2020 00:55:42 +0530
Message-ID: <CA+CkUQ8Gst2RTaXY6t+ytWu_9Pu7eqnRYRrnawRwYd_NN=u0Lg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: 'contents:trailers' show error if `:`
 is missing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Aug 22, 2020 at 12:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > ...an alternative would have been something like:
> >
> >     else if (!strcmp(arg, "trailers")) {
> >         if (trailers_atom_parser(format, atom, NULL, err))
> >             return -1;
> >     } else if (skip_prefix(arg, "trailers:", &arg)) {
> >         if (trailers_atom_parser(format, atom, arg, err))
> >             return -1;
> >     }
> >
> > which is quite simple to reason about (though has the cost of a tiny
> > bit of duplication).
>
> Yeah, that looks quite simple and straight-forward.

No doubt, it looks good for "contents:trailers".

What if In future we would like to expand functionalities of other
'contents' options?

Recently, I sent a patch series "Improvements to ref-filter"[1]. A
patch in this patch series introduced "sanitize" modifier to "subject"
atom. i.e "%(subject:sanitize)".

What if in the future we also want "%(contents:subject:sanitize)" to work?
We can duplicate code again. Something like:
```
} else if (!strcmp(arg, "trailers")) {
        if (trailers_atom_parser(format, atom, NULL, err))
            return -1;
} else if (skip_prefix(arg, "trailers:", &arg)) {
        if (trailers_atom_parser(format, atom, arg, err))
            return -1;
} else if (!strcmp(arg, "subject")) {
        if (subject_atom_parser(format, atom, NULL, err))
            return -1;
} else if (skip_prefix(arg, "subject:", &arg)) {
        if (subject_atom_parser(format, atom, arg, err))
            return -1;
}
```

OR

We can just simply use helper. Something like:
```
else if (check_format_field(arg, "subject", &arg)) {
    if (subject_atom_parser(format, atom, arg, err))
        return -1;
} else if (check_format_field(arg, "trailers", &arg)) {
    if (trailers_atom_parser(format, atom, arg, err))
        return -1;
```
We can use this helper any number of times, whenever there is a need.

Sorry, I missed saying this earlier. But I don't prefer duplicating
the code here.

Thanks,
Hariom

[1]: https://public-inbox.org/git/pull.684.v4.git.1598046110.gitgitgadget@gmail.com/#t

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065DBC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 12:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A6561002
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 12:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhFUMJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 08:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUMJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 08:09:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CF6C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 05:07:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h2so5078659edt.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 05:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=llElNIFbm9fT/dUsRz65BthMIeyX/kVUz1nqOa93D0o=;
        b=WzXzSTlY4iXjhRoSAUOrJroBXIy2O4P0064fBhQYm0q9j62hz+q87TcsGe+2pBOXC9
         6CPETKspnsVpG3VEyI15MA0k4KCyScSHmmNknBumXfJR+3th4oyajqOcGV4aWlEr2mw9
         l8LpaJNJD/orQCVn14IGewMdKlFRzVoliPjRLfOvs8/DG8eZFPNu0ijPR0C80ynJwisP
         sgxJuyp/VHVp2hzSX8XFGUYSrLOOr+6oeWGYPefWd6jnnHMmfQTIeyOJ404jpav3hrF3
         uoZFL29R0aE3RuFuJ7IVZpUyd+mI+Z8vqOGZHFCts3XOxkhIYvDSxYvwlLYbGi/t35+V
         OYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=llElNIFbm9fT/dUsRz65BthMIeyX/kVUz1nqOa93D0o=;
        b=NZAdU7R8IefbKXf+lKFZqbsw11BmGzGuEszCwln/dBLfvogCeqCVFu+BrMvbZ6GtPw
         T9IhS6NP9H2ML5O2gw3O7QD3l57lt3kLxxIVTtmJy1BUW2QUq6u2j9t8uxggRakMnckH
         sAQfZCJ5/Bz/AslZvmyrBpzdHs37meI4YPR1vjOhg+FQFf25in7r8X8OnE7W0ScAiYR/
         HFg+6BmxUMHqAG9eQxrB+vIkvAr5VRLuPG/ZApwtWwHz2b74PMtyAFvRgK7qW5Q+/593
         PTf5XMsniwGqe2PYHxl6+H9Oa1Ulm/vhOmcmSK/+cwDKL23XnCkYKlmQXW0xcEP6qP/Q
         pTnA==
X-Gm-Message-State: AOAM5318DB1ObM4sUXDUErpH/pJyeCN0VlsPF+bpN+kXvu5z/Jld8TM8
        2HVcXAWmCGCtn24JjaTQyEZHEi4A2r4n3dZEsNA=
X-Google-Smtp-Source: ABdhPJwfums9w2NUZ3GWs/ypLeceMO+Q2cdNRAmPUFmHJQRzfP4YpCOYPLTmTO4wIgQVIGJxqZCTtE31K+3xLtaWeZo=
X-Received: by 2002:aa7:dc42:: with SMTP id g2mr20940445edu.362.1624277263086;
 Mon, 21 Jun 2021 05:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TZqKQ1vkRX7apvzAJ04Cv9aHJ9kF1+wJcEvyi-pibOOw@mail.gmail.com>
In-Reply-To: <CAOLTT8TZqKQ1vkRX7apvzAJ04Cv9aHJ9kF1+wJcEvyi-pibOOw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 21 Jun 2021 14:07:32 +0200
Message-ID: <CAP8UFD0sHevUHB-ryUZm9Sxm=daKMwbqe6_Q7kc-pZAZN-eHWA@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 5
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 6:53 PM ZheNing Hu <adlternative@gmail.com> wrote:
>
> My fifth week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Blog-5/

Great, thanks!

> ## Week5: Tempting apple
>
> This week, I spent a lot of time working on the digital circuit
> course design of the school. So this week's patches for git
> was completed in a hurry. This week `=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on`

s/was/were/

> gave a lot of useful suggestions for the patch I wrote earlier.

Maybe a link could help.

> Some are related to code style improvements, and some are
> better design ideas.

[...]

> But something like `fill_remote_ref_details()`, things gradually
> become complicated and difficult. `fill_remote_ref_details()`.

I think you can remove the above `fill_remote_ref_details()` as you
are talking about it later.

> Just consider the `show_ref()` called in `fill_remote_ref_details()`,
> `show_ref()` may call `shorten_unambiguous_ref()` internally, and
> then another function is called internally in `shorten_unambiguous_ref()`=
...

> Well, this is one of the reasons why I cannot move on.
>
> On the other hand, look at the following piece of code, it appears
> in `populate_value()`.
>
> ```c
> for (i =3D 0; i < used_atom_cnt; i++) {
> struct atom_value *v =3D &ref->value[i];
> if (v->s =3D=3D NULL && used_atom[i].source =3D=3D SOURCE_NONE)
> return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
> oid_to_hex(&ref->objectname), ref->refname);
> }
> ```
>
> We need to determine whether `v->s` equals to `NULL`. We can use

s/equals to/equals/

> c-style strings to easily distinguish between empty strings(`xstrdup("")`=
)
> and `NULL`, but if we use strbuf, it is not easy to distinguish, because
> an empty strbuf has the following characteristics: `s.buf =3D=3D strbuf_s=
lopbuf`
> or `sb->buf[0] =3D=3D '\0'`. It can be said that we shouldn=E2=80=99t eve=
n use `NULL`
> to assign to `s.buf`.
>
> So in the end, I rejected this seemingly very attractive solution, and us=
e the
> previous strategy: `<s, s_size>`, unless someone can think of a better
> solution later `;-)`.
>
> * FootNote:
> 1. Why is there no `strbuf_empty()` in `strbuf` API? I think this may be
> a very important thing.

There is a 'size_t len' field in 'struct strbuf', so doing `buf->len
=3D=3D 0` works.

> 2. Another thing worth mentioning is: I will have the school final exam
> between July 7th and July 14th, I may be busy during this period.

Ok, thanks for telling us in advance.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E33C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE748610A3
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhFRNt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbhFRNtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 09:49:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71A3C06175F
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 06:47:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id nb6so15927303ejc.10
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 06:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bv3gBTYLBmZXgvZZxDxrfrTtZLpi4zK6+SJxBBxSJTM=;
        b=m1I1EYYaFN/w5JIA8GmKTOizlTSB0Rj74HmJblhPLGGZMT5hNMZGiHAeHnXsztMzqn
         iaZ+ZAiVwlkvbXomNE6OdW+VVE16LC6bFevoesQDOukBb/vz/q3a330B0Yrpw3LTD4mQ
         xbHTTMmXKdcNpe4MzXAvKbNtW3e0eKCfPul+lGwzDQyy88pPw32HQKFJJhVWm03Kqz7w
         ewcu6N80eE9dU1l2WA7jzTed26xpU5vRIS/WqUgTb3b0RJiKSkAN8u5tQStjsdcGtbC6
         /DDaIAZa4qgUi+muTAs51pGyJjMBoG72+43DarpAuxMWn1ki8W806Legp6OG6nHAn/l8
         EFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bv3gBTYLBmZXgvZZxDxrfrTtZLpi4zK6+SJxBBxSJTM=;
        b=AvLH0HwkZ9W1b94oIs51tzbs5ycc8wBYw0WU40ohF71bQEK5A66H6NvmK+azxT0qx4
         upaSyxD1eKhU4dPihkP/kNUn1JTPzsFSc4ve84EOg/DxchqRJiKWRTYen+c1dEPbrJz0
         zIKdBWuism+M6BtMjUBoeByxonvvv8n9+pu6SXNOUtmOIqdtSC/hDKS2QWjWsKUomS9N
         x/p6GXm4vf7u+3rtgIZdKkSSO2p1A2EALUU01+nmeC4mcdNbEyDgtkIMMPbqy0H9RZAr
         sacQ1u2Fu3aA2RGDbZpX7NJuHTxUxFV9dVA2tiot/HdJzs/V0TzG+f8TLinBYJy7DKCu
         2GdQ==
X-Gm-Message-State: AOAM530QowpIIBNtCW1MtbAfHcn2N/y4riiCLTBShRTB4ouWuNAESShH
        Jq0L0qcrzcv6L/zsE+AnOF0mvFkTul/Mx7PewQw=
X-Google-Smtp-Source: ABdhPJwh79qw6FxZ/3NWViKqCt5GVzp2bt9+sJ5g6/wL9UZiI+EsxHlfawP/+PeJxfe0dht8TrOu2uybMGABY/Xhzsw=
X-Received: by 2002:a17:906:dc6:: with SMTP id p6mr3029170eji.283.1624024033281;
 Fri, 18 Jun 2021 06:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <abee6a03becb929ffb292648d1ef64e61b66d53d.1623496458.git.gitgitgadget@gmail.com>
 <875yydx8oo.fsf@evledraar.gmail.com> <CAOLTT8TMOs-FF+EcTZBbxfGnKQipe_nx_eZon=S=PWRTNT4CjA@mail.gmail.com>
 <87r1h0wnwg.fsf@evledraar.gmail.com> <CAOLTT8SGkObKWMZax-k4KXgsN+7ezvOMkRU-zt+c2zon2Ta3pA@mail.gmail.com>
 <87r1gz4faf.fsf@evledraar.gmail.com>
In-Reply-To: <87r1gz4faf.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 18 Jun 2021 15:47:02 +0200
Message-ID: <CAP8UFD1O0PLeThi+_DcSQ3U7Vughode+dRM0b=H5V4J3i_Nn3w@mail.gmail.com>
Subject: Re: [PATCH 2/8] [GSOC] ref-filter: add %(raw) atom
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 18, 2021 at 12:51 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> On Fri, Jun 18 2021, ZheNing Hu wrote:

> > After some refactoring, I found that there are two problems:
> > 1. There are a lot of codes like this in ref-filter to fill v->s:
> >
> > v->s =3D show_ref(...)
> > v->s =3D copy_email(...)
> >
> > It is very difficult to modify here: We know that show_ref()
> > or copy_email() will allocate a block of memory to v->s, but
> > if v->s is a strbuf, what should we do? In copy_email(), we
> > can pass the v->s to copy_email() and use strbuf_add()/strbuf_addstr()
> > instead of xstrdup() and xmemdupz(). But show_ref() will call
> > external functions like shorten_unambiguous_ref(), we don=E2=80=99t kno=
w
> > whether it will return us NULL or a dynamically allocated memory.
> > If continue to pass v->s to the inner function, it is not a feasible
> > method. Or we can use strbuf_attach() + strlen(), I'm not sure
> > this is a good method.

If you resend this patch, it might be a good idea to add a short
version of the above explanations into the commit message.

[...]

> > In the case of using strbuf, I don=E2=80=99t know how to distinguish be=
tween an empty
> > strbuf and NULL. It can be easily distinguished by using c-style "const=
 char*".

Maybe this could also be part of the explanation.

> Yes, sometimes it's just too much of a hassle, looking at
> shorten_unambiguous_ref() which returns a xstrdup()'d value that could
> indeed be strbuf_attach'd. I haven't tried the conversion myself,
> perhaps it's too much hassle.
>
> Just a suggestion from reading your patch in isolation.

Yeah, thanks for the review anyway!

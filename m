Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D36C47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 04:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C6C06139A
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 04:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhFFFAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 01:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhFFFAl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 01:00:41 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC8CC061766
        for <git@vger.kernel.org>; Sat,  5 Jun 2021 21:58:44 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a8so11830517ilv.9
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 21:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YvlvyRv+H9x6tIhTaUbiDPMeRxio2OLdcRY3F6PDWKo=;
        b=IrJOGmaPhcMNXpAYlQyZygT2th/yzGD3OQmr9f90Mr2tjqai4LX5DkOrYacNj3y03X
         WEb5PpduV+/kUONJEo6zWGYxliG3UGduuSzdTjM3Xpli7nZGjptrGXp/uuZ9PqMWTWuJ
         GjjzGljnlrW74orqkf8bAC6ZncgCVl7nHU8ZyL24JB5IvaZoj85bg/6q0nBQlHZTf9Jz
         hmRNR6rOJy+nsA+KuHB+T2h947022CNuCB53ptP8i4HZk50pcc+yEJbWar4iM7kw+QH3
         ysos51RaNIBkmahFO75g8Hbrv6VqHB0aJYZi1HkpinwtPNf/A26vM4H6z9yeL0tk+KsT
         LRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YvlvyRv+H9x6tIhTaUbiDPMeRxio2OLdcRY3F6PDWKo=;
        b=eHWFzlATU1figj8K2NUJsvD3oBrviem17ABquwqRxPj0SzsdnbpayDWdiFuji12oPf
         xkQpKMiraNBII9WYYWzqxFSZ1GzDz8uofZLznT6YM4+xps/zmCv5WXQv8Yz3gQAk6eaj
         yXqXijYCbsbaBMs9tFd/Frmd8tWL7RDDQGwOUrNZEJk8CPPn25utPnQ0sP3f8Y5Qajqe
         O4h5sCZt8SkY0UzqVOndZvaxWR1wjLvfs2RXC0ObY26Uavzt+1o9ehWtRfMUeDhDpVca
         8SyMUFrQzJLhacly/VWSeHvkIFy/2X+rM8y7vfNda/jiSsbhEsC9nwxOg8w9Fu0VTgoJ
         /0qg==
X-Gm-Message-State: AOAM530UQ8da99ws682GUQrYdzr/xbuG/YTQr0y3IvL8Zd9N0lhgWCQc
        ztaJGAtv5d8IhdqqqLW2z81/ZxFqK14kLMGFfzo=
X-Google-Smtp-Source: ABdhPJywArL0wXoLxxr/7HH5rIm0qyRpOExlMcnkyMez2CGV1uDV8j1stuAUkR3MwtGa3sWNUV/PU56vC8Jrnzs44Mk=
X-Received: by 2002:a05:6e02:12c9:: with SMTP id i9mr9993195ilm.17.1622955519314;
 Sat, 05 Jun 2021 21:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
 <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
 <CA+CkUQ9f8kN=S8dU_zt=-uG1pcK8cE9CuhJdqR9oMwcguZ9FLg@mail.gmail.com>
In-Reply-To: <CA+CkUQ9f8kN=S8dU_zt=-uG1pcK8cE9CuhJdqR9oMwcguZ9FLg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 6 Jun 2021 12:58:27 +0800
Message-ID: <CAOLTT8RD1hmjiusDuf_O+UPBH0H9-2Y58LFd_UcvnZ2R5zL08w@mail.gmail.com>
Subject: Re: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
To:     Hariom verma <hariom18599@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Hariom verma <hariom18599@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=885=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8811:20=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Sat, Jun 5, 2021 at 2:43 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > --- a/builtin/branch.c
> > +++ b/builtin/branch.c
> > @@ -670,6 +674,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
> >                         N_("print only branches of the object"), parse_=
opt_object_name),
> >                 OPT_BOOL('i', "ignore-case", &icase, N_("sorting and fi=
ltering are case insensitive")),
> >                 OPT_STRING(  0 , "format", &format.format, N_("format")=
, N_("format to use for the output")),
> > +               OPT_STRING(0, "rest", &format.rest, N_("rest"), N_("spe=
cify %(rest) contents")),
> >                 OPT_END(),
> >         };
> >
>
> Although it's not related to this patch. But I just noticed an unusual
> extra space(s) before the first argument of `OPT_STRING()`. (above the
> line you added)
>

Yeah, I noticed it too.

> > --- a/builtin/for-each-ref.c
> > +++ b/builtin/for-each-ref.c
> > @@ -37,6 +37,7 @@ int cmd_for_each_ref(int argc, const char **argv, con=
st char *prefix)
> >
> >                 OPT_GROUP(""),
> >                 OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> =
matched refs")),
> > +               OPT_STRING(  0 , "rest", &format.rest, N_("rest"), N_("=
specify %(rest) contents")),
> >                 OPT_STRING(  0 , "format", &format.format, N_("format")=
, N_("format to use for the output")),
> >                 OPT__COLOR(&format.use_color, N_("respect format colors=
")),
> >                 OPT_REF_SORT(sorting_tail),
>
> Here too in `OPT_INTEGER()` and `OPT_INTEGER()`.
>
> Also, I don't think these extra space(s) are intended. So you don't
> need to imitate them.
>

Maybe... I find it's begin at c3428da8 (Make builtin-for-each-ref.c
use parse-opts.)
This is something from 2007. So It may be wrong to imitate its format.
But this format fix work may be can put in good-first-issue. :)

> > --- a/builtin/tag.c
> > +++ b/builtin/tag.c
> > @@ -481,6 +486,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
> >                 OPT_STRING(  0 , "format", &format.format, N_("format")=
,
> >                            N_("format to use for the output")),
> >                 OPT__COLOR(&format.use_color, N_("respect format colors=
")),
> > +               OPT_STRING(0, "rest", &format.rest, N_("rest"), N_("spe=
cify %(rest) contents")),
> >                 OPT_BOOL('i', "ignore-case", &icase, N_("sorting and fi=
ltering are case insensitive")),
> >                 OPT_END()
> >         };
>
> Here too in the first line.
>
> Thanks,
> Hariom

Thanks.
--
ZheNing Hu

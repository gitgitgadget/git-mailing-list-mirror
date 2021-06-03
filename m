Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB94C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 04:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BCD613D7
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 04:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFCEyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 00:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhFCEyX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 00:54:23 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F492C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 21:52:26 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e7so4355628ils.3
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 21:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lLtupaiWljx5IXvhcuG9fXupWF2BhrUg7iObIkfjlIA=;
        b=ii+iqBJyQ+BLDxomTmhSiUWbCdOiH+uXR7CJHDhsDJFofC2sNKf/ps5QxDqUnv3OOv
         LlsIfqQ4f6ZjwJntyMZj7JJvdui9db01Luw2UM+FAx3wMc5Mzhl/dw3aD9gd2xAeXWmO
         I+Sk34iO83mFsDFH0WK0MRwn2fclXr/L6iQtBeIrQ8RpUZ7gfPgNIv9dfOagVxeH3pS+
         0I4cVXFlNAKexp3w9gVnAsYyOdCHyLWR1amjAI+B5PsWJxmllnyBAgovoJhPu+Tg7kel
         QSjvaYhdlJTZ3yySZN9p4dT6ne9R937g82KjoaY+6fou+jkKdzzWaRuHR5x9KmTEoWn0
         t5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lLtupaiWljx5IXvhcuG9fXupWF2BhrUg7iObIkfjlIA=;
        b=AMpXJhO3gYpBI+aDAoUZLLULuoe8u77p7i+67hM4HvDfyh4yK5kkXxXLQuSmLdkhk9
         byVFHIUf+7SBtc7k9G2JHus+P5mQcai8LVb4cPAf31zuwx+1Z6+PEYhGK4DSHoHQsH65
         XR7gp3kXEfLN1w6xMRWBnLgpyGO72DY1p4YZDOT2kBsDELKUjWtZf+JWrkQ/GPMVP0KT
         CDVTblq7ot0FrmYbEsGbWdJfZ5rnmEyaWLVJmlC+4B7lHuvF2qo7t32k2xNlMhwMKrB0
         KVb+vj5diBIl0iH++om82DbmYOQHQI0yAKBK8XuTucEr3Vxk3yuFm/wXNcsKRWNXmApp
         zskA==
X-Gm-Message-State: AOAM533ACsPqt35Jdq5yoflhAOyq8eIgfARC9KfzkecaRxppDxRBi9gH
        wfezQ+w0lNCmmch272oUkhpLJNerd5xmXlB5w1s=
X-Google-Smtp-Source: ABdhPJyJy5vO3nwgfwqLEVCGaTDOQ5ias5lC8aQ28+//tigpO5EFC6w8L5MYSa6AZx2GPR4a/+J8ijP/FKBg04DWqqk=
X-Received: by 2002:a92:b0b:: with SMTP id b11mr24098472ilf.301.1622695945603;
 Wed, 02 Jun 2021 21:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
 <97955705c22e00a718a8de7555ab7e0e401e792e.1622558243.git.gitgitgadget@gmail.com>
 <xmqq1r9j7l60.fsf@gitster.g>
In-Reply-To: <xmqq1r9j7l60.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 3 Jun 2021 12:52:14 +0800
Message-ID: <CAOLTT8TzZHsZfLtgS8G=fvE5hQzP-1PBnS8yyj41y2PtZtBh0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] ref-filter: add obj-type check in grab contents
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=883=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8810:10=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  /* See grab_values */
> > -static void grab_sub_body_contents(struct atom_value *val, int deref, =
void *buf)
> > +static void grab_sub_body_contents(struct atom_value *val, int deref, =
void *buf,
> > +                                struct object *obj)
>
> Neither this step or the next change needs anything but type member
> of the 'obj' (and 'buf' is coming from oi.content of the result of
> asking about that same 'obj').
>
> I wonder if we should do one of the following:
>
>  (1) stop passing "void *buf" and instead "struct expand_data
>      *data", and use "data->content" to access "buf", which would
>      allow you to access "data->type" to perform the added check.
>
>  (2) instead of adding "struct obj *obj" to the parameters, just add
>      "enum object_type type", as that is the only thing you need.
>
> Obviously (2) is with lessor impact, but if it can be done safely
> without breaking the code [*], (1) would probably be a much more
> preferrable direction to go in the longer term.
>

I agree with (1). In future versions of grab_sub_body_contents(), we will
use the content of "data" more frequently instead of using the
crude "obj". The type provided by "obj" can also be provided by
"data". So yes, I would be very willing to let grab_sub_body_contents()
only use "data". (delete "obj")

E.g.

static void grab_sub_body_contents(struct atom_value *val, int deref,
struct expand_data *data)

Using (2), we will need more parameters to pass other object info.

>     Side note [*].  A caller is allowed to choose to feed "buf" that
>     is different from "oi.content" (perhaps buf may sometimes want
>     to be a utf-8 recoded version of oi.content for certain types of
>     objects) with the current system, but if we pass expand_data
>     throughout the callchain, such a caller is broken, for example.
>

Just see the situation in front of us: grab_sub_body_contents()
have only one caller: grab_values(). If someone need a function like
grab_sub_body_contents() to grab another buf, they can use rewrite
a more universal function interface:

static void grab_sub_body_contents(struct atom_value *val, int deref,
struct expand_data *data)
{
   grab_sub_body_contents_internal(val, deref, data->content,
data->size, data->type);
}

static void grab_sub_body_contents_internal(struct atom_value *val,
int deref, void *buf,
                                           unsigned long buf_size,
enum object_type type)
{
...
}

But for the time being, the above one is sufficient.

Thanks.
--
ZheNing Hu

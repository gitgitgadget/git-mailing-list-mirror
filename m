Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2208BC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 16:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CC660FD7
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 16:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhHQQKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 12:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhHQQKj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 12:10:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D17C061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 09:10:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn28so20391431edb.6
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X1n14yc0OUiiv/Y0uRj84fcg8hs1/JXguLi73BzebVs=;
        b=lnqVtbqseNOHguZ+sXHgUIfsbSrpIUrL6ThVvmzQhdgxU8W1379hxzcCEhzRXSbyiy
         b1j6JdJ5X7NnZFW+APP7MBzM1McJDRiKRGZ9Zlc7/eqr4p2SPRVKHH3U2talHMbMZT6q
         p3RtG0EHDPyl/ydlV1s+rOd9zPPug4ZDv94q2pXi0TnZAaoxCXN/3Z2yRvP1/ERfzlNQ
         T0a7FByseAQ/3cGFrzIb5QFaO6phceIj5QNu5R1CFQJcKJ5J9tonB6XDg2ZEZamyIZAt
         y5+3vHIFibIlkXcvARFDzmAXMSr/EtRLSoiviDjlDPjXKVYzNUxkP7NfXud8n8faHYdi
         db2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X1n14yc0OUiiv/Y0uRj84fcg8hs1/JXguLi73BzebVs=;
        b=iXZXnPj//G3Rn+SzrBU/HU0L8EBzDaLpKu9ZiJPjNStj2C2i4uhiclmsTI/W+07Xdt
         jTZHwxdPkSqxBsPnjk81X0urrsDeKuWdAPT8YRW9myG9x6FPlMNZiPxOK8KYyBEhIDOm
         5EFBC3HdJWER2z37LlRCNI/UC4JRzO1Z294rsONp3XVlwV2ZhfZiP1haY1Qllg5ZcskW
         q39RTnV7usik+Y5aYABZt2x/oYV6hRQ0kdyYkfZkd4UzSivd4A0U59ZiYKX7oBAxRKI0
         7Ct87dgT7NeF9XM+Jyn4daXIIYx+q0tnrybf1mfYN55VIFR/sSQI9SsZJGXj4+rSndsq
         bf3g==
X-Gm-Message-State: AOAM532ABrIIBtEWiE3x2lckZ4cQD2DkUsTr+ywJwa3Nvq81RBK/xGyT
        KXeqX1dyHdfb2p0REYa4rrxsLGiRUl6WUpk3RH8=
X-Google-Smtp-Source: ABdhPJy7T323QzcKF9DQMYkLhQN1mIR/McL62adIl+8aN5Gk1lao5MTEWsQtaxCN3/TzzZFqYMH33qwAm3h7/HjCBjA=
X-Received: by 2002:aa7:cb8a:: with SMTP id r10mr5000138edt.237.1629216604249;
 Tue, 17 Aug 2021 09:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
In-Reply-To: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 17 Aug 2021 18:09:52 +0200
Message-ID: <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com>
Subject: Re: [GSOC] [QUESTION] ref-filter: can %(raw) implement reuse oi.content?
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Aug 16, 2021 at 4:00 PM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Hi,
>
> In the implementation of %(raw) atom
> (bd0708c7 ref-filter: add %(raw) atom), we use xmemdupz()
> to copy the content of the object. But if we can reuse the content
> of the object?
>
> Since git cat-file --batch needs to use ref-filter
> as the backend, if the object buffer can be reused correctly here,
> we can save a lot of copies and improve its performance by about 6%.

Yeah, that would be great.

> Tracing back to the source, the object buffer is allocated from
> oid_object_info_extended(), but in parse_object_buffer() we may lose
> the ownership of the buffer (maybe the buffer is eaten), but I browsed th=
e
> source code of for-each-ref.c or cat-file.c, and I don=E2=80=99t seem to =
find that the
> buffers which have been eaten are released by the program.
>
> So can we reuse it?
>
> This is what I want to do:
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 93ce2a6ef2..1f6c1daabd 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1443,7 +1443,7 @@ static void grab_sub_body_contents(struct
> atom_value *val, int deref, struct exp
>                         unsigned long buf_size =3D data->size;
>
>                         if (atom->u.raw_data.option =3D=3D RAW_BARE) {
> -                               v->s =3D xmemdupz(buf, buf_size);
> +                               v->s =3D buf;

It seems to me that this could work only if 'buf' isn't freed. Have
you checked that? Did we leak 'buf' before this patch? Otherwise when
are we freeing it?

>                                 v->s_size =3D buf_size;
>                         } else if (atom->u.raw_data.option =3D=3D RAW_LEN=
GTH) {
>                                 v->s =3D xstrfmt("%"PRIuMAX, (uintmax_t)b=
uf_size);
> @@ -1768,8 +1768,6 @@ static int get_object(struct ref_array_item
> *ref, int deref, struct object **obj
>         }
>
>         grab_common_values(ref->value, deref, oi);
> -       if (!eaten)
> -               free(oi->content);

This change might not be needed. 'oi->content' seems to come from the
'buf' above, either directly or through a copy, but if we can indeed
own the 'buf' completely, then we should be able to dispose of it how
we want.

>         return 0;
>  }

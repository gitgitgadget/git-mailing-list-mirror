Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A10C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 11:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351AB606A5
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 11:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhHRLMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 07:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhHRLMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 07:12:09 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870A1C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 04:11:34 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z1so2215878ioh.7
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KiUFc5dArVWQr1XzA3Y22Cpc5n3zaJvwbDr8sszSqbM=;
        b=KGxyIntVRshCCV0uKXTIjKTob3tD8X1uBSkejvYTz1pS1ku8VAZlBqxejm/qTkYqWG
         COUSdUIchlCCuaJcy9e1qNdNnsbPrui2t1bLH5FJ3046+s0HF3kYRdQXN426HlX0Eplo
         wpl2Zs0skwpoVtc95JGB6X6pbHAeomMg63MayNhwLVB0DaZa1JFNErn/hUZOoHB+KF9J
         OAodUW7OpKYSW1/cq78/ZGSDlBLK2ZUxzMyKrhnhzj3Xy4ML5HWDvoD31aUSp+Ks4Nce
         YO7KfVo014erEM2QWYpXL18eUCsTZRo+9DcI9xEgZtn2xqGFy1xgrBlwVy9/LOvHmHsa
         zcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KiUFc5dArVWQr1XzA3Y22Cpc5n3zaJvwbDr8sszSqbM=;
        b=C03r351XgKhSyLArqk1OX7kERxm26or7oGDZju1gTy6BqF7x5Aa8EOJgXYHkDeyEeV
         D2PbLxweK/jMKtw0IHwgf08wg6jc4BWCJ6MhCYQh5okczNV0PhNaHXsV/Ctq6PHmd0z4
         6T49ZtZLMBRH4asI/64PQBr54m54MgPk5FET8A+tGYfQaRpeJ3BWEqsPxiNGLQ5wSjKT
         2XxJKdW8i4MxkMJS34ZdcdUM/fHX+aU3+NPUy36aEDsk06+wC1hnWvDAZywuKh3db/jm
         34LEsOgjhmv2PkzvWj5dtAB0xMrUXF1URKtsTOfEXXYnTZQxOxWQM+fIqmHT4dlBtiRz
         rQVQ==
X-Gm-Message-State: AOAM531GQAy3SgSlscIN+PD/pn2ORKVGuz6G5rpiFEf+F8axLZgd0pLe
        scZf9xbCExLKzQVnDnS4FywFdJIKlUVJIXHtviw=
X-Google-Smtp-Source: ABdhPJzrJWYKSuUkZL1d3hbWI5n5taCs1ajf8MUxy468u+U212l6QkyEPpglxiBnKB5NUNDEOmh5DCUGG5fYCG26aDc=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr6467127ion.203.1629285094066;
 Wed, 18 Aug 2021 04:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TJ_VBh8mreExXHdCFb1e6hB1-Exsn6OFdo2sZNkVFJkA@mail.gmail.com>
 <CAP8UFD0AvakWdpJKBDrEZstVvFOGdjVUkWsBXn7geiUdVzAZGQ@mail.gmail.com>
 <CAOLTT8TB0HUBnYc1U7o36wBp=qxKDOLA6D9K19niNt_y_W==ag@mail.gmail.com>
 <CAP8UFD15vZ4B3dxPamaxqySZgLwffHU1Rx21bHRLY9zndjvAew@mail.gmail.com> <CAOLTT8SjLPXT7ows-MZQLmDwzPN5pUrqj26+PHVbTevkBn3Tug@mail.gmail.com>
In-Reply-To: <CAOLTT8SjLPXT7ows-MZQLmDwzPN5pUrqj26+PHVbTevkBn3Tug@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 18 Aug 2021 19:11:22 +0800
Message-ID: <CAOLTT8RY213BMTq+wx8yS=0QjY55L1BnCgPHQph1uos2oX03gw@mail.gmail.com>
Subject: Re: [GSOC] [QUESTION] ref-filter: can %(raw) implement reuse oi.content?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8818=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=885:07=E5=86=99=E9=81=93=EF=BC=9A
> I think the 'buf' is not freed in ref-filter logic.
>
> But one thing worth noting is:
>
> parse_object_buffer() may take this buffer away, and store it in
> tree->buffer or use set_commit_buffer() to store it in commit_slab.
>
> So in theory, as long as we don=E2=80=99t use parse_object_buffer(), this
> dynamically allocated memory can be used freely for us. If we use
> parse_object_buffer() and free the buffer, there seems to be a risk,
> but it does not appear so far.
>

When parse_object_buffer() hints that we don=E2=80=99t free the buffer when
eaten =3D=3D 1, I have a better idea, If the buffer is "eaten", we copy it,
otherwise we use the originally allocated space.

-static void grab_sub_body_contents(struct atom_value *val, int deref,
struct expand_data *data)
+static void grab_sub_body_contents(struct atom_value *val, int deref,
struct expand_data *data, int eaten)
 {
        int i;
        const char *subpos =3D NULL, *bodypos =3D NULL, *sigpos =3D NULL;
@@ -1499,7 +1499,10 @@ static void grab_sub_body_contents(struct
atom_value *val, int deref, struct exp
                        unsigned long buf_size =3D data->size;

                        if (atom->u.raw_data.option =3D=3D RAW_BARE) {
-                               v->s =3D buf;
+                               if (eaten)
+                                       v->s =3D xmemdupz(buf, buf_size);
+                               else
+                                       v->s =3D buf;
                                v->s_size =3D buf_size;
                        } else if (atom->u.raw_data.option =3D=3D RAW_LENGT=
H) {
                                v->s =3D xstrfmt_len(&v->s_size,
"%"PRIuMAX, (uintmax_t)buf_size);

As parse_object_buffer() does internally: the buffer of commit/tree objects
needs to be copied, but blob/tag not. You said that the number of commits
is generally significantly greater than the others. It seems that we cannot
make full use of this idea. But remember the "skip_parse_buffer" before?
If we skip the parse_object_buffer(), this buffer is also "!eaten".

In other words, those default paths of git cat-file --batch are included in=
 it!
So from the perspective of performance regression, this patch will be
beneficial.

Thanks.
--
ZheNing Hu

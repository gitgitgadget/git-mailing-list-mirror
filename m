Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B158C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 14:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3897561364
	for <git@archiver.kernel.org>; Mon, 31 May 2021 14:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhEaOrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 10:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhEaOph (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 10:45:37 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3304C061251
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:55:49 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d25so12035606ioe.1
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OdsNzcCaJjIqoXbYbqbqVK1bYgTT20NffZWfdg1Spro=;
        b=lgCR7UrPqyA9+2dFax1/+UnP3pkwIdqJ+FMhX43PnEXXHSlYLZq9LNs+mhlmF2THPx
         DmVddzm78lSvUzlCWFElyH7alIaCftTZ7p/LLNs03jGyQC2FNBVZDH/aNUYqq6xLu/a1
         PPL4Ixu6aUFz/+5A05isav9gI98RVZqynkPRPO9wvmvSaWAkbbypEUcY9J8THjS/l7/B
         3H91f7aVs5scIw82FN8HyW1A/85d0uVkyTVW4Gsy4Qs7hZANgIpRddjmny291D2hBuYo
         7yepG+TzPzS72taSXpwfxUH+y/rfrvb52s7dGpDtWFoNlxPD/XhMWYBbySOg24Y3Wzp7
         Zhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OdsNzcCaJjIqoXbYbqbqVK1bYgTT20NffZWfdg1Spro=;
        b=EyJQlfHD+lFnDN3hOoDxxeopiECS3vx3edeK3JxVL5NEJpiIq2k9DzrA04Fj3H8p5x
         XuHpyMv7o2mUjFJFYY73XoizAiQVLvOpJmXTamohTVEjXL/RueIflGhPqEDOdFa81+1M
         osGVWv4dK5Y67hpfxGxj5cCJVfeA5EEuLDX6cbW8/qMWfxY13zyzK/DyubNhC1/wsRKE
         ovXcrEQ95Dkfi6+XL78iFCL7j3vm3wl/v/UsqWr3U1O2kNBBq/gfnuKRB27lXhragrzi
         T1kUIYYBpafKL9o1bZQn3gQozNjlaluYyV1QPS2mX0BJ4NgRqrtMruHccIgQlt54uV+U
         9t7Q==
X-Gm-Message-State: AOAM5310QaMiy0hfB8GmQIvaMXiaNFpd1RHHw6w/etEcyf2We//3byNj
        cIQME3zfSaju50v7r4cbu6GIgyq//HxQYuA2BXI=
X-Google-Smtp-Source: ABdhPJwUBQKRkPOWLjceiDerjHAEnwT+EMm4J84c1jFzBhape9NDBcXuWvFtYRnzjsnRgm/9wNy2NfHqV0kvUkM8Y08=
X-Received: by 2002:a6b:5803:: with SMTP id m3mr8459032iob.68.1622469349020;
 Mon, 31 May 2021 06:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com> <xmqqy2bv3ovf.fsf@gitster.g>
In-Reply-To: <xmqqy2bv3ovf.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 31 May 2021 21:55:38 +0800
Message-ID: <CAOLTT8Qz5NBXKp0iF5+mFK7evhqiTH_TUf+Ve3BuO5iV1DESaQ@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=885:15=E5=86=99=E9=81=93=EF=BC=9A
> > So avoid checking changes in type and size when all_objects
> > and skip_object_info options are set at the same time.
>
> ... it is not immediately clear how the above conclusion follows.
>

My origin idea is: Now that it is known that the first "data->type" is 0,
and the second "type" obtained is the real type of the object, they are
different, so we can skip the comparison here.

> An obvious alternative, however, is to avoid skipping object info
> when all objects is in use---but that goes directly against why this
> "skip" mechanism was added at 845de33a (cat-file: avoid noop calls
> to sha1_object_info_extended, 2016-05-18).
>
> Which makes me suspect that the solution presented here would be
> going in the right direction.
>

Looking at it now, Peff's solution may be correct.

> There however is one curious thing about this.  The log message of
> the original commit that introduced this optimization does use the
> batch-check and batch-all-objects at the same time.  Was this
> breakage not there when the original was written and we broke it in
> a later update?  If so, with what commit?  Can that commit have
> broken other places in cat-file in a similar manner?
>

Because it's bug of --batch with --batch-all-objects, not the bug of
 --batch-check with --batch-all-objects. The extra broken atoms
are %(rest), %(objectname).

> > diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> > index 5ebf13359e83..5f9578f9b86b 100644
> > --- a/builtin/cat-file.c
> > +++ b/builtin/cat-file.c
> > @@ -345,11 +345,12 @@ static void print_object_or_die(struct batch_opti=
ons *opt, struct expand_data *d
> >               contents =3D read_object_file(oid, &type, &size);
> >               if (!contents)
> >                       die("object %s disappeared", oid_to_hex(oid));
> > -             if (type !=3D data->type)
> > -                     die("object %s changed type!?", oid_to_hex(oid));
> > -             if (data->info.sizep && size !=3D data->size)
> > -                     die("object %s changed size!?", oid_to_hex(oid));
> > -
> > +             if (!(opt->all_objects && data->skip_object_info)) {
> > +                     if (type !=3D data->type)
> > +                             die("object %s changed type!?", oid_to_he=
x(oid));
>
> When skip_object_info bit is set, we know data->type and date->size
> are unusable and should not be checked, regardless of the reason why
> skip_object_info bit is set, don't we?

Yes... We don't need to consider "opt->all_objects".

>
> > +                     if (data->info.sizep && size !=3D data->size)
> > +                             die("object %s changed size!?", oid_to_he=
x(oid));
>
> Does this check need to be modified at all?  Would info.sizep ever
> be set to non-NULL if skip_object_info is set (hence we are not
> calling object-info)?
>

Indeed, we don=E2=80=99t need to consider sizep.

> > +             }
>
> In other words, shouldn't this patch just this one liner?
>
> -               if (type !=3D data->type)
> +               if (data->skip_object_info && type !=3D data->type)
>                         die("object %s changed type!?", oid_to_hex(oid));
>

With the original patch, this is the best code.

Thanks.
--
ZheNing Hu

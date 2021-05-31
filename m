Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7626C47083
	for <git@archiver.kernel.org>; Mon, 31 May 2021 13:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAE461465
	for <git@archiver.kernel.org>; Mon, 31 May 2021 13:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhEaN3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbhEaN1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 09:27:01 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DA8C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:20:48 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id z1so10032751ils.0
        for <git@vger.kernel.org>; Mon, 31 May 2021 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UIcVmyegJrtqwCwkQakEMj49k6mX9C7AOI0TNajLa48=;
        b=rbleTVs0ukUyXUrNXIzER9ZOs0RFcN/qxnzgFV0noISN6r3S3dHO7DIGm3edDu9jsd
         VccwCNszDDqHNU3Pajaa0Ylchmfg+4stPoYGBpg4Tv6eO/SGIS7eiy43SuI9Jf0G/QbM
         uftIiLBNnLtCOQwt9mI53P2NgsN3ASJqXexz4FJLjahi2ELYeVSQ6KbxwcTKRLsU/Ay/
         x9JcAZ9Tczsn5VK5CWc+9bDlA8mMA0DDuWZOwlgaOwFbP/q89Em0txtfofZjj2+xLEpS
         Kf305aVbpkxCduz7NjdC5GGaX//bCIHaFCuBq1SYbK/Y3/p5AcSjFasx5uFhKC9boiGH
         ZLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UIcVmyegJrtqwCwkQakEMj49k6mX9C7AOI0TNajLa48=;
        b=dwUnzWBPjUDbfWFPPFAf91Jx8BkUOXswKrNis3rE/j5gWsu1y2Fj66eYE8In1hgpJx
         tcESji7DW2+wpkb90d1yhUDqNUyUc2zS7w9QlJADPuaudDUh2jjNzz/mGEYNdhp2SSbf
         3ox1OzM45oGZz4xMxIZdws/monX5zRvuuGCnfotDCuPTPrgZcFUiJZ1SHGnaX6u/2OBJ
         /UlAIXsOJgnI6COG5EFHuWTq0A7lz3RzjawMESU4u1S2MQME18pC6i0ifeMVFVAuP2xI
         f9zWRyqTjlSIfCT+8kwlzpDZUp4xhXyKBj0HaJZuY09ocAWwPWfKGxbAiCVFQO0NZi6O
         ZWmA==
X-Gm-Message-State: AOAM532YIRox3A+3JdZ+nmcWTrIMpTxTlspU1ma5xWE+pyNhDlBN+zQK
        xlacsYtqdhmHRVj6pjrZ8PA0BXtUi2KzYbyfYzE=
X-Google-Smtp-Source: ABdhPJzvyBOTrnAbuz5h1qfBRMkzS9vQBoyX3UruztuPoVf3fe94fowA8L4C+5q8EO/cFFLQOxtpGpHQrYZaYP4kI6w=
X-Received: by 2002:a92:2004:: with SMTP id j4mr18100169ile.53.1622467247537;
 Mon, 31 May 2021 06:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com> <YLP/GEN0qIXvWEUn@coredump.intra.peff.net>
In-Reply-To: <YLP/GEN0qIXvWEUn@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 31 May 2021 21:20:34 +0800
Message-ID: <CAOLTT8Q0zbxh8X03ZmgAzHadTbE4-Af+AB3POOUF2n22u8RExw@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B45=E6=9C=8831=E6=97=A5=E5=91=
=A8=E4=B8=80 =E4=B8=8A=E5=8D=885:09=E5=86=99=E9=81=93=EF=BC=9A

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
> > +                     if (data->info.sizep && size !=3D data->size)
> > +                             die("object %s changed size!?", oid_to_he=
x(oid));
> > +             }
>
> Wouldn't checking data->skip_object_info be sufficient? It's only set
> when opt->all_objects is set anyway. But more importantly, it is the
> most direct root of the problem: we did not find out the type and size
> earlier, so comparing anything against data->type is useless.
>
> But that leads me to a follow-up question: what if we did give a format,
> so skip_object_info isn't set, but it didn't include the type or size?
>

Indeed, such a situation may arise with some format atom e.g. %(objectname)
and %(rest). However %(deltabase) and %(objectdisk:size) don't have this
problem because they filled typep in `packed_object_info()`.

> In the size code, it looks like we explicitly protect against this by
> checking if data->info.sizep is set (i.e., did we request the size from
> oid_object_info_extended). But it's not for the type.
>

Yes, because we set typep while setting print_contents for
print_object_or_die() to check different object type case, this
leads to inconsistent behavior between sizep and typep.

> So the assumption is that we do always fill in the type, even if the
> user didn't ask for it. And that assumption is actually violated much
> earlier. These two bits of code from the setup are out of order:
>
>           if (opt->all_objects) {
>                   struct object_info empty =3D OBJECT_INFO_INIT;
>                   if (!memcmp(&data.info, &empty, sizeof(empty)))
>                           data.skip_object_info =3D 1;
>           }
>
>           /*
>            * If we are printing out the object, then always fill in the t=
ype,
>            * since we will want to decide whether or not to stream.
>            */
>           if (opt->print_contents)
>                   data.info.typep =3D &data.type;
>
> We should not let skip_object_info kick in at all if opt->print_contents
> is requested. And that causes other bugs outside of the spot you found.
> We look at data->type earlier in print_object_or_die() to decide whether
> or not to stream the contents, but we'll see garbage (fortunately we
> zero-initialize the expand_data struct, so it's at least predictably
> zero, and not random undefined behavior).
>
> But I think we'd want to solve it by swapping the two conditionals I
> showed above, which restores the assumption made in print_object_or_die()=
.
>

This method is correct. This will ensure that skip_object_info will not
be set when print_contents is set.

By the way, maybe we can merge this two "if (opt->all_objects)" block to on=
e.

        if (opt->all_objects) {
                struct object_info empty =3D OBJECT_INFO_INIT;
                if (!memcmp(&data.info, &empty, sizeof(empty)))
                        data.skip_object_info =3D 1;
        }

        if (opt->all_objects) {
                struct object_cb_data cb;

                if (has_promisor_remote())
                        warning("This repository uses promisor
remotes. Some objects may not be loaded.");

After the merger:

        if (opt->all_objects) {
                struct object_cb_data cb;
                struct object_info empty =3D OBJECT_INFO_INIT;

                if (!memcmp(&data.info, &empty, sizeof(empty)))
                        data.skip_object_info =3D 1;

                if (has_promisor_remote())
                        warning("This repository uses promisor
remotes. Some objects may not be loaded.");


> > +test_expect_success 'cat-file --batch=3D"batman" with --batch-all-obje=
cts will work' '
> > +     git -C all-two cat-file --batch-all-objects --batch=3D"%(objectna=
me)" | wc -l >expect &&
> > +     git -C all-two cat-file --batch-all-objects --batch=3D"batman" | =
wc -l >actual &&
> > +     test_cmp expect actual
> > +'
>
> Is it worth testing both of these? The %(objectname) one will fail in
> the same way (because we do not need to run oid_object_info() to get the
> oid, which we already have). I'm OK doing both for better coverage, but
> it may be worth mentioning either in a comment or in the commit message
> that we expect both to fail, and why.
>

Yes, these damages need to be pointed out in the commit message.

> -Peff

Thanks.
--
ZheNing Hu

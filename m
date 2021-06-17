Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0539BC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 09:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA09B61400
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 09:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhFQJzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 05:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhFQJzl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 05:55:41 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BE9C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 02:53:32 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b9so4892023ilr.2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ps46OokS1DYdnDzSlRlCGt73rl/tGpMXy7ZIPWB0ncw=;
        b=HSt6kZkpZVRYEqozEXsAvjREpEdeSkIxxrVpWkF79cubXVNt6m3RBlvqAwE55H7c08
         YG1v4QQDs6y+2l9o8yfFi3R2/zBv0UkkHTO5kXRohEtKGGtAzfDbkIYeomWCAeVS4hf7
         y4Nk/cL8Tiy5d4RAVu7ecYbda6pkXPO1MpyN5pcfDN7SpaYACZp/Qzv+YJYIaqvpMu7q
         m+P+rB48K/EfY7wpV1nicD40lS4040emZNsbldHycXQKtxB2z+JghkI+VXBf14qmzhbU
         mpUzv7G2S7/tEqcUk4zf3UUkKYWa2XNzQXoF/xIEfuFqVK5iSxutty0AHmPbWXJTbrNo
         gU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ps46OokS1DYdnDzSlRlCGt73rl/tGpMXy7ZIPWB0ncw=;
        b=F04ZpB8IEcx0sX1PqnWgZxZ/3fP4NnRjac6HZxiGuyVMGvgTm2GUHgY3UHoVHXoUL0
         1uJFlcRTniiEVuRHf8xml81R8+7JkLRbZjbnmbrf5ShPiqWWwc0GLeZh3dibP+EYdfYW
         had71yStRTkrzKgPOYpvMCMCXCrjqqw3bStuT9SVdDXYnWHbz/7RSuKNgTc6q5pm/RYu
         v+WkvNVpcyR1pfT3mmggnzxwfkWJa7hfxXH+fFNx2pSwx91xQD5OIiBFedZkfqa0N/PR
         IBhgp+o2G0zBmVpKHYQoFhV9HYMA0fPfTK6FtfnkbrxgUT+DbThGDqhuHLHyINe+R4p4
         o/eA==
X-Gm-Message-State: AOAM531Bu6da4hN3WaCA1+l3n4r8IJ6In/JZ3QRQQT8d7nk6aBgqinwr
        +exBcpLbxG5Tdvw9pf1bHgjQe0o6rlHdhkwZ/pk=
X-Google-Smtp-Source: ABdhPJx7iJKW9+E2aPmDPrbRX27JiMz2qhc732CpGOqGv4Ii/HPJ8vErM83ep7EdKju7FbdFllUQ4PVOxtb0wPGWAXE=
X-Received: by 2002:a05:6e02:1486:: with SMTP id n6mr2926569ilk.174.1623923612122;
 Thu, 17 Jun 2021 02:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <0004d5b24a0fb735d7fa9cb9a8e214d6e838baeb.1623496458.git.gitgitgadget@gmail.com>
 <87zgvpvtu4.fsf@evledraar.gmail.com>
In-Reply-To: <87zgvpvtu4.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 17 Jun 2021 17:53:20 +0800
Message-ID: <CAOLTT8QiFiXm7M=Cdk22wqztKKKaTnw3iQpv8DEtZp_iKRUdDw@mail.gmail.com>
Subject: Re: [PATCH 8/8] [GSOC] cat-file: re-implement --textconv, --filters options
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2021=E5=
=B9=B46=E6=9C=8817=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:22=E5=86=
=99=E9=81=93=EF=BC=9A
>
>
> On Sat, Jun 12 2021, ZheNing Hu via GitGitGadget wrote:
>
> > From: ZheNing Hu <adlternative@gmail.com>
>
> >       opt->format.format =3D format.buf;
> > +     if (opt->cmdmode =3D=3D 'c')
> > +             opt->format.use_textconv =3D 1;
> > +     if (opt->cmdmode =3D=3D 'w')
> > +             opt->format.use_filters =3D 1;
> > +
>
>
> Style nit: if/if -> if/else if, both can't be true.
>

Ok.

> > +             /* get the type and size */
> > +             if (oid_object_info_extended(the_repository, &oi->oid, &o=
i->info,
> > +                                     OBJECT_INFO_LOOKUP_REPLACE))
> > +                     return strbuf_addf_ret(err, 1, _("%s missing"),
> > +                                            oid_to_hex(&oi->oid));
> > +
> > +             oi->info.sizep =3D NULL;
> > +             oi->info.typep =3D NULL;
> > +             oi->info.contentp =3D temp_contentp;
>
> Here we have a call function and error if bad, then proceed to populate
> stuff (good)...
>
> > +
> > +             if (use_textconv) {
> > +                     act_oi =3D *oi;
> > +
> > +                     if(!ref->rest)
> > +                             return strbuf_addf_ret(err, -1, _("missin=
g path for '%s'"),
> > +                                                    oid_to_hex(&act_oi=
.oid));
> > +                     if (act_oi.type =3D=3D OBJ_BLOB) {
> > +                             if (textconv_object(the_repository,
> > +                                                 ref->rest, 0100644, &=
act_oi.oid,
> > +                                                 1, (char **)(&act_oi.=
content), &act_oi.size)) {
> > +                                     actual_oi =3D &act_oi;
> > +                                     goto success;
> > +                             }
> > +                     }
> > +             }
>
>
> Maybe change the if (A) { if (B) {} ) to if (A && B) {} ?
>

Maybe it's something like this:

@@ -1762,19 +1762,17 @@ static int get_object(struct ref_array_item
*ref, int deref, struct object **obj
                oi->info.typep =3D NULL;
                oi->info.contentp =3D temp_contentp;

-               if (use_textconv) {
-                       act_oi =3D *oi;
+               if (use_textconv && !ref->rest)
+                       return strbuf_addf_ret(err, -1, _("missing
path for '%s'"),
+                                              oid_to_hex(&act_oi.oid));

-                       if(!ref->rest)
-                               return strbuf_addf_ret(err, -1,
_("missing path for '%s'"),
-                                                      oid_to_hex(&act_oi.o=
id));
-                       if (act_oi.type =3D=3D OBJ_BLOB) {
-                               if (textconv_object(the_repository,
-                                                   ref->rest,
0100644, &act_oi.oid,
-                                                   1, (char
**)(&act_oi.content), &act_oi.size)) {
-                                       actual_oi =3D &act_oi;
-                                       goto success;
-                               }
+               if (use_textconv && oi->type =3D=3D OBJ_BLOB) {
+                       act_oi =3D *oi;
+                       if (textconv_object(the_repository,
+                                           ref->rest, 0100644, &act_oi.oid=
,
+                                           1, (char
**)(&act_oi.content), &act_oi.size)) {
+                               actual_oi =3D &act_oi;
+                               goto success;
                        }
                }
        }

> >       }
> >       if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
> >                                    OBJECT_INFO_LOOKUP_REPLACE))
> > @@ -1748,19 +1786,43 @@ static int get_object(struct ref_array_item *re=
f, int deref, struct object **obj
> >               BUG("Object size is less than zero.");
> >
> >       if (oi->info.contentp) {
> > -             *obj =3D parse_object_buffer(the_repository, &oi->oid, oi=
->type, oi->size, oi->content, &eaten);
> > +             if (use_filters) {
> > +                     if(!ref->rest)
> > +                             return strbuf_addf_ret(err, -1, _("missin=
g path for '%s'"),
> > +                                                    oid_to_hex(&oi->oi=
d));
> > +                     if (oi->type =3D=3D OBJ_BLOB) {
> > +                             struct strbuf strbuf =3D STRBUF_INIT;
> > +                             struct checkout_metadata meta;
> > +                             act_oi =3D *oi;
> > +
> > +                             init_checkout_metadata(&meta, NULL, NULL,=
 &act_oi.oid);
> > +                             if (convert_to_working_tree(&the_index, r=
ef->rest, act_oi.content, act_oi.size, &strbuf, &meta)) {
> > +                                     act_oi.size =3D strbuf.len;
> > +                                     act_oi.content =3D strbuf_detach(=
&strbuf, NULL);
> > +                                     actual_oi =3D &act_oi;
> > +                             } else {
> > +                                     die("could not convert '%s' %s",
> > +                                         oid_to_hex(&oi->oid), ref->re=
st);
> > +                             }
>
> ... but here instead of "if (!x) { bad } do stuff" we have if (x) {do
> stuff} else { bad }". Better to get the die out of the way, and avoid
> the indentation on the "do stuff" IMO.
>

And this part:

@@ -1786,25 +1784,21 @@ static int get_object(struct ref_array_item
*ref, int deref, struct object **obj
                BUG("Object size is less than zero.");

        if (oi->info.contentp) {
-               if (use_filters) {
-                       if(!ref->rest)
-                               return strbuf_addf_ret(err, -1,
_("missing path for '%s'"),
-                                                      oid_to_hex(&oi->oid)=
);
-                       if (oi->type =3D=3D OBJ_BLOB) {
-                               struct strbuf strbuf =3D STRBUF_INIT;
-                               struct checkout_metadata meta;
-                               act_oi =3D *oi;
-
-                               init_checkout_metadata(&meta, NULL,
NULL, &act_oi.oid);
-                               if
(convert_to_working_tree(&the_index, ref->rest, act_oi.content,
act_oi.size, &strbuf, &meta)) {
-                                       act_oi.size =3D strbuf.len;
-                                       act_oi.content =3D
strbuf_detach(&strbuf, NULL);
-                                       actual_oi =3D &act_oi;
-                               } else {
-                                       die("could not convert '%s' %s",
-                                           oid_to_hex(&oi->oid), ref->rest=
);
-                               }
-                       }
+               if (use_filters && !ref->rest)
+                       return strbuf_addf_ret(err, -1, _("missing
path for '%s'"),
+                                               oid_to_hex(&oi->oid));
+               if (use_filters && oi->type =3D=3D OBJ_BLOB) {
+                       struct strbuf strbuf =3D STRBUF_INIT;
+                       struct checkout_metadata meta;
+                       act_oi =3D *oi;
+
+                       init_checkout_metadata(&meta, NULL, NULL, &act_oi.o=
id);
+                       if (!convert_to_working_tree(&the_index,
ref->rest, act_oi.content, act_oi.size, &strbuf, &meta))
+                               die("could not convert '%s' %s",
+                                       oid_to_hex(&oi->oid), ref->rest);
+                       act_oi.size =3D strbuf.len;
+                       act_oi.content =3D strbuf_detach(&strbuf, NULL);
+                       actual_oi =3D &act_oi;
                }


>
> > -#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, -1 }
> > +#define REF_FORMAT_INIT { NULL, NULL, 0, 0, 0, 0, 0, -1 }
>
> Not a new problem, but an earlier cleanup to simply change this to
> designated initializers would be welcome, see recent work of mine in
> fsck.h for an example.
>
> I.e. we keep churning on changing this *_INIT just to populate the one
> -1 field at the end, can also be simply:
>
>     #define FOO_INIT { .that_field =3D 1 }
>

I agree, this method is better. We don't need to care about which members
so many "0" point to.

Thanks.
--
ZheNing Hu

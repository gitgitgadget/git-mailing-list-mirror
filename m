Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCE4C433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 04:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A793061261
	for <git@archiver.kernel.org>; Fri, 21 May 2021 04:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbhEUEpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 00:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbhEUEpi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 00:45:38 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970CEC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 21:44:16 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s7so2817030iov.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 21:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XuKRji13Id/B45KMAyYtbXXy7n2b20ljjeTu2294xmI=;
        b=TuBdAo9WqN9FeyvWo8mMV0oREjansRVEIfbaw7AVl8a18IYH58g/XODjjGl1Qwf/kj
         QWqGkBJs4iqlPzJyxLXdw+AsmOebJlcRSZqUIeMU9jT3F0HWwncy3llLAUxYY+mFx+nD
         hz0cprQWIdNV8QRl5AYSCwDenajQHiUkzZOy1C73OMe7dr5+oHL3IOnf5nvk7eZhY7ue
         jEuS419wp7y9AeCtTRelE9RhhoxJGIubZASUdr4vwY0Yiw+0oJxOyEEroptEaH/YskMH
         3fAve7Ep5g2m+o51W6qKk4MM1Cb0jB42Ewdcfaa4hCm3e/HuE1fHkhFyR5hv4KO6ZJzY
         1daQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XuKRji13Id/B45KMAyYtbXXy7n2b20ljjeTu2294xmI=;
        b=GGX/XBSPAZB//O6urLyxhP3p1rvA9MhP88utDRxrL7jU05vzJhsOAcWD2FTEX/qM8J
         eE9dbF+PDFqZgV1kUKHdM8nHay+VOgOGjNprisrd/o/BtgJmAEA04KXffktC/hJ89Gv1
         VEtVqAJon3X495v8V4QAOBCKp5upRWTB864vuV9jkMCJ2syGDHCtenmZacewhn+wpL1F
         1KCPUX3wKvA6s9ww0gcSG4T35Kf4KEJYC1kRAVjk75tNKVYvxmSGw06R2Iy732cCskHP
         ebVoJVwQY4JMzjtAX8DJtcCAyLKYw9cZnkaHYXz036ZHAylDcV1V9Gi6QKwARuUxGOev
         8RkA==
X-Gm-Message-State: AOAM533Gj2CAB/YdV8F8DdwgxOXRuAqBJQPQl8JHxIuWfRL1ihQmUVGw
        +ViG+lvcomA194jU8I0eRPjZefZwCMzJF+CnHWRYE0S5zeqDqCuPo+M=
X-Google-Smtp-Source: ABdhPJwQ38LJC5hzMxPATJ8iSc12YfsKPWys+nEbnq87mPu59RxQbV7Tb6DFzb5MHRHOIscWsJuriH2HT7eOmuJdjYY=
X-Received: by 2002:a5d:89c5:: with SMTP id a5mr9829770iot.172.1621572255770;
 Thu, 20 May 2021 21:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.958.git.1621500593126.gitgitgadget@gmail.com> <CAP8UFD0Pzdb_9+VpeLrydu8ROdVi4ygFPk367J+NWGL0P5nXdg@mail.gmail.com>
In-Reply-To: <CAP8UFD0Pzdb_9+VpeLrydu8ROdVi4ygFPk367J+NWGL0P5nXdg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 21 May 2021 12:43:59 +0800
Message-ID: <CAOLTT8S_Bu1PG+-gVK_6iUx--YrMx2hxDCTa=5sW6UJv9Oz_0Q@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: add contents:raw atom
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=8821=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:20=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Thu, May 20, 2021 at 10:49 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Add new formatting option %(contents:raw), which will
> > print all the object contents without any changes.
>
> Maybe you could tell how it would be different from %(contents), or in
> other words what are the changes that %(contents) makes.
>
> Isn't %(contents) only printing the commit message or the tag message
> of a commit or a tag respectively? If %(contents:raw) would print all
> the object contents, it could feel strange that it is actually
> printing more than %(contents).
>

Okay, some explanations are indeed missing here:

%(contents) will discard the metadata part of the object file,
and only print the data contents part of it. %(contents:raw)
can will not discard the metadata part of the object file, this
 means that it can print the "raw" content of an object.

In addition, %(contents:raw) can support print commit, blob,
tag, tree objects contents which %(contents) can only support
commit,tag objects.

E.g:

git for-each-ref --format=3D%(contents:raw) refs/heads/foo

will have the same output as:

git rev-parse refs/heads/foo | git cat-file --batch

> Also is %(contents:raw) supposed to print something for a blob or a
> tree, while I guess %(contents) is printing nothing for them?
>

Now my thoughts are:
Let %(contents) learn to print four kinds of objects.
and then let %(contents:raw) learn to print metadata.
I will split it into two patches.

> > It will help further to migrate all cat-file formatting
> > logic from cat-file to ref-filter.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
>
> It looks like you rewrote the patch nearly completely, but if you
> based your patch on, or got inspired by, Olga's work, it might be nice
> to acknowledge this using a trailer (for example "Based-on-patch-by:
> ..." or "Helped-by:...").
>

Okay, "Based-on-patch-by" would be more appropriate here.

> > @@ -1312,6 +1315,13 @@ static void grab_sub_body_contents(struct atom_v=
alue *val, int deref, void *buf)
> >                     !starts_with(name, "trailers") &&
> >                     !starts_with(name, "contents"))
> >                         continue;
> > +               if (atom->u.contents.option =3D=3D C_RAW) {
> > +                       v->s =3D xmemdupz(buf, buf_size);
> > +                       continue;
> > +               }
> > +               if (object_type !=3D OBJ_TAG && object_type !=3D OBJ_CO=
MMIT)
> > +                       continue;
>
> When seeing the 2 lines above, I am guessing that, before this patch,
> grab_sub_body_contents() couldn't actually be called when object_type
> was OBJ_BLOB or OBJ_TREE, but you have made other changes elsewhere so
> that now it can. As only the atom->u.contents.option =3D=3D C_RAW case is
> relevant in this case, you added this check. Let's see if I am
> right...
>
> >                 if (!subpos)
> >                         find_subpos(buf,
> >                                     &subpos, &sublen,
> > @@ -1374,25 +1384,30 @@ static void fill_missing_values(struct atom_val=
ue *val)
> >   * pointed at by the ref itself; otherwise it is the object the
> >   * ref (which is a tag) refers to.
> >   */
> > -static void grab_values(struct atom_value *val, int deref, struct obje=
ct *obj, void *buf)
> > +static void grab_values(struct atom_value *val, int deref, struct obje=
ct *obj, struct expand_data *data)
> >  {
> > +       void *buf =3D data->content;
> > +       unsigned long buf_size =3D data->size;
> > +
> >         switch (obj->type) {
> >         case OBJ_TAG:
> >                 grab_tag_values(val, deref, obj);
> > -               grab_sub_body_contents(val, deref, buf);
> > +               grab_sub_body_contents(val, deref, buf, buf_size, obj->=
type);
> >                 grab_person("tagger", val, deref, buf);
> >                 break;
> >         case OBJ_COMMIT:
> >                 grab_commit_values(val, deref, obj);
> > -               grab_sub_body_contents(val, deref, buf);
> > +               grab_sub_body_contents(val, deref, buf, buf_size, obj->=
type);
> >                 grab_person("author", val, deref, buf);
> >                 grab_person("committer", val, deref, buf);
> >                 break;
> >         case OBJ_TREE:
> >                 /* grab_tree_values(val, deref, obj, buf, sz); */
> > +               grab_sub_body_contents(val, deref, buf, buf_size, obj->=
type);
> >                 break;
> >         case OBJ_BLOB:
> >                 /* grab_blob_values(val, deref, obj, buf, sz); */
> > +               grab_sub_body_contents(val, deref, buf, buf_size, obj->=
type);
>
> ...ok, I was right above. The issue now is that I wonder if
> grab_sub_body_contents() is still a good name for a function that can
> be called for a blob or a tree which does not really have a body.
>

Makes sense, It might be better to use the new name: grab_contents().

> >                 break;
> >         default:
> >                 die("Eh?  Object of type %d?", obj->type);
> > @@ -1614,7 +1629,7 @@ static int get_object(struct ref_array_item *ref,=
 int deref, struct object **obj
> >                         return strbuf_addf_ret(err, -1, _("parse_object=
_buffer failed on %s for %s"),
> >                                                oid_to_hex(&oi->oid), re=
f->refname);
> >                 }
> > -               grab_values(ref->value, deref, *obj, oi->content);
> > +               grab_values(ref->value, deref, *obj, oi);
> >         }
> >
> >         grab_common_values(ref->value, deref, oi);
> > diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> > index 9e0214076b4d..baa3a40a70b1 100755
> > --- a/t/t6300-for-each-ref.sh
> > +++ b/t/t6300-for-each-ref.sh
> > @@ -686,6 +686,17 @@ test_atom refs/tags/signed-empty contents:body ''
> >  test_atom refs/tags/signed-empty contents:signature "$sig"
> >  test_atom refs/tags/signed-empty contents "$sig"
> >
> > +test_expect_success 'basic atom: refs/tags/signed-empty contents:raw' =
'
> > +       git cat-file tag refs/tags/signed-empty >expected &&
> > +       git for-each-ref --format=3D"%(contents:raw)" refs/tags/signed-=
empty >actual &&
> > +       sanitize_pgp <expected >expected.clean &&
> > +       sanitize_pgp <actual >actual.clean &&
> > +       echo "" >>expected.clean &&
> > +       test_cmp expected.clean actual.clean
> > +'
>
> For an empty tag %(contents:raw) should produce nothing, ok.
>
> > +test_atom refs/tags/signed-empty *contents:raw $(git cat-file commit H=
EAD)
>
> Maybe use single quotes around *contents:raw?
>
> The rest looks good to me. Thanks!

Good suggestion. thank!
--
ZheNing Hu

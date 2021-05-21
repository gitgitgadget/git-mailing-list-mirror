Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C76C43460
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E0B613AC
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbhEUJLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 05:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbhEUJLk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 05:11:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C47C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 02:10:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o5so13537429edc.5
        for <git@vger.kernel.org>; Fri, 21 May 2021 02:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rxcyZhCt22tZ0A1BHtHscp5v1pvW8WKh1FMgb2ZzkrA=;
        b=WYMx7hNL6ssuZDNwyppLzxj/pAgDZSVt8kB0hJArcbv7yarYSGgbXCXPJ3Hf20AS16
         wFnV2qDJPubVqv6+XEHMhdlJnouetklx1Dt93Md28zL0KQEDVLS18sdOnr9l6YVFnVm1
         ZqNy0v2awlzvDY4Pv2V7+4ZCel4ClUZhJ2BKDH8MxoHNUTsk/77cF3eaTb78ORucG0aD
         EabqO4Fds8SF/C81ehGXPTsfNtlUBOkDbNPwp712/h4R3ZNo5IvDaqwxK9sj+381iiiK
         lOGJc0MhHWYmG6NmMImVEiYbHvAA7HcY+QR4XnF/eFjzU98hfGeMOoaXVXwyitUMjJ63
         EYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rxcyZhCt22tZ0A1BHtHscp5v1pvW8WKh1FMgb2ZzkrA=;
        b=DcYaceGZ3uBgYYYpZBAtaqS1+6FgzrubyRUPfOxg+AXHHcqBFKN67D6NPZw57GnaE2
         lLZwJr8A7iIToULXS4VqSt5yVQ+4O0BMgjzR/FxOC38j4HN6JBuVvacF4Yj4tzGbR0aH
         8GEtK+Cwx1SQjJYRnLdXfaeTVOpy6GPiacHBAlRzHGTdtRDcMgeW5cWMSLYy8zhYb3HJ
         9+1zB4V7qKunEgP0zY22HJTp5DZ3q+/CpQByDi41J6jQjl7ez3zk84IPhv1gqzR5+AaR
         NaV773Uc/ZZS8HT8XKVtuZHp8QR1h2G1N96piMRxwm3rsLnhCWnBzsbH2+jEzJvANPG/
         tzKw==
X-Gm-Message-State: AOAM533d1kWBGIpH+Uf6qgcO08a+xB2gPhfG7BPwuSfGEvEMNVujkFO6
        NFJzHC4kHsndaG6P9m0SNoKBZ0tg8RQyvAY1H07+DLyJ3mCKcA==
X-Google-Smtp-Source: ABdhPJzqKzT+onNSOd7jJGmYazf2Ovrh/pnN99dDQGk2+XDkdJvB67H3cblEbok0tJNSpB9uQ+RU2kKo9I9epZ63Ks4=
X-Received: by 2002:a05:6402:1d2c:: with SMTP id dh12mr6705020edb.237.1621588216491;
 Fri, 21 May 2021 02:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.958.git.1621500593126.gitgitgadget@gmail.com>
 <CAP8UFD0Pzdb_9+VpeLrydu8ROdVi4ygFPk367J+NWGL0P5nXdg@mail.gmail.com> <CAOLTT8S_Bu1PG+-gVK_6iUx--YrMx2hxDCTa=5sW6UJv9Oz_0Q@mail.gmail.com>
In-Reply-To: <CAOLTT8S_Bu1PG+-gVK_6iUx--YrMx2hxDCTa=5sW6UJv9Oz_0Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 May 2021 11:10:05 +0200
Message-ID: <CAP8UFD1yLS9UBs0r6_GjB-K6prW7GNxR+z445HJe8cR4HYLewA@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: add contents:raw atom
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 6:44 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=
=9C=8821=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:20=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> > On Thu, May 20, 2021 at 10:49 AM ZheNing Hu via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > From: ZheNing Hu <adlternative@gmail.com>
> > >
> > > Add new formatting option %(contents:raw), which will
> > > print all the object contents without any changes.
> >
> > Maybe you could tell how it would be different from %(contents), or in
> > other words what are the changes that %(contents) makes.
> >
> > Isn't %(contents) only printing the commit message or the tag message
> > of a commit or a tag respectively? If %(contents:raw) would print all
> > the object contents, it could feel strange that it is actually
> > printing more than %(contents).
>
> Okay, some explanations are indeed missing here:

By the way I forgot to say that your patch might want to also properly
document %(contents:raw). If the doc was updated as part of the patch,
maybe the whole patch would be easier to understand.

> %(contents) will discard the metadata part of the object file,

It's not clear what you mean when you talk about metadata in objects.
Are you taking about only the headers, like the "tree XXX", "parent
YYY", etc lines in commits, and the "object OOO", "type TTT", etc
lines in tags? Or does it also includes the lines in tree objects that
reference other trees or blobs?

> and only print the data contents part of it. %(contents:raw)
> can will not discard the metadata part of the object file, this

s/can//

>  means that it can print the "raw" content of an object.

The above seems to be changing the definition of %(contents) (as
previously it was only the commit message of a commit or the tag
message a tag) to explain %(contents:raw)...

> In addition, %(contents:raw) can support print commit, blob,
> tag, tree objects contents which %(contents) can only support
> commit,tag objects.

...but this is saying that the definition of %(contents) actually
doesn't change. This doesn't seem logical to me.

If %(contents:raw) can support any kind of object (commit, blob, tag
or tree) then it would be logical that %(contents) also support any
kind of object.

So if you really want to define %(contents:raw) as the raw object
contents, you might want to consider a preparatory patch that would
first change the definition of %(contents) to be the object contents
without the headers. This would keep the same output for any commit or
tag. But for blobs and trees it would print the whole content of the
object in the same way as `git cat-file -p` does, instead of nothing.

I think this acceptable as refs rarely point to something other than
commits, so people are not likely to rely on the fact that %(contents)
currently prints nothing for blobs and trees.

> E.g:
>
> git for-each-ref --format=3D%(contents:raw) refs/heads/foo
>
> will have the same output as:
>
> git rev-parse refs/heads/foo | git cat-file --batch

Ok, I think that would indeed be useful.

> > Also is %(contents:raw) supposed to print something for a blob or a
> > tree, while I guess %(contents) is printing nothing for them?
>
> Now my thoughts are:
> Let %(contents) learn to print four kinds of objects.
> and then let %(contents:raw) learn to print metadata.
> I will split it into two patches.

Yeah, great!

> > > It will help further to migrate all cat-file formatting
> > > logic from cat-file to ref-filter.
> > >
> > > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> >
> > It looks like you rewrote the patch nearly completely, but if you
> > based your patch on, or got inspired by, Olga's work, it might be nice
> > to acknowledge this using a trailer (for example "Based-on-patch-by:
> > ..." or "Helped-by:...").
>
> Okay, "Based-on-patch-by" would be more appropriate here.

Nice!

> > > @@ -1312,6 +1315,13 @@ static void grab_sub_body_contents(struct atom=
_value *val, int deref, void *buf)
> > >                     !starts_with(name, "trailers") &&
> > >                     !starts_with(name, "contents"))
> > >                         continue;
> > > +               if (atom->u.contents.option =3D=3D C_RAW) {
> > > +                       v->s =3D xmemdupz(buf, buf_size);
> > > +                       continue;
> > > +               }
> > > +               if (object_type !=3D OBJ_TAG && object_type !=3D OBJ_=
COMMIT)
> > > +                       continue;
> >
> > When seeing the 2 lines above, I am guessing that, before this patch,
> > grab_sub_body_contents() couldn't actually be called when object_type
> > was OBJ_BLOB or OBJ_TREE, but you have made other changes elsewhere so
> > that now it can. As only the atom->u.contents.option =3D=3D C_RAW case =
is
> > relevant in this case, you added this check. Let's see if I am
> > right...
> >
> > >                 if (!subpos)
> > >                         find_subpos(buf,
> > >                                     &subpos, &sublen,
> > > @@ -1374,25 +1384,30 @@ static void fill_missing_values(struct atom_v=
alue *val)
> > >   * pointed at by the ref itself; otherwise it is the object the
> > >   * ref (which is a tag) refers to.
> > >   */
> > > -static void grab_values(struct atom_value *val, int deref, struct ob=
ject *obj, void *buf)
> > > +static void grab_values(struct atom_value *val, int deref, struct ob=
ject *obj, struct expand_data *data)
> > >  {
> > > +       void *buf =3D data->content;
> > > +       unsigned long buf_size =3D data->size;
> > > +
> > >         switch (obj->type) {
> > >         case OBJ_TAG:
> > >                 grab_tag_values(val, deref, obj);
> > > -               grab_sub_body_contents(val, deref, buf);
> > > +               grab_sub_body_contents(val, deref, buf, buf_size, obj=
->type);
> > >                 grab_person("tagger", val, deref, buf);
> > >                 break;
> > >         case OBJ_COMMIT:
> > >                 grab_commit_values(val, deref, obj);
> > > -               grab_sub_body_contents(val, deref, buf);
> > > +               grab_sub_body_contents(val, deref, buf, buf_size, obj=
->type);
> > >                 grab_person("author", val, deref, buf);
> > >                 grab_person("committer", val, deref, buf);
> > >                 break;
> > >         case OBJ_TREE:
> > >                 /* grab_tree_values(val, deref, obj, buf, sz); */
> > > +               grab_sub_body_contents(val, deref, buf, buf_size, obj=
->type);
> > >                 break;
> > >         case OBJ_BLOB:
> > >                 /* grab_blob_values(val, deref, obj, buf, sz); */
> > > +               grab_sub_body_contents(val, deref, buf, buf_size, obj=
->type);
> >
> > ...ok, I was right above. The issue now is that I wonder if
> > grab_sub_body_contents() is still a good name for a function that can
> > be called for a blob or a tree which does not really have a body.
>
> Makes sense, It might be better to use the new name: grab_contents().

Yeah.

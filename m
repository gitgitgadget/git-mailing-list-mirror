Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C26C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 13:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5866F23788
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 13:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbhAHNPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 08:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbhAHNPP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 08:15:15 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13B3C0612F4
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 05:14:34 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id f6so9289502ybq.13
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 05:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aTOA0kqiM4LkBHY2Ks3IYewQvB+A/fSD/naukEaxgeE=;
        b=Adpi/wT3kSk1at3SqcKkVt+RoSWMu7aIQfCPdxMmCHlrBdRYZSZL2qFP/w0o3duRwY
         jg1W3u1G0WM5yV1VvG7BTo97CqxAlr7uGAy16rttYev1qkm/Urohni/SK/xHOTdZF2k1
         HY+vct1aJ6r5si66H2GCfDJztUx5NpJ5tpr4zNTQzNWufR0DldIEoWoLMYsEIbWfExBk
         f8RwmZ56vw1IEzSL1oN1gvSkNZg/tDSJ4xCT6ETN7MIkeIqw1mB1eQayCbLgtboaqeqL
         kxqrZpn6WL+jhv1uJXocUNxKSwM7cFpMuROxFZjsdHANykMT+T03wnyjuJ45Tn0b2/Qw
         ocEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aTOA0kqiM4LkBHY2Ks3IYewQvB+A/fSD/naukEaxgeE=;
        b=ZZKcncGDGLVSrcEZwgnE8nkKCGyVhzErqPEP5s77oXOJs5Q3vWWJKDkefqkHFyh7zD
         AGvCNRaxZCW7xNW5MmuOXAggFBRwbMGHyCTdV3WvHLdm7rpBiuEdN3Mb7j4mYwAkw8f5
         rcCmd7A2wXCXWpKcRWQvrZWxSGT2sjcjbECbFgvtgMdYV/TyHF1G1nSXutioOvL5jJ6W
         iQ+Ynd1IypGv60K0lwiAhyCmDt2IPY7SzEgwzFnujogkMNPY6JOuir0x0UWJ28SV71hz
         oVPHjguq6Bz31fKkVjT/hEfDgCAEOrx+rQ+l2lqu3ug7XG+fq7mNOgRzGJ00xjWlkBhk
         Alrg==
X-Gm-Message-State: AOAM530Vh6DCRrDKCbHVB2ox9PAFe+Haz2yn0I9RIzxxNajPthv3cznq
        IZrq2KQ/lJPSGFYOYLD2oWpOAQHvr8GwzOziypc=
X-Google-Smtp-Source: ABdhPJwdV1PU9d9JZy5ZECULBqXOc79zUqn7ae7KLbTcyst1DApnvnUmUpSJ4sEJshSVYVw41GitWtJBlDcTy7fWR28=
X-Received: by 2002:a25:44d7:: with SMTP id r206mr5368032yba.323.1610111673987;
 Fri, 08 Jan 2021 05:14:33 -0800 (PST)
MIME-Version: 1.0
References: <xmqqft3g6ziz.fsf@gitster.c.googlers.com> <20210107135025.2682-2-worldhello.net@gmail.com>
 <X/cqrTgilKAW9P9G@danh.dev>
In-Reply-To: <X/cqrTgilKAW9P9G@danh.dev>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 8 Jan 2021 21:14:22 +0800
Message-ID: <CANYiYbG84GuwnU5QEg0NoMfYS0fWzfDbz-yruA2fr2yQfyfMhg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bundle: lost objects when removing duplicate pendings
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> =E4=BA=8E=
2021=E5=B9=B41=E6=9C=887=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8811:37=
=E5=86=99=E9=81=93=EF=BC=9A
>
> > -static int contains_name(struct object_array *array, const char *name)
> > +static int contains_object(struct object_array *array,
> > +                        const struct object *item, const char *name)
> >  {
> >       unsigned nr =3D array->nr, i;
> >       struct object_array_entry *object =3D array->objects;
> >
> >       for (i =3D 0; i < nr; i++, object++)
> > -             if (!strcmp(object->name, name))
> > +             if (item =3D=3D object->item && !strcmp(object->name, nam=
e))
>
> I think the comparison of `item =3D=3D object->item` is a bit too fragile=
.
> Yes, we all know `item` must be an entry of array.
> However, it's separated from its usage may lead to misuse in the
> future. Perhaps using `oidcmp` or adding a comment to indicate that
> `item` must be an entry of `array`.

You can find the same usage on comparing address of objects in other places=
:

+ https://github.com/git/git/blob/v2.30.0/bundle.c#L447
+ https://github.com/git/git/blob/v2.30.0/commit.c#L954

Both `item` and `object->item` point to address of a shared object in
parsed_object_pool of the repository, we can compare two objects by
checking address of them safely.

> > +test_bundle_object_count () {
> > +     bundle=3D$1 &&
> > +     pack=3D${bundle%.bdl}.pack &&
> > +     convert_bundle_to_pack <"$bundle" >"$pack" &&
> > +     git index-pack "$pack" &&
> > +     git verify-pack -v "$pack" >verify.out &&
> > +     count=3D$(grep "^$OID_REGEX " verify.out | wc -l) &&
>
> I think we can use 'grep -c' instead of `grep .. | wc -l`.

This function is borrowed from `t5510-fetch.sh`, and will change like
this. Thanks.

> > +
> > +convert_bundle_to_pack () {
> > +     while read x && test -n "$x"
> > +     do
> > +             :;
> > +     done
> > +     cat
>
> I'm not sure what you would expect in this case,
> but in my experience, I replace this whole block with
>
>         sed '1,/^$/d'

This function is used to convert bundle file to pack file by strip the
header, which has a signature, prerequisites, references. This
function is also borrowed from "t5510-fetch.sh".

> For the below change, I haven't checked but I think test_commit should wo=
rk, no?
> > +test_expect_success 'setup' '
> > +     # commit A & B
> > +     cat >main.txt <<-EOF &&
> > +             Commit A
> > +             EOF
> > +     git add main.txt &&
> > +     test_tick &&
> > +     git commit -m "Commit A" &&
> > +
> > +     cat >main.txt <<-EOF &&
> > +             Commit B
> > +             EOF
> > +     git add main.txt &&
> > +     test_tick &&
> > +     git commit -m "Commit B" &&
> > +     A=3D$(git rev-parse HEAD~) &&
> > +     B=3D$(git rev-parse HEAD) &&

I should refactor these code, but I forgot.  After examine the
`test_commit` function, I have to write a new helper, because it does
not meet my needs.
1. It should not create a tag every time.
2. The tag it created is not an annotated tag.
3. I need to store the object id to a variable.

So I write a new helper `test_commit_setvar()` in next reroll. And
make this testcase much simpler.

test_expect_success 'setup' '
        # branch main: commit A & B
        test_commit_setvar A "Commit A" main.txt &&
        test_commit_setvar B "Commit B" main.txt &&

        # branch topic/1: commit C & D, refs/pull/1/head
        git checkout -b topic/1 &&
        test_commit_setvar C "Commit C" topic-1.txt &&
        test_commit_setvar D "Commit D" topic-1.txt &&
        git update-ref refs/pull/1/head HEAD &&

        # branch topic/1: commit E, tag v1
        git checkout main &&
        test_commit_setvar E "Commit E" main.txt &&
        test_commit_setvar TAG1 --tag v1 &&

        # branch topic/2: commit F & G, refs/pull/2/head
        git checkout -b topic/2 &&
        test_commit_setvar F "Commit F" topic-2.txt &&
        test_commit_setvar G "Commit G" topic-2.txt &&
        git update-ref refs/pull/2/head HEAD &&
        test_commit_setvar H "Commit H" topic-2.txt &&

        # branch main: merge commit I & J
        git checkout main &&
        test_tick &&
        test_commit_setvar I --merge topic/1 "Merge commit I" &&
        test_commit_setvar J --merge refs/pull/2/head "Merge commit J" &&

        # branch main: commit K
        git checkout main &&
        test_commit_setvar K "Commit K" main.txt &&

        # branch release:
        git checkout -b release &&
        test_commit_setvar L "Commit L" release.txt &&
        test_commit_setvar M "Commit M" release.txt &&
        test_commit_setvar TAG2 --tag v2 &&
        test_commit_setvar N "Commit N" release.txt &&
        test_commit_setvar TAG3 --tag v3 &&

        # branch main: merge commit O, commit P
        git checkout main &&
        test_commit_setvar O --merge tags/v2 "Merge commit O" &&
        test_commit_setvar P "Commit P" main.txt
'

--
Jiang Xin

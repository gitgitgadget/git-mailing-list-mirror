Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F3BC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96A7613AA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 16:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFQQQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 12:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhFQQQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 12:16:58 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF06EC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:14:50 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s26so446540ioe.9
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JFcb10JEWCiFk5xteB73PU4ey/dOg+dgNkSpg7q1SJU=;
        b=V1kUCdKUhRAcbG79TqMWu9d1abqT9gMeCKWUUrh4u92LgETajPVcQXQxJR/IUAqD5J
         T8hImnJWotNqgNlJOrID6TX7rDZ986yjXhtDQo4+v9Dj0Tq76ktkgedSpTZo28J2PMas
         6LKktjuK2hao0lsuXaZeF3i+DjjSS8O02W+Wm/56T+FmCo3zHVF8B/nRMvgOyxPDwtNr
         gr+2GRXvu2tRWqMTb1rUINrGyf4tE6kep2XmS9bWBiWcdFIq98kiVCT7u6TbjMUar6at
         rKo+cxCGhydsrVah+8Gd1opReilQRvhonskIIIuUtN+KCF9CNBLK6eqQsyRWcg9ifTYg
         jfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JFcb10JEWCiFk5xteB73PU4ey/dOg+dgNkSpg7q1SJU=;
        b=p80+ziVfCFmbrq5ehus7Exs+fZ1MT7lIZohW67nbulsZsmgeEv7gzJv4W9R48ClPyC
         x9MlWzv26WT3pQ0IFrXAthB30fIdkyF7B2pH7N5iB9V+10AifPKbkpsSFfdPxXrMy75y
         DFOK6GIF+y8em/lLQZS2axxwJtcvc3jXFIFy1Hkal91VsporfrYGmzFYCJ8MRkFxCMeG
         BNNdDMwoX6lyUAWms9VdJSPpyH/bxQKd/VjcKCOU0k0D7VA1Mk1mobQdVPVXTpiAxz7e
         BgkBFo7TrxZPHZ2J6FcWoZBKAKaG/0synV8Avl6wzj6wd8wpvAz7xfbjQc92iDHwxMDC
         tTRQ==
X-Gm-Message-State: AOAM532BzNZKCmNRnurUlwb8BWf5W0dWDKW9/MosEWetXOCcsnEpESMc
        HDpxyX1ic0zDyqO6doY9YO21TSFoxBynktMG8Ic=
X-Google-Smtp-Source: ABdhPJxI1My+3r2kXJI6Zl6iXhEEN6fd/Obuc4EyCEM4aml/Tncb+ptFSVvMuXDJU9Qc8UOVojE5SHF4hMnxgf0If5w=
X-Received: by 2002:a05:6638:144a:: with SMTP id l10mr5524029jad.50.1623946490128;
 Thu, 17 Jun 2021 09:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <abee6a03becb929ffb292648d1ef64e61b66d53d.1623496458.git.gitgitgadget@gmail.com>
 <875yydx8oo.fsf@evledraar.gmail.com> <CAOLTT8TMOs-FF+EcTZBbxfGnKQipe_nx_eZon=S=PWRTNT4CjA@mail.gmail.com>
 <87r1h0wnwg.fsf@evledraar.gmail.com>
In-Reply-To: <87r1h0wnwg.fsf@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 18 Jun 2021 00:14:37 +0800
Message-ID: <CAOLTT8SGkObKWMZax-k4KXgsN+7ezvOMkRU-zt+c2zon2Ta3pA@mail.gmail.com>
Subject: Re: [PATCH 2/8] [GSOC] ref-filter: add %(raw) atom
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
=B9=B46=E6=9C=8817=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:45=E5=86=
=99=E9=81=93=EF=BC=9A
>
>
> On Thu, Jun 17 2021, ZheNing Hu wrote:
>
> >
> > Yes, strbuf is a suitable choice when using <str,len> pair.
> > But if replace v->s with strbuf, the possible changes will be larger.
>
> I for one would like to see it done that way, those changes are usually
> easy to read. Also it seems a large part of 2/8 is extra new code
> because we didn't do that, e.g. getting length differently if something
> is a strbuf or not, passing char*/size_t pairs to new functions etc.
>

After some refactoring, I found that there are two problems:
1. There are a lot of codes like this in ref-filter to fill v->s:

v->s =3D show_ref(...)
v->s =3D copy_email(...)

It is very difficult to modify here: We know that show_ref()
or copy_email() will allocate a block of memory to v->s, but
if v->s is a strbuf, what should we do? In copy_email(), we
can pass the v->s to copy_email() and use strbuf_add()/strbuf_addstr()
instead of xstrdup() and xmemdupz(). But show_ref() will call
external functions like shorten_unambiguous_ref(), we don=E2=80=99t know
whether it will return us NULL or a dynamically allocated memory.
If continue to pass v->s to the inner function, it is not a feasible
method. Or we can use strbuf_attach() + strlen(), I'm not sure
this is a good method.

2. See:

-       for (i =3D 0; i < used_atom_cnt; i++) {
+       for (i =3D 0; i < used_atom_cnt; i++) {
                struct atom_value *v =3D &ref->value[i];
-               if (v->s =3D=3D NULL && used_atom[i].source =3D=3D SOURCE_N=
ONE)
+               if (v->s.len =3D=3D 0 && used_atom[i].source =3D=3D SOURCE_=
NONE)
                        return strbuf_addf_ret(err, -1, _("missing
object %s for %s"),

oid_to_hex(&ref->objectname), ref->refname);
        }

In the case of using strbuf, I don=E2=80=99t know how to distinguish betwee=
n an empty
strbuf and NULL. It can be easily distinguished by using c-style "const cha=
r*".

> >
> > Not python safe. See [1].
> > Regarding the perl language, I support Junio's point of view: it can be
> > re-supported in the future.
>
> Ah, I'd missed that. Anyway, if it's easy it seems you discovered that
> Perl deals with it correctly, so we could just have it support this.
>

Well, it's ok, support for perl will be put in a separate commit.

> >>
> >> > +test_expect_success 'basic atom: refs/tags/testtag *raw' '
> >> > +     git cat-file commit refs/tags/testtag^{} >expected &&
> >> > +     git for-each-ref --format=3D"%(*raw)" refs/tags/testtag >actua=
l &&
> >> > +     sanitize_pgp <expected >expected.clean &&
> >> > +     sanitize_pgp <actual >actual.clean &&
> >> > +     echo "" >>expected.clean &&
> >>
> >> Just "echo" will do, ditto for the rest. Also odd to go back and forth
> >> between populating expected.clean & actual.clean.
> >>
> >
> > Are you saying that sanitize_pgp is not needed?
>
> No that instead of:
>
>     echo "" >x
>
> You can do:
>
>     echo >x
>
> And also that going back and forth between populating different files is
> confusing, i.e. this:
>
>
>     echo a >x
>     echo c >y
>     echo b >>x
>
> is better as:
>
>     echo a >x
>     echo b >>x
>     echo c >y
>
>

Thanks, I get what you meant now.

> >>
> >> > +test_expect_success 'set up refs pointing to binary blob' '
> >> > +     printf "a\0b\0c" >blob1 &&
> >> > +     printf "a\0c\0b" >blob2 &&
> >> > +     printf "\0a\0b\0c" >blob3 &&
> >> > +     printf "abc" >blob4 &&
> >> > +     printf "\0 \0 \0 " >blob5 &&
> >> > +     printf "\0 \0a\0 " >blob6 &&
> >> > +     printf "  " >blob7 &&
> >> > +     >blob8 &&
> >> > +     git hash-object blob1 -w | xargs git update-ref refs/myblobs/b=
lob1 &&
> >> > +     git hash-object blob2 -w | xargs git update-ref refs/myblobs/b=
lob2 &&
> >> > +     git hash-object blob3 -w | xargs git update-ref refs/myblobs/b=
lob3 &&
> >> > +     git hash-object blob4 -w | xargs git update-ref refs/myblobs/b=
lob4 &&
> >> > +     git hash-object blob5 -w | xargs git update-ref refs/myblobs/b=
lob5 &&
> >> > +     git hash-object blob6 -w | xargs git update-ref refs/myblobs/b=
lob6 &&
> >> > +     git hash-object blob7 -w | xargs git update-ref refs/myblobs/b=
lob7 &&
> >> > +     git hash-object blob8 -w | xargs git update-ref refs/myblobs/b=
lob8
> >>
> >> Hrm, xargs just to avoid:
> >>
> >>     git update-ref ... $(git hash-object) ?
> >>
> >
> > I didn=E2=80=99t think about it, just for convenience.
>
> *nod*, Junio had a good suggestion.
>

ok.

Thanks.
--
ZheNing Hu

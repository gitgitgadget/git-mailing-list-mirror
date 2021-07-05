Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7B3C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 16:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66536108B
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 16:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhGEQMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 12:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhGEQMg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 12:12:36 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3EAC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 09:09:59 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id j8so10409320vsd.0
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3BSqu4UsKoDVSzszT5giikbdJ6D0ZOvfk+0WcwIlPRE=;
        b=XNGiABvw00ZrFHpp4IbqQsDaPyBE+eBN8N80OUMfvvoqqUxopWxzdY/jypZeH00p6/
         w7CM8S+90dghY1/bt5OZ0Rp9ianYUaPuPOPHAILbfX/fyffdBva3eJRx9+oo8ZP6z5U1
         kLUMyOsu/4j06nw6T5JF8ZJ4buYjhMZUyoCbE4xGs9QmmfQyvDc1oY/zkS+FRzwj2z+b
         qA6GbXkyFGC0svpVDIssEdXiSSdytGEWaLWbifugxeSu401+VWJ6iiwK2bxPN/J+XzAb
         vY0fTxp204PoEt4MrFZa4WNH04RTLhaaWQ6zLEVFJKmblVFxjIYatiyQ7GRfPwlMEHFc
         muIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3BSqu4UsKoDVSzszT5giikbdJ6D0ZOvfk+0WcwIlPRE=;
        b=d9TIvTI3WrYd5UvaLWQz/Anwq2c6CDmVv2LPCAXBCROFN/QnmKiK+JcbVsusBdabqO
         769eKpyEi/3zSCDGNxXb4XGyxdpNyv05aN/bHX1s9u99LqCiEnAFEPapat3kMVdfjlBc
         i+WH4RJ6kQNL5hbq9eQkiV51p5pub+VJLED7vZ/QMC4b7Rgw56MpR0rvbYv+YizE0elt
         riZj7mb5Q3Kl0e5kOYHt7qXlRBBX41eU4BaopOozOCIlJy8MZjnWrkQIMar7Vviks4Rj
         iS5+rOasNnicaNBBdS/jo1PNGwFgZBhS71evIp1RPXca0mr0SHkAGHBVR64lIyTiQxvd
         JRzQ==
X-Gm-Message-State: AOAM532no13ZoOOhPRtWyT7e16XIaXafZrsIex4OAW8GAJI+FGYKhSlm
        mWpdWRAaHmJ+jpJr4Bb8o0Zq2RXNPQR42Zq6sBV1UA==
X-Google-Smtp-Source: ABdhPJyRdfwSrEMSYRpkG5ln6OPFIbVASp5kjSmVlhOh9mD0Fono3bf4EFojF5YmqW4QTk1uzd7gzCfLgmcXG6OU4Os=
X-Received: by 2002:a67:e884:: with SMTP id x4mr9830617vsn.28.1625501398696;
 Mon, 05 Jul 2021 09:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
 <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com> <2a9ebe43deac3da9baf241ff1e494f8210c27981.1623329869.git.gitgitgadget@gmail.com>
 <8735sydvzs.fsf@evledraar.gmail.com>
In-Reply-To: <8735sydvzs.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 5 Jul 2021 18:09:47 +0200
Message-ID: <CAFQ2z_OeO8ALHPv6JzL2UDWqEb6Um8e8nPYMWBH8mmaMvibMhQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] refs: explicitly propagate errno from refs_read_raw_ref
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 1, 2021 at 3:06 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> > -     const char *result =3D refs_resolve_ref_unsafe_implicit_errno(
> > -             refs, refname, resolve_flags, oid, flags);
> > -     *failure_errno =3D errno;
> > -     return result;
> > +     int ignore;
> > +     return refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_=
flags,
> > +                                               oid, flags, &ignore);
> >  }
>
> Okey, so here we have something like the "caller should explicitly
> ignore it" I suggested in <878s2qdy8y.fsf@evledraar.gmail.com>. We no
> longer set "errno" at all for the benefit of the callers of that
> function, but instead explicitly throw it away, our
> refs_resolve_ref_unsafe_with_errno() no longer sets errno.
>
> But this end-state seems to have resulted in introducing new bugs. A
> bunch of functions are thin wrappers for
> refs_resolve_ref_unsafe(). Previously they could inspect errno on a -1
> return, now they can't.
>
> I didn't look at them all, but just the second one I looked at,
> refs_read_ref_full() has a verify_lock() caller which calls it, and that

It looks like you were lucky. I looked at the output of

egrep -A7 -B7 --color -nH -e
'(refs_resolve_refdup|resolve_refdup|refs_read_ref_full|read_ref_full|read_=
ref|refs_ref_exists|ref_exists|resolve_gitlink_ref|index_path)\('
*.[ch] */*.[ch]

and the case you pointed out is the only one which inspects errno
after calling resolve_ref_unsafe (transitively through the grepped
functions.)

> function then expects a meaningful errno that it in turn ferries up with
> "can't verify ref". It in turn is called by lock_ref_oid_basic(), it
> ferries up that strbuf with the error, which'll now have a meaningless
> strerror(0) in it.
>
> So it seems to me that the refactoring being done here is halfway done,
> [..]
> of what you're starting here. I.e. we have a low-level function that may
> encounter an errno, and then callers removed from that via:
>
>     index_path() -> resolve_gitlink_ref() -> refs_resolve_ref_unsafe()
>..
> Where the common case for index_path() is to report the error we got,
> but it doesn't call die_errno() or error_errno() now, but really should,

"but really should": Why?

Why should all functions that resolve a ref print out system level
errors? For example, that would entail large changes to sequencer.c
which does "error" =3D=3D "does not exist".

Also, the errors you print out will be fundamentally limited. An error
in resolving HEAD could be caused by a problem in any of the following
files

   .git/HEAD
   .git/packed-refs
   .git/refs/
   .git/refs/heads/
   .git/refs/heads/main

Since we have no way of reporting the filename involved, what is a
user going to do with the error message ("file doesn't exist")? I
think refs_verify_refname_available() provides a more realistic
approach: create custom error messages for situations that a user is
more likely to encounter.

Also, for something like the reftable backend, there are error classes
that have no direct errno counterpart. For example, if reftable finds
corrupt zlib data, should it invent a bogus errno code so it can work
with the errno reporting system?

I'll take from this review that I should elide the part where errno is
cleared, and leave it to someone else to figure out a more holistic
strategy to error reporting.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

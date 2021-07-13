Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F46C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C51061249
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhGMIDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhGMIDY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:03:24 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FF2C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:00:34 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id az15so879441vkb.9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x5RaCjn3+CsJvCgBBZM8xgmajlDGH3fB0EtUHoCxn1g=;
        b=ELxvv4ckhob04xL15SrgqoIgXVw96aPoalZeh9OjNG6meNO3boeuUarWC15i5ATkF/
         PPqUZy4C+vvqmrThBIlf78WJp2I8ohacAG8B1dVRIgNq/Q66PEfqbsjjw/HOpJYSnRsR
         fOZkjkGNpQ7EQoC5ErHoOX4//JcDANm+3BNjSSKtTYqcbUuXKVBLObWg55LfPd3Hk2mZ
         jCbnhlYFUk/XsOShyg0qLKZN4hGD9F+CpUFkNi+j6dKvUmZQcNE24NyaPc4IpTqrd3B+
         O1kuT9r2oHMeOyzVHZGu4QcsyzrE6f9OAKRe0iJVVpq14UmAn003o8j3ICu9dXGqncC5
         nHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x5RaCjn3+CsJvCgBBZM8xgmajlDGH3fB0EtUHoCxn1g=;
        b=AzIkj69UYQzhS47dTARjTEcFt2FF7Ko/45kHdUK0KrgVn8VC8FH/9pPMnAwkA6WYDc
         +t+WiSP6kO408zJZq1R5UpFvVuF93e58hiC2cPnqvk2/f7AAqu4w9y0vMjvudkGkSp8e
         acwAcFOjfZQtB03rEm29ctmIhWpN2kcot4saJlQZJKKgRGWQOYx3UUExWbDJslLDvCqj
         a8W8zslP+AQy44xdnCype/ZsRou6ZuvbXMprYuGLxrGShp3xMMzWKa6YZyeuIg417SQs
         uaAQjuvI1ijUDxU0AS7McgN+wcq6BkgBOYyh88BqKCDz8Tros+gBXldjVWK6+va6ulhb
         2JAw==
X-Gm-Message-State: AOAM531tLeKbAEe2sdMKu9+z71mb6fGe96Gz3j9by9FonTRAJHpDfQjb
        GcViQA6npKyz7dAx/mZuPnJlfZUWAzd1y7Z13KlZMw==
X-Google-Smtp-Source: ABdhPJyKHWZu28AsvRkrgpmZjtpoq0+pQDRsFh9VejFxevvLlsEep5vsy8PVIFEs8Bqc7SXhww2jDlS2jwRc6wo/hD8=
X-Received: by 2002:a1f:9d13:: with SMTP id g19mr3738767vke.15.1626163231171;
 Tue, 13 Jul 2021 01:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com>
 <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <95025080c16f535599826ed4f013845d712b0e8d.1625684869.git.gitgitgadget@gmail.com>
 <87lf6d3wbz.fsf@evledraar.gmail.com>
In-Reply-To: <87lf6d3wbz.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 13 Jul 2021 10:00:19 +0200
Message-ID: <CAFQ2z_OftKcmR3ZgogAjiSGEBNmB7Akb01HLy9Abc0xSR5oSHQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] refs/files-backend: stop setting errno from lock_ref_oid_basic
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 11, 2021 at 1:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Jul 07 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>
> >  /*
> >   * Locks a ref returning the lock on success and NULL on failure.
> > - * On failure errno is set to something meaningful.
> >   */
> >  static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *ref=
s,
> >                                          const char *refname,
> > @@ -922,7 +921,6 @@ static struct ref_lock *lock_ref_oid_basic(struct f=
iles_ref_store *refs,
> >  {
> >       struct strbuf ref_file =3D STRBUF_INIT;
> >       struct ref_lock *lock;
> > -     int last_errno =3D 0;
> >       int mustexist =3D (old_oid && !is_null_oid(old_oid));
> >       int resolve_flags =3D RESOLVE_REF_NO_RECURSE;
> >       int resolved;
> > @@ -949,7 +947,6 @@ static struct ref_lock *lock_ref_oid_basic(struct f=
iles_ref_store *refs,
> >                * to remain.
> >                */
> >               if (remove_empty_directories(&ref_file)) {
> > -                     last_errno =3D errno;
> >                       if (!refs_verify_refname_available(
> >                                           &refs->base,
> >                                           refname, extras, skip, err))
> > @@ -962,10 +959,13 @@ static struct ref_lock *lock_ref_oid_basic(struct=
 files_ref_store *refs,
> >                                                    &lock->old_oid, type=
);
> >       }
> >       if (!resolved) {
> > -             last_errno =3D errno;
> > +             int last_errno =3D errno;
> >               if (last_errno !=3D ENOTDIR ||
> > -                 !refs_verify_refname_available(&refs->base, refname,
> > -                                                extras, skip, err))
> > +                 /* in case of D/F conflict, try to generate a better =
error
> > +                  * message. If that fails, fall back to strerror(ENOT=
DIR).
> > +                  */
> > +                 !refs_verify_refname_available(&refs->base, refname, =
extras,
> > +                                                skip, err))
> >                       strbuf_addf(err, "unable to resolve reference '%s=
': %s",
> >                                   refname, strerror(last_errno));
>
> I don't think it's some dealbreaker and we can move on, but just FWIW I
> think what I mentioned ending in your
> https://lore.kernel.org/git/CAFQ2z_NpyJQLuM70MhJ8K1h2v3QXFuAZRjN=3DSvSsjn=
ukNRJ8pw@mail.gmail.com/
> is still outstanding.
>
> I.e. you added the comment, which is just says what the error emitting
> looks like, that's all well & good.
>
> But what I was pointing out that it didn't make sense to do any
> "last_errno" here at all anymore. You pointed to 5b2d8d6f218
> (lock_ref_sha1_basic(): improve diagnostics for ref D/F conflicts,
> 2015-05-11), we started setting "last_errno" there, but that was *not*
> to avoid clobbering between the !resolved and the
> strbuf_add(strerror(last_errno)) here, but rather to carry the
> "last_errno" forward to the end of this lock_ref_oid_basic(), because
> other things (after this hunk) might reset/clear errno.

I disagree. In your suggested change

> +       if (!resolved &&
> +           (errno !=3D ENOTDIR ||
> +            /* in case of D/F conflict, try to generate a better error
> +             * message. If that fails, fall back to strerror(ENOTDIR).
> +             */
> +            !refs_verify_refname_available(&refs->base, refname, extras,
> +                                           skip, err))) {
> +               strbuf_addf(err, "unable to resolve reference '%s': %s",
> +                           refname, strerror(errno));
>                 goto error_return;

the refs_verify_refname_available() call happens only if
errno=3D=3DENOTDIR. The call might clobber the ENOTDIR errno and then
fail. Then we'd be printing the last errno that
refs_verify_refname_available() saw, which may be different from
ENOTDIR.

Other than that, for clarity's sake, it's always better to avoid the
use of global errno if we can.

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado

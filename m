Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AC5C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 02:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjDFC2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 22:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDFC2B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 22:28:01 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF8F40CF
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 19:28:00 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54c061acbc9so34223557b3.11
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 19:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680748080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5rqS4DFX173//XPJ1fjR9vfYz001mMjngvHzsFtvKk=;
        b=JbE/rzWs+nDZTAxIZVidDTslfLoZYbq9eVtaeWVv35une5U27EgWYLZvWjFeeAmzcO
         7qxa4ysD7v6wNfZi1v4e8r2yUFMMLX+M0jN6vVov/0oX6b6MWq/tVvQFvYZ6ORaaTL6T
         fHN65MHgzjwT1Pq1O0dTCZnWI+s4aEjlyXxuFfgu+TZS9n4bKtXmfXusqTwEs9u3fuYl
         Sb2dzKsIf4O9RHHNFCMzpBM5XVhP97dyPaBlbacA0kebfxjFFwVguI6vkhLq6e6URjMX
         J1mW90nioAUYntlUqlRnFyrl2XfqvSMpI0Pvkriw2R0A7R8jj7WsTxRROtub0aCxm476
         ZEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680748080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5rqS4DFX173//XPJ1fjR9vfYz001mMjngvHzsFtvKk=;
        b=4L5e9dF1mx7Xty847YQcQrvA+jUwUWUwlGm+i/2igM6pGQetHC9Yd57iCB2bNNWHIH
         wnd6XURTPVtfVQzlOIUAg+jJx9seYpJG1wand1vxY+cAEyAhInSErVAYiOkjiciKi33L
         RrDKV2vmBaLUDouzrQtlT8PwhKZxb2t6kKZNtGCF6oCgT7MU/GX8Zi5EXz4NeoUxwj4O
         Vbr4Tx9YdLBWDZ08xJSHrGEPaJ1FhJ8rAai1gl9CHDo4cMh1mRnXWmK8Z8nmlOwM9aFI
         06XPW76Lt5QsZ4bompCcTpbTO5gTCx25nWaeM3f/+5Nkjr8qgpt6l+lofLMLmxn2MIbk
         IzdA==
X-Gm-Message-State: AAQBX9cnmGfYtabgJ/oGjfSmmTj/zQMDveXk+iV9K3kTStm+u+60Zslq
        h349k7mMd46aHy6pgxnAT9CRLIl4TJ6GfxWqYHtlnGwn
X-Google-Smtp-Source: AKy350aPfX0ke8MinfZNqQ2qvKmZEvIZ4AZbdP5YSCucv/K0Ivqrvn6LDV0U4o7rSLwQb0xfkM0cNba4QhTrlYxQZlQ=
X-Received: by 2002:a81:e545:0:b0:545:8202:bbcf with SMTP id
 c5-20020a81e545000000b005458202bbcfmr4799812ywm.9.1680748079889; Wed, 05 Apr
 2023 19:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com> <ZC2LOAwycdaUawxM@ncase> <ZC2ZyTTZFbd_gNtw@pobox.com>
 <ZC2xcDwuhiEn2giX@xps> <xmqqv8iaw4n5.fsf@gitster.g>
In-Reply-To: <xmqqv8iaw4n5.fsf@gitster.g>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 5 Apr 2023 21:27:48 -0500
Message-ID: <CAMP44s2VuvP_mhLSXXyC1__GGYhfQM4Td-bghOE3AmqfQW0Czw@mail.gmail.com>
Subject: Re: [PATCH] global: resolve Perl executable via PATH
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 2:29=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> >> I don't know what the right choice is for upstream Git, it
> >> can easily be argued in either direction. :)
> >
> > I agree, there is no clearly-superior choice -- both have their merits.
> > I'll probably send a v2 that only munges internal scripts that are used
> > as part of our build and testing infrastructure. That's the area I care
> > most about in this context anyway.
>
> My preference is
>
>  (1) not to touch scripts that are processed by Makefile to use
>      $PERL_PATH,
>
>  (2) fix callers of "./foo.pl" to invoke "$PERL_PATH ./foo.pl" where
>      the perl () { command "$PERL_PATH" "$@" } wrapper is not
>      avialable, and
>
>  (3) fix them to use "perl foo.pl" where the wrapper is visible.

That is orthogonal to the patch.

All those steps can be done *eventually* while the proposed patch is
applied *today*.

> That way, we can wean ourselves away from the assumption that perl
> interpreter should exist at /usr/bin/perl without introducing a new
> assumption that everybody's env should exist at /usr/bin/env.

The patch doesn't introduce such an assumption.

Changing the shebang only affects scripts that are 1) not processed by
the Makefile, and 2) not called as "${PERL_PATH-perl} foo.pl".

If your system does not have /usr/bin/env and everything you cared
about worked yesterday, it would still work with the patch applied
today.

Having a `#!/usr/bin/env perl` shebang is simply a good practice to
write in all scripts.

But that is just the *default*, nobody is being forced to actually use
that shebang because 1) the Makefile is still going to override that
and replace it with $PERL_PATH in generated scripts, and 2) the
scripts that do "$PERL_PATH ./foo.pl" are essentially overriding it
to, and so does 3).

I believe this is a red herring (which might be desirable to fix some day).

Cheers.

--=20
Felipe Contreras

Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD1C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C82720777
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOO6XAkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCTPXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:23:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39817 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgCTPXL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 11:23:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id a2so6828625ljk.6
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nmps89H8Xm4/14Xs0tbxRscxK2woypE9rZiXB2MfJrk=;
        b=UOO6XAktvZb6l7+FmdUbsoQlks16IrInMeIBChN51bz3A1lj6jyCqhCx6h3B+b9P5w
         iXEU2uRH9cb9VdPRUt9pp37fByKKii3/3Ce8K15SVSn6ROZKAOkdfzsqxHo62QDwdPH5
         Ib15+utaIoFUdRyLaBlhJWbpwnwttxSKsqM3Ymnk4LBs498SV/th1rhaQ2fTzhG2Uo0p
         Z3D73tfacJVPy7SkJ5YA7CRvjhKvOyO+mw1moIwnpu9Z3h8U7pUUB5yE+Cg002rZPcOU
         LbeO0eynNmiQDkuqzoeBjeRONuhaRBkJ5aRckUy7giWiwcKbuJS6LkqrueopI+2INA+n
         Nqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nmps89H8Xm4/14Xs0tbxRscxK2woypE9rZiXB2MfJrk=;
        b=BSX5JjDo/4o9oU1aMmmPkFOYG9rgFPPYpSeFzIqUw3sddlOH0Jgqpz5fFVsb9RczB7
         kFqvPkl+V2aZjkVLiFn8YR/Fiz8Or3htPc/l3jKZh8KxqRZem8fCyzr0UmomexpPpZ6J
         2NyE/OeL2E/H5OsKY9MMXJwMqJSpzrNMDWxXtFexH3G5ds5mpSanMNkJxz2+DziEQzhU
         AAe5+4OWUFZablqKzppPhI5gmlnEkIUklMdnZD7kAEB3CWpxP8OMqGfvCzk9Rrq2HT1U
         PaLUcQ5L81yLcDft6aySXlWJ+5XtEiE6fUTPBGh8QhEh/L03wBLVH/UoA/hByax0kkV+
         x5eg==
X-Gm-Message-State: ANhLgQ008o7CmRo7zkd6rs6ZVG3lFEHHE+mSlhQ+wUtuNYWjZ6WiqLpa
        DasHqom2+zE1H2rJxQQ5eUuMfBYBbSmwEdGXGzPgD6gZYyY6Sw==
X-Google-Smtp-Source: ADFU+vtp5D0RafvDKr2VlZZndtBz7BrJTrCTU6kIMDJSdyXZ5omg9/Xt3zNxOXJWFeYWiTTlZ477brPIC8zEBfYAedc=
X-Received: by 2002:a2e:a312:: with SMTP id l18mr5770414lje.229.1584717788319;
 Fri, 20 Mar 2020 08:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200319234723.6504-1-adrianwijaya100@gmail.com>
 <20200319234723.6504-2-adrianwijaya100@gmail.com> <20200320055225.GG499858@coredump.intra.peff.net>
In-Reply-To: <20200320055225.GG499858@coredump.intra.peff.net>
From:   adrian wijaya <adrianwijaya100@gmail.com>
Date:   Fri, 20 Mar 2020 22:22:56 +0700
Message-ID: <CA+0Uiy-EkT1BHSgL4R783Qh=c4-W_FZwB=LwnQG7OLx92YN=ww@mail.gmail.com>
Subject: Re: [GSOC][PATCH 2/2] t1300: replace "test -f" into "test_path_is_file"
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 20, 2020 at 12:52 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Mar 20, 2020 at 06:47:23AM +0700, Adrian Wijaya wrote:
>
> > [...]
>
> Thanks, and welcome to the Git community. The patch looks pretty good to
> me. A few minor nits:
>
> > Subject: Re: [GSOC][PATCH 2/2] t1300: replace "test -f" into "test_path_is_file"
>
> The subject says 2/2, but I think there is only one patch. :) Looks like
> you used send-email; the --cover-letter option is probably what you
> wanted to generate the first message. Though for a single-patch series,

Thanks for letting me know. Hmm, looks like I didn't get to see that part
when I looked at the documentation.

> I'd generally suggest just sending one email total, and putting any
> comments below the "---" line (which would then not be included in the
> commit message).

Got it.

>
> The general form of the subject line looks good, and follows our
> conventions.
>
> I'd suggest s/into/with/ in the subject line as a minor English fixup.
> We'd often assume the maintainer will just fix up something small like
> that while applying (or if he doesn't, that it's not too big a deal).
> But since the point of the microproject is to get comfortable with the
> patch submission process, maybe it would be good practice for you to fix
> it up yourself (using "commit --amend" or "rebase -i") and re-send (try
> git-send-email's "-v" option).
>
> > Replace "test -f" into "test_path_is_file" to give more verbose
> > test output.
>
> Same s/into/with/ here, too (or perhaps s/Replace/Convert/).
>

Sounds good. I will make a second version of this patch.

>
> Maybe worth saying "to give more verbose test output on failure", though
> now I am really nit-picking (sorry, you avoided so many of the usual
> first-time-patch pitfalls I have to stretch :) ).
>

No worries. Actually, I can learn something that will be useful for my next
contribution.

>
> > Signed-off-by: Adrian Wijaya <adrianwijaya100@gmail.com>
> > ---
>
> You remembered your signoff. Good.
>
> > diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> > index 97ebfe1f9d..d74554fc09 100755
> > --- a/t/t1300-config.sh
> > +++ b/t/t1300-config.sh
> > @@ -1020,11 +1020,11 @@ test_expect_success SYMLINKS 'symlinked configuration' '
> >       ln -s notyet myconfig &&
> >       git config --file=myconfig test.frotz nitfol &&
> >       test -h myconfig &&
> > -     test -f notyet &&
> > +     test_path_is_file notyet &&
>
> And the patch itself looks obviously correct.

Thanks :)

>
> The "test -h" in the context sticks out now, but we don't have a
> test_path_is_symlink(). I think adding it goes beyond the scope of this
> patch, and beyond what's needed for a microproject. But if you or
> anybody wants to add it (modeled after test_path_is_file), it seems like
> a reasonable thing for us to have.
>
> -Peff


Never thought of that. I think I will make a feature request about it when
I have enough time.

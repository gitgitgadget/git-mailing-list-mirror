Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090CDC433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 05:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74A264E61
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 05:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhCOFLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 01:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhCOFLT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 01:11:19 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BCAC061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 22:11:18 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id c13-20020a4ab18d0000b02901b5b67cff5eso3019167ooo.2
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 22:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IAWcxd5rSEo6KAGhqEst9WWfHSt7JF5JAIi5mef9NVY=;
        b=euMG4QUvaGEzAZEAbT8DhFfJstkzHPayfMJGBrYgW8fk0vE1rNRdlUlgOqQn1pErZK
         89FYvxKOlMK9IOKZ49CKVfugTrZUiRXpkRIQfC8V3fS/kDoD3Orz4iDkR/iBDYB6QN8S
         4jbEPcsGpAGeXpq/vBQRyqTyXCXKc9404muuEupY4byiep/Ovhy5xJmp9Kw1ZLo/v5RC
         xqdvxcrfXVV/Z6iBrPrWiau5uLoYze6PV61F9LKaGMUfey+FxbnLPr0Nl/GiZCIZCbkD
         EyQ8rnbvAoQkYKvsYvKTNxsa4dhAxf3etnlxCsSjND8aLabXOoqSqBjSzhSupL/Mzj7b
         Z7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IAWcxd5rSEo6KAGhqEst9WWfHSt7JF5JAIi5mef9NVY=;
        b=ufLfEG5lkaDAGyBJ0supp1x/rxIQnZIjHQqjqMqlmtDW8QitTcWU5B0GQJTUP9n+0u
         qi4OQB9C3NfP6evoBcRSOHMLgKRMFbLEBwFGvt7MJb+1u6MuhIHVt/15wMw/Zl4rz4TM
         r753NpPA8wDiYpDk4Hp/JoE3Y770cqi1NLEQfcD12CWfylW/Xt9NkYdkCfWvK+9y0hSF
         8+nhNzKW7pYGTttF+tsORymXPmfclXh7+esBIPllOShAeFw6CZTNuzoULBMKdqfdeFnq
         2bwJQEfa+spTjNsvGLc37LtGgpCpHAIYwMA0Z5RC8wKiaA4nQrAVXoJEdYN7HzDLstgu
         18+Q==
X-Gm-Message-State: AOAM5332mGFI1bJOlVy12K3Q86/57PS22BuZeWst+es0ED6Jf0DxPVWI
        v8z+8UB8//d4wYbcNrpAP6o7k493pnTpNwZOfp2nTlV4w7p1uVIs
X-Google-Smtp-Source: ABdhPJxVGERKG5g81RKNba923qhEWSZvBGUXAGzxyz/pXTDkEbe4L+ytyHlGY3TsGrExzlbzbu0HuCTJwtxCDjGtTcA=
X-Received: by 2002:a4a:bd97:: with SMTP id k23mr12061198oop.13.1615785078251;
 Sun, 14 Mar 2021 22:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v3.git.1615726978059.gitgitgadget@gmail.com>
 <pull.901.v4.git.1615737505834.gitgitgadget@gmail.com> <xmqqczw12fqg.fsf@gitster.g>
In-Reply-To: <xmqqczw12fqg.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 15 Mar 2021 13:11:07 +0800
Message-ID: <CAOLTT8T9X8d-cY1sCmiFAKRo5t4pbxoLjjt8+Nm1htaKV6D6DA@mail.gmail.com>
Subject: Re: [PATCH v4] [GSOC] commit: add --trailer option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8812:38=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> One thing I forgot to mention.
>
> > +static int opt_pass_trailer(const struct option *opt, const char *arg,=
 int unset)
> > +{
> > +     if (unset) {
> > +             strvec_clear(&run_trailer.args);
> > +             return -1;
>
> What input is this part of the code designed to handle, and what
> outcome does it want to show to the user?
>
> Does the test added in this patch cover this codepath, where unset
> is true?
>
> I think this codepath is reached when the command line says
> "--no-trailer", and I am guessing that by clearing the code wants to
> say "ignore the accumulated trailers and start accumulating afresh",
> i.e.
>
>     git commit --trailer=3D'T1: V1' --trailer=3D'T2: V2' \
>                 --no-trailer \
>                 --trailer=3D'T3: V3'
>
> would want to add only the "T3: V3" trailer; which is a sensible
> design, but I do not think returning -1 would be compatible with
> that design.
>
> If on the other hand the code wants to say "--no-trailer is a
> command line error", then using PARSE_OPT_NONEG to let the
> parse-options API issue an error message and die would be more
> appropriate.  That is an often used pattern for an option that can
> appear on the command line only once without accumulating, which may
> be less appropriate for the "--trailer", though.
>

As you said, what I want to express is "--no-trailer is acommand line error=
".
`--no-trailer` may don't have any big benefits for users.
I will follow you suggections.
> > +     }
> > +     strvec_pushl(&run_trailer.args, "--trailer", arg, NULL);
> > +     return 0;
> > +}
>

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1392AC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C5961074
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhETALN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 20:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETALN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 20:11:13 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D73C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:09:51 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id v13-20020a4ac00d0000b029020b43b918eeso3400333oop.9
        for <git@vger.kernel.org>; Wed, 19 May 2021 17:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D11VcPKg4432XB1YFQdA4xb/+HbqjRkHlqUdzCOCbEY=;
        b=N0kxWQEUHu+0zqB8mECS1UOpUctaFwAGNf5SgWFi93Ev4pa2KizCHmNC79ir6n4wqw
         6lo6HFpW9vJOmQeHJ0wu8wn/EVVlnWRnFMadX5mXcnN3OqSPZmvK4ZqR5GxIwxm8GvZu
         gHEXj1mANIPNALXpfjjBbRTWwRUGZQmue9o/tz8TSTEdGoQWva5B6GQCZ7ihVa/rvFn+
         NYlN/Zn3aJg7t5TpM1CjwkQZYq8kQG1sI1f15vdQe1vJAyJ0+kU9tdPiMzEqDlvSYUet
         SZ2H46E98zw+6sz4sWqZO05m91oA8KRM/vPPR7W8EUuKxjh5qQjFTPto4rJYRvBEj95D
         Vn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D11VcPKg4432XB1YFQdA4xb/+HbqjRkHlqUdzCOCbEY=;
        b=GTAxg5yTtCDqYeUd2QcbtC32GGPKnPXL9qUueg7Kcq3T5qfd4B5QeCdoccfcbB2bUN
         uQSX5hr6QLsd0altR2PRDsuWDJLoVExarstq5RV2v5ej8b/dcIts9cxr4QBaZlQaU1Zf
         datpG45SZUaX/EcIJSfoYrIR4ATUedZtNpgDhJj5pzDaJ8yo+EPzDxcNSuPxojklKT24
         4f+lba3rTpF4ydt31cwogdE+DFlnce9GhQw1zQBr9LXj0ew05NsL+3Ra2LGh8p/2JOLs
         xLL8MuJCOlRShN9dbvhNz4iBTlH59KEnEF1j/N/mKccUj1YWwg1q62fTNxBwaJYF184t
         ZQ7Q==
X-Gm-Message-State: AOAM530j/UVShJ5bFhclq9S7Ltn2THwtPpJruU/PgOWFHcwnCtY82Foj
        xw7PKVPc9xrIoXcheBt/RAPNE+mN6W5CjCWJIYo=
X-Google-Smtp-Source: ABdhPJwmokG6czpVoY9b1Eo8kxnvCxFxDsNh8V4hf9Qe7FrSac0IVDcKuzGaGjycnd2EOqi2kGejDQtlqHxcoMd6Rmc=
X-Received: by 2002:a4a:b301:: with SMTP id m1mr16957ooo.7.1621469391069; Wed,
 19 May 2021 17:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <f1fc174b10ca5bc8b54ede513bc79e3864d8e014.camel@scientia.net>
 <xmqq4kf7cmaj.fsf@gitster.g> <xmqqzgwzb7ad.fsf@gitster.g> <CABPp-BGERNLKbLA_r7i7+r+v7YK6xT00_5n9ebESb2SzLhC0Cg@mail.gmail.com>
 <xmqqv97nb51b.fsf@gitster.g> <681aefe15af98f6758f28544b96bc2eca90642f3.camel@scientia.net>
 <xmqqr1i2wbef.fsf@gitster.g>
In-Reply-To: <xmqqr1i2wbef.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 May 2021 17:09:40 -0700
Message-ID: <CABPp-BFY41YrO1cVNxGJG2rSXb=Y0EY3t7Y9x+ENAKmA0=oreA@mail.gmail.com>
Subject: Re: git-sh-prompt: bash: GIT_PS1_COMPRESSSPARSESTATE: unbound variable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christoph Anton Mitterer <calestyo@scientia.net>,
        Git Mailing List <git@vger.kernel.org>, ville.skytta@iki.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 4:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christoph Anton Mitterer <calestyo@scientia.net> writes:
>
> > Hey there.
> >
> > I think I found another case of an unbound variable:
> >
> > Completing e.g.:
> > git commit --[press TAB]
> >
> > gives:
> > $ git commit  --bash: GIT_COMPLETION_SHOW_ALL: unbound variable

That particular case was fixed by Ville Skytt=C3=A4 in commit c5c0548d793e
(completion: audit and guard $GIT_* against unset use, 2021-04-08).

> It seems that OMIT_SPARSESTATE would have the same issue.
>
>         if [ -z "${GIT_PS1_COMPRESSSPARSESTATE}" ] &&
>            [ -z "${GIT_PS1_OMITSPARSESTATE}" ] &&
>
> all coming from afda36db (git-prompt: include sparsity state as
> well, 2020-06-21).
>
> But I think we have already seen the fix in 5c0cbdb1 (git-prompt:
> work under set -u, 2021-05-13), which may or may not appear in the
> upcoming release.

Yeah, I fixed the ones I introduced in git-prompt.sh --
GIT_PS1_COMPRESSSPARSESTATE and GIT_PS1_OMITSPARSESTATE.

> There still are unprotected mentions of GIT_PS1_SHOWUPSTREAM even
> with that fix, though.

Yeah, neither my fix (which was only trying to fix the problems I
introduced in git-prompt.sh) nor Ville's fix (which was focused on
git-completion.bash) caught that one.

Do you want to make a patch for that, Christoph?  If not, #leftoverbits?

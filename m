Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21BAC433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788FC20855
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 14:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp6Blwxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHMOEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgHMOEi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 10:04:38 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757FEC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 07:04:37 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id v21so4838005otj.9
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xb6kSpn5EZwYCBAFRPwLWxSzg8V8v8oSNoMLbo95p/Q=;
        b=Fp6Blwxn7xRdGCVkhT1OEjePX7Q4fefswxr1qr+N+vdyIMF7KmQpY8TOVjE4aZxwXj
         1rUE0OILFAWoT6oFJOcDI/RBGBSoL9hkcl9wpSWxLvgQWZt0Q1kiECFI8cpVavk4OjAX
         OtHkpfGKdbtf5LeRekPRtql1zbRa7ZW6poQscW4tRJcmLwjZz4z14jlr/anQq9qKFpBl
         fxHtJo3BNiuf2I9BaVh5LjgaOmh3YEsAfdvhBmVnUByfAzkDKofNOlw45GNkADO6ls8t
         xNiTGEh8CaDMao01zvnhSF+ytwI6zYjRUQPrCCNbgnSlliPO8GS4XPsrtEKOgaK2ooTO
         SgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xb6kSpn5EZwYCBAFRPwLWxSzg8V8v8oSNoMLbo95p/Q=;
        b=Rs46bqJ3bzDznDL5zOVFD/WUsX3yxKIwaT+cs+znv7lq7A2QZouEIJDK9stciWi2Ye
         2BIBnOHgveSGAujJg0wl+4cL/sXYQMUpcGbKNv8vDtK+iftlfKtEExSqfV8OFCfgAnlk
         zuN1DeRktYqz5V2xoTcgjtIYnShYFTQpU/IxSNoPjBZoWZrU4gKSxaYooqzZ2dEWMyyn
         CLDl6qDyojRWGe8CvjG7AqmzVgTDxJVfPzrNCymQibUTwFL8HkMbyFqKYlxOyJgybGUw
         AxXQNSX3F1/3zSSWtRe1V0TvuJ6ZZl43yCxv3MyNWG0bU8s7mMWIdhn/2hHB3vrUpoon
         Cf+w==
X-Gm-Message-State: AOAM531CLXv6f2YP3SaZ6qMpTAboYoYSUBBZx2u/zfZ8Iv/q0yKktDUx
        iyYg06XbUCQVHbO9HGGEP5LvOgM6s+oBJPCQRiM=
X-Google-Smtp-Source: ABdhPJyukWf0sSj5CPpm8bHCduYKVeuiE+Syjcjc1aI4funbfbpBl9B47pBUGjVMFYwugS9YEClD2wu2Gybj4blhs2E=
X-Received: by 2002:a05:6830:22c8:: with SMTP id q8mr4383880otc.345.1597327476235;
 Thu, 13 Aug 2020 07:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.700.git.1597271429.gitgitgadget@gmail.com>
 <69fe977b66f9744c914cfdfa2da4b9be5e720e4f.1597271429.git.gitgitgadget@gmail.com>
 <CABPp-BENKdxqXjH07yCNojRWQ3XO+_mm8x+LSVLTBx36m6nSSw@mail.gmail.com> <8014D105-0957-4A45-B375-1027E070C74E@gmail.com>
In-Reply-To: <8014D105-0957-4A45-B375-1027E070C74E@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 13 Aug 2020 07:04:25 -0700
Message-ID: <CABPp-BFwX-m=BryaxkSyh-126O_0GQxyqRvFnKeOQ66Feiq4Kw@mail.gmail.com>
Subject: Re: [PATCH 2/2] userdiff: improve Fortran xfuncname regex
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Brandon Casey <drafnel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Thu, Aug 13, 2020 at 5:45 AM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Elijah,
>
> > Le 12 ao=C3=BBt 2020 =C3=A0 22:10, Elijah Newren <newren@gmail.com> a =
=C3=A9crit :
> >
> > On Wed, Aug 12, 2020 at 3:34 PM Philippe Blain via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Philippe Blain <levraiphilippeblain@gmail.com>
> >>
> >> The third part of the Fortran xfuncname regex wants to match the
> >> beginning of a subroutine or function, so it allows for all characters
> >> except `'`, `"` or whitespace before the keyword 'function' or
> >> 'subroutine'. This is meant to match the 'recursive', 'elemental' or
> >> 'pure' keywords, as well as function return types, and to prevent
> >> matches inside strings.
> >>
> >> However, the negated set does not contain the `!` comment character,
> >> so a line with an end-of-line comment containing the keyword 'function=
' or
> >> 'subroutine' followed by another word is mistakenly chosen as a hunk h=
eader.
> >>
> >> Improve the regex by adding `!` to the negated set.
> >>
> >> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> >> ---
> >> t/t4018/fortran-comment-keyword | 1 -
> >> userdiff.c                      | 2 +-
> >> 2 files changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/t/t4018/fortran-comment-keyword b/t/t4018/fortran-comment=
-keyword
> >> index c5dbdb4c61..e9206a5379 100644
> >> --- a/t/t4018/fortran-comment-keyword
> >> +++ b/t/t4018/fortran-comment-keyword
> >> @@ -8,7 +8,6 @@
> >>       real funcB  ! grid function b
> >>
> >>       real ChangeMe
> >> -      integer broken
> >>
> >>       end subroutine RIGHT
> >>
> >
> > This change seems orthogonal to the explanation in the commit message.
> > What is its purpose, and does it belong in this commit or a different
> > one?
>
> If you take a look at t/t4018/README, the way to mark t4018 tests as "kno=
wn failures"
> is to insert "broken" somewhere in the file. Since I'm fixing the regex i=
n this commit to be able
> to cope with the situation in t/t4018/fortran-comment-keyword, I'm unmark=
ing this test as broken.

Ah, gotcha.  I guess that's what I get for trying to review a random
patch outside my area of expertise.  :-)  Thanks for explaining how
this works to me.

Elijah

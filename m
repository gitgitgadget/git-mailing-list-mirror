Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3FDC433DF
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2874921883
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 04:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/0DfE1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgGNEJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 00:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgGNEJy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 00:09:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93689C061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 21:09:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id r22so14414027qke.13
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 21:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/t0NM9F3wo9di221IoO+ttGOiXQUk4EivwJGa3T3u8=;
        b=b/0DfE1gXsFHyhW81U67C2n6K0PkSbIxhbeFgf8ioEbvxkNUrEa2fiTAYTQfaYTTzI
         HDSTcSAOM39nVAu8qLED2mFEhR7BvonBYu/oqZXmpQ1HTVRBhtlMLFjyIg2C5aB6dk7u
         g78vWsma3c2Z3r5BvFoaT2Vih5we2g48tZVyGjgZaF2OiV29yz2QQRvvW8O4umX8Ar2z
         4+Rq1DK/n06opf3hTCQIrekO7MA8g2+xJ8dxDcfX7KB+fIhZEAHJYe5pZRYGvRGA2Ulr
         N9UUjjRKZMQWQI0Qbe3UEissoeDTIp60KnfczP5WgDvk69TvbkCdnCA35e/lHQVYQcIz
         9p8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/t0NM9F3wo9di221IoO+ttGOiXQUk4EivwJGa3T3u8=;
        b=UbXLei92UXVl4A3r/wbiljtWGhmF0LJDdxpporCNu0P+jtUiofKe5n0gVGQyZY8PCE
         dO5HYa4Ac8yxIFQaw0USmfemEzUIiiIsFR7nuiCZUogSuBUD6J3Po08ZUPRVkEdHJ2qQ
         W6cjh3ZR+oHzlnulztJleokfgh3UHB6S0ANHdHqiYod94kSG2177Np0lwqYUtaeSX9ut
         wpqzRICV9dq47htOrrZ4WbMY1UUkb+pBDdnzI19yCSyNgurz9xtvHANQtQqu6xcdZ5O4
         h90NpTi4w3fismw8ANhWMIUrSnfy/lr1eSBWHstBDItalNIE9vq/9C042Zxc53V475iF
         WfTg==
X-Gm-Message-State: AOAM530MVwJqWiZD4YuUy1btIEYTQLnSRq0fTYg4ggbTGTBp3nvB0GxO
        vbmEC3LFNXid7Ejch//1iA8fg2mvDhTYE3lIyaGCeA==
X-Google-Smtp-Source: ABdhPJx0cF5eYEcL9nb73sCZckqUFQxLI2VDbtNqtdj63dvGDI8CefvEv8HYja78+HODqm5pO/uK1LXpNpdQZrl/l2o=
X-Received: by 2002:a37:46c6:: with SMTP id t189mr2714843qka.325.1594699793594;
 Mon, 13 Jul 2020 21:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAGPh-qNrjQ5xwbPcfJdBqrqOJQsVpa2hy-XHwN-8rhPPZe4Vpg@mail.gmail.com>
 <20200713223906.GH8360@camp.crustytoothpaste.net>
In-Reply-To: <20200713223906.GH8360@camp.crustytoothpaste.net>
From:   Jason Xu <jasonx98@gmail.com>
Date:   Tue, 14 Jul 2020 00:09:41 -0400
Message-ID: <CAGPh-qPyTNidqT=K-U8iYtG3udFZVFBhE1RyA1AZ1qEqN_NnZw@mail.gmail.com>
Subject: Re: Force git diff to create a binary patch?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So then it would not be possible to produce a diff that mixed binary
and text diffs?

If `--binary` is for email patches, then it should still be easy to
detect non-email-safe characters (probably anything that isn't a
printable ASCII character).

Also if git's binary detection is really just checking for a NUL byte,
then it could be improved. Example: checking if bytes form any common
encoding, like UTF-8, and if not then marking it as a binary. Or more
advanced `file` like heuristics. I don't know if this is worth the
effort, or if others think the current binary detection is fine (it
likely works fine for actual executables, but not short binary data
like my example).

On Mon, Jul 13, 2020, 6:39 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-07-13 at 04:58:23, Jason Xu wrote:
> > Hello everyone,
> >
> > Here are two small files with non-ASCII data, yet git diff considers
> > them text instead of binary.
> >
> >     echo -n -e '\x01\xff\xdf' > bin1
> >     echo -n -e '\x01\xdf\xff' > bin2
> >     git diff --binary bin1 bin2
> >
> > Result:
> >
> >     diff --git a/bin1 b/bin2
> >     index 802dc8e..c39b638 100644
> >     --- a/bin1
> >     +++ b/bin2
> >     @@ -1 +1 @@
> >     -^A<FF><DF>
> >     \ No newline at end of file
> >     +^A<DF><FF>
> >     \ No newline at end of file
> >
> > I think `--binary` for `git diff` should force the creation of git
> > binary patches if there are any non-printable-ASCII characters, since
> > my understanding is that `--binary` is for safe encoding for email.
> > Otherwise `-a` can be used.
>
> I was the one that asked you to post this here.  While Junio's comment
> explains _why_ this happens, I think that --binary should, well, produce
> a binary patch, regardless of whether the file is text or binary.  After
> all, --text does the opposite.
>
> The description for the --binary option reads as follows:
>
>   In addition to --full-index, output a binary diff that can be applied
>   with git-apply. Implies --patch.
>
> So we need to fix either the documentation or the code.
>
> I looked into what it takes to fix the code to do this; it's fairly
> straightforward, but it does cause some testsuite failures which assume
> the current behavior and will likely involve a small series.  So if
> other folks agree, I'm happy to pick this up in the next couple of weeks
> and add support for it that would hopefully hit Git 2.29.
> --
> brian m. carlson: Houston, Texas, US

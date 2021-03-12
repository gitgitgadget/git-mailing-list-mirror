Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44875C433E6
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88B164F95
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 01:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhCLBdY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 20:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhCLBcv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 20:32:51 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71F3C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 17:32:51 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id f145so7323748ybg.11
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 17:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B0l530xLy1m5i+Dwc0grgvUVZAxKT0EDo0FhirTtbPw=;
        b=Xx+IixreUOtrg64/0ERY8GAz/PRFRtWGPyKRXaLdXaYCvV7NUWgpdHuxCvTmUcqA1F
         9RpagK/xkyrfaU+QxmqCM6a0ROqhS+Ol17FWyjrbNRvuwQNcnYiOlUVN1Tok7jGgHJHG
         L/9x8wajwi6rNFpBRAA5BmeJxJ4PoST8+m2lsKSyTc/t5DeWx0nt2KlgxS3ITWa3LATV
         gCpCjzotQp7WRRQsKglRoj9UvztQtg0tT58d6HTQuaVwyt++TL01nfdAzQkVVGnIpexn
         f/qfDSjFarxL36lpI6SsZUBytT5a2PLhdiPT/l5Kgl6lsAFUFCguTBvz2bZce7cUutLQ
         53Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B0l530xLy1m5i+Dwc0grgvUVZAxKT0EDo0FhirTtbPw=;
        b=NIGV+4YmUUL1si4PY2CQVRsG3xPinnMODCSlxUIR0w40AY0F/gjB4IU6xnwNTjg4tz
         xg5VmIt8IQdPi3eIl5tgYSq6U1ckng8ExowHptBzvq/yZWzFRijDgrnARO90k/2rVIhK
         GgyFQsPJqat2lXbs9fM9EBAiHPAoTwIAUjsHuLdxzCBWR27XdlRnRrEJEbZfEoewrnmK
         x+KZclJpJMqWG4PxqJCmPkQy6GJjvF/OvzvjZqlgs7jL1xvKuPIRo2oTWaEJEGt4luL9
         RZSdMC9KFxLZ76Up5GH08k3p18Qf4grzKmK3ewyGzO6gdqtHQ74zvlEvSfh04sAaQVhA
         2LFg==
X-Gm-Message-State: AOAM533Yt1r/zQs/upWVGG+1zx9TZYBvYYcgqQhrKhy4GV2+saJLrso3
        AcoTJVCtZVzypq49ClA74nuFYRf1jkysXUM8UJJqQNt3
X-Google-Smtp-Source: ABdhPJw9M0+qqEfFJlIi0ZoxRClma9fZI5Eb/Xg5YDRKzdUWpiHBa3F9WPrIwvdeell+gldeXEe8HG5X+BcdzGnHz6g=
X-Received: by 2002:a25:874c:: with SMTP id e12mr14747690ybn.403.1615512770907;
 Thu, 11 Mar 2021 17:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20210311125511.51152-1-bagasdotme@gmail.com> <20210311125511.51152-2-bagasdotme@gmail.com>
In-Reply-To: <20210311125511.51152-2-bagasdotme@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 12 Mar 2021 09:32:39 +0800
Message-ID: <CANYiYbH_U=3gN+LH7e-LBdRdcE0geAuUzoBX4O09qego0xKX-Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] po/README: document PO helper
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=888:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Document about PO helper script (po-helper.sh). It covers about
> installing the script and short usage examples.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  po/README | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/po/README b/po/README
> index efd5baaf1d..9beffc2954 100644
> --- a/po/README
> +++ b/po/README
> @@ -286,3 +286,25 @@ Testing marked strings
>
>  Git's tests are run under LANG=3DC LC_ALL=3DC. So the tests do not need =
be
>  changed to account for translations as they're added.
> +
> +
> +PO Helper
> +---------
> +
> +To make maintaining XX.po file easier, the l10n coordinator created
> +po-helper.sh script. It is wrapper to gettext suite, specifically

It's better to rename the script to other name without the suffix
".sh", so we can reimplement it in other programming language. Maybe
we can rename it to `git-po-helper`, and host this helper in a
separate project on GitHub.


> +written for the purpose of Git l10n workflow.
> +
> +To install the script, checkout "po-helper" branch, then copy
> +utils/po-helper.sh to somewhere on $PATH, and mark it executable.
> +
> +Below are the usage examples:
> +
> +  - To start new language translation:
> +        po-helper.sh init XX.po
> +  - To update PO file:
> +        po-helper.sh update XX.po
> +  - To syntax check:
> +        po-helper.sh check XX.po
> +
> +Run po-helper.sh without arguments for usage help.
> --
> 2.25.1
>

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B3CC433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 07:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9CF60C4A
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 07:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJ1HRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 03:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1HRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 03:17:42 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B091C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 00:15:16 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id e5so9674388uam.11
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 00:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opyDRYJP5emjT35t9UWzyTsP3Q7+OcTXoB+Bti9hgJU=;
        b=IhgMtbO5YyW0JUuBp6i/67xT63NzJ9FOHL/piK8xiO+CvFhwshyJ6vKqvX9U/HMy/D
         1yUiQN9Gg8/4hqMk1EaU/nj906GwA+SUemU8SrZvcFIAkj8QNNNEambIaEiUgWv7Jdq2
         dKeDI8taMZJ5FqjRhpYFQ62B9RWyYBIkXeoT+gmpG2Tevn5sYAT51lpVRR+iM05rVg1/
         MrQLwBEvSiG+i3ybUYdXWU+3cV/NgrehXl8HBhUY6SpdNOx+x1PyNx/fLJ3mtjyqbhfK
         R158vCRNG1Yuf8f71MpWz/92iAzqL0y8WgL4+SK4rCW1hTnooLzoqVBZbL6vv4So3p5K
         F74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opyDRYJP5emjT35t9UWzyTsP3Q7+OcTXoB+Bti9hgJU=;
        b=IRnZ/ttT2NSZRSPKQnacOIV5Ll5NOiNChZlbz686/XXDRfkN/+U8v4gV6/eSOv5g/4
         aemyxD6CDc9yXSjYG6PG1bJfpevN3MYOms67SOICK4xKQRh5AcqJlbDR1kNCA/DTmaR1
         10v6S9FXndWeIN06Cf4o43k+rPEd0iPrCgY5wwi66XrEcoohZixHQSUTJAcDKDMvYYX3
         4HOIWB2H7YlIgZXwqXNLh4kztsS+SVOAXuubVV445pwMOihtFDxJg+jh1ZsUPV3SHLlu
         ca5uiOQ3difwFI20xG7EmDzvFVYXyRGmw3vfY2PiyE4sRo+EBpt0QWgj8XNGBU75UXwj
         iDdA==
X-Gm-Message-State: AOAM531K9Cb/zFSUD49a2Fgh64QfWN3P/cazR70MWll/CePQCxD24Fcg
        ZeuCi9He3zX/e6uRj0yANJVkTVlZFdfU6prvWKALuI8KHpw=
X-Google-Smtp-Source: ABdhPJyScqZlgvyPQTzVpV4I+sGeWxzgnVBET+fGGS5682n8JMhfQwNcft0wWNxjQQxdlqQxsbfXV9iGKsUsQlTKwqA=
X-Received: by 2002:ab0:5928:: with SMTP id n37mr2615913uad.15.1635405315090;
 Thu, 28 Oct 2021 00:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com> <449eb5c205e139e21b619c4eb975afc3d47427f3.1635320952.git.gitgitgadget@gmail.com>
In-Reply-To: <449eb5c205e139e21b619c4eb975afc3d47427f3.1635320952.git.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 28 Oct 2021 00:15:04 -0700
Message-ID: <CAPUEspi_nxpYzJOjJ0osRRLVQ42uPRA9=9eWp3NBtbpeVtJZng@mail.gmail.com>
Subject: Re: [PATCH 1/5] t1051: introduce a smudge filter test for extremely
 large files
To:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 27, 2021 at 12:03 PM Matt Cooper via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
> index 8b7640b3ba8..684ba5bd0a5 100755
> --- a/t/t1051-large-conversion.sh
> +++ b/t/t1051-large-conversion.sh
> @@ -83,4 +83,16 @@ test_expect_success 'ident converts on output' '
>         test_cmp small.clean large.clean
>  '
>
> +# This smudge filter prepends 5GB of zeros to the file it checks out. This
> +# ensures that smudging doesn't mangle large files on 64-bit Windows.
> +test_expect_failure EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
> +       test_commit test small "a small file" &&
> +       test_config filter.makelarge.smudge "dd if=/dev/zero bs=$((1024*1024)) count=$((5*1024)) && cat" &&

/dev/zero doesn't exist in HP NonStop, a portable solution would be to
use `test-tool genzeros` that is available since d5cfd142ec (tests:
teach the test-tool to generate NUL bytes and use it, 2019-02-14)

Carlo

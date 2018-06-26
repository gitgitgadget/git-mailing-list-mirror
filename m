Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00AAF1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 08:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933133AbeFZI6I (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 04:58:08 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35150 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbeFZI6G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 04:58:06 -0400
Received: by mail-vk0-f65.google.com with SMTP id o202-v6so617327vko.2
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9xI8R/s4lxplZj3LmwAHeg74T6rBdldXXFxDkQtutjo=;
        b=poP2AxrmIdqmpxkSMckX2RCzb/VvltkpQz8kWRw3+cnrtJI61hjJfWUoViVp4ipseU
         KYs/EBjtqjpxLzB6AQaNQ+RjU2KOC2s4JtUIFJFrLzipN5vGwZsSzUEYYLi1Yh4Yhf0R
         hXhMCyu+zDFg9SqIG2g/Mapd7jCzEu2F2S2GW77z8sslwkjRcInWzo6B99pYZ+/TMr4X
         xOJqcS3Hoj7j56siKYli/e9ZD4lwsqxvhW7bzcdnm68zvtqPtpm5WA/nqxTtt3Xhuj2v
         k3llKir+fZpDRn80PrSdFeL2quo0Dvd8UMMb6KeXHavPSif0+AAhZFzEbPCDfBX4lqGt
         7Xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9xI8R/s4lxplZj3LmwAHeg74T6rBdldXXFxDkQtutjo=;
        b=Gl67iHvZIuOno0y5Tv13EN68mk2NWjhbrQkfBGVPAHGA0LHn/ILwDqGrdG31olLP+s
         049FqJF/3u0dbs4F9+00kRKQ6lUMWG4gMBf0EDuNUAH9jaGvVc76EXig7bD42ec8zIae
         PZtTrGdsmnV1WD+Dn3B2FSZgahrgqpSQxOfZAqM6leJIStpw6+hzikxKRKo59brYPuV/
         otjQjF11oU7rgquSUT363A26fIXYW+fi2KcPRB4u2HiVCM86GdMmiq3V0j5ZNGVm9rXt
         yBRjumIDZsyk1xvWY52nJJTqkSHFJM823ma7FeHdu2ILzBiq11rztsK6QJWeonVq8JmF
         cSPA==
X-Gm-Message-State: APt69E1S5A+sy6h5hl1NO43CvLEDw72tYWR4I7llgaIRd03rOO/Kce9c
        u0BvaqA+/O9nP9owt29WeuQrgeaLvCz6zg89AB8=
X-Google-Smtp-Source: AAOMgpdEsIKPy/oRDyRC4oLYi+K4ChjF8HjCrCnp2Lnsp4GxEF3DMarLEldmJSaFEGHoX+307cfig9SvWgLYtDhcIrs=
X-Received: by 2002:a1f:d285:: with SMTP id j127-v6mr347550vkg.7.1530003485455;
 Tue, 26 Jun 2018 01:58:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2310:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 01:58:04
 -0700 (PDT)
In-Reply-To: <20180626073001.6555-18-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com> <20180626073001.6555-18-sunshine@sunshineco.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jun 2018 01:58:04 -0700
Message-ID: <CABPp-BFmfN6=E+3BAKt-NH5hmU-368shgDnrnkrnMRvKnx07BQ@mail.gmail.com>
Subject: Re: [PATCH 17/29] t: use test_must_fail() instead of checking exit
 code manually
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 12:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> These tests intentionally break the &&-chain to manually check the exit
> code of invoked commands which they expect to fail, and invert that
> local expected failure into a successful exit code for the test overall.
> Such manual exit code manipulation predates the invention of
> test_must_fail().
>
> An upcoming change will teach --chain-lint to check the &&-chain inside
> subshells. This sort of manual exit code checking will trip up
> --chain-lint due to the intentional break in the &&-chain. Therefore,
> replace the manual exit code management with test_must_fail() and a
> normal &&-chain.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t5405-send-pack-rewind.sh |  3 +--
>  t/t9814-git-p4-rename.sh    | 16 ++--------------
>  2 files changed, 3 insertions(+), 16 deletions(-)
>
> diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
> index 4bda18a662..235fb7686a 100755
> --- a/t/t5405-send-pack-rewind.sh
> +++ b/t/t5405-send-pack-rewind.sh
> @@ -25,8 +25,7 @@ test_expect_success 'non forced push should die not segfault' '
>
>         (
>                 cd another &&
> -               git push .. master:master
> -               test $? = 1
> +               test_must_fail git push .. master:master

test_must_fail or test_expect_code 1?

>         )
>
>  '
> diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
> index e7e0268e98..80aac5ab16 100755
> --- a/t/t9814-git-p4-rename.sh
> +++ b/t/t9814-git-p4-rename.sh
> @@ -12,20 +12,8 @@ test_expect_success 'start p4d' '
>  test_expect_success 'p4 help unknown returns 1' '
>         (
>                 cd "$cli" &&
> -               (
> -                       p4 help client >errs 2>&1
> -                       echo $? >retval
> -               )
> -               echo 0 >expected &&
> -               test_cmp expected retval &&
> -               rm retval &&
> -               (
> -                       p4 help nosuchcommand >errs 2>&1
> -                       echo $? >retval
> -               )
> -               echo 1 >expected &&
> -               test_cmp expected retval &&
> -               rm retval
> +               p4 help client &&
> +               test_must_fail p4 help nosuchcommand

same question?

>         )
>  '

Overall, looks much nicer.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A62281F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbeFZH73 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:59:29 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:42701 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeFZH73 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:59:29 -0400
Received: by mail-ot0-f196.google.com with SMTP id 92-v6so18046832otw.9
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F/JWfS13lEp3gLatbSmeVZ+HL4/jVGZwOap2jIUmiNY=;
        b=FU4hgQB/rnm2fY9qyNUtvkHBvDXFhgLGXSjXC0WZk39IepGxNGdcVW6iKRkluql8Ub
         BDcxcrWmXY8LjPLuodcPrjawfWRGD2MGluS+J3qwQbT4O9peeKwT+SVjVSCjqen45Uqs
         Eg4iMd+GM4svP+koDxeMTHqOW637aDJzviCSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F/JWfS13lEp3gLatbSmeVZ+HL4/jVGZwOap2jIUmiNY=;
        b=F8V90mhUqcAaRBcF4yeWyELqZdrtBSGbp1NeT0dM7amLpVXXnwpAZNf6HHjbcW8Nmm
         TELSguoVOu238kqePDAA4MZkBZEtJDvYElEQaFz/IDBdJmwlp393wTHVXs5ybM4R/YFn
         TacPbs2d+rjSRq3VbFxkJAPpheGjeh7QYKJWg/DuogsNWRTAwk1SVNMegLFVeVEHklF0
         ImqgAc/fzfWaVl98VEivdaerPWqxuet4Qy+C9OaPx+fAKqfnYwtgfuAhPE+/VRsnx+YN
         vsnOlTcM22kOeJonZKis49jaBV+m8O36zkQLV+ieEwChuANT5BB6b3o8gs2FDMEt5bJu
         LZow==
X-Gm-Message-State: APt69E3LtMqSoTTxw8qndtPboKzHyxB14EqDz6nJos7PLqzMdaXNpoLH
        1CDpwdNXhn/f4Flha+o549bECXJFE0pHePcO0AQMXA==
X-Google-Smtp-Source: AAOMgpfN/u50wG0VUnBLTXlPgwY/F5vtswM5SoCdTZXseYn7jOB92l4t/no0YjDOTNU0NFae+rAbHb1jN4HFOR+c38Q=
X-Received: by 2002:a9d:5250:: with SMTP id q16-v6mr208541otg.229.1529999968392;
 Tue, 26 Jun 2018 00:59:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2fae:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 00:59:27
 -0700 (PDT)
In-Reply-To: <20180626073001.6555-18-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com> <20180626073001.6555-18-sunshine@sunshineco.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 26 Jun 2018 08:59:27 +0100
Message-ID: <CAE5ih79-eXhx8d9Fsgo-4gFQ6A-Deje1ky3ge5X-vEuZcSePJA@mail.gmail.com>
Subject: Re: [PATCH 17/29] t: use test_must_fail() instead of checking exit
 code manually
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26 June 2018 at 08:29, Eric Sunshine <sunshine@sunshineco.com> wrote:
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

This seems a lot more sensible. It works fine in my tests.

Thanks,
Luke

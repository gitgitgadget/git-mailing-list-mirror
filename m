Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C9581F516
	for <e@80x24.org>; Mon,  2 Jul 2018 18:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeGBSaB (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 14:30:01 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38547 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753389AbeGBS35 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 14:29:57 -0400
Received: by mail-yw0-f194.google.com with SMTP id r3-v6so327703ywc.5
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sa+M3cR0zfg8BLAiT2MdymfnosiJ8zzcAjxUG1SGQzo=;
        b=HOlFYB0wVFvppXs4YbEMJfXOuSZS75UPISODG29rHLi/BPsfIEwyX4rvQWMDeZ1geZ
         a4zdF5xSN/mnQUB4mxQbUJLDzxZqmCU80GeF8GBqGleoH7zRo/txTnMVP1bzsSOtU0yR
         k9megT2pQoLauXXPcZN8U3Gzqk0ESuHfj2h2WJjuAPY4dX5U4tTwXkIbdu9E72r7nMGp
         RNbKCSKe4w0RQ+DuCmBEFwEWQ24MvT3erw9/L9Y5U8MZxbXL+V/XHyS/j+3WGdCglpBC
         1wYXn/QuM9G+1FGj4oFgdkqwb19YDnbRY1hIYXgW3bMBvQmLq7uoytJWoYVqKqfwOw7P
         GRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sa+M3cR0zfg8BLAiT2MdymfnosiJ8zzcAjxUG1SGQzo=;
        b=Vy1ln88AJXKOr9X16GlW2j7vX/01m1GQBWLFsPKXaddsOtRnv0ozRWYNuCNQvwaKlA
         dZCD7vV2F6l5q7abiZQlVD2vHraPTpHAbqoNJPTHFUhuublQwgNPcSQGFZgd8/9UU3DJ
         QoYKgIl0K5FhxjA1bpn3beh3koH7wLoULOWjaKC+xsNUVJd/DiOotAS86MWBQ0JWIo8f
         LTYXsfnO5SK/L8sIPhykqxwRrz/wQ4Optw+bkUvN4FNE8exoBsGdXg/w/Oxm5HezyiKC
         Dh8x/ZmqOZKK4lhbQVYLclLDS6r5qipzTLHWMjl1MQlYJFNq5OIfMW7zUyzjuOwdXb09
         LjMA==
X-Gm-Message-State: APt69E0Rg+/9MCfOucPnVJAQ9N4FWiaYc4h177TMZZYVJg9uiEjhozBr
        uF9qZ84ZvVcWI9+ib2mBcTWuQLLvWq45kEq2i1a7sA==
X-Google-Smtp-Source: AAOMgpe3LQTtPdti9HA7d7V3wyllUmkJdJcRxCaivbWMG98J7lr1l9xTiymiXyRWUJfcWG2d4PEjZyqVObS2aHzeAO8=
X-Received: by 2002:a81:c743:: with SMTP id i3-v6mr15528ywl.421.1530554761337;
 Mon, 02 Jul 2018 11:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180702002405.3042-1-sunshine@sunshineco.com> <20180702002405.3042-13-sunshine@sunshineco.com>
In-Reply-To: <20180702002405.3042-13-sunshine@sunshineco.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Jul 2018 11:05:48 -0700
Message-ID: <CAGZ79kZFSAe1NL3EVKtbSm6E9PvhajWdrrbwDNMm2K5FRH7m-Q@mail.gmail.com>
Subject: Re: [PATCH 12/25] t7810: use test_expect_code() instead of
 hand-rolled comparison
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 1, 2018 at 5:25 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> This test manually checks the exit code of git-grep for a particular
> value. In doing so, it intentionally breaks the &&-chain. Modernize the
> test by taking advantage of test_expect_code() and a normal &&-chain.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t7810-grep.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 1797f632a3..fecee602c1 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -845,10 +845,9 @@ test_expect_success 'grep from a subdirectory to search wider area (1)' '
>  test_expect_success 'grep from a subdirectory to search wider area (2)' '
>         mkdir -p s &&
>         (
> -               cd s || exit 1
> -               ( git grep xxyyzz .. >out ; echo $? >status )
> -               ! test -s out &&
> -               test 1 = $(cat status)
> +               cd s &&
> +               test_expect_code 1 git grep xxyyzz .. >out &&
> +               ! test -s out
>         )

Further optimisation would be possible if I understand the code correctly:

    test_expect_code git -C s grep xxyyzz .. >../out
    test_must_be_empty out

(dropping the subshell entirely)


>  '
>
> --
> 2.18.0.203.gfac676dfb9
>

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05381F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935029AbeF0SFK (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:05:10 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:42776 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934833AbeF0SFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:05:09 -0400
Received: by mail-yb0-f181.google.com with SMTP id i3-v6so1099089ybl.9
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q98Iyn7cnWPfNi+shSCNGKdFDpDgplhBfWMauylE9G0=;
        b=uKddTcZB1Oe1PNhyc/c3VVbQmqoRf3uPtf1BQOu9RuW3r7xLjdQ4NeyKT9SfkYCrZ7
         JgwRSa1dFzDgDTO5HdzvzxeGQGg9sIXlKnCBAf4m4dT2RsO2BHK8uAa4S0iYlc4q7Q+c
         1m0FgwGtJJ5TMCbTSocxnKq4RfBZ+lMk65wN/UcDvLWzvbgDm4XUb9JwEeG4xQUy1+do
         0h8+MjgicMJFmEDHevXKNnC6OKkbXomt6e5CArlbT41hUoGANtsF/0SXXNgFqrussYgL
         aFSJdHKWJw6af+YYW7Al8qptAaJFe99jP2A55FjmX1SpzvSGwrAwmawTBfOC0iJMNMNk
         h08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q98Iyn7cnWPfNi+shSCNGKdFDpDgplhBfWMauylE9G0=;
        b=NZm0eU4xM4hnJPtY4ozRHDFTQjtA6Lx5Kaw6qTVJp/8oc/IZ5QyVsAmp14kF1uNkA8
         i5CyBAYkRklq3OXZOnOfVguDtaOWIYcIVZ/G6WfTWihYJyB0KGiXeZLZoTFeRykZQnok
         AmOUVj2A5rFrv60NbjMJbVVpTNmYCzPa6UPgx4yhZxGdUdzblnuFpgKF5YqaZdOrwXJg
         l8zU6dAm3rqHSfu/vO+RWjJiGO14+iA4bw70V2qWmW3DTsXuG4ir0fUi0prtj/zY0PTO
         YJYR9UGvhro3jlgUN/e0qqqnkrZXktTcLDFknB83/C9nsJ/i/aAljcq609cJ1LOCpkK7
         WoaQ==
X-Gm-Message-State: APt69E0UFC3hG0myU4iLzGI2Avp0/OU6l3+Wuo6Sgp4yL1ZcyueTTy2A
        c3moNbJc0Rr9STjZ51P9vEnODWM42iDmtpLY41kO/bV0
X-Google-Smtp-Source: ADUXVKLWhO2drXjH+XO4GT7xkvS+muUu2SnK35RA1hYLZ74RZS9oMHnJ69Od2RLDFKhmDt6QmgAFLd5772f2hiMo9Tc=
X-Received: by 2002:a25:560b:: with SMTP id k11-v6mr3614367ybb.292.1530122708642;
 Wed, 27 Jun 2018 11:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180626073001.6555-1-sunshine@sunshineco.com> <20180626073001.6555-9-sunshine@sunshineco.com>
In-Reply-To: <20180626073001.6555-9-sunshine@sunshineco.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 27 Jun 2018 11:04:57 -0700
Message-ID: <CAGZ79kZziBqyUbFuBEiMUO+5sx6ds=RY0SXejZA7F2CVY67rqQ@mail.gmail.com>
Subject: Re: [PATCH 08/29] t7400: fix broken "submodule add/reconfigure
 --force" test
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>, szeder@ira.uka.de,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 12:30 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> This test has been dysfunctional since it was added by 619acfc78c
> (submodule add: extend force flag to add existing repos, 2016-10-06),
> however, two problems early in the test went unnoticed due to a broken
> &&-chain later in the test.
>
> First, it tries configuring the submodule with repository "bogus-url",
> however, "git submodule add" insists that the repository be either an
> absolute URL or a relative pathname requiring prefix "./" or "../" (this
> is true even with --force), but "bogus-url" does not meet those
> criteria, thus the command fails.
>
> Second, it then tries configuring a submodule with a path which is
> .gitignore'd, which is disallowed. This restriction can be overridden
> with --force, but the test neglects to use that option.
>
> Fix both problems, as well as the broken &&-chain behind which they hid.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

This patch is
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks for this whole series (I just read the cover letter) and I think
detecting broken && chains is a valuable part in the test suite.

Thanks,
Stefan

> ---
>  t/t7400-submodule-basic.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 812db137b8..401adaed32 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -171,12 +171,12 @@ test_expect_success 'submodule add to .gitignored path with --force' '
>  test_expect_success 'submodule add to reconfigure existing submodule with --force' '
>         (
>                 cd addtest-ignore &&
> -               git submodule add --force bogus-url submod &&
> -               git submodule add -b initial "$submodurl" submod-branch &&
> -               test "bogus-url" = "$(git config -f .gitmodules submodule.submod.url)" &&
> -               test "bogus-url" = "$(git config submodule.submod.url)" &&
> +               git submodule add --force /bogus-url submod &&
> +               git submodule add --force -b initial "$submodurl" submod-branch &&
> +               test "/bogus-url" = "$(git config -f .gitmodules submodule.submod.url)" &&
> +               test "/bogus-url" = "$(git config submodule.submod.url)" &&
>                 # Restore the url
> -               git submodule add --force "$submodurl" submod
> +               git submodule add --force "$submodurl" submod &&
>                 test "$submodurl" = "$(git config -f .gitmodules submodule.submod.url)" &&
>                 test "$submodurl" = "$(git config submodule.submod.url)"
>         )
> --
> 2.18.0.419.gfe4b301394
>

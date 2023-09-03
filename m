Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEC1C83F2D
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 09:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbjICI7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 04:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjICI7t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 04:59:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F18120
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 01:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693731578; x=1694336378; i=johannes.schindelin@gmx.de;
 bh=4xA6lVKPb29xocltG0Dr+4weMIs9xGLECxj7j2vMx+g=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=sWXPNdX+h0wXST9e0QUElKZ8krIUgFjNHzUessW+hWa+f+9ZpGSV+5uv2SDlkSGO9c4Hhes
 NweItIcj60EzjpaJamTA4OwMZnL4UlgxDQ2qGQ5TFzuVxU8qfWgOybV/bWzeflKnav4Tw51LP
 pI58VugUWwbdRwOqD2rFrKNVbc2sVJoQXHqZh0irH8R0hst9EGERjoLYQW+C/riUht0J0SoYe
 94OGNxS9fcLgYgsIZogjd34kgjQms6f9NJMPMVzqrA70YgknHaP9+qfW2eYw6IL71o9Hc4d3X
 AnKx8Hb+ksx7psVn4jkv5QIfuajkkg0A0UbgmfwNb6OQ4GP5fsAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.152]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1pmGtP1snJ-00rGbr; Sun, 03
 Sep 2023 10:59:38 +0200
Date:   Sun, 3 Sep 2023 10:59:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci: allow branch selection through "vars"
In-Reply-To: <20230830195113.GA1709824@coredump.intra.peff.net>
Message-ID: <d000f469-2b7d-e037-c92e-013034490461@gmx.de>
References: <20230830194919.GA1709446@coredump.intra.peff.net> <20230830195113.GA1709824@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:E2j5KjFCARaHAhU4hDtYYT0Xrzb+m/xWOpwcUqdSderZi7AFsfg
 E0R46JMIEwaQssBlT8cswPxjLB86e8rMuOeYiQ0elbsx9vKNTJ5k1//fqFdBRGd8a0pZbC5
 yDIk3APIReV6psPiSfZZu88dlpQ2DmWxZF24kbUeQ1apJx5YomRuyV9X36jpkwkhgVog8Nd
 XKGrHUacyRvoQ9T0HRE1A==
UI-OutboundReport: notjunk:1;M01:P0:wkov25OUZiE=;mE6vtSgbaX/SehWlVh3xrQjhZYk
 L9aPjJis5c8IG7Ie9s+E45bj2t7Zw/3aDcN+prRtaBoO3Qzt5/uIq1x8pdzbSRbPby9Qea0Sf
 cKiSvAkvyO0ZboO+INIQHC/YnTId9vQf+11OZLMrB95u4Uz/4fqy665JvvIxjsu4v4dtgeBrI
 7gUzz7Ic3mHyScNiPjzS9YireEhredX0okkDR0usV6Z58KysiZfBSE4tqmTHOJuQblxDqavlI
 0BfdJtNAvmM53JHeYgOi04ocYNeT08MGF8+9+5Agd/eZu++zQUhYAnHSSCr6ILBXOt3QGoIsV
 vUC9Kl121M4iI4mMNOtzgLEaKQ359+ZSryJWU4mDS6Xmphe5gjtYnD3+WJe8qt++YePnTeTAr
 tqtbBW7wMls12R8xgXM6GYpymvUPOxq3bqw2jPEJWgz40YZZIzqHHW8kYvB8o8bjxX0+nAx3b
 B/H9Z9SmNVCFA5oO9XN5r298nSn02L+Zv8MdjoiOO0bcjvRzVuZXDSzLYgkhtSB5DUt9t9fSW
 8CFlTmrVvCaMPWLQLQnHi3WaKP2IzMJzJtJh+i3EIYUNPLVo9Ne3ZxXf3hs0AQS9LdDPY0D/t
 jepOSV1aOUtsTFAtixcb73XNp2H/kYocZIOOnEW9DaD9enfcJI9mQ2/P+9pBmON1YWyCGLh5r
 766/Dvi0mNLq5YAvaQgQTqbAo31T1uVBSKRqd0bqqxESrtlmC+/i1OsW5wkFvzeCnkdXP6BZY
 nJIp9skC69jD3g4pef6jprkq8ae+GLukqkV8+6nZZ2IAELTYsVfuKu+lW0rHSRfnnze2ltUn3
 LyCkIKZL1jDeCCCnXjAap7wGhLOGNU63qW+PLpziBJLt+ErF9puHPgn/wdFZpggqyqHpRVvbM
 jru+3VQubR98fVTkJxTSX+6HqdTgGdFoiWdh+NDA+AnsjMiLU4b4eY1foMuEQNc6cH+QwS8+g
 qnOjp8UPTgktwKhmoG58uQOzzkc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Wed, 30 Aug 2023, Jeff King wrote:

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 1b41278a7f..c364abb8f8 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -21,6 +21,7 @@ concurrency:
>  jobs:
>    ci-config:
>      name: config
> +    if: vars.CI_BRANCHES == '' || contains(vars.CI_BRANCHES, github.ref_name)

This might be too loose a check, as branch names that are a substring of
any name listed in `CI_BRANCHES` would be false positive match. For
example, if `CI_BRANCHES` was set to `maint next seen`, a branch called
`see` would be a false match.

Due to the absence of a `concat()` function (for more details, see
https://docs.github.com/en/actions/learn-github-actions/expressions#functions),
I fear that we'll have to resort to something like `contains(format(' {0} ',
vars.CI_BRANCHES), format(' {0} ', github.ref_name))`.

Ciao,
Johannes

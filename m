Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36455EC8758
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbjIGUz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjIGUz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:55:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1D11990
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694120151; x=1694724951; i=johannes.schindelin@gmx.de;
 bh=XqMZDlUO0s4409XccoOz5Tb4WWDlrE5tkQfzXVcXQ8M=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=khiYP4bgzoosy4JLMTWlu4J49b6de7H4UwPl5but8Lf1hM37Y+QQ+Pz3b6j7kPopdij3cQD
 7IBE2EULyRXcaOEuw6RfxFPuxFS648+oyP9f0c6wB71Mp8oRRHgFLzLGFVhaAxIp3qmc/5Nef
 a2hAGIdL+xWQddP4Wth8lCli9A+GddUZiGvTjHrbTTnP4qLtuZ7ir81+sFjxY3XUoj0PGr3j4
 AAQ274Z1eCuGIDtx4SJCcY+zGnvSmcGC+TxKUt0DUYzbp5y/dX48PDPqqnRQiILcyU2F5thcM
 Diozp9P/csz3sUA+Q/QZv2UGUVLRBb9K1mphM7tjTtp8po+i3XPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([80.151.253.86]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWAOW-1q7noI3syo-00XZLC; Thu, 07
 Sep 2023 13:01:53 +0200
Date:   Thu, 7 Sep 2023 12:23:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Toon Claes <toon@iotcl.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 02/15] replay: introduce new builtin
In-Reply-To: <20230907092521.733746-3-christian.couder@gmail.com>
Message-ID: <52277471-4ddd-b2e0-62ca-c2a5b59ae418@gmx.de>
References: <20230602102533.876905-1-christian.couder@gmail.com> <20230907092521.733746-1-christian.couder@gmail.com> <20230907092521.733746-3-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:38dWbJe2lkdhmvIVBpVV5w4IMY6JpOWXvRuIv01gbmkTqz9+PfR
 72fo22jHpTXY0+RmROSUlUbJ45QfwuwCR8pBHhX/C27QE8VE+g5QCoSl8JCa0KoZDTZhudH
 ZrownvumyOAm62kD/cR9aWC+bqgrH46ZI3pS+aYjlZXMT8nZ32U14mXVKi61/pmrC08AMie
 xihT1OWO89NklgV4UA8mw==
UI-OutboundReport: notjunk:1;M01:P0:NFhM2qtddT4=;V0ZvfefM82/xq7zjdcYXHWJE/47
 9Vx6K3aR9lt9Zk79BFch36No+anY10WwE2OpYrGwnHZWSn3RwD0cSKii/ltJOWNrxXRYahLOv
 O+HzfJ7Id/lpzKhWUfjSkWdEM3vYf4x4s8OogvPQQPfGDsZIfA9aTct+uUdBZnE9Ek8i8Inb4
 H6ovBi9YtuDw/8GDr5BiBk4o95OZBcUcktRHWuUWy/tZJU1SqKoPjdDfp55ipK3hv9eEBFmSk
 K+KRoPg0/ZZpyCBoLf/hXZD2171WbzEKrWwLz/vclHXhuSNMGK80o/DrlowmLHUKxvdJTKCJF
 mYT547h1DKRVQqD1JtqXpoLHpozcSfYKdWzICRalq5GfUck0i5LG2YnUJ2CV9KbHH1jUG/Ijh
 GJjosW+Zp0aumm3G2ODQp8eshdys1KTv6Hjmp7tbQZsyX3SnzcXKy42n8DwpDcVj5tur+zOa2
 COFyFDoclTw4nNACOC3X/NUIqPD7ZQQ1zjRq0kx+A4BYpZZC2kBSbWPwH/G+1uOc42asT1Rmw
 29vCvOlzYzEHMKGuFa9wekMYxNdQNSNqsHxMtm1J9pTZCsfbZWa31m4PzSsNtYDqGjsql9wmv
 OZ9DTCiUdVu3K+fETocjJph7B1XEvl0jIljsHKVYuAaMRDeXQo3UBzzoMpRPQX2t/mdWj32a1
 ex+wzdDCTB9hf3nwxX7Y4EbLtSMYONdxB2P1kqiAttFMSGZm+gfxyh7mVRxp5dmsHg6zrSiIQ
 ejSNBL+17jo5DTAyrdu0vS72qhRZzGw2MrvFyspsHaDUw0CHvYsh/irnSDYoeqbuNwRy6Rwwq
 m9FhqOMM3EMIYbN3uGSj0SREmY2H0ChPJxcGw7Vs9ezeFM8pPZPViOWJL/o9ROzpjNueAn4f5
 KAAHaesHMaiLOvRxHmfBbRFzuRg7Hwvd0oytrAzUrvQwZHlopxVR688YEe3DcfpK+CW5ktfwj
 EGUC0Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian & Elijah,

On Thu, 7 Sep 2023, Christian Couder wrote:

> diff --git a/command-list.txt b/command-list.txt
> index 54b2a50f5f..d74836ab21 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -160,6 +160,7 @@ git-reflog                              ancillarymanipulators           complete
>  git-remote                              ancillarymanipulators           complete
>  git-repack                              ancillarymanipulators           complete
>  git-replace                             ancillarymanipulators           complete
> +git-replay                              mainporcelain           history

I recall this having come up before, but in light of the still active
discussion revolving around command-line parameter validation, I would
strongly advise removing `git replay` from the main page and instead go
for plumbingmanipulators.

Ciao,
Johannes

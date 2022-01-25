Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F9C433FE
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 08:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453172AbiAYIwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 03:52:43 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:53680 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452633AbiAYIuI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 03:50:08 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4JjgXP0QVLz1sYdt;
        Tue, 25 Jan 2022 09:49:56 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4JjgXN6Qqjz1qqkC;
        Tue, 25 Jan 2022 09:49:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Xu7O39zLbbPM; Tue, 25 Jan 2022 09:49:56 +0100 (CET)
X-Auth-Info: /NrgCk3oqSlRrObJnYR1fsES+IE2bX2Ag9NUbxg7MsV5dloAV4Km5r7XsRatRdhZ
Received: from igel.home (ppp-46-244-168-172.dynamic.mnet-online.de [46.244.168.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 25 Jan 2022 09:49:56 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 88C942C3892; Tue, 25 Jan 2022 09:49:55 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michael Herrmann <michael@herrmann.io>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: A puzzle: reset --hard and hard links
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
        <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net>
        <xmqqilufl5cv.fsf@gitster.g>
        <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>
        <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net>
        <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
        <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com>
        <xmqqk0ep57ou.fsf@gitster.g>
        <CABrKpmB7UEGzLCiNHQtY5-Dt16jLkpcpBEx3o8y9OBGZ418keA@mail.gmail.com>
        <xmqqfspc3k8k.fsf@gitster.g>
        <CABrKpmDjrTPhL_55YaXEAVTEmu8iZEsKUJYab7OgK0=w9d_7MA@mail.gmail.com>
X-Yow:  Now, I think it would be GOOD to buy FIVE or SIX STUDEBAKERS
 and CRUISE for ARTIFICIAL FLAVORING!!
Date:   Tue, 25 Jan 2022 09:49:55 +0100
In-Reply-To: <CABrKpmDjrTPhL_55YaXEAVTEmu8iZEsKUJYab7OgK0=w9d_7MA@mail.gmail.com>
        (Michael Herrmann's message of "Mon, 24 Jan 2022 18:50:49 -0300")
Message-ID: <875yq842to.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 24 2022, Michael Herrmann wrote:

> My suspicion is that Git keeps a cache of the stat(...) result of
> files. An additional hard link increases the .st_nlink count of this
> struct. `git reset` compares the cached stat(...) values to the actual
> ones and sees that one has changed. `git status` does the same but is
> smart enough to realize that the additional hard link does not change
> anything. It writes this to the cache. `git reset` should also be
> smart!

See the core.trustctime config.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

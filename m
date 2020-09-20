Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5745CC43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 16:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207B320EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 16:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgITQD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 12:03:28 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54577 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITQD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 12:03:27 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BvXRf0jzQz1qs03;
        Sun, 20 Sep 2020 18:03:26 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4BvXRd6zWXz1qryt;
        Sun, 20 Sep 2020 18:03:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 2Nhy95Oe19NY; Sun, 20 Sep 2020 18:03:25 +0200 (CEST)
X-Auth-Info: OSyzmV16P8KG/oCuoZZbpHFkXwmPvY9GuE6OOTlQKjhywFBICOUw84UoeJww5CgY
Received: from igel.home (ppp-46-244-189-145.dynamic.mnet-online.de [46.244.189.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 20 Sep 2020 18:03:25 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 12CB92C2861; Sun, 20 Sep 2020 18:03:24 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] builtin/rev-parse: learn --null-oid
References: <cover.1600427894.git.liu.denton@gmail.com>
        <004f2e4c92918a7a4e452d49e98ef15f1c5ac545.1600427894.git.liu.denton@gmail.com>
        <20200918141125.GB1602321@nand.local>
        <20200918212609.GC67496@camp.crustytoothpaste.net>
X-Yow:  I'm pretending that we're all watching PHIL SILVERS
 instead of RICARDO MONTALBAN!
Date:   Sun, 20 Sep 2020 18:03:24 +0200
In-Reply-To: <20200918212609.GC67496@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 18 Sep 2020 21:26:09 +0000")
Message-ID: <87h7rsl9kj.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 18 2020, brian m. carlson wrote:

> What I typically do when I write shell scripts, and which may obviate
> the need for this patch is turn this:
>
>   [ "$oid" = 0000000000000000000000000000000000000000 ]
>
> into this:
>
>   echo "$oid" | grep -qsE '^0+$'
>
> This is slightly less efficient, but it's also backwards compatible
> with older Git version assuming you have a POSIX grep.

You can also use

  case $oid in *[1-9a-f]*) ... ;; *) ... ;; esac

which doesn't need an external process.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

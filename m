Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C13AC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25FE7613DB
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 21:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhDTVpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 17:45:00 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54764 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhDTVo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 17:44:59 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4FPxzD2Vkdz1qskn;
        Tue, 20 Apr 2021 23:44:24 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4FPxzD1xRgz1qqlD;
        Tue, 20 Apr 2021 23:44:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Rercr47ueWvV; Tue, 20 Apr 2021 23:44:23 +0200 (CEST)
X-Auth-Info: CMImxLkr86JouaUKsBywxKl4xbJu5R/KdIh8oSKBa2xPcinDftwl5NbgqODHZkeF
Received: from igel.home (ppp-46-244-161-165.dynamic.mnet-online.de [46.244.161.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 20 Apr 2021 23:44:23 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id E088D2C3716; Tue, 20 Apr 2021 23:44:22 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v2] builtin/repack.c: set a default factor for
 '--geometric'
References: <1ecab817396fae6a1cbafde1ca8b3ebfd9ae4c11.1618883241.git.me@ttaylorr.com>
        <8d8dea2e2c149303891cfe6ae8dbec06b538622c.1618950726.git.me@ttaylorr.com>
X-Yow:  KARL MALDEN'S NOSE just won an ACADEMY AWARD!!
Date:   Tue, 20 Apr 2021 23:44:22 +0200
In-Reply-To: <8d8dea2e2c149303891cfe6ae8dbec06b538622c.1618950726.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 20 Apr 2021 16:32:13 -0400")
Message-ID: <877dkwfx6x.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 20 2021, Taylor Blau wrote:

> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index 317d63cf0d..f7c7e0aeae 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -165,11 +165,12 @@ depth is 4095.
>  	Pass the `--delta-islands` option to `git-pack-objects`, see
>  	linkgit:git-pack-objects[1].
>  
> --g=<factor>::
> ---geometric=<factor>::
> +-g[=<factor>]::
> +--geometric[=<factor>]::
>  	Arrange resulting pack structure so that each successive pack
>  	contains at least `<factor>` times the number of objects as the
> -	next-largest pack.
> +	next-largest pack. If `<factor>` is not specified, then `2` is
> +	used by default.

I don't think the short option takes a '='.

$ ./git repack -g=2
error: switch `g' expects a numerical value

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646F6C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE3D239EB
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 19:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgLQTPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 14:15:32 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:38973 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgLQTPb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 14:15:31 -0500
Received: from localhost (unknown [103.82.80.43])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0A7A4200002;
        Thu, 17 Dec 2020 19:14:49 +0000 (UTC)
Date:   Fri, 18 Dec 2020 00:44:47 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: conditionally include GIT-VERSION-FILE
Message-ID: <20201217191447.xrijupbmqulnp3ym@yadavpratyush.com>
References: <ceacd2f6-c9c7-ef93-8bc2-0749770a260f@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceacd2f6-c9c7-ef93-8bc2-0749770a260f@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/12/20 12:39AM, Ramsay Jones wrote:
> 
> The 'clean' target is noticeably slow on cygwin, even for a 'do-nothing'
> invocation of 'make clean'. For example, the second 'make clean' given
> below:
> 
>   $ make clean >/dev/null 2>&1
>   $ make clean
>   GITGUI_VERSION = 0.21.0.85.g3e5c
>   rm -rf git-gui lib/tclIndex po/*.msg
>   rm -rf GIT-VERSION-FILE GIT-GUI-VARS
>   $
> 
> has been timed at 1.934s on my laptop (an old core i5-4200M @ 2.50GHz,
> 8GB RAM, 1TB HDD).
> 
> Notice that the Makefile, as part of processing the 'clean' target, is
> updating the 'GIT-VERSION-FILE' file.  This is to ensure that the
> $(GITGUI_VERSION) make variable is set, once that file had been included.
> However, the 'clean' target does not use the $(GITGUI_VERSION) variable,
> so this is wasted effort.
> 
> In order to eliminate such wasted effort, use the value of the internal
> $(MAKECMDGOALS) variable to only '-include GIT-VERSION-FILE' when the
> target is not 'clean'. (This drops the time down to 0.676s, on my laptop,
> giving an improvement of 65.05%).
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---

Applied to git-gui/master. Thanks.

-- 
Regards,
Pratyush Yadav

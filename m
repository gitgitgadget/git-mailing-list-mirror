Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372C3C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 15:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10BB20727
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 15:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgKVPls (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:41:48 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:52830 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgKVPlr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 10:41:47 -0500
Received: from client3368.fritz.box (i5C744221.versanet.de [92.116.66.33])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 2D4523C04C2;
        Sun, 22 Nov 2020 16:41:45 +0100 (CET)
Subject: Re: [PATCH] git-gui: Fix selected text colors
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org, me@yadavpratyush.com
References: <7553c99f-1dea-0c1d-e5b0-2103333a76b7@haller-berlin.de>
 <20201122133233.7077-1-serg.partizan@gmail.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <2436cd2e-26b9-a7cc-722a-7f27212f58f4@haller-berlin.de>
Date:   Sun, 22 Nov 2020 16:41:44 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201122133233.7077-1-serg.partizan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.11.20 14:32, Serg Tereshchenko wrote:
> Stefan, please check if this fixes select colors for you.

Yes, this works. Thanks for the quick fix! I tested on Mac in both light
and dark mode, and on Windows.

> --- 8< ---
> 
> Added selected state colors for text widget.
> 
> Same colors for active and inactive selection, to match previous
> behaviour.

Preserving the previous behavior is probably a good idea when fixing a
regression.

However, it would actually be nice to have different colors for active
and inactive selection (could be a follow-up patch). In native Mac and
Windows applications the active selection background is usually light
blue, and the inactive one is light grey. This would not just be a
cosmetic improvement that looks prettier (that wouldn't be worth it),
but it would be a real usability improvement because it would make it
much easier to tell which of the four main views has the keyboard focus.

I couldn't find a way to query the inactive selection colors, though. Do
you know if there's a way to do that? If not, I guess one way to do this
is to numerically calculate a grey color with a similar brightness from
the active selection background. I could work on a patch if you think
this is an approach that makes sense.

-Stefan


> Signed-off-by: Serg Tereshchenko <serg.partizan@gmail.com>
> ---
>  lib/themed.tcl | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/themed.tcl b/lib/themed.tcl
> index 83e3ac7..eda5f8c 100644
> --- a/lib/themed.tcl
> +++ b/lib/themed.tcl
> @@ -34,8 +34,10 @@ namespace eval color {
>  		}
>  		add_option *Text.Background $text_bg
>  		add_option *Text.Foreground $text_fg
> -		add_option *Text.HighlightBackground $base_bg
> -		add_option *Text.HighlightColor $select_bg
> +		add_option *Text.selectBackground $select_bg
> +		add_option *Text.selectForeground $select_fg
> +		add_option *Text.inactiveSelectBackground $select_bg
> +		add_option *Text.inactiveSelectForeground $select_fg
>  	}
>  }
>  
> 

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 745B21F461
	for <e@80x24.org>; Sun, 25 Aug 2019 21:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfHYV7H (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 17:59:07 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:38759 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbfHYV7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 17:59:07 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5CCDBC0005;
        Sun, 25 Aug 2019 21:59:04 +0000 (UTC)
Date:   Mon, 26 Aug 2019 03:29:02 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Update in-memory config when changing config
 options
Message-ID: <20190825215902.ccvhgf5wesjmatqj@localhost.localdomain>
References: <20190822223316.11153-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822223316.11153-1-me@yadavpratyush.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

This patch hasn't got any comments, but it looks correct to me, and fit 
for merging IMO.

I updated the commit subject from 'git-gui: Update...' to 'git-gui: 
update...' to match with the style of other commit messages, as you 
suggested in the other series.

You can pull the updated commit from 
https://github.com/prati0100/git-gui/tree/py/reload-config commit 
3d8a8d8ff795f93554dd0ab3bbcdaec6a53c5642.

I don't think it is worth the email noise to send a re-roll with just 
the commit subject changed, but if you want, I will.

On 23/08/19 04:03AM, Pratyush Yadav wrote:
> When the user updates any config variable from the options menu, the new
> config gets saved, but the in-memory state of the config variables is
> not updated. This results in the old settings being used until the user
> either opens the options menu again (which triggers a call to
> load_config), or re-starts git-gui.
> 
> This change fixes that problem by re-loading the config variables when
> the Save button is pressed in the options menu.
> 
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
> 
> The commit can be found in the topic branch 'py/reload-config' at
> https://github.com/prati0100/git-gui/tree/py/reload-config
> 
> Once reviewed, pull the commit 92582527b91750e47c2c3e4d1e2188998e9330ce
> or just munge the patch and apply it locally, whichever you prefer.
> 
>  lib/option.tcl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/option.tcl b/lib/option.tcl
> index e43971b..139cf44 100644
> --- a/lib/option.tcl
> +++ b/lib/option.tcl
> @@ -344,6 +344,7 @@ proc do_save_config {w} {
>  	if {[catch {save_config} err]} {
>  		error_popup [strcat [mc "Failed to completely save options:"] "\n\n$err"]
>  	}
> +	load_config 1
>  	reshow_diff
>  	destroy $w
>  }
> --
> 2.21.0
> 

-- 
Regards,
Pratyush Yadav

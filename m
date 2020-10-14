Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C226FC433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 10:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D41C20757
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 10:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgJNKBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 06:01:30 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:47727 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgJNKBa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 06:01:30 -0400
X-Originating-IP: 157.36.82.177
Received: from localhost (unknown [157.36.82.177])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C592DFF810;
        Wed, 14 Oct 2020 10:01:25 +0000 (UTC)
Date:   Wed, 14 Oct 2020 15:31:11 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Make usettk off by default on Mac OS X
Message-ID: <20201014100111.c43f2fqipc52dtsg@yadavpratyush.com>
References: <20201013190243.62313-1-stefan@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013190243.62313-1-stefan@haller-berlin.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On 13/10/20 09:02PM, Stefan Haller wrote:
> This option is supposed to make a Tcl/Tk app look more like a native app
> for the respective platform. This doesn't seem to work on Mac, it looks
> worse than the non-ttk appearance (for instance, the colored pane
> headers are grey).

I think we should actually fix the root of the problem instead of just 
fixing the symptoms by disabling ttk.

There were recently some changes to how git-gui works with ttk in commit 
c02efc1 (git-gui: improve dark mode support, 2020-09-26). Are you 
running git-gui with that commit? If yes, what results do you see with 
it reverted. If no, what results do you see with it applied?

> Users who really prefer the ttk look can still turn it on with the
> gui.usettk config.
> 
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> ---
>  git-gui.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 867b8ce..f7e13ca 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -897,7 +897,7 @@ set default_config(gui.fontui) [font configure font_ui]
>  set default_config(gui.fontdiff) [font configure font_diff]
>  # TODO: this option should be added to the git-config documentation
>  set default_config(gui.maxfilesdisplayed) 5000
> -set default_config(gui.usettk) 1
> +set default_config(gui.usettk) [expr ![is_MacOSX]]
>  set default_config(gui.warndetachedcommit) 1
>  set default_config(gui.tabsize) 8
>  set font_descs {
> -- 
> 2.29.0.rc1
> 

-- 
Regards,
Pratyush Yadav

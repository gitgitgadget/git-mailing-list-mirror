Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A1F1F463
	for <e@80x24.org>; Sun, 29 Sep 2019 18:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfI2SCC (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 14:02:02 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:38529 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbfI2SCB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 14:02:01 -0400
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 8A5A6100002;
        Sun, 29 Sep 2019 18:01:59 +0000 (UTC)
Date:   Sun, 29 Sep 2019 23:31:57 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] git-gui--askyesno (mingw): use Git for Windows'
 icon, if available
Message-ID: <20190929180157.ogwmiaer4pjjduoj@yadavpratyush.com>
References: <pull.358.git.gitgitgadget@gmail.com>
 <6025b38d2659caa111d2e5e9a1fa48d47de0e827.1569511793.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6025b38d2659caa111d2e5e9a1fa48d47de0e827.1569511793.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since this is a git-gui dialog/prompt, why not use the git-gui icon? 
This will mean some uniformity between all the platforms (though I'm not 
sure if other platforms even use GIT_ASK_YESNO). It would also probably 
save you the hacks needed to find out the git-for-windows icon.

Well, there is the problem that the git-gui logo is not in any external 
file, and is inside git-gui.sh (as a vector image, but I'm not sure). 
But I'd like to at least start some discussion in this direction.

On 26/09/19 08:30AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> For additional GUI goodness.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-gui--askyesno | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/git-gui--askyesno b/git-gui--askyesno
> index 45b0260eff..c0c82e7cbd 100755
> --- a/git-gui--askyesno
> +++ b/git-gui--askyesno
> @@ -52,5 +52,17 @@ proc yes {} {
>  	exit 0
>  }
>  
> +if {$::tcl_platform(platform) eq {windows}} {
> +	set icopath [file dirname [file normalize $argv0]]
> +	if {[file tail $icopath] eq {git-core}} {
> +		set icopath [file dirname $icopath]
> +	}
> +	set icopath [file dirname $icopath]
> +	set icopath [file join $icopath share git git-for-windows.ico]
> +	if {[file exists $icopath]} {
> +		wm iconbitmap . -default $icopath
> +	}
> +}
> +
>  wm title . $title
>  tk::PlaceWindow .
> -- 
> gitgitgadget

-- 
Regards,
Pratyush Yadav

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013AF1F463
	for <e@80x24.org>; Sun, 29 Sep 2019 17:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfI2RnX (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 13:43:23 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:43457 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbfI2Rbk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 13:31:40 -0400
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 06549100005;
        Sun, 29 Sep 2019 17:31:37 +0000 (UTC)
Date:   Sun, 29 Sep 2019 23:01:35 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/4] git-gui--askyesno: allow overriding the window title
Message-ID: <20190929173135.3swz2canehtoxkcf@yadavpratyush.com>
References: <pull.358.git.gitgitgadget@gmail.com>
 <8cfc935cdba316f513f2408c1f39c5d68d5258fc.1569511793.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cfc935cdba316f513f2408c1f39c5d68d5258fc.1569511793.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One minor nitpick: please add a comment at the top of the file 
documenting the `--title` option, and the usage of the program in 
general.

Other than that, looks good. Thanks.

On 26/09/19 08:29AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> "Question?" is maybe not the most informative thing to ask. In the
> absence of better information, it is the best we can do, of course.
> 
> However, Git for Windows' auto updater just learned the trick to use
> git-gui--askyesno to ask the user whether to update now or not. And in
> this scripted scenario, we can easily pass a command-line option to
> change the window title.
> 
> So let's support that with the new `--title <title>` option.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-gui--askyesno | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/git-gui--askyesno b/git-gui--askyesno
> index cf9c990d09..45b0260eff 100755
> --- a/git-gui--askyesno
> +++ b/git-gui--askyesno
> @@ -12,10 +12,15 @@ if {$use_ttk} {
>  	set NS ttk
>  }
>  
> +set title "Question?"
>  if {$argc < 1} {
>  	puts stderr "Usage: $argv0 <question>"
>  	exit 1
>  } else {
> +	if {$argc > 2 && [lindex $argv 0] == "--title"} {

While this is probably not the most robust way of handling command line 
arguments, I guess it doesn't really make too much of a difference for 
something this simple.

> +		set title [lindex $argv 1]
> +		set argv [lreplace $argv 0 1]
> +	}
>  	set prompt [join $argv " "]
>  }
>  
> @@ -47,5 +52,5 @@ proc yes {} {
>  	exit 0
>  }
>  
> -wm title . "Question?"
> +wm title . $title
>  tk::PlaceWindow .
> -- 
> gitgitgadget
> 

-- 
Regards,
Pratyush Yadav

Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A89DC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 15:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58A5A206E5
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 15:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgKBPse (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 10:48:34 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:41203 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgKBPse (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 10:48:34 -0500
X-Originating-IP: 103.82.80.169
Received: from localhost (unknown [103.82.80.169])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 90BD61C0017;
        Mon,  2 Nov 2020 15:48:31 +0000 (UTC)
Date:   Mon, 2 Nov 2020 21:18:15 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] git-gui: Auto-rescan on activate
Message-ID: <20201102154815.4incizurpmdhhmjh@yadavpratyush.com>
References: <20201101170505.71246-1-stefan@haller-berlin.de>
 <20201101170505.71246-3-stefan@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101170505.71246-3-stefan@haller-berlin.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On 01/11/20 06:05PM, Stefan Haller wrote:
> Do an automatic rescan whenever the git-gui window receives focus. Most other
> GUI tools do this, and it's very convenient; no more pressing F5 manually.
> 
> People who don't like this behavior can turn it off using
> "git config gui.autorescan false".
> 
> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
> ---
>  git-gui.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 8864c14..4a4ac19 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -906,6 +906,7 @@ set font_descs {
>  }
>  set default_config(gui.stageuntracked) ask
>  set default_config(gui.displayuntracked) true
> +set default_config(gui.autorescan) true

Default to false. See my reply to the cover letter for more info.

It would also be a good idea to include an option for this in the 
options dialog. Check do_options in lib/options.tcl for examples.

>  
>  ######################################################################
>  ##
> @@ -4020,6 +4021,10 @@ bind .   <Alt-Key-2> {focus_widget $::ui_index}
>  bind .   <Alt-Key-3> {focus $::ui_diff}
>  bind .   <Alt-Key-4> {focus $::ui_comm}
>  
> +if {[is_config_true gui.autorescan]} {
> +	bind .   <FocusIn>  schedule_rescan
> +}
> +

Ok.

>  set file_lists_last_clicked($ui_index) {}
>  set file_lists_last_clicked($ui_workdir) {}
>  
> -- 
> 2.29.2
> 

-- 
Regards,
Pratyush Yadav

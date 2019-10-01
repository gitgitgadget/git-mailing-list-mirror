Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85A8D1F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 14:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389137AbfJAOYF (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 10:24:05 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34389 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbfJAOYF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 10:24:05 -0400
X-Originating-IP: 1.186.12.44
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8FA10FF805;
        Tue,  1 Oct 2019 14:24:03 +0000 (UTC)
Date:   Tue, 1 Oct 2019 19:54:01 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] git-gui: use existing interface to query a path's
 attribute
Message-ID: <20191001142401.hhg5dtefj6qg66dd@yadavpratyush.com>
References: <97013a71289857767100d6a4adcb39ca99b2b21b.1569873171.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97013a71289857767100d6a4adcb39ca99b2b21b.1569873171.git.bert.wesarg@googlemail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I don't see any difference between v3 and v2 of this patch. What changed 
in this version?

On 30/09/19 09:54PM, Bert Wesarg wrote:
> Replace the hand-coded call to git check-attr with the already provided one.
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  lib/diff.tcl | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index 958a0fa..0fd4600 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -270,19 +270,6 @@ proc show_other_diff {path w m cont_info} {
>  	}
>  }
>  
> -proc get_conflict_marker_size {path} {
> -	set size 7
> -	catch {
> -		set fd_rc [eval [list git_read check-attr "conflict-marker-size" -- $path]]
> -		set ret [gets $fd_rc line]
> -		close $fd_rc
> -		if {$ret > 0} {
> -			regexp {.*: conflict-marker-size: (\d+)$} $line line size
> -		}
> -	}
> -	return $size
> -}
> -
>  proc start_show_diff {cont_info {add_opts {}}} {
>  	global file_states file_lists
>  	global is_3way_diff is_submodule_diff diff_active repo_config
> @@ -298,7 +285,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
>  	set is_submodule_diff 0
>  	set diff_active 1
>  	set current_diff_header {}
> -	set conflict_size [get_conflict_marker_size $path]
> +	set conflict_size [gitattr $path conflict-marker-size 7]
>  
>  	set cmd [list]
>  	if {$w eq $ui_index} {
> -- 
> 2.23.0.11.g242cf7f110
> 

-- 
Regards,
Pratyush Yadav

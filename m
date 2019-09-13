Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C0E1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 20:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbfIMUjK (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 16:39:10 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:59155 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387461AbfIMUjK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 16:39:10 -0400
Received: from localhost (unknown [1.186.12.20])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 949C8100003;
        Fri, 13 Sep 2019 20:39:07 +0000 (UTC)
Date:   Sat, 14 Sep 2019 02:09:04 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Subject: Re: [PATCH v4] git-gui: add horizontal scrollbar to commit buffer
Message-ID: <20190913203904.n2sdjczlfobfs2yr@yadavpratyush.com>
References: <20b0d8599099a412833af93f85e414fdc495dd76.1568405611.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20b0d8599099a412833af93f85e414fdc495dd76.1568405611.git.bert.wesarg@googlemail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the re-roll. Will queue.

On 13/09/19 10:16PM, Bert Wesarg wrote:
> While the commit message widget has a configurable fixed width, it
> nevertheless allowed to write commit messages which exceeded this limit.
> Though there is no visual clue, that there is scrolling going on. Now
> there is a horizontal scrollbar.
> 
> There seems to be a bug in at least Tcl/Tk up to version 8.6.8, which
> does not update the horizontal scrollbar if one removes the whole
> content at once.
> 
> Suggested-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  git-gui.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/git-gui.sh b/git-gui.sh
> index 5bc21b8..ad962d4 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3363,10 +3363,16 @@ ttext $ui_comm -background white -foreground black \
>  	-relief sunken \
>  	-width $repo_config(gui.commitmsgwidth) -height 9 -wrap none \
>  	-font font_diff \
> +	-xscrollcommand {.vpane.lower.commarea.buffer.frame.sbx set} \
>  	-yscrollcommand {.vpane.lower.commarea.buffer.frame.sby set}
> +${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sbx \
> +	-orient horizontal \
> +	-command [list $ui_comm xview]
>  ${NS}::scrollbar .vpane.lower.commarea.buffer.frame.sby \
> +	-orient vertical \
>  	-command [list $ui_comm yview]
>  
> +pack .vpane.lower.commarea.buffer.frame.sbx -side bottom -fill x
>  pack .vpane.lower.commarea.buffer.frame.sby -side right -fill y
>  pack $ui_comm -side left -fill y
>  pack .vpane.lower.commarea.buffer.header -side top -fill x
> -- 
> 2.21.0.789.ga095d9d866
> 

-- 
Regards,
Pratyush Yadav

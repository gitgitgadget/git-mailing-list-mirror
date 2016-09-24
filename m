Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A261F935
	for <e@80x24.org>; Sat, 24 Sep 2016 18:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934852AbcIXSWd (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 14:22:33 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:53370 "EHLO bsmtp4.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932768AbcIXSWc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 14:22:32 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp4.bon.at (Postfix) with ESMTPSA id 3shJVY5xfrz5tlJ;
        Sat, 24 Sep 2016 20:22:29 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id A5E885326;
        Sat, 24 Sep 2016 20:22:28 +0200 (CEST)
Subject: Re: [PATCH] git-gui: stop using deprecated merge syntax
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cbb1815e-0ebc-e103-927e-14d7d038245a@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Junio C Hamano <gitster@pobox.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a5b001fd-3ba2-bcc0-2104-eb630796ab09@kdbg.org>
Date:   Sat, 24 Sep 2016 20:22:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <cbb1815e-0ebc-e103-927e-14d7d038245a@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.09.2016 um 13:30 schrieb René Scharfe:
> Starting with v2.5.0 git merge can handle FETCH_HEAD internally and
> warns when it's called like 'git merge <message> HEAD <commit>' because
> that syntax is deprecated.  Use this feature in git-gui and get rid of
> that warning.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Tested only _very_ lightly!
>
>  git-gui/lib/merge.tcl | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/git-gui/lib/merge.tcl b/git-gui/lib/merge.tcl
> index 460d32f..5ab6f8f 100644
> --- a/git-gui/lib/merge.tcl
> +++ b/git-gui/lib/merge.tcl
> @@ -112,12 +112,7 @@ method _start {} {
>  	close $fh
>  	set _last_merged_branch $branch
>
> -	set cmd [list git]
> -	lappend cmd merge
> -	lappend cmd --strategy=recursive
> -	lappend cmd [git fmt-merge-msg <[gitdir FETCH_HEAD]]
> -	lappend cmd HEAD
> -	lappend cmd $name
> +	set cmd [list git merge --strategy=recursive FETCH_HEAD]
>
>  	ui_status [mc "Merging %s and %s..." $current_branch $stitle]
>  	set cons [console::new [mc "Merge"] "merge $stitle"]
>

Much better than my version. I had left fmt-merge-msg and added --no-log 
to treat merge.log config suitably. But this works too, and is much more 
obvious.

Tested-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863181F461
	for <e@80x24.org>; Tue, 20 Aug 2019 19:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfHTTV5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 15:21:57 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:57207 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbfHTTV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 15:21:57 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46Cgdv6fb3z5tlC;
        Tue, 20 Aug 2019 21:21:55 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8704A2146;
        Tue, 20 Aug 2019 21:21:55 +0200 (CEST)
Subject: Re: [PATCH 2/3] git-gui: Add the ability to revert selected lines
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Newsgroups: gmane.comp.version-control.git
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190819214110.26461-3-me@yadavpratyush.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <73e63382-4f79-cfd0-47f4-812f9cd4f88b@kdbg.org>
Date:   Tue, 20 Aug 2019 21:21:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819214110.26461-3-me@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.08.19 um 23:41 schrieb Pratyush Yadav:
> Just like the user can select lines to stage or unstage, add the
> ability to revert selected lines.
> 
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>

> +	if {$revert} {
> +		set query "[mc "Revert changes in file %s?" \
> +			[short_path $current_diff_path]]
> +
> +[mc "The selected lines will be permanently lost by the revert."]"
> +
> +		set reply [revert_dialog $query]

Please don't do this. This confirmation dialog is unacceptable in my
workflow. I use reversals of hunks and lines frequently, almost like a
secondary code editor. My safety net is the undo function of the IDE,
which works across reloads that are triggered by these external edits.
These confirmations get in the way.

> +		if {$reply ne 1} {
> +			unlock_index
> +			return
> +		}
> +	}
> +
>  	set wholepatch {}
>  
>  	while {$first_l < $last_l} {
> 

-- Hannes

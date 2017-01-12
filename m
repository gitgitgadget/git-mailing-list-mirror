Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04B8020756
	for <e@80x24.org>; Thu, 12 Jan 2017 06:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750790AbdALG11 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 01:27:27 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:9674 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbdALG1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 01:27:25 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3tzbQg3XWSz5tlM;
        Thu, 12 Jan 2017 07:27:23 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id B81A33B5;
        Thu, 12 Jan 2017 07:27:22 +0100 (CET)
Subject: Re: [PATCH 2/2] Use 'env' to find perl instead of fixed path
To:     Pat Pannuto <pat.pannuto@gmail.com>
References: <20170112055140.29877-1-pat.pannuto@gmail.com>
 <20170112055140.29877-3-pat.pannuto@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     gitster@pobox.com, git@vger.kernel.org
Message-ID: <6fe462dd-929a-671b-a210-36ee38e99115@kdbg.org>
Date:   Thu, 12 Jan 2017 07:27:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170112055140.29877-3-pat.pannuto@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.01.2017 um 06:51 schrieb Pat Pannuto:
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index cf6fc926a..6d7b6c35d 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1,4 +1,4 @@
> -#!/usr/bin/perl
> +#!/usr/bin/env perl

This change, and all others that affect installed external git programs, 
is a no-go. On Windows, our execve emulation is not complete. It would 
invoke only `env` (looked up in PATH), but not pass 'perl' as argument.

Sorry for the bad news.

I would have suggested to set PERL_PATH in your config.mak, but that 
does not change the generated perl scripts, I think. Perhaps you should 
implement that?

I'm not thrilled about your changes to the test scripts, but I do not 
expect that they break on Windows.

-- Hannes


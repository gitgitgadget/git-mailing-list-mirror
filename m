Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2F7A1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 18:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935443AbeAKSVo (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 13:21:44 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:59942 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934462AbeAKSVo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 13:21:44 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zHZ2s4zRfz5tlD;
        Thu, 11 Jan 2018 19:21:41 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1264141FD;
        Thu, 11 Jan 2018 19:21:41 +0100 (CET)
Subject: Re: [PATCH] run-command.c: print env vars when GIT_TRACE is set
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20180110104835.22905-1-pclouds@gmail.com>
 <20180111100734.GA17274@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <efacd948-0984-ef83-c249-b4139f61a519@kdbg.org>
Date:   Thu, 11 Jan 2018 19:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180111100734.GA17274@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.01.2018 um 11:07 schrieb Jeff King:
> The output for a single command is pretty shell-like due to the quoting:
> 
>    $ GIT_TRACE=1 ./git upload-pack . >/dev/null
>    [...]run_command: 'git-upload-pack' '.'
> 
> You could copy and paste that to a shell if you wanted.  And with
> environment variables, that remains so:
> 
>    $ GIT_TRACE=1 ./git ls-remote https://github.com/git/git >/dev/null
>    [...]run_command: 'GIT_DIR=.git' 'git-remote-https' 'https://[...]'

Not quite, though. For variable assignments to be recognized as such, 
the name and equal sign must not be quoted:

   GIT_DIR='.git' 'git-remote-https' 'https://[...]'

-- Hannes

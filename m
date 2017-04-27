Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96AF71FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 05:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbdD0FHe (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 01:07:34 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:55438 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbdD0FHc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 01:07:32 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wD4h24GqDz5tlN;
        Thu, 27 Apr 2017 07:07:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id E810F1C7;
        Thu, 27 Apr 2017 07:07:29 +0200 (CEST)
Subject: Re: [PATCH 07/15] remote.c: report error on failure to fopen()
To:     Junio C Hamano <gitster@pobox.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170420112609.26089-8-pclouds@gmail.com>
 <3a2686c2-6766-1235-001f-1b5283b5f408@kdbg.org>
 <xmqqwpa6pt0b.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4ef2fe61-720c-6227-11b4-4a6be24a4918@kdbg.org>
Date:   Thu, 27 Apr 2017 07:07:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqwpa6pt0b.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.2017 um 02:57 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> +++ git ls-remote 'refs*master'
>> +warning: unable to access '.git/branches/refs*master': Invalid argument
>>  fatal: 'refs*master' does not appear to be a git repository
>>  fatal: Could not read from remote repository.
>>
>>  Please make sure you have the correct access rights
>>  and the repository exists.
>> +++ exit_code=128
>>
>> On Windows, it is not allowed to pass a file name with an asterisk to
>> the OS. The test case contains this comment:
>>
>> # We could just as easily have used "master"; the "*" emphasizes its
>> # role as a pattern.
>>
>> So, can we replace the name with a simple "master", our would this
>> miss the goal of the test case? Should we make it conditional on the
>> MINGW prerequisite?
>
> I would actually be more worried about the real-life impact of this
> change.  Those who did "git ls-remote 'refs*master'" merely got "it
> does not appear to be a git repository" and that was entirely sensible
> response from the command.  Can Windows folks live with an extra
> warning before it, or do they object to see that new warning?

I was also worried that the new warning may be irritating. However, I 
expect that it is seen in practice only after a typo. My gut feeling is 
that this is bearable, because the reason for the warning should be obvious.

Unless a use-case turns up where the pattern occurs routinely. We'll 
have to keep the eyes open. Until then it is better to keep the change, IMO.

-- Hannes


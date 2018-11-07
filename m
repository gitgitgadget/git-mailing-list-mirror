Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C96191F453
	for <e@80x24.org>; Wed,  7 Nov 2018 21:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeKHHJK (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 02:09:10 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:31282 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbeKHHJK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 02:09:10 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42r09d195bz5tml;
        Wed,  7 Nov 2018 22:36:53 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 68687265;
        Wed,  7 Nov 2018 22:36:52 +0100 (CET)
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.66.git.gitgitgadget@gmail.com>
 <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
 <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org>
 <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
 <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org>
 <20181107204142.GA30078@sigill.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e7ff6f22-fe5a-3cca-9305-2c8a6fb55d45@kdbg.org>
Date:   Wed, 7 Nov 2018 22:36:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107204142.GA30078@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.11.18 um 21:41 schrieb Jeff King:
> On Wed, Nov 07, 2018 at 07:52:28PM +0100, Johannes Sixt wrote:
>> Do I understand correctly, that you use a leading slash as an indicator to
>> construct a path relative to system_path(). How about a "reserved" user
>> name? For example,
>>
>>    [http] sslcert = ~system_path/what/ever
>>
>> although a more unique name, perhaps with some punctuation, may be
>> desirable.
> 
> It's syntactically a bit further afield, but something like:
> 
>    [http]
>    sslcert = $RUNTIME_PREFIX/what/ever
> 
> would make sense to me, and is a bit less subtle than the fake user. I
> don't know if that would confuse people into thinking that we
> interpolate arbitrary environment variables, though.

The expansion of a fake user name would have to go in 
expand_user_path(), a fake variable name would have to be expanded 
elsewhere. Now, Dscho mentions in the cover letter that his patch has 
already seen some field testing ("has been 'in production' for a good 
while"). So, we have gained some confidence that the point where the 
substitution happens, in expand_user_path(), is suitable. Therefore, I 
have slight preference for a fake user.

-- Hannes

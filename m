Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190B31F453
	for <e@80x24.org>; Wed,  7 Nov 2018 18:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeKHEYJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 23:24:09 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:25336 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbeKHEYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 23:24:09 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 42qwWw5MMGz5tmh;
        Wed,  7 Nov 2018 19:52:28 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 73D71130;
        Wed,  7 Nov 2018 19:52:28 +0100 (CET)
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.66.git.gitgitgadget@gmail.com>
 <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
 <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org>
 <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <efd57458-07f6-2813-483b-dc7fba785dc0@kdbg.org>
Date:   Wed, 7 Nov 2018 19:52:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.11.18 um 12:23 schrieb Johannes Schindelin:
> On Tue, 6 Nov 2018, Johannes Sixt wrote:
> 
>> Am 06.11.18 um 15:53 schrieb Johannes Schindelin via GitGitGadget:
>> Even if a path looks like a POSIX paths, i.e. it starts with a directory
>> separator, but not with drive-letter-colon, it still has a particular meaning,
>> namely (as far as I know) that the path is anchored at the root of the drive
>> of the current working directory.
>>
>> If a user specifies such a path on Windows, and it must undergo
>> expand_user_path(), then that is a user error, or the user knows what they are
>> doing.
>>
>> I think it is wrong to interpret such a path as relative to some random other
>> directory, like this patch seems to do.
> 
> Okay, now we know everything you find wrong with the current patch. Do you
> have any suggestion how to make it right? I.e. what would you suggest as a
> way to specify in a gitconfig in a portable Git where the certificate
> bundle is?

Ah, so your actual problem is quite a different one!

Do I understand correctly, that you use a leading slash as an indicator 
to construct a path relative to system_path(). How about a "reserved" 
user name? For example,

   [http] sslcert = ~system_path/what/ever

although a more unique name, perhaps with some punctuation, may be 
desirable.

-- Hannes

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53F41F453
	for <e@80x24.org>; Sat,  9 Feb 2019 18:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfBISTO (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 13:19:14 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:28547 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfBISTO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 13:19:14 -0500
Received: from [192.168.1.12] ([92.29.15.245])
        by smtp.talktalk.net with SMTP
        id sXDcgd8GIwhzSsXDcghP6z; Sat, 09 Feb 2019 18:19:12 +0000
X-Originating-IP: [92.29.15.245]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=9anTPZJWX8pnfAL1p5p6vw==:117
 a=9anTPZJWX8pnfAL1p5p6vw==:17 a=IkcTkHD0fZMA:10 a=aulWLQ49AAAA:20
 a=anyJmfQTAAAA:8 a=hwrZGPZov635JRgfEEYA:9 a=QEXdDO2ut3YA:10
 a=YJ_ntbLOlx1v6PCnmBeL:22
Subject: Re: Possible minor bug in Git
To:     =?UTF-8?Q?Giuseppe_Crin=c3=b2?= <giuscri@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>, tboegi@web.de,
        angelomelonas@gmail.com, git@vger.kernel.org
References: <20190202063828.4kjtdmrsm7g4eyg3@tb-raspi4>
 <20190206221759.338-1-g@evil.localdomain>
 <nycvar.QRO.7.76.6.1902072040360.41@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <788eefef-f677-f0ce-7e02-dd85b11da78a@iee.org>
Date:   Sat, 9 Feb 2019 18:19:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1902072040360.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfHZL3KzKl0J+UMKYTP9Wq59WPPel7PcRSS3aWR/tZSPsx3SG4sOXGt3r1DLPK/vVlPE6NtxXh6euK1RAradRVB5kB2LSJ/VSSktLib3vf6acyek+M7j/
 7mHWHNz2NmmqTbdXU8G8ApABUuOgCL24kkszyN1c5EOZ4Jdftt3qjKjFsKTup6FAmJzht4pbusNqLPvDM/B+RRn1zt946gkk5HhNypHmZVqXIff9LqEiyvB8
 mZp17d1d5TnYFCE56rTtvk9GYUPIzf9uVZmhqiXfKgErJEVlWyiHttoxd+cSATFq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Guiseppe,

On 07/02/2019 19:41, Johannes Schindelin wrote:
> Hi Giuseppe,
>
> On Wed, 6 Feb 2019, Giuseppe Crinò wrote:
>
>> I wanted to have a look at the bug, and I can correctly reproduce it using version 2.20.1.windows.1.

Thank you for having a look.

The root cause of the issues will most probably be use of a case 
insensitive file system on Windows (and Mac). There is a configuration 
flag `core.ignoreCase` [1] that is normally auto detected that can be 
used to decide when the checks should be done and advice [2] or warnings 
given.


There are also similar case issues with branch names should you want to 
go that far. In any case you should probably at least cover the full 
utf-8 filenames, not just ascii ones.

>>
>> To start to even think of fixing this bug I need to build the source for Windows, but I got lost on how to do that.
> Does this help?
>
> https://github.com/git-for-windows/git/wiki/Building-Git
>
> Ciao,
> Johannes
>
>> Is it correct that I should cross-compile from a POSIX system (GNU/Linux), using x86_64-w64-mingw32-gcc and Gnulib to produce a static executable?
>>
>> Am I missing something? How does people here build for Windows?
>>
>> Giuseppe

--

Philip

[1] https://git-scm.com/docs/git-config#git-config-coreignoreCase

[2] https://git-scm.com/docs/git-config#git-config-advice


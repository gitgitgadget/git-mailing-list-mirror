Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EF871F453
	for <e@80x24.org>; Sat,  3 Nov 2018 23:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeKDJJT (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 04:09:19 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:45643 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeKDJJT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 04:09:19 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Nov 2018 04:09:19 EST
Received: from [192.168.1.12] ([92.29.15.216])
        by smtp.talktalk.net with SMTP
        id J5eNgd8QXoI6LJ5eNgoHTU; Sat, 03 Nov 2018 23:48:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1541288899;
        bh=PLlfdn5ODf9YMcfHeYl6yXkQN1iHHhjfdOYV18I/aDU=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=jX1qNwjSfn1nvwZme9qv7gmwpUQaqrtXKt7XlU6Deov7pvRn9B6HzE8cAYrHuqA2W
         kfSeLOWrdmXZu1HoxuTMU41Ps57je76dHDQpUXUMNDcVZib0lfOacGkyO+g52ieJb2
         Syw/JKz1yRLZ8ZSfIOLBVsCXdIibanW2zw/gQGn0=
X-Originating-IP: [92.29.15.216]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=nW19o/PZ5qZJ0p49dqPFUw==:117
 a=nW19o/PZ5qZJ0p49dqPFUw==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=4X8ON4D8JfOxqGHsgTAA:9 a=QEXdDO2ut3YA:10
Subject: Re: Git Slowness on Windows w/o Internet
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Peter Kostyukov <peter.kostyukov@kohls.com>,
        git@vger.kernel.org
References: <CAEL6bLrY5OgsjrZSSHDfYgrjefninR4wuZhGCsop_f-HCH7Jmg@mail.gmail.com>
 <20181103164423.GE731755@genre.crustytoothpaste.net>
From:   Philip Oakley <philipoakley@talktalk.net>
Message-ID: <4b32622b-e600-44b4-e1f7-0713d4839a86@talktalk.net>
Date:   Sat, 3 Nov 2018 23:48:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181103164423.GE731755@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFHHiB7MqLobiznstkvza/xdq40qHykFAVDi3YlR/wbP7cJNzKzl4OH/fluz7rYGiGLcp98L5UK1P+GNSUGzIdBXJpCBab/wjRNySryGFoXi6aFRXIY1
 Q8Y1MYfVEofpHUQdZWSqqaqdDJ1D2O9TxD/ckQgXAb0dWILDu3BIlaic826cgdPZ8ZihDff5Vy1izCeN4pVgqTYPESfsNgqgfJFLq4sXLaruJcpAwxADda87
 Egjfnb1ai2Qw7na2/EZQQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 03/11/2018 16:44, brian m. carlson wrote:
> On Fri, Nov 02, 2018 at 11:10:51AM -0500, Peter Kostyukov wrote:
>> Wanted to bring to your attention an issue that we discovered on our
>> Windows Jenkins nodes with git scm installed (git.exe). Our Jenkins
>> servers don't have Internet access. It appears that git.exe is trying
>> to connect to various Cloudflare and Akamai CDN instances over the
>> Internet when it first runs and it keeps trying to connect to these
>> CDNs every git.exe execution until it makes a successful attempt. See
>> the screenshot attached with the details.
>>
>> Enabling Internet access via proxy fixes the issue and git.exe
>> continues to work fast on the next attempts to run git.exe
>>
>> Is there any configuration setting that can disable this git's
>> behavior or is there any other workaround without allowing Internet
>> access? Otherwise, every git command run on a server without the
>> Internet takes about 30 seconds to complete.
> 
> Git itself doesn't make any attempt to access those systems unless it's
> configured to do so (e.g. a remote is set up to talk to those systems
> and fetch or pull is used).
> 
> It's possible that you're using a distribution package that performs
> this behavior, say, to check for updates.  I'd recommend that you
> contact the distributor, which in this case might be Git for Windows,
> and see if they can tell you more about what's going on.  The URL for
> that project is at https://github.com/git-for-windows/git.
> 

The normal Git for Windows install includes an option to check for 
updates at a suitable rate. Maybe you are hitting that. It can be 
switched off.

-- 
Philip

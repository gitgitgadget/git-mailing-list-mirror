Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78721F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 10:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdBBKkJ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 2 Feb 2017 05:40:09 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:35996 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdBBKkI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 05:40:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id E1D7F1E2EAB;
        Thu,  2 Feb 2017 11:40:03 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vukLW64mgEFW; Thu,  2 Feb 2017 11:40:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 300071E3097;
        Thu,  2 Feb 2017 11:40:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HLHlC8E8FkxE; Thu,  2 Feb 2017 11:40:02 +0100 (CET)
Received: from [192.168.178.72] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id B10AA1E3091;
        Thu,  2 Feb 2017 11:40:01 +0100 (CET)
Subject: Re: [PATCH v2 7/7] completion: recognize more long-options
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <74ecd09c-55da-3858-5187-52c286a6bf62@kdbg.org>
 <20170127211703.24910-1-cornelius.weig@tngtech.com>
 <20170127211703.24910-2-cornelius.weig@tngtech.com>
 <CAM0VKj=Ein4yrKG2aZnN7JU80ctZBQromcR6BEu-TyMLenLFCg@mail.gmail.com>
 <2841d2de-32ad-eae8-6039-9251a40bb00e@tngtech.com>
 <CAM0VKjkAnsT_LE4OZRkLPuiEZW88P7_OBbOw0XovHhLYfBhbwg@mail.gmail.com>
Cc:     j6t@kdbg.org, Shawn Pearce <spearce@spearce.org>,
        git@vger.kernel.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <415570bf-7201-3b68-4c91-668741d50160@tngtech.com>
Date:   Thu, 2 Feb 2017 11:40:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAM0VKjkAnsT_LE4OZRkLPuiEZW88P7_OBbOw0XovHhLYfBhbwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/02/2017 03:00 AM, SZEDER Gábor wrote:
>> Personally, I agree with you that
>>> Adding more long options that git commands learn along the way is
>>> always an improvement.
>> However, people may start complaining that their terminal becomes too
>> cluttered when doing a double-Tab. In my cover letter, I go to length
>> about this. My assumption was that all options that are mentioned in the
>> introduction of the command man-page should be important enough to have
>> them in the completion list.
> 
> But that doesn't mean that the ones not mentioned in the synopsis
> section are not worth completing.

Absolutely. What I meant is that at least the options from the synopsis
should be contained in the set of completable options.

>> Btw, I haven't found that non-destructive options should not be eligible
>> for completion. To avoid confusion about this in the future, I suggest
>> to also change the documentation:
>>
>> index 933bb6e..96f1c7f 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -13,7 +13,7 @@
>>  #    *) git email aliases for git-send-email
>>  #    *) tree paths within 'ref:path/to/file' expressions
>>  #    *) file paths within current working directory and index
>> -#    *) common --long-options
>> +#    *) common non-destructive --long-options
> 
> I don't mind such a change, but I don't think that list was ever meant
> to be comprehensive or decisive.  It is definitely not the former, as
> it's missing several things that the completion script does support.
> OTOH, it talks about .git/remotes, which has been considered legacy
> for quite some years (though it's right, because the completion script
> still supports it).

Then let's not do that change, because for some commands destructive
long-options have been in the list of completed options for quite a
while. Given that, the above change of the documentation, might stir up
more confusion than it settles.

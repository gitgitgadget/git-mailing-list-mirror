Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED8BA1F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 09:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750947AbdBBJk6 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 2 Feb 2017 04:40:58 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:29692 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbdBBJk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 04:40:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 379B41E2FA4;
        Thu,  2 Feb 2017 10:40:54 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id h8M0tn7nRAQR; Thu,  2 Feb 2017 10:40:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id DCA951E2EAB;
        Thu,  2 Feb 2017 10:40:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sQyXfHhDInmZ; Thu,  2 Feb 2017 10:40:53 +0100 (CET)
Received: from [192.168.178.72] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 7EE7C1E2FA4;
        Thu,  2 Feb 2017 10:40:53 +0100 (CET)
Subject: Re: [PATCH 4/7] completion: teach ls-remote to complete options
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20170202014014.25878-1-szeder.dev@gmail.com>
Cc:     bitte.keine.werbung.einwerfen@googlemail.com,
        thomas.braun@virtuell-zuhause.de, john@keeping.me.uk,
        git@vger.kernel.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <603697da-c8e9-5644-e0f0-7ee265c069d8@tngtech.com>
Date:   Thu, 2 Feb 2017 10:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170202014014.25878-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/02/2017 02:40 AM, SZEDER Gábor wrote:
> 
>> ls-remote needs to complete remote names and its own options.
> 
> And refnames, too.

Yes, right. However, do you think it is reasonable to complete remote
refnames? I don't think so, because it would mean we would have to run
ls-remote during completion -- and waiting for ls-remote could be quite
lengthy.

>> In
>> addition to the existing remote name completions, do also complete
>> the options --heads, --tags, --refs, and --get-url.
> 
> Why only these four options and not the other four?
> 
> There are eight options in total here, so there is really no chance
> for cluttered terminals, and all eight are mentioned in the synopsis.

My line of thought is the following:

--quiet: does not print anything and is therefore only useful for
scripting. Thus, there is no need to have it on the command line completion.

--exit-code: has no visible effect and is only useful for scripting.

--upload-pack: is really exotic. Nobody will ever use it without digging
deep in the manuals. Therefore, I think it's unnecessary to have the
option completable.


--symref: Should probably be added, thanks.

However, if you don't find my reasoning for omitting the three options
above conclusive, I have no problem including them.

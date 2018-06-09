Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF001F403
	for <e@80x24.org>; Sat,  9 Jun 2018 06:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbeFIG4D (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 02:56:03 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:47376 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753169AbeFIG4C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 02:56:02 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 412qmx09r4z5tlK;
        Sat,  9 Jun 2018 08:56:00 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6ADFB3B5;
        Sat,  9 Jun 2018 08:56:00 +0200 (CEST)
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff King <peff@peff.net>, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <20180608090758.GA15112@sigill.intra.peff.net>
 <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de>
 <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
 <87fu1w53af.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <900a34bb-4d8b-4a22-a0f5-1d2f6df84945@kdbg.org>
Date:   Sat, 9 Jun 2018 08:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87fu1w53af.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.06.2018 um 00:20 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Fri, Jun 08 2018, Johannes Sixt wrote:
> 
>> Am 08.06.2018 um 18:00 schrieb Thomas Braun:
>>> I for my part would much rather prefer that to be a compile time
>>> option so that I don't need to check on every git update on windows
>>> if  this is now enabled or not.
>>
>> This exactly my concern, too! A compile-time option may make it a good
>> deal less worrisome.
> 
> Can you elaborate on how someone who can maintain inject malicious code
> into your git package + config would be thwarted by this being some
> compile-time option, wouldn't they just compile it in?

Of course they can. But would we, the Git community do that?

 From the design document:

 > The goal of the telemetry feature is to be able to gather usage data
 > across a group of production users to identify real-world performance
 > problems in production.  Additionally, it might help identify common
 > user errors and guide future user training.

The goal to gather usage data may be valid for a small subset of Git 
installations. But it is wrong to put this into the software itself, in 
particular when the implementations includes scary things like loading 
unspecified dynamic libraries:

 > If the config setting "telemetry.plugin" contains the pathname to a
 > shared library, the library will be dynamically loaded during start up
 > and events will be sent to it using the plugin API.

When you want usage data, ask your users for feedback. Look over their 
shoulders. But do not ask the software itself to gather usage data. It 
will be abused.

Do not offer open source software that has a "call-home" method built-in.

If you want to peek into the workplaces of YOUR users, then monkey-patch 
survaillance into YOUR version of Git. But please do not burden the rest 
of us.

-- Hannes

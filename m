Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D411F597
	for <e@80x24.org>; Tue, 24 Jul 2018 18:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbeGXTep (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 15:34:45 -0400
Received: from s019.cyon.net ([149.126.4.28]:57150 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388534AbeGXTep (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 15:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tf4CmxxLJs1D91Y0dbPF7joS9mjor4niyocAxF5Cp1s=; b=hN8A+vRD+6f2ClwbYvd/pgHnSK
        a6LJ/Ot8WUL45Y9YX4cdHoNwQF+jDB1k5hHATgxJSv6OlEr8oh4/paTJtEdIhr29KLCvKSmQc/Y09
        1RpfjV7+KFu6tn6o3Z67ERBaE/x4avFkmviVTlBUCktU01aR6vQ95ekBFgJP2SlWkCVlmCD3ZlhJq
        bna8jKteB9ziiaD3Au9lR4RJmv0wXPfmFSmmqOxLzRQomax8zitV2OrMeyNjcxM+SdFazizFEgRMm
        WEK4BqWG3g1Zc7Y2f9pZ6FIHg6azRYyxcHov81FQ9a+02MnDaZDX4Y1Y4SMb7uZIScIHvzrMMudm+
        I4kSTF9w==;
Received: from [10.20.10.232] (port=29630 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1fi21L-00A3rV-3K; Tue, 24 Jul 2018 20:26:52 +0200
Subject: Re: [PATCH v1] config.c: fix msvc compile error
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, peff@peff.net,
        me@ttaylorr.com, Jeff Hostetler <jeffhost@microsoft.com>
Newsgroups: gmane.comp.version-control.git
References: <20180724153010.6693-1-git@jeffhostetler.com>
 <235ae68c-f764-ba3a-c641-ef5f99507564@drbeat.li>
 <xmqqwotkxzn0.fsf@gitster-ct.c.googlers.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <8fd2fe53-ff42-5e21-a485-a38c97331b9c@drbeat.li>
Date:   Tue, 24 Jul 2018 20:26:50 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqwotkxzn0.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24.07.18 20:22, Junio C Hamano wrote:
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>> Hi Jeff
>>
>> On 24.07.18 17:30, git@jeffhostetler.com wrote:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> In commit fb0dc3bac135e9f6243bd6d293e8c9293c73b9cd code was added
>>> to builtin/config.c to define a new function and a forward declaration
>>> for an array of unknown size.  This causes a compile error under MSVC.
>>>
>>> Reorder the code to forward declare the function instead of the array.
>>
>> This was already fixed (differently) in
>> <20180705183445.30901-1-dev+git@drbeat.li>.
> 
> Thanks for saving me from having to dig the list archive myself.
> Yes, it is already applied to the tip of the topic that originally
> caused the breakage.
> 
Just a general question:

Is it OK to refer to patches on pu with the Message-ID, or would you
prefer the commit hash? The hash changes whenever you recreate pu,
doesn't it?

Beat

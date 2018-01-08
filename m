Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9622F1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 20:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeAHUEZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:04:25 -0500
Received: from siwi.pair.com ([209.68.5.199]:53343 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752471AbeAHUEY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 15:04:24 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EB39E844E5;
        Mon,  8 Jan 2018 15:04:23 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9E201844D4;
        Mon,  8 Jan 2018 15:04:21 -0500 (EST)
Subject: Re: [PATCH v4 0/4] Add --no-ahead-behind to status
To:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180108154822.54829-1-git@jeffhostetler.com>
 <7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8affe37c-d937-d7e0-fe06-cf7c8db173fa@jeffhostetler.com>
Date:   Mon, 8 Jan 2018 15:04:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <7b759564-5544-8845-0594-e8342a0b4ba5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/8/2018 2:49 PM, Ben Peart wrote:
> 
> 
> On 1/8/2018 10:48 AM, Jeff Hostetler wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> This is version 4 of my patch series to avoid expensive ahead/behind
>> calculations in status.  This version removes the last commit containing
>> the experimental config setting.  And removes the undefined return values
>> for the nr_ahead/nr_behind arguments as discussed on the mailing list.
> 
> While I like the simplicity of just turning this off completely, I do wonder if we could come up with a better user experience.  For example, could we somehow limit the time spent computing the before/after and if it exceeds that limit, drop back to saying they are "different" rather than computing the exact number of commits before/after.
> 
> I was thinking about something similar to the logic we use today about whether to start reporting progress on other long commands. That would mean you could still get the ahead/behind values if you aren't that far behind but would only get "different" if that calculation gets too expensive (which implies the actual value isn't going to be all that helpful anyway).


After a off-line conversation with the others I'm going to look into
a version that is limited to n commits rather than be completely on or
off.  I think if you are for example less than 100 a/b then those numbers
have value; if you are past n, then they have much less value.

I'd rather do it by a fixed limit than by time to ensure that output
is predictable on graph shape and not on system load.

Jeff

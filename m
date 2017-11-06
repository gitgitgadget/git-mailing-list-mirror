Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462D120A10
	for <e@80x24.org>; Mon,  6 Nov 2017 17:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753454AbdKFRcr (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 12:32:47 -0500
Received: from siwi.pair.com ([209.68.5.199]:12346 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753430AbdKFRcr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 12:32:47 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 58199844F2;
        Mon,  6 Nov 2017 12:32:46 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EAF76844F0;
        Mon,  6 Nov 2017 12:32:45 -0500 (EST)
Subject: Re: [PATCH 1/9] extension.partialclone: introduce partial clone
 extension
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20171102202052.58762-1-git@jeffhostetler.com>
 <20171102202052.58762-2-git@jeffhostetler.com>
 <20171102152427.32544b3d6149e7a7bfe840c8@google.com>
 <1db01a45-85c4-6243-c43f-9f5e50e9a6a8@jeffhostetler.com>
 <20171103113919.396807c82dbfdecff7f19c41@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <99b7c61b-f8ab-43a0-0707-62ac1db4d080@jeffhostetler.com>
Date:   Mon, 6 Nov 2017 12:32:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171103113919.396807c82dbfdecff7f19c41@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/3/2017 2:39 PM, Jonathan Tan wrote:
> On Fri, 3 Nov 2017 09:57:18 -0400
> Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> On 11/2/2017 6:24 PM, Jonathan Tan wrote:
>>> On Thu,  2 Nov 2017 20:20:44 +0000
>>> Jeff Hostetler <git@jeffhostetler.com> wrote:
>>>
>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>>
>>>> Introduce the ability to have missing objects in a repo.  This
>>>> functionality is guarded by new repository extension options:
>>>>       `extensions.partialcloneremote` and
>>>>       `extensions.partialclonefilter`.
>>>
>>> With this, it is unclear what happens if extensions.partialcloneremote
>>> is not set but extensions.partialclonefilter is set. For something as
>>> significant as a repository extension (which Git uses to determine if it
>>> will even attempt to interact with a repo), I think - I would prefer
>>> just extensions.partialclone (or extensions.partialcloneremote, though I
>>> prefer the former) which determines the remote (the important part,
>>> which controls the dynamic object fetching), and have another option
>>> "core.partialclonefilter" which is only useful if
>>> "extensions.partialclone" is set.
>>
>> Yes, that is a point I wanted to ask about.  I renamed the
>> extensions.partialclone that you created and then I moved your
>> remote.<name>.blob-max-bytes setting to be in extensions too.
>> Moving it to core.partialclonefilter is fine.
> 
> OK - in that case, it might be easier to just reuse my first patch in
> its entirety. "core.partialclonefilter" is not used until the
> fetching/cloning part anyway.
> 

Good point.  I'll take a look at refactoring that.
If it looks like the result will be mostly/effectively
your original patches, I'll let you know and hand part 2
back to you.

> I agree that "core.partialclonefilter" (or another place not in
> "remote") instead of "remote.<name>.blob-max-bytes" is a good idea - in
> the future, we might want to reuse the same filter setting for
> non-fetching functionality.
> 

Jeff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4C861F428
	for <e@80x24.org>; Tue,  2 Jan 2018 21:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751049AbeABVOL (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 16:14:11 -0500
Received: from siwi.pair.com ([209.68.5.199]:10103 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbeABVOK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 16:14:10 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 408E4844DF;
        Tue,  2 Jan 2018 16:14:10 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E38F2844DE;
        Tue,  2 Jan 2018 16:14:09 -0500 (EST)
Subject: Re: [PATCH] status: handle worktree renames
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, alexmv@dropbox.com,
        git@vger.kernel.org
References: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
 <20171225103718.24443-1-pclouds@gmail.com>
 <b3e90960-d743-3299-ba43-150849b591d2@gmail.com>
 <20171226021150.GA10059@duynguyen.vn.dektech.internal>
 <xmqqh8scnip5.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3a8169b4-1d7f-35dc-eb23-49afdaa3bf52@jeffhostetler.com>
Date:   Tue, 2 Jan 2018 16:14:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqh8scnip5.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/27/2017 1:12 PM, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
>> Or we disable rename-from-worktree when porcelain v2 is requested (and
>> optionally introduce v3 to support it). Jeff, any preference?

Sorry for the delay, I was on vacation last week.

I like the "R." and ".R" lines in your 3rd patch series as that keeps
porcelain V2 output consistent with the changes that you added to plain
and porcelain V1 output.  All 3 formats now report 2 types of renames.
Having a "RR" line would be more consistent with a "MM" line, but I
don't think that happens often enough to define a porcelain V3 format
with a 3 path row variant.

I like that we can now show "unstaged renames" (in all 3 formats)
as I think that is less confusing to the novice user than a
new-file/delete pair.


Having said that, I am a little concerned about us changing V1 and
V2 output at all -- we are breaking the porcelain contract we have
with scripts.  I like the change, so I'm not bothered about it, but
others may think differently.


Also, does this introduce any new cases for reporting conflicts?
I haven't really thought about it too much yet, but if there was a
divergent rename in both branches of a merge, do we now have to handle
showing possibly 4 pathnames for a file?  (merge-base, branch-a,
branch-b, worktree)

Jeff



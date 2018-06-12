Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4658D1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 09:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754300AbeFLJpo (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 05:45:44 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:8274 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754285AbeFLJpm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 05:45:42 -0400
Received: from [192.168.2.201] ([92.22.39.132])
        by smtp.talktalk.net with SMTP
        id SfrwfzN0ZwhzSSfrwfj6jv; Tue, 12 Jun 2018 10:45:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1528796741;
        bh=ue3J+Bpvm4ZFD9S+9Hz/IRhMt86M4kRYAWj1q0w+ltM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ERNwVf1ID61rVOZKXWny/ILS7KWNrfjn5h/YJ44/H4WH6yM+Mu0VopEWq2Xfb1xFw
         bOEUDPrOasRBf/HGCJ/xYcpa2t9Uex6NvzICzWcBF1jR3tpFh+lV6TjUiU6otjd3+s
         vuLsjNpeHyRwdYXd8aDxMHGFu8bnrmQeKnRrn4SM=
X-Originating-IP: [92.22.39.132]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=AATg4WxWBR3MjRzlB3y0Ow==:117
 a=AATg4WxWBR3MjRzlB3y0Ow==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=8__YJ5Aconm0Pyo4UPkA:9 a=y6thIPH-TIgOBg5s:21 a=ho6wO-8DwiqhP-BH:21
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] git-rebase: error out when incompatible options
 passed
To:     Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050654.19663-1-newren@gmail.com>
 <20180607050654.19663-2-newren@gmail.com>
 <cec770a8-28ee-d546-8c27-905d2fcdb0c8@talktalk.net>
 <CABPp-BF6HapQ=tcWu4j=L-sjgTRbdLnhYXBWwdWm+oThav_zJw@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <cd30ac59-4715-dc33-6de4-aa009134ac87@talktalk.net>
Date:   Tue, 12 Jun 2018 10:45:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF6HapQ=tcWu4j=L-sjgTRbdLnhYXBWwdWm+oThav_zJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMmOjrygc5EmuOyqZHU3V3P/kB50Y25WgdxfQkQaM/xyQDT29Ax/B8cTiAIn4sktFQLg7oYVE0uPG0VfwpOQWrqtjcBkOP1oW/6PX3dyyM2LuM4z1gAb
 am4JFFB0WeVkxfjOeqFKUetpcJY7pyJXunU3AIYyasoDwIzQP2aJBWDe9Qg2mTSEOgyUM2EpBVQCT8ClQ1HGNBayZXfSkfVdYoXp85jNrBxqxEOuM2TXlc9l
 LhCdrR5YPnunhJcM8QssoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/06/18 16:49, Elijah Newren wrote:
> Another thing I missed...
> 
> On Sun, Jun 10, 2018 at 12:40 PM, Phillip Wood
> <phillip.wood@talktalk.net> wrote:
>> On 07/06/18 06:06, Elijah Newren wrote:
> 
>>> Some exceptions I left out:
>>>
>>>    * --merge and --interactive are technically incompatible since they are
>>>      supposed to run different underlying scripts, but with a few small
>>>      changes, --interactive can do everything that --merge can.  In fact,
>>>      I'll shortly be sending another patch to remove git-rebase--merge and
>>>      reimplement it on top of git-rebase--interactive.
>>
>> Excellent I've wondered about doing that but never got round to it. One
>> thing I was slightly concerned about was that someone maybe parsing the
>> output of git-rebase--merge and they'll get a nasty shock when that output
>> changes as a result of using the sequencer.
> 
> I can see the minor worry, but I think upon inspection it's not
> something that concerns me, for a few reasons:
> 
> In terms of use, given that rebase --merge was introduced to handle
> renames in mid-2006, but plain rebase has been able to handle them
> since late 2008 (though directory renames changes that again), the
> utility of rebase --merge has been somewhat limited.  I think that
> limits the exposure.  But to address the 'break' more directly...
> 
> If we were to agree that we needed to support folks parsing rebase
> output, that would be a really strict requirement that I think would
> prevent lots of fixes.  And if so, it's one we've violated a number of
> times.  For example, I certainly wasn't thinking about rebase when I
> modified messages in merge-recursive.c over the years, but they'd leak
> through for rebase --merge.  (Those messages would not leak through to
> rebase --interactive as much, since the sequencer sets o.buffer_output
> and then only conditionally shows the output.)  Also, changes that
> have occurred in the past, like adding 'git gc --auto' to rebase,
> modifying error messages directly found in git-rebase--merge.sh would
> have been considered breaks.
> 
> Finally, looking over all the differences in output while fixing up
> testcases makes me think we've done much less around designing the
> output based on what we want the user to see, and more around what
> minimal fixups can we do to these lower level commands that provide
> useful functionality to the user?  We linearize history differently
> for different rebase modes, have different entries in the reflog
> depending on which mode, and we often times implement features for
> just one mode and then sometimes add it to others.  In fact, I think
> the primary reason that am-based and merge-based rebases had a --quiet
> option and the interactive rebases didn't, is mostly attributable to
> the defaults of the lower level commands these three were built on top
> of (git-am vs. git-merge-recursive vs. git-cherry-pick).  The noiser
> two merited a quiet option, and the option was never added for the
> last one.
> 
> Anyway, that's my rationale.  I'm curious to hear if folks disagree or
> see things I'm overlooking or have reasons I might be weighting
> tradeoffs less than optimally.
> 

I agree that there are already plenty of inconsistencies, (it's great to
see you reducing them). If we can avoid emulating the ouput of
git-rebase--merge.sh in sequencer.c that would definitely be my
preferred option (the code is already a bit hard to follow in places
where there it's doing slightly different things for cherry-pick and
rebase -i). Hopefully no one is relying on the output, as you say it's
just whatever the underlying plumbing prints rather than designed for a
specific purpose.

Best Wishes

Phillip

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7911C83F2D
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 12:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbjICMfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 08:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbjICMfO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 08:35:14 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EBA12A
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 05:35:05 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 731082C814;
        Sun,  3 Sep 2023 14:35:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id E07A72C70B;
        Sun,  3 Sep 2023 14:35:02 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5ynwpMvTakv9; Sun,  3 Sep 2023 14:35:02 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id BDC592C627;
        Sun,  3 Sep 2023 14:35:00 +0200 (CEST)
Message-ID: <2e1f1d2a-4aec-4b60-bc96-685a27055c06@opperschaap.net>
Date:   Sun, 3 Sep 2023 08:34:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Wesley Schwengle <wesleys@opperschaap.net>
Subject: Re: [PATCH v2 2/3] builtin/rebase.c: Emit warning when rebasing
 without a forkpoint
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq1qfiubg5.fsf@gitster.g>
 <20230902221641.1399624-1-wesleys@opperschaap.net>
 <20230902221641.1399624-3-wesleys@opperschaap.net>
 <xmqq4jkckuy7.fsf@gitster.g> <xmqqlednuagl.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqlednuagl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=ybZZDoGAAAAA:8
        a=F9SJyzd9bpDgWOLI2IEA:9 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/3/23 00:50, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> If you rewind to lose commits from the branch you are (re)building
>> against, and what was rewound and discarded was part of the work you
>> are building, whether it is on a local branch or on a remote branch
>> that contains what you have already pushed, they will be discarded,
>> it is by design, and it is a known deficiency with the fork-point
>> heuristics.  How the fork-point heuristics breaks down is rather
>> well known ...
> 
> Another tangent, this time very closely related to this topic, is
> that it may be worth warning when the fork-point heuristics chooses
> the base commit that is different from the original upstream,
> regardless of how we ended up using fork-point heuristics.
> 
> [snip]
> 
> Perhaps something along the lines of this (not even compile tested,
> though)...  It might even be useful to show a shortlog between the
> .restrict_revision and .upstream, which is the list of commits that
> is potentially lost, but that might turn out to be excessively loud
> and noisy in the workflow of those who do benefit from the
> fork-point heuristics because their project rewinds branches too
> often and too wildly for them to manually keep track of.  I dunno.

I like the idea of the warning, but it could be loud indeed and you'll 
want to turn it off in that case.

-- 
Wesley

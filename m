Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE59C2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 12:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E642070A
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 12:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLVMrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 07:47:08 -0500
Received: from mail-gateway-shared12.cyon.net ([194.126.200.65]:55248 "EHLO
        mail-gateway-shared12.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfLVMrI (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 22 Dec 2019 07:47:08 -0500
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared12.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1ij0dS-0000tZ-3s
        for git@vger.kernel.org; Sun, 22 Dec 2019 13:47:05 +0100
Received: from [10.20.10.230] (port=22644 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <dev+git@drbeat.li>)
        id 1ij0dQ-002qUQ-T6; Sun, 22 Dec 2019 13:47:00 +0100
Subject: Re: [PATCH 2/2] contrib/git-jump: add mode commit
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
References: <20191221113846.169538-1-dev+git@drbeat.li>
 <20191221113846.169538-2-dev+git@drbeat.li>
 <20191221192348.GA3339249@coredump.intra.peff.net>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <94d850de-cb73-e124-bced-4dc3f6b970a6@drbeat.li>
Date:   Sun, 22 Dec 2019 13:47:00 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191221192348.GA3339249@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21.12.19 20:23, Jeff King wrote:
> On Sat, Dec 21, 2019 at 12:38:46PM +0100, Beat Bolli wrote:
> 
>> After committing, I often want to return to the place of the latest
>> change to continue my work. Add the new mode "commit" which does exactly
>> this.
> 
> That's one of my primary uses for git-jump, too. But you can already do
> that by jumping to the diff of HEAD^. Which has the additional advantage
> that it's a diff against the working tree. So if you did a partial
> commit, the diff will include any leftover changes.
> 
> So I'm not opposed to this patch per se, given that it's not very many
> lines. But I'm not sure I see much advantage over "git jump diff HEAD^".
> It's slightly less typing, but I already alias "git jump diff" since
> it's so long.
> 
>> Optional arguments are given to the "git show" call. So it's possible to
>> jump to changes of other commits than HEAD.
> 
> This can also be done with "git jump diff $commit^ $commit". However,
> I've found that jumping based on older diffs is mostly useless, because
> the line numbers at $commit and those in the working tree don't always
> match up (and inherently you're always jumping in the working tree
> copy).

Thanks, I didn't realize that git diff could just as well be used to
generate the diff of an arbitrary commit. I have added this new shortcut
to my bash aliases:

    gjc() { git jump diff ${1:-HEAD}^ ${1:-HEAD}; }


Cheers, Beat

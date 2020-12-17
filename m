Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85139C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 22:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E61B23603
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 22:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbgLQWVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 17:21:48 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:16995 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgLQWVs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 17:21:48 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Cxmfp2mkkz5tlB;
        Thu, 17 Dec 2020 23:21:05 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CA7C4246;
        Thu, 17 Dec 2020 23:21:04 +0100 (CET)
Subject: Re: [PATCH 0/2] git-gui: Auto-rescan on activate
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Stefan Haller <stefan@haller-berlin.de>, git@vger.kernel.org
References: <20201101170505.71246-1-stefan@haller-berlin.de>
 <e5f6753b-10b3-1291-1b39-34af63792037@kdbg.org>
 <20201217201051.am33p6h2xu6wq34s@yadavpratyush.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f4e51020-e7e2-cfd6-7631-ca5f32850746@kdbg.org>
Date:   Thu, 17 Dec 2020 23:21:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217201051.am33p6h2xu6wq34s@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.12.20 um 21:10 schrieb Pratyush Yadav:
> On 17/12/20 08:45PM, Johannes Sixt wrote:
>> It is unclear which file is selected automatically when there are
>> unstaged changes. But there is one misbehavior: after I have invoked the
>> merge tool, resolved the conflict, and then switch back to Git GUI, the
>> conflicted file is not selected anymore when it is not the first file in
>> the list. That is *very* annoying.
> 
> Haven't had a chance to try this out yet but AFAIK the last file should 
> be correctly remembered. See below.

It doesn't here in the case where I invoke the merge tool via the
context menu in the diff view.

>> And then there is the following use-case. While Git GUI is not active
>> (think Git GUI and Gitk side-by-side and Gitk active), I click on a
>> particular file that is not at the top of the list; then Git GUI becomes
>> active and rescans, but also forgets on which file I have clicked. But I
>> expected the clicked-on file to become visible, which it doesn't, and I
>> have to click again. This is mildly annoying.
> 
> Hmm, I don't see that on my system on Linux. The code to remember last 
> open file is there in 'rescan_done'. So I don't understand why this 
> becomes a problem on your system.
It's not "last open file"; that works ok. It is "file A is open, I click
on file B, then rescan happens, now file A is still open"; at that point
I want file B open---that's where I clicked. The important part is that
the single click on file B must do two things: activate Git GUI, and
switch to file B. It worked that way in the past.

-- Hannes

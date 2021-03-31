Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC68EC433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 16:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998C56100A
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 16:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhCaQD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 12:03:27 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:63241 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232319AbhCaQDY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 12:03:24 -0400
Received: from host-92-1-139-132.as43234.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lRdJR-0002Ci-9Q; Wed, 31 Mar 2021 17:03:22 +0100
Subject: Re: Detecting when bulk file-system operations complete
To:     Drew Noakes <drew@drewnoakes.com>, git@vger.kernel.org
References: <CAJd66x6XT7m5Njg2kRyGJ80rU6WNcLifijS98=onJeBz+74rrA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <5a1abc6b-52a3-fc12-166f-8af5e7bdff48@iee.email>
Date:   Wed, 31 Mar 2021 17:03:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJd66x6XT7m5Njg2kRyGJ80rU6WNcLifijS98=onJeBz+74rrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Drew,

On 31/03/2021 04:39, Drew Noakes wrote:
> Hi,
>
> I develop IDE tooling that watches a repo's workspace and reacts to changes.
>
> Bulk file-system changes (i.e. branch switch, rebase, merge,
> cherry-pick) trigger lots of file system events, and my tooling should
> ignore intermediary updates. Currently I debounce events with a fixed
> time span, but would like a more reliable and performant approach to
> scheduling this reactive work.
>
> Can this be done by monitoring the GITDIR in some way? For example, is
> there a file that's present when these operations are in flight, and
> which is removed when they complete?
>
> If an operation is interrupted (i.e. merge or rebase that hits a
> conflict) my tooling should consider the bulk operation as complete.
> This means that detecting a git-rebase-todo file or
> rebase-merge/rebase-apply folder is not adequate.
>
> Any help appreciated. Thanks!
>
> Drew.
You may want to look at the various bits of work on `fsmonitor` etc on
the mailing list archive

https://lore.kernel.org/git/?q=fsmonitor

to ensure that all the different approaches inter-operate with
reasonable efficiency..

-- 
Philip

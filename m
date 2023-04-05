Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2F5C761A6
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 15:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbjDEPRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbjDEPQv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 11:16:51 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094846EBB
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 08:15:22 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 28B91241CE;
        Wed,  5 Apr 2023 11:15:19 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pk4r0-64i-00; Wed, 05 Apr 2023 17:15:18 +0200
Date:   Wed, 5 Apr 2023 17:15:18 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rebase: implement --rewind
Message-ID: <ZC2Qhi73YKSOJrM2@ugly>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <20230323162235.995645-1-oswald.buddenhagen@gmx.de>
 <7bd63d7e-ad13-d5b8-54ea-ba5f81da0c17@gmx.de>
 <ZCMRpnS9gzN1Rlbh@ugly>
 <4fa6d2da-4885-09d9-dddb-6f19efda6398@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4fa6d2da-4885-09d9-dddb-6f19efda6398@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 02:07:29PM +0200, Johannes Schindelin wrote:
>This question brings me back to the initial question: What problem do 
>we try to solve here? (This is a question that try as I might, I cannot 
>see answered in the proposed commit message.)
>
and i, try as i might, don't understand what you're not understanding 
...

>[...] In other words, I need a nested rebase.
>
that's just *your* private terminology. i don't apply the term "nested" 
here, because for me that implies the possibility to "unnest", which my 
patch doesn't implement. instead, it just continues past the point where 
the rewind was initiated. it's the difference between a loop and 
recursion.
but outside this difference in terminology, for all i can tell, my patch 
implements *exactly* what you're asking for, and i don't understand why 
that's not obvious to you, given how well you understand the problem 
space yourself.
please describe what you want with _a few_ words and without introducing 
any new terminology first, i.e., something you'd actually want to see in 
the feature's summary documentation. that should illuminate what 
keywords you find critical.

i just gave rewinding rebasing merges a shot, and it didn't work for the 
simple reason that --rebase-merges is not saved in the state 
(understandably, because that was unnecessary so far) and the 
combination of --rewind --rebase-merges is being rejected. i'll need to 
fix that.

then there is the problem that --rebase-merges only redoes merges rather 
than replaying them. but it seems that the simple case with unmodified 
parents actually does get replayed (or rather, skipped over, just 
incredibly slowly), so rewinding to just the last merge would work fine.  
other than that, i'm declaring the matter out of scope and deferring to 
your "replaying evil merges" sub-thread.


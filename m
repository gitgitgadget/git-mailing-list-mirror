Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F653C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 15:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiB1P37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiB1P36 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 10:29:58 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC545D67C
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 07:29:18 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 427E53F482C;
        Mon, 28 Feb 2022 10:29:18 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 207C43F4827;
        Mon, 28 Feb 2022 10:29:18 -0500 (EST)
Subject: Re: [PATCH 0/2] Reduce explicit sleep calls in t7063 untracked cache
 tests
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <06511c93-3e40-a5d4-142c-cab81199e75e@jeffhostetler.com>
Date:   Mon, 28 Feb 2022 10:29:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/28/22 4:40 AM, Tao Klerks via GitGitGadget wrote:
> As noted in a recent proposed patch to t/t7519-status-fsmonitor.sh, a number
> of test cases in t\t7063-status-untracked-cache.sh explicitly sleep a
> second, in order to avoid the untracked cache content being invalidated by
> an mtime race condition.
> 
> Even though it's only 9 seconds of sleeping that can be straightforwardly
> replaced, it seems worth fixing if possible.
> 
> Replace sleep calls with backdating of filesystem changes, but first fix the
> test-tool chmtime functionality to work for directories in Windows.
> 
> I do have a question to the list here: Do mingw.c changes need to be
> upstreamed somewhere? I don't understand the exact relationship between this
> file and the MinGW project.
> 
> Tao Klerks (2):
>    t/helper/test-chmtime: update mingw to support chmtime on directories
>    t7063: mtime-mangling instead of delays in untracked cache testing
> 
>   compat/mingw.c                    | 33 ++++++++++++++++++++++++++-----
>   t/t7063-status-untracked-cache.sh | 29 ++++++++++++++++-----------
>   2 files changed, 45 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1166%2FTaoK%2Ftaok-untracked-cache-testing-remote-waits-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1166/TaoK/taok-untracked-cache-testing-remote-waits-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1166
> 

Thanks for working on this.  It would be nice to be able
to drop that commit (read: hack) from my fsmonitor series.

Jeff

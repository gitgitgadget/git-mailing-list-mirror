Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191A9C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 15:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjATPs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjATPs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 10:48:58 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D71188
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:48:57 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 40DDECA126D;
        Fri, 20 Jan 2023 10:48:57 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 11121CC8337;
        Fri, 20 Jan 2023 10:48:57 -0500 (EST)
Message-ID: <021ab1ab-b90a-5a24-23c4-44e46d87c476@jeffhostetler.com>
Date:   Fri, 20 Jan 2023 10:48:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2] fsm-listen-darwin: combine bit operations
Content-Language: en-US
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
References: <pull.1437.git.git.1673990756466.gitgitgadget@gmail.com>
 <pull.1437.v2.git.git.1673992448371.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <pull.1437.v2.git.git.1673992448371.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/17/23 4:54 PM, Rose via GitGitGadget wrote:
> From: Seija Kijin <doremylover123@gmail.com>
> 
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>      fsm-listen-darwin: combine bit operations
>      
>      Signed-off-by: Seija Kijin doremylover123@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1437%2FAtariDreams%2Fdarwin-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1437/AtariDreams/darwin-v2
> Pull-Request: https://github.com/git/git/pull/1437
> 
> Range-diff vs v1:
> 
>   1:  a98654c7507 ! 1:  9943d52654f fsm-listen-daarwin: combine bit operations
>       @@ Metadata
>        Author: Seija Kijin <doremylover123@gmail.com>
>        
>         ## Commit message ##
>       -    fsm-listen-daarwin: combine bit operations
>       +    fsm-listen-darwin: combine bit operations
>        
>            Signed-off-by: Seija Kijin <doremylover123@gmail.com>
>        
> 
> 
>   compat/fsmonitor/fsm-listen-darwin.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
> index 97a55a6f0a4..fccdd21d858 100644
> --- a/compat/fsmonitor/fsm-listen-darwin.c
> +++ b/compat/fsmonitor/fsm-listen-darwin.c
> @@ -129,9 +129,9 @@ static int ef_is_root_renamed(const FSEventStreamEventFlags ef)
>   
>   static int ef_is_dropped(const FSEventStreamEventFlags ef)
>   {
> -	return (ef & kFSEventStreamEventFlagMustScanSubDirs ||
> -		ef & kFSEventStreamEventFlagKernelDropped ||
> -		ef & kFSEventStreamEventFlagUserDropped);
> +	return (ef & (kFSEventStreamEventFlagMustScanSubDirs |
> +		      kFSEventStreamEventFlagKernelDropped |
> +		      kFSEventStreamEventFlagUserDropped));
>   }

Technically, the returned value is slightly different, but
the only caller is just checking for non-zero, so it doesn't
matter.

So this is fine.

Thanks,
Jeff


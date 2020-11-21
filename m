Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3804C388F9
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 16:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDB722206
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 16:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwYgk64T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKUQTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 11:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgKUQTE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 11:19:04 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F4EC0613CF
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 08:19:03 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so12047769qkc.12
        for <git@vger.kernel.org>; Sat, 21 Nov 2020 08:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8llBhn5ZjMkYff9WtIX576dOViGvaOo9vMMe+iWXDBY=;
        b=SwYgk64T7VW+5qtDLL2zDywfFOYV45rcHCn1eNW/Q2P1J0PrK7bPm6LLXmyUJbueyu
         Cz3Nx/43CePvHRM0A4RHkJEbGmw0lWPGgpKfaU++UWYpNhKAlPjLB4bWBzwnJXS+c7QX
         IisG5rS/ogNhmPPdv902w1wbR1sIGS6HALM562pYWXEFVFbxBMZKgTZfSHgRr4wwdOnB
         rpSLJFyLKzAoSJebIv8rnUo4Tv7WYNH2B/4SnweHIYU1rYcDvus9meH+NuMUISR5xTVO
         Ewh/0rYZQa2XhqUme3V+2ugjVjUsszrKjy+hN4557AWHcpRrkzhYrgfhyfOh/4Mya2Sz
         iLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8llBhn5ZjMkYff9WtIX576dOViGvaOo9vMMe+iWXDBY=;
        b=rJ8+Enydhh9hcTZHO3+K8Mhsi5ikCXi8hvRSRSof/6GQdhPMw0KIz8UOID4hlUr1O7
         jgW0U4TPXAwGmm9i6e6N23jDkcyCjVegHJo/DHy4CANPV2CAvIP3OilzjqcS1pHDah44
         7G7r9PZEQi2+E5pGjO15G5NnaT7N39PpmGbYKKwqWSNoPbdtvEmUwkjUbUEj4S4ikiUu
         KtlpK+4vpAu9e3IQI7ewF0KrvDtsIAUPgquN1S/TV2cySfjZvhBvsSCuDt93V6JkaEm6
         lYf3e0wRK5uxbjUEWCcbNv3zV8XP5sJIbqkUCq3cpiLXXxxRtvaAA+02dCcmkfeQAVWf
         PVBQ==
X-Gm-Message-State: AOAM530Uao/tQxmOQCF8ySSjTGVOKuv494a2YXn5z3Y4NUl21pUYKfrG
        awEboeQjqF3HvAn6MINFWYA0uu9LesCwYmWr
X-Google-Smtp-Source: ABdhPJyYVNjysuxX24cuXLmiWk35F4NZtJaY90sAF9M991p/DduOU5Enu8+Mebc7bZ1jCQwxM2f/3Q==
X-Received: by 2002:a05:620a:14b2:: with SMTP id x18mr21619242qkj.440.1605975542978;
        Sat, 21 Nov 2020 08:19:02 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id j124sm4418744qkf.113.2020.11.21.08.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 08:19:02 -0800 (PST)
Subject: Re: [PATCH] clone: --filter=tree:0 implies fetch.recurseSubmodules=no
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>, peff@peff.net
References: <pull.797.git.1605904586929.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <e539892e-743a-96d7-a540-b7f0af22cbe1@gmail.com>
Date:   Sat, 21 Nov 2020 11:19:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <pull.797.git.1605904586929.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On 20-11-20 15 h 36, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The partial clone feature has several modes, but only a few are quick
> for a server to process using reachability bitmaps:
>
> * Blobless: --filter=blob:none downloads all commits and trees and
>   fetches necessary blobs on-demand.
>
> * Treeless: --filter=tree:0 downloads all commits and fetches necessary
>   trees and blobs on demand.
>
> This treeles mode is most similar to a shallow clone in the total size
> (it only adds the commit objects for the full history). This makes
> treeless clones an interesting replacement for shallow clones. A user
> can run more commands in a treeless clone than in a shallow clone,
> especially 'git log' (no pathspec).
>
> In particular, servers can still serve 'git fetch' requests quickly by
> calculating the difference between commit wants and haves using bitmaps.
>
> I was testing this feature with this in mind, and I knew that some trees
> would be downloaded multiple times when checking out a new branch, but I
> did not expect to discover a significant issue with 'git fetch', at
> least in repostiories with submodules.
>
> I was testing these commands:
>
> 	$ git clone --filter=tree:0 --single-branch --branch=master \
> 	  https://github.com/git/git
> 	$ git -C git fetch origin "+refs/heads/*:refs/remotes/origin/*"
>
> This fetch command started downloading several pack-files of trees
> before completing the command. I never let it finish since I got so
> impatient with the repeated downloads. During debugging, I found that
> the stack triggering promisor_remote_get_direct() was going through
> fetch_populated_submodules(). Notice that I did not recurse my
> submodules in the original clone, so the sha1collisiondetection
> submodule is not initialized. Even so, my 'git fetch' was scanning
> commits for updates to submodules.

I'm not super familiar with the inner workings
offetch_populated_submodules(), but is seems weird that this function
does something in that case. It should do nothing, as the submodule is
not populated. Maybe it would be worth it to investigate what exactly is
happening?

> I decided that even if I did populate the submodules, the nature of
> treeless clones makes me not want to care about the contents of commits
> other than those that I am explicitly navigating to.
>
> This loop of tree fetches can be avoided by adding
> --no-recurse-submodules to the 'git fetch' command or setting
> fetch.recurseSubmodules=no.
>
> To make this as painless as possible for future users of treeless
> clones, automatically set fetch.recurseSubmodules=no at clone time.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     clone: --filter=tree:0 implies fetch.recurseSubmodules=no
>     
>     While testing different partial clone options, I stumbled across this
>     one. My initial thought was that we were parsing commits and loading
>     their root trees unnecessarily, but I see that doesn't happen after this
>     change.
>     
>     Here are some recent discussions about using --filter=tree:0:
>     
>     [1] 
>     https://lore.kernel.org/git/aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com/
>     [2] https://lore.kernel.org/git/cover.1588633810.git.me@ttaylorr.com/[3] 
>     https://lore.kernel.org/git/58274817-7ac6-b6ae-0d10-22485dfe5e0e@syntevo.com/
>     
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-797%2Fderrickstolee%2Ftree-0-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-797/derrickstolee/tree-0-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/797
>
>  list-objects-filter-options.c | 4 ++++
>  t/t5616-partial-clone.sh      | 6 ++++++
>  2 files changed, 10 insertions(+)

In any case I think such a change would also need a doc update, probably
in Documentation/fetch-options.txt and Documentation/config/fetch.txt.

Cheers,

Philippe.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78196C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 17:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhLTRe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 12:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhLTRez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 12:34:55 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D57AC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:34:55 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso13422821ots.6
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 09:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JIe2qKQrHWdCT38DSAbtpFD8y9GjlUc9BCd/ie2SF2I=;
        b=QtHPvaTeIF1jhZ0edjbEzWYrRIQFVpW5u8t/CAF0L5xi5j+y8o7IdTkZQgu/IUWp+C
         VgdalR9awOb9beKO/CK2KYmsSaZTvUyEsVy60ObTJBzmqhTt/845tgux5Tc0I9WLUhEQ
         oUsD6M8d5UMo8LqA/7f8yaVzcWSXwcq7SqZf3LhCwfp1qwMrema1wtxfVKmyUmfcEmSP
         He0chLvy07rHgJLpEF6I5UcStOBnYoNstt+nFnowBSHZAjh1J/C0bGkqlrtjH15gmRom
         tDBR43bOwVTNiJiQE00DKTuqh8/39JwuXhNNBQ+kFviG8dWyVFgTNOQAf5d0kG4ObMRa
         A7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JIe2qKQrHWdCT38DSAbtpFD8y9GjlUc9BCd/ie2SF2I=;
        b=fKofykfhrRm6FLaYFvwoVxZnqtgEhJRt0LwLZcc1y2EIX3TNkua18SlDH2qsqcI22r
         rvyseEx/r70lUAOrSx37KBFsAq762gdwHUA4Obf2U4rVeFOZ2Xhd1A2C/VhbVn5/vzoJ
         +jYpD8WqLLSv17cTxZWq5J5N8R1NvHrEhiIkl5P9eGd/V7eSSrJP8Dp7jZnh+osQeFdi
         2w8KTBMeyroKVXLiTI2IxFiaUrrw4dlCP6v9T2m9cb2dIuaOKaXwGSM7mj3yQ+Y5Wi4+
         AW6pdBdHwCsyqQkIdV/aOxAjzzLSoQyHFclBMcXy9FnoNVCLAY2fxAhQjXl6VvXC6FuX
         ENIw==
X-Gm-Message-State: AOAM53112pob/DdaMGVD5K3Kxfyj86HC75/Xq4UWK0G+dvTBAZ72IgGn
        OZ8LXV4sjuluNtBKuFfhYk4=
X-Google-Smtp-Source: ABdhPJxIDrqwfOfNe3Sh6lyWnWJCzg0IxxBNLZqWzlBCiRQR3DVhxWGRhAuqAxmevg5CkjejOjWnkg==
X-Received: by 2002:a05:6830:2058:: with SMTP id f24mr12479324otp.288.1640021694804;
        Mon, 20 Dec 2021 09:34:54 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1dd9:8fb3:37da:4055? ([2600:1700:e72:80a0:1dd9:8fb3:37da:4055])
        by smtp.gmail.com with ESMTPSA id q22sm3307944ots.62.2021.12.20.09.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 09:34:54 -0800 (PST)
Message-ID: <cedea0bf-5def-86a4-5d3b-5377949c1f12@gmail.com>
Date:   Mon, 20 Dec 2021 12:34:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/4] Sparse checkout: fix bug with worktree of bare repo
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <CAPig+cTVzMtiHzkJq7VRg4Xa3xhrq7KKCdK5OSDY6bvwKu_ynA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cTVzMtiHzkJq7VRg4Xa3xhrq7KKCdK5OSDY6bvwKu_ynA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2021 11:21 AM, Eric Sunshine wrote:
> On Mon, Dec 20, 2021 at 10:57 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> This patch series includes a fix to the bug reported by Sean Allred [1] and
>> diagnosed by Eric Sunshine [2].
>>
>> The root cause is that 'git sparse-checkout init' writes to the worktree
>> config without checking that core.bare might need to be set. This only
>> matters when the base repository is bare, since creating the config.worktree
>> file and enabling extensions.worktreeConfig will cause Git to treat the base
>> repo's core.bare=false as important for this worktree.
> 
> Thanks for jumping on this so quickly. Unfortunately, however, as
> mentioned in [1] and [2], I think the approach implemented here of
> setting `core.bare=false` in the worktree-specific config is
> fundamentally flawed since it only addresses the problem for worktrees
> in which `git sparse-checkout init` has been run, but leaves all other
> worktrees potentially broken (both existing and new worktrees). As far
> as I can see, the _only_ correct solution is for the new helper
> function to enable `extensions.worktreeConfig` _and_ relocate
> `core.bare` and `core.worktree` from .git/config to
> .git/worktree.config, thus implementing the requirements documented in
> git-worktree.txt.

Thanks for clarifying what I had misread. I commented on Patch 3 at the
place that should be changed to relocate the setting. The test in patch 4
could have multiple worktrees to verify that it works.

I'll plan on providing a v2 with that change tomorrow, leaving time to
find any other glaring errors.
 
> I also raised a separate question in [2] about whether `git
> sparse-checkout init` or the new helper function should be warning the
> user that upgrading the repository format and setting
> `extensions.worktreeConfig` might break third-party tools. However,
> that question is tangential to the fix being addressed here and
> doesn't need to be addressed by this series.

Let's continue to simmer on this one. If there is a clear direction for
doing this (should it just be an advice message?) then we can do that
whenever.
 
> [1]: https://lore.kernel.org/git/CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com/
> [2]: https://lore.kernel.org/git/CAPig+cQPUe9REf+wgVNjyak_nk3V361h-48rTFgk6TGC7vJgOA@mail.gmail.com/

Thanks,
-Stolee

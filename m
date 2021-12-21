Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7ADC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 13:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbhLUNlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbhLUNlP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 08:41:15 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51081C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 05:41:15 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 7so20890277oip.12
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 05:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PwWDg1llQMPMPTAiCDWQU+wb0RnTpnsvU8goOgocHnQ=;
        b=ha9fUwQN1/VKjlbb+9uCFLcnONn6ga4QR9ZCt4kbsH+A4uFoaJYohAoxLivqKDHWGg
         6oiUjg7edvceVoVwUImSPy/Zt8u3KO6Bc9nFYduJmqhAMQHrGrXSGqAacjplJDbTwvsx
         LrCqbsGFceHKSTCAEo6GTip4oMkPwjQr0KNgupKguBQAU2Ezb7x+PtRBVtV/VF79Ej+A
         zD43XJ4yOrajBAm/7QbRj9vbVTjqGXxSo9+lXgNR4/nSEUXjMl3/yVZVp9KNnYzG6tl0
         8TskFp+LsKJJalx4UudIOWjYGYyqsOSGTI4YtYqq5FD4ew8F8IZ/uybNZNgH2VWmZTIb
         lJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PwWDg1llQMPMPTAiCDWQU+wb0RnTpnsvU8goOgocHnQ=;
        b=03xso/bL+S33L2+sQRs8njDjI0Ap4M64Esz3ZC7YHsHqwplFwsjU7T59+eRMCuItGt
         bUHzsA0ZAwo7lQMp9SaYVo3Kt+vivGiQk+JEB9rE1aoyW+dUN2kIt7zZJ7ffAIdWdzRo
         Y0ENZigz7df6+TO3hKE/32LDUGvnDpZn7JqXkcuGNTThTNddOyM2s24fH12gSP0pQoqX
         ExOMxtKgc5DvpVktVJjIYhMSVl5wK9Fg7raTJA/FszhBY4C1XzdUCNLI+6qhx2wvUJOF
         /CpO3oIHJEwnnDgpFQACpQRAX4ytryJuZp1QV1BuXwFziDhBTYDF0Eh4U0cZRhKaq8t5
         D49A==
X-Gm-Message-State: AOAM530VQwGzZQyPq/1Cxks9umKQVmsWMlvBYpLYQYr+FbdqPs58vH3y
        FzlXAYIv4DTsG+zP0AEGOW4=
X-Google-Smtp-Source: ABdhPJzobRHAilTnfGM48Nxl54ch3/erb2RzFjkLeApvO1Kn6wXMnSa6tcWTEEdkSZteAYLqFvneSA==
X-Received: by 2002:aca:581:: with SMTP id 123mr2404895oif.13.1640094074423;
        Tue, 21 Dec 2021 05:41:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c11c:699d:989:f926? ([2600:1700:e72:80a0:c11c:699d:989:f926])
        by smtp.gmail.com with ESMTPSA id f12sm3694330ote.75.2021.12.21.05.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 05:41:13 -0800 (PST)
Message-ID: <73744786-4248-f04f-5d56-11e938d174e7@gmail.com>
Date:   Tue, 21 Dec 2021 08:41:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] config: add repo_config_set_worktree_gently()
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <67993f6cff254d341ba4ad7fe7709b57eb3e74d4.1640015844.git.gitgitgadget@gmail.com>
 <6d72a020-ded7-6ef2-825c-ce6421194b26@gmail.com>
 <CAPig+cTuLYFc9fpAe8Uq9fvBYuSGcc9SA1O-q1BRw0DYxDF4Eg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAPig+cTuLYFc9fpAe8Uq9fvBYuSGcc9SA1O-q1BRw0DYxDF4Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2021 7:01 PM, Eric Sunshine wrote:
> On Mon, Dec 20, 2021 at 12:32 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 12/20/2021 10:57 AM, Derrick Stolee via GitGitGadget wrote:
>>> +     /*
>>> +      * Ensure that core.bare reflects the current worktree, since the
>>> +      * logic for is_bare_repository() changes if extensions.worktreeConfig
>>> +      * is disabled.
>>> +      */
>>> +     if ((res = git_config_set_multivar_in_file_gently(config_filename, "core.bare",
>>> +                                                       r->worktree ? "false" : "true",
>>> +                                                       NULL, 0))) {
>>
>> As mentioned by Eric, this portion isn't correct. It fixes _this_ worktree, but
>> any other existing worktrees would become broken.
>>
>> The fix would be to detect if the core config file has core.bare=false and then
>> to move that setting into the base repo's config.worktree file.
>>
>> I believe that if we do that change, then the rest of this patch series is valid.
> 
> Sorry, but I'm not following what you're suggesting, and I'm not sure
> what you mean by "core config file" and "base repo's config.worktree
> file". Also, we aren't specifically concerned that `core.bare=false`.
> 
> Conceptually the proper fix is quite simple. (Whether the actual
> implementation is simple is a different question; I haven't looked
> closely at the code yet to be able to answer that.) First, though,
> let's make clear what different config files are involved:
> 
> .git/config -- config shared by the repository and all worktrees
> (including the main worktree)
> 
> .git/config.worktree - config specific to the main worktree (or to the
> repository itself if bare)
> 
> .git/worktrees/<id>/config.worktree -- config specific to worktree <id>
> 
> In the above list, I'm using ".git/" loosely to mean either a bare
> repository (i.e. "bare.git") or the ".git/" directory within the main
> worktree; the difference is immaterial to this discussion. When
> `extensions.worktreeConfig` is false or unset, only the first item in
> the above list is consulted; when `extensions.worktreeConfig` is true,
> then the `config.worktree` files are consulted, as well (depending
> upon which worktree you're in).
> 
> Regarding the actual "fix": we want a new utility function which
> enables per-worktree configuration and handles all the required
> bookkeeping actions described in git-worktree.txt. Specifically, if
> per-worktree configuration is not already enabled, the function will
> need to:
> 
> (1) set `extensions.worktreeConfig=true` in .git/config
> 
> (1) relocate `core.bare` from .git/config to .git/config.worktree if
> that key exists
> 
> (2) relocate `core.worktree` from .git/config to .git/config.worktree
> if that key exists

You are describing (in better detail) what I meant in my message about
what needs to change in this patch.
 
> That's it. It doesn't need to create or touch any
> .git/worktrees/<id>/config.worktree file(s); it should _not_ add a
> `core.bare=false` to .git/worktrees/<id>/config.worktree, as this v1
> patch series does.

Yes, the current patch is incorrect. However, changing just that one
aspect of this patch in the current method (in config.c) should make
it behave the way you are advocating.

I should have a v2 up later today and we can talk in more specifics
about that if you want to wait until then.

Thanks,
-Stolee

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F14C433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 17:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhL2RjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 12:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhL2RjC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 12:39:02 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E79C061574
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 09:39:02 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id 8so19548195qtx.5
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 09:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+qefR1ukgRMA+ZiAZ8ImwcH3naaQ0zfY1QnHyHXMgtI=;
        b=KiA3agddE1qgdGf5QwB7W+aMMRqPIubQP3WercVm5wBE2T5RpFsgETEYsmeJdbyZyp
         QsggEPKUDC3t/cG9CxT254P8YI7KN3pMZOTwk0urNW/g1lXYdf83JorIjw6qpop+53yy
         3lm5b/aP1C1GlGx6e3QTXqt1C+Om40D/A6iLPoyjQtNxlvImtOlT2ZZyKeHuCtVnaWG3
         F2jFaTbwa/AO+g21xQO1kcAky8miWORoBDlOloK5Ig5dIWKvXJTk+fRVo9jYqtPeEoWC
         2NN6rTnh4yWuxB37mR7mYjNswQ5Q8hqTWPMDFHw9xkpkf3RDsR0ulugBUUjA6v9Plv1r
         QGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+qefR1ukgRMA+ZiAZ8ImwcH3naaQ0zfY1QnHyHXMgtI=;
        b=6agmmb759E3VtzQbeMidWawNeKcO6mbVBLcwD9o/UMw/rVn3bxjMCwMgXg8zfOKwkz
         oGQ62b+vykBRNKwDWgRnNAy0TFrOznUGDQNAzLRXfBmWfDVvLZ4VyqMaMSSRvFLuRiKj
         xurSZMVWRTSukZcLS1cLLDhKmnNfeYRNyU83SGGCEDIAI690wQEx0BLERat0tYYvfjOX
         E3/83HVZoDTj0lV6gOJnmSmnyjAHCnCXLuD6grEphwQneflHyBQKxYzQFl+OXI0NKV7+
         HpBRqt9GFtR52PBH6zloctCb6RjKwG4M1EYFqrif5p57JhGfCaNnCse2dGNz0juO+zO/
         3s+A==
X-Gm-Message-State: AOAM532YfTQleOd9Qokry6wY9CXPkX4XZ6Wj5Vvfzdkv9z/XyRhssUmF
        DcWLS5BRiyQRPYhy7jpnxRA=
X-Google-Smtp-Source: ABdhPJyjQt17kwHur8org5kHva+B0owsgllpcpt5u8UBwfqgc6+FFNyXfoofHGxcs7Kwp+Hx+9HD/Q==
X-Received: by 2002:ac8:758b:: with SMTP id s11mr23509826qtq.51.1640799541400;
        Wed, 29 Dec 2021 09:39:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:90c2:2049:9567:8f81? ([2600:1700:e72:80a0:90c2:2049:9567:8f81])
        by smtp.gmail.com with ESMTPSA id x1sm17588728qtj.9.2021.12.29.09.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 09:39:01 -0800 (PST)
Message-ID: <1db0f601-4769-15c0-cd58-ecddfa1fc9d5@gmail.com>
Date:   Wed, 29 Dec 2021 12:38:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3 0/6] Sparse checkout: fix bug with worktree of bare
 repo
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
 <CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/29/2021 4:39 AM, Elijah Newren wrote:
> On Tue, Dec 28, 2021 at 1:32 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This series is based on a merge of en/sparse-checkout-set,
>> en/worktree-chatty-to-stderr, and ds/sparse-checkout-malformed-pattern-fix.
> 
> I think you mean es/worktree-chatty-to-stderr (not 'en/')

Yes. Thanks.
 
>> This patch series includes a fix to the bug reported by Sean Allred [1] and
>> diagnosed by Eric Sunshine [2].
>>
>> The root cause is that 'git sparse-checkout init' writes to the worktree
>> config without checking that core.bare might need to be set. This only
>> matters when the base repository is bare, since creating the config.worktree
>> file and enabling extensions.worktreeConfig will cause Git to treat the base
>> repo's core.bare=false as important for this worktree.
>>
>> This series fixes this, but also puts in place some helpers to prevent this
>> from happening in the future. While here, some of the config paths are
>> modified to take a repository struct.
>>
>>  * 'git sparse-checkout' will now modify the worktree config, if enabled. It
>>    will no longer auto-upgrade users into using worktree config.
> 
> This sounds dangerous to me.

> ...
>>      +    Let the sparse-checkout builtin use this helper instead of attempting to
>>      +    initialize the worktree config on its own. This changes behavior of 'git
>>      +    sparse-checkout set' in a few important ways:
>>
>>      -    The fix is to have this assignment into config.worktree be handled by
>>      -    the repo_config_set_worktree_gently() helper.
>>      +     1. Git will no longer upgrade the repository format and add the
>>      +        worktree config extension. The user should run 'git worktree
>>      +        init-worktree-config' to enable this feature.
>>      +
>>      +     2. If worktree config is disabled, then this command will set the
>>      +        core.sparseCheckout (and possibly core.sparseCheckoutCone and
>>      +        index.sparse) values in the common config file.
> 
> Yikes.
> 
>>      +     3. If the main worktree is bare, then this command will not put the
>>      +        worktree in a broken state.
>>      +
>>      +    The main reason to use worktree-specific config for the sparse-checkout
>>      +    builtin was to avoid enabling sparse-checkout patterns in one and
>>      +    causing a loss of files in another. If a worktree does not have a
>>      +    sparse-checkout patterns file, then the sparse-checkout logic will not
>>      +    kick in on that worktree.
>>      +
>>      +    This new logic introduces a new user pattern that could lead to some
>>      +    confusion. Suppose a user has not upgraded to worktree config and
>>      +    follows these steps in order:
>>      +
>>      +     1. Enable sparse-checkout in a worktree.
>>      +
>>      +     2. Disable sparse-checkout in that worktree without deleting that
>>      +        worktree's sparse-checkout file.
>>      +
>>      +     3. Enable sparse-checkout in another worktree.
>>      +
>>      +    After these steps, the first worktree will have sparse-checkout enabled
>>      +    with whatever patterns exist. The worktree does not immediately have
>>      +    those patterns applied, but a variety of Git commands would apply the
>>      +    sparse-checkout patterns and update the worktree state to reflect those
>>      +    patterns. This situation is likely very rare and the workaround is to
> 
> No, it's not even rare, let alone very rare.  I'd actually call it
> common.  Since 'sparse-checkout disable' does not delete the
> sparse-checkout file, and we've encouraged folks to use the
> sparse-checkout command (or a wrapper thereof) instead of direct
> editing of the sparse-checkout file (and indeed, the sparse-checkout
> command will overwrite the sparse-checkout file which further
> discourages users from feeling they own it), having the file left
> around after disabling is the common case.  So, the only question is,
> how often do users disable and re-enable sparse-checkout, and
> potentially only do so in some of their worktrees?  At my $DAYJOB,
> that's actually quite common.  I got multiple reports quite soon after
> introducing our `sparsify` tool about users doing something like this;
> this is what led me to learn of the extensions.worktreeConfig, and why
> I pointed it out to you on your first submission of
> git-sparse-checkout[1]
> (https://lore.kernel.org/git/CABPp-BFcH5hQqujjmc88L3qGx3QAYZ_chH6PXQXyp13ipfV6hQ@mail.gmail.com/)

Thank you for these comments and the detailed descriptions of things
from your $DAYJOB. That's helpful context and I'm happy to switch back
to enabling the extension in the sparse-checkout builtin. I might need
to rearrange the code so there is an API in worktree.c instead of just
the subcommand in builtin/worktree.c, but that's pretty minor. I'll
keep Eric's earlier suggestion to have the upgrade be a separate call
from the repo_config_set_worktree_gently().

Thanks,
-Stolee

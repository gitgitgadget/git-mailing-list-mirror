Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FBBC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 01:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F167610E5
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 01:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbhHTBAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 21:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhHTBAf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 21:00:35 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09395C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:59:59 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id b1so6259507qtx.0
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BGN59GsywYRUi5ooIuIfgwwN8TOlVvqJ6P9yyCRlvo4=;
        b=gCInq8SU0D1g0mDvAPlvbfrT4fmaaI1IcBoAtLCj4M6u1LzQQ+KYNogGq6/DNRsi/L
         LGJCJiy7rcyt0wNPRRQ+llWBBI1HFHGBdIGS43v0dzCxHxHRqxSU2bbo3NGI35asFcuV
         fXAHHRbd/lDtVLRYAWku5fITbgS1lBfQ7/+1/oNbZrNR/EPlK2YLTWmeh5WRQf/SQYmT
         5+cN84R4JnwYTgBCo+daC+C1L/MRyie03HkWmNqw7JOxCA6UPp2+R06ZZGfAGZYvY1+S
         htMRHoZ4bYoDmtxS5p8qkjmIv3b7wekKvMKtEwtzdvAIByLNwrcoN7qMMKaNpQThv6aF
         +Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BGN59GsywYRUi5ooIuIfgwwN8TOlVvqJ6P9yyCRlvo4=;
        b=f0zag6hSZIORJr3UsiE6iHiK5NMXGXo6tMOCLKZ+3/7QgaMLyOjgp5Wh8NnOnPmIQ9
         cQet3YHKL02Q4/Irj8PxIdUu5P0L+KrfetuU/Yq6F3M3dzJp4pNkHbFKtXbt+iZTTDvw
         LjuPkf7NuRXWNm/XSikySMJSxomm9BsTN++Fi2/+pr9BK6PCqCxcLjm7i1cUSG+RxgOI
         oKh4uRf5Uzxr41II7sbPhQ6u+nKoLFtmy9kGB/J2EvndLJDK0QhiQMJ36yMk2cZgzJEa
         x9TvDa7XggSbeEVTJyT6X/bxEqEcLwgwanh0r2ELG6ibgB2wgOrFySe+fsnyUZOgvKuc
         E68A==
X-Gm-Message-State: AOAM533DgFrCXuvRiXnUAcMvQigSDx9ubxSCgygY9HOtqnVkJ8aSuhtP
        54YagRDgONlKkhf0VxM+Slup4GKNpsNnXQ==
X-Google-Smtp-Source: ABdhPJx9dotwjrwFd6oq1ZzTqKmtKjXp+U1dFDKoZTLNcgIePycDKEBGnKxrAG+2F+/TFjoZLqXnfQ==
X-Received: by 2002:ac8:7304:: with SMTP id x4mr15398072qto.222.1629421197912;
        Thu, 19 Aug 2021 17:59:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:2127:20ac:7d67:3e01? ([2600:1700:e72:80a0:2127:20ac:7d67:3e01])
        by smtp.gmail.com with ESMTPSA id p22sm2379658qkj.16.2021.08.19.17.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 17:59:57 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] submodule: record superproject gitdir during
 'update'
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20210819200953.2105230-1-emilyshaffer@google.com>
 <20210819200953.2105230-5-emilyshaffer@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <66111c98-8be3-d3e5-288f-cb5b59744cb5@gmail.com>
Date:   Thu, 19 Aug 2021 20:59:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819200953.2105230-5-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2021 4:09 PM, Emily Shaffer wrote:
> +		# Cache a pointer to the superproject's gitdir. This may have
> +		# changed, so rewrite it unconditionally. Writes it to worktree
> +		# if applicable, otherwise to local.
> +		relative_gitdir="$(git rev-parse --path-format=relative \
> +						 --prefix "${sm_path}" \
> +						 --git-dir)"
> +
> +		git -C "$sm_path" config --worktree \> +			submodule.superprojectgitdir "$relative_gitdir"

Ok, I see now why you care about the worktree config. The scenario you
are covering is something like moving a submodule within a worktree and
not wanting to change the relative path of other copies of that submodule
within other worktrees, yes?

For commands such as 'init' and 'add', we don't have the possibility of
colliding with other worktrees because the submodule is being created
for the first time, so the relative path should be safe to place in the
non-worktree config.

I do struggle with the fact that these are inconsistent across the
two commits. It makes me think that there should only be one way to
do it, and either the NEEDSWORK needs to be fixed now, or this line
shouldn't include --worktree. Much of this can depend on the reason
the worktree config exists for a submodule. I expect you have more
context than me, so could you help me understand?

Moving to a different concern I am now realizing with this config:
What happens if a submodule moves, and then a user runs 'git checkout'
in the superproject to move it back? How do we make this config value
update across those movements? Is there a possibility of integrating
with unpack_trees() to notice that a submodule has moved and hence we
should update this config value?

Thanks,
-Stoolee

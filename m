Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025A2C7EE2F
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 19:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236652AbjFLTpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjFLTpc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 15:45:32 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E650BE62
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 12:45:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3ce6607cbso12671085ad.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686599128; x=1689191128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oachJCCfp+ZZlBu68pS/w73vSkNOVrW50bTmAZ8G9BM=;
        b=IkKSB1iivHQUJXOq8MSBXZogZD428208hiwd2EnLobkSI8JKDmwdPjgJrB6GUsee83
         P5QQjhQaSFGvvyv0whMQB7NV0k++Maph8TMqCmfHTGge5TIbPKEMQvf9lH2F7DHFYZh9
         nF5TpjvntU2kl9ay7erAXY9W70sU2BJl8HbLUyg65slcyPgiW22XqsHKjF2vMWxEfsqI
         D9z7LIWGmK27Xio0KE4sq11BwduYC3jDiRpJE+lUGzp7trivtK/v1O83Van8IizYcFOw
         jE+Cy3oICQwXfCztKD5OnQnhHOgL4SxcbIg8CJYmE+zgAgW4rgMrV/7qALbKFqfWkqA3
         Pgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686599128; x=1689191128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oachJCCfp+ZZlBu68pS/w73vSkNOVrW50bTmAZ8G9BM=;
        b=BpqaEtQH00a32nhUoZKdFpCXqoQd+WT/U++5XjUGzP3lxBVijYb2rb0CBdLZlVhUwa
         cPUbiVlpiqJ/JxuOyG+mmn3KHonujD1Smb2uyP+ZlBIbNxwen6+ctJ7jexpeUIfuAW+k
         ROfCjf6dCi3cHE99kbtt81CHM3z/OodR++eTvJSG6Wi6PdryPavPeNcFOagQ1YW3QOEx
         P/grbO0Me4sBFjFqNxCgncdHC0xKoZZd2ZnVXHYuBxJnJj4WZVxUhAy2clXJ5ld0pHNL
         JplrchJc//C7qIiT54IY9RaJdxdP385CVCqHf1A7hdObQ5+VSUp7jrziIHm1+9JxZTJW
         AqOg==
X-Gm-Message-State: AC+VfDwrW8xJmQDWMnCqES8SXpQlrlCZWASviq3O74RLEdbgjasccWI4
        VOYCCkzgs4f7tr8Kr723LNS2
X-Google-Smtp-Source: ACHHUZ6YTN5PKyq2NKcqHty9cqfcEFVUnkcahJFL0c7FRTTqRHSDQUEayrm4E0D3GWHucBNC0sQwFQ==
X-Received: by 2002:a17:902:c20b:b0:1b3:9abd:6c2c with SMTP id 11-20020a170902c20b00b001b39abd6c2cmr7617617pll.59.1686599128198;
        Mon, 12 Jun 2023 12:45:28 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c11100b001b06361a38dsm8622962pli.116.2023.06.12.12.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 12:45:27 -0700 (PDT)
Message-ID: <dd21767c-7c66-cf42-1a64-954a069dc466@github.com>
Date:   Mon, 12 Jun 2023 12:45:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/3] repository: move
 'repository_format_worktree_config' to repo scope
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Cc:     derrickstolee@github.com, gitster@pobox.com
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
 <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
 <506a2cf8c73549bc8f9761b56532ef08ed220da4.1685064781.git.gitgitgadget@gmail.com>
 <kl6lr0qwno2q.fsf@chooglen-macbookpro.roam.corp.google.com>
 <49509708-c0a1-2439-a551-cab05d944b66@github.com>
 <kl6lttvcft59.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <kl6lttvcft59.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo wrote:
> Victoria Dye <vdye@github.com> writes:
>> If we were to settle on a single "copy repository format settings" function,
>> it's not obvious what the "right" approach is. We could change
>> 'check_repository_format()' to the shallow-copy-then-null like the others:
>> its two callers (in 'init-db.c' and 'path.c') don't use the value of
>> 'repository_format_partial_clone' in 'struct repository_format' after
>> calling 'check_repository_format()'. But, if we did that, it'd introduce a
>> side effect to the input 'struct repository_format', which IMO would be
>> surprising behavior for a function called 'check_<something>()'. Conversely,
>> unifying on a deep copy or adding a flag to toggle deep vs. shallow copy
>> feels like unnecessary complexity if we don't actually need a deep copy.
>>
>> Beyond the smaller subtleties, there's the larger question (that you sort of
>> get at with the questions around 'discover_git_directory()') as to whether
>> we should more heavily refactor or consolidate these setup functions. The
>> similar code implies "yes", but such a refactor feels firmly out-of-scope
>> for this series. A smaller change (e.g. just moving the assignments into
>> their own function) could be less of a diversion, but any benefit seems like
>> it'd be outweighed by the added churn/complexity of a new function.
> 
> I don't agree that this refactor is out of scope. I think we agree that
> the refactor is desirable, but if we apply the same heuristics in the
> future, the next author to copy a member from 'repository_format' to
> 'repository' could do the same and we'd never end up with the refactor
> we wanted. I strongly feel that if we don't put in a concerted effort
> into such refactors along the way, we end up creating more of the churn
> that made our lives harder in the first place.

I don't actually agree that *this* refactor (that is, moving all the
"repository_format -> repository" assignments into a helper function) is
desirable, though, even if we extrapolate to future updates. 

Even if we updated the only other 'repository_format' value
('repository_format_precious_objects') to be copied the same way, the
benefit we'd get from eliminating a couple of lines of code duplication
wouldn't necessarily outweigh the the extra complexity of a new abstraction
- which may or may not need special-casing based on who's calling it -
and/or the risk associated with changing behavior if we want to eliminate
those special cases. IOW, I don't feel it's a definitive net improvement in
this situation.

What I do feel is desirable (although, to be honest, not particularly
strongly) is a larger refactor of 'setup.c' - including a deeper analysis
into the all the different setup functions we have, how they're used, why
they differ, etc. - to create a more unified setup process across all of
Git. That might include a helper function like what you've described, but it
might not need one at all, hence my comment about "added churn" (it's just
another thing a larger refactor would need to work around). 

*That* refactor is what I was referring to as "out-of-scope" for this series
(sorry I wasn't clearer earlier!), which - considering the goal is "make
submodules work with worktree config" - doesn't seem unreasonable to me.

> E.g. we could support both deep and shallow copying, like:
> 
>   /*
>    * Copy members from a repository_format to repository.
>    *
>    * If 'src' will no longer be read after copying (e.g. it will be
>    * cleared soon), pass a nonzero value so that pointer members will be
>    * moved to 'dest' (NULL-ed and shallow copied) instead of being deep
>    * copied.
>    */
>   void copy_repository_format(struct repository *dest,
>                               struct repository_format *src,
>                               int take_ownership);

Unless we find that we *need* to support both, this approach would be more
harmful than helpful. If it doesn't matter whether the copy is shallow or
deep, this design proliferates that meaningless distinction in a way that
can easily confuse developers (or at least create more work for them as try
to try to understand it) if they ever want to change or use the function.


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35EBC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 11:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF3886103C
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 11:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbhJ0Lhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 07:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241660AbhJ0Lhh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 07:37:37 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C9C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 04:35:12 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id o204so2952621oih.13
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 04:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uH79kPKyt9gIDFUWPc92EZAue16wSRCk3AcEAVZ0GgA=;
        b=qFUgGcjxQ6TzcGktAm9fjHzXpqWTm6uXBuQESZiq1tQffcTb1uxTeOwo5076YX4op9
         UP9R/YBo6X3srL4LIKLvuP6U5joJJyXsYGnGMmb7timSdu9teTdMdFjpPnY2olBLcDyx
         EvxDaM26kchcu3zB8HevD2zl+5+xjL3pfuyghDKuR/0njfcdfx2jHg/jXMG+j5RuoV4b
         xZkqVr8f3sOP2yJdeci4KpZ8Jh2xi67S5cTrx1a28/mwE0tURHBsK09xifgVBPQGVeMz
         UmSbdWz5yRxrBwf0uthpL7y/rDuEamnqcoY35rJE+R7BRG/jjOnH/J11BoI3FVKBUU60
         7hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uH79kPKyt9gIDFUWPc92EZAue16wSRCk3AcEAVZ0GgA=;
        b=JZSuM7/rqEmS93IEtDK/DfA5SQnLmHfBqffppcJTl87eLiOiYOBFazEEj8ugheF5yY
         UYDYGX/rct0gaFeV0oX/kLkUzXk83F5nR5fPTCKK+LFrla1QX6C5lfZiOylve7FSqb7+
         Sm1pgkby2+VqPMsg/5IfMLe7NdQvd/kWQmGSfNJyW9h9gv+ZQc8rDl/VDQ8w6KMAuBuS
         17T+QqrWmudgufOjcmuxkXxQoSQlODUMmML5YI2+PZhuRs9bla8p+rSQVR7GPFocqUxV
         LfzvXpZuvfodq+K/PBiutjRcbwpK3e6ji2hOY6mtD8kg0c43ZAy8Ry5MUf59/gUrRE2q
         BWsA==
X-Gm-Message-State: AOAM533i7Gu8/pjJ5Ztz96R9+k2iVwEDPTCf6S2sUDFrGeh7K9bZg5Qe
        zMuAfQAzC0VMuaVH+J+1uqJHab+UToM=
X-Google-Smtp-Source: ABdhPJyt3Lvyic0PNNTJ1H66/czMjhq3GYnZLzFvIkozpJwBonEWfEEyLCX3vU6XbC5Zk4oeMLtbWQ==
X-Received: by 2002:aca:ac0b:: with SMTP id v11mr3130362oie.155.1635334512014;
        Wed, 27 Oct 2021 04:35:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e44a:53c8:a196:8752? ([2600:1700:e72:80a0:e44a:53c8:a196:8752])
        by smtp.gmail.com with ESMTPSA id k7sm3214330oiw.58.2021.10.27.04.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 04:35:11 -0700 (PDT)
Message-ID: <fe225c5f-ea21-8e5b-8407-f4dfe28ba8be@gmail.com>
Date:   Wed, 27 Oct 2021 07:35:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] add, rm, mv: fix bug that prevents the update of
 non-sparse dirs
Content-Language: en-US
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Sean Christopherson <seanjc@google.com>
References: <5e99c039db0b9644fb21f2ea72a464c67a74ff64.1635191000.git.matheus.bernardino@usp.br>
 <47aec8ed-5e54-6d13-8154-0202ef0fd747@gmail.com>
 <CAHd-oW6w0aiFDVX1S2ttfc++H3okz2YTGf3f2p=xSbL_Bc_DNA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAHd-oW6w0aiFDVX1S2ttfc++H3okz2YTGf3f2p=xSbL_Bc_DNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/26/2021 6:43 PM, Matheus Tavares wrote:> On Tue, Oct 26, 2021 at 9:53 AM Derrick Stolee <stolee@gmail.com> wrote:
>>> - Inside the loop, made sure to change dtype to DT_DIR when going to parent
>>>   directories. Without this, the pattern match would fail if we had a path
>>>   like "a/b/c" and the pattern "b/" (with trailing slash).
>>
>> Very good. We typically need to detect the type for the first path given,
>> but we know that all parents are directories. I've used this trick elsewhere.
>>
>> I see in the code that the first path is used as DT_REG. It's my fault, but
>> perhaps it should be made more clear that path_in_sparse_checkout() will
>> consider the given path as a file, not a directory. The current users of the
>> method are using it properly, but I'm suddenly worried about another caller
>> misinterpreting the generality of the problem.
> 
> Yeah, I was thinking about this too... I'm afraid there might be at
> least two users of this function which already pass non-regular files
> to it: builtin/add.c:refresh() and
> sparse-index.c:convert_to_sparse_rec().
> 
> The first calls the function passing the user-given pathspec, which
> may be a directory. But this one is easy to solve: I think we don't
> even need the path_in_sparse_checkout() here as the `git add
> --refresh` only work on tracked files, and the previous
> matches_skip_worktree() call covers both skip_worktree and
> non-skip_worktree index entries (maybe we should rename this function
> to matches_sparse_ce()?)
> 
> As for convert_to_sparse_rec(), it seems to call
> path_in_sparse_checkout() with the directory components of paths, so
> something like "dir/". Perhaps we can make path_in_sparse_checkout()
> receive a dtype argument and pass DT_UNKNOWN in this case?

This might be necessary. Thanks for digging into the details here.

> Another case I haven't given much thought yet is submodules. For example:
> 
> git init sub &&
> test_commit -C sub file &&
> git submodule add ./sub &&
> git commit -m sub &&
> git sparse-checkout set 'sub/' &&
> git mv sub sub2
> 
> Erroneously gives:
> The following paths and/or pathspecs matched paths that exist
> outside of your sparse-checkout definition, so will not be
> updated in the index:
> sub
> 
> But it works if we change DT_REG to DT_UNKNOWN in
> path_in_sparse_checkout(). So, I'm not sure, should we use DT_UNKNOWN
> for all calls?

This is interesting. Submodules aren't controlled by the sparse-checkout,
so we should probably check the cache entry to see if it is a gitlink
and skip the path_in_sparse_checkout() if so.

Good find!
-Stolee

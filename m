Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113B9C54EED
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 20:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjAXULu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjAXULi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 15:11:38 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F8D42DFD
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 12:11:37 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 207so11996767pfv.5
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 12:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDSKxmj2VZvK7OavQ4caAtMBCCme82VxRJbktmWDaJg=;
        b=XDZzwvKh24d8X6Eo7lcY7k6FRY3nqDGUwgibTB0UVrsF3J/cFqxnc36XX250f4kxgq
         EoE5gFETwKWTh0Fe+s9iMednxnvCNvVcZnssexn1sw9VhxvgX41RJrtSZnmh7OA4/B8Q
         O6KyqLr2XAXu2A2K8+tNS2OtWOkCe2OAAI96sCXW0NN5yMOLGtWe8eX9UqzHkP3aRFxS
         T7gtMX3tqk3JriUO7bJmdPhcSo/3k0Q5mXb5ji8/Exrn5YKPXAZkFHNMwDOdiJr04Ex1
         clhEuKcJdzbXpDv3CUvlaK/giZSE5kahqxUJYnJX4VcjGRgQOG+cl8PhCMPYiRGEoNoL
         4kJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDSKxmj2VZvK7OavQ4caAtMBCCme82VxRJbktmWDaJg=;
        b=lZ+I9/Vx6vQ9UfGBuccbWDzHzoT3NqPQC7xct/nPoAQm4kGFFLvUa1lqsKGhu9305t
         HbjjsC47RuspYrZFGhaSCBwloyk91izfl9tF/1qYCS8onWpOMkym/Q7jJb6jBlNSABEb
         d6CQtTiRnZp32PhzlsRjrF91YLKUOaeKoYsuZtzfbILxFyQr90jl9z9Axln8njT1hTlA
         ck989AEvuPhXdw/iOj/aQdLpVrF+lPT0/iNyvOL0q9lV24Dtt7j3BqCLOfwJ4TZuJsQT
         jYfjJ8FFQ2MmvnArLB29OiyNMHp3Kt5Mye5Sxj54kcpfVbvTvDXS/ulBtAu+7jVnp/37
         f2eQ==
X-Gm-Message-State: AFqh2ko+4ytj4vT5WjvF9YK3xRmZYvShSk9SHHL6/qHPQD4SIkiJSFvu
        eJJr0MbMrfefA6eKe+l66QDJ
X-Google-Smtp-Source: AMrXdXsyOTd6CaTNyuTYFUZxzqm3exXf09QMVwCxjKAT0TrCUARnuIoXTiQKsLpalHBDcTKtOJ/VSg==
X-Received: by 2002:a62:3244:0:b0:583:2971:df8b with SMTP id y65-20020a623244000000b005832971df8bmr25066271pfy.20.1674591096893;
        Tue, 24 Jan 2023 12:11:36 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id c9-20020a056a000ac900b0058b927b9653sm2072168pfl.92.2023.01.24.12.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 12:11:36 -0800 (PST)
Message-ID: <7ccf7b17-4448-5ef4-63b1-9073a400e486@github.com>
Date:   Tue, 24 Jan 2023 12:11:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
Content-Language: en-US
To:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Sprent via GitGitGadget wrote:
> From: William Sprent <williams@unity3d.com>
> 
> There is currently no way to ask git the question "which files would be
> part of a sparse checkout of commit X with sparse checkout patterns Y".
> One use-case would be that tooling may want know whether sparse checkouts
> of two commits contain the same content even if the full trees differ.
> Another interesting use-case would be for tooling to use in conjunction
> with 'git update-index --index-info'.

These types of use cases align nicely with "Behavior A" as described in
'Documentation/technical/sparse-checkout.txt' [1]. I think adding a
'--scope=(sparse|all)' option to 'ls-trees' would be a good way to make
progress on the goals of that design document as well as serve the needs
described above.

[1] https://lore.kernel.org/git/pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com/

> 
> 'rev-list --objects --filter=sparse:oid' comes close, but as rev-list is
> concerned with objects rather than directory trees, it leaves files out
> when the same blob occurs in at two different paths.
> 
> It is possible to ask git about the sparse status of files currently in
> the index with 'ls-files -t'. However, this does not work well when the
> caller is interested in another commit, intererested in sparsity
> patterns that aren't currently in '.git/info/sparse-checkout', or when
> working in with bare repo.

I'm a bit confused by your described use cases here, though. Right now,
'sparse-checkout' is a local repo-only optimization (for performance and/or
scoping user workspaces), but you seem to be implying a need for
"sparse-checkout patterns" as a general-purpose data format (like a config
file or 'rebase-todo') that can be used to manually configure command
behavior.

If that is what you're getting at, it seems like a pretty substantial
expansion to the scope of what we consider "sparse checkout". That's not to
say it isn't a good idea - I can definitely imagine tooling where this type
of functionality is useful - just that it warrants careful consideration so
we don't over-complicate the typical sparse-checkout user experience. 

> 
> To fill this gap, add a new argument to ls-tree '--sparse-filter-oid'
> which takes the object id of a blob containing sparse checkout patterns
> that filters the output of 'ls-tree'. When filtering with given sparsity
> patterns, 'ls-tree' only outputs blobs and commit objects that
> match the given patterns.

I don't think a blob OID is the best way to specify an arbitrary pattern set
in this case. OIDs will only be created for blobs that are tracked in Git;
it's possible that your project tracks potential sparse-checkout patterns in
Git, but it seems overly restrictive. You could instead specify the file
with a path on-disk (like the '--file' options in various commands, e.g.
'git commit'); if you did need to get that file from the object store, you
could first get its contents with 'git cat-file'. 

> 
> While it may be valid in some situations to output a tree object -- e.g.
> when a cone pattern matches all blobs recursively contained in a tree --
> it is less unclear what should be output if a sparse pattern matches
> parts of a tree.
> 
> To allow for reusing the pattern matching logic found in
> 'path_in_sparse_checkout_1()' in 'dir.c' with arbitrary patterns,
> extract the pattern matching part of the function into its own new
> function 'recursively_match_path_with_sparse_patterns()'.
> 
> Signed-off-by: William Sprent <williams@unity3d.com>
> ---
>     ls-tree: add --sparse-filter-oid argument
>     
>     I'm resubmitting this change as rebased on top of 'master', as it
>     conflicted with the topic 'ls-tree.c: clean-up works' 1
>     [https://public-inbox.org/git/20230112091135.20050-1-tenglong.tl@alibaba-inc.com],
>     which was merged to 'master' recently.
>     
>     This versions also incorporates changes based on the comments made in 2
>     [https://public-inbox.org/git/CAPig+cRgZ0CrkqY7mufuWmhf6BC8yXjXXuOTEQjuz+Y0NA+N7Q@mail.gmail.com/].
>     
>     I'm also looping in contributors that have touched ls-tree and/or
>     sparse-checkouts recently. I hope that's okay.

Definitely okay, thanks for CC-ing!

Overall, this is an interesting extension to 'sparse-checkout', and opens up
some opportunities for expanded tooling. However, at an implementation
level, I think it's addressing two separate needs ("constrain 'ls-files' to
display files matching patterns" and "specify sparse patterns not in
'.git/info/sparse-checkout'") in one option, which makes for a somewhat
confusing and inflexible user experience. What about instead breaking this
into two options:

* --scope=(sparse|all): limits the scope of the files output by ("Behavior
  A" vs. "Behavior B" from the document linked earlier). 
* --sparse-patterns=<file>: specifies "override" patterns to use instead of
  those in '.git/info/sparse-checkout' (whether 'sparse-checkout' is enabled
  for the repository or not).

I haven't looked at your implementation in detail yet, but I did want to
offer a recommendation in case you hadn't considered it: if you want to
allow the use of patterns from a user-specified specific file, it would be
nice to do it in a way that fully replaces the "default" sparse-checkout
settings at the lowest level (i.e., override the values of
'core_apply_sparse_checkout', 'core_sparse_checkout_cone', and
'get_sparse_checkout_filename()'). Doing it that way would both make it
easier for other commands to add a '--sparse-patterns' option, and avoid the
separate code path ('path_in_sparse_checkout_1()' vs.
'recursively_match_path_with_sparse_patterns()', for example) when dealing
with '.git/info/sparse-checkout' patterns vs. manually-specified patterns.

>     
>     William
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1459%2Fwilliams-unity%2Fls-tree-sparse-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1459/williams-unity/ls-tree-sparse-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1459


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED10C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 20:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiKGUpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbiKGUox (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 15:44:53 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52291D1
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 12:44:52 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id c8so8937622qvn.10
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 12:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qRgQ3LBGocpRqTOrMjtNrHJFT6VcCv4KY3zBHuDK4rQ=;
        b=iEgf+x3g5Fd88ZC6ryzd5V0fs9FnJAw0ezUhiKUr1W6iPLZXQNCz3p/WId687VTJRf
         74U7ay1QDGJUEkg5bohOoxH20qHBAxMyvrX6+9BUuNrFmr9uYZF4BufWZzx7VZ0VLQ/y
         jL7YNXsKCY1J1IRH10S55bPcab9MAMN/wvBwXN3bHXiLZM4nQr2nt7TnoR/Dy/axZwN1
         kLiKXul9fWkhlXZynmDDhpwXB+BlsQhpr1uhw1IG3NerucCzywL162oBDt0n7FIuX0lh
         WLLsYAwdpp7wgTralIhsCXsDlDeCNKmNuiqzkWs2sYG484B3NuHcOTNbnCdLwgTK6vFU
         Oxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRgQ3LBGocpRqTOrMjtNrHJFT6VcCv4KY3zBHuDK4rQ=;
        b=3GnghXlrSkbTX/Zp/MTr6lNYP/Jkm6CQOH8QwSqkHziHbtm+b4qtnyiagvMjOnSQ1o
         AKx4gTdrEFejlUl3EcJVv9nm2QZO2z1GDQ362A6caGDNSDUpo97u+sCMmP46z9mUluqg
         vPcPPMo9YJplXE9oysoJvU+qsMm0AMoIIyysAevxBAIvR7mwq+GiB80/Os2xzJ2M4FZU
         3yRlOiJpgttsHw+B3D2JC5fSpeQoUEQAHaBJPGXZRo/Ka3pgFqJhinvV0bUu4fRNMus4
         e1EwQuUS1V3Ao8dwX08JbZFcfmZ28Q7AirPciPIaHBxic/ox49KCOpZLtUGCMIpYK04i
         QXgw==
X-Gm-Message-State: ACrzQf3Mz8/ByN620qG5LZq9Zg7Cu6oXczFSjGsKgyZb7bobez7S9UpP
        AVOWL7qHvfc5h27N+tJEiNZs
X-Google-Smtp-Source: AMsMyM5jd6NaM0K4/2EkMvc7wQwHn1fTNEcVCMKbDBSugBQqfQAidanA+wXnUOZov3V4IkSEQtReRw==
X-Received: by 2002:a05:6214:2a8b:b0:4bc:28b0:1cb with SMTP id jr11-20020a0562142a8b00b004bc28b001cbmr26060066qvb.113.1667853891763;
        Mon, 07 Nov 2022 12:44:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id bm7-20020a05620a198700b006ce1bfbd603sm7487652qkb.124.2022.11.07.12.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:44:51 -0800 (PST)
Message-ID: <f3345a9e-e7f1-4230-d30a-0608eb69513d@github.com>
Date:   Mon, 7 Nov 2022 15:44:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v4] sparse-checkout.txt: new document with sparse-checkout
 directions
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Martin von Zweigbergk <martinvonz@google.com>
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/6/22 1:04 AM, Elijah Newren via GitGitGadget wrote:

> The --sparse-index work has been mostly complete (or at least released
> into production even if some small edges remain) for quite some time
> now.  We have also had several discussions on flag and config names,
> though we never came to solid conclusions.  Stolee once upon a time
> suggested putting all these into some document in
> Documentation/technical[3], which Victoria recently also requested[4].
> I'm behind the times, but here's a patch attempting to finally do that.

This is a correct summary of where the sparse index feature is right now.

It also is a highly-requested document. Thank you for working so hard on
it and sorry for being slow to sign off on your edits since v1.

Today, I'm rereading the whole document anew, but I'll avoid any nits
since I think you are converging on a solid foundation for us to build on.

Mostly, if you asked a question in the doc, I'll reply. Nothing is binding
since the point is to ask the question in the context of the problem
statement and examples. We should remember to update this document when we
actually implement the options, so the decisions are documented here
instead of leaving answered questions lingering.

> +  * Do the options --scope={sparse,all} sound good to others?  Are there better
> +    options?
> +    * Names in use, or appearing in patches, or previously suggested:
> +      * --sparse/--dense
> +      * --ignore-skip-worktree-bits
> +      * --ignore-skip-worktree-entries
> +      * --ignore-sparsity
> +      * --[no-]restrict-to-sparse-paths
> +      * --full-tree/--sparse-tree
> +      * --[no-]restrict
> +      * --scope={sparse,all}
> +      * --focus/--unfocus
> +      * --limit/--unlimited

I'm partial to --scope={sparse|all} (with the option to add another
value if we see the need).

> +  * If a config option is added (sparse.scope?) what should the values and
> +    description be?  "sparse" (behavior A), "worktree-sparse-history-dense"
> +    (behavior B), "dense" (behavior C)?  There's a risk of confusion,
> +    because even for Behaviors A and B we want some commands to be
> +    full-tree and others to operate sparsely, so the wording may need to be
> +    more tied to the usecases and somehow explain that.  Also, right now,
> +    the primary difference we are focusing is just the history-querying
> +    commands (log/diff/grep).  Previous config suggestion here: [13]

Personally, I think we should have the same values for 'sparse.scope' and
'--scope=<X>'. For now, let's pick one behavior for the 'sparse' value and
we can add a new value to differentiate between A and B when necessary in
the future.

> +  * Is `--no-expand` a good alias for ls-files's `--sparse` option?
> +    (`--sparse` does not map to either `--scope=sparse` or `--scope=all`,
> +    because in non-cone mode it does nothing and in cone-mode it shows the
> +    sparse directory entries which are technically outside the sparse
> +    specification)
> +
> +  * Under Behavior A:
> +    * Does ls-files' `--no-expand` override the default `--scope=all`, or
> +      does it need an extra flag?
> +    * Does ls-files' `-t` option imply `--scope=all`?
> +    * Does update-index's `--[no-]skip-worktree` option imply `--scope=all`?

Since the --no-expand option is rather new, and we have a big experimental
banner on the sparse-checkout documentation, it might be good to plan for
a deprecation of these non-standard options. We could start by making them
aliases for the --scope=sparse option, but with a warning that the option
is deprecated and we will _remove_ the option in a future version. We can
document here which versions we expect those removals to happen.

> +  * sparse-checkout: once behavior A is fully implemented, should we take
> +    an interim measure to ease people into switching the default?  Namely,
> +    if folks are not already in a sparse checkout, then require
> +    `sparse-checkout init/set` to take a
> +    `--set-scope=(sparse|worktree-sparse-history-dense|dense)` flag (which
> +    would set sparse.scope according to the setting given), and throw an
> +    error if the flag is not provided?  That error would be a great place
> +    to warn folks that the default may change in the future, and get them
> +    used to specifying what they want so that the eventual default switch
> +    is seamless for them.

I'm not sure that we need a warning here. I think picking an initial default
is good enough. Let's reconsider this warning after we have more implementation
changes that provide a choice between behaviors A and B.

> +=== Implementation Goals/Plans ===
> +
> + * Get buy-in on this document in general.

Consider me bought-in.

> + * Figure out answers to the 'Implementation Questions' sections (above)
> +
> + * Fix bugs in the 'Known bugs' section (below)
> +
> + * Provide some kind of method for backfilling the blobs within the sparse
> +   specification in a partial clone
> +
> + [Below here is kind of spitballing since the first two haven't been resolved]

We can update this document as we gain clarity after the first few updates.

> + * update-index: flip the default to --no-ignore-skip-worktree-entries,
> +   nuke this stupid "Oh, there's a bug?  Let me add a flag to let users
> +   request that they not trigger this bug." flag
> +
> + * Flags & Config
> +   * Make `--sparse` in add/rm/mv a deprecated alias for `--scope=all`

This '--sparse' deprecation can eventually be a removal, I think.

> +   * Make `--ignore-skip-worktree-bits` in checkout-index/checkout/restore
> +     a deprecated aliases for `--scope=all`

This one might be harder to remove since it's much older. We can consider
it, though.

> +   * Create config option (sparse.scope?), tie it to the "Cliff notes"
> +     overview

Implementation detail: it might be nice to create a parse-opt macro that
will read the '--scope={sparse|all}' command-line option but _also_
create a method to initialize the value to the 'sparse.scope' config
option. These can both happen with the very first implementation of the
command-line option and all future integrations can follow that pattern to
get both options.

Thanks for working so hard on this doc. I think this version is ready to
merge down. Let's get started on this work. I'm excited!

Thanks,
-Stolee

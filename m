Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A98C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 15:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A97D613D3
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 15:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbhKQPoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238539AbhKQPnw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 10:43:52 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CE7C061767
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 07:40:54 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so5404783otj.7
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 07:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w1P03EdcskMGccseszVYgWaMRGCIJDVhHLP9AzHeYBA=;
        b=gUBVxzBmdXwPfWcteR/YN67gbHvuZpQeG7Wzo6Y3Mmc1rSvClB7/Cf+SG4vVTXsKOI
         A/tLpvrMYPuUn6unAdR6816CHCVYGt6XrE9myOPQl9+VQBvDK+zg1w+P1fOp18KgezCO
         aePsQKi24O/EDOYvtgKWvDcsyerM2nLxXKPV5Hq5bYT9AWduGPbUkJ46I00Lu3Q6V1Wt
         Y7BvV4LMC/Q/jOcigvaKa0gEvvgxUxuWqVoD7P4xeHN1GhNWOZA5jWMFui/dq8Puqx1V
         GCGlvU9KKUOUurM0wrx8f5AOYp/WInNJclxkV9Xd0I8rHDsM3ZzmNX4z115eV6F6A8bt
         omqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w1P03EdcskMGccseszVYgWaMRGCIJDVhHLP9AzHeYBA=;
        b=toWlXsIzncStdDJorJuhPab0xmbS/mNPDSIIzGrffu5eQAONb/C+FGFIFmDhWCKLPI
         9y41rL7ZJeC1aPlQ110tkNc8wtpsZ6Net7xP2ZENx2kH8tQ/nf6AXeqqD1IWZLlP2tBs
         FMtYqz+GMPTnxaMFZ6vsJIZvBdJFOOF2DiERaZUJVo1lpY5zrOAGn7GEq0D2EuIaOTtx
         RL1styDCBVXaQd075DwUv6H6kqTMGrptuWKoToOGr3lCSGfdBcRXvWJndYkk2JQE6XVN
         nG7CkObf0MpRACip/puG7pj0UpUqACz/wFE5R5bIQmVNzRxAo1woC8SZX5c19F005J0P
         m/gQ==
X-Gm-Message-State: AOAM530VoCLgWbgXvDQI/fohaxReO5ac6/An06VHqJeujjr+hVl0vvkI
        sX6yrQSV+8e0Fdf/fI4OmdPC3Em2Q8Y=
X-Google-Smtp-Source: ABdhPJwFOgsUzThHA8F4KyWdNtZMdOU50wfx7qWBRl7KTsRYfEdKQxY0/3FalR1owO533EHN9MqSNg==
X-Received: by 2002:a05:6830:1690:: with SMTP id k16mr14470041otr.148.1637163653500;
        Wed, 17 Nov 2021 07:40:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d1ee:6c8f:319:f5? ([2600:1700:e72:80a0:d1ee:6c8f:319:f5])
        by smtp.gmail.com with ESMTPSA id o6sm9101oou.41.2021.11.17.07.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:40:52 -0800 (PST)
Message-ID: <f674b1fe-87d4-2598-874c-7c3984d0ee92@gmail.com>
Date:   Wed, 17 Nov 2021 10:40:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v7 01/17] scalar: add a README with a roadmap
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
 <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
 <3aa095dc824ea7f659e6c11aa2c21be6cadbe985.1637158762.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <3aa095dc824ea7f659e6c11aa2c21be6cadbe985.1637158762.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2021 9:19 AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The Scalar command will be contributed incrementally, over a bunch of
> patch series. Let's document what Scalar is about, and then describe the
> patch series that are planned.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/scalar/README.md | 71 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 contrib/scalar/README.md
> 
> diff --git a/contrib/scalar/README.md b/contrib/scalar/README.md
> new file mode 100644
> index 00000000000..7898a683ba5
> --- /dev/null
> +++ b/contrib/scalar/README.md
> @@ -0,0 +1,71 @@
> +# Scalar - an opinionated repository management tool
> +
> +Scalar is an add-on to Git, helping Git scale to very large repositories and
> +worktrees.

I would rephrase this as "Scalar is an add-on to Git that helps users take
advantage of advanced performance features in Git."

Git scales just fine, only it helps to enable some features that are off
by default.

> Originally implemented in C# using .NET Core, based on the learnings
> +from the VFS for Git project, most of the techniques developed by the Scalar
> +project have been integrated into core Git already:
> +
> +* partial clone,
> +* commit graphs,
> +* multi-pack index,
> +* sparse checkout (cone mode),
> +* scheduled background maintenance,
> +* etc
> +
> +This directory contains the remaining parts of Scalar that are not (yet) in
> +core Git.
> +
> +## Roadmap
> +
> +The idea is to populate this directory via incremental patch series and
> +eventually move to a top-level directory next to `gitk-git/` and to `git-gui/`. The
> +current plan involves the following patch series:
> +
> +- `scalar-the-beginning`: The initial patch series which sets up
> +  `contrib/scalar/` and populates it with a minimal `scalar` command that
> +  demonstrates the fundamental ideas.
> +
> +- `scalar-c-and-C`: The `scalar` command learns about two options that can be
> +  specified before the command, `-c <key>=<value>` and `-C <directory>`.
> +
> +- `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
> +
> +- `scalar-and-builtin-fsmonitor`: The built-in FSMonitor is enabled in `scalar
> +  init` and in `scalar clone`, for an enormous performance boost when working
> +  in large worktrees. This patch series necessarily depends on Jeff Hostetler's
> +  FSMonitor patch series to be integrated into Git.

You say 'scalar init' but do you mean 'scalar register'?

> +- `scalar-gentler-config-locking`: Scalar enlistments are registered in the
> +  user's Git config. This usually does not represent any problem because it is
> +  rare for a user to register an enlistment. However, in Scalar's functional
> +  tests, Scalar enlistments are created galore, and in parallel, which can lead
> +  to lock contention. This patch series works around that problem by re-trying
> +  to lock the config file in a gentle fashion.
> +
> +- `scalar-extra-docs`: Add some extensive documentation that has been written
> +  in the original Scalar project (all subject to discussion, of course).
> +
> +- `optionally-install-scalar`: Now that Scalar is feature (and documentation)
> +  complete and is verified in CI builds, let's offer to install it.
> +
> +- `move-scalar-to-toplevel`: Now that Scalar is complete, let's move it next to
> +  `gitk-git/` and to `git-gui/`, making it a top-level command.

This final one is where we can make the final call about where Scalar should
exist in the tree and how optional it should be. This would also move the
Scalar man pages into Documentation/, along with possibly the docs from
'scalar-extra-docs', and the tests into t/. The benefit of leaving this until
the end is that we can see the entirety of Scalar before making a final call.

> +The following two patch series exist, but there is no plan to integrate them
> +into Git's source tree:
> +
> +- `scalar-with-gvfs`: The primary purpose of this patch series is to support
> +  existing Scalar users whose repositories are hosted in Azure Repos (which
> +  does not support Git's partial clones, but supports its predecessor, the GVFS
> +  protocol, which is used by Scalar to emulate the partial clone).
> +
> +  Since the GVFS protocol will never be supported by core Git, this patch
> +  series will remain in Microsoft's fork of Git.
> +
> +- `run-scalar-functional-tests`: The Scalar project developed a quite
> +  comprehensive set of integration tests (or, "Functional Tests"). They are the
> +  sole remaining part of the original C#-based Scalar project, and this patch
> +  adds a GitHub workflow that runs them all.
> +
> +  Since the tests partially depend on features that are only provided in the
> +  `scalar-with-gvfs` patch series, this patch cannot be upstreamed.

These topics (in some form or another) exist on microsoft/git and are available
via GPL, so we don't intend to say "we are withholding these patches" but instead
are saying "We don't think the Git community is interested in these patches."
There are some interesting ideas there, but the implementation is too specific to
Azure Repos to be of much help in general. These still exist mainly because the
GVFS protocol is what Azure Repos has instead of partial clone. We are focused
instead on improving partial clone.

Thanks,
-Stolee

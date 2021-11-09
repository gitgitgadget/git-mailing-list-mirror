Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB2CC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 15:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD1961205
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 15:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbhKIQBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 11:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbhKIQBq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 11:01:46 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16F2C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 07:58:59 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so19337997otj.5
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 07:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ChhHIsxfF5zBPD1OYESwvDSLOzuj2fI7B32nWlSOu9Y=;
        b=aYzc+W1PeweUzvtqDkRjiQTChQtUiO9XjMjVh847+48SOC2NgOIYFMNs8bMMacq7zo
         7cBMQ8tx2Jf7crTcjyseXhGSahZ4hGczqtFkKrsBbtZSxoKDwuED2BV2P5vTyv7Uq7rT
         UoKWXdBZXHcBkGSwKZkZadGjrAvoOAa2j0mVixUn5r17uSqYbIeBUaSRCPmP06/oxrnt
         er05YpurIPuQZ5BmgMgDE5vIL/qbeLguyM4TVdwFwa6izgt0lYHsNewx9s4VqJeAOvSB
         I4QSV6nbyDSuyZNQs0ci+XWXxyxYS6VY9jnC5RDQcO1FT2UYyPP+uFYvFXcMtRavW+oM
         RQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ChhHIsxfF5zBPD1OYESwvDSLOzuj2fI7B32nWlSOu9Y=;
        b=wYxPmF8H2ts6MF/BvXPQP9vD5oCWVylJwD8cI3PQFt7rmpboS9a+1QpEnCWbj7AoD6
         tJ0XYrMV4xaFi5sPGfW1FFpvRFym2ECEBHpsWButU2dHEy10oSJNuWheb6Wt9Zy6v29X
         7lNGn+ia6HwEOaL8uViRsOblwZ64mDGd1/9m1MZV12oiEGJSwq63EJ8/Qn7sTJW41zz+
         a1+hg9vhc8UAINxYU8Y/gVboWJiijjYauqe1+z17fdYQcafREvruSeZ4/NnKz1A33idR
         E0C/1e5LhwAL7lVc4o3gzgYzSejNYtbCSQNsZniWH8mJkbgpqXeBXavvQarUjH3gtiR4
         52Lg==
X-Gm-Message-State: AOAM531Xn2QoReBjc9z7dIx8YlyRM7ok0iBmmbCGn+ZBS9JF8BpBJVbS
        luVbnN221Yy6rMsNibN2THM=
X-Google-Smtp-Source: ABdhPJxCfQOoQhDvGTVKPu+zLk9b98YX3Qn3QzCH/xEuUwUf1sPg8bqH83N3/JhI11xzL6TjELsSYQ==
X-Received: by 2002:a9d:7289:: with SMTP id t9mr6548962otj.1.1636473539302;
        Tue, 09 Nov 2021 07:58:59 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:7df4:7637:c299:db4f? ([2600:1700:e72:80a0:7df4:7637:c299:db4f])
        by smtp.gmail.com with ESMTPSA id n22sm804750oop.29.2021.11.09.07.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 07:58:58 -0800 (PST)
Message-ID: <82efc900-8518-3bb3-2524-8997475f1a45@gmail.com>
Date:   Tue, 9 Nov 2021 10:58:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v5 0/4] cache parent project's gitdir in submodules
Content-Language: en-US
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20211104234942.3473650-1-emilyshaffer@google.com>
 <920c3133-b6ee-b82c-0876-f06713e9337b@gmail.com>
 <YYmuqEQUaB1a8Gs1@google.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YYmuqEQUaB1a8Gs1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/8/2021 6:11 PM, Emily Shaffer wrote:

> Yeah, I think we may be overthinking it, especially with the concerns
> about common dir vs. gitdir. More specifically - I think we accidentally
> did the right thing in the previous iteration by using the gitdir :)
> 
> I think we can probably put it pretty simply:
> submodule.superprojectGitDir should point from the most local gitdir of
> the submodule to the most local gitdir of the superproject.
> 
> Luckily there are not so many permutations to worry about here.
> 
> Super doesn't have worktrees, sub doesn't have worktrees:

> Super doesn't have worktrees, sub does have worktrees (and as you
> suggest above, right now this would have to be created carefully and
> manually, but later we probably want this to Just Work):

> Super has worktrees, sub doesn't have worktrees:
> Actually, I think in the future this might not be possible, if we want
> to make `git worktree add --recurse-submodules` work gracefully (and I
> do want that). But in the interim, in practice it looks like this:

> Both super and sub have worktrees:
> And this won't exist until we have graceful support of `git worktree add
> --recurse-submodules` or with some manual effort, now.

> I think this will give us access to both the worktree gitdir *and* the
> common gitdir:
> 
>   ~/git/.git/worktrees/git-second [GIT_DIR!]$ git rev-parse --git-common-dir
>   /usr/local/google/home/emilyshaffer/git/.git
> 
> So that means from any submodule, we can determine:
>  - submodule's gitdir (from the .git link in the submodule wt)
>  - submodule's common dir (from existing commands)
>  - gitdir of superproject which submodule inhabits (from the config in
>    the submodule's gitdir, or the submodule's config.worktree)
>  - common dir of superproject (from existing commands + prior config)
> 
> The upshot to me, then, means that we should be 1) making sure to get
> the path to the gitdir, not the common dir, of the superproject; and 2)
> using helpers to write to the worktree config, not to the local config,
> of the submodule. In other words, we want to avoid the following:
> 
> .git/
>   modules/
>     sub/
>       worktrees/
>         wt/
> 	  config
>       config <- "submodule.superprojectGitDir = ../../../.." as written by the worktree
> 
> Will take a look at the rest of the comments too, but this sounds like a
> reasonable approach to me.

I agree, that this seems reasonable. Spelling it out carefully like this,
along with your list of possibilities, clarifies where the data is located
and how we can construct any information we need from that.

You point out that there are cases that can be a bit tricky to get into
with current features, but this config approach won't make that any worse
right now.

Thanks,
-Stolee

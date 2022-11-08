Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0ADC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 13:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbiKHNcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 08:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiKHNcM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 08:32:12 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E524FF94
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 05:32:11 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id l15so8620408qtv.4
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 05:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAt1ra/nI/En09z75t5WTP3JJGFMTQOW7/UKPw3PgNY=;
        b=T7jJGcZmd4QwO3RDznNNIanDy2ynnyRX6mVTg3txCVV/9sH2VJiQ1ilzOggBGkRvc7
         p0AOHwl93JBtTuAmTiE8rS+8qXdWoIacpNHSW4CP4J+eO6rvmf4i3LczI2jnRYUnbQ8c
         QsqbimVeBwtTDYH7JtlQF5ejJzDDPz0zbnyb7duK8IB9OKdU+A9EMxldQthPo7CGe6pR
         fKh16iHOdajbQT9u3m8oXDCgvKWY5ID/R9zRVz30EIjd+VBC1s0EJNqsPUwgEHX5JuW1
         4F0uiRe2aENBUajyiOZfToZWxyCsPHbbLsPvUxe24EJ6CkcLKO/zusl8PrZiCMIFxN32
         g0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAt1ra/nI/En09z75t5WTP3JJGFMTQOW7/UKPw3PgNY=;
        b=td1fa/o21gpZ6Bj1i4VPSRmLIbMOycM1kz3ZwnUNdCt86pNBX02Z7oTPngkRAVzZYU
         pgbpwlQIZy4SPCIv+sTnEuOFconN5EZb6fLxLfV1SMtzoVmLZofD3xq70UCREXhvKwRz
         ZTBYx6SYOdIvuGv1lVCeASqgpCUFDJ3v7wH0fdV1vbXAmo7zAfat3I0OoLzewFA06DKv
         2YR9T9SsEnsqa30B3EKyLa4eUwy4l2sUc43a6qZhpyBQiGSFtgMdFogKIE9I/7h7Dypo
         TmaJj29lcdWRoW76I0t+gBl1nxnroGqfkpKAb8rkPkUs/Md0f3S9phmnp7lr5RLsWsBv
         QbFA==
X-Gm-Message-State: ACrzQf213W+8kTEdwk8bil18lTKz9kdEY7gl3xNLo3z9DPE6ZW4ywfRT
        2sEYd2hD2TD2pQWILbMCV6M=
X-Google-Smtp-Source: AMsMyM6l6VKTZ7YNRxuQ34KVnSlgDIvJjtxQAaKReL0mgdaTYSYdYqmQS0nkMSOYnn2hyH521gHjaw==
X-Received: by 2002:ac8:6b46:0:b0:3a5:57f1:5159 with SMTP id x6-20020ac86b46000000b003a557f15159mr20514317qts.421.1667914330369;
        Tue, 08 Nov 2022 05:32:10 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id n16-20020a05620a295000b006f9ddaaf01esm9485047qkp.102.2022.11.08.05.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 05:32:09 -0800 (PST)
Subject: Re: [PATCH v3 1/8] clone: teach --detach option
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
 <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
 <432bc7cb3a42cf39d0033701c2cc677c9109b3dd.1666988096.git.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <6b17b06e-8217-ce56-0733-5501d81fe433@gmail.com>
Date:   Tue, 8 Nov 2022 08:32:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <432bc7cb3a42cf39d0033701c2cc677c9109b3dd.1666988096.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2022-10-28 à 16:14, Glen Choo via GitGitGadget a écrit :
> From: Glen Choo <chooglen@google.com>
> 
> Teach "git clone" the "--detach" option, which leaves the cloned repo in
> detached HEAD (like "git checkout --detach"). In addition, if the clone
> is not bare, do not create the local branch pointed to by the remote's
> HEAD symref (bare clones always copy all remote branches directly to
> local branches, so the branch is still created in the bare case).
> 
> This is especially useful in the "submodule.propagateBranches" workflow,
> where local submodule branches are named after the superproject's
> branches, so it makes no sense to create a local branch named after the
> submodule's remote's branch.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  Documentation/git-clone.txt |  8 +++++++-
>  builtin/clone.c             | 12 +++++++++---
>  t/t5601-clone.sh            | 22 ++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index d6434d262d6..6a4e5d31b46 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -16,7 +16,7 @@ SYNOPSIS
>  	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
>  	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
>  	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
> -	  [--filter=<filter> [--also-filter-submodules]] [--] <repository>
> +	  [--filter=<filter> [--also-filter-submodules] [--detach]] [--] <repository>
>  	  [<directory>]
>  
>  DESCRIPTION
> @@ -210,6 +210,12 @@ objects from the source repository into a pack in the cloned repository.
>  	`--branch` can also take tags and detaches the HEAD at that commit
>  	in the resulting repository.
>  
> +--detach::
> +	If the cloned repository's HEAD points to a branch, point the newly
> +	created HEAD to the branch's commit instead of the branch itself.
> +	Additionally, in a non-bare repository, the corresponding local branch
> +	will not be created.
> +


"point the newly created HEAD to the branch's tip commit"
would be slightly clearer, I think.

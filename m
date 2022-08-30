Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8602ECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 04:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiH3EDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 00:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiH3EC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 00:02:59 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E987AA4ED
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 21:02:58 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j1so7849846qvv.8
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 21:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=J+3Y7xGnjBfr2PToAHu+RI9tGVLYUX594MLpSXBZJag=;
        b=Xt92tN7urhq5UD0hR0nNewIxP0GFpmhuXZw/+4Uux57wu+zs5YCRrFNIsLcyBtEdBF
         N9NOmQ+G0cfk5K3ZkXRN9TQivIX3dmJOn76W4QLJhvfWuOmHJzwyETViDs5FjxWGIxkp
         jknAHLO0geeINx8FErknQ74pRqENB9omgGOnQoQz6l77ujTZ0M/SSs0WAZR21o7db04J
         GB7voCswVC7+xkO2NhJPHGWZv4nIH9pncbaYdLszzB0W1C8KMLOFGhOGQxwl2vcgdaJb
         Ac312dyIZvudqf1WT2Ap8IhhhQYZoPGPx2Mrw6iYH4ghi4M0G5e09IcLz+f/sBxRXiza
         xrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=J+3Y7xGnjBfr2PToAHu+RI9tGVLYUX594MLpSXBZJag=;
        b=s/CowvKOSpl7mKEDOImist+Y+WEQomTCH5gkJM5W8EJy3lWY7iJdOfs6AE3ZM1lhBv
         B4G5h/Dqro6bW0fIKrYm9I9ToBULgxFemh7jbKQ1dQzvpoc2VUtQxfQbxAvMGsTyALZi
         tHi8eiGTp+/wrl1KhHXNMr1bxLRsmKrLx4Nf9+DLMX+PsnVPHpFTViqQoMbrDLDCMJ7U
         ywtBJW+RtMOMzSDzWmiVC79MxvMHJLmZErHs1rbubNn/MJoJkkgDdYH04CawwNXrUIg0
         RQnr7cA2MX7TQZxEUO5/oRY0yTiLmE9JX1jUDoqqDzyz5l6g5ZS+7fMXTYAwdtMRXN/A
         276g==
X-Gm-Message-State: ACgBeo1dOyh0kcY9d2630ocqNBov2Qryr2i/9flEynvjHHFRwax+l0oM
        rvBGsUjDYEMZX6OTuLoCzMs=
X-Google-Smtp-Source: AA6agR4Q2bisMvsXQB7pu5/156PE+B/9/4wlbZbtW11o7R0NM8s47AWxDHhRrpWDpHxVHmtARhsIWQ==
X-Received: by 2002:a0c:8c07:0:b0:496:e2ef:f920 with SMTP id n7-20020a0c8c07000000b00496e2eff920mr13506713qvb.65.1661832177462;
        Mon, 29 Aug 2022 21:02:57 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id x13-20020a05620a258d00b006b640efe6dasm7245782qko.132.2022.08.29.21.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 21:02:57 -0700 (PDT)
Subject: Re: [PATCH 2/6] repo-settings: add submodule_propagate_branches
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
 <35f068eb0318653ee0474b30d3420d210f47f8e4.1661806456.git.gitgitgadget@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <01a3cb4a-7af1-3723-dd91-e6218b7c10c5@gmail.com>
Date:   Tue, 30 Aug 2022 00:02:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <35f068eb0318653ee0474b30d3420d210f47f8e4.1661806456.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2022-08-29 à 16:54, Glen Choo via GitGitGadget a écrit :
> From: Glen Choo <chooglen@google.com>
> 
> When processes recurse into submodules, the child processes have to
> use the same value of "submodule.propagateBranches" as the parent
> process regardless of whether the process is spawned in the superproject
> or submodule, otherwise the behavior may be inconsistent if the
> repositories don't agree on the config.
> 
> We haven't needed a way to propagate the config because because the only

"because because"

> command that reads "submodule.propagateBranches" is "git branch", which
> only has one mode of operation with "--recurse-submodules". However, a
> future commit will teach "submodule.propagateBranches" to "git submodule
> update", making this necessary.
> 
> Propagate "submodule.propagateBranches" to child processes by adding a
> corresponding GIT_INTERNAL_* environment variable and repository
> setting, and setting the environment variable inside
> prepare_submodule_repo_env(). Then, refactor builtin/branch.c to read
> the repository setting.
> 
> Using an internal environment variable is a potentially leaky
> abstraction because environment variables can come from sources besides
> the parent process. A more robust solution would be to teach Git that
> the repository is a submodule and to only read
> "submodule.propagateBranches" from the superproject config. There is WIP
> for this on the ML [1].
> 
> Another alternative would be to pass "-c submodule.propagateBranches" to
> all child processes. This is error-prone because many different
> processes are invoked directly or indirectly by "git submodule update"
> (e.g. "git submodule--helper clone", "git clone", "git checkout"). With
> an environment variable, we can avoid this work because
> prepare_submodule_repo_env() is already called for submodule child
> processes.

I think this is a good justification. I agree adding '-c' everywhere would be
error-prone.


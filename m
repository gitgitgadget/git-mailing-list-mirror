Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA04C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 01:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2372761355
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 01:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhKHB1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 20:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhKHB1b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 20:27:31 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158B2C061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 17:24:48 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so463184ote.8
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 17:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hLdqKMW9AI9xJbpmrL04E6UycOgHk3+kPbivxgqhpeI=;
        b=fWb558+F64OxMLc/gyDNuvPiFTgv2ILnPxz83hjBEXibmfnJgN9SaHan4BipiwSGg+
         4PWcD7xmGttReRVHV/zJ2nOcIQ2ye496yR88TyLj2a3puCNvEZq6zZEJiyFeL2IqaeHR
         K4t8b5klG2zNmPMA/V1lMMfZHoUstYhpCq4A43eQg86VmPU/YJ3KxOG0DEFBvl7BzH+K
         IYwUvOFoInj/zfgwrqxqT2TgCWChO4lGK6uz0SLQc9MDGa1qC1AdexQEc2AiJY1g2LpK
         kslSCThGB/i/s/fqD+KZwCoOUcFk+gtvy0ns1cXKX75qEOfndqa8DkN+nOPH4tHfMeDC
         9pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hLdqKMW9AI9xJbpmrL04E6UycOgHk3+kPbivxgqhpeI=;
        b=YBXs9Vt8cx4qQFOt8SimWgSrAou2Ua3MACbUktO7WVeGqjVWvK9eOU7K2tB1k4OvvD
         0gyqhqhKxIIsSzmeqFe26gaz6oKMBseVoHpDczG3zVIRIgYJHZooLXmUOzizCZBcAnNp
         Kox35VgxGwL+KuYuIjRToFXbD33uEXMI7Lc1wO2SRnLKgTtX8apxAaJf3PMKA5GVLxcg
         UNMHPMcJPMc2xvZzevcd18PV7ADbibo6Qjddpl8adCdmMGeaWPqAJ/cWVtPd7FWMBGF5
         PINgKU2gprHosVWNx9doZhmLyu0H0M+mVITUL1ON5EQDM6WJPAypV+E8tErUB5CTSX1k
         YKxA==
X-Gm-Message-State: AOAM531TZUbRC2bPyuicxcZ+Tw2NMmWGGcRZ6Gyrbh+H6zV0YkAyL3s3
        LPzXKPOvuglEp+dhITdWkQs=
X-Google-Smtp-Source: ABdhPJzOsTga8fTMW3xJzVLn4rPWDQP5g84UNYZ4RWwijJ5UGCv0XzdwMGp5EyL2/g0qlzHfpdYYhA==
X-Received: by 2002:a9d:7655:: with SMTP id o21mr59160945otl.126.1636334687076;
        Sun, 07 Nov 2021 17:24:47 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d408:2f91:3d1a:771e? ([2600:1700:e72:80a0:d408:2f91:3d1a:771e])
        by smtp.gmail.com with ESMTPSA id j99sm4292312otj.19.2021.11.07.17.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 17:24:46 -0800 (PST)
Message-ID: <920c3133-b6ee-b82c-0876-f06713e9337b@gmail.com>
Date:   Sun, 7 Nov 2021 20:24:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v5 0/4] cache parent project's gitdir in submodules
Content-Language: en-US
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Albert Cui <albertcui@google.com>,
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
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211104234942.3473650-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/4/2021 7:49 PM, Emily Shaffer wrote:

> The only real change here is a slight semantics change to map from
> <submodule gitdir> to <superproject common git dir>. In every case
> *except* for when the superproject has a worktree, this changes nothing.
> For the case when the superproject has a worktree, this means that now
> submodules will refer to the general superproject common dir (e.g. no
> worktree-specific refs or configs or whatnot).
> 
> I *think* that because a submodule should exist in the context of the
> common dir, not the worktree gitdir, that is ok. However, it does mean
> it would be difficult to do something like sharing a config specific to
> the worktree (the initial goal of this series).
> 
> $ROOT/.git
> $ROOT/.git/config.superproject <- shared by $ROOT/.git/modules/sub
> $ROOT/.git/modules/sub <- points to $ROOT/.git
> $ROOT/.git/worktrees/wt
> $ROOT/.git/worktrees/wt/config.superproject <- contains a certain config-based pre-commit hook
> 
> If the submodule only knows about the common dir, that is tough, because
> the submodule would basically have to guess which worktree it's in from
> its own path. There would be no way for '$WT/sub' to inherit
> '$ROOT/.git/worktrees/wt/config.superproject'.
> 
> That said... right now, we don't support submodules in worktrees very
> well at all. A submodule in a worktree will get a brand new gitdir in
> $ROOT/.git/worktrees/modules/ (and that brand new gitdir would point to
> the super's common dir). So I think we can punt on this entire question
> until we teach submodules and worktrees to play more gracefully together
> (it's on my long list...),

(I omit a portion that will be discussed later.)

> Or, to summarize the long ramble above: "this is still kind of weird
> with worktrees, but let's fix it later when we fix worktrees more
> thoroughly".

I'm concerned about punting here, because making a messy situation worse
is unlikely to have a clean way out. Could we set up a design that works
with superproject worktrees?

You mentioned that submodules cannot have worktrees. At least, you said
that 'absorbgitdirs' does not allow them. Could those subprojects still
exist and be registered as submodules without using that command?

What I'm trying to hint at is that if the submodules can't have
worktrees, then maybe we could make their 'config.worktree' files be
relative to the superproject worktrees. Then, these submodules could
point to the commondir in their base config and _also_ to the worktree
gitdir in their config.worktree.

The issue that is immediately obvious here is that my definition is
circular: we need to know the superproject worktree in order to discover
the config.worktree which contains the information about the superproject
worktree.

> and at that time we can probably introduce a
> pointer from $ROOT/.git/modules/sub/worktrees/wt/ to
> $ROOT/.git/worktrees/wt/....

Your idea here appears to assume that if the superproject has worktrees,
then the submodule is divided into worktrees in an exact correspondence.
This would allow the submodule's config.worktree to point to the
superproject's worktree (or possibly it could be inferred from the
submodule's worktree relative to the submodule's commondir).

This seems like an interesting way forward, but requires changing how
'git absorbgitdirs' works, along with changes to 'git worktree' or other
submodule commands when the submodule first appears during a 'git checkout'
in a worktree. I imagine there are a lot of "gotchas" here. It is worth
spending some time imagining how to create this setup and/or enforce it
as submodules are added in the lifecycle of a repository, if only to
validate the config design presented by this series.

Thanks,
-Stolee

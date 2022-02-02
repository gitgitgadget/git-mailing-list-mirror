Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD40C433FE
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 19:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbiBBTAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 14:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiBBTAB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 14:00:01 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E131CC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 11:00:01 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s5-20020a635245000000b0034ea48b7094so147689pgl.12
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 11:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=btrTZQJtyW24YlIynIFH9EzqmX+vIrILFDvOGLa71js=;
        b=VaUyPODirl9N516zm38qepOsTM9eTGexN8un8iQbe9rnTXpXGD/166xa2jhBBx9rZ1
         5gVDeZgxUyETkD/9OoMcVU+kJeWgEebsMw/+pOy2N75CRgEQeNrq/vD4SktVuHQMWjTi
         gVXRYgwNhnVxgpUt5HY7Y2jNHcdLxTHo+CR7tqH7kPz66Au569s8N6BQ4ars6tRXxgxT
         wauFBGbu7F8eGJE2JguucrzsJvN0SnJOspYOpLB33ID+vAm25M8WMmDIj2o7rMzdGdAT
         rAw1pov3RuMHyY0gWF9G72s1ua+RuTqlyBATLTCdhvClb587IwHpsZefs3GZc+ljHsH2
         xQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=btrTZQJtyW24YlIynIFH9EzqmX+vIrILFDvOGLa71js=;
        b=LbzSPcpsm0Yst4LI82u9mLmc8gVASnzWoVLzzYriO9wjCdl04p4qjVnuU/WlvZUE1m
         SIzbKaMFQhKPJlcLvBP15QJu1pgqF/MCTEgimlFn24qZCkHQAXlhbQNt/6VFew+gK3KS
         jK2/0zBoj96sSQx84qJ2i7O4kpd1R3R8v89PGQ7VaP9MW8rHBaQOWL1fJNaoJBh1lxVP
         0xDu4b9l/RTW1m0rxvEIqFEmiSSDzJeWqmc5zF5s2ef8TM4kWN2z8hSFgVvSZGPGM/gN
         0G5/q1NpH0F6/xUr8bWqk/00j63K+5AJ7j3Hx9p638uGstJeL+fiu+wPwPuPc+RyvtjG
         NUVg==
X-Gm-Message-State: AOAM532yTWbAFH/WtK/2RBtxFy2aImREk4ihnW6HvEJDvq1wE9EmSHnS
        HCTsHXvjHR9U9hldXA13umenYl8psl52yyn58eAD
X-Google-Smtp-Source: ABdhPJzGSmUhfA+O50INm8YwsepC09fl/3SuRTVJdOyinY+G2VULVpPd0IRLMWHRHNVFnQtUeMLcwLkQBT0IEs6+LjjW
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:682:: with SMTP id
 m2mr9718048pjz.22.1643828401242; Wed, 02 Feb 2022 11:00:01 -0800 (PST)
Date:   Wed,  2 Feb 2022 10:59:57 -0800
In-Reply-To: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
Message-Id: <20220202185957.1928631-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: Re: [PATCH 0/6] [RFC] partial-clone: add ability to refetch with
 expanded filter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, stolee@gmail.com,
        me@ttaylorr.com, christian.couder@gmail.com, johncai86@gmail.com,
        robert@coup.net.nz
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Coup via GitGitGadget" <gitgitgadget@gmail.com> writes:
> If a filter is changed on a partial clone repository, for example from
> blob:none to blob:limit=1m, there is currently no straightforward way to
> bulk-refetch the objects that match the new filter for existing local
> commits. This is because the client will report commits as "have" during
> negotiation and any dependent objects won't be included in the transferred
> pack. Another use case is discussed at [1].

Reporting commits as "have" can be solved by forcing the noop
negotiator, but there is another issue (which you seem to have
discovered, glancing through your patches) in that fetch will abort (and
report success) if all wanted commits are present, even if not all
objects directly or indirectly referenced by those commits are present.

> This patch series proposes adding a --refilter option to fetch & fetch-pack
> to enable doing a full fetch with a different filter, as if the local has no
> commits in common with the remote. It builds upon cbe566a071
> ("negotiator/noop: add noop fetch negotiator", 2020-08-18).

Thanks - I think this is a useful feature. This is useful even in a
non-partial-clone repo, to repair objects that were, say, accidentally
deleted from the local object store.

If it's acceptable to have a separate command to configure the new
filter in the repo config (or to delete it, if we want to convert a
partial clone into a regular repo), I think it's clearer to name this
option "--repair" or something like that, and explain it as a fetch that
does not take into account the contents of the local object store (not
as a fetch that changes the filter).

Having said that, the overall feature is worth having. While we decide
on the name, the implementation of this will not change much. I'll try
to review the implementation by the end of this week (but other reviews
are welcome too, needless to say).

> To note:
> 
>  1. This will produce duplicated objects between the existing and newly
>     fetched packs, but gc will clean them up.

Noted. This might be an argument for naming the option "--repair", since
the user would probably understand that there would be duplicate
objects.

>  2. This series doesn't check that there's a new filter in any way, whether
>     configured via config or passed via --filter=. Personally I think that's
>     fine.

Agreed.

>  3. If a user fetches with --refilter applying a more restrictive filter
>     than previously (eg: blob:limit=1m then blob:limit=1k) the eventual
>     state is a no-op, since any referenced object already in the local
>     repository is never removed. Potentially this could be improved in
>     future by more advanced gc, possibly along the lines discussed at [2].

That's true.

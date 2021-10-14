Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1548C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 22:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A16610F9
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 22:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJNWX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 18:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhJNWX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 18:23:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB95C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 15:21:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q193-20020a252aca000000b005ba63482993so8956971ybq.0
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bIu87anSWtfsL2QTxJGxz3fbJVkLQE582QLSLnWST0s=;
        b=Z5aGIf11twjXOG3joCyeKDz63kMtlZc5k8DODdQvSf0r8UrCsW40LNlTAjxjGpSzJL
         OD6ydm46Cta4U+Zukj4/R7rncmtsMLBpGubSxKe45EDa2mb3xn3IjLZLvcDNRTlWeRqB
         AqIeEMsQu1h7UlHUIrmuQl1qVlFqE0yRWLxhDvqropVUraoULq8u1BC+F/lMh0Psk1SI
         GecQviS1J1l7/qV9MGByM8al8a/Sk63rvTymLA37e3iBJadG2jiCjFD+YXJPjkURZxmb
         YGAMgAZVhVxO0auGYFpoY+kBTjWZ5/R8fGAG/o2H4gIqBZmkpzMkv5kpugNEddAiwR5G
         bb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bIu87anSWtfsL2QTxJGxz3fbJVkLQE582QLSLnWST0s=;
        b=Sd6hJ9aCaRST3lTYENLFwjKYtoIQoVCLXm63Ki2YoNBXcJVy6hAIsTy4tZso8kGRFx
         lF6aPl/NYmCPIGZq1qJjDyortxsNs0N2fCc8XeJVPzM4TPGZlxZWUNJ+j/1+xe2gG149
         XBH8WEN99v5pDY+8lu7hF6jMBhklRhtZJgmDUPejT/vVfL//P2Q+ToK8NBSr7rKgjgIc
         f6VJQMfa9U70LT6pQPgiCGr36+Hm7O9uyn8gKa4peqp171a3PGxI1KGIYjdu9O2gF+e4
         y36sTs6KqlSh8+60lZibicagxqsLxH+FFvxIcL4LjEHNA3lrXCFBeE5qM2jl+WBf6JTR
         IdcQ==
X-Gm-Message-State: AOAM533SYicviweZ9ldY6E9pRXXSaAXm8xvSG5AteeyyXbPVZniLwbeo
        Bn1t+bg2JAmYUyqhz+BUoelRhu5yaUx7FQ==
X-Google-Smtp-Source: ABdhPJyqbo/KM7+pPlMEI66H6JBSPr40k6oNAHwJzBXvI748NCEhyd9wnyU0OhMLgOtq7za3vN+2h6NayaVGqg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:b447:: with SMTP id
 c7mr9194724ybg.214.1634250080054; Thu, 14 Oct 2021 15:21:20 -0700 (PDT)
Date:   Thu, 14 Oct 2021 15:21:18 -0700
In-Reply-To: <d553054f-a484-ba34-ef3b-1e6778211a47@gmail.com>
Message-Id: <kl6l7def1c4h.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211005001931.13932-1-chooglen@google.com> <20211012174208.95161-1-chooglen@google.com>
 <87wnmihswp.fsf@evledraar.gmail.com> <02947b5e-7ce3-4760-0d27-621c7362f839@gmail.com>
 <87pms8hq4s.fsf@evledraar.gmail.com> <d553054f-a484-ba34-ef3b-1e6778211a47@gmail.com>
Subject: Re: [PATCH v4 0/3] Use default values from settings instead of config
From:   Glen Choo <chooglen@google.com>
To:     Derrick Stolee <stolee@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>> The commit-graph should be disabled if replace-objects are enabled. If
>>> there is a bug being introduced here it is because the commit-graph is
>>> being checked during fsck even though it would never be read when the
>>> replace-objects exist.
>>>
>>> Thanks,
>>> -Stolee
>> 
>> Thanks, isn't the obvious fix for this to extend your d6538246d3d
>> (commit-graph: not compatible with replace objects, 2018-08-20) to do
>> "read_replace_refs = 0;" in graph_verify()? That works for me on this
>> case.
>
> Ignoring the replace refs while verifying will allow you to verify the
> on-disk commit-graph file without issue.

It seems like we've converged on doing read_replace_refs = 0 \o/

If we are going to do this twice in graph_verify() and graph_write(), is
there any reason why I shouldn't just do "read_replace_refs = 0" once in
cmd_commit_graph()? IOW any time we do anything with commit-graphs, we
should just ignore replace refs because they're incompatible.

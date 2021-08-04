Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D15C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 11:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF8B560FC3
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 11:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbhHDLAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbhHDLAb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 07:00:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9923DC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 04:00:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id oz16so3087127ejc.7
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 04:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=E4uVzYoBGsP8ISna5cw2tRnvsXcveJk6ejAhyixE8+w=;
        b=EbxnVM224GRUD8KH1YFOKZja6Y5yYwbtEVwQIuffzzqq1dYgSYvXZS9C92soLi4qwX
         aW0G9+OO0A0tR3+r4E/bwWWMJckrFFdQx/KxhUvQ+dCMgWwDe5SPO0+OKoPIB4Zm2PG3
         uW/tMM+O1NOie9X3nnmm/+lW/swGlDEoYEMRRfemwgCblRVqKWvBHcj2VLiHPpqc/xqD
         n5aw1KHAPzpImLcinsNRnS1Ji2DUyfmlPuXAdM4ubq6KujmUWDapjVqAKwEXH+7AxVGS
         sfnBGmoSKErHlNi8cbFXU8pTNLCsZr6I2Rt7F2Uk5sR7LNtN/c7b4xLQQwZiNtt6zpD4
         Rzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=E4uVzYoBGsP8ISna5cw2tRnvsXcveJk6ejAhyixE8+w=;
        b=Jb0cqu4d6ibqvtTY1TlX+djXrFBHuNBQWZ8bpcuxmiAbNQvLgWJjw27jdbquuA4t6/
         tks67lS/DYoWxsgvGeFWJQjviu4xR7Ct2/niV/dgUizXPfg929AyroLl125hTMQzbFl9
         wYpKL6CidtiqZ00BRk/uvS71o3HKlLfN2h7Ahhu6vcQ9uL108bEQcWIeR/ecg8KRehWq
         su8RIuGzt/OPUhC6+gkeoS6fw5BS7DQomUq84H2dwYhIeVmrVPAR7F4oLJ6SkuD/jYff
         ZNLMejtj5uKLmUbRuE9SJNoWoKdNnaI1u5XKyxEnFHzSFvxcMLOp9sYsN8uTBMMAE7n5
         rCWg==
X-Gm-Message-State: AOAM531MOgkyT6TrgwEuN6Lu/yKULauGITHHGYhnYw57qv9S/ZbDFJGT
        r/c42rdk+e2rNdg2M1FsPu4=
X-Google-Smtp-Source: ABdhPJykcdJlkA5Hp2kaI+lCrfU9ZwBDBMid0xC81B0m+naQkmfEI3ZtOnfn1TNOgS/I/4GiD7pIig==
X-Received: by 2002:a17:906:8606:: with SMTP id o6mr25233371ejx.247.1628074815829;
        Wed, 04 Aug 2021 04:00:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m9sm560347ejn.91.2021.08.04.04.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:00:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 4/4] revision: avoid hitting packfiles when commits
 are in commit-graph
Date:   Wed, 04 Aug 2021 12:51:18 +0200
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
 <f6fc2a5e6d94befa915fb59b6296ce3153820c13.1627896460.git.ps@pks.im>
 <xmqqwnp3vcow.fsf@gitster.g> <YQkJdDvRtyOPzszU@ncase>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQkJdDvRtyOPzszU@ncase>
Message-ID: <87tuk5mq4h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 03 2021, Patrick Steinhardt wrote:

> I wonder what our stance on this is. I can definitely understand the
> angle that this would be a deal breaker given that we now claim commits
> exist which don't anymore. On the other hand, we update commit-graphs
> via git-gc(1), which makes this scenario a lot less likely nowadays. Is
> there any precedent in our codebase where we treat commits part of the
> commit-graph as existing? If not, do we want to make that assumption?

I don't think there is, but don't see why given the performance benefits
it should not at least be exposed in this form for those that think they
know what they're doing.

But right now the way we write the commit graph seems guaranteed to
produce races in this area, i.e. we expire objects first, and then we
write a new graph (see cmd_gc()). I.e. something like:

 1. (Re)pack reachable objects
 2. Prune unrechable and old
 3. Write a new commit graph using discovered tips

I don't see a good reason other than just that this needs some
refactoring to not instead do:

 1. Discover reachable refs
 2. (Re)pack reachable objects from those refs
 3. Write a new commit graph using those ref tips, i.e. don't re-run
    for_each_ref() in write_commit_graph_reachable() but call
    write_commit_graph() with those OIDs directly.
 4. Prune unreachable and old

Which I think would nicely get around this particular race condition,
which also doesn't exist if you call "git commit-graph write", it's just
if we write a new graph and then expire objects without being aware that
the graph needs updating.

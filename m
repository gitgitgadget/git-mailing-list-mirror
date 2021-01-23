Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B470BC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8283222CA1
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbhAWVLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 16:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWVLd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 16:11:33 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238B8C0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 13:10:53 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id m13so2412514oig.8
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 13:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGdG3VCnJ2pFc0vyqL72SJJsTj2OLPI6dnF7J3otsMA=;
        b=agyP8oInwnVFz1mCtcP6a9NBzpQL+dwWYYWPHhbokFUL11QYrQURv+y4TZew9tTIeB
         Pize3wjrblrK4iDdhtHGGNyK77d7AWbk386fP7zJuTk02NGqPUzdPBO03ck31ALD5CfU
         dzXWZHH9Tl21fXL3KmyoAbRFaVJu1VttVgEH96ic4oiSh9Nw7BTeNldRmnZSnoFQsmke
         PDvN0YN+uNMTBAt0/rsvR9j7ZKXXayhx/rpz3RQJ4vqzDWLLnkzVIR7bDPuWF8Q5Nhxn
         +IMNPxfg3PtWHymdPXxZDCkjxEB4fVgafBd19mIVT/lK0gBvhuZLN+0n3VmR1ptIku1H
         WFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGdG3VCnJ2pFc0vyqL72SJJsTj2OLPI6dnF7J3otsMA=;
        b=avnPOYtYLK2AQiJW1O9adS+I5lKugmE3q1xmkA0NRbWWNp7III12bydws/Luf6QN41
         r8xmLEufIz5t9W4hnBtQBadSNJSg6FAwNtHTxVALsyApgb+wU7k0DtCMbwWliMEVW921
         N1hJxiFiUxBUraU5zv2/KU38k3wWEI1mSrv1Tf+5u2inAWaBTlKGVTrDg8qiv9O6zK7s
         5Lyn6Jd0W4aKy6Pl2mcwA9Og+Y8lkffPSRpdHv1800yk2PVHLGloM/NPOsofeSAsB1/e
         8H1Jt1Up1saKiyYjw68vLVY2kIxy0OkvOLmMF3iA+BcXeZI3hDI3tw4/ht3zOZQqiytC
         XGfw==
X-Gm-Message-State: AOAM532vKUjxGfK5uw/82mxr9hTqQONTbAyadVPY1tXg2wWw+ywcrFh/
        ZYnhq2OsX5gmctt6wtgnhf5VySKGT9zykuWZNK8=
X-Google-Smtp-Source: ABdhPJxnaFpYEv+rWN2eKvNYxztE7vV5K8SV136Ja+wVAJq62IMjHc3DkLER1jBiQGehGFl6NERQOZHWUKQxwxfke+k=
X-Received: by 2002:aca:a816:: with SMTP id r22mr2246218oie.31.1611436252446;
 Sat, 23 Jan 2021 13:10:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
 <pull.839.v3.git.1611431899.gitgitgadget@gmail.com> <1b8b56800948339c0e0387555698bdfdc80a19ad.1611431900.git.gitgitgadget@gmail.com>
 <CABPp-BEsoWs5ZEhS0KTHankzc8eUdmpn0uoF7t1ZtN8b2gwvBA@mail.gmail.com> <d910be29-ba90-bbe1-fd96-523508b99781@gmail.com>
In-Reply-To: <d910be29-ba90-bbe1-fd96-523508b99781@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 23 Jan 2021 13:10:41 -0800
Message-ID: <CABPp-BHGFU_2t7gRgdzTgf33y-_9LkLVZtp5RCjfty2mVme_yA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] cache-tree: simplify verify_cache() prototype
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 23, 2021 at 1:02 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/23/2021 3:24 PM, Elijah Newren wrote:
> > On Sat, Jan 23, 2021 at 11:58 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> -       for (i = 0; i < entries - 1; i++) {
> >> +       for (i = 0; i + 1 < istate->cache_nr; i++) {
> >>                 /* path/file always comes after path because of the way
> >>                  * the cache is sorted.  Also path can appear only once,
> >>                  * which means conflicting one would immediately follow.
> >>                  */
> >> -               const struct cache_entry *this_ce = cache[i];
> >> -               const struct cache_entry *next_ce = cache[i + 1];
> >> +               const struct cache_entry *this_ce = istate->cache[i];
> >> +               const struct cache_entry *next_ce = istate->cache[i + 1];
> >>                 const char *this_name = this_ce->name;
> >>                 const char *next_name = next_ce->name;
> >>                 int this_len = ce_namelen(this_ce);
> > Makes sense.  Thanks for explaining the i + 1 < istate->cache_nr bit
> > in the commit message; made it easier to read through quickly.  I'm
> > curious if it deserves a comment in the code too, since it does feel
> > slightly unusual.
>
> I would argue that "i + 1 < N" is a more natural way to write this,
> because we use "i + 1" as an index, so we want to ensure the index
> we are about to use is within range. "i < N - 1" is the backwards
> way to write that statement.

Oh, right, I think I was reading too quickly and assuming one thing in
my head (about what the code was going to do), and forgetting that
assumption when I got to the actual code.  Sorry about that; I agree
with you, so ignore my previous comment.

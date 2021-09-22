Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB85C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 17:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B620561181
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 17:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbhIVRgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbhIVRgK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 13:36:10 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E945C061574
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 10:34:40 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id r20-20020a170902be1400b0013b9a9629b7so1235502pls.21
        for <git@vger.kernel.org>; Wed, 22 Sep 2021 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=phdFXzPxISnWNMO73Hr7uOPBt0QK3hiX/849iIi8NwA=;
        b=jD4I5FDdAIw1aJjHv9p1yBJr9He0X/TzmpFJyBXCw0KNbCl6JgDjp0e3QvUiP9Abdf
         nVpI8w/Tds49f5ScTV0Fxnqo+kBFjFCjGyoWjLyuQTbyB170ZF8pd8EoScevo0dku6b+
         /CUrPjeKWG7sI3/90asZRVqiK/r0CNptiE6JIKzKJZZJpf5lTiz5vKQzHXwN5/xIgAyT
         OWuVZIpiGY8B0K2cL4GQ9xNSL5BSLYRDaDa/p0iw2JfrUS8WUAeFR6St3SF2o8WXoutD
         4JKIK2JM+X9pZLCpo8JPdVdIk7nbJHJE9CABHjGKha6bocln4qUsLAOnEWYxEdsZf0pS
         cAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=phdFXzPxISnWNMO73Hr7uOPBt0QK3hiX/849iIi8NwA=;
        b=oq7CmrFfrMreM+TehU09QxiD2j/I432BdxS4RdaEraeecYjfZHvxePuONbAy+o7kXo
         U3U3gs+DevLXoRS0S3VUeSTU7csE0/1ykrfL3WV5A4k5ijDIhz28HSKuwb1ow/GDKvg9
         gLV7s63EGUmEm5sBPMEm1XzjyxJjmAR9hn4lasjIFvhhofJDVKNTU3OcSHLR4la8eAsk
         XpwHXn1AgNfwi8z2Y3bN2kA14ioJCwgOoTCqgOPQsYccThZyh7sluo8qeHV879HvV3T8
         +7/qet5Pq5S2tsOiDDi+XeliPbZemi/pJL0OB9GvN++reXNKYTJDr32PNGPgGaq/A4tP
         Kv7Q==
X-Gm-Message-State: AOAM533XABcFwBPuCWJ49aQgZd0xtwURAZWDJDtAIZcyC99oBaj0Sykp
        wEVnTY9UolB5wqiZFx9vRLG1jnDGBPbybQ==
X-Google-Smtp-Source: ABdhPJwQFKhNjooxO7qPmeoi0Cr8HXCjUdAgkBa/4gWbHBK9aj20+RhH2/sgjJdY3QDlfVWt8XE4XtSinAeFPA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:aa88:b0:13a:95d:d059 with SMTP id
 d8-20020a170902aa8800b0013a095dd059mr15812plr.65.1632332079636; Wed, 22 Sep
 2021 10:34:39 -0700 (PDT)
Date:   Wed, 22 Sep 2021 10:34:38 -0700
In-Reply-To: <77a8b8d9-4e13-8c5b-c313-512fc7c2c953@iee.email>
Message-Id: <kl6lmto4345t.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210913194816.51182-1-chooglen@google.com> <20210920223226.25877-1-chooglen@google.com>
 <77a8b8d9-4e13-8c5b-c313-512fc7c2c953@iee.email>
Subject: Re: [PATCH v2] MyFirstContribution: Document --range-diff option when
 writing v2
From:   Glen Choo <chooglen@google.com>
To:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Do we need a line to cover/suggest how the V2 to V3 follow up to further
> review commands are tweaked.
>
> This sort of follows from the discussion about keeping the branch `psuh`
> as the working branch, and the `-v1`, -`v2`, `-v3` as the record of
> former submissions. The range-diff is then tweaked to be `--range-diff
> master..psuh-v<N>` where N is the last proper submission (just in case
> one version was a not-submitted dud).

While writing, it seemed pretty obvious to me that v2 -> v3 would just
entail adding 1 to every numeral. Of course I'm biased though, so I'm
happy to add a line if you think this isn't that obvious.

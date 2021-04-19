Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563FCC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D766108B
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbhDSTQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237147AbhDSTQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 15:16:27 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C01C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:15:57 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k11-20020a62840b0000b029024135614a60so7080913pfd.18
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jieD1gQdixQEo7nCCbVOmoJUwUThU9gvEyVQfG9mEJw=;
        b=TxHUwlGMKREmK0Y5gQJ+5wcjGDDlnrmJp2QVrpq3q07dnmWTzrpYCJHhHIVd7AExzq
         6cWvfyIVRvgtpOrPNy/QbPqyHC1Y9/FGa45VHDMGR+K9P9s6gDVGPLU4VXKJUQ+MvehK
         gz/N9yB7UN6A+NEB5bTy4ksWWulDKr8hB4SG/8LipCxK58zMF/gSUrCGXDnhKSIWF2IO
         tWrBSrTFNhxa3gT9dE0KMCArIjGnPBu8tkHqfBF74HW6spfCDbvLKe2u6kivYU45o1bE
         Ko6vc0ekFzGkq+9hmNZ1i7WTz7lIlfmkaiWDNUohUzsYZ6gqKmeBcV3dZWxnwMkmkjSM
         c4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jieD1gQdixQEo7nCCbVOmoJUwUThU9gvEyVQfG9mEJw=;
        b=AGghv7DnwY6EepFHLKi8u4EY5KOEC+9iRqOBsNk+pPx7Yg/AGqtQITtdLL6JcUAFVk
         B1SWAoVX2anZ0hjYTvlbE+yWMmaG18GZ0qGDI5C//jtiGKW4PQAWo8fzLMwiKW7VKajr
         IsgYOl+96QCSzwGBhnQ4wO7lq0HBgtNeZgn5iSCy7TFc2kMxA6xohMvTqt8MoRfl6G0s
         2DeU0W2YPUkdc+XrbsIWm2Ai1tNF964xj6YSS3TgpSrY5ERQPA4zkLQpVooSEoJpnTxM
         IHOIn4Jr33pGO+zSL712td8WJjwsXp8UQCFgXcpf+m2f0fZXd6MKuB1767oJpWY80reh
         F1FA==
X-Gm-Message-State: AOAM532Z/yaJQFmL9unvVU5mW8+o2HIxoAlPdYcFWJokIpfKI5k0Vlb8
        0qxIH9KSqSKcKSkee18vfmU24qtf3ykB+i+HGvgY
X-Google-Smtp-Source: ABdhPJya4B5WjNy3jjFAu+6xPVs/Rj5fBtpDCpCuZ+WLxlZnT/XM/K6DYFATaNV+yUb7D+jreOu293V1GDQXs99DNzi1
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:97ae:0:b029:24b:3b0f:b2c2 with
 SMTP id d14-20020aa797ae0000b029024b3b0fb2c2mr20890603pfq.38.1618859757052;
 Mon, 19 Apr 2021 12:15:57 -0700 (PDT)
Date:   Mon, 19 Apr 2021 12:15:53 -0700
In-Reply-To: <20210418135749.27152-2-rafaeloliveira.cs@gmail.com>
Message-Id: <20210419191553.581877-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210418135749.27152-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: Re: [PATCH v2 1/1] repack: avoid loosening promisor objects in
 partial clones
From:   Jonathan Tan <jonathantanmy@google.com>
To:     rafaeloliveira.cs@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        szeder.dev@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> When `git repack -A -d` is run in a partial clone, `pack-objects`
> is invoked twice: once to repack all promisor objects, and once to
> repack all non-promisor objects. The latter `pack-objects` invocation
> is with --exclude-promisor-objects and --unpack-unreachable, which
> loosens all unused objects. Unfortunately, this includes promisor
> objects.

s/loosens all unused objects/loosens all objects unused during this invocation/

> [snip] The --keep-pack option takes only a packfile name, but we
> concatenate both the path and the name in a single string. Instead,
> let's split them into separate string in order to easily pass the
> packfile name later.

I think mentioning this part is unnecessary in the commit message.

With or without these changes, this patch looks good to me.

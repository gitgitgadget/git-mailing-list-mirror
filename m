Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1949C4320A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C156103A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhHMQbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbhHMQbl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 12:31:41 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22221C0617AE
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:31:14 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id k18-20020ac847520000b029028bf7425a59so6724955qtp.22
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oC6imozVyFgYQ1YQ5l9gPuOHz1M8+sp8M2BhoQU3FGM=;
        b=lyl42gSNIQgXmdfYWlDWhNxP6ZAixKyKIYTAbB6p+3rjF8U7ot4nF/Fj9lrwBRzmzz
         b4F+Gwox2HVr8YvgtrGV7lj5DrNuSJNDb7+kSSiO/B1utnfB+eoGcocVBWXKk93k5AFR
         aI1hDNFrMAPqdqWZe+gOvfw5lAmd26eFqtUFu6X/GCFFt1MYHiNkv9HUym3rr7F8Wd94
         MS3zpvTRdMvHGkMVCqoPlz7ZYTeULVPuRrQo0j+af16+h2SD+F3E5Jb2grFgG+YQ5QI+
         UVn/DonCDxQ1vCLrTF1rLgE8OR5bprBibAJy4EiQR3TX4Pb2YjzMkyRU0SmUptiD4MK8
         YP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oC6imozVyFgYQ1YQ5l9gPuOHz1M8+sp8M2BhoQU3FGM=;
        b=agM1oKrjz50Sxi1qWYNiYfL5+P/aps7TNn/yJj8fkZi0n7EthRpNdDh8gyi8j9V/Xj
         T9Oyf09+uAu3/pnb59MhsHqoPhXSyzVPLhoopq9tF7cweY2BNkCkvV3JVyChUdTa+y7I
         uSdPyh1a6A3YJ3818Pilr8o9vF/zjtpPezljvybbJO0OrdablRUWtgtxzKmb+fFNSbBp
         LHqLqYG28bkhVtVgxYshDsp0qsPRiPwdxDOomhzEJUVDgRJnf/tm1tyzTqx9JDASD5v4
         EeD0/x6JHWC8SFi0XBy80TlAdSsBGfN8+g1VtcA6XVQbh4XwPiUFBBbk1Wt7faCgkhop
         xJGw==
X-Gm-Message-State: AOAM531ga5v99XRMwpPIxFo6rIc6Fx2CCm2En3++GWdIj8ttWfJC7jSJ
        6R+Vz/xQPb1qtYeABm8sy9vHk6IuzySmDbiV4gcX
X-Google-Smtp-Source: ABdhPJzjO4ntr7IRv8PPXAXdZ8lc5NfpZOyHgmOk0XXX9y9gGPtKMZue13Uio+XMjn74MiuN28pCjCx0AdokI4IqVOXX
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:f2e:: with SMTP id
 iw14mr3423362qvb.36.1628872273309; Fri, 13 Aug 2021 09:31:13 -0700 (PDT)
Date:   Fri, 13 Aug 2021 09:31:11 -0700
In-Reply-To: <YRRC528p06ByShE5@google.com>
Message-Id: <20210813163111.3212129-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YRRC528p06ByShE5@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH 2/7] grep: use submodule-ODB-as-alternate lazy-addition
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I had wondered whether we can entirely drop add_to_alternates_memory()
> but I see on second reading that that's still used by
> register_all_submodule_odb...(). I wonder if it can become static in
> submodule.c to prevent users from dodging the envvar+BUG()?

You mean make add_to_alternates_memory() static? I'm not sure how we can
do that - alternates is a concern that extends beyond submodules.

> Curious whether add_submodule_odb() can be reduced by calling
> add_submodule_odb_by_path() internally.

That's a reasonable idea, but I don't think it works in this case - in
particular, add_submodule_odb_by_path() dups its argument whereas
add_submodule_odb() already has an allocated string that it is prepared
to give up ownership of. Also, add_submodule_odb_by_path() is only one
line, so it won't save us much.

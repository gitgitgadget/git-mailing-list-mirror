Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6811BC4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE0E60F4F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhG0Rvz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhG0Rvz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:51:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C9BC061757
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 10:51:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d69-20020a25e6480000b02904f4a117bd74so19418662ybh.17
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N8qV6lq6pkJU/16wBzG0S8iBBLcqTN1O3/5alh86hAg=;
        b=ZJqNFMG6Lwa5BqJUW4HJsQxNd2i9yTESo8Nrzx4wzjusye9cWXatMgrx7wY0OO1wkG
         ymqpV2zzJVtG/s3vukkKJHkOo78NwqguneuJQU2oz5kyAxtip2xti1inWjGrXII7GjvG
         bBPRtbW85XpBtiml91rd2BMM+I/KHfg9+z6EP5Pp5rv0uD3hdbQxY1UDXlgF3lk4wDdq
         PH1daYi2idF0HF76OSe4Uib1zQHMHYDTQfUOZHBic8POL4tF+AM9sqJcxhLYk3GWdgoA
         wy5aOtz3j0VP56G8hz4vPLAPDrSeS70kQqNsqnIKefivZYo3bkvmKS4FyFbDUB76LMda
         cbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N8qV6lq6pkJU/16wBzG0S8iBBLcqTN1O3/5alh86hAg=;
        b=MqqyHjhx4D14kEm17++aSm+Z1Z+Lwv4IRMV5FiQzCKLiMXMhUUHZuGU1dftknp1rj8
         F3lGii7CINX3wJZ2+l0tFN5DQQpT8M7AzfC28UB0ZZFyIoBVCzQ3ar8LruN2IdHuy3J9
         r2fiDdwLuwahwIUScdUXUgqFncSM6Z8B2cKozxn9bZksIG+DdxjVCNW/u7p/RA40dObx
         S7UEt+o3MvYKtWlNCW+uXr/MhYiQ/q/+sEGyAx3Q/rFA1IqKHoSncZbYUEY8IX5k7BpI
         nzLX5kPHPg9kprgBEil9FH7ny37i6XCZKkMNL/8Me95M97jsmyXunSr4wW3CeFD3fHGJ
         Xtyw==
X-Gm-Message-State: AOAM530X9pB6GFc65tB/7o2SIJe1ZDYJmJNdd9jfb4r4zmQiWX/XKS/M
        tCd2+bojNPpRV42UxH/xeXkLOcLndhV1VW4iXrJa
X-Google-Smtp-Source: ABdhPJyhROoIObdghsVQHQE714JxQaEFot1aQv+heFQDbaOwW7mKkuj6JQNaqcD0cZe/Jys7RsCk/1urPTT/vDu7XzF1
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:7647:: with SMTP id
 r68mr33870736ybc.432.1627408313506; Tue, 27 Jul 2021 10:51:53 -0700 (PDT)
Date:   Tue, 27 Jul 2021 10:51:51 -0700
In-Reply-To: <20210616004508.87186-5-emilyshaffer@google.com>
Message-Id: <20210727175151.2462983-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210616004508.87186-5-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: Re: [PATCH v2 4/4] submodule: cache superproject gitdir during 'update'
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> A cached path to the superproject's gitdir might be added during 'git

[snip]

> +		# Cache a pointer to the superproject's gitdir. This may have

Patches 3 and 4 look good to me except that for me, a cache is something
that lets us avoid an expensive computation. But as far as I know, we're
not planning to perform the expensive computation in the absence of a
cache. Maybe the word "record" would fit better.

This is nit-picky, though, and if others think that the word "cache"
fits here, that's fine by me too.

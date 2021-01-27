Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC08DC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CD720754
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhA0IWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhA0IUK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 03:20:10 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFCFC061574
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:08:47 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ke15so1332455ejc.12
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 00:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=pOaXhrKAfnvKkq/3zFwcv2pNL5NTWNsuVei5VunpbWU=;
        b=i40B9x+D0rxgjMJaq12qHAlQPnyG5aHLzegHc/n9BIVewtkk6jYS8iA3XAvg0t2FL1
         2f4mXN44mpzMIpB861VbTdl3pkYYEUaZBKxEJGtGPAeFcc8LcuqJvHHHQVds9bZIGad9
         63RR2GPFBYNUEoWLDlWt5seLKKtrvNhsKNb17biRXgjAuOCtGuOMUJcy02aXhldq/E1/
         NUUSKXwglhk/mRA0lam0xy1aBdfkdSqEvC+7sGzCXt6O0/ISA3TC48GXo7XsUwL60TEo
         iTBWRKpMtpckQaZjzXGNNhg/jTjnJrJ6BGmAIgKduiy/tNRefXSIuO7ibKKp9GQsTXUu
         OBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=pOaXhrKAfnvKkq/3zFwcv2pNL5NTWNsuVei5VunpbWU=;
        b=gJvQIaMi8bS2/TRO6KdpLWkVHZ4DwaOHQqNKkbVVhuSDSgPKFZIC3KAPdlRQ11YJRh
         FVsNcmlP8B2BngBjdpHIks5dPR9CuFnPPqp5gpFkqR77B9UA3ZvjtdyT+iGNRnHFU1mg
         RIyZDkO62l4YG2MzZdZd/9tYmYTi9qbxGUWjTylcR8DNbOBc7LmDysPVcuegon0WLr4v
         1R0r+n7s4nBbnQYXp/eVlc5iUTqm2yjUAy1Eo+GxErV2Jh9uO3O0hrLhiUb1/i/QWv9a
         pwZd0omSfEV6S9/pPBlotjMu6W3qeN2eS4rZrRDvAYsUaQPlznRtLXkFR7Ms5k/K8g9i
         EffA==
X-Gm-Message-State: AOAM532IDtw59sycKjGXrcOLYSamxcEuyUpocrwQVAUmL8bLB5cNZjqO
        03I8dLyGmy9fJzL4ZEWfIOilDOHm6h3/K8/u
X-Google-Smtp-Source: ABdhPJzDSiatX5JffRf/xCCqWzlyWoQvaMr2n00xevMjRrAZiAZjC0hSCk50Nx+GqR1q74Qea4+IzA==
X-Received: by 2002:a17:906:44a:: with SMTP id e10mr5755968eja.265.1611734925820;
        Wed, 27 Jan 2021 00:08:45 -0800 (PST)
Received: from cpm12071.local ([79.140.115.116])
        by smtp.gmail.com with ESMTPSA id s1sm460710ejx.25.2021.01.27.00.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 00:08:45 -0800 (PST)
References: <20210117234244.95106-1-rafaeloliveira.cs@gmail.com>
 <20210119212739.77882-1-rafaeloliveira.cs@gmail.com>
 <CAPig+cS8ZPwkVZZbfsndd-sYV=oWsLUYsmDAqL3FTYsTFgmguQ@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/7] teach `worktree list` verbose mode and prunable
 annotations
In-reply-to: <CAPig+cS8ZPwkVZZbfsndd-sYV=oWsLUYsmDAqL3FTYsTFgmguQ@mail.gmail.com>
Message-ID: <gohp6k5z3i7qes.fsf@gmail.com>
Date:   Wed, 27 Jan 2021 09:08:45 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jan 19, 2021 at 4:28 PM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> Changes in v3
>> =============
>> v3 is 1-patch bigger than v2 and it includes the following changes:
>
> Thanks. I gave v3 a complete read-through, and it is just about perfect.
>
> Aside from a very minor problem with the tests in [5/7] and [7/7] and
> the documentation enhancement (`core.quotePath`) suggested by Phillip,
> this is really, really close. (In fact, I would be happy to accept v3
> as-is; those minor changes could easily be done on top.)
>
> I look forward to giving v4 my Reviewed-by:.
>

Thanks again for reviewing the series. I've just sent the v4 and I'm
looking forward to your review.

>> Range-diff against v2:
>> -:  ---------- > 1:  66cd83ba42 worktree: libify should_prune_worktree()
>> 1:  9d47fcb4a4 ! 2:  81f4824028 worktree: teach worktree to lazy-load "prunable" reason
>
> The range-diff seems slightly off. The "libify
> should_prune_worktree()" patch existed in v1 and v2, but the
> range-diff suggests that it's new with v3. You probably just need a
> minor adjustment to your `git format-patch --range-diff` invocation.

Thanks for pointing this out, I didn't notice this from the v3 range-diff.

-- 
Thanks
Rafael

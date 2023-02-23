Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9311DC64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 21:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBWVLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 16:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBWVLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 16:11:09 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F54C15562
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 13:10:38 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id q5-20020a170902788500b0019b0c60afa8so6702835pll.12
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 13:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x1ZnUDffV4gfzRA/Gg5ptGNe1aJjrCbja3xzKf84w3o=;
        b=j1KysxsZO/RH3cc/7apZ6QUIq2W0tSqA8r8q4aj5W77vfRrECZA7XYIZCWTRxQUpeH
         kFFhiiWXW4yCM6Aiv96FZb7yOPZTTf55R4xOr2w752lWxwW8xIwBH0K/Q4Uub9wbLFFD
         WH8/asDqScevsKKviPavSfEC9PD4/BooaBV7hWZW+AXBSj2OVX4RjoEiu41le95f1cAO
         a7It4lpZG0HhyHvM7NoYv2kQCA8KzOY3sV0oR7tk1uAXU3aczfHOJ58dQRxOUNC1SWyx
         eq/bzYqU0rP5V5HcnzNmY7i7clmLJ1/s//LUcMom4lgQuNmLx84+iWA20hVK5ZCbRLUc
         aXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1ZnUDffV4gfzRA/Gg5ptGNe1aJjrCbja3xzKf84w3o=;
        b=Fysj0IliN8+jE9NzOvH5R1NVvKtaOKkb2y7HdfchMA2RaxmANCP24xPra+8L1tqIT7
         NusbpDJrChOa/KG3SYe2AEDoHGcBLbCZPqNgyK4jgiOgh4zdQImoo+HmaAfWMLit164h
         19lNccCvUCwJej9/WJoLwEnY8TBTJZif+MvcWapbnWjQryG84wmy3cU2fwBVKipDPolX
         bOk+JqAzumHGyJEYHRXt2L8FipUZQsTgT9dEYIuazTYueh4NqeTEZr3tKzDzY7Fw1BbB
         a9RrUkRdLnv7SobPb8QXpTO4RkACXDGgvfSaUAqiyCRAFCFdor/EovRpcux19gNpwvdv
         UKfw==
X-Gm-Message-State: AO0yUKWC454IE5somssIrcL9CcJl8oxjvRXPGoEtQNIoDAu9mtqv/jiJ
        RyD21UYfpm+3qexjYW8qs+I8vt6HArhngQ==
X-Google-Smtp-Source: AK7set8HDECfLVVz6DI9kcKp59s/NxLXsMHJgDXAwv6lxNl5+UH+TZUdRa9wl7Oa+yfgVCUl40aSt0y8+1Rsww==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:903:2404:b0:19c:a3be:a9d4 with SMTP
 id e4-20020a170903240400b0019ca3bea9d4mr1439581plo.7.1677186637396; Thu, 23
 Feb 2023 13:10:37 -0800 (PST)
Date:   Thu, 23 Feb 2023 13:10:35 -0800
In-Reply-To: <xmqqbkllaxd7.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqbkllaxd7.fsf@gitster.g>
Message-ID: <kl6lfsaw84vo.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: ab/config-multi-and-nonbool (was Re: What's cooking in git.git (Feb
 2023, #04; Wed, 22))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * ab/config-multi-and-nonbool (2023-02-07) 10 commits
>  - for-each-repo: with bad config, don't conflate <path> and <cmd>
>  - config API: add "string" version of *_value_multi(), fix segfaults
>  - config API users: test for *_get_value_multi() segfaults
>  - for-each-repo: error on bad --config
>  - config API: don't lose the git_*get*() return values
>  - config API: have *_multi() return an "int" and take a "dest"
>  - versioncmp.c: refactor config reading next commit
>  - config API: add and use a "git_config_get()" family of functions
>  - config tests: add "NULL" tests for *_get_value_multi()
>  - config tests: cover blind spots in git_die_config() tests
>
>  Assorted config API updates.
>
>  Will merge to 'next'?
>  source: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>

I would prefer to eject 06/10 [1] for now and leave it in for a future
cleanup series. I haven't confirmed whether it's safe (the practical
effect of that patch is that the *_get() functions can now return -1
instead of 1, so the patch is safe if all callers only check if the
return value is zero, and not whether it has a particular sign), and I
don't think 06/10 is absolutely necessary to the series.

But if we are already quite convinced that this is safe, I have no
objections to merging it as-is.

[1] https://lore.kernel.org/git/patch-v5-06.10-b515ff13f9b-20230207T154000Z-avarab@gmail.com

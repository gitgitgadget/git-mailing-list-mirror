Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80457C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B8E61019
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbhIQT3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIQT3z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 15:29:55 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4209C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:28:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q3so33912056edt.5
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LpMzeSxZN4yU1UhKT0W4U1pgNFOrZlThkMjTZPjF2ls=;
        b=VvHBJvgebE2ZEAEJHU1fXn+BCehdYesBTRimUnU9TIJV86a4FZf74kEm3SRw2qYB6R
         3TJQGnXvOuX+Y59wSTcCtWpIwRlxT+f8JYv3E5USGVDEbYA10lc1Z0lszDm1wdu5NtCG
         nVoGNNFOfHoFqiq5UwdZiEgbm3E5kqaeF/6oE6JKEUJwaL2fq8w3W+9LmiFvJim6hlnX
         grHFthCjYZqipQOeZM1sMT2VJv4+6a0XNWf4YwFld5JcpE4KyeId/61tq0tIdldzHwaE
         FoVlQD/N3rRdYzzPSx586bpWGoLG/77p4d+/KuPZI1FRW8FyHFfpXFg+ZPXHZUezjnvQ
         d2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LpMzeSxZN4yU1UhKT0W4U1pgNFOrZlThkMjTZPjF2ls=;
        b=HeZeV0sGyiabAMKgO8SA3D9pTMmuShX9OoYaWoQnURF5uiuOCby8Y+NX+aslWC7kan
         e5fwI/xlVgF4zdSI1NRizC53q/7tbXD5FB3FF0AAcEExPo/+8l6tloLf38kbZFo/5Wna
         HuHDTJ24V9iam8bZpNzZxAJiB+axjjVP0a8RsTMnKGtmXuU09bSybvgz58kXSjRtcC3f
         qLo+0LLKsYatRpNEbHKAOhdaRmhu9/hCjP99CQHn4BcTSWN0rAWIn9ZMrMlOOIhB6N0O
         rjYbqWXbQXN+bpl+sci4jJZRs3esJIR6plWGbdq/NtFG8+MpcxJTIpuUSKrjsRLiuLHy
         JS9w==
X-Gm-Message-State: AOAM532hgYlctcTRduSxJ69h1LpNQXqJ4ZrI3CTforXv85/4kObLeDV+
        +vN6TcNzdSNHXEEexJBxB8w=
X-Google-Smtp-Source: ABdhPJzz9I7NxHyYKNfVHyo13uKk4ngNlnyjajAbs7b6CPIDHpavXw34O6DSqjJAGP6/xJ3oX3jmEg==
X-Received: by 2002:a17:906:718e:: with SMTP id h14mr13235656ejk.365.1631906911332;
        Fri, 17 Sep 2021 12:28:31 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bt24sm2686964ejb.77.2021.09.17.12.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 12:28:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kurt von Laven <kurt.von.laven@gmail.com>, git@vger.kernel.org
Subject: Re: Don't Call commit-msg Hooks With Empty Commit Messages
Date:   Fri, 17 Sep 2021 21:27:13 +0200
References: <CAO-Ogzs7vCtfgjZqp+cg1ERiu3bSwZM47arHJyyTrEqAQ=ZLcw@mail.gmail.com>
 <xmqqlf3vilnb.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqlf3vilnb.fsf@gitster.g>
Message-ID: <874kajdmsh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 17 2021, Junio C Hamano wrote:

> Kurt von Laven <kurt.von.laven@gmail.com> writes:
>
>> The most common reason commit messages are left empty is to abort
>> them. commit-msg hooks that replace empty commit messages with
>> non-empty ones (i) make it impossible to abort commits, (ii) are
>> startling to developers joining a project configured in this manner,
>> and (iii) can offer no value that wouldn't be equally or better
>> offered another way. For instance, a default commit message would be
>> better implemented as a commit message template or prepare-commit-msg
>> hook. I propose that Git eventually cease calling commit-msg hooks
>> when the commit-message is empty, but I would understand if backwards
>> compatibility were the overriding concern. On the other hand, the
>> empty commit message case is easy to overlook when crafting a
>> commit-msg hook. One consequence of this behavior is that running the
>> popular pre-commit tool (https://pre-commit.com/) tends to lead to a
>> spew of false positives to the console on an aborted commit when
>> configured with commit-msg hooks.
>
> The primary reason commit-msg hook is there is *not* because we need
> a way to tweak the log message.  As you said, prepare-commit-msg and
> templates are much better way to give some sort of default.  
>
> The purpose of the hook is to serve as the gatekeeper to cause an
> attempt with a bad commit message to fail.  And a properly written
> commit-msg hook would be rejecting an empty message, instead of
> inserting cruft into an empty message file.
>
> So, from that point of view, if we were to change anything, a more
> useful thing to do might be to forbid commit-msg hook from modifying
> the file and make sure it would only verify but not modify, I
> suspect.  Doing so would have a side effect of making sure that no
> commit-msg hook will turn an empty message file into a non-empty
> message file ;-).

I'd think we'd want to call it on an empty message, e.g. maybe someone
depends on that with empty message = auto-generate a message for me.

But for those that don't, doesn't the default behavior of "git commit"
catch this in either case, i.e. it wouldn't let it pass without
--allow-empty-message.

I understood this report as the hook taking the empty message (e.g. the
user using it as a shorthand to abort), and their hook "helpfully"
inserting some "default" message or template.

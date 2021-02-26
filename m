Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3469C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 15:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C0C64E21
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 15:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBZPZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 10:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhBZPZx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 10:25:53 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB75C061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 07:25:11 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id k13so15478343ejs.10
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 07:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=O86YxDOASeCJF4PZWbLnt2KIKlKAxF5fgPpRtsPWQZ0=;
        b=cyHyWHPPsWDVP6SudDCWE+7bAAltF9XHqsGrqk+9so72PyGiIyTBoBvjY1j+gq012p
         wSQWxwbqkr94pSTW3JtwpgTzpQvU0J373FMHryVZH4LDc0kDMykHrmfsG+HiHD/4R/FM
         7EobFC6g/tvuQLL0lU6Mz0c+1dxLmCcHPfNfxPPR2W4o/SWwvz9vmNZuUnFURwcPWwFj
         PZ+bOGHr7OIaovCnCfMH3vjxXFwZMLYnXXvARxKJmj4DXLMmYtaCPamF1Zczq+/f+Adk
         acJBZMJQq3RhRiFgRgGSZWK9dzsJsEWf1bU5Lh2q9cv6cV3JNRL3GMXwAbnKJABh+QuS
         G/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=O86YxDOASeCJF4PZWbLnt2KIKlKAxF5fgPpRtsPWQZ0=;
        b=Voli4H5BSkbwMLjJRUo3p9WxhabPq8dm2CSZf92A7kI1qvrfihN4gQjawdLsb6Ez16
         gNHTnBbJ9kgZ3y7uiuoARl8xHmOH5QvgIGQ4eAkLT+mi39Xz66l0ppuQRm9zs8xAQ0DD
         mdPAdKgwRbiNstnh87mxKwPrPpWnroATOk4BVl1SXABZcinhQuewixOztg+QtFNX595R
         6yzXxUF25j0327Dt8uNiF1ftbhlAAyS1wjLHmRkx55bT3WXWKPeoLy50vP2sSNuWIHCP
         WjA1BoWyIcjlA6athZOnhrNYW7lAzwLDxxarljAv+4F/MBLby1wAlW0SIsWLvFnD5X7/
         IMZg==
X-Gm-Message-State: AOAM532UfUMqJeCRf8T8QmfWmU2eqox7f9oU3fVFFW3fRfGKcuOWzG9/
        Sbed/ggsWmG2NP9bnKydJSw=
X-Google-Smtp-Source: ABdhPJwvF+Gj5GHWutHBwQ8SQGLxLsa6z4K+lAMbDe4w47i+NSfMQqtboD8hYI0F/WJ0vNu6E0vBCg==
X-Received: by 2002:a17:906:2e91:: with SMTP id o17mr3900819eji.488.1614353110364;
        Fri, 26 Feb 2021 07:25:10 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id ca26sm6171981edb.4.2021.02.26.07.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 07:25:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jean-Marie Lemetayer <jeanmarie.lemetayer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] new subcommand: git sync
References: <CAAdc0hwmR7BF53_66LNaceLrkFPDphU-y2sLEGB_1YoR5ErQsg@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAAdc0hwmR7BF53_66LNaceLrkFPDphU-y2sLEGB_1YoR5ErQsg@mail.gmail.com>
Date:   Fri, 26 Feb 2021 16:25:09 +0100
Message-ID: <87tupy7sx6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 26 2021, Jean-Marie Lemetayer wrote:

> Hi folks,
>
> I created a new "git sync" sub-command a few months ago to deal with the pull
> request workflow.
>
> Its goals are to:
>  - keep all configured branches synchronized with the remotes (--set-upstream)
>  - do not touch your wip feature branches (which has diverged from upstream)
>  - prune the remotes
>
> As I use it on a daily basis, to synchronize the remotes and then be able to
> quickly rebase my pull requests. I think it's worth sharing. What do you think?
>
> For now it is a simple shell script available here:
> https://github.com/jmlemetayer/one-time-setup/blob/main/git-sync
>
> If you think it's a good idea, I'll propose a series of patches with the new
> sub-command, the manual page and the associated tests.

Have you seen 'git branch -v' and 'git branch -v --format=*'? There
seems to be a high amount of overlap between this wrapper you've written
and it.

I suspect most of what you have here could be turned into an %(if:*)
directive where you emit the pull/push command as appropriate.

If you search the internet for "git-sync" there's dozens of such command
(and I've personally observed at least two of them being written by
co-workers in real time, not sure if either of those is in the Google
results).

So I think there's probably a worthwhile problem to be solved here that
could be turned into patches to git.git, something between "git
[clone|push] --mirror" and "git branch -v".

I don't think there's any interest in getting new shellscript built-ins
in the future. We've been actively migrating away from those.

But most of the logic in your script is just calling the ref-filter.c
API behind the scenes.

B.t.w. you can probably speed up & simplify your script a lot by making
use of IFS="" in the shell and not calling N for-each-ref commands when
it seems to me that one invocation would do. Just dump the N fields you
need split on some token, and split on that token in your loop.

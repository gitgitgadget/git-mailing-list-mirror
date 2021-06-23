Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F549C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 06:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B45F6115A
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 06:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFWGoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 02:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhFWGon (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 02:44:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961E4C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 23:42:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id nd37so2299083ejc.3
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2Rq0rrE0rK/eyWRmEhjPD4i5mrbPjpjAC8LY68xuBQ=;
        b=Q1aWeZICVA32Pd6N7qUT0LgIBUUNXPs30eii/RYGbYVbsRjBPOcsb7hpR3ENAdiqR8
         VwY6uxFw9LiBLql2ywU7V5QXle+g4XVFI5np5tabtrfmLueXAYcesnssvoX71oXM60j8
         fzd7lBeIDG5EqWW7bI+sHnSdbUiJEUx75NHM4aP0W5CYyqm0diaWnst22+2sYDooYEeM
         GtjDHNhuwg7+7CSfr8JdD5w9vCa2USYbYGlhyBlSsI6GEMSgH7iouJFVRTbqENkF8Hil
         M6HKgMdG+9PHyJUd7jlQtwnIo4+SA8mRBzKSINHn1n4K6QQelQqSYClEhj8S+iUXZAjb
         GxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2Rq0rrE0rK/eyWRmEhjPD4i5mrbPjpjAC8LY68xuBQ=;
        b=I0CprtI6IWy3bcVDuw57lneFy2agPi3eQYdtKJ6nqeGsfBm7Q5Jn2Q2lY97zgUoW4U
         iycxzC+ZIMkNEwC0eV8ZYNWJQHzKi18AfaUBKoxi5oeH1TonTgUZrc+5QnJYLgPHF9TQ
         k9jRJy1/DbdCMQ724L01dsEqxCONluNjA58QSn5uW2gyWk6R1Yc4o4xDFPX63vQCsQwZ
         uRPO7ZbZ1kYjzdyPxGX9ekteuxuVGWv1xJGBw1oBx/woeLvQFsNVvdYcgkjCKvBaMvVt
         mzdMgtUvdHrY0U2iaggPUz8czaMYze/MTt0uGEMyqmFgiaOwx6yvT0ZnnCDNNv99doHg
         wqlw==
X-Gm-Message-State: AOAM5302QgItL4MgJ0goaWsTXdV6nZi1Z0896Zoa6lGh8MOGTQnIMs0D
        fUjg+kEmHYtSb5ufcPdhlklKp2xFn1a7SnZiDVadig==
X-Google-Smtp-Source: ABdhPJy7sP2Ty51ANR8h0pWnbfqp/JBf0zySOw/rG1Tmsopbg8rbfg7tnfYE9SnMIR4v/+Utuo+EnzRUyQvRLuG59ec=
X-Received: by 2002:a17:907:3da9:: with SMTP id he41mr8137517ejc.231.1624430545105;
 Tue, 22 Jun 2021 23:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpohp6+jW2C0ewfYEp3rrwbKSqGVa94LRgQDcKJvYmiANuA@mail.gmail.com>
 <CABPp-BFiwzzUgiTj_zu+vF5x20L0=1cf25cHwk7KZQj2YkVzXw@mail.gmail.com>
In-Reply-To: <CABPp-BFiwzzUgiTj_zu+vF5x20L0=1cf25cHwk7KZQj2YkVzXw@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 23 Jun 2021 08:42:10 +0200
Message-ID: <CAPMMpojA7EVSuKo=Ej55H-Sk29LitEJscMuMbHHPfR7UiR4n6A@mail.gmail.com>
Subject: Re: Untracked Cache and --untracked-files=all
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, Jun 22, 2021 at 6:06 PM Elijah Newren <newren@gmail.com> wrote:
> It may be that some combination of Kyle's removal of the
> resolve_gitlink_ref() and my removal of the exponential traversal of
> untracked paths make your idea safe...but this is dir.c and
> untracked-cache, so who really knows?
>
> Not sure if that helps, but I hope one or two pointers I provided are
> somehow meaningful to you.

It is, thank you! I had already looked at those commits you mention,
and my impression is indeed that any -uall incompatibilities have been
addressed as a result of the major restructurings and fixes.

After this exchange I prepared a patch that seems to be "right" from
my perspective - it aligns the untracked cache flags with the config,
so if your command-line "-uXXX" choice matches your config you get
untracked cache, if it does not you get it disabled for that run (ie,
in windows under some circumstances, surprisingly bad performance).

This means people who want -uall to work well/performantly (because
they prefer it, or because their tooling requires it) can now have it
do so, simply by setting "git config status.showuntrackedfiles all".

This seems much better than a new temporary config, it is not subject
to "flip-flopping" issues like my previously described "naive"
approach was, and it seems much more achievable than substantially
changing the untracked cache structure & correspondingly adjusting the
untracked directory iteration process to support both -unormal and
-uall simultaneously within a single cache structure.

The patch passes all (working) tests, including the t7603 untracked
cache series I know you worked on, and seems to do exactly what I
intend it to - but I'm new here, so there are probably many problems;
hopefully this is interesting enough for people to take the time to
point them out.

The pull request in GitGitGadget is still requesting some form of
approval before I can submit the patch to the mailing list:
https://github.com/gitgitgadget/git/pull/985

Thanks,
Tao

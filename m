Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE485C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJLVKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJLVK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:10:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7B8CAE60
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:10:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s30so60237eds.1
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xlPBylXjbUrUqbAWmn7+LE1WulsXU555p+mmUb1xK1A=;
        b=htkqcrWQZMVgm5hM3jfoAxDYMRpoQ1GLnxSl1m58eTWLuk7DuskTVgRTTBFqAOazWb
         CNtNpL4N4AogvxpNq43dYx9fjnD1aFGgV+vTtKpP23lmWoiiJJBT5BkSFamhmPDgRPjp
         JJ0abCMqtLbSbf/Kql8IvaGfyrlvhqRkqq7O9lFybR/rKf7u5qF27ofXbOt5O/LpKh4p
         wUtTMfT6mVQQqyQXIH6rHlkeQsB3Kev1pBEhlWcO8a4FE5pXJzmj2wc+aH9GhfN8Owqm
         gtEICkn2bUnGpOK5NyHxoG4Fx8IjYDWAaPhhrzrR3GeP336zaqZLyx3eJTslWg4hxffV
         Lp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlPBylXjbUrUqbAWmn7+LE1WulsXU555p+mmUb1xK1A=;
        b=tCda6hJvYGhrPm/0p3D/lYEi5pYHTVemieu6b0tvYk8U5xKm/N02/BQgr8SO/mtBKC
         /IWxnjya3yH7Ytw3lqNWc5ioC+/vlREScDzrAWFubUiZDyz+sdcbRBMnIrojni1qpMxE
         nWp3oWrvCmCwHfximPlesbC2w1BiaoeenCl94Rj7eXojxdtwPd7qQ2f7CthJFEQOuvt4
         /uE1ZD9fJMfVJ62+k/zr4fWlCXhewytYFxci+CetWVK6EC3Nup+PaK8OPvzbv1ZdLXLV
         zKlc7j1tCcin3WqkhiZ4SjqVnXyXEQFeVHx7Rh+8cpmxTp6b81pa+VHbDgnx5OLUtvu8
         YKCA==
X-Gm-Message-State: ACrzQf3ZIHdTWQ+bapZyGhqOBd/s8JhBQCADS9CQl0gUnraZVFqXARFI
        bELxbmQCm908BdHhk3fVVk60NmiJL+eAhQ==
X-Google-Smtp-Source: AMsMyM5KpxdX6nhFisb79BHurb0i4IpwJ+dfFww2PM7vZ0ehaRIEChR6UQ3QL15t7f108YNOFTY9Nw==
X-Received: by 2002:aa7:d454:0:b0:459:9ae7:725b with SMTP id q20-20020aa7d454000000b004599ae7725bmr28484457edr.165.1665609022079;
        Wed, 12 Oct 2022 14:10:22 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id lb6-20020a170907784600b0078d886c871bsm1841641ejc.70.2022.10.12.14.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:10:21 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiizb-004KRZ-31;
        Wed, 12 Oct 2022 23:10:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 4/7] trace2: rename the thread_name argument to
 trace2_thread_start
Date:   Wed, 12 Oct 2022 23:06:46 +0200
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
 <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
 <637b422b8606b3b6d954e6a1959aae450507cdfa.1665600750.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <637b422b8606b3b6d954e6a1959aae450507cdfa.1665600750.git.gitgitgadget@gmail.com>
Message-ID: <221012.86edvcn3yc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 12 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Rename the `thread_name` argument in `tr2tls_create_self()` and
> `trace2_thread_start()` to be `thread_base_name` to make it clearer
> that the passed argument is a component used in the construction of
> the actual `struct tr2tls_thread_ctx.thread_name` variable.
>
> The base name will be used along with the thread id to create a
> unique thread name.

Makes sense.

> This commit does not change how the `thread_name` field is
> allocated or stored within the `tr2tls_thread_ctx` structure.

What this commit does change though, which isn't mentioned here, is...

> diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
> index 1297509fd23..7d1f03a2ea6 100644
> --- a/trace2/tr2_tls.h
> +++ b/trace2/tr2_tls.h
> @@ -25,17 +25,20 @@ struct tr2tls_thread_ctx {
>  /*
>   * Create thread-local storage for the current thread.
>   *
> - * We assume the first thread is "main".  Other threads are given
> - * non-zero thread-ids to help distinguish messages from concurrent
> - * threads.
> - *
> - * Truncate the thread name if necessary to help with column alignment
> - * in printf-style messages.
> + * The first thread in the process will have:
> + *     { .thread_id=0, .thread_name="main" }
> + * Subsequent threads are given a non-zero thread_id and a thread_name
> + * constructed from the id and a thread base name (which is usually just
> + * the name of the thread-proc function).  For example:
> + *     { .thread_id=10, .thread_name="th10fsm-listen" }
> + * This helps to identify and distinguish messages from concurrent threads.
> + * The ctx.thread_name field is truncated if necessary to help with column
> + * alignment in printf-style messages.

...this documentation, which I'd argue should be a separate change, as
nothing's changed about the state of the world with this rename of the
field, this was all true before this rename.

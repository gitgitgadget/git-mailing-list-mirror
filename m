Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D761C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 12:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiJRMza (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJRMz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 08:55:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEC589812
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:55:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z97so20290343ede.8
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yHKkRj5rkorckv+EL98G6DZeQVW/FMvR3ijvlHa5LMc=;
        b=avcAcyf6i9deyh75QuthoqMhqlaTycurpj+Q4SHAVZ4KEx11ThFS73DKEIa6uRBRrz
         cTS/Z70YwHxDY8XdJ0qXA8R/lvbf9tnAoINFpsffu0Ci9MXhpmWASxmb7k1Palm2TV5U
         bx/oUvZa/KAURyntH0cjM1Rt9j0WUUwMneqEqAIo8jqejQqwhbBZ80QPzWfW8x75BPZG
         6LnJ6XcIalSWRfsQuKIownjWNoTFJOZiYiLXvuQUnhLH+o3ktTjH2p72ui9khdBk8EWr
         7kS5CDJe2bpvMvvdHsfMpUVu1223lfAkgkjbeB3ZQO45tphrerJBeCRihA6Hg3gnsrSn
         H5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHKkRj5rkorckv+EL98G6DZeQVW/FMvR3ijvlHa5LMc=;
        b=Xt7gFPFvKi2XtXTyT61BcqCIYP8wLnNwD/v9r3kcZ8j2uCrYqrP3mFWaEqdHcigqgM
         PMl+KeC0f89pdxAuxzPxUPEQxIYDvFABIVqzZt2SygocNW5zTihkd+SSOwv0cMYrZoXO
         0Y+l756IuqTmGGJGTljIsFZEDGSR+ETujql+6qF035ba8A9I41p7viRO3v9cQy6j1sk8
         BvKrb0orwd+Lo9ZLDqtvFVsWpBo4ZNehC3QKhj6HO12mvzQCvXFnq1cISLjgVem2fJdH
         Eazti2uhyneIxbIUv99/XL+UuBacxDwTJgZxZKhcW6YA/tuMKE3f4khyCPjlE7a3hgV5
         oJLg==
X-Gm-Message-State: ACrzQf0Eq16VImI10uckfGrqd9QYYzZ0MSfAIkSC7SiUuQLL4BFIAaOp
        l1r7mDI1vw2V5QeXaKxHL4A=
X-Google-Smtp-Source: AMsMyM6PTltYR1LKP1lq3I1s7jrKspUMgg2mmazz+YLUsu7TUCmDKcoybYjqnwdspKFjrt1V6Bkb8A==
X-Received: by 2002:a05:6402:11c9:b0:45d:aa9b:5193 with SMTP id j9-20020a05640211c900b0045daa9b5193mr2479451edw.372.1666097725878;
        Tue, 18 Oct 2022 05:55:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906384e00b0078246b1360fsm7434726ejc.131.2022.10.18.05.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 05:55:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okm7w-005kZQ-1e;
        Tue, 18 Oct 2022 14:55:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH 00/12] fsmonitor: Implement fsmonitor for Linux
Date:   Tue, 18 Oct 2022 14:47:24 +0200
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
Message-ID: <221018.86edv5i94z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 09 2022, Eric DeCosta via GitGitGadget wrote:

> Goal is to deliver fsmonitor for Linux that is on par with fsmonitor for
> Windows and Mac OS.

I applaud the effort, I gave this some light reviewing, I hope it helps.

> This patch set builds upon previous work for done for Windows and Mac OS
> (first 6 patches) to implement a fsmonitor back-end for Linux based on the
> Linux inotify API. inotify differs significantly from the equivalent Windows
> and Mac OS APIs in that a watch must be registered for every directory of
> interest (rather than a singular watch at the root of the directory tree)
> and special care must be taken to handle directory renames correctly.
>
> More information about inotify:
> https://man7.org/linux/man-pages/man7/inotify.7.html

You haven't said why/if you considered using fanotify() instead of
inotify(), which seems like a more natural target to me. It's unlikely
that anyone who cares to use this isn't also using a new enough kernel.

See previous on-list discussions at:
https://lore.kernel.org/git/?q=fanotify

I think it would address some of the rac econditions you're mentioning
here.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB7EC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5140F61B29
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbhKQXbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 18:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbhKQXbt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 18:31:49 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3B8C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 15:28:50 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id x1-20020a17090a294100b001a6e7ba6b4eso2089984pjf.9
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 15:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7wMDDgIRgYtCA2+crGCu6qdi+8z+Vk1IwU77Aps/Acg=;
        b=ZvB2mqIcsKFgMhKd7lJwHv+ZVbLNkZKlc8rI7eExhytcm1ST40FeDSPjedEqtmJmOi
         9zGAd56PMOB2GjyCAdpmsTn6eeIZjwlAGeNi5KHEuzDIVIq+Wl16gEjyNLQXsX7ZhqUG
         7ojF4w/kATA4GX9RqZKM9m14tK4pxtFW4Ux0hfxEM2g3qUwAGJZhHS3vygTIKbxNYMQS
         Tsw+1TApyBvIXH5jLrrF7DncbAKFD/2WWVZevFIOp6XyzUQoBxbbCL5iN9BFtGzLviGK
         kxMkZg7KLFD06IiorDDzz621aDk3JzrpuytG8NSkMmteh4W7TriEsDoHwB8oIMTuyeU0
         s8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7wMDDgIRgYtCA2+crGCu6qdi+8z+Vk1IwU77Aps/Acg=;
        b=2bJ6CBCnTWVRReFP33N/ZCI4VLZ+1/5NtC4uT3Qso5tVSh/TlJtNuwx1QB8VoMetyR
         K1h8XlrfDAoe2Sx8mKDL3uPMWKbvhjRwx2Vwm/nUw2Q92By8+xZqCnzrLo3hlS/tezmN
         LJMMKp3/Q10vNHBiooI3p6l3kORQW6uoKdh0NbxaZ8UhCuPCMVS2rrn6JAheiRDrHcv0
         acA6rpCZiTUBjzyr9U3tSq4n8F1hk8B4e9tOj7eAi0034T0wUuM4oJOoAC71Qfz8sNOH
         XU0CuH0Oopu833yb/ZMmYewv6d6gtpaJu42IbxEHGn9wwP2f42rMR8YIqoUOTlw2kpXu
         fUNA==
X-Gm-Message-State: AOAM532F0/d38MfeweFqvi+IcN6Jp+k+o2uQMCrf8W1WbI2Av/lmLK2Y
        3tba+t3DcWGwGBcC+mgdmWFouLDo7xfBJEnN4AiP
X-Google-Smtp-Source: ABdhPJwHkayfXhGo64emK8E+H7q+ZSSJSHDB7npDhxMbkVfxlp6pmkq1w/TfDG7cMpjsoaIXIABcqr/KaA2bVHHUBoJA
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:c403:: with SMTP id
 i3mr4607690pjt.203.1637191729753; Wed, 17 Nov 2021 15:28:49 -0800 (PST)
Date:   Wed, 17 Nov 2021 15:28:46 -0800
In-Reply-To: <20211117005701.371808-1-emilyshaffer@google.com>
Message-Id: <20211117232846.2596110-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211117005701.371808-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: Re: [PATCH v6 0/5] teach submodules to know they're submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, albertcui@google.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        jrnieder@gmail.com, jacob.keller@gmail.com, raykar.ath@gmail.com,
        stolee@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:
> For the original cover letter, see
> https://lore.kernel.org/git/20210611225428.1208973-1-emilyshaffer%40google.com.

Also for reference, v4 and v5 (as a reply to v4) can be found here:
https://lore.kernel.org/git/20211014203416.2802639-1-emilyshaffer@google.com/

> Since v5:
> 
> A couple things. Firstly, a semantics change *back* to the semantics of
> v3 - we map from gitdir to gitdir, *not* from common dir to common dir,
> so that theoretically a submodule with multiple worktrees in multiple
> superproject worktrees will be able to figure out which worktree of the
> superproject it's in. (Realistically, that's not really possible right
> now, but I'd like to change that soon.)

Makes sense. Also, thanks for the tests covering what happens when this
is run from worktrees.

> Secondly, a rewording of comments and commit messages to indicate that
> this isn't a cache of some expensive operation, but rather intended to
> be the source of truth for all submodules. I also added a fifth commit
> rewriting `git rev-parse --show-superproject-working-tree` to
> demonstrate what that means in practice - but from a practical
> standpoint, I'm a little worried about that fifth patch. More details in
> the patch 5 description.

OK - this is not the "this variable being missing is OK" idea that I had
[1], but we want to be able to depend on it to some extent. (And it is
not a cache either - we are not planning to perform an operation to
obtain the superproject gitdir if the cache is missing, but we are just
going to assume that there is no superproject.)

To that end, the 5th patch is misleading - it is behaving exactly like a
cache. I think it's better to drop it.

What would make sense to me (and seems to be in the spirit of this patch
set) is to describe this as something that Git commands can rely on to
determine if the current repo is a submodule, for performance reasons.
So maybe Git commands/parameters that directly reference the submodule
concept like "--show-superproject-working-tree" will work hard to find
the superproject (by searching the filesystem), but those that do not
(e.g. "git status") can make assumptions.

Making this variable a source of truth wouldn't work, I think, because
the source of truth is whether this repo appears in a .gitmodules file
(and that hasn't changed).

To this end, I'll comment on the changes I'd like to see on the
individual patches too.

[1] https://lore.kernel.org/git/20210727174650.2462099-1-jonathantanmy@google.com/

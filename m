Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7221EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 18:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjHKSWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 14:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjHKSWh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 14:22:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB65430DD
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:22:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5897d05e878so26800587b3.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691778156; x=1692382956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5VWAFeZspLjIw/Q5huhpqa+euBTezjMA9gxhenGnhI=;
        b=w0R31bqIs21iplWhLoLh4ip8ihrBvJ7p8ir3aglGlPjE+NyrYYBywfa4BFxQDGsUJw
         Mo8iREd3KbKKy4ReCTHRZQd59B/ZH7vDbX3DZelGpTZN771qpx3Xl81veFSRfmlJWUku
         NBQOhqUtIR6UTGPF9RCYEsjC9huP7gCZ8VB3vLGxxgBsP84e7laiePn6YP2DJ7ky2Uye
         +tlbDEh5g0/kK627xfW6Wiz2Cg3hQR12vvMgzkf33cmIisJEPCrf0/8c5dsxfmgB74qG
         SD0SEtKPMX0oL4ecj1q9YISJu9C50if4hhu25WmMJHGUfPb2SVY2wC7GWgqseqzeTZFW
         suZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691778156; x=1692382956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5VWAFeZspLjIw/Q5huhpqa+euBTezjMA9gxhenGnhI=;
        b=O+iEiDhnOv0GhgGGXM9B7w/0PdcdKu6aJ/XS80eE+Sy610NiaQi9NSL9hhvGhF4Z++
         GYshlq+JsGuSrXW8yGcR1UqBpWDf5diquD6piQegmCALT4h8kvyUP2/5MJMoKR7JPgPS
         epZ4ybYHBctdxtEA2XM7Ffv6j5ROoCwVNR0fmVRGtiARDI5u4dBMuHhLxlpnDieq8IO8
         F7n9vc9VeLCiniNkVgbmZfHa9CLuJeyYsrbrj7FV8Y+qVq3coBsgaYaBiUxjI1Z2DjiT
         3eyv9SnWV8arkpwZQf78aiZFHpzweZKjZYJIHimHlfrax9Wv2TeZ3u1t10Jbdk9v6JCv
         8/YQ==
X-Gm-Message-State: AOJu0YwNQxyb1yFzLpWa0kaG8H2nE78CCeiKd1KGcFj2p/PyXHHcwOHL
        PO2h3b//X/BJqQM2ow/teFk8ewxmUCw=
X-Google-Smtp-Source: AGHT+IE9HOw/4efdv/XwBa+KtSXu9kn3hWNaz6PcliZabfwOJ7E0WfRp23boGWvxPcRZzGmfDrUu3e73B9g=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:af27:0:b0:579:f832:74b with SMTP id
 n39-20020a81af27000000b00579f832074bmr51009ywh.10.1691778156182; Fri, 11 Aug
 2023 11:22:36 -0700 (PDT)
Date:   Fri, 11 Aug 2023 11:22:34 -0700
In-Reply-To: <xmqqmsz2hl9m.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1566.git.1691412557518.gitgitgadget@gmail.com> <xmqqmsz2hl9m.fsf@gitster.g>
Message-ID: <owly5y5lfnh1.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] ls-tree: default <tree-ish> to HEAD
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Ryan Williams via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ryan Williams <ryan@runsascoded.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Ryan Williams via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Ryan Williams <ryan@runsascoded.com>
>>
>> When no positional arguments are passed to `git ls-tree`, it currently
>> prints "usage" info to stderr and exits with code 129. A more intuitive
>> default would be to operate on the `HEAD` commit's tree (similarly to
>> `git show`, `git log`, and possibly others).
>
> As 'ls-tree' is a plumbing command meant for script writers, it was
> designed to require the users to be more explicit.  So, similarity
> to "show" and other Porcelain commands do not weigh much here.  Same
> for "rev-list" that does not fall back to HEAD.

Indeed, we already partition these commands into these porcelain vs
plumbing categories in "man git". There, we say for plumbing

    The interface (input, output, set of options and the semantics) to
    these low-level commands are meant to be a lot more stable than
    Porcelain level commands, because these commands are primarily for
    scripted use. The interface to Porcelain commands on the other hand
    are subject to change in order to improve the end user experience.

> This was a very deliberate design decision to help use of the
> plumbing commands.  A buggy script may say
>
>     TREE=$(some command to find a tree object)
>     git ls-tree $TREE
>
> without making sure something sensible is in $TREE (and not even
> quoting it like "$TREE"), and if ls-tree defaulted to something, the
> script will silently produce a wrong result, instead of failing,
> robbing the script writer a chance to notice a bug in their code to
> come up with the TREE object name.

I think this illustrative example (at least the general language of it,
if not the entire example) could be added to the referenced section of
our docs (I'd be happy to add this).

On a related note, does it make sense to explicitly call out the
plumbing vs porcelain distinction in the individual manpages for each
command? For example, I grepped for "plumb" in the docs for
"git-ls-tree" but came up empty. We could add just a simple "Part of
Git plumbing" to a slightly longer

    Part of Git plumbing. Plumbing commands are more stable and are
    designed to work reliably in scripting environments ...

and similarly for all the porecelain commands.

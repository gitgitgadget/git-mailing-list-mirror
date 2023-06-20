Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A975EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 23:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjFTXG6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 19:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjFTXG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 19:06:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A7710FB
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 16:06:54 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc77a2d3841so5360650276.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687302414; x=1689894414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rpi3tZaV7V+MXLiKenMbU+gL3rpP3Joj4uiXquweIaI=;
        b=zkr23LbM3Op5s7vIl6mZaCscuOFXEYuZD38FZdAIsuURgbA53dYkknwzIupzGO/ITQ
         MsJ+nHbN+Q4UfXKCTG9YwU+uD8lcMaCje30MKdqo519LQ/phxU84kzAINZ8EMbqCG1lI
         l4U5QaafBFNwKElTNHmPv2vA2tdP9AKuJ+8/KQDXsJDXdbwFQ2qwtzpXcVdCxUMRja52
         ySu0KVZbVF2NdnzeSU1lJ8CKPYWD0/4uxJ8mBX1OFZcDpcTgo0aanpZP3TPYQp/q2FXT
         1+EtmMFMLRL7hyYP4/lji/Xmj5ZtPXhGJ2TYh5tZ1du40otCPob7AdtUHbMQ8H6ebXFY
         RF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687302414; x=1689894414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rpi3tZaV7V+MXLiKenMbU+gL3rpP3Joj4uiXquweIaI=;
        b=Q4DO62ugSIhXgRd3z8J11S8JypNE/DqdzbxZJIwC6mwQzMoohSasRVo358gK7h/rsX
         N0kcO/LhBs/CZDqyVVjDop16eac86/0Oiy7uR9F+cU1OHroR+J4t5n+NWEZzEqIowyJR
         iRJ3XAe6/9NGR/c5/W1rfn0F/RfrLIj8guA0TZYxqedRy29PmzKYZlxLRxR8A6OMI8zr
         MM+LXVJsFZLtywZ1lupgK1VOcxFRbRAk5LtVSt738zzHHuuUWYR0w1q/tqG3R3N29mqe
         m9GmltDuztICpz9Laf1woYgWy8W56Nh9qN35I5OapTdnQl9PWt72qekjXphCofJFn9By
         5O3A==
X-Gm-Message-State: AC+VfDzSpFSVKPMV1tQVjjZGe0Bg9YrIzZjVRUryGbWx8hWU4j/4ZkSQ
        QDdqssMkL9D8bIQyWKMFsSjFH8vNCn8aiA==
X-Google-Smtp-Source: ACHHUZ7OHEyr1lnszr2YUIsoU0uXFSOZd+qs//5uO3uvqpAM0QZo3qsA7bh6pJie3VgN1gxymTAmhbs8ZqC5UA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:1363:b0:bea:918f:2ef6 with SMTP
 id bt3-20020a056902136300b00bea918f2ef6mr1412296ybb.0.1687302414160; Tue, 20
 Jun 2023 16:06:54 -0700 (PDT)
Date:   Tue, 20 Jun 2023 16:06:52 -0700
In-Reply-To: <xmqq4jn1lsuv.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
 <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com> <a2a891a069f46d3d77cafe61f64402c93cffaae4.1687290233.git.gitgitgadget@gmail.com>
 <xmqq4jn1lsuv.fsf@gitster.g>
Message-ID: <kl6l1qi5spgz.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 06/12] builtin/config.c: test misuse of format_config()
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> current_config_*() functions aren't meant to be called outside of
>> config callbacks because they read state that is only set when iterating
>> through config.
>
> Interesting.  And config_context is about expressing the state of
> the iteration, so presumably some of these callers that do not have
> config_context to pass (because they happen outside iterations) will
> now (can|have to) pass NULL or something to say "I am asking format
> but from outside any iteration" or something?

Yup, they now have to pass a default value for config_context. For .kvi,
it should be what's given by KVI_INIT (the next patch has an example).

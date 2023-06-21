Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82FFEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 23:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjFUXHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 19:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFUXG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 19:06:59 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A740B1988
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 16:06:58 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53425d37f33so2914695a12.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 16:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687388818; x=1689980818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9wG3L7xxGCptpkYJasB51bek7CIrLFB0gsMrVH9JeFc=;
        b=uqoZ+OscWCbVwNjdGxZtJZAK62JOQ0ZloT49SL5Kkrf088rXMXdkFgbcZFRej/h0wo
         E4Bem6p39usVXVbE8nWXmUY9pR0voe4LS46C0NHHsIve2BNAtoILR9qoCe2yz5oWCymG
         KdmnkpvUNLuCNbU3Ts5scD/S4vrmHe5vaFX0geTT4OlKW1/wjbu1S4NrEcTuVwHBW5Xu
         SM6YPINDhuQcWW62ty+By8Unh6aefQeHDTF4/sboJhsjbvBI222D6QL+I4GiLIaXZWvh
         wkr8enKCJHCWL/t2jR7pRNhSczCGyStyBpwkDuUyBBbNwPfShYUJyBROsUf06tgNF5+R
         P+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687388818; x=1689980818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wG3L7xxGCptpkYJasB51bek7CIrLFB0gsMrVH9JeFc=;
        b=L4A5Vg9nYZ9BtdilYYeg4m2f+qKp15f/reIPp/O5ceyhIRDxoEqek4wBYONEmsZ5nu
         +SqvXwgnciy6vkh6nOi/qkRto5thxF1kADMzJZZWu1tr/PMRktjt3Co0Ay1u1RZGe4JS
         yRjucGOgsJHWTYeXpT1s3229m4XITgSPJkCMoHL9U4dxK9T7evm6KG/mturBkzl/Rfgw
         MhxvITBtKiJ5mueiqE/i/6uKU1cmoXc/FAgo/6aZyjJvIjn4Fg8jR0G/VQVh4vfPkTO3
         0f2lWzILmC+s+uFH9MQlfY5h8QJe8/goRZ4oiaOhBAmCsczEnFCLJaPoExECd6EICpIv
         CCxw==
X-Gm-Message-State: AC+VfDxsZQlDKhHEzEc4qtrmujqMH7xiXkSLlLDPlQWyCmz4DARhar0W
        Ad2YIUpGXYivfwCA5SbGT2zRcNLj7VvqPg==
X-Google-Smtp-Source: ACHHUZ4QAnZqgUjWorV/0jzj5xgaMs3gGjK1s+Wucb/Kc7mcTcaw83GH+CmtCVSYf5P1vRtG66ctO/RTgI2Uog==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:4b18:0:b0:554:1af0:81e0 with SMTP id
 y24-20020a634b18000000b005541af081e0mr785700pga.7.1687388818091; Wed, 21 Jun
 2023 16:06:58 -0700 (PDT)
Date:   Wed, 21 Jun 2023 16:06:43 -0700
In-Reply-To: <xmqqr0q4fpzb.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
 <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com> <xmqqr0q4fpzb.fsf@gitster.g>
Message-ID: <kl6lh6r0qut8.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 00/12] config: remove global state from config iteration
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

> I've reviewed them in its current shape, but it seems to cause too
> many conflicts even when merged to 'next', let alone 'seen', with
> interactions with topics in flight:
>
>  * ds/add-i-color-configuration-fix (easy)
>  * ps/fetch-cleanups (easy but messy)
>  * vd/worktree-config-is-per-repository (moderately messy)

Ah, sorry. I ran some trial merges against these before I sent out v3,
but I forgot as I sent this out. Not queueing this version sounds fine.

> some of which may have graduated to 'master' in the meantime, so it
> might not be a bad idea to rebase on a more recent 'master' after
> you collect and adjust for review comments on v3.

Sounds good. I suppose it would also be worthwhile to base it on
conflicting topics queued for 'next'.

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92750C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhL1NzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhL1NzK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:55:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737EAC061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:55:10 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b13so74087336edd.8
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ptLYXMhoZLJmo3yPGSkTgr+A6FP5zKPkG4LE6tnqxEU=;
        b=CoqnqNvLBT5OccgpQU160GjU41PrCwO3wtrW5/NyG2jR1w7N8CTXEZ5rnN+h0sGO7F
         Gn5FfY14y7qa1tok1BF85G+iq2nGRqAVQZ/zM4jLMyG7J0U5woQVm3PZfKnBk9EqFbEB
         1v9kXnkZ3HnkgR/UFJFBDszfEKdaYDN9VIB3QYr/MIQXn/TLCXjlVHbnqMYNCfBYi6LY
         VuQpCEqQ8oNAoIDVfAxBV8ZO/UgrO+ZH/LAea9elXzDfBitjltxjeu45vZESV3AkDCL7
         c5r3hdxvDEoVyGvPeruMc5Xt6upXsRRofQYthtoWrR00kJCeICWXifhwVy5dOsECoanf
         ZTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ptLYXMhoZLJmo3yPGSkTgr+A6FP5zKPkG4LE6tnqxEU=;
        b=XMcJFC+s8QtI9OHGGCZTgh+EwU0+p/6sn5SZGNm8oyl3ysItiAPMhNhs3HMQcnYeAD
         bTQRt+yhpttEkqp7vYnodKLxLCuJCBZKBJvUePjwYGxDiMOH/+1tz8IoBg+BnmbMj8yq
         yb5b0hHQ7w2tgQEiqrMC3IgAosg3WLbEY1IUxnE6PuKfsVkHQXpAEorZ2XZ0zxJy0ewt
         ukeI57pq3p3WzGZscGJtfWqLMXIIDXetzBgmE/fhtEnUMUji4tIF98W75Om5+S/kOvlx
         Esi272aiskwhU5CDjfuFoXhuEbmvkS4/ZMs/CVvlTiC3Wu5GMmhGhI44XrM68M8aUEmA
         cGeA==
X-Gm-Message-State: AOAM531sgBH1lKOc5NFEiEDMhpewepp7KSThdC+RFYspHJkKyPpNZJdL
        NedeMrawkXlO0vPIVZmJBApNIuT/TkOXBMpX
X-Google-Smtp-Source: ABdhPJzcRKO2O/pcQkQvS3oH3HxcIMxBU739kcK96B1kHhaVCHsejV24rQDMWBEtvcZmEificI3OiA==
X-Received: by 2002:aa7:d411:: with SMTP id z17mr20389590edq.214.1640699708983;
        Tue, 28 Dec 2021 05:55:08 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id hq9sm6056344ejc.57.2021.12.28.05.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:55:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n2CwV-000CVB-Hj;
        Tue, 28 Dec 2021 14:55:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: hn/reftable-coverity-fixes (was: What's cooking in git.git (Dec
 2021, #06; Mon, 27))
Date:   Tue, 28 Dec 2021 14:40:14 +0100
References: <xmqq7dbpvb0q.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq7dbpvb0q.fsf@gitster.g>
Message-ID: <211228.86lf04j0lg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 27 2021, Junio C Hamano wrote:

> * hn/reftable-coverity-fixes (2021-12-22) 18 commits
>  - reftable: be more paranoid about 0-length memcpy calls
>  - reftable: add print functions to the record types
>  - reftable: make reftable_record a tagged union
>  - reftable: remove outdated file reftable.c
>  - reftable: implement record equality generically
>  - reftable: make reftable-record.h function signatures const correct
>  - reftable: handle null refnames in reftable_ref_record_equal
>  - reftable: drop stray printf in readwrite_test
>  - reftable: order unittests by complexity
>  - reftable: all xxx_free() functions accept NULL arguments
>  - reftable: fix resource warning
>  - reftable: ignore remove() return value in stack_test.c
>  - reftable: check reftable_stack_auto_compact() return value
>  - reftable: fix resource leak blocksource.c
>  - reftable: fix resource leak in block.c error path
>  - reftable: fix OOB stack write in print functions
>  - Merge branch 'hn/create-reflog-simplify' into hn/reftable-coverity-fixes
>  - Merge branch 'hn/reftable' into hn/reftable-coverity-fixes
>
>  Problems identified by Coverity in the reftable code have been
>  corrected.
>
>  Will merge to 'next'?
>  source: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>

It looks to me like the points you raised in
https://lore.kernel.org/git/xmqqy24a4oyq.fsf@gitster.g/ are worth being
addressed before a merge to 'next'. I.e. is that memcpy() paranoia
needed / does it do anything?

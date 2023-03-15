Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2599C7618B
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 16:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCOQFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjCOQEi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 12:04:38 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687299BE0C
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:03:56 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q23so11091706pgt.7
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678896232;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKtdjCZR5EYLmdOxv77th+1XaZZD47e0UDA6f3z03u4=;
        b=OpO06LFj1QsPoTOcsAj1aRFDSRKrN72k3z2SAYaFp2jRcaprSJwLJH3rfZewythU66
         BNIw3tFPob8wyHc90oebGvdI2VcTBtGaAj5zoLTNWhP/4NCsSSkRjW8qemYm7G0nhCXx
         pJHPgDBZOaEyPG6TkKx/cPzHw16IsLFCcTSxVvp+0GhB7p7LJmPiRiY6/Kdy9xzoN91a
         IIkxRDdzj+Nu4MtdDrS0RjuiRcQcp8p7mz0j90p64sZqpIwNHWf0JDfYnqX6At9J4DMd
         fmbdnXbxaQz2z5KROXrV9utGy7k1hXc5v8VlYsv9nhQ54BFk8N7NNrrlOFf5UTSv/CRZ
         lY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896232;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SKtdjCZR5EYLmdOxv77th+1XaZZD47e0UDA6f3z03u4=;
        b=Qm6BjTUOHwx3bF8ulZE6Xg4lrET0T3y8F5AkX/eHiU4Hnhkl34rP01Srwg3RHQbPwg
         Xo78XTV1EuIep8SrgsYrwR2bQXmLvGO6gDVC3BWiJhWAU/QpBrzj+qsB/vPn1KevzDKg
         2sgswwn6afGnQ8Pw6rjmrUTWwA+IJe6M5HrbwqpeVXqChjaTUJEw57q85QovexaUXFxp
         GNAWzisouhOVLBZviei/JkDslgMpUS5IbzlFVM3utw2dgEdo9HkIWa7BG3qKxa0X09hF
         rIdgnlC+TK9pKX68OjS9IqJzQ7IBAyPNWz+JTcZK1uJkbIKLdWuafLKWSMY7O/4qjnaX
         w7Vw==
X-Gm-Message-State: AO0yUKVTmpruOVF4jdscIrT1FljBCepRKZgzorWUb/updMhXZ1odSXvG
        j2IKKuGlgUSmoXfhrNM/Aug=
X-Google-Smtp-Source: AK7set9VKNNTW6S7L/1IAEPasqckOFL6r0FqrO/Nxw1F+/mbp/p405+Y7Fz8H91iLyf+aqQht4z7wQ==
X-Received: by 2002:aa7:948a:0:b0:5a8:9f71:315b with SMTP id z10-20020aa7948a000000b005a89f71315bmr70177pfk.4.1678896232564;
        Wed, 15 Mar 2023 09:03:52 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id n17-20020aa78a51000000b00625037cf695sm280055pfa.86.2023.03.15.09.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:03:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/4] rebase: cleanup merge strategy option handling
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
Date:   Wed, 15 Mar 2023 09:03:51 -0700
In-Reply-To: <cover.1678893298.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
        message of "Wed, 15 Mar 2023 15:14:55 +0000")
Message-ID: <xmqq8rfyovbs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Cleanup the handling of --strategy-option now that we no longer need
> to support "--preserve-merges" and properly quote the argument when
> saving it to disc.

Nice.

>
> These patches are based on a merge of 'master' and
> 'ab/fix-strategy-opts-parsing'
>
> Published-As: https://github.com/phillipwood/git/releases/tag/sequencer-merge-strategy-options%2Fv1
> View-Changes-At: https://github.com/phillipwood/git/compare/c2e329a52...3e02eeff7
> Fetch-It-Via: git fetch https://github.com/phillipwood/git sequencer-merge-strategy-options/v1
>
> Phillip Wood (4):
>   rebase: stop reading and writing unnecessary strategy state
>   rebase -m: cleanup --strategy-option handling
>   rebase -m: fix serialization of strategy options
>   rebase: remove a couple of redundant strategy tests
>
>  builtin/rebase.c               | 60 +++++++++-----------------------
>  sequencer.c                    | 26 ++++++++++----
>  sequencer.h                    |  1 -
>  t/t3402-rebase-merge.sh        | 21 ------------
>  t/t3418-rebase-continue.sh     | 62 +++++++++++-----------------------
>  t/t3436-rebase-more-options.sh | 18 ----------
>  6 files changed, 56 insertions(+), 132 deletions(-)

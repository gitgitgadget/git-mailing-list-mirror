Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2341C4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 19:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbiK2TBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 14:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiK2TBA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 14:01:00 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613DF68C5A
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 10:59:27 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 38-20020a630b26000000b004773803dda1so9894719pgl.17
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 10:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDNnWVfEEwDceJtdaYgEbF0KAr8VElZXHr1mgZho1Vc=;
        b=pK/0kx7ozGZqTH2Neyr1SJghUNdFG4DIQDfnwzHfYDYs/nEL2ml1rRtB9rO91STT0R
         g3vtIegUshTR8+5TVVuZov38zF+gRlzFTZEwYz/SfGSyjseuRhneK/AM7XzBarVviFv6
         K9bWxvAuJn3dKeQC8hsJZPt+dDKhpyAwYSeOVCp3suVdXo6+D0UVstDAMCAqYgXmjBUd
         LpnqZqdvf3JF9AHlXdoVPp1D5QIEX6qaPPi+edQZtUoTtoognhF/j1FVWLU2c9zdMtxo
         12rasfjQ8Mj5xM9I7oXIyaPkRV1NybAjb4eRCrEGLsYNhiNimnZS1ObWbhcWGzyYvL+V
         ScAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDNnWVfEEwDceJtdaYgEbF0KAr8VElZXHr1mgZho1Vc=;
        b=xIV0iB2vqQOd7AJvF+aRqQZbXtA4LFWNpnlAtay9W5fr/ruF+HqkrBBM3iEyoDue7u
         KJUVBRqT1e3sHIkYc/GG4ZSfTVidDJaz7AvMioSzxsZotyYt0NRdWW0VU1vyyLTHGKOU
         iMg12GUywCupPBzi05K2hclk13iz9dI53gE/RLlcLvl/7iGj7xWNNWYVHL+dODN53kix
         aufscOTZA6bBs4Uo4zyTh0Q+KHG4+ifVK0fJKFIiQK+RnKHkEMJlSi5a8JLsf+pve7Cd
         CDNzlhn4wJXQ3C6QoT1AuvECI83GwOkUCoUZ2cJga2z7DhP7CDJHXuHbIZHcdXyCiJgu
         cIAw==
X-Gm-Message-State: ANoB5pnQONLc/ahXZcz7XZ7goRYjqJ8DTBcT/toNERZ9JmtL+Q+OuBFw
        kVIjIhjKtQSZR8WXn+N38IPx1oeC8171zA==
X-Google-Smtp-Source: AA0mqf5wOUfZpDdJF3UK0y5D71R+uZWO0tuaBMVsq5RM/TxGvG+S3jFTTu89QoI0BN2wahnVlffEUezy9SWKUQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:f94c:0:b0:56e:174e:efdf with SMTP id
 g12-20020a62f94c000000b0056e174eefdfmr58865806pfm.29.1669748366857; Tue, 29
 Nov 2022 10:59:26 -0800 (PST)
Date:   Tue, 29 Nov 2022 10:59:24 -0800
In-Reply-To: <xmqqsfi22j67.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqsfi22j67.fsf@gitster.g>
Message-ID: <kl6lsfi1d1tf.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: ab/remove--super-prefix and -rc0 (was What's cooking in git.git (Nov
 2022, #07; Tue, 29))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and are candidate to be in a future
> release).  Commits prefixed with '-' are only in 'seen', and aren't
> considered "accepted" at all.  A topic without enough support may be
> discarded after a long period of no activity.
>
> The preview release -rc0 for this cycle has been tagged.

[...]

> * ab/remove--super-prefix (2022-11-21) 12 commits
>  . fetch: rename "--submodule-prefix" to "--super-prefix"
>  . read-tree: add "--super-prefix" option, eliminate global
>  . submodule--helper: convert "{update,clone}" to their own "--super-prefix"
>  . submodule--helper: convert "status" to its own "--super-prefix"
>  . submodule--helper: convert "sync" to its own "--super-prefix"
>  . submodule--helper: convert "foreach" to its own "--super-prefix"
>  . submodule--helper: don't use global --super-prefix in "absorbgitdirs"
>  . submodule.c & submodule--helper: pass along "super_prefix" param
>  . read-tree + fetch tests: test failing "--super-prefix" interaction
>  . Merge branch 'ab/submodule-no-abspath' into ab/remove--super-prefix
>   (merged to 'next' on 2022-11-18 at 34d0accc7b)
>  + submodule--helper absorbgitdirs: no abspaths in "Migrating git..."
>  . Merge branch 'ab/submodule-helper-prep-only' into ab/remove--super-prefix
>
>  Remove the top-level `--super-prefix` option.
>  source: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>

Hm, it looks like ab/remove--super-prefix missed the preview release..
Per the discussion ending at [1] I think my one-patch fix to "git
fetch" [2] should have made it into the release (it's pretty low-risk
and doesn't introduce too much churn to ab/remove--super-prefix). Is it
too late for that?

[1] https://lore.kernel.org/git/221117.86y1s9h2q5.gmgdl@evledraar.gmail.com
[2] https://lore.kernel.org/git/pull.1378.git.git.1668210935360.gitgitgadget@gmail.com

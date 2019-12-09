Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9081C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C28206E0
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 19:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vd0XrVuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLITnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:43:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53281 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLITnD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 14:43:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id n9so613900wmd.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 11:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kf+B5g3wNFJ5+U73Qxf6ae2rsIW5DpZoWabH9cdu2Rk=;
        b=vd0XrVuPSpTeFXZaodJ9umtEI0W/Y3usZJE1DHFqsd8mzG42e9K0/Er/hUyJ5APRxx
         /WGi3SYxIGvkhwLh3ZwXKMH9EAFVb10Ss+3Re8zQIfyvxp282zy4R5VKXpr9Evb2DYN/
         7LiT7gcd4dXpg23yEGM6k7vO6Y3r5GkD1mKxT3XttuZo6M79q+lCu7L0B8Fau56uG2AX
         jm8x3jytrz1clJn7UcugAJWLTH9/i+9E61uZ3m1+qWJlGp0LPSOH1EKsi78VRXJ1cGeJ
         6WQL4NJb7P0IvfT5NuK+zGhR0OgJp/TxFMm9/FK9WCfKyb46dOJYUXJQhSuiNx0HQUND
         kAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kf+B5g3wNFJ5+U73Qxf6ae2rsIW5DpZoWabH9cdu2Rk=;
        b=EsCB06Xk7bZL5C0/5yJsusPj94g3I6KrkMLm4WnJLnEPB500wni1J1WX1FV8oWPpLR
         4yXwyYZT/XsNXxVA9bD5atC3+/AFq7092lA9EMtco6jUm81acJ2uRfi6v5NWAiaERpvD
         AXr0sOarYtLo9yzUhqKBfKhOxWyMJyEcPWvQ8SBvYcotytZoxNboHEEsPT4ZeUr7KwuR
         rFUXdC6KJo5/q8tyUPH6RDI1KyTsbCcDH+BlU6f+h1gNqiLlxX5HHqPLrWPJn0wx0ytv
         r7AaQHYfMuJskt4c+8XzB4lHfteqiT2xBfBrrEaakjw/3M28WZ0UFlK7SkZ5JObnfvO/
         H1Ow==
X-Gm-Message-State: APjAAAX6sC4FfkjKREZUQybp9likaxZfSSp+3XM9melNIcybpTJxI5dt
        iLJRmEJo8kJ7OdNLPVIskeHyYx91
X-Google-Smtp-Source: APXvYqzya28LfmnT2KBpq2MuG297JHOU0KGd+fUFrC7gG71ZJ4Xk9FHj2kjvAoU8CYAifiQQwb7ygg==
X-Received: by 2002:a1c:e209:: with SMTP id z9mr687885wmg.95.1575920581208;
        Mon, 09 Dec 2019 11:43:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z64sm418405wmg.30.2019.12.09.11.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 11:43:00 -0800 (PST)
Message-Id: <pull.488.git.1575920580.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 19:42:59 +0000
Subject: [PATCH 0/1] sparse-checkout: respect core.ignoreCase in cone mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first of several cleanups to the sparse-checkout feature that
had a large overhaul in ds/sparse-cone.

We have an internal customer that plans to use sparse-checkout as a core
feature of their version control experience. They use a case-insensitive
filesystem, so as they created their directory dependency graph they did not
keep consistent casing. This data is what they plan to feed to "git
sparse-checkout set".

While I would certainly prefer that the data is cleaned up (and that process
is ongoing), I could not argue with the logic that git add does the "right
thing" when core.ignoreCase is enabled.

Thanks, -Stolee

Derrick Stolee (1):
  sparse-checkout: respect core.ignoreCase in cone mode

 Documentation/git-sparse-checkout.txt |  4 ++++
 builtin/sparse-checkout.c             | 19 +++++++++++++++++--
 cache.h                               |  1 +
 name-hash.c                           | 10 ++++++++++
 t/t1091-sparse-checkout-builtin.sh    | 13 +++++++++++++
 5 files changed, 45 insertions(+), 2 deletions(-)


base-commit: cff4e9138d8df45e3b6199171092ee781cdadaeb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-488%2Fderrickstolee%2Fsparse-case-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-488/derrickstolee/sparse-case-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/488
-- 
gitgitgadget

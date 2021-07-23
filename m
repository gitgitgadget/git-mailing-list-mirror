Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61070C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FCD60E0C
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhGWSL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSLz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 14:11:55 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082BAC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:52:29 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id f62-20020a17090a28c4b02901733dbfa29cso7292016pjd.0
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=V19lGWxQsziEMG4oMq6F5F7nUxCkmCkupIdSSkSVYgk=;
        b=SNP6e0cc5Co9m0rA75Di6T81OsDI4f9uiExATTleXl/IHOLltw/PouYCtCMLdbhrIj
         XvckAR1yXILwk34XsZAKlz0J+/ObYKWjMwaCTXsH+Y1FvSDOzJJeWVSFlKxo7tlasnJX
         bi+IoBRQJDKsNrnpRxrOgsHfLT06JqofvPQZNoS0ak1gx/GYmAWA17v4C+zaW1AB+vP2
         9CrE2vMF2U79PDs6vwc42SPT9Q6bWJRAYJt4dp53bdMlaMj5EY/cupL4/pnsm5V1kYJe
         4AjioSfMJvGkACNK8/MS8GjRWU55eRLgQbMY2fuEsRx8weS6zSrB9elIdIB5ffU1Bto2
         VHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=V19lGWxQsziEMG4oMq6F5F7nUxCkmCkupIdSSkSVYgk=;
        b=TZbJWr9ZylqiLEdjuVbpX+yNsa2HijuEBcKYtr3B8draRJQuA+TP9MqtDdCTVjL13q
         FSemJ+8+hAhmZZ84c1Xp2MxAPr+by/XzQ+ZhD7PhCZT0tpjcO2bEobNK/Nq2F3LrV1kQ
         ewTwflwaqUAdRQae5UWM2CDj+8Mmjvo8jFbne9yQDRINuj13O8JLJTKTZYVexZRsfdMT
         FGmeDSkdypB2jQQUYLU1qATjqJlvYfkD40eYYsvl/ykh4KA0Jzd5OV692O/oO/tc5EqT
         4Bswbkkf1c/pI+kKfkJFUs0dBKJgIHZpXdA5t1Y2Gc0ppf1nkjI8J6ADXTBvUePQk6rz
         Ew7w==
X-Gm-Message-State: AOAM531wpK0+niBogQuLjvY8t6d9BzYIhDBhM6zcuy/DNvXUpbDN44VH
        JcqnnxyA48NG2wnLMUq07HHiTznf5p8JqK3LyCCYbovMVKwv7tClRNtqCV1MmiTYzaWcDl0lk4o
        aMq+wq+XgUgj9leFFymDL6lgr5J3ItUm6/i9wjK0M/H1et/UlZYew2x5LD+Oz6cVqrY8PZBATsr
        Rz
X-Google-Smtp-Source: ABdhPJzNWqo6qF25UlR2gIZJaRZcrbM1h1RPWJtn6knUlRSSVvbYvMCuXTUBM3pjU3ensK5FBZtC4lTLLJhpkqbzf4dS
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:189:: with SMTP id
 t9mr490895pjs.1.1627066348101; Fri, 23 Jul 2021 11:52:28 -0700 (PDT)
Date:   Fri, 23 Jul 2021 11:52:21 -0700
Message-Id: <cover.1627066238.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 0/2] Another partial clone prefetch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's another instance in which we need to prefetch in order to avoid
fetching objects one by one. More information is in patch 2's commit
message.

Jonathan Tan (2):
  unpack-trees: refactor prefetching code
  cache-tree: prefetch in partial clone read-tree

 cache-tree.c                       | 11 ++++++++--
 cache.h                            |  9 ++++++++
 read-cache.c                       | 23 +++++++++++++++++++++
 t/t1022-read-tree-partial-clone.sh | 33 ++++++++++++++++++++++++++++++
 unpack-trees.c                     | 27 ++++++++----------------
 5 files changed, 82 insertions(+), 21 deletions(-)
 create mode 100755 t/t1022-read-tree-partial-clone.sh

-- 
2.32.0.432.gabb21c7263-goog


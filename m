Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B92C4346E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 03:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF06B239D4
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 03:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/Mps1uy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIVDEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 23:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgIVDEB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 23:04:01 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5F0C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 20:04:01 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id a16so14824070qtj.7
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=1gsIBrp3TNG5uXhWrCQNzJxy9bOf80tpCW6g73WihTo=;
        b=c/Mps1uyz4hkbDnacGTBEDwVVLGsHtnr5l7f+DaiLt8iqwLxnOO2hV9YNoCdKDr4bz
         OuBCp5+8URBRZiEtjrMYOpT8YtOivvozgpUjweU208hk94fvKVHMLyKRnEVDo1RXBPyr
         /YC/x/kUNtZy49TxLrhC8QMz9ZcfTQjQJraBLrjZPXB0i6H6doo7yIpI5TdQdko6uXba
         viGAW6G2pHEPcq+leFpL1deLh3x512vyuP1BhKpKJ88XonYUyhHWbKvO1tesVSUhniWh
         qYqBaUzAk7UuDaesFTJQX9Jf03s0w9uaV33/erjEXIg8q6i0Yz36a/c813etc9qB4xNz
         bxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=1gsIBrp3TNG5uXhWrCQNzJxy9bOf80tpCW6g73WihTo=;
        b=khjJbXz2JeXAjfFek4mbJGrrL83WUP3svuEDJRl9LVSUmBiLXyaTICuN2vaHDzY6kn
         dLkLwSuxax4/6/A0UlBsHJ91vZEluh0fZYZFPGdfIciDn4RodtVL3J3HAM0QNCwDaItI
         xWlQC6UUmXBzddHI27P+k+oRrjNUN/YPqz3NhBPdScMicGQ4b1/nCqrvl/iPPyCnYds4
         uuR/rnDFsbCi+t+O6Td/+VEXK4FKQkcPPwOiN6KgoFCpo5YS8msFfZsmHeYleXLW0QDd
         wrYKk/8qdUHq5V8wTuXjM22isRG4GkT706YT8EP3G982LQ5fg/Uld+O4kORz26V+eBr/
         2lCQ==
X-Gm-Message-State: AOAM533fy/NKokJ2Ln1DMw+TKEF+hTG81JN6kKcPraeyl43ixkrHjt/n
        ktmOJ6d88+yoQEt8bA0o3MEUmF2r/WxmKDfEq3l5Av+0axdQl3BSGkKPyQNjQGApgi/gD/ntAu+
        V0j4VovZdBzCvonuAvNYDZe/Sa6dFoYncOFElDroh5TxNZCqoK/brdTuNUietfqvDRnsPOSvj7r
        KC
X-Google-Smtp-Source: ABdhPJyU18mcUTmb7BKt39poA0sCCG3LduXLAD75NqhU12oG4ojNekH8tzsJrPfwOWKO7UQKgJljIhNfcWqrnomqw0eR
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:9cc6:: with SMTP id
 j6mr3592344qvf.60.1600743840520; Mon, 21 Sep 2020 20:04:00 -0700 (PDT)
Date:   Mon, 21 Sep 2020 20:03:55 -0700
Message-Id: <cover.1600743698.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 0/2] Fix overriding of partial clone filter when lazy-fetching
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, chriscool@tuxfamily.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was noticed at $DAYJOB when in a partial clone with a filter other
than blob:none. The 1st patch is a code cleanup (so that the 2nd patch
does not need to take into account the unused variable), and the 2nd
patch contains the bug fix.

Jonathan Tan (2):
  promisor-remote: remove unused variable
  fetch: do not override partial clone filter

 builtin/fetch.c               |  2 +-
 list-objects-filter-options.c | 10 +++++++++-
 promisor-remote.c             |  5 -----
 promisor-remote.h             |  2 +-
 t/t5601-clone.sh              |  5 +++++
 5 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.28.0.681.g6f77f65b4e-goog


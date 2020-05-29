Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDB7C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C2C20810
	for <git@archiver.kernel.org>; Fri, 29 May 2020 22:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhDT8tY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgE2Wae (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 18:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgE2Wad (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 18:30:33 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EC6C03E969
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:31 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o11so4233825qtm.7
        for <git@vger.kernel.org>; Fri, 29 May 2020 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hxBUgFdYqtL5CytpcvC4d5hJM3B66NlI4v7I62nYfYo=;
        b=bhDT8tY2+cYuIl6c4g4LDGZ4fg+X3bzhZoM21gmmW6PvZc6UNJL3nAku6l8KEYIshF
         FZRBWCYzJQ5/GNS1lKy+08ae31KFDyfeL+P10RsESA5RUkDwT0r/iR7LrbIBydBT5AVo
         4lxaV6gKBA2B9yXeI+/CHMK81RHnng3bq8eIGQn1UNRrOiFgjLdYoShF9QqPXN0QbfbY
         8yC6Qt7bAUMm5D80wdOktvAnqUPqZRt6B7QsEl8XTnkeantb6Al67r7djddjdcuK209t
         TrgTRcZi1q7J81qIb4vr1EDrhADfwOIOuFOlzTRFc96KHVg9hgBCPHLPHhheGwNS3CBu
         Cixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hxBUgFdYqtL5CytpcvC4d5hJM3B66NlI4v7I62nYfYo=;
        b=ZjwbPSjmU5jY68VkBBVI3A77e+B7tq9qizVPbQdelx9M1EYFw8+ml8QoKx9B+JJCSk
         1U3vfK7ZXvxYWe50bwqcJKe2wSmPGbskw/iQ+pfDjB6ShPpnV7cx7pOxMCegyM81/A2+
         ek4klqLoD+rpkPCBVIx85qC9pmXm1fAbtGypcw99DlDetFigwlaeQocnEL6L8hp8xQo4
         5sdgyy3RNBa+9vq3ngXuXXde1ptJrY2SLJNpFGCe5uAFfjRThWzJCiFdTbYLy31eipZ+
         xaQyGceF+Edq2WOr3GyqhQ39Tmmgw9fnZRAGrSOWkXH2jRwjKTYXJJ8BByZpXduHrB5w
         iWKQ==
X-Gm-Message-State: AOAM531zox1OB+DtGEB9EwCFlVhQK+TvQw8+tnIl2kPPevy+bOhVTl0u
        4/OOYwD0i5sSNUuziNH5OP12+39SiCaB711ePLTzZSjnnE0UrJhGpqSSOjpZO2prxEh/wFlEhwv
        hrTVxk+cz4c1BBxiLSq7etyXQtG3V11R/ePZ/obh69zYaNjJAFBhn7wngeYqqP5IC/l5cnay1JC
        Ji
X-Google-Smtp-Source: ABdhPJzKvGTaVDJTCetH5V4vFxKmP6uQ0NtftJyvqU/MJC6OUHroXnuCIjIznD3Eslq9m1XLhCINXIpS9SG6wyqmqubp
X-Received: by 2002:ad4:56b2:: with SMTP id bd18mr8819404qvb.209.1590791430409;
 Fri, 29 May 2020 15:30:30 -0700 (PDT)
Date:   Fri, 29 May 2020 15:30:12 -0700
Message-Id: <cover.1590789428.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 0/8] CDN offloading update
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For those of you who are interested in CDN offloading, we have been
trying it out at $DAYJOB and found a bug - since we use the URL as the
name of a temporary file, if the URL is longer than the maximum filename
size (255 on Linux), it will not work.

Here are the latest patches with the bug fix. Note that these are based
on the "next" branch.

Jonathan Tan (8):
  http: use --stdin when getting dumb HTTP pack
  http: improve documentation of http_pack_request
  http-fetch: support fetching packfiles by URL
  Documentation: order protocol v2 sections
  Documentation: add Packfile URIs design doc
  upload-pack: refactor reading of pack-objects out
  fetch-pack: support more than one pack lockfile
  upload-pack: send part of packfile response as uri

 Documentation/git-http-fetch.txt         |   8 +-
 Documentation/technical/packfile-uri.txt |  78 +++++++++++
 Documentation/technical/protocol-v2.txt  |  44 +++++--
 builtin/fetch-pack.c                     |  17 ++-
 builtin/pack-objects.c                   |  76 +++++++++++
 connected.c                              |   8 +-
 fetch-pack.c                             | 135 ++++++++++++++++---
 fetch-pack.h                             |   2 +-
 http-fetch.c                             |  64 +++++++--
 http.c                                   |  88 ++++++++-----
 http.h                                   |  32 ++++-
 t/t5550-http-fetch-dumb.sh               |  25 ++++
 t/t5702-protocol-v2.sh                   |  88 +++++++++++++
 transport-helper.c                       |   5 +-
 transport.c                              |  12 +-
 transport.h                              |   6 +-
 upload-pack.c                            | 157 +++++++++++++++++------
 17 files changed, 711 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/technical/packfile-uri.txt

-- 
2.27.0.rc0.183.gde8f92d652-goog


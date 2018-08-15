Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6431F404
	for <e@80x24.org>; Wed, 15 Aug 2018 23:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeHPCR3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 22:17:29 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:35331 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbeHPCR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 22:17:28 -0400
Received: by mail-vk0-f73.google.com with SMTP id x125-v6so594236vke.2
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 16:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k4OtF+g+c3gAmtIIbgGm36W4NVdQSLZ3124YA24U7So=;
        b=nLmMrher6Qc4VHIJ+tz7T3kyjPRXxFSdvVWh84SlZfpI/s1JCapw/6c3mrb2dwLr9c
         ueAr75hPCKjZs7Ymg/GfLBg2/Vj3dPl2ljqQq5idK8tuBppiuuOLx4s41u5yv/a/G1pD
         CvLtTMJRg/dYFwCQraqu47iaaN96e4ySQikJByWp5BsXqwqPCaU+LBGkmmXhQv74ubTk
         8nQZuT63AS86ZFzjPocn53WlsqzcNLi1sE4hw8gMy9qPpk0PHc0U9oaMi4CM9WTCMgwM
         DeWhb1U+VX/0FgpMvrkIhG37HNdUKHbssZMI9cKX/gk78GAQoV3C2uouEoQnKkVpRFT0
         CEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k4OtF+g+c3gAmtIIbgGm36W4NVdQSLZ3124YA24U7So=;
        b=JKRYdKLd+VlVUDiJ4JCROWad0hXwR70mZ14j/zhaetFk63rJg+A1OPaV5/owl/yFzz
         RMzV0mVRsPzK+F6LW5fnJB9OmqlNRWwx06opx2okrlOlf1183+SsH9/kocq2QFmSQjsE
         6luBqpoIjpjp+pFI93wxtvizYQ9CGmtJAnTJxUszJJS72LZCBDK4lOdyI/2k3TOdUJRS
         SWqsFf4RxiXOwH2DnXOLo7HgMcmYsiSgCd7jAAR+MkZ5KVoxV9VvysUrHvW0qN/WC2+B
         afSRdR2hUKk1Y8nbQUZv4Zm2xTi1fVHyL49BaRJmm+7WiIiysbSCWT/sDuzpm6uXYUbv
         1Icw==
X-Gm-Message-State: AOUpUlGq+OPd+2yJSNDHfz6pHG0ctzFxI2XmyalTX7BHEOhM9Opd9nRQ
        k4FkWFN+8oRRmtR2JH24pjRSGhx+NSC0RpOlZFpr4sh7DxEigb4+3bUMjwEjWmkILU03v5F68js
        3HKjxy7hLkYRWJ1OcLjnkcMbnDW1U4p8gud7cWRtltPcOJy0viymGrLYECws=
X-Google-Smtp-Source: AA+uWPzI4VZbmkLegZW9RCSgWhfMuOPAnNdp7ALx/jgU1MTCHKRj7Nx+iOuj2aGh/w5huyRfBFLnNnth1qAg
X-Received: by 2002:ab0:3393:: with SMTP id y19-v6mr13426925uap.98.1534375386928;
 Wed, 15 Aug 2018 16:23:06 -0700 (PDT)
Date:   Wed, 15 Aug 2018 16:19:05 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <cover.1534374650.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: [PATCH v6 0/6] filter: support for excluding all trees and blobs
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Applied suggestion from Junio about removing -e flag from awk invocation.
Sending an updated patchset now since I haven't heard any other comments for a
while, and I don't believe Jonathan, the most active reviewer, has any more
concerns.

Matthew DeVore (6):
  list-objects: store common func args in struct
  list-objects: refactor to process_tree_contents
  list-objects: always parse trees gently
  rev-list: handle missing tree objects properly
  revision: mark non-user-given objects instead
  list-objects-filter: implement filter tree:0

 Documentation/rev-list-options.txt     |   5 +
 builtin/rev-list.c                     |  11 +-
 list-objects-filter-options.c          |   4 +
 list-objects-filter-options.h          |   1 +
 list-objects-filter.c                  |  50 ++++++
 list-objects.c                         | 232 +++++++++++++------------
 revision.c                             |   1 -
 revision.h                             |  25 ++-
 t/t0410-partial-clone.sh               |  45 +++++
 t/t5317-pack-objects-filter-objects.sh |  41 +++++
 t/t5616-partial-clone.sh               |  38 ++++
 t/t6112-rev-list-filters-objects.sh    |  29 ++++
 12 files changed, 364 insertions(+), 118 deletions(-)

-- 
2.18.0.865.gffc8e1a3cd6-goog


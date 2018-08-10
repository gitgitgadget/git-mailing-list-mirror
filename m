Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63EFB1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 23:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeHKBin (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 21:38:43 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:51286 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeHKBin (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 21:38:43 -0400
Received: by mail-oi0-f74.google.com with SMTP id m197-v6so10640073oig.18
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=/L0BR7KgJk6+DTx7FeC8G8gT2UWkaTSPc6qSDvSivn0=;
        b=vnlqftubqY4yd2clEJsRlXshidq+8TOA/wh+rVfAQMBhy6GdZuxV7YAr220Vx79Hbw
         Bbx7iGoa47d1nsHcSqjZIAurnLvIoFUepWlD1+giAwMrppk1E6MuptdXTVrAxBuwDac3
         6ro7Y8djUKJsNrWrztBScan0UN2PyzlAU3QSWMRiq8F0F4E+sErmebu9dlL8caQCIWom
         FR/ZmZhxHckjIzR2MqSEEpIjmsPIvO2PFb26cgLTmhn6hIGhV8w2mZIv80aHrBp/n2OK
         FUblaOxigJu2MOpn816lO8Qv/W+WzHXXwJoWoQv+B+GJhloTsZBBTC02809jZijXNE55
         eqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=/L0BR7KgJk6+DTx7FeC8G8gT2UWkaTSPc6qSDvSivn0=;
        b=HhWidiCh+GvSvpS6Z9xUQA3TcPJVwqa7kpsXf8q/nU2WO9JeTtIRhoHg7QrguWZ8Qq
         V90GhPfCUkl0yblreTauZ2qbpQx7WJX/ZAtO+EmbNqOlocABPyChB3umPd6zVu55Njvw
         rT/ZHygRwQIeXlijg1+kByRsNbeE7xCuBv/zo++rR2ASLC7YtrnyzbFN87pL/z+Ugj98
         wEXCxGHuFnqdDiWQ1aQl4p9u5mXwGqQWjEci5E5yPydbF40HqHsfNkiVfT/JGvoOdxhn
         rz/HsVGzbFOTuft8PzLRfwZ0u5k5DZSW1FC1mL3lIFDh0aD23xSbGq5pS4VGKOXXX9id
         SJhQ==
X-Gm-Message-State: AOUpUlFKPBkxLOmkH5777Ems3GSlkehNH3HOWL0Ed1QhijtWs3Z+C7C/
        KCm63SoF82ajToJ62A4FQkwYCCdpgvKTsiDP5hQwQayemMDUzVJzLlxT+U4zQA1SlbdZT6PUWhS
        EKZVgghvtrSsQwvmNj8a8XSbmb32yOe0lEB4T6SMrkpiYXDVUqbygjbanxEQ=
X-Google-Smtp-Source: AA+uWPwyFISYW/4w9CI2emkQb+QK6umLYbLcbsSQ1jjfqaWnIV7z5vdU34bHYik/OqvJ9/fF61Ljefx3P3YZ
X-Received: by 2002:a54:441a:: with SMTP id k26-v6mr4547531oiw.94.1533942407500;
 Fri, 10 Aug 2018 16:06:47 -0700 (PDT)
Date:   Fri, 10 Aug 2018 16:06:24 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <cover.1533941986.git.matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v2 0/5] filter: support for excluding all trees and blobs
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, jeffhost@microsoft.com,
        peff@peff.net, stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes applied, as suggested by jonathantanmy@google.com:
- Re-ordered patches so 3-5 actually come first
- Sadly, as a result of the above, many of the tests in the "treat
  missing trees like missing blobs" patch had to be moved to the filter
  implementation patch, since it doesn't seem possible to create
  promisor objects that are really recognized as promisor objects in
  tests (unless you actually do a partial clone). Overall, I thought
  this ordering was more elegant, so I kept it.
- Reworded NOT_USER_GIVEN commit message as suggested
- Fixed style error list-objects.c (var dec and code mixed)
- Added missing /* fallthrough */ and explanation why
- Removed the show_missing_trees flag - now we won't show any error if
  the only problem is the object is missing and it's a promisor object.
- Renamed only:commits to tree:none and updated commit message
  accordingly
- Added /* blobs are always omitted */ comment in list-objects-filter.c
- Fixed up tests in t5317-pack-objects-filter-objects.sh to not use
  unnecessary sorts, and to do more commands on lines of their own
  rather than in pipes


Matthew DeVore (5):
  list-objects: store common func args in struct
  list-objects: refactor to process_tree_contents
  rev-list: handle missing tree objects properly
  revision: mark non-user-given objects instead
  list-objects-filter: implement filter tree:none

 Documentation/rev-list-options.txt     |   2 +
 builtin/rev-list.c                     |  10 +-
 list-objects-filter-options.c          |   4 +
 list-objects-filter-options.h          |   1 +
 list-objects-filter.c                  |  49 +++--
 list-objects.c                         | 236 +++++++++++++------------
 revision.c                             |   1 -
 revision.h                             |  10 +-
 t/t5317-pack-objects-filter-objects.sh |  40 +++++
 t/t5616-partial-clone.sh               |  27 +++
 t/t6112-rev-list-filters-objects.sh    |  13 ++
 11 files changed, 259 insertions(+), 134 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog


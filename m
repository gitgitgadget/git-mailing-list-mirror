Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC5111F462
	for <e@80x24.org>; Thu, 13 Jun 2019 21:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfFMVvj (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 17:51:39 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:44489 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfFMVvi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 17:51:38 -0400
Received: by mail-oi1-f202.google.com with SMTP id b124so112457oii.11
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 14:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MSIZqpoCGPhoVJrvaIcY2ZCteTsC1mfMNICK7keQnlY=;
        b=bwcbxL6DxU/pWsroqOhlQZpa5DsuSL1jBX20jZ6XnPWqf2Uubokaud6TyaA4fIUQrY
         JyVicSC9x8niphHh9gjCtN/zwT0wFnMR2ER3E7Luh6d8T35NrDmFoH/ztUBTJ8u2OkBd
         QdfeieCPRA6qFi7JKJ6lDi85jjqmF059ErgK9WMSS7mrkaaVNzvQ242ygpCUXrbhcLrl
         JqernEEDHjGHv2z+vXjmQ3dXB47rXNbyaeAh5Xj2RpXSyeoRFoWrr4LshPb9oUwQFMv9
         XCiccdxU50Exo1ocFdm3GJNnzaRGzPAr3L0Q3DLJWv1ep8FMqAWLumRuKIp+4iHTdq8o
         F3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MSIZqpoCGPhoVJrvaIcY2ZCteTsC1mfMNICK7keQnlY=;
        b=bbwQ0Tl0ffRBUaIiHdwjSEfc+PrNe0MyRqUmQosnWZgnUihwvwlH/v25MUlxvOTv1X
         CNkk/vs74vZEXLWoH8eRiqL+Vsp6YeTHOgyxNoHVktiDT/m+n1QpQQCj6rdhBPufYUXG
         wy0HnZ3hxQWDthWcwe/FxqkqxW3h+rv7LxMqPtTZL/W3MhMoWSdUXG55zWj70zjpbMNz
         WNMW9IywBnqOhaD1MtcTZ3MhlB0M1aXzfgTuAuboXS0DlTBspuye3sr35RtD0YVw7DAW
         WZbvWNlbPy11JzSWbQYE7iF4JNJroCU68Rjztk+HO9AmGp+dgOyT+q9sdELaiisftUXF
         aumQ==
X-Gm-Message-State: APjAAAUTbbuWY3hhPNW2FMHoPB3qqhouPuKQAhFdOszt9WafWONAsTN5
        /2ySFjyuQmaIOds9WUI5CijIkSEQ046ysMwRZg59yv0wRoevzkJQhkRr97L0BYCJfhkhnnP6MRt
        ojwVnbTzi9DQfP7ZUSB6TIlPJv0rdn0K1GY1+bkIV+14THGAXGZZdlv2bSEM=
X-Google-Smtp-Source: APXvYqxDCpDJAkXgFI/VifYkuho2KnDHkUa/cz3jcdawpAPtrjjLcmDDUQFc9le2ldTanSAJj4bXHn2Cg2Qt
X-Received: by 2002:a9d:6416:: with SMTP id h22mr13776377otl.44.1560462698159;
 Thu, 13 Jun 2019 14:51:38 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:51:23 -0700
In-Reply-To: <20190601003603.90794-1-matvore@google.com>
Message-Id: <cover.1560462201.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v3 00/10] Filter combination
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It has been a while since a sent a roll-up. Here are the changes since v2:

 - Re-use more URL-encoding logic in strbuf.c
   * This was partially achieved by changing the helper function to accept a
     function that will indicate whether some character must be escaped.
 - Re-use more URL-decoding logic in url.c
 - changed the filter_spec strbuf to a string_list to avoid explicit
   initialization
 - Remove logic to "expand" tree:#k and tree:#m filter specs since there is no
   server that supports tree:# but does not support tree:#k, as they were
   implemented at the same time.

Thanks,

Matthew DeVore (10):
  list-objects-filter: make API easier to use
  list-objects-filter: put omits set in filter struct
  list-objects-filter-options: always supply *errbuf
  list-objects-filter: implement composite filters
  list-objects-filter-options: move error check up
  list-objects-filter-options: make filter_spec a string_list
  strbuf: give URL-encoding API a char predicate fn
  list-objects-filter-options: allow mult. --filter
  list-objects-filter-options: clean up use of ALLOC_GROW
  list-objects-filter-options: make parser void

 Documentation/rev-list-options.txt  |  16 ++
 builtin/clone.c                     |   8 +-
 builtin/fetch.c                     |   9 +-
 builtin/rev-list.c                  |   6 +-
 cache.h                             |  22 ++
 credential-store.c                  |   9 +-
 fetch-pack.c                        |  20 +-
 http.c                              |   6 +-
 list-objects-filter-options.c       | 267 +++++++++++++++++----
 list-objects-filter-options.h       |  57 ++++-
 list-objects-filter.c               | 345 +++++++++++++++++++++-------
 list-objects-filter.h               |  35 ++-
 list-objects.c                      |  55 ++---
 strbuf.c                            |  15 +-
 strbuf.h                            |   7 +-
 t/t5616-partial-clone.sh            |  19 ++
 t/t6112-rev-list-filters-objects.sh | 194 +++++++++++++++-
 transport-helper.c                  |  10 +-
 transport.c                         |   1 +
 upload-pack.c                       |  13 +-
 url.c                               |   6 +
 url.h                               |   8 +
 22 files changed, 879 insertions(+), 249 deletions(-)

-- 
2.21.0


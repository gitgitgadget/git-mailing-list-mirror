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
	by dcvr.yhbt.net (Postfix) with ESMTP id 002A11F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfF0WyX (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:54:23 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:51676 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfF0WyW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:54:22 -0400
Received: by mail-pl1-f201.google.com with SMTP id d2so2242093pla.18
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SwEVw72Ch3QqNbbDoWNlsO4jTVaShbvOHr+GUeM+C3w=;
        b=HFqNTCiCUdFTVloAxgEnwvA7AQuMBS3xKZvBc3IJiH4K2hkpXjssdxynvHXNJ+HkDC
         jP5/vQYFrKgAWMK2vDdTBURxplNyyoI3bpODECHeRdQobLDKGo60JPraqoDcnLGnRtQA
         zi7zhG1TOdmO8EW4Sfdg842zvLVny2WFWDogE1rMoIYOT6Douw/ai2/wxFH2wYgIutSs
         CoaLhax78k68O9H+aTTQzI0Huxu1ibhzNYey9wOr69bYK1ays0HpM4rovsGsVDbWYHLj
         xS7zpwAKnYsqqXBqkgSeEBRFY400KEtnh/is8guyvjBvGqg+0PKjSOgtp+mAi/ObUIag
         KFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SwEVw72Ch3QqNbbDoWNlsO4jTVaShbvOHr+GUeM+C3w=;
        b=YMKKOVbAvwOCOfgpQqmXGuxFisY+Oky3ipzApNlXtCRUdMhnIfMmAbMD6AIBZ16JpM
         Vv2u4bl8KpBxcX2hh66IATxt/qJ+IJo9/1FT8sOeChPELqfhU01+EyT3jKACg5mAoFgq
         JJEAwumkqfRcUQHe7zCYl+qPhIs9e1Xi2h6bA4CrPKpUlSGbPBzFhEBK5PGRTsKgP3LI
         kTXCxIWKNdnClbSIV03a1QhaPYqdnMAQOU/BrzcNavU31cL2+tGtvvB3FJvVZvAs2XtB
         O5xX2cBHA0HomvDZpMZFacY8N0zRgeuv45oT5R6nMxOLogFBGf6A/VRckGsmb4oCZqpU
         YmTA==
X-Gm-Message-State: APjAAAUEaIbw0/up34CfcsUhVBI03aNqHMr2GxXwaSPOODGdcj1mFAZm
        i/E4zALk5Vgy+Jv4RNx44NGdI8NhPjpLUlwiVKxdEf08Vm8ocHQNi4Qrp2R7CIXeO4pEhj1eX36
        KYyHpk0euNBBB6U+r6ThhZ7LEC6vLAtEsRgl1Muk9f4yBSt+a9eQOfT1g4QE=
X-Google-Smtp-Source: APXvYqzXxSAp8FcoRus8rBWq2BRefZV1KK9aOaZYqG4EI9vBdzP7a7i6mMYXE52hVkfz01RafCtH+9Ot14DD
X-Received: by 2002:a63:c34c:: with SMTP id e12mr5936556pgd.195.1561676061576;
 Thu, 27 Jun 2019 15:54:21 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:54:04 -0700
In-Reply-To: <20190601003603.90794-1-matvore@google.com>
Message-Id: <cover.1561675151.git.matvore@google.com>
Mime-Version: 1.0
References: <20190601003603.90794-1-matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 00/10] Filter combination
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org, jonathantanmy@google.com, jrn@google.com,
        dstolee@microsoft.com, jeffhost@microsoft.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, emilyshaffer@google.com
Cc:     Matthew DeVore <matvore@google.com>, matvore@comcast.net,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This applies suggestions made by Jonathan Tan, as well as fixes a
Coccinelle-breaking error in strbuf usage, and makes an additional string
localizable.

Thanks,

Matthew DeVore (10):
  list-objects-filter: encapsulate filter components
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
 list-objects-filter-options.c       | 267 ++++++++++++++++++----
 list-objects-filter-options.h       |  57 ++++-
 list-objects-filter.c               | 335 +++++++++++++++++++++-------
 list-objects-filter.h               |  40 ++--
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
 22 files changed, 884 insertions(+), 239 deletions(-)

-- 
2.21.0


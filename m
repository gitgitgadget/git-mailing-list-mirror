Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13EC1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 18:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeIDWcQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 18:32:16 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:43926 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeIDWcP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 18:32:15 -0400
Received: by mail-yb1-f201.google.com with SMTP id n7-v6so1381408yba.10
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zVbVX3wZGZw/n1MCCeHvvBXPSVjAz//wDPZHTZmRyXM=;
        b=L94tAb7MqmhEvezYPIieIBNUi9cUqjdBoLN97ZDMwxxdzLK3t8NWjPyUdvrg43EKKd
         tau5B3+IPLSgDvUmUzAdLiFFubENxA9gnr5i2jVN+16PeCgc60Rxbr9dY4Vy7lYmliWZ
         xBwHu7hhwanoEcxo00tog42G5gV9UIA9Netvx4VCRLvcz02ZwoZVMa9lh9WCsMwXf+W9
         aUTb0i3SUxXBUC7UjXRLPq5mKPJNK7TnO9jpzdorAFmczuO/00HgbDk8WG+2ejrLvqIF
         aJR0EuJhgKvgSNov1x3FAajz4l3cOLyqNJTSl4X5L34BMK0moTlLoGjGWKQp49sCbjI+
         zgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zVbVX3wZGZw/n1MCCeHvvBXPSVjAz//wDPZHTZmRyXM=;
        b=OfpteK4vLdasJMUGSyTqjGyO9xxREyPCkMBtz5gfAu5WTGRJg5yV66S9lIZVlt47kH
         n0xw69EvCs+6bAcCBH7X/JWXyXhuNAV0P3oGAxQeR7LSWNI6QEwcD4NcEct9NZDEZ+ci
         c2s0JLv2MOjWKmqFa6p4qV/l9gi5+U5Kr+y3gLiEeRA+mmDeiQ7yMZxL8+n+OwR10wEv
         gLzwfhiyjOciDieB/oNzmwMx2CxcLq/SSVSGwm+wNZnNAHkfmjpXrLCuuV9nHvGi6A4g
         OCgUqnQb9/x0XuuirsRtdkYHq2z95u1ax6BqB5DxDYQcFc3SwUGp9CuP0+L3L+ZMVMcN
         v2Pw==
X-Gm-Message-State: APzg51DJxKkbyBb/XDhhENy12GAj5SN9d1ey+T5Yv087lQ8TIxmyf7qI
        Vh5w/esMnsuzuKqUijKu1ATGCJ7TUSw=
X-Google-Smtp-Source: ANB0VdZeU6KV/NUqnQchbSJgDJh3xhfz0JPkFVCVz2sL+jg7EojXS/VDAsg9FEi7xLJsTygzAIfbnQo4GzmD
X-Received: by 2002:a0d:c207:: with SMTP id e7-v6mr9126274ywd.154.1536084362259;
 Tue, 04 Sep 2018 11:06:02 -0700 (PDT)
Date:   Tue,  4 Sep 2018 11:05:43 -0700
In-Reply-To: <cover.1533854545.git.matvore@google.com>
Message-Id: <cover.1536081438.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
Subject: [PATCH v7 0/7] filter: support for excluding all trees and blobs
From:   Matthew DeVore <matvore@google.com>
To:     sbeller@google.com, git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I made the following changes since v6 of the patchset:
 - (suggested by Duy Nguyen) add a new commit which replaces uses of die() with
   BUG() in list-objects-filter.c wherever it corresponds to a coding error.
 - Replace die() with BUG() in new code.
 - Replace test_line_count = 0 with test_must_be_empty in new tests since the
   trend seems to be, based on other RFCs in progress, that we are standardizing
   on that phraseology. See:
   https://public-inbox.org/git/20180819215725.29001-1-szeder.dev@gmail.com/

As asked in the last "What's cooking in git.git" post, the status of this patch
is:
 - The original reviewer, Jonathan Tan, is on vacation and will be back later
   this week.
 - Stefan Beller has been reviewing the patchset in Jonathan's absence, and
   stated that it's a good read despite not being familiar with the code:
   https://public-inbox.org/git/CAGZ79kaWcGbyc2S5gOCU7NdvT4fN46jq4xK9MvTLAFBGhyuo2A@mail.gmail.com/
 - I haven't updated this patch in a while since we have been in RC for a while,
   but after this update I think it's ready. There hasn't been any comment or
   request for change to the patchset recently.

Matthew DeVore (7):
  list-objects: store common func args in struct
  list-objects: refactor to process_tree_contents
  list-objects: always parse trees gently
  rev-list: handle missing tree objects properly
  revision: mark non-user-given objects instead
  list-objects-filter: use BUG rather than die
  list-objects-filter: implement filter tree:0

 Documentation/rev-list-options.txt     |   5 +
 builtin/rev-list.c                     |  11 +-
 list-objects-filter-options.c          |   4 +
 list-objects-filter-options.h          |   1 +
 list-objects-filter.c                  |  60 ++++++-
 list-objects.c                         | 232 +++++++++++++------------
 revision.c                             |   1 -
 revision.h                             |  25 ++-
 t/t0410-partial-clone.sh               |  45 +++++
 t/t5317-pack-objects-filter-objects.sh |  41 +++++
 t/t5616-partial-clone.sh               |  38 ++++
 t/t6112-rev-list-filters-objects.sh    |  29 ++++
 12 files changed, 367 insertions(+), 125 deletions(-)

-- 
2.19.0.rc1.350.ge57e33dbd1-goog


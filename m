Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98EA31F403
	for <e@80x24.org>; Thu,  7 Jun 2018 19:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbeFGTEY (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 15:04:24 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37695 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbeFGTEX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 15:04:23 -0400
Received: by mail-pg0-f68.google.com with SMTP id r21-v6so4858497pgv.4
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x5nX/uyN0D0fmRctviSJP9FwSXwk8Z/o8X9pBHyq/9g=;
        b=e2YjjykGAQVdOgR0MoiCT1iQUlfxpJrcNKH1MuMqNQ9sxba4tYtIgIRojp9hLBNAG0
         h62hjxvCH8MVmsH3LErtLwPu8SkuXUB1l/fEb/7kNjwKG29lEYmD4OOmJZR/bRFngSlw
         s9WaW2GRW0iXzwDedEI/RXTkL9ovvMoXt93GtX5AkMngjoSYj2nmRjFNEojokKHS6kHf
         PtHt+q7DAl41YZO2z62Vk2TyrtNdTfsCx5FKvpXZUb++kjSJnGoDRZcYdKLSbS6Hb65H
         h6NvhVjIb4BoLe/DoKlu26cSkvtL16E6mtgsZDerBhvpZISMzzxGkKVS5x8bkJ3MKpYe
         TDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x5nX/uyN0D0fmRctviSJP9FwSXwk8Z/o8X9pBHyq/9g=;
        b=AwSk9vsh+ey1aQw52wAEhbi/U6pmf00a/HxrjvNAfnAxxFoGZZfcC2dXcsuegASiqh
         xZwY7h7+09pUxWSbgzUQZcIkvbqKJIEWCnvVei3Cz1kGwFhX5TUSh8KoA0ng6vrxh47/
         1YiKG1AlNS8VzxA4gQ+tm9bt/LZ2IMpurQ7aiJlWNuSaNUSsb9n48ATAuyRUk+48ePwH
         ElkSMJK+EHiFyuv+HyTxZvWB29x1+r0eEXgKTQwpmX3en8BlaW9sQCuHZ2F1penHl+Q2
         RVXPbEDE0YlI9hqwFaK6VcQ4ftlg1PVMB95bTQoPHoHoEFjfMMXRM9yxtLjXOj9OYXiv
         Oipw==
X-Gm-Message-State: APt69E3LXdhPu6z8uyX7M38U4/N69GgjyIPqy5Xe2TjahGsMRONTSg/k
        z/ZkFsg4ospwirnh4h21TrJTmPfDuy0=
X-Google-Smtp-Source: ADUXVKIPTRs9X7NCUO3ZYQTDXBT+UTcqd4p1AUE/4RK0aaHE/LR2x58sRsBuSKie5zJ6x7oW+o3NjQ==
X-Received: by 2002:a65:47c8:: with SMTP id f8-v6mr2560790pgs.430.1528398262172;
        Thu, 07 Jun 2018 12:04:22 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x2-v6sm16324624pfn.11.2018.06.07.12.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 12:04:20 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [PATCH 0/2] Object store refactoring: make bitmap_git not global
Date:   Thu,  7 Jun 2018 12:04:12 -0700
Message-Id: <cover.1528397984.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a continuation of the object store refactoring effort.

We cannot truly free an object store without ensuring that any generated
bitmaps are first freed, so here are patches to drastically reduce the
lifetime of any bitmaps generated. As a bonus, the API is also improved,
and global state reduced.

Jonathan Tan (2):
  pack-bitmap: remove bitmap_git global variable
  pack-bitmap: add free function

 builtin/pack-objects.c |   7 +-
 builtin/rev-list.c     |  13 +-
 pack-bitmap-write.c    |  10 +-
 pack-bitmap.c          | 344 ++++++++++++++++++++++++-----------------
 pack-bitmap.h          |  20 ++-
 5 files changed, 234 insertions(+), 160 deletions(-)

-- 
2.17.0.768.g1526ddbba1.dirty


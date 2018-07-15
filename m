Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 165D21F597
	for <e@80x24.org>; Sun, 15 Jul 2018 21:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbeGOWVD (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jul 2018 18:21:03 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44993 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbeGOWVD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jul 2018 18:21:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id k21-v6so421074pff.11
        for <git@vger.kernel.org>; Sun, 15 Jul 2018 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AylKGebYqSwZDy0d5/htmYSHpEIpFUVtkA5bOjDOM/Y=;
        b=gYxzHIlLeHh3AwrKLZdEkpLlsqFBtXL5hHRcMvQbMP5svv5jG3KvXjiIFZMRjEyXxb
         GmFllG7t68nYjrybhRuGjDD0mu6hLyO4qFsOE7GAJDlOX1orevuuDLPnV/ACvOgOACAI
         3zfxFaThnkkaCiiaQTV1goE0qpNDCRZJuL7i7WuK9B2eoLKbBsJwV7iWshC1lvJrxDpj
         nw6JznVWS2w7EDW6W5gKYxbdCBiMUEbr3G8xvCqwVIl5tTIUUuAnupdyLpfjx47nmNE2
         JdYVm3SVIMjHiM7WxA4nwuZL+uaaclGQI8XDwRrmp7cUNw6r6M/WNDnDAeeUcLTUg0r2
         /mfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AylKGebYqSwZDy0d5/htmYSHpEIpFUVtkA5bOjDOM/Y=;
        b=gagb3a8Sfyi0+4ct8mQZXAIgcSbgEvkKNirTAgXeQgh0H1yPxQ4Rzvcsr7KxiysMxU
         BNdShWka4cJOZwRQJzntOp3kq9x3sDsC3MiIBnfJrPuyJeaZP114Ad3DGSofFk6wKJAz
         Xw23Vrz5zPyrztDKXtvn6o+Rgnpk6tgRrwK/oGphCWx33sE4+Q/2NyrQ0ASXGa2Wx5gK
         LcBhQFvSy1nuTwLs4UEVhk5lLoeeP/cUbOezY1fJy9nAWxS9tJY9+cH0bvl7N0AdUADq
         v/RKCUR57eBLHXJznS9W/tiY+0Ctd04klE4qKbJKBM/aqO4WPSXAA93qVniYuGr5lzaj
         cu7A==
X-Gm-Message-State: AOUpUlE/cylU04sn+O06ewS4rQOvgN5MUGyGYsqk3RGrntr+4+nCI9XK
        UasnZlOaGb5UokW7JQsq+IuxXKSD
X-Google-Smtp-Source: AAOMgpf3a4RrbM41P4h44bpI6FRZNf3ZLgnff4QiO+tG3BY/R+hwL3WgAwLX7QFB5c4mdtHqgPM6wA==
X-Received: by 2002:a63:6949:: with SMTP id e70-v6mr13783957pgc.119.1531691802919;
        Sun, 15 Jul 2018 14:56:42 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-236-28-204.dsl.chi2ca.sbcglobal.net. [76.236.28.204])
        by smtp.gmail.com with ESMTPSA id e82-v6sm81924819pfk.87.2018.07.15.14.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 14:56:41 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3 0/3] Fix --short/--porcelain options for git commit
Date:   Sun, 15 Jul 2018 07:08:04 -0400
Message-Id: <20180715110807.25544-1-sxlijin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180426092524.25264-1-sxlijin@gmail.com>
References: <20180426092524.25264-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take 3. Addressed the issue that Junio turned up the last time I sent
this out for review.

I'm not entirely sure I like the way I added the tests in the first
patch, but it's unclear to me if there's actually a pattern for setting
up and tearing down the same env for multiple test methods. There are
also other tests in t7501 that rely on state left from earlier tests, so
it's not really clear to me what the best thing to do here is.

Also added a FIXME in the second patch for something I think should be
fixed, but doesn't make sense to fix in this patch series.

Samuel Lijin (3):
  t7501: add merge conflict tests for dry run
  wt-status: teach wt_status_collect about merges in progress
  commit: fix exit code for --short/--porcelain

 builtin/commit.c  |  32 +++---
 ref-filter.c      |   3 +-
 t/t7501-commit.sh |  49 +++++++--
 wt-status.c       | 260 +++++++++++++++++++++++++---------------------
 wt-status.h       |  13 +--
 5 files changed, 208 insertions(+), 149 deletions(-)

-- 
2.18.0


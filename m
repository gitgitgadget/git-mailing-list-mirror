Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CAA51F453
	for <e@80x24.org>; Thu,  4 Oct 2018 10:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJDRA2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 13:00:28 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:60722 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeJDRA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 13:00:28 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 80XsgfYebVlGZ80XxgOCEP; Thu, 04 Oct 2018 11:07:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538647674;
        bh=gv6IzF3nRe9YPK5G/s5WnYzvTZO94dCd1z5rKioqwwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=c1mjB0Cs3w977cchf0HZPFCrbV99YgmtaC0+FF1aBzWY/A7KsnZFS6CJTCjFV+S//
         LvVWortPX3oX6ia6vGW7Nd0Dq5clvM5/avN5U5DXeohuTu8aHsLVl3AAJPSZuN9bN5
         O4Y9FVY+iOvJwPzsaynknYlGPbMZq+7Wcz3+3wHM=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=N9X_xAMF68vFOtRwJXEA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/5] diff --color-moved-ws: fix double free crash
Date:   Thu,  4 Oct 2018 11:07:40 +0100
Message-Id: <20181004100745.4568-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002175514.31495-1-phillip.wood@talktalk.net>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPqwW+LmMa8sfZCWIHWBqzhHeI2/kqXmXQPG5vZbA6sZlnjA8huXVzWhWXT9Gk0bvqLLyD0+Z62/B6x85W+7EUKmbiW5w2VP/o0ssa8qMyD0tOHrl6EN
 /scxZ7+WflrUL+McxYPFFrRvquAuxcVSDFw/a1yA1a102P6KdjOuzPOZS8epkwXnaKTdB8JjFwEe99hwbmGh+GoQ32Y/MNwvQ9N7v9X5h4GWyektP6HK14AG
 Pdc1PLwSagIsn/iQGlp+xa95pQkpGnHKASvfpKwgiVb6NCVqXiRNmXhQIMHHObkIFa30Wi1W8xcq/e0OynjNkg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to Stefan and Martin for their comments on v1. This version has
some small changes to patches 1-3 based on that feedback - see the
individual patches for what has changed.

Phillip Wood (5):
  diff --color-moved-ws: fix double free crash
  diff --color-moved-ws: fix out of bounds string access
  diff --color-moved-ws: fix a memory leak
  diff --color-moved-ws: fix another memory leak
  diff --color-moved: fix a memory leak

 diff.c | 95 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 41 deletions(-)

-- 
2.19.0


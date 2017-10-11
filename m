Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBBF91FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 13:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbdJKNfV (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 09:35:21 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38506 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbdJKNfT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 09:35:19 -0400
Received: by mail-qt0-f195.google.com with SMTP id k31so2419525qta.5
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BgfIL9IBy7lxBz+H0I3O6+w0oRnghAdTBictMqokWi0=;
        b=uSzP0yjtUartPSBU+ew1TBdBmmwOiVT79B5NMdwGh8TDFQXAR+mbvtCT92SBWGiM7i
         WbgsMqoTn7mEyTNvgh0R7Pdy/GNAkkcxve4LjOL7+Chk3SMP2+m2o3qHI9xoRFovgrg3
         cU2TVVIVSJ6xVd7q1zZPG6EqhDBQ31sPz1wxWwd1P45WsIOPk5OTd7VG0jHEY8BOomJi
         xiSFN/5I3r6moRR5zrArx5J1rUfIMLsSCLtl2/xPOujGA/tWxqk6E8MGPxQiUUm5bbyQ
         RM/xWpKtAPLn3pnAQ3PxCS+N/SDqcZcjU0/MexOGGQZXJo8fDTq4mIno4V9hFDifvXHQ
         byVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BgfIL9IBy7lxBz+H0I3O6+w0oRnghAdTBictMqokWi0=;
        b=S0TJpw1/T3cRbA4W8f5qPkfN8UHsTgjxaQc0W3+Qtk0LX6+GbK7yeh4M43xbBnsQNd
         /PPzE50RSk05veK1A5IrbkyzTc2/cFV3q29cnn7A8QJ+10VwrkG3yThIwpAMM2HY+e48
         e1r3mtUGC9S+NX0jo3R7QprIWqyh6VChxaIC+sKw7yV35esJLuHghpcLoOPe/LiLt2sU
         ZEblG85OF35ChlBz7RaZ7U+y1KFgGlPKATwUEytv0AGT0kOxMLkyCfLfB/90JJcDDmoV
         bKyxy3vmy5EpMTUnonsU4e2Qf9Qic3ggDN99mI/AQuiQDGxzQQinC2jrxO8eQhcgZLzE
         LRzw==
X-Gm-Message-State: AMCzsaXl172Z3sVNKJ62eOtqM7v/LL0EXrTiIsEyUvO8dGQzgsE6tCT1
        2TnBBbHCGKR5me46aUNph9g=
X-Google-Smtp-Source: AOwi7QBL4vww0xDKnqSGXMpC8I2Tcp4IqD6iPVGz+exVy8+sWwdMe/HkGVfrdt7++4T62xvXY0ydtw==
X-Received: by 10.55.17.33 with SMTP id b33mr19133882qkh.58.1507728919219;
        Wed, 11 Oct 2017 06:35:19 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id i1sm8192685qta.19.2017.10.11.06.35.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Oct 2017 06:35:18 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v2 0/5] Teach Status options around showing ignored files
Date:   Wed, 11 Oct 2017 09:34:59 -0400
Message-Id: <20171011133504.15049-1-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171005205443.206900-1-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:

Addressed review comments from the original series:

* Made fixes / simplifications suggested for documentation

* Removed test_tick from test scripts

* Merged 2 commits (as suggested)

Jameson Miller (5):
  Teach status options around showing ignored files
  Update documentation for new directory and status logic
  Add tests for git status `--ignored=matching`
  Expand support for ignored arguments on status
  Add tests around status handling of ignored arguments

 Documentation/git-status.txt                      |  21 ++-
 Documentation/technical/api-directory-listing.txt |  27 +++-
 builtin/commit.c                                  |  31 +++-
 dir.c                                             |  44 +++++-
 dir.h                                             |   3 +-
 t/t7519-ignored-mode.sh                           | 183 ++++++++++++++++++++++
 wt-status.c                                       |  11 +-
 wt-status.h                                       |   8 +-
 8 files changed, 310 insertions(+), 18 deletions(-)
 create mode 100755 t/t7519-ignored-mode.sh

-- 
2.13.6


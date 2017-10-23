Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6458C202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 17:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbdJWRFx (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 13:05:53 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:52628 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbdJWRFw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 13:05:52 -0400
Received: by mail-qk0-f193.google.com with SMTP id b15so22846128qkg.9
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 10:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=93t8kqVqxrnpGty/N1YAthIJ+XXMZLimkiBh27qgp8Y=;
        b=u7Sk1Ib2mmmE7CpG1KK4hlJW1srjqvmwmcYDmMqbvDC6Vn3zo7lyQow4t51yr+BoJp
         h1f7wvTxfMxU6QYJnWXFuhqVi7y2oLBVEAGipXia0Z+LPViyRy3DJT44i/H+83BEQv8c
         5TTbzD//vDK8NcC6iFWRpjIf+mGn0VQsNsu1DQNBez9ku24evl7rko+VssjYpqj80Ndq
         UEsKr8JpgoejCLDbTXcjnDfLc67UbvHGNnkNvV2+2X6NIsi8PiVeGq4jVRZhKpwaO4QT
         F0udG4wMtykSALuwvXPjidP9veilP30jRbUwctZTaJfsPB9o1QmyumXoLs6kba/oUNQW
         NlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=93t8kqVqxrnpGty/N1YAthIJ+XXMZLimkiBh27qgp8Y=;
        b=o12uFEUvgxpwxprihI7bhzxSJQP6YzcJBfDavEZNOYdV29nu+rCWmfMlq1paGqP1bS
         SgMO4VHg1hCgj8QmSDNBzUSYOz4OKAY64rFVIzdnad0NPlVyXSFWkh8cC4bILg43Fdyh
         xeV587zh1PTAYDH66uy8GzNgjwfIlUESBArUoK4EZc8lX4MpIJUCruyAYNeWB+iC4h5B
         oyTADUozIeCh3tNkgdNFSuxFeIbzNGkvc53dOZw8W9S8/1fzdzsMbIaGM6isbb/NDHvj
         IRvA7Y5mecYE70UX0D0WJmXcy6QyVne1Q5xjBmF8fl9cqfsiHGeAB+gOL6ePrhcw6LJC
         A4Rg==
X-Gm-Message-State: AMCzsaV+mN+dZStfoF6O7+H+mrnkKT4jLSKr47A+MW6u4uoXeo8D0VAp
        TAEbq3+dH2RbzpwkRr6JFBo=
X-Google-Smtp-Source: ABhQp+Rh8YjEnt+WokdSWcK3dmTImdCyRU1n5FGSx5rpfgP5ZHAmwxzhnDu+soNQugeOc9RTjWgxgA==
X-Received: by 10.55.99.148 with SMTP id x142mr19242628qkb.212.1508778351910;
        Mon, 23 Oct 2017 10:05:51 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id p64sm4885397qkd.67.2017.10.23.10.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 10:05:51 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v4 0/4] status: add option to show ignored files differently
Date:   Mon, 23 Oct 2017 13:05:30 -0400
Message-Id: <20171023170534.157740-1-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171005205443.206900-1-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous iteration can be found here:

https://public-inbox.org/git/20171019160601.9382-1-jamill@microsoft.com/


Changes from V3 patch series:
 - Added extra test for --ignored=no an --ignored=traditional
 - Updated wording from "folders" -> "directories"
 - Renamed test to a name not taken in by topics in flight

Jameson Miller (4):
  status: add option to show ignored files differently
  status: report matching ignored and normal untracked
  status: document options to show matching ignored files
  status: test ignored modes

 Documentation/git-status.txt                      |  21 +-
 Documentation/technical/api-directory-listing.txt |  27 ++-
 builtin/commit.c                                  |  31 ++-
 dir.c                                             |  44 +++-
 dir.h                                             |   3 +-
 t/t7521-ignored-mode.sh                           | 233 ++++++++++++++++++++++
 wt-status.c                                       |  11 +-
 wt-status.h                                       |   8 +-
 8 files changed, 360 insertions(+), 18 deletions(-)
 create mode 100755 t/t7521-ignored-mode.sh

-- 
2.13.6


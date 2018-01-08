Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6051FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 15:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeAHPsb (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 10:48:31 -0500
Received: from siwi.pair.com ([209.68.5.199]:59055 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933979AbeAHPsb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 10:48:31 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8B511844D1;
        Mon,  8 Jan 2018 10:48:30 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 116B9844CB;
        Mon,  8 Jan 2018 10:48:29 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 0/4] Add --no-ahead-behind to status
Date:   Mon,  8 Jan 2018 15:48:18 +0000
Message-Id: <20180108154822.54829-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is version 4 of my patch series to avoid expensive ahead/behind
calculations in status.  This version removes the last commit containing
the experimental config setting.  And removes the undefined return values
for the nr_ahead/nr_behind arguments as discussed on the mailing list.

This version does not address "git branch -vv", but that requires
passing data across the for-each-ref barrier and that seemed beyond
the scope of this task.

Jeff Hostetler (4):
  stat_tracking_info: return +1 when branches not equal
  status: add --[no-]ahead-behind to status and commit for V2 format.
  status: update short status to respect --no-ahead-behind
  status: support --no-ahead-behind in long format

 Documentation/config.txt     |  6 ++++
 Documentation/git-status.txt |  5 +++
 builtin/checkout.c           |  2 +-
 builtin/commit.c             | 18 ++++++++++-
 ref-filter.c                 |  8 ++---
 remote.c                     | 50 ++++++++++++++++++++----------
 remote.h                     | 12 ++++++--
 t/t6040-tracking-info.sh     | 73 ++++++++++++++++++++++++++++++++++++++++++++
 t/t7064-wtstatus-pv2.sh      | 69 +++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 41 +++++++++++++++++--------
 wt-status.h                  |  2 ++
 11 files changed, 250 insertions(+), 36 deletions(-)

-- 
2.9.3


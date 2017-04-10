Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6103D20960
	for <e@80x24.org>; Mon, 10 Apr 2017 21:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752873AbdDJVOS (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 17:14:18 -0400
Received: from siwi.pair.com ([209.68.5.199]:13405 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752822AbdDJVOR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 17:14:17 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 84DB984565;
        Mon, 10 Apr 2017 17:14:11 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v8 0/3] read-cache: speed up add_index_entry
Date:   Mon, 10 Apr 2017 21:14:00 +0000
Message-Id: <20170410211403.25126-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 8 addresses the following:
  () Refactors strcmp_offset() test helper to just compare the
     values and return results to stdout.
  () Updates t0065 to have the actual test logic.
  () Splits the synthetic test repo generation out of the perf
     test into a stand-alone script.
  () Simplifies the p0006 (was p0004) perf test to use an
     existing repository (whether artificial or real).
  () Adds additional tests for add/delete (which should be
     driven by the arg-list rather than an iteration on the
     index.
  () Updated the read-cache commit message with new perf data.

Jeff Hostetler (3):
  read-cache: add strcmp_offset function
  p0006-read-tree-checkout: perf test to time read-tree
  read-cache: speed up add_index_entry during checkout

 Makefile                           |   1 +
 cache.h                            |   1 +
 read-cache.c                       |  66 ++++++++++++++++++++-
 t/helper/.gitignore                |   1 +
 t/helper/test-strcmp-offset.c      |  22 +++++++
 t/perf/p0006-read-tree-checkout.sh |  90 ++++++++++++++++++++++++++++
 t/perf/repos/.gitignore            |   1 +
 t/perf/repos/many-files.sh         | 118 +++++++++++++++++++++++++++++++++++++
 t/t0065-strcmp-offset.sh           |  21 +++++++
 9 files changed, 319 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-strcmp-offset.c
 create mode 100755 t/perf/p0006-read-tree-checkout.sh
 create mode 100644 t/perf/repos/.gitignore
 create mode 100755 t/perf/repos/many-files.sh
 create mode 100755 t/t0065-strcmp-offset.sh

-- 
2.9.3


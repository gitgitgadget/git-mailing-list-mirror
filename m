Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAFA1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 17:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967747AbdDSRGi (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 13:06:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:15205 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967438AbdDSRGc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 13:06:32 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4DEFC844FA;
        Wed, 19 Apr 2017 13:06:30 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v12 0/5] read-cache: speed up add_index_entry
Date:   Wed, 19 Apr 2017 17:06:13 +0000
Message-Id: <20170419170618.16535-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 12 adds a new t/perf/repo/inflate-repo.sh script to let you
inflate a test repo, such as a copy of git.git or linux.git, to have
a branch containing a very large number of (non-synthetic) files.

It also fixes the "##" comments in the many-files.sh script
as mentioned on the mailing list.

I've also updated the commit message on part 2 to show the
results when run on an inflated copy of linux.git with 1M+ files.

Jeff Hostetler (5):
  read-cache: add strcmp_offset function
  p0006-read-tree-checkout: perf test to time read-tree
  read-cache: speed up add_index_entry during checkout
  read-cache: speed up has_dir_name (part 1)
  read-cache: speed up has_dir_name (part 2)

 Makefile                           |   1 +
 cache.h                            |   1 +
 read-cache.c                       | 139 ++++++++++++++++++++++++++++++++++++-
 t/helper/.gitignore                |   1 +
 t/helper/test-strcmp-offset.c      |  22 ++++++
 t/perf/p0006-read-tree-checkout.sh |  67 ++++++++++++++++++
 t/perf/repos/.gitignore            |   1 +
 t/perf/repos/inflate-repo.sh       |  86 +++++++++++++++++++++++
 t/perf/repos/many-files.sh         | 110 +++++++++++++++++++++++++++++
 t/t0065-strcmp-offset.sh           |  21 ++++++
 10 files changed, 447 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-strcmp-offset.c
 create mode 100755 t/perf/p0006-read-tree-checkout.sh
 create mode 100644 t/perf/repos/.gitignore
 create mode 100755 t/perf/repos/inflate-repo.sh
 create mode 100755 t/perf/repos/many-files.sh
 create mode 100755 t/t0065-strcmp-offset.sh

-- 
2.9.3


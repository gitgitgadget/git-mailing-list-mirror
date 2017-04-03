Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498CC1FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 15:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbdDCPQ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 11:16:59 -0400
Received: from siwi.pair.com ([209.68.5.199]:44048 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752749AbdDCPQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 11:16:57 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 43177845D0;
        Mon,  3 Apr 2017 11:16:56 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ramsay@ramsayjones.plus.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 0/2] name-hash: fix buffer overrun
Date:   Mon,  3 Apr 2017 15:16:40 +0000
Message-Id: <20170403151642.2889-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 2 of this fix smashes the HT and chmod issues in the
test code discussed on the mailing list.  The test has also
been updated to skip on 1 cpu systems.

================
Fix buffer overrun in handle_range_dir() when the final entry
in the index was the only file in the last directory, such as
"a/b/foo.txt". The look ahead (k_start + 1) was invalid since
(k_start + 1) == k_end.

Jeff Hostetler (1):
  test-online-cpus: helper to return cpu count

Kevin Willford (1):
  name-hash: fix buffer overrun

 Makefile                                |  1 +
 name-hash.c                             |  4 +++-
 t/helper/.gitignore                     |  1 +
 t/helper/test-online-cpus.c             |  8 ++++++++
 t/t3008-ls-files-lazy-init-name-hash.sh | 27 +++++++++++++++++++++++++++
 5 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 t/helper/test-online-cpus.c
 create mode 100755 t/t3008-ls-files-lazy-init-name-hash.sh

-- 
2.9.3


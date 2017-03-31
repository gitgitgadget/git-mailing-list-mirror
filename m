Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927591FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 17:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933359AbdCaRcs (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 13:32:48 -0400
Received: from siwi.pair.com ([209.68.5.199]:36851 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933340AbdCaRcp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 13:32:45 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 949E5845D2;
        Fri, 31 Mar 2017 13:32:38 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, kewill@microsoft.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH] name-hash: fix buffer overrun
Date:   Fri, 31 Mar 2017 17:32:13 +0000
Message-Id: <20170331173214.47514-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Fix buffer overrun in handle_range_dir() when the final entry
in the index was the only file in the last directory, such as
"a/b/foo.txt". The look ahead (k_start + 1) was invalid since
(k_start + 1) == k_end.

This bug was introduced by Jeff in "jh/memihash-opt" which was
recently merged into master.

Kevin Willford (1):
  name-hash: fix buffer overrun

 name-hash.c                             |  4 +++-
 t/t3008-ls-files-lazy-init-name-hash.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 t/t3008-ls-files-lazy-init-name-hash.sh

-- 
2.9.3


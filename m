Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8834F2096C
	for <e@80x24.org>; Mon,  3 Apr 2017 18:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbdDCSxa (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 14:53:30 -0400
Received: from siwi.pair.com ([209.68.5.199]:36716 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbdDCSx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 14:53:29 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 405E484645;
        Mon,  3 Apr 2017 14:53:23 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v4 0/4] read-cache: call verify_hdr() in a background thread
Date:   Mon,  3 Apr 2017 18:53:02 +0000
Message-Id: <20170403185306.36164-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 4 of this patch series incorporates the cleanup made by Junio
to my 3rd veresion, updates fsck to always verify the checksum, and a
new simplified perf test using p0002 as discussed on the mailing list.

================
Version 3 of this patch series simplifies this effort to just turn
on/off the hash verification using a "core.checksumindex" config variable.

I've preserved the original checksum validation code so that we can
force it on in fsck if desired.

It eliminates the original threading model completely.

Jeff Hostetler (4):
  read-cache: core.checksumindex
  fsck: force core.checksumindex=1
  t1450-fsck: test core.checksumindex
  p0002-read-cache: test core.checksumindex

 Documentation/config.txt   |  8 ++++++++
 builtin/fsck.c             |  1 +
 cache.h                    |  7 +++++++
 read-cache.c               | 18 ++++++++++++++++++
 t/perf/p0002-read-cache.sh |  8 +++++++-
 t/t1450-fsck.sh            | 27 +++++++++++++++++++++++++++
 6 files changed, 68 insertions(+), 1 deletion(-)

-- 
2.9.3


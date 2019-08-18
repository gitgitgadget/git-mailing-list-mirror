Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE0E1F461
	for <e@80x24.org>; Sun, 18 Aug 2019 19:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfHRTUp (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 15:20:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57738 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbfHRTUp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 15:20:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3EB976047B;
        Sun, 18 Aug 2019 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566156038;
        bh=m99XL7VEErWtPYAQ2qUC8/0KJhl1bX/KsH+dF6dgGqs=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=JfWCGwgBoD2VdDpiR2g4jc2D2UX9PVnojT9vueECFAZzzzlyizaN09Mijhd0rplRj
         h9Io5RMKGgIm6KlgQ2kfV2sft1ut7Ssh13EkPkHN0th+oLCmmQ56KkCFOgSnepZPve
         nsCC+ATq4+JyQZPcwS4wS/dC9DlGrO3qSJ3p6IV/+4M8MW/T0IlmlNA5o2ciTyqEhw
         envBVx5+kYcR/qQXxgGldrVW7c0hMN5H1P2m8SB8foC+67uU1IOccfMyh0WGCrZNNk
         fD3IYaSOeB39T6WTgo4GgHZucvV6HYdgAmZrZOC36DfYUFjqZER9MV5Biz2i/p+K/X
         xVD2+wk14r29e22nnCVGqKCMr88K2v8UNnzRMK489xx3SbNHlqvlC7ISPFMLhHwzQX
         +A4tt8nzq4I5C1L6005KxOreYjR6EZzoqr1fPi/Vq796qZA/uZ32CIxRABIgdSaQxC
         OPNjpM/AY0HhsBSAGKrm6rDnqVH26Y1aqcgiCqCcPWb1ZcI7iFb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 00/14] Hash-independent tests, part 5
Date:   Sun, 18 Aug 2019 19:16:32 +0000
Message-Id: <20190818191646.868106-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the fifth series of test fixes for SHA-256 compatibility.  It
consists of 15 patches fixing various tests from t3201 through t4009 and
has only test fixes: no test helper changes are included.

There are approximately 75 remaining test patches (plus some additional
code changes) required for the test suite to pass successfully with
SHA-256, which does not include the patches required to replace SHA-1
near-collisions in tests with actual SHA-256 near-collisions.

brian m. carlson (14):
  t3201: abstract away SHA-1-specific constants
  t3206: abstract away hash size constants
  t3301: abstract away SHA-1-specific constants
  t3305: make hash size independent
  t3306: abstract away SHA-1-specific constants
  t3404: abstract away SHA-1-specific constants
  t3430: avoid hard-coded object IDs
  t3506: make hash independent
  t3600: make hash size independent
  t3800: make hash-size independent
  t3903: abstract away SHA-1-specific constants
  t4000: make hash size independent
  t4002: make hash independent
  t4009: make hash size independent

 t/t3201-branch-contains.sh    |   8 +-
 t/t3206-range-diff.sh         | 227 +++++++++++++++------
 t/t3301-notes.sh              | 140 ++++++++-----
 t/t3305-notes-fanout.sh       |  22 +-
 t/t3306-notes-prune.sh        |  45 ++---
 t/t3404-rebase-interactive.sh |  22 +-
 t/t3430-rebase-merges.sh      |  23 ++-
 t/t3506-cherry-pick-ff.sh     |   8 +-
 t/t3600-rm.sh                 |   4 +-
 t/t3800-mktag.sh              |  49 ++---
 t/t3903-stash.sh              |  32 ++-
 t/t4000-diff-format.sh        |   2 +-
 t/t4002-diff-basic.sh         | 367 ++++++++++++++++++++++++----------
 t/t4009-diff-rename-4.sh      |  19 +-
 14 files changed, 640 insertions(+), 328 deletions(-)


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602B4C83F01
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 22:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbjH3Wgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 18:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243562AbjH3Wgw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 18:36:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E0A12F
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 15:36:28 -0700 (PDT)
Received: (qmail 19546 invoked by uid 109); 30 Aug 2023 19:49:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Aug 2023 19:49:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29718 invoked by uid 111); 30 Aug 2023 19:49:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Aug 2023 15:49:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Aug 2023 15:49:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] replacing ci/config/allow-ref with a repo variable
Message-ID: <20230830194919.GA1709446@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a more efficient way to do the same thing that
ci/config/allow-ref does (which didn't exist back then).

We should be able to do the same with ci/config/skip-concurrent (and
just use vars.CI_SKIP_CONCURRENT) throughout the workflow. But I didn't
test that at all.

After that, the only useful thing left in the "config" job would be the
"skip-if-redundant" step. I'm not sure if it will be possible to get the
same behavior there without spinning up a VM.

  [1/2]: ci: allow branch selection through "vars"
  [2/2]: ci: deprecate ci/config/allow-ref script

 .github/workflows/main.yml | 10 +++++++---
 ci/config/README           | 14 ++++++++++++++
 ci/config/allow-ref.sample | 27 ---------------------------
 3 files changed, 21 insertions(+), 30 deletions(-)
 create mode 100644 ci/config/README
 delete mode 100755 ci/config/allow-ref.sample


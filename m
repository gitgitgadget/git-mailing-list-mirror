Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C78C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217FE60E94
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhJEUbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:31:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:33346 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235715AbhJEUbb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 16:31:31 -0400
Received: (qmail 17622 invoked by uid 109); 5 Oct 2021 20:29:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Oct 2021 20:29:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6414 invoked by uid 111); 5 Oct 2021 20:29:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Oct 2021 16:29:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Oct 2021 16:29:39 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] cat-file replace handling and optimization
Message-ID: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started as an optimization to have cat-file use the pack/offset
info it gets during --batch-all-objects to avoid extra object lookups.
And that does happen in the final patch.

But there was an interesting interaction with replace refs there, which
led me to patch 3.

The other patches are relevant prep/cleanup.

  [1/5]: t1006: clean up broken objects
  [2/5]: cat-file: mention --unordered along with --batch-all-objects
  [3/5]: cat-file: disable refs/replace with --batch-all-objects
  [4/5]: cat-file: split ordered/unordered batch-all-objects callbacks
  [5/5]: cat-file: use packed_object_info() for --batch-all-objects

 Documentation/git-cat-file.txt |  6 ++-
 builtin/cat-file.c             | 49 +++++++++++++++-------
 t/t1006-cat-file.sh            | 75 ++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 16 deletions(-)

-Peff

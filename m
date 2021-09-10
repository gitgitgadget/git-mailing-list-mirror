Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E84C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086F56108B
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhIJOLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:11:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:43890 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233702AbhIJOLb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:11:31 -0400
Received: (qmail 5818 invoked by uid 109); 10 Sep 2021 14:10:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 14:10:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25385 invoked by uid 111); 10 Sep 2021 14:10:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 10:10:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 10:10:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH 5/5] docs/protocol-v2: point readers transport config
 discussion
Message-ID: <YTtnS/pdwH2yVJJ3@coredump.intra.peff.net>
References: <YTtleYs48A1NpUpp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTtleYs48A1NpUpp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We recently added tips for server admins to configure various transports
to support v2's GIT_PROTOCOL variable. While the protocol-v2 document is
pretty technical and not of interest to most admins, it may be a
starting point for them to figure out how to turn on v2. Let's put some
pointers from there to the other documentation.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/protocol-v2.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 1040d85319..a703d37e08 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -42,7 +42,8 @@ Initial Client Request
 In general a client can request to speak protocol v2 by sending
 `version=2` through the respective side-channel for the transport being
 used which inevitably sets `GIT_PROTOCOL`.  More information can be
-found in `pack-protocol.txt` and `http-protocol.txt`.  In all cases the
+found in `pack-protocol.txt` and `http-protocol.txt`, as well as the
+`GIT_PROTOCOL` definition in `git.txt`. In all cases the
 response from the server is the capability advertisement.
 
 Git Transport
@@ -58,6 +59,8 @@ SSH and File Transport
 
 When using either the ssh:// or file:// transport, the GIT_PROTOCOL
 environment variable must be set explicitly to include "version=2".
+The server may need to be configured to allow this environment variable
+to pass.
 
 HTTP Transport
 ~~~~~~~~~~~~~~
@@ -81,6 +84,9 @@ A v2 server would reply:
 Subsequent requests are then made directly to the service
 `$GIT_URL/git-upload-pack`. (This works the same for git-receive-pack).
 
+The server may need to be configured to pass this header's contents via
+the `GIT_PROTOCOL` variable. See the discussion in `git-http-backend.txt`.
+
 Capability Advertisement
 ------------------------
 
-- 
2.33.0.731.g24eb83922d

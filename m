Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA35C433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF6F61490
	for <git@archiver.kernel.org>; Sat,  1 May 2021 14:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhEAOOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 10:14:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:42058 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhEAOOS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 10:14:18 -0400
Received: (qmail 26443 invoked by uid 109); 1 May 2021 14:13:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 May 2021 14:13:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10251 invoked by uid 111); 1 May 2021 14:13:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 May 2021 10:13:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 May 2021 10:13:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH v2] docs/format-patch: mention handling of merges
Message-ID: <YI1iBGGW6ySxNDRH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Format-patch doesn't have a way to format merges in a way that can be
applied by git-am (or any other tool), and so it just omits them.
However, this may be a surprising implication for users who are not well
versed in how the tool works. Let's add a note to the documentation
making this more clear.

Signed-off-by: Jeff King <peff@peff.net>
---
This is a re-work of the patch from:

  https://lore.kernel.org/git/YDQ5YIeXGiR5nvLH@coredump.intra.peff.net/

taking into account Junio's suggestion (and also rebased on top of
28e29ee38b, which touches the same intro paragraph).

 Documentation/git-format-patch.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 911da181a1..fe2f69d36e 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -36,7 +36,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Prepare each commit with its "patch" in
+Prepare each non-merge commit with its "patch" in
 one "message" per commit, formatted to resemble a UNIX mailbox.
 The output of this command is convenient for e-mail submission or
 for use with 'git am'.
@@ -740,6 +740,14 @@ use it only when you know the recipient uses Git to apply your patch.
 $ git format-patch -3
 ------------
 
+CAVEATS
+-------
+
+Note that `format-patch` will omit merge commits from the output, even
+if they are part of the requested range. A simple "patch" does not
+include enough information for the receiving end to reproduce the same
+merge commit.
+
 SEE ALSO
 --------
 linkgit:git-am[1], linkgit:git-send-email[1]
-- 
2.31.1.875.g5dccece0aa

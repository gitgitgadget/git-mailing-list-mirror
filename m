Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F4FC46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 22:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjIRWcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 18:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjIRWcM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 18:32:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3A38F
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 15:32:07 -0700 (PDT)
Received: (qmail 13045 invoked by uid 109); 18 Sep 2023 22:32:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Sep 2023 22:32:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4723 invoked by uid 111); 18 Sep 2023 22:32:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Sep 2023 18:32:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Sep 2023 18:32:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: [PATCH 4/8] fsmonitor/win32: mark unused parameter in
 fsm_os__incompatible()
Message-ID: <20230918223205.GD2659298@coredump.intra.peff.net>
References: <20230918222908.GA2659096@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918222908.GA2659096@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We never look at the "ipc" argument we receive. It was added in
8f44976882 (fsmonitor: avoid socket location check if using hook,
2022-10-04) to support the darwin fsmonitor code. The win32 code has to
match the same interface, but we should use an annotation to silence
-Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/fsmonitor/fsm-settings-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index b6f6744494..0f2aa321f6 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -25,7 +25,7 @@ static enum fsmonitor_reason check_vfs4git(struct repository *r)
 	return FSMONITOR_REASON_OK;
 }
 
-enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc)
+enum fsmonitor_reason fsm_os__incompatible(struct repository *r, int ipc UNUSED)
 {
 	enum fsmonitor_reason reason;
 
-- 
2.42.0.671.g43fbf3903a


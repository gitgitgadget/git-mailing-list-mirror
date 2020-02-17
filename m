Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA40C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 14:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5427320679
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 14:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="Cl4lFuK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgBQOwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:52:45 -0500
Received: from mail.cmpwn.com ([45.56.77.53]:56534 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbgBQOwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 09:52:45 -0500
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Feb 2020 09:52:45 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1581950679; bh=IgLIwNxn7fV+CBBDAxh9W/EaK0xrGkJBILiDCQ4n7F4=;
        h=From:To:Cc:Subject:Date;
        b=Cl4lFuK11iKC3yrwWelTH2SA0uAA4EmUkishx9pAVhnt6rAqIgbuKEQZprjkTRQlH
         UpL+6ajOMCYQxBbidWrzlhRKKTiDMdZFn3023LIXoGDIfQAQyBkq10X1BxqHn+PsgD
         yC2uVTgWJ/w6MjFW08XPtqGEWi6n4BV9WonVxm7E=
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH 1/2] git-receive-pack: document push options
Date:   Mon, 17 Feb 2020 09:44:31 -0500
Message-Id: <20200217144432.43920-1-sir@cmpwn.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the missing documentation on how git push options are
presented to the pre-receive hook.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
 Documentation/git-receive-pack.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 25702ed730..69b3e77776 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -109,6 +109,12 @@ the following environment variables:
 This hook is called before any refname is updated and before any
 fast-forward checks are performed.
 
+If the user has specified any push options (see linkgit:git-push[1]),
+`GIT_PUSH_OPTION_COUNT` is set to the number of options, and
+`GIT_PUSH_OPTION_N` is set where N is an integer from 0 thru
+`GIT_PUSH_OPTION_COUNT` - 1. In order for to receive push options,
+`receive.advertisePushOptions` must be enabled on the server.
+
 If the pre-receive hook exits with a non-zero exit status no updates
 will be performed, and the update, post-receive and post-update
 hooks will not be invoked either.  This can be useful to quickly
-- 
2.25.0


Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B2EC433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 02:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AFA20671
	for <git@archiver.kernel.org>; Sun, 17 May 2020 02:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEQCYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 22:24:19 -0400
Received: from smtp-1.his.com ([216.194.195.13]:45456 "EHLO smtp-1.his.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgEQCYS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 May 2020 22:24:18 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 May 2020 22:24:18 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.his.com (Postfix) with ESMTP id 52D5C609D5
        for <git@vger.kernel.org>; Sat, 16 May 2020 22:16:17 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at smtp-1.his.com
Received: from smtp-1.his.com ([127.0.0.1])
        by localhost (smtp-1.his.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BLXTiE5pqzyc for <git@vger.kernel.org>;
        Sat, 16 May 2020 22:16:17 -0400 (EDT)
Received: from smtp-nf-201.his.com (smtp-nf-201.his.com [216.194.196.93])
        by smtp-1.his.com (Postfix) with ESMTP id 00E39609D4
        for <git@vger.kernel.org>; Sat, 16 May 2020 22:16:16 -0400 (EDT)
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id 5F3546042B
        for <git@vger.kernel.org>; Sat, 16 May 2020 22:16:16 -0400 (EDT)
X-ASG-Debug-ID: 1589681776-061c41045b25c610001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id ncAu0luieecnG5dc for <git@vger.kernel.org>; Sat, 16 May 2020 22:16:16 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id F04A060229
        for <git@vger.kernel.org>; Sat, 16 May 2020 22:16:15 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id B97F5177E8B;
        Sat, 16 May 2020 22:16:15 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dRApcFO_5f0y; Sat, 16 May 2020 22:16:15 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id A30EC177E99;
        Sat, 16 May 2020 22:16:15 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PRWf4MKv2m_X; Sat, 16 May 2020 22:16:15 -0400 (EDT)
Received: from kenilap.lorber.home (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 86C1A177E8B;
        Sat, 16 May 2020 22:16:15 -0400 (EDT)
Received: (from keni@localhost)
        by kenilap.lorber.home (8.14.5/8.14.1) id 04H2GFlm037022;
        Sat, 16 May 2020 22:16:15 -0400 (EDT)
From:   Kenneth Lorber <keni@hers.com>
To:     git@vger.kernel.org
Cc:     keni@hers.com
Subject: [RFC PATCH 2/6] Add bit on extending git to Hacking Git
Date:   Sat, 16 May 2020 22:13:40 -0400
X-ASG-Orig-Subj: [RFC PATCH 2/6] Add bit on extending git to Hacking Git
Message-Id: <1589681624-36969-3-git-send-email-keni@hers.com>
X-Mailer: git-send-email 2.7.1.287.g4943984.dirty
In-Reply-To: <1589681624-36969-1-git-send-email-keni@hers.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1589681776
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 1159
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81903
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kenneth Lorber <keni@his.com>

The Hacking Git section of the user manual is the logical place to look
for information on extending Gut, so add a short section of links to
places where that information actually lives.

Signed-off-by: Kenneth Lorber <keni@his.com>
---
 Documentation/user-manual.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 833652983f..2144246444 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4049,6 +4049,14 @@ and that is what higher level `git merge -s resolve` is implemented with.
 This chapter covers internal details of the Git implementation which
 probably only Git developers need to understand.
 
+If you are extending Git using hooks, writing new tools, or otherwise
+looking for technical information but not hacking Git itself, the following
+documents may be what you are really looking for:
+
+* hooks: linkgit:githooks[5]
+* attributes: linkgit:gitattributes[5]
+* new tools: linkgit:git-sh-setup[1]
+
 [[object-details]]
 === Object storage format
 
-- 
2.17.1


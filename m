Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9588EC433E1
	for <git@archiver.kernel.org>; Mon, 25 May 2020 23:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F752071A
	for <git@archiver.kernel.org>; Mon, 25 May 2020 23:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbgEYXe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 19:34:56 -0400
Received: from smtp-1.his.com ([216.194.195.13]:38862 "EHLO smtp-1.his.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgEYXez (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 19:34:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.his.com (Postfix) with ESMTP id 16983609BB
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:50 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at smtp-1.his.com
Received: from smtp-1.his.com ([127.0.0.1])
        by localhost (smtp-1.his.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W+zEbrK+W1UP for <git@vger.kernel.org>;
        Mon, 25 May 2020 19:27:49 -0400 (EDT)
Received: from smtp-nf-201.his.com (smtp-nf-201.his.com [216.194.196.93])
        by smtp-1.his.com (Postfix) with ESMTP id BF9E76090C
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:49 -0400 (EDT)
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id 1424662AE6
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:49 -0400 (EDT)
X-ASG-Debug-ID: 1590449268-061c4120512f2910001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id Es6NUjRwqvYg12VO for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:48 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id 8B193601CD
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:48 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 55E90177EAB;
        Mon, 25 May 2020 19:27:48 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id I7kCozNQqZYw; Mon, 25 May 2020 19:27:48 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 3E015177EAC;
        Mon, 25 May 2020 19:27:48 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ioBxu2wOH3fH; Mon, 25 May 2020 19:27:48 -0400 (EDT)
Received: from wings.local (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 216C0177EAB;
        Mon, 25 May 2020 19:27:48 -0400 (EDT)
Received: from wings.fios-router.home (localhost [127.0.0.1])
        by wings.local (8.15.2/8.15.2/Debian-10) with ESMTP id 04PNRlGr021156;
        Mon, 25 May 2020 19:27:47 -0400
Received: (from keni@localhost)
        by wings.fios-router.home (8.15.2/8.15.2/Submit) id 04PNRlIA021155;
        Mon, 25 May 2020 19:27:47 -0400
From:   Kenneth Lorber <keni@his.com>
To:     git@vger.kernel.org
Cc:     keni@his.com
Subject: [RFC PATCH v2 2/6] doc: Add bit on extending git to Hacking Git
Date:   Mon, 25 May 2020 19:27:23 -0400
X-ASG-Orig-Subj: [RFC PATCH v2 2/6] doc: Add bit on extending git to Hacking Git
Message-Id: <20200525232727.21096-3-keni@his.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525232727.21096-1-keni@his.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
 <20200525232727.21096-1-keni@his.com>
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1590449268
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 1120
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82102
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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


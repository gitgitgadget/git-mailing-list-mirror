Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7644FC433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 16:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450162087C
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 16:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgH0QT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:19:28 -0400
Received: from mail-gateway-shared02.cyon.net ([194.126.200.224]:48076 "EHLO
        mail-gateway-shared02.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726828AbgH0QT2 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Aug 2020 12:19:28 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Aug 2020 12:19:27 EDT
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1kBKWL-0007oo-3O
        for git@vger.kernel.org; Thu, 27 Aug 2020 18:13:03 +0200
Received: from [10.20.10.232] (port=32122 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.93)
        (envelope-from <bb@drbeat.li>)
        id 1kBKWJ-004h1z-TU; Thu, 27 Aug 2020 18:12:59 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 7AD53180546; Thu, 27 Aug 2020 18:12:59 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     Paul Mackerras <paulus@samba.org>
Cc:     git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] gitk: use the 'reference' format for the commit reference
Date:   Thu, 27 Aug 2020 18:12:24 +0200
Message-Id: <20200827161224.824365-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.26.0.277.gb8618d28a9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 1f0fc1db85 (pretty: implement 'reference' format, 2019-11-19) in
the main Git repository, there's an officially blessed format for commit
references. Update gitk to also use this format.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 gitk | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/gitk b/gitk
index da84e22..b26996c 100755
--- a/gitk
+++ b/gitk
@@ -9433,8 +9433,7 @@ proc mktaggo {} {
 proc copyreference {} {
     global rowmenuid autosellen
 
-    set format "%h (\"%s\", %ad)"
-    set cmd [list git show -s --pretty=format:$format --date=short]
+    set cmd [list git show -s --pretty=reference]
     if {$autosellen < 40} {
         lappend cmd --abbrev=$autosellen
     }
-- 
2.26.0.277.gb8618d28a9


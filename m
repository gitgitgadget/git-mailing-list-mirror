Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D07C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 18:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594112080D
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 18:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLISfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:35:42 -0500
Received: from mail-gateway-shared12.cyon.net ([194.126.200.65]:49620 "EHLO
        mail-gateway-shared12.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfLISfm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Dec 2019 13:35:42 -0500
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared12.cyon.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1ieNjL-0005Iw-WE
        for git@vger.kernel.org; Mon, 09 Dec 2019 19:26:02 +0100
Received: from [10.20.10.233] (port=20388 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.92)
        (envelope-from <bb@drbeat.li>)
        id 1ieNjK-0025mH-O2; Mon, 09 Dec 2019 19:25:58 +0100
Received: by drbeat.li (Postfix, from userid 1000)
        id 84187180083; Mon,  9 Dec 2019 19:25:58 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 1/2] gitk: use --pretty=reference to generate the commit summary
Date:   Mon,  9 Dec 2019 19:25:33 +0100
Message-Id: <20191209182534.309884-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git learned the "reference" pretty format in 1f0fc1db85 (pretty:
implement 'reference' format, 2019-11-19). Use it also in gitk instead
of duplicating the format string. This way, gitk always follows the
formatting convention defined by git.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
Junio, this goes on top of dl/pretty-reference, currently in pu.

Thanks!

 gitk-git/gitk | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index a14d7a16b2..cc89fb25d2 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9392,8 +9392,7 @@ proc mktaggo {} {
 proc copysummary {} {
     global rowmenuid autosellen
 
-    set format "%h (\"%s\", %ad)"
-    set cmd [list git show -s --pretty=format:$format --date=short]
+    set cmd [list git show -s --pretty=reference]
     if {$autosellen < 40} {
         lappend cmd --abbrev=$autosellen
     }
-- 
2.23.0.13.gecf2037ff6


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9C2E1FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 21:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbcLBVc1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 16:32:27 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:34606 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751937AbcLBVc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 16:32:26 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id DA357C3475;
        Fri,  2 Dec 2016 22:26:44 +0100 (CET)
Received: from drbeat.li (215-243-153-5.dyn.cable.fcom.ch [5.153.243.215])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id BF37BC3472;
        Fri,  2 Dec 2016 22:26:44 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
        id 8AEEF203DB; Fri,  2 Dec 2016 22:26:44 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 1/2] update-unicode.sh: automatically download newer definition files
Date:   Fri,  2 Dec 2016 22:26:34 +0100
Message-Id: <1480713995-16157-1-git-send-email-dev+git@drbeat.li>
X-Mailer: git-send-email 2.7.2
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Checking just for the files' existence is not enough; we should also
download them if a newer version exists on the Unicode servers.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 update_unicode.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/update_unicode.sh b/update_unicode.sh
index 27af77c..3c84270 100755
--- a/update_unicode.sh
+++ b/update_unicode.sh
@@ -10,12 +10,8 @@ if ! test -d unicode; then
 	mkdir unicode
 fi &&
 ( cd unicode &&
-	if ! test -f UnicodeData.txt; then
-		wget http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
-	fi &&
-	if ! test -f EastAsianWidth.txt; then
-		wget http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt
-	fi &&
+	wget -N http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt \
+		http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt &&
 	if ! test -d uniset; then
 		git clone https://github.com/depp/uniset.git
 	fi &&
-- 
2.7.2

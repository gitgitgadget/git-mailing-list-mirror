Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4171E1F406
	for <e@80x24.org>; Sun, 31 Dec 2017 19:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbdLaTTB (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 14:19:01 -0500
Received: from shout01.mail.de ([213.128.151.216]:40225 "EHLO shout01.mail.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbdLaTS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 14:18:58 -0500
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
        by shout01.mail.de (Postfix) with ESMTP id 3F9E1400AC;
        Sun, 31 Dec 2017 20:13:09 +0100 (CET)
Received: from smtp03.mail.de (smtp03.bt.mail.de [10.0.121.213])
        by postfix01.mail.de (Postfix) with ESMTP id 2939F43D9D;
        Sun, 31 Dec 2017 20:13:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde201610; t=1514747589;
        bh=M0G5mndBqa37Eexnj7h37DXaaKexIPdiegq80tR/Nro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXSIof/f2XF856jrunOrt14JzV6EXnptYrt3U/95B+S8ZIZggaSd/DVzSk3R4Bp+T
         p5m111LSkHIy+km70/Cn7SVQuzkhnItptXYdHuPQE8dNRPTbaKXiYTmZUcfM+bmtpN
         GKOYQj/Ud1y4USG8HIH2DUMyLvjTCcBxEB3dZKEw=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp03.mail.de (Postfix) with ESMTPSA id C3C7D80030;
        Sun, 31 Dec 2017 20:13:08 +0100 (CET)
From:   Stefan Moch <stefanmoch@mail.de>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Simon Doodkin <helpmepro1@gmail.com>, git@vger.kernel.org,
        Stefan Moch <stefanmoch@mail.de>
Subject: [PATCH 1/2] Add test case for mv --dry-run to t7001-mv.sh
Date:   Sun, 31 Dec 2017 20:11:55 +0100
Message-Id: <20171231191156.28359-2-stefanmoch@mail.de>
In-Reply-To: <20171231191156.28359-1-stefanmoch@mail.de>
References: <20171216013130.GB188893@aiede.mtv.corp.google.com>
 <20171231191156.28359-1-stefanmoch@mail.de>
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 723
X-purgate-ID: 154282::1514747589-00006A20-11CD19AA/0/0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It checks if mv --dry-run does not move file.

Signed-off-by: Stefan Moch <stefanmoch@mail.de>
---
 t/t7001-mv.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 6e5031f56..d4e6485a2 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -38,6 +38,12 @@ test_expect_success \
     'git diff-tree -r -M --name-status  HEAD^ HEAD | \
     grep "^R100..*path1/COPYING..*path0/COPYING"'
 
+test_expect_success \
+    'mv --dry-run does not move file' \
+    'git mv -n path0/COPYING MOVED &&
+     test -f path0/COPYING &&
+     test ! -f MOVED'
+
 test_expect_success \
     'checking -k on non-existing file' \
     'git mv -k idontexist path0'
-- 
2.14.3


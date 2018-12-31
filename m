Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53991F770
	for <e@80x24.org>; Mon, 31 Dec 2018 00:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbeLaAbw (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 19:31:52 -0500
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:34263 "EHLO
        fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLaAbw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 19:31:52 -0500
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181231003151.YKSV4101.fed1rmfepo101.cox.net@fed1rmimpo110.cox.net>
          for <git@vger.kernel.org>; Sun, 30 Dec 2018 19:31:51 -0500
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id A1970B837FB;
        Sun, 30 Dec 2018 17:31:50 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090207.5C296377.0027,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=L8upvNb8 c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=2ur7OfE09M0A:10 a=WDhBSedXqNQA:10 a=kviXuzpPAAAA:8 a=Zg4XqIe21ZXrWr11gN8A:9
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Stephen P . Smith" <ischis2@cox.net>
Subject: [PATCH 2/3] Add 'human' date format documentation
Date:   Sun, 30 Dec 2018 17:31:49 -0700
Message-Id: <20181231003150.8031-3-ischis2@cox.net>
X-Mailer: git-send-email 2.20.1.2.gb21ebb671b
In-Reply-To: <20181231003150.8031-1-ischis2@cox.net>
References: <20181231003150.8031-1-ischis2@cox.net>
Reply-To: alpine.LFD.2.21.999.1807071502260.18818@i7.lan
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Display date and time information in a format similar to how people
write dates in other contexts. If the year isn't specified then, the
reader infers the date is given is in the current year.

By not displaying the redundant information, the reader concentrates
on the information that is different. The patch reports relative dates
based on information inferred from the date on the machine running the
git command at the time the command is executed.

While the format is more useful to humans by dropping inferred
information, there is nothing that makes it actually human. If the
'relative' date format wasn't already implemented then using
'relative' would have been appropriate.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 Documentation/rev-list-options.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bab5f50b17..b491c3b999 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -835,6 +835,14 @@ Note that the `-local` option does not affect the seconds-since-epoch
 value (which is always measured in UTC), but does switch the accompanying
 timezone value.
 +
+`--date=human` shows the timezone if it matches the current time-zone,
+and doesn't print the whole date if that matches (ie skip printing
+year for dates that are "this year", but also skip the whole date
+itself if it's in the last few days and we can just say what weekday
+it was).
++
+`--date=auto` defaults to human if we're using the pager.
++
 `--date=unix` shows the date as a Unix epoch timestamp (seconds since
 1970).  As with `--raw`, this is always in UTC and therefore `-local`
 has no effect.
-- 
2.20.1.2.gb21ebb671b


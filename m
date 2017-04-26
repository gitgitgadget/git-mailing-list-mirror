Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BED5207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966177AbdDZT3t (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:29:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:56808 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966676AbdDZT3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:29:46 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRkhB-1dWEqh1DoX-00SzMI; Wed, 26
 Apr 2017 21:29:38 +0200
Date:   Wed, 26 Apr 2017 21:29:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v6 7/8] Abort if the system time cannot handle one of our
 timestamps
In-Reply-To: <cover.1493234408.git.johannes.schindelin@gmx.de>
Message-ID: <3f4c005794846ecc80bb4048adda54be2ad23b7a.1493234408.git.johannes.schindelin@gmx.de>
References: <cover.1493042239.git.johannes.schindelin@gmx.de> <cover.1493234408.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Xk2ZygKFSVerJhQdvBKb/ZljDpjIRwIzZE6BpYFPfak2CRSPYIT
 7AhBedeWzjWy1dbvQsLyRKDMVJcBWFqcFsE2mFSRyR8ccb7G9Wyu00qmdlVjplHk0JMWBu5
 aBa8yZC0nF06HBacKF8sDNFV9IDk8bQQLmH4NT/+yCH2/x1KGsa0zLJXfheREhNYub1aCDc
 ijlPlraVHeFYqdfjzTFtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1gPJe6prZ6o=:XG2bZgkwFwJsLsIfmx0RW+
 xaswPjM4YoDsxQVTj/vMwdvFiPod8OoLozaX6ryGrbUzrJ2gHdwj/DBykt9hQIRCadhcV9noR
 DuxdzEMkKcAu2AdPD4jl5PEt4jD06475bIX75aAT7dMrb/M2JVsWWhmye+GN8nGsOIfIkL3F4
 5ed2/cREY/AZDE1mwtnG7SwFPhaZNHRU5U9XuO4GiwUBp4IWlGzvYaRcijWNZ9a0MtWJi09pl
 2ujyAYMNzPUuq1u/tEyyPFURyDILM2uw3o0p+toia/y84h9R5y2E6/CqWoeaarmivg/g+QH3g
 gIua8AbG66FoB4P/1yniEDNWH3jdDpL7iaiqVqSvSfVSkv67aQW6rmy2Mt8Dz9SmVofur3ual
 b1/8GX4swGtGDPanXAyMzW1edXXrEBoRZaiaXqjBqeWyEsI/DZ3Xgxmuls9bxrYW8BNQRGfkg
 sUgJ4ZyRvNwW2O/T4dMCUEBlaHtrF9vAbK2d79UmE8LJF3okXJIyqL35/fthMAVkjLVp74DQ7
 RI/WlgAu3SiR0q7s+ZKhfMsb53Pbpcb9bR3RqSdKu2b8WSYYaxorteTARvB6ZhHihsysIOWAY
 2nUbywB5VsDNme3piBnN3unJz770m7YN1GRs9sB8C9/4QhN9XhTfwZFW5I48uWMERafUF44dn
 Vm2xvnGctvQFh0k2sxLBP8/f6DrKPfLe3wUbt/3fKI3taQ/vrHu+ghn4rWapFXavZ6KgzEppq
 Po1TYMZtN0WWl7a4aA5UJa9Tg/apvSlrGQwhg+fxRIuZKluHnaI580wOMz3BZNuvCaJPU3Esv
 +SqSd91
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are about to switch to a new data type for time stamps that is
definitely not smaller or equal, but larger or equal to time_t.

So before using the system functions to process or format timestamps,
let's make extra certain that they can handle what we feed them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 date.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 92ab31aa441..63fa99685e2 100644
--- a/date.c
+++ b/date.c
@@ -46,7 +46,17 @@ static time_t gm_time_t(timestamp_t time, int tz)
 	minutes = tz < 0 ? -tz : tz;
 	minutes = (minutes / 100)*60 + (minutes % 100);
 	minutes = tz < 0 ? -minutes : minutes;
-	return time + minutes * 60;
+
+	if (minutes > 0) {
+		if (unsigned_add_overflows(time, minutes * 60))
+			die("Timestamp+tz too large: %"PRItime" +%04d",
+			    time, tz);
+	} else if (time < -minutes * 60)
+		die("Timestamp before Unix epoch: %"PRItime" %04d", time, tz);
+	time += minutes * 60;
+	if (date_overflows(time))
+		die("Timestamp too large for this system: %"PRItime, time);
+	return (time_t)time;
 }
 
 /*
@@ -70,7 +80,10 @@ static int local_tzoffset(timestamp_t time)
 	struct tm tm;
 	int offset, eastwest;
 
-	t = time;
+	if (date_overflows(time))
+		die("Timestamp too large for this system: %"PRItime, time);
+
+	t = (time_t)time;
 	localtime_r(&t, &tm);
 	t_local = tm_to_time_t(&tm);
 
-- 
2.12.2.windows.2.406.gd14a8f8640f



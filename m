Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A9C31F42D
	for <e@80x24.org>; Sat, 19 May 2018 08:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeESI2W (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 04:28:22 -0400
Received: from mout.web.de ([212.227.15.4]:50747 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeESI2A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 04:28:00 -0400
Received: from [192.168.178.36] ([79.237.255.222]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M1WtV-1eQUFY0ZkP-00tRIO; Sat, 19
 May 2018 10:27:49 +0200
Subject: Re: [PATCH 3/5] query_fsmonitor: use xsnprintf for formatting
 integers
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20180519015444.GA12080@sigill.intra.peff.net>
 <20180519015758.GC32492@sigill.intra.peff.net>
Cc:     Ben Peart <benpeart@microsoft.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cd6dba3c-19bb-e6c7-0c1f-5cea0c8f9d81@web.de>
Date:   Sat, 19 May 2018 10:27:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180519015758.GC32492@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dimk5Bisc+shgyeZxsK8BZs3Yib9LZTVXCu90qzUkOe3Sk6sVh5
 gvGEVVf/3u1Nm06LqpCvXZftEyWl1Mec9cDFIy0E2cjHYz9kbO+umVHlBSu2fsp5CiQ7jLh
 1Sex4blnVwB060FJyTCUSZ7Kkbcf8zEIBaTjZAxINxfUHZiKU5DnkcyXw6F69FfwQWgzD0S
 9hI91F6SNGPUvKUaxeYDw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2SZFI1CoTMU=:nO1cRPAq2TACQn4nhngfsA
 1QA31QG0SuUesAmwfXsIizPrDhBGsNFrx/bAIoCF/RmZk6O5m2F4g/oW7z6ICxD3G0PyDzPVB
 +8jSMD0XbSwJSsV/vuNkd0v4b6D9sggL4j3FezR1cdWEZRTA/TIFcYZRsnMebzFSiNcvIWWnh
 +zjcIPNx4Azh8JWNgF3Oj5zxTlEY+nDCyysbENRMpmE0mue4BFSVAEiZ7GaSaeba1McFeoMmB
 Rnbdej7sXuLoYo4ecWpo9ABLYXGV+dwCuaaWd5GRbUBbnqX8PKqDBL6R9dVfYXLnUy2Um+7E/
 vuHNyakjgQs2Wwb1LIhpP3mEGDkP/325NV/nevDHMr1XoJNZA1icGgyQK/RV+ePwQvqvAyj+c
 4gRqCKNecB9dGwpwa040He//RBH7P+FsYjnJR9GAQ3w0CK0oMkPfxKIUIwJsP1GDGmftBFIiT
 SJxS1+nQpicQN4U24URCIKM2B69+hPzJrnOTcHv0jaQub2hKqO/CZr7HyzluOs++LEIOAnpt7
 zeFtNWebx4nvVdSqvR147jZG/eezOxNsBcoGy0Zrz7y4SHfylMXdzG3hqoc2tIE86qJOJIJTn
 fA3Bz3/z0OErJzQGTphh4B2SE+ZXAMVE0wx3tIz79L+6JbPfzP96/2kjQnpW42QV9KUovw13/
 qNhta22HJLRE/wzS3IoedgoWPILmFfW4tlQ90IS4qRGurw8v4DzEqxjFwXAgzLJdHerhT+tK4
 52gvp4Qaj40fi2AEC0DjN5Cwa3iZRcrrzg6F8Xn1iZe3cqWUw78KSrD+icGz8vewQw4fd+fC2
 P4FPYdg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.05.2018 um 03:57 schrieb Jeff King:
> These formatted integers should always fit into their
> 64-byte buffers. Let's use xsnprintf() to add an assertion
> that this is the case, which makes auditing for other
> unchecked snprintfs() easier.

How about this instead?

-- >8 --
Subject: [PATCH] fsmonitor: use internal argv_array of struct child_process

Avoid magic array sizes and indexes by constructing the fsmonitor
command line using the embedded argv_array of the child_process.  The
resulting code is shorter and easier to extend.

Getting rid of the snprintf() calls is a bonus -- even though the
buffers were big enough here to avoid truncation -- as it makes auditing
the remaining callers easier.

Inspired-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 fsmonitor.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index ed3d1a074d..665bd2d425 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -97,19 +97,13 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
 static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *query_result)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-	char ver[64];
-	char date[64];
-	const char *argv[4];
 
-	if (!(argv[0] = core_fsmonitor))
+	if (!core_fsmonitor)
 		return -1;
 
-	snprintf(ver, sizeof(ver), "%d", version);
-	snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
-	argv[1] = ver;
-	argv[2] = date;
-	argv[3] = NULL;
-	cp.argv = argv;
+	argv_array_push(&cp.args, core_fsmonitor);
+	argv_array_pushf(&cp.args, "%d", version);
+	argv_array_pushf(&cp.args, "%" PRIuMAX, (uintmax_t)last_update);
 	cp.use_shell = 1;
 	cp.dir = get_git_work_tree();
 
-- 
2.17.0

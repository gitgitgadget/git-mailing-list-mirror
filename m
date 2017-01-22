Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEC520A17
	for <e@80x24.org>; Sun, 22 Jan 2017 17:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbdAVRyk (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 12:54:40 -0500
Received: from mout.web.de ([212.227.15.14]:63587 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbdAVRyj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 12:54:39 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLgTT-1cWBYI3xD9-000uFn; Sun, 22
 Jan 2017 18:54:02 +0100
Subject: [PATCH v2 3/5] perf: add basic sort performance test
To:     Git List <git@vger.kernel.org>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <74edb08e-4470-e166-cc78-243fa7cb36b3@web.de>
Date:   Sun, 22 Jan 2017 18:53:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:yYtYZKYIFa/8TlNqVZ+u5Usk04pQX6FSBXTBldgFzTSbqU+ZD0m
 ygiZTFPh92sgPyOzxZlXpraEtPrhoygFtLkRuHICDMN7fJdUvA78pAtTkHmxiXiIFKCA8H1
 iA+RjaTW2sEbWzcxhmDch7rMEDPu+KxcNokA4QBnOCX/0LiX3ly1UnrbFFkEn679UpggIdb
 6R6IUglbaPA2edp2tDVhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5lAsvNPJqj0=:F5VQU5UlAsao5H1jrBF2Zr
 ohFXu8r4uZflr9SFpyi9WsDwT22CQ3m4rjJ0PixnKQOlbptgoV7Zvh0cZ2v5H+00a6zDqEmuA
 5fRF49zP0YEhEQQRc/gm1gLx7+ujn6guXJ4zpNEUyKKLZRxqWp4eyefq05u4UT5AxtuThVNTa
 lMCAyqan4xfuEHEiQYclqxEX/gp1kbQ5uvyqhEVYqMShtdYAxpftVssIanhWBCxNZ/EmuizrK
 0Dbcs5I0S6T7FnmgZL/VS5x/jiCVBRaHePvkfrH2/6rXyuVGujYP4CUbItvB6Q5kIvsnGPhuE
 xiOF6ISHsjK8vtqMCWDCS48PpJKt5JKbqTuCjyQI6ku//GIMtJvrS+1g/9DPzz+CM5fux/Hq9
 kmfval85OLVnq2GxQlFtiqFQqlyGsZdT0oC5RUguz9mFs4MB2RP6xCLeDMrOwhBrlPgTd5qoY
 LTaLe+tTprdP8jBYoHx/1KwPi1NK13UA9n/XN6THuXhCsF0Zq5M9iDQYmWY5oDiA3p/7ijVp4
 JHoHIu1s+U27Nh+NL4BMsYioDlum7HIbq3KrXYns8XlropOylTPwwNOcvHV5EdXilxIcItLNy
 hzcNV9UCSRCvf1aECVldsjystswkn/qJwf6PI+Pyhaoj96NeRNdpr/maQ72UTWdLHT0FxPysB
 PpTbSP5PCpwJ8g9oJV8p0agK4to+WzeQTg0pRh2vR5fcAmyjpcnRl7IbB3H71xtEZpad6voFH
 XnpHjhmsdWkjB8umDKvx/OVNoI2R3v7aSxkMrsJxLZ7D8qKKwsU5ZYMr947VKehjesv79xw72
 Uwpb513
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a sort command to test-string-list that reads lines from stdin,
stores them in a string_list and then sorts it.  Use it in a simple
perf test script to measure the performance of string_list_sort().

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/helper/test-string-list.c | 25 +++++++++++++++++++++++++
 t/perf/p0071-sort.sh        | 26 ++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100755 t/perf/p0071-sort.sh

diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 4a68967bd1..c502fa16d3 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -97,6 +97,31 @@ int cmd_main(int argc, const char **argv)
 		return 0;
 	}
 
+	if (argc == 2 && !strcmp(argv[1], "sort")) {
+		struct string_list list = STRING_LIST_INIT_NODUP;
+		struct strbuf sb = STRBUF_INIT;
+		struct string_list_item *item;
+
+		strbuf_read(&sb, 0, 0);
+
+		/*
+		 * Split by newline, but don't create a string_list item
+		 * for the empty string after the last separator.
+		 */
+		if (sb.buf[sb.len - 1] == '\n')
+			strbuf_setlen(&sb, sb.len - 1);
+		string_list_split_in_place(&list, sb.buf, '\n', -1);
+
+		string_list_sort(&list);
+
+		for_each_string_list_item(item, &list)
+			puts(item->string);
+
+		string_list_clear(&list, 0);
+		strbuf_release(&sb);
+		return 0;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
diff --git a/t/perf/p0071-sort.sh b/t/perf/p0071-sort.sh
new file mode 100755
index 0000000000..7c9a35a646
--- /dev/null
+++ b/t/perf/p0071-sort.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='Basic sort performance tests'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'setup' '
+	git ls-files --stage "*.[ch]" "*.sh" |
+	cut -f2 -d" " |
+	git cat-file --batch >unsorted
+'
+
+test_perf 'sort(1)' '
+	sort <unsorted >expect
+'
+
+test_perf 'string_list_sort()' '
+	test-string-list sort <unsorted >actual
+'
+
+test_expect_success 'string_list_sort() sorts like sort(1)' '
+	test_cmp_bin expect actual
+'
+
+test_done
-- 
2.11.0


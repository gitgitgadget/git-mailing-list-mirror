Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EC1620188
	for <e@80x24.org>; Sat, 13 May 2017 16:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754199AbdEMQCn (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 12:02:43 -0400
Received: from mout.web.de ([212.227.17.11]:56672 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753030AbdEMQCm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 12:02:42 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFL6u-1dCqlD28Cy-00EJxC; Sat, 13
 May 2017 18:02:35 +0200
Subject: [PATCH 3/5] p0004: use test_perf
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Message-ID: <5d8cff82-c695-ea6a-4d82-448dc10b8b63@web.de>
Date:   Sat, 13 May 2017 18:02:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <9b574d73-8dfb-f0b3-dc3e-d593726a8f0e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:QVL8RAL8UD3MNIQjZl+qzNBWrU+GS4PDXdtDk0DrzJSI7SUJysc
 FWtTNgIU91/xYtSIRem4lCNn8NAyJqJBxs1y2Z+pd8nLs5iJrcq+CaraqfNLugd/7sKuP+L
 YVkKDIEJoI6aHI549bXMVd2FIqJWMMqHGJ7hrkXDCMxEdx4Qx1xMpwy/82otYxjF92ammRU
 Fkn36d6rvD6vicrYFB72A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d+QBTunY6Ds=:bpH5cgh7SktboAdgsa5Axe
 4+MbbRpskuW2to4kNiOROd4W52hg1jN6pGVlrtpygMaL62HwouSBfGYKawSTLQ9sH6ik2POZL
 4P+UkmsH5Xwug/swZuYkzq6UNq5KXV+/zxP9+bh6VKymcOm4A15LarTT65qUYoj+7iSk/N33U
 CAlCGXMFPV72iEA7Jp2hjRiRq2r/mO9s0nU3LSyu6Z3swO2NKIMUNYzE3+tbjmwCIjbP3TH1V
 574JPLJlWQhcN5g3/zqpRrA41yfC+Nm9JUYchnod2qNsFryD0CBAvYFP1FPScZ1P/H2pMohUw
 0daOVBuKSiCGoehbwXcvH4AKiWDsz5dCk8q3za51T3cUarlJmWj4SQsFiYs8cQUdu1/FnfOKG
 aWAacUJ1wB4DQ82+lU0bcHpyae9oIDZnrqLR0fmRF80z5ArVsi2YL9CYObQ2aMz6y7Ze1JwEF
 5snC00I3Obw2QuKY0d+WSL12eaKR3TtKXaHhhEskp/90SmtTfuvheN7oQwOHwsXVyPY7mvWw5
 BoyYwNx+iaJP5TtJO3LeaqSIfmYdL2LmRRFFmUK24qoUoLI6zS9BsEYq9+crOnsUDo43Qam3K
 pxjvGZfBIPM7T5tRnf+JC7W/I8RqJf+piyI7o581D4fqF5SMnn5L/GiFqkwJUgY6Vh9JjVHSO
 UoeSreFJzpi+EqGWKYAVEujx7T2KGdB6hpczJVSf/UqgiseaH58vEZNjYDgmvOAQ98VMmHJI2
 iCzGNVDdIvlu82kzrwtjKqk5HqhKfmYPFvg1yVzc5nLr1l9JVRMSlZiFvyZV1w7dv9/gKvhJA
 w665kNH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The perf test suite (more specifically: t/perf/aggregate.perl) requires
each test script to write test results into a file, otherwise it aborts
when aggregating.  Add actual performance tests with test_perf to allow
p0004 to be run together with other perf scripts.

Calibrate the value for the parameter --count based on the size of the
test repository, in order to get meaningful results with smaller repos
yet still be able to finish the script against huge ones without having
to wait for hours.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
The numbers are just guesses; I didn't actually test all ranges.

 t/perf/p0004-lazy-init-name-hash.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/perf/p0004-lazy-init-name-hash.sh b/t/perf/p0004-lazy-init-name-hash.sh
index 576bdc3c4e..d30c32f97b 100755
--- a/t/perf/p0004-lazy-init-name-hash.sh
+++ b/t/perf/p0004-lazy-init-name-hash.sh
@@ -18,4 +18,40 @@ test_expect_success 'multithreaded should be faster' '
 	test-lazy-init-name-hash --perf >out.perf
 '
 
+test_expect_success 'calibrate' '
+	entries=$(wc -l <out.single) &&
+
+	case $entries in
+	?) count=1000000 ;;
+	??) count=100000 ;;
+	???) count=10000 ;;
+	????) count=1000 ;;
+	?????) count=100 ;;
+	??????) count=10 ;;
+	*) count=1 ;;
+	esac &&
+	export count &&
+
+	case $entries in
+	1) entries_desc="1 entry" ;;
+	*) entries_desc="$entries entries" ;;
+	esac &&
+
+	case $count in
+	1) count_desc="1 round" ;;
+	*) count_desc="$count rounds" ;;
+	esac &&
+
+	desc="$entries_desc, $count_desc" &&
+	export desc
+'
+
+test_perf "single-threaded, $desc" "
+	test-lazy-init-name-hash --single --count=$count
+"
+
+test_perf "multi-threaded, $desc" "
+	test-lazy-init-name-hash --multi --count=$count
+"
+
 test_done
-- 
2.12.2


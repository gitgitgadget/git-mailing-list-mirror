Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1251F89C
	for <e@80x24.org>; Tue, 24 Jan 2017 18:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750772AbdAXSAd (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 13:00:33 -0500
Received: from mout.web.de ([212.227.17.12]:52869 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbdAXSAc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 13:00:32 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCqsR-1ce5rU454t-009i9H; Tue, 24
 Jan 2017 19:00:12 +0100
Subject: Re: [DEMO][PATCH v2 6/5] compat: add a qsort_s() implementation based
 on GNU's qsort_r(1)
To:     Junio C Hamano <gitster@pobox.com>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de>
 <9f8b564d-ec9f-abc9-77f6-aa84c6e78b7a@web.de>
 <xmqq60l5sihz.fsf@gitster.mtv.corp.google.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <4e416167-2a33-0943-5738-79b4da5f2c11@web.de>
Date:   Tue, 24 Jan 2017 19:00:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq60l5sihz.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:jFsnMx9ehF15VRWlo5n+4OTy1mXM8k9bMCoHQoZU10wTLmLvvoi
 QZ0eouX3iKeXgwVkUFZ2itiQptaKhuVGHKE0cnPt8Lz+/BQxjFhWjIDra75yVBe5E9Z9H5Q
 YJDApT1ZDHiYBM3o2/9ZLsgKQWAsbpS5G95rrCVnWXmHjpOsw49rBvgAS1/ompIv6aT8BGS
 YYANPQgqcUFJMxQocIAEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+iG6nvObrf8=:EWyunM1O1H9vb3ax7XYpkD
 xixX5RmsF1I2oXHxFJc7+doxVQsLaH7vWp0CSrTsimwOMZfhFyCu3881eVH1r9H+AH0FxLIuq
 /nzroLsq4WsNGNsMxZJgvEWDqY+AunsNY/xNAjFbYloUov8Hai6kWqXw23ocANCwNdjjhbg0G
 uEQAf1/6QlWgY6E29ldkrn7kqc97x/uthASNM1FJI+2LqJR2gu2zRSB5KuBE/MvjqVkJBUe4L
 2s/344ZxERMP5TZK2K5wwZ7GJuIoz6OngPz5HbkbJUG9vb5ETkiB40+GnKcfWn5g5ny5bDeyD
 YBgCykSBJWfaLnKGKev9/FUpu96rUv6/E6qN8uaf1tEwxGk9uELKJPef6gsJ92qQtsJHBDlLN
 TSaVa9r/zUKRBgcH46AdmtxIScqieCelI2m4w/h3sMQuiWoK3FMMumRYSrPFb6QV1RoW3PUWP
 bDCBQEorYjUsRo01XZBjsyuH28UexFCwbCba1DTmIEkrMeSEEw4PBQip7MXqiX01UdLUn+Mbo
 YFxvX3QYRnozXSKgzB8cqZ48P/3MyYkDIA4ICYXAbtkAGFxmsMBtEJxAZasM90yuL9LYqRoWa
 dHWCLadCfwcrNRLnrLskBwXzu/6FDbe2m0z1tbiSFenCU2LAAf8Hx+TmWzsOyFvW7RL4qCpXE
 D90xS7TsviaueP1/ZCf2+snMWwj59wEs4VQs8YQ6UHMkxr8zAyHbIzuLtPHf69qYYTzKlI4Sb
 iugYczPMOYOrVwsjLIzt51e/PMKutqTRNWH1mQeoblJPoOeL17g6Q+1S4oowMEPmLHfy5IGT8
 FNxCTK1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.01.2017 um 20:07 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Implement qsort_s() as a wrapper to the GNU version of qsort_r(1) and
>> use it on Linux.  Performance increases slightly:
>>
>> Test                         HEAD^             HEAD
>> --------------------------------------------------------------------
>> 0071.2: sort(1)              0.10(0.20+0.02)   0.10(0.21+0.01) +0.0%
>> 0071.3: string_list_sort()   0.17(0.15+0.01)   0.16(0.15+0.01) -5.9%
>>
>> Additionally the unstripped size of compat/qsort_s.o falls from 24576
>> to 16544 bytes in my build.
>>
>> IMHO these savings aren't worth the increased complexity of having to
>> support two implementations.
> 
> I do worry about having to support more implementations in the
> future that have different function signature for the comparison
> callbacks, which will make things ugly, but this addition alone
> doesn't look too bad to me.

It is unfair of me to show a 5% speedup and then recommend to not
include it. ;-)  That difference won't be measurable in real use cases
and the patch is not necessary.  This patch is simple, but the overall
complexity (incl. #ifdefs etc.) will be lower without it.

But here's another one, with even higher performance and with an even
bigger recommendation to not include it! :)  It veers off into another
direction: Parallel execution.  It requires thread-safe comparison
functions, which might surprise callers.  The value 1000 for the minimum
number of items before threading kicks in is just a guess, not based on
measurements.  So it's quite raw -- and I'm not sure why it's still a
bit slower than sort(1).

Test                         HEAD^             HEAD
---------------------------------------------------------------------
0071.2: sort(1)              0.10(0.18+0.03)   0.10(0.20+0.02) +0.0%
0071.3: string_list_sort()   0.17(0.14+0.02)   0.11(0.18+0.02) -35.3%

---
 compat/qsort_s.c | 76 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 18 deletions(-)

diff --git a/compat/qsort_s.c b/compat/qsort_s.c
index 52d1f0a73d..1304a089af 100644
--- a/compat/qsort_s.c
+++ b/compat/qsort_s.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "../thread-utils.h"
 
 /*
  * A merge sort implementation, simplified from the qsort implementation
@@ -6,29 +7,58 @@
  * Added context pointer, safety checks and return value.
  */
 
-static void msort_with_tmp(void *b, size_t n, size_t s,
-			   int (*cmp)(const void *, const void *, void *),
-			   char *t, void *ctx)
+#define MIN_ITEMS_FOR_THREAD 1000
+
+struct work {
+	int nr_threads;
+	void *base;
+	size_t nmemb;
+	size_t size;
+	char *tmp;
+	int (*cmp)(const void *, const void *, void *);
+	void *ctx;
+};
+
+static void *msort_with_tmp(void *work)
 {
+	struct work one, two, *w = work;
 	char *tmp;
 	char *b1, *b2;
 	size_t n1, n2;
+	size_t s, n;
 
-	if (n <= 1)
-		return;
+	if (w->nmemb <= 1)
+		return NULL;
 
-	n1 = n / 2;
-	n2 = n - n1;
-	b1 = b;
-	b2 = (char *)b + (n1 * s);
+	one = two = *w;
+	one.nr_threads /= 2;
+	two.nr_threads -= one.nr_threads;
+	n = one.nmemb;
+	s = one.size;
+	n1 = one.nmemb = n / 2;
+	n2 = two.nmemb = n - n1;
+	b1 = one.base;
+	b2 = two.base = b1 + n1 * s;
+	two.tmp += n1 * s;
 
-	msort_with_tmp(b1, n1, s, cmp, t, ctx);
-	msort_with_tmp(b2, n2, s, cmp, t, ctx);
+#ifndef NO_PTHREADS
+	if (one.nr_threads && n > MIN_ITEMS_FOR_THREAD) {
+		pthread_t thread;
+		int err = pthread_create(&thread, NULL, msort_with_tmp, &one);
+		msort_with_tmp(&two);
+		if (err || pthread_join(thread, NULL))
+			msort_with_tmp(&one);
+	} else
+#endif
+	{
+		msort_with_tmp(&one);
+		msort_with_tmp(&two);
+	}
 
-	tmp = t;
+	tmp = one.tmp;
 
 	while (n1 > 0 && n2 > 0) {
-		if (cmp(b1, b2, ctx) <= 0) {
+		if (one.cmp(b1, b2, one.ctx) <= 0) {
 			memcpy(tmp, b1, s);
 			tmp += s;
 			b1 += s;
@@ -42,7 +72,8 @@ static void msort_with_tmp(void *b, size_t n, size_t s,
 	}
 	if (n1 > 0)
 		memcpy(tmp, b1, n1 * s);
-	memcpy(b, t, (n - n2) * s);
+	memcpy(one.base, one.tmp, (n - n2) * s);
+	return NULL;
 }
 
 int git_qsort_s(void *b, size_t n, size_t s,
@@ -50,20 +81,29 @@ int git_qsort_s(void *b, size_t n, size_t s,
 {
 	const size_t size = st_mult(n, s);
 	char buf[1024];
+	struct work w;
 
 	if (!n)
 		return 0;
 	if (!b || !cmp)
 		return -1;
 
+	w.nr_threads = online_cpus();
+	w.base = b;
+	w.nmemb = n;
+	w.size = s;
+	w.cmp = cmp;
+	w.ctx = ctx;
+
 	if (size < sizeof(buf)) {
 		/* The temporary array fits on the small on-stack buffer. */
-		msort_with_tmp(b, n, s, cmp, buf, ctx);
+		w.tmp = buf;
 	} else {
 		/* It's somewhat large, so malloc it.  */
-		char *tmp = xmalloc(size);
-		msort_with_tmp(b, n, s, cmp, tmp, ctx);
-		free(tmp);
+		w.tmp = xmalloc(size);
 	}
+	msort_with_tmp(&w);
+	if (w.tmp != buf)
+		free(w.tmp);
 	return 0;
 }
-- 
2.11.0


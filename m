Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DECC433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 16:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiGPQ4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 12:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiGPQ4h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 12:56:37 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F721EECB
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657990592;
        bh=ZHs1iXbVbXaVw++047CRpV2JS/Why4c2OfaUdEZ4T+g=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=OznOkL+gRsoA3pNXiMzNu0clX5BWQ2TJtmnQ7IIT1vd22HFZkDzuy5rcf62zOWVVc
         leaGtEXl7XgqLQ5WSpydDV8trR5EGbnULnjHiXR08F0abOl4XEQJU7dKjXikurDXzQ
         c9luoKGvarYtmrkFcgjxBt7oizQYG/wmmZH+sNHY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGWc-1oKyZO1che-009cgG; Sat, 16
 Jul 2022 18:56:32 +0200
Message-ID: <dda728d4-eedc-c4c6-034e-0a5a03ed9059@web.de>
Date:   Sat, 16 Jul 2022 18:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: [PATCH 04/10] test-mergesort: use DEFINE_LIST_SORT_DEBUG
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
In-Reply-To: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5zvVqOiGSj+I8UlajZWWsivRsEfT902OfOKVdeQapYx0KCV4uEh
 y+1FOg4lhF+74D9yDQip1yQvxu20Y3UMBeaBB//aYwz+XV4KntPT7r/ToarSVSCfHNo9UhE
 hQwJKxdw6zbssgr9cKFAWOy22dlyCLKn9YYBsqMuHMHeHYCFtLKHhsTQP+4urGvultK9ek3
 j9JcVpHzlNkH395YCyMBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GBhaQeWRxzY=:rQix5elWVPriWcmuAr5n0x
 KP2N7jb/0T5LNLy4YIul1Gi9tm6JricW9NRdw0SKby0brm/u+gqNatxUqAzULOdJob11teZzU
 w+ai1sBEJf+J8lKXMG08fhKQCf2CV0zlhaH92EUgQ/CpMqj4zjxMtareyLIOlIyy0wqNxCTQo
 IW2k/BSUSXpOjH+HoeJn0KljujZsFe4nFZe9wRJQeKdbIPohTfFEuM7yum0i47+Z0JomDOqCy
 6k9Q0TnjLb+ZUYGsfN3PwEhhuEnSZnoEhGtcLqtlw1G5XXlUBpENJz98vsuvh1BjnqoqkUSdd
 aRFA6Fcqpedjd/hqjssfplM+8g+i7J9duvOVJkyJ1tK1KVTEgR8RYMSWmvS3MRoulbivjxX8z
 MarDuv7dCvfXye/2pyXKZfgTKYFDoU31BoRFwVuy9xykTX41Z5+B00sZMXCaqjLvjHIBsHYUJ
 sZa0KQM1XVVOXcltjAjM121Kscan+PrFuPGeTfxEBpFN8N6PiRovF2Lq8lNiMUkd8mPwH+v8Y
 wm1NR3AJRsQNRfWQmvr0GdzBMAm61DAL1flfs/MXwX1JWyyM4ZzK4OSKB5iCPZPpRBLTp8bV5
 fzHLUAVDWJQ/hy9U5impbw6Ugb1FkOs/h1GtocvFYF7y5W61SdDhITxbfhH7JjPqFMk7JYFdg
 50XuK5qcst105ruDgnzmDRNDPA2wN9ZGF6GevYYG9U8ORp0MqTYEGRJ2LiZfgN20GcKEDCRXP
 qdzJY1jabfjeC6VPR8oITIdr6B1yhVjlnn4iyxAyD2kkGugJiC/SBXvUMYfzAgNZhx/jBDDrK
 /t2rHhiRAQ4mUyTQiRvh2H6GxOJvAoJ8B4cLdg9S6AeU+RMJPnqoQ0SB7BuHjPaMITb9Ny7QB
 FveIGjNKIFVTj8yOlNzSGtG6XexFsGXaJAtINuM+x9OI+8Q/P2gRLYf9NGbF+tRsurUtw57ap
 xmMgyUvjQbPuFG4w2OkD4ko14odOpPlZGzVQG07m1yMlbs867WscJPZRDYF/xvcwsC5+77yz4
 UDoKTVNfsQtdHPUYfHgOCRrrpugoGsgzRTIbbhWIeqEXlsdTQEjUwkYf/LaL4An/j0J6lC9Y9
 cL2zMdTpV6kN5VCRRm+sFZyf6nuyknjNAJ5osLNpzi/ZgKG9V6kh+qaJw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define a typed sort function using DEFINE_LIST_SORT_DEBUG for the
mergesort sanity check instead of using llist_mergesort().  This gets
rid of the next pointer accessor functions and improves the performance
at the cost of slightly bigger object text.

Before:
Benchmark 1: t/helper/test-tool mergesort test
  Time (mean =C2=B1 =CF=83):     108.4 ms =C2=B1   0.2 ms    [User: 106.7 =
ms, System: 1.2 ms]
  Range (min =E2=80=A6 max):   108.0 ms =E2=80=A6 108.8 ms    27 runs

__TEXT	__DATA	__OBJC	others	dec	hex
6251	276	0	23172	29699	7403	t/helper/test-mergesort.o

With this patch:
Benchmark 1: t/helper/test-tool mergesort test
  Time (mean =C2=B1 =CF=83):      94.0 ms =C2=B1   0.2 ms    [User: 92.4 m=
s, System: 1.1 ms]
  Range (min =E2=80=A6 max):    93.7 ms =E2=80=A6  94.5 ms    31 runs

__TEXT	__DATA	__OBJC	others	dec	hex
6407	276	0	24701	31384	7a98	t/helper/test-mergesort.o

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-mergesort.c | 19 ++++---------------
 t/t0071-sort.sh           |  2 +-
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index ebf68f7de8..93d15d59a1 100644
=2D-- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -273,21 +273,11 @@ struct number {
 	struct number *next;
 };

-static void *get_next_number(const void *a)
-{
-	stats.get_next++;
-	return ((const struct number *)a)->next;
-}
-
-static void set_next_number(void *a, void *b)
-{
-	stats.set_next++;
-	((struct number *)a)->next =3D b;
-}
+DEFINE_LIST_SORT_DEBUG(static, sort_numbers, struct number, next,
+		       stats.get_next++, stats.set_next++);

-static int compare_numbers(const void *av, const void *bv)
+static int compare_numbers(const struct number *an, const struct number *=
bn)
 {
-	const struct number *an =3D av, *bn =3D bv;
 	int a =3D an->value, b =3D bn->value;
 	stats.compare++;
 	return (a > b) - (a < b);
@@ -325,8 +315,7 @@ static int test(const struct dist *dist, const struct =
mode *mode, int n, int m)
 	*tail =3D NULL;

 	stats.get_next =3D stats.set_next =3D stats.compare =3D 0;
-	list =3D llist_mergesort(list, get_next_number, set_next_number,
-			       compare_numbers);
+	sort_numbers(&list, compare_numbers);

 	QSORT(arr, n, compare_ints);
 	for (i =3D 0, curr =3D list; i < n && curr; i++, curr =3D curr->next) {
diff --git a/t/t0071-sort.sh b/t/t0071-sort.sh
index 6f9a501c72..ba8ad1d1ca 100755
=2D-- a/t/t0071-sort.sh
+++ b/t/t0071-sort.sh
@@ -5,7 +5,7 @@ test_description=3D'verify sort functions'
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh

-test_expect_success 'llist_mergesort()' '
+test_expect_success 'DEFINE_LIST_SORT_DEBUG' '
 	test-tool mergesort test
 '

=2D-
2.37.1

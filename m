Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F87C43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 16:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiGPQ5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 12:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiGPQ5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 12:57:24 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E231EEDD
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657990639;
        bh=P0Ldh/u8BxpmuQnbuXD1I8hnP1si1Hm0NES5D0boh88=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=YlTawgs6Qc2SY9LTw7PzDghHnqkPQD7aCoHYSUkU75K+iYgA8ijWd5RdLT5q6V+Ys
         3arXvmD9I8dXG/FqQf/fADRYo2BkgIOGf6ZUkDV6i7GvKhi79qkIL4QnSz3Px6HlbF
         kxRTvOj2Pkk6MPeVuUr+laBrLbHwekfK9eIYRFY4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mpl0r-1nlMlX4C6v-00q4jO; Sat, 16
 Jul 2022 18:57:19 +0200
Message-ID: <54b6a68e-9e2d-c3ec-d6d0-e5dd9a81d391@web.de>
Date:   Sat, 16 Jul 2022 18:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: [PATCH 05/10] test-mergesort: use DEFINE_LIST_SORT
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
In-Reply-To: <4d7cd286-398e-215c-f2bd-aa7e8207be4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YTQSZQAe/p4jr+Y7sfN0sooPLb1FTVE/DzXVZ17bzPcgQorfXSL
 XaAiAWyK9XuPqRuDUtBSBpvz69KU1/Bcgh+rQKaIKJZL2FiOownMvyRs5o+vbuUo/auH65v
 vTS6mA0hKa3yXDg9rmpVjoiWzBMyh0iZps00DN+cKtLu068hL1Fzpbx+pz0maC0bSPUs1Mq
 bn4jwkF7bfxLV67ofPiSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rwr/te9R23E=:dm1xb8MFODmBeEATQ/evNa
 cC4LMrve3X8/FPR548mdaG22cUy6IfxpSyi/NQrPqIhzH6IMBNDU+WXkmcqQdrtW6seoLJLq7
 cUWjEG2BO0NNkzY3GZ7N6vswWFLPfKQ8dB0KkrGqKRPSGOv3i136LdJERQsOXefFqUvysqpkb
 qDbHMf2+KbBSdRyxmho/xhzoPedEPvx8dlVrMZ2uSDkUaKCaOEyzQTvPwHWTcZLzuHWu5aQzv
 PszpfPGRbVv4wya9TQcK3d2AUltWrNGLOx1aLfo6h12jyQjgcpjo1GP4/U2T913IO38Qjbegw
 eCFEGKzWFOW55zmiEkWgxlaZ441GT/P04abqd43M/kETc9M7oAPHwJ0yC3IVw7+cLJ2YhtXGZ
 rtuy3Cfjz+EVLnhLxV8VxiFIoiJSYa5vYtyBfejQAYIPOHeKKG2wYSyjrVXDLBvgHvHDPrGbL
 78m96b9RT1LgV/V6hkck735eqwa4fqu8jp4nL5Gv6JPOU6tdYf/EjUeLQZ2VlgqgDpu4pCLa4
 vFNIJxazZvAdodM33lxaVb5RFVeie3j9HCpcqQl44ZA3THthsl0Tdlvp8s9L3NewKfpEbZLUn
 2q4xfdbS2/rXWpVpyflWYx+iKie6NGYNmVOYbfsHCOepjhVnJVwUMfS4KHquHWTRLCXuQLciB
 YIlRDA/vGtRgHuczjcQhlGNfmC9CFA0iHJ6jPgFys49eptKW1UldZ6txbpj21mHidQLiXJX7n
 Yms3A9cVEM0Z+3aGiumLPzu/H/RAOsqw3WI0E66PAJJLKCYu8Bg57bN5gSMNIuviN9aODQ82f
 4UY0zXa7xBpaBtGigfSI8KshIrIA8HZPnoo2H5NYr9ewbmUcgJFehBjqEuO3LFbxVjLkcqewa
 8YFjRE7yiFot8kzCfvrn4ksEoRXHwA6cKEYYznCFfiY951OBJM8GE+geJOsjI4tXn6nXeX2fw
 PZh85ts6lLOlfcW2ap8vu4XT9DkhCReDMPfP0TpwVheGh9wbjUkklZvZFBa0BXdYjQRgywmli
 Hbkznf3aG0gK90/yzC0b6tL3Txuv0Vztne+mzbh4gB0nSg7HtXGT1a/DvSsaPSFC6u3AI2RiD
 GJxHt/tqfxeLdessIHywYrz/f6TQomDuLhpjEmo2RC09pxoWdRdHDPzYQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Build a typed sort function for the mergesort performance test tool
using DEFINE_LIST_SORT instead of calling llist_mergesort().  This gets
rid of the next pointer accessor functions and improves the performance
at the cost of a slightly higher object text size.

Before:
0071.12: llist_mergesort() unsorted    0.24(0.22+0.01)
0071.14: llist_mergesort() sorted      0.12(0.10+0.01)
0071.16: llist_mergesort() reversed    0.12(0.10+0.01)

__TEXT	__DATA	__OBJC	others	dec	hex
6407	276	0	24701	31384	7a98	t/helper/test-mergesort.o

With this patch:
0071.12: DEFINE_LIST_SORT unsorted     0.22(0.21+0.01)
0071.14: DEFINE_LIST_SORT sorted       0.11(0.10+0.01)
0071.16: DEFINE_LIST_SORT reversed     0.11(0.10+0.01)

__TEXT	__DATA	__OBJC	others	dec	hex
6615	276	0	25832	32723	7fd3	t/helper/test-mergesort.o

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-mergesort.c | 15 +++------------
 t/perf/p0071-sort.sh      |  4 ++--
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 93d15d59a1..202e54a7ff 100644
=2D-- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -13,19 +13,10 @@ struct line {
 	struct line *next;
 };

-static void *get_next(const void *a)
-{
-	return ((const struct line *)a)->next;
-}
-
-static void set_next(void *a, void *b)
-{
-	((struct line *)a)->next =3D b;
-}
+DEFINE_LIST_SORT(static, sort_lines, struct line, next);

-static int compare_strings(const void *a, const void *b)
+static int compare_strings(const struct line *x, const struct line *y)
 {
-	const struct line *x =3D a, *y =3D b;
 	return strcmp(x->text, y->text);
 }

@@ -47,7 +38,7 @@ static int sort_stdin(void)
 		p =3D line;
 	}

-	lines =3D llist_mergesort(lines, get_next, set_next, compare_strings);
+	sort_lines(&lines, compare_strings);

 	while (lines) {
 		puts(lines->text);
diff --git a/t/perf/p0071-sort.sh b/t/perf/p0071-sort.sh
index ed366e2e12..ae4ddac864 100755
=2D-- a/t/perf/p0071-sort.sh
+++ b/t/perf/p0071-sort.sh
@@ -40,11 +40,11 @@ done

 for file in unsorted sorted reversed
 do
-	test_perf "llist_mergesort() $file" "
+	test_perf "DEFINE_LIST_SORT $file" "
 		test-tool mergesort sort <$file >actual
 	"

-	test_expect_success "llist_mergesort() $file sorts like sort(1)" "
+	test_expect_success "DEFINE_LIST_SORT $file sorts like sort(1)" "
 		test_cmp_bin sorted actual
 	"
 done
=2D-
2.37.1

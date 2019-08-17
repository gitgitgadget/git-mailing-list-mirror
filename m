Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 177411F461
	for <e@80x24.org>; Sat, 17 Aug 2019 16:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfHQQY1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 12:24:27 -0400
Received: from mout.web.de ([212.227.15.3]:34907 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfHQQY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 12:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566059063;
        bh=DBvufhzjQItO41/xuB1YvDY/dZ+FA08yyk9LRsiF5xE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=n46L8AgMH78BLuNvKaFsliVwiMYDoTinVdUn2MS4BBstQO3j3sFd0+Itoi/FPW4j1
         WuAiU+g9xHv7ZS0O8ihf1hqwZ1obpx7I/TveOQ/4Aq0grSHHZ/gWv22H+LsmdRaBzt
         fm4mOuj2KGvPXFpOsEdmlcIQq8iltWNITUaoG7lg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6UmJ-1iB3u82rff-00ySDi; Sat, 17
 Aug 2019 18:24:23 +0200
Subject: [PATCH 4/4] archive-tar: turn length miscalculation warning into BUG
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <c77a0081-93ab-7b97-e322-9616f6e7f86c@web.de>
Message-ID: <f5ad09f8-9da5-9567-afe0-f1379bd9192b@web.de>
Date:   Sat, 17 Aug 2019 18:24:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c77a0081-93ab-7b97-e322-9616f6e7f86c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/qtC+MfUG9Dyk2ZHkc/5vAcUaNjAlUMj/YimXBx1V7rpWvL7W32
 BUwSMiUTNx/wlG+uChXMdhzNIWoJVBG9icJiYCM1z7yb1Q2ebRs0qyRq8WByeJ7tw85HG9A
 gITGNFg8IiYwPinnH28aAWve/Nx/lnldIc77D6jVQX6ptKfd8TTNh9/aIHJB2bI7Lwh5rwq
 ehtDpGyf31vFxd2YQc2ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hR/fAzriNMU=:AEtuPcGCkqSUK2YP8dUaoL
 TPEU4eKV5FqAXfWqZEfPIS8e6V/z66kqRT1gwF32o0qbWBFOd4l5AY2LBchfr8m6O9Xdg3wov
 mb0EwTUhbDXeTyoriQ9lkun775M/85y+9NDCaCktHBkDg0NeCpoE/pcmP+3KwSEEik99jv2mK
 18WjX7NLoltCA8xXxfKIclHDbQunxqZkmWqabaXOjWRrzRMXm8yTTo1HzsV4+acCBeBfS2M1I
 5nP2v2zgbtEJNSpmG/Bhun7hzptbIsIt08P6DtdzAfqXbKIeRB8KhWEQe2Q76x70y0Xw+g0Rg
 /fKesrmSWOb4fysNR2VfczW8h3gvkueANBx7TlGiSGUnNwlgW6/Z4mXxaY8zchC0iwKInU3lm
 nR9PGyUyxt9/xWnqRRPWbEVak5UE8N3w2mEXjYyZfe9bbS4QkwKCd9Fh5dsQuCnPGePvBKcaa
 NoRKzjiiHGYILAVIRDKNmGfvZ4KrNi71PjytN8WwB4R67kwWJzb9VIXzpgMHJ60hZbtfAGzGz
 R3+Z2+RCrG2nC9vrCiT1zsTYFQse63rFZ+BJpbN11f3MIcwqJI87kkC1fwapaoEpMAZ6DworS
 7gwlJ32ZGzbfJkn/yIw0+KqBRRrBxdD3cip69ICax72EM/gTh9DJmfq6TDr0ZlsuR0ISuKHfW
 Kpy77HNISqpRXlryodtaSwr53D9Di/t+xztlga60Ye0b9ppYLF3x4G3rzcadyVILh8ruMK7oz
 nzPkbuRPyCRo0f691K3f3ZnjeaHfk95CiMVOP7+c8hfJJQts4evjmA9OyMm22Gqeg7UjXFTRM
 v84HSeK0IPNbZx2svElUhldiZn4qMrOyTv8lgM7gC+NA08VU9uA6arJzt/erKeNOIyIMLF//l
 PANedIFbm6oNesdEnibcksO6K/RJ5hzo3MR+s27qYk7t0g24faRKIPk0ZUiheq/UlzszpndTo
 CX6xv1ALcbdMIIXkaq/+WbWnfVTCqm7G7+Ypvo+05wSi74J3YJmR+fsGEfCdyQ0fJOC3xvZBg
 hXtdF0GvOIUWTFAlSDozc58zl/3mOpGr1I3Npsbs79ZlEp2lz2XnAsuAcQhKViyqWurxKdeVi
 ZrmlNe5PULt52zajomPRmrwAQGaiaLcnpQVyWHXNxdFKzDbWMq43goB5aczLDMTrTQCDqLhp2
 k8VlR4I7uZPvcMWMO1wiiPBpbB6GQEKRmhe2czOhlpBZ6Gkg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we're confident our pax extended header calculation is correct,
turn the criticality of the assertion up to the maximum, from warning
right up to BUG.  Simplify the test, as the stderr comparison step would
not be reached in case the BUG message is triggered.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-tar.c                   | 6 +++---
 t/t5004-archive-corner-cases.sh | 3 +--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 9d09edd547..e16d3f756d 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -158,9 +158,9 @@ static void strbuf_append_ext_header(struct strbuf *sb=
, const char *keyword,
 	strbuf_addch(sb, '\n');

 	if (len !=3D sb->len - orig_len)
-		warning("pax extended header length miscalculated as %"PRIuMAX
-			", should be %"PRIuMAX,
-			(uintmax_t)len, (uintmax_t)(sb->len - orig_len));
+		BUG("pax extended header length miscalculated as %"PRIuMAX
+		    ", should be %"PRIuMAX,
+		    (uintmax_t)len, (uintmax_t)(sb->len - orig_len));
 }

 /*
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-case=
s.sh
index 4966a74b4d..3e7b23cb32 100755
=2D-- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -220,8 +220,7 @@ build_tree() {
 test_expect_success 'tar archive with long paths' '
 	blob=3D$(echo foo | git hash-object -w --stdin) &&
 	tree=3D$(build_tree $blob | git mktree) &&
-	git archive -o long_paths.tar $tree 2>stderr &&
-	test_must_be_empty stderr
+	git archive -o long_paths.tar $tree
 '

 test_done
=2D-
2.23.0

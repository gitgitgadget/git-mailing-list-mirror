Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45A861F991
	for <e@80x24.org>; Tue,  8 Aug 2017 06:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbdHHGxf (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 02:53:35 -0400
Received: from mout.web.de ([212.227.15.14]:57928 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751918AbdHHGxe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 02:53:34 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPowc-1dju4t2d2A-0053ey; Tue, 08
 Aug 2017 08:53:25 +0200
To:     Git List <git@vger.kernel.org>
Cc:     David Coppa <dcoppa@openbsd.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t4062: stop using repetition in regex
Message-ID: <861dc875-7300-fe5a-1360-0ed546c8c2bb@web.de>
Date:   Tue, 8 Aug 2017 08:53:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:gJPy/rXTVgljA5zgEXvBxDGCe8MXSzblPjSW+IPO1nEwd6TwlvQ
 UrAJ2drfKueSBg2df2AU+CbC+6wQJO3+VDbbbZ5oPBvBdx5RJa4w/1icCaEeSE6YmyQ5d2v
 lHUP9+TmXNzRhR3nniDbW6rjr00zJLVS4c2fPWoSvquKwOqkoGi/joBQkCpVr1quvZp4dhR
 OuAxV8MI/rXyDVW4odfRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e51SwjA61To=:yX5Q9o7tZFLTbrH/j8pO+W
 HptITvC8WiSBMn4llZsPB8kwuVwVulU6MtIwFLONckYHRXYZPKpmEQPYclbSZZz3L32N7crxU
 RW/tCOxPTgNCvv/J93mbVgfmKyusXOHL05Hcq/yAiZ8GKtxbFj1oiDIYRqSDPIjNIuIjBJSRr
 RP15oyeMrpzjXkrjT/SvBIANK7M7hstpD1EEBTz9Ic22L+vfvVdA3+MZozf2k3Pq3sJATFbG3
 XPvvGFi+8/VV7GyWfIXiuEjlz97rYH7f/7NvIYJg2A+lXKPsPmTDsqazHiaUz604oCi4EYZ7o
 8ogD5KxVjysNIficSLwSZRTGSQDH0UlpLHqw1V8dgea5eVbPVBS7YuPtdqvI672DzahETXHZh
 NaMZKMA1znObqLGpu/eQEG/Gc+UurA/v2HSTXMf7Ojoqs3d8QyhXtFwjJ6eJ+KekvXE5bmVJ+
 gzmV+ML2ICdftvvLIUpdo9TB895yWjL8ztSL4AvlOgUDy7rYI7IbKzRt4fV/QNpLxl3vAsLFl
 GM/ZJlrw1TCjR48XF9+llIGS7bot/m3Cg3NwAr+9sV7XksI6O0kBcN5j4vuhl4kFflacNzeIi
 qIcSesf8a/c5Ss6AaUWkDilwb43YKL2zUoYkw/01JpHPT558zQY5hZ5eYoEXKbD07FdDIo9EA
 KEUwKvpLad+fzQA5C/Jtsbq7vLFZeS0+Gwr8lnxgnLVfHR77cJlAwXx5PBngqapeBD1kAYDXa
 fRbFe8H4wJR/cTX7r+FjIO6RSG83t1Z9UTFQZmr36Ve6XiBXsTZCiF7SifRGXFikPVbL5IXph
 o2+AYQqjXf+Do2CNGjKjtuSv4gXoBqFS4Hs3lvMNwXQ2TkAX4A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OpenBSD's regex library has a repetition limit (RE_DUP_MAX) of 255.
That's the minimum acceptable value according to POSIX.  In t4062 we use
4096 repetitions in the test "-G matches", though, causing it to fail.

Do the same as the test "-S --pickaxe-regex" in the same file and search
for a single zero instead.  That still suffices to trigger the buffer
overrun in older versions (checked with b7d36ffca02^ and --valgrind on
Linux), simplifies the test a bit, and avoids exceeding OpenBSD's limit.

Original-patch-by: David Coppa <dcoppa@openbsd.org>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4062-diff-pickaxe.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4062-diff-pickaxe.sh b/t/t4062-diff-pickaxe.sh
index 7c4903f497..c16e5af6fa 100755
--- a/t/t4062-diff-pickaxe.sh
+++ b/t/t4062-diff-pickaxe.sh
@@ -15,7 +15,7 @@ test_expect_success setup '
 	git commit -m "A 4k file"
 '
 test_expect_success '-G matches' '
-	git diff --name-only -G "^0{4096}$" HEAD^ >out &&
+	git diff --name-only -G0 HEAD^ >out &&
 	test 4096-zeroes.txt = "$(cat out)"
 '
 
-- 
2.14.0

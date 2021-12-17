Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CE4C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbhLQQtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:49:01 -0500
Received: from mout.web.de ([212.227.17.12]:35987 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235967AbhLQQtA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 11:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1639759733;
        bh=gIji6OaX1j7ExGF60pI3HsZx0wdjaVPcaAU7Nz94QkE=;
        h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
        b=ns3Foq76Xkx2rcWrR4A0q1mRBqZv3ifXlfjpESOn/fu4MIA1M2zhgCmk3pywQxC9J
         vk+ypIezYDCbaDdta548IBMBn4WgVyTbp7SGuXNwCPh7HAoocofrZMP9twsxrb7ac5
         25WgmHTWBJBx3FCkXDxDF0sbM51yuJ2zuerE6meA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6sFx-1mQr2g2RVX-0183es; Fri, 17
 Dec 2021 17:48:53 +0100
Message-ID: <79dcebc0-e569-cc8a-4702-c572b062ed6d@web.de>
Date:   Fri, 17 Dec 2021 17:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t4202: fix patternType setting in --invert-grep test
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rBdHUj0cYoCWGCwFM29E1zcLSFsobGFqsrzO6sVYGunSrTqc1bf
 m2u/Z2GJ6t3+bmOtFGtqLWL/r/DUlGwK7LuOkiQdBchmoiXBRcCUkJiqOUDNaOjF4fpZq1o
 S1hcEa5bB1H+pC90W8tJZ0w4qRryuFi0zw526qJENmIhLjQhKz7jyEUHDlNA28jQip0ahjf
 5M362Zrk/wg3l70Xx7pKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9uAlyla8pL4=:T0qjzj7aB0SE9HvI7d0Edn
 nqnb9LRCCsuXZxZzjfZixsWMBZY+857RpW5dbugzRnQvzCaGZqvQNUY0j43fcELVr9D5Mjrvi
 iKhoFPHAsLqwZ14aSuj1L3NNSYzAQRuzOm1uD9KC2KJWFE/hhLgQTkjEh2mYWQzsVwb1wjN3m
 qcidm7Cn1QEpU8DktgVjRMtMQkqXmCr7ODY6Nea/Nqh4wvant5z00StmF8JE8fhHMod7MAoyy
 1jfNPC0xTZka/IRemWaISek2zsta/zuF2BmHXsxyCtNAirJwU1m+vZigahmBd0nDIXUeYDCib
 LJlWfM1BaX50wHucSED5u2E63jGcVL9mawN1XzVoqYQ9MEXvwJKqxWDCUtbuJphN4QVjDRc/I
 oknrcV/SyQpayl3ZJzrHgY63o2NQxxmRuC4Wkw2hJKtPKZqhbt/rEJBd7TBegBLNuuVcygux9
 5wzcFdhxGil9cb9V56w4nbitA7PKqnMSCAtLZTtSkkrQnDybp/Yzagt24Itkr3hnOFOt6elLR
 h0ShCxTN29wpaX1yzmwXUFiLCKyWK6KCpaZVG8H5Zq9YzGt6AQ4iEO9OZLlYRyje8MZo1+EHE
 7WMjAQNhzL2hk10/vo00VAJ9OYwtk+jWAps0eZWfZEIidPmBZDqTxZyGgOYs1NNyk5pGWY0Wj
 3IeXyr12tCzzGsYc8BjL3MUn5Pbwd0q9J6fdCC5C8l35lgtLULoqx17xJHxzO0imlq2mWVH1w
 PHYdHhK5UHJ1NYuRxgO2FLXu6YlzIVfZkDAmj3jHiJfugoTzJE6TkK+ltZxUPBhiCB5/wq2dL
 5lVvd2qVlN6kaD5vLAbo4/8T/h2HSZ936U2FR/ZRtfMz1Ds0xZyzVZHbvBPnL9LkNR4MczOFn
 a6C9oTZMefBigD6gBpikcGCnsYRKBRzg8WISovafyqBJtMXSN9cnzXIbg+rHcXe+cYrLhHpgE
 PtUdJKFIKlh/0a6CmR1DKcyczQU+w+Cn2m7iAyHzATfhMUQjZQdWQCG2fJBTZnDS1q9ewCkJV
 miry8TjMB5PQDSmew0QlCI6CoVFBhe/zPknwG0orn8Wazg9IggQUe/PbQTL0GlB1pw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Actually use extended regexes as indicated in the comment.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t4202-log.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7884e3d46b..f51b57b4a2 100755
=2D-- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -250,7 +250,7 @@ test_expect_success 'log --invert-grep --grep' '
 	test_cmp expect actual &&

 	# POSIX extended
-	git -c grep.patternType=3Dbasic log --pretty=3D"tformat:%s" --invert-gre=
p --grep=3Dt[h] --grep=3DS[e]c >actual &&
+	git -c grep.patternType=3Dextended log --pretty=3D"tformat:%s" --invert-=
grep --grep=3Dt[h] --grep=3DS[e]c >actual &&
 	test_cmp expect actual &&

 	# PCRE
=2D-
2.34.0

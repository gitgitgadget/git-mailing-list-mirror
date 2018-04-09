Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63551F424
	for <e@80x24.org>; Mon,  9 Apr 2018 08:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeDIIbw (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 04:31:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:54247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbeDIIbu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 04:31:50 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M34eJ-1eF8Xd4A35-00sw6a; Mon, 09
 Apr 2018 10:31:39 +0200
Date:   Mon, 9 Apr 2018 10:31:39 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Phil Haack <haacked@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 05/15] t1300: avoid relying on a bug
In-Reply-To: <cover.1523262449.git.johannes.schindelin@gmx.de>
Message-ID: <4c8159bd9d77f7e21052e9c9b453f47b83847885.1523262449.git.johannes.schindelin@gmx.de>
References: <cover.1522772789.git.johannes.schindelin@gmx.de> <cover.1523262449.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HMWlw0hQp4qFt4iqrNHL2kMIGzwN/00opJP60/7A6FhlzD4j2wi
 qcYFbMBa+a1XfPIJuIs/c6Whjcs3pbG27b0yIvdidULQza6oM5vVZMQadoXwyN8j8cr9vu8
 UOi4GDf7bNAZ2phjB09fDUOe/kllb/Tj2VnPqo0kKU7cHGxKGG5Vxwl8RBbj+oaPye0zevX
 8OA/O4kiQ1+FrB4dja4Eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mh3EokLSCwA=:7WZmorXSvNy60UqTCFw/YY
 Zan5Uqt6qBZubCYZUGg+9i713Z0Xra2mUcMY2f5VGgTm7ZzD0XU0JDzNZfAWiAwZ6ThJ6N2R4
 WJ84BG493+Qi8BGYs/cGuqOjPoqpZo+1Vd8qSJjWX87YU3nZzkBGY1FHGElOnExn4t9mgVlKH
 FXru2XFOd1QTMSibe6SVjYmq5kwfnl6SlMKRTZQbptycjjzLL4DamklRzA9ik+KipiMKvrrrT
 lbnPUmU9YRv4ccHph/rJ7yESziAbCnvmleDpZzj0OvWgRT9LYb8fScESb4zxviYVdZ7H8C+7c
 CiXTy7Ppd+Kym/fEft9ITWnAm6Jnh7lDUGijQUaQavuW8wnLXkjXv9VzmDw0bZO6b5/70B9om
 Mw044aBb7+tUog0Hw72RFJ615g+3XZmluLVRudd7Ia1QK+aCnCAyviqihQt1JKThZkeRMefdo
 VEJsxsJtsOQC7ks0B/SPeS+85Ng+13gkZ1PZNZ0ysOdTpbOnkko0nHUcE9kawLV6nEnlQV0a7
 9Rni+7IRBa4K85WVW3ePNX3VS+6uZIeD4Asw8OXHoANwlEFOWrM9JzYsYEPP+C51njOe1QZRQ
 jU9e79tnFd1exiKDyodPLMaNtzwBZp+6gUB3RIpFa/1ecVekpf2dY6EIHM4FSqQGCLQ0U5KiA
 kRa56+HN37P7tuDnLid327ETpB6dfkB5lhITVvRzuIEK8Nvj6pbgHYP8PnNYXnS58APmAWrwa
 fl4QozUUCAp1oOc2fTw5jt+83FpzOfyKTTqp+OHp5fGmrFo0YD0KJichSNJ1Je5G+rNvyRHid
 oJTHG1fvdMFqPk6EVKQy0lFSlS1pRh4EMHXTompJtpYtuFBk38=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test case 'unset with cont. lines' relied on a bug that is about to
be fixed: it tests *explicitly* that removing the last entry from a
config section leaves an *empty* section behind.

Let's fix this test case not to rely on that behavior, simply by
preventing the section from becoming empty.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-config.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index aed12be492f..7c0ee208dea 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -108,6 +108,7 @@ bar = foo
 [beta]
 baz = multiple \
 lines
+foo = bar
 EOF
 
 test_expect_success 'unset with cont. lines' '
@@ -118,6 +119,7 @@ cat > expect <<\EOF
 [alpha]
 bar = foo
 [beta]
+foo = bar
 EOF
 
 test_expect_success 'unset with cont. lines is correct' 'test_cmp expect .git/config'
-- 
2.17.0.windows.1.4.g7e4058d72e3



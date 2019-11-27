Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3B6C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBD3206F0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 12:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ae4zqwFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfK0Ms4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:48:56 -0500
Received: from mout.web.de ([212.227.15.4]:42375 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfK0Ms4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 07:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574858932;
        bh=a3ueAu3JhOntyJ2MwYFJ+hZUx0fNmXszYvm8QOwr/Rg=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=ae4zqwFX+usXxhQfovjuVVvzW+M9j2jmxDoXP7OPhIlouxbKilIS3U2Kelom1lTHb
         bNRTICNmpn8moZJEMeHa+v5ytfzZ8nVuW61shOWX1X7oJzL29taiPN9voubRqtJwpu
         JjWimpARIcIsdRaeZnJfO8PwLTFUxHixRUebXAMI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhULy-1iDJYc0kuA-00MYjB; Wed, 27
 Nov 2019 13:48:52 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t9300: don't create unused file
Message-ID: <7df56c8a-f35a-0f35-102a-b70ebd803c9c@web.de>
Date:   Wed, 27 Nov 2019 13:48:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PCzs0G/4eTPxeCmR7J82ZEhl8HYBmf+dxx0Htr3VVdj7q3FPrVl
 JUx5TVbnMXftUo+KPiv6WIY9jGHmQM7WrjP8geRaRgtsatQOelQF4BZntPxhhLWlVKU1oLJ
 CmJXTdAdpuYlk/NXAXPxHXTFjU3rWWvHlJq4m7s934hm191kQpDKB/zWXA6MuJ5OgquS05Z
 yxvgGvCzuVBZfbi373aWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K3QJSsJIb+4=:v1JRD7Ug4Ct0DgJaQYkPjo
 7yfj3p+5RcZfzBqal363hoEkcbv6a+venvXbSfzsAP6gl25VhRro9AbO6AR+pMg/Dq2zA06Qs
 0f4XhG72XzcUIs/uIRkpFB338wZEDKSXwHq2hYiuY1tDXAYtr8dF+vgnfdQl5nXsSol9CBuZG
 BP20bhyl3ueTEnm64Py2OeYO+0H6u7SOYmb+ZD5xQmyXFbsygslF8Et07j8JV3K205HopwoSU
 T4aCona77XIntVSWEWVucMMPlR0MuvudfSoFo9fDMszytcUwuZ4eyxgmTunnv7tAOF0Mz+VhS
 +X1pZxR0mm9tXgWhE4DlmVkGeTE9HMw7GhnUuY+phVchNdCSRIDaHJGZ8EmFDdv9q5x7UYQQ2
 +9VswHqtlaP2twlLAa262LOdcjLpFvFgQpXTZzfGpxMaLKUyxaBJoPGIyrFKlFbvk0z44k4u7
 yaqfq0yvIdH33PKdcQcSBGvAQEsBHCSK5OIaHd4q/f2W9H9k203tWms64W2d6j+AGcPY57FyV
 raHxS5TP2gcpxMETD7rwegvdqmB2+2jhaYTGKNSsWnqsApsdnNpQ+YYUMgHs/JIblvG9WBrKU
 6f3VZpYBTBdpicoGhLGTqhVrmARwIAg17mnYw2giglyF/Bgu5Fr4PIWLpsjWX+Mqb1NyEHXNC
 gmad6jhUagsV60pjHiqfOVSPohcEpj90czcAvPTLOshB0DxXtT/EnRclgUmBzMk1dHO2Q7d8c
 7nIQWmgvMe6lnb5aJp6U5RFMMlZ8DmO1g2yPBRGUUy1I/7eZoDul0/dnG2fbzKpvDnRd+qYVD
 i+B8B6GbNDPGx0psFwjkMi6l9W50AxpIc2cvrLmbho0XhsIv8p9c76WcZq+8rLGPeYs0DqfZP
 9mGJDkSO3Oow4GI74yX+ORPr9Nuo7WECkyvX0xMsTDDidGJu+/c3TIVufPB65HLzfZJXivaqo
 0tnFeT6zuJD40H53fU41mdaVLNlBvsGSs09tp69EsVKe+jMT8pbt6QIxPPrwtlYlChbwNZDyB
 DdSsyP5O4zlSnfe7HQJANDrYpVwWm83UFz+vvVIvKRniJzj/45z/l0mJ3gMCT6rl7CrFOCQl7
 1cetpcpxz//AhnOD00YWf2Fg9LV9V20CNY1x8nWx65iQ/sLQoO0RRXrJmlh5kbUT/XqazVi5T
 DLhcFCFTuvZC33YeA6alQs/nPPFj5iukWYHPBt2rN7869rhEHM6N1dK7j+V8/fGjIHHXAfLng
 LSkIUbLkNQSBi6Q7HrEml1SEnalNqRG9PCf52mw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The file "frontend" became unused with 4de0bbd898 (t9300: use perl
"head -c" clone in place of "dd bs=3D1 count=3D16000" kluge, 2010-12-13);
get rid of it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t9300-fast-import.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e707fb861e..062d599423 100755
=2D-- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2477,9 +2477,6 @@ test_expect_success PIPE 'R: copy using cat-file' '
 	echo $expect_id blob $expect_len >expect.response &&

 	rm -f blobs &&
-	cat >frontend <<-\FRONTEND_END &&
-	#!/bin/sh
-	FRONTEND_END

 	mkfifo blobs &&
 	(
=2D-
2.24.0

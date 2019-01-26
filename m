Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399FC1F453
	for <e@80x24.org>; Sat, 26 Jan 2019 21:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfAZVDR (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 16:03:17 -0500
Received: from avasout05.plus.net ([84.93.230.250]:51666 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAZVDR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 16:03:17 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id nV6fg69JtuQOBnV6ig5n0e; Sat, 26 Jan 2019 21:03:16 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=JtDfUvwC c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=HwVATwgoNOUDAL2-MZoA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] test-xml-encode: fix sparse NULL pointer warnings
Message-ID: <68a8c70e-dc42-1df3-3616-c096f63cb848@ramsayjones.plus.com>
Date:   Sat, 26 Jan 2019 21:03:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFxgeYJ+KNTzajkM+sPaUEQUo6V4EXJCJy+fBTx4KYkgeeSkSXZfekwI7x6w0D92pfNrfz6EAKmVjk8is6LBHiRT7hynvb8g0akw+3sPZE+PcM4Rn7qp
 HZRTtjoyNiKI+7hNmBI/c9W7Ip6LsGM8mg3EQnTNmgHtpRf+5kA3MywoW6FI+FHp7yO01kmH0e1ErA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Johannes,

If you need to re-roll your 'js/vsts-ci' branch, could you please
squash this into the relevant patch (commit af7747e7c7 ("tests: optionally
write results as JUnit-style .xml", 2019-01-23)).

Thanks!

ATB,
Ramsay Jones

 t/helper/test-xml-encode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-xml-encode.c b/t/helper/test-xml-encode.c
index 367c4875e6..a648bbd961 100644
--- a/t/helper/test-xml-encode.c
+++ b/t/helper/test-xml-encode.c
@@ -26,7 +26,7 @@ int cmd__xml_encode(int argc, const char **argv)
 		if (tmp2) {
 			if ((ch & 0xc0) != 0x80) {
 				fputs(utf8_replace_character, stdout);
-				tmp2 = 0;
+				tmp2 = NULL;
 				cur--;
 				continue;
 			}
@@ -34,7 +34,7 @@ int cmd__xml_encode(int argc, const char **argv)
 			tmp2++;
 			if (--remaining == 0) {
 				fwrite(tmp, tmp2 - tmp, 1, stdout);
-				tmp2 = 0;
+				tmp2 = NULL;
 			}
 			continue;
 		}
-- 
2.20.0

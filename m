Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF733203EA
	for <e@80x24.org>; Thu, 22 Dec 2016 17:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966441AbcLVRJg (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 12:09:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:64199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966435AbcLVRJf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 12:09:35 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MW9TR-1c56Aa3zlx-00XO93; Thu, 22
 Dec 2016 18:09:14 +0100
Date:   Thu, 22 Dec 2016 18:08:57 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 1/3] mingw: adjust is_console() to work with stdin
In-Reply-To: <cover.1482426497.git.johannes.schindelin@gmx.de>
Message-ID: <ca4c61c603247c8ad0b876b068f6cd41fbe01667.1482426497.git.johannes.schindelin@gmx.de>
References: <cover.1482342791.git.johannes.schindelin@gmx.de> <cover.1482426497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KVZLVvZSg8uUfyMD+dRLja9xkPgAVo5d+Nck3gTrqmwCxfDxGVH
 gH/p4UdDBJxdpSrd4V21WDqvFlEQ0/noQKJgUc/cBHk363MirhyW81QQwGEbTX4haMnYB8J
 hoW7P2Bf/IPPNpqEWubd+CadptaMMFt35IiNDL+8Zlun2ioUP/8/JxHtoDrccsyJzzbfdhV
 ELn+scnAHPXZC47YmrOIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5B0Q27yaRys=:NfAAO4j+/8vEKQAtmX2cuQ
 WF/yl+X1jGncxrh/hDLR8JkSn5q7PFcgR/C/KkzddHuWY5pj6XGSTZrpyCsu8xAOOeLDdys5D
 tiDi0WiTTWfBNTF2WdtxvZ/UEaIutjjhLinKeB5dZhCwsQdgV6T0+x54hkErg3oGB95/ria5q
 igDcfcbr9R/nXxgmXRy7mOmgCCPEU8SpOSyXhEEBvGrRE2xrVKvXtlfk8LsuPerYC8V3dpwal
 wqNmurOcQ16XUgXEaDzPIEda9ivbqilubCLA4LyxkJLKnjsKFh39tl0IVaZnvKMVRaDxpeZUY
 M3MzWI07++LfkJdLc5UcspQ1T7HiKbg6N8iReB2LiKLvuj9S2dDbCJpJ9Dtm898yPvPBpA6TG
 aNpzV7011oxu6sOc46AXJ+Nvcx1ugpOIz4DA8BFQLaCF91zgTfgXhhP4Q/HgKITlbBWoB/H3A
 VUQ17mwq2atpYU+EONwuL2ZB+sSaWi2Ws72jB074Li0mbW74ZKUhe1JoKMFMDPv+97khs2GVL
 bawsdUk1JDJO66pyXwfEjnfm4vk9l7iRnUwj4e+fg6Z54LiioW5EbWZym322rZudZJgcPoHry
 /4LhDtTiTyDyOebtdvz3/cW0jK2uook1IRkGvJ3svT0gVhi9XDbbGYafFivbwpvCH0JzXpDfY
 Heuf+kzkofWhVLKlOyE4tIpcT0bi5i5SeYa9dAAk58378v0F9DPcTEWA0e0LcM+gpfp6Kp+Ln
 V4aycPp/C64dL2UYiGYeayQz1cAgPdzp4R+YxE2MrXHNBP27/DSSloUWH4bOAEy6X3U/uX2Q4
 XIiQSQceyUNK59pONnpxOFAQs61/ThxPEtgnMiUHb5MYFAPjcTr+OEM1wFTDM4Nnly89maat+
 evb8WKCJx6V2xg4GAgYkuGVQxd+Gbpve0iiucSpiGNYzHfOoAQemiWV3O+dR66qlTKqm28vFw
 ClmtEQLXcRdTn9b6yNXbphJq6CVpm7Lcug2oyXwNx7WENn3UYy/cbOM/KS6OhGJYAsRlatc4h
 TBgPiUA3h4g6Pd/uSleGCqI/5a31kE0tDlCchdISP7DYa5mvpy8dy2W1YpAat0CRSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When determining whether a handle corresponds to a *real* Win32 Console
(as opposed to, say, a character device such as /dev/null), we use the
GetConsoleOutputBufferInfo() function as a tell-tale.

However, that does not work for *input* handles associated with a
console. Let's just use the GetConsoleMode() function for input handles,
and since it does not work on output handles fall back to the previous
method for those.

This patch prepares for using is_console() instead of my previous
misguided attempt in cbb3f3c9b1 (mingw: intercept isatty() to handle
/dev/null as Git expects it, 2016-12-11) that broke everything on
Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index cb725fb02f..590d61cb1b 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -84,6 +84,7 @@ static void warn_if_raster_font(void)
 static int is_console(int fd)
 {
 	CONSOLE_SCREEN_BUFFER_INFO sbi;
+	DWORD mode;
 	HANDLE hcon;
 
 	static int initialized = 0;
@@ -98,7 +99,10 @@ static int is_console(int fd)
 		return 0;
 
 	/* check if its a handle to a console output screen buffer */
-	if (!GetConsoleScreenBufferInfo(hcon, &sbi))
+	if (!fd) {
+		if (!GetConsoleMode(hcon, &mode))
+			return 0;
+	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
 		return 0;
 
 	/* initialize attributes */
-- 
2.11.0.rc3.windows.1



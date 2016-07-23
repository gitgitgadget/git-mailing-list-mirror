Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A805B203E1
	for <e@80x24.org>; Sat, 23 Jul 2016 08:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbcGWIjv (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 04:39:51 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:55224 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbcGWIjr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 04:39:47 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rxLYD3szSz5tlC;
	Sat, 23 Jul 2016 10:39:44 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 0785952D7;
	Sat, 23 Jul 2016 10:39:43 +0200 (CEST)
Subject: [PATCH v2 ew/daemon-socket-keepalive] Windows: add missing definition
 of ENOTSOCK
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
References: <28dbe3b0-7a16-1b87-3d59-b8c981fead7c@kdbg.org>
 <alpine.DEB.2.20.1607221020520.14111@virtualbox>
 <xmqqmvl9a2wc.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607230957320.14111@virtualbox>
Cc:	Git Mailing List <git@vger.kernel.org>,
	git-for-windows <git-for-windows@googlegroups.com>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <4ca7ee51-351b-d222-d05a-63c5bdc5c383@kdbg.org>
Date:	Sat, 23 Jul 2016 10:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1607230957320.14111@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The previous commit introduced the first use of ENOTSOCK. This macro is
not available on Windows. Define it as WSAENOTSOCK because that is the
corresponding error value reported by the Windows versions of socket
functions.

For details, see
https://msdn.microsoft.com/en-us/library/windows/desktop/ms740476.aspx

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 Same patch text, but the commit message is amended, just in case it's
 easier for you to apply a new patch than to amend a queued one.

 Thanks everybody.

 compat/mingw.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index 233933e..95e128f 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -73,6 +73,9 @@ typedef int pid_t;
 #ifndef ECONNABORTED
 #define ECONNABORTED WSAECONNABORTED
 #endif
+#ifndef ENOTSOCK
+#define ENOTSOCK WSAENOTSOCK
+#endif

 struct passwd {
     char *pw_name;
-- 
2.9.0.443.ga8520ad


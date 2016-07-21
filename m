Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A48B203C5
	for <e@80x24.org>; Thu, 21 Jul 2016 20:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754120AbcGUU7L (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 16:59:11 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:19708 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754088AbcGUU7K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 16:59:10 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rwR3H0mwRz5tlG;
	Thu, 21 Jul 2016 22:59:07 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 575DD29CF;
	Thu, 21 Jul 2016 22:59:06 +0200 (CEST)
To:	Git Mailing List <git@vger.kernel.org>
Cc:	git-for-windows <git-for-windows@googlegroups.com>
From:	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH ew/daemon-socket-keepalive] Windows: add missing definition of
 ENOTSOCK
Message-ID: <28dbe3b0-7a16-1b87-3d59-b8c981fead7c@kdbg.org>
Date:	Thu, 21 Jul 2016 22:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The previous commit introduced the first use of ENOTSOCK. This macro is
not available on Windows. Define it as WSAENOTSOCK because that is the
corresponding error value reported by the Windows versions of socket
functions.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
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


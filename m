Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 722F5207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966692AbdDZT3z (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:29:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:50047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966690AbdDZT3u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:29:50 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LobGI-1djfHI15Io-00gUeY; Wed, 26
 Apr 2017 21:29:42 +0200
Date:   Wed, 26 Apr 2017 21:29:42 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v6 8/8] Use uintmax_t for timestamps
In-Reply-To: <cover.1493234408.git.johannes.schindelin@gmx.de>
Message-ID: <7f9b6db618742a6dae6c491ba52dbe1f9a2bf745.1493234408.git.johannes.schindelin@gmx.de>
References: <cover.1493042239.git.johannes.schindelin@gmx.de> <cover.1493234408.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KRvzbes7WCYms+F0s3dUqhxlZZG7siI1I+ot6kSiXgSxubpXR+R
 aR0/zebHFzsb/TEaiyHA+o8g7/nNABkTbMiIVhEzoEpsIeFwgTiduubSNiFEl0meqp9Aehx
 mbR4yKsyocce/6Ry8d9e4hkK9XdoJQREQpE7WjLFAqcpt17n500JH0Jv4wkz0fIFVdfMC7r
 z7qmXM3yb8Ko5tx709rgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zJX/ykUY8LY=:T9sT22Cgm+tvKyflKmSoU9
 yENsvnumo7YXio+kfcUQ7AePbrMC/AIPoPKJHPtWPhpqUeFcqs8EpcyXpiphDvjBB8UaEMXRo
 dQN3IBMSQhl3U1MmRdTXvvMf8xjdi2hQaC2R7SW/JIYQEnpbPHa6WrZZJLgCtztACKZzIAJ/5
 UBqvTC86azEZncUKVnpE9KAyzN8Q1dp3PMCz7R9BcOdxDSkUBAV+j1LK/BunFZwtqRuyyYVtQ
 xVZkB+QAD3Xd5FB8cDkPtvfMU0UpkPBG5dug4Tl47OxhweluNCQeLRg3Wuk0kEamLT7JPpXsM
 Df+fm/LHTMHOUGqDLjbKU+pb5S04Iamqc8HMVTrYYnuYqUSidyzCll+LItT9x8S9XBz6hZibB
 h8mg1nIN8tEdJeW9lt5DHpm1P8hJYgGzx6s8fJuc+0xqz6/8bq8a8CuiD7+xBwYfKamkDlle/
 4OS99w/YsrmlWmfxvNj163WwGV/6ZPL/9TVqaVBO13OU9Fr1oFGBS52kDynBDQ/CrsrVqUR+m
 Nu6FBXBzsFaDAkwAHgAS0Dr3zFDw2x5AJYEci7OBVcFgutPcR3bAef+VFzwS/SGa37gWSj5+c
 sTDW97i13lSh4NZr4IeDJC9UrxGuK6twQ9PytTJIwfQHdBHuil5lgq0OOAcJASxBJ2vLOGyxJ
 VFlksopuxzHQB/7m7IRrOVJFt1oPVl5L3iYTbcG9NHQuNJISKR8coPF7dxH9VC8WgD/PpZ8Mm
 ITUrXmpLmxnHlWdIndhj6jncu/DjXznjijRD342yHrTmn0JQkh0mjUClij2JAk/YS392jjLjp
 Yi27Hlv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, we used `unsigned long` for timestamps. This was only a good
choice on Linux, where we know implicitly that `unsigned long` is what is
used for `time_t`.

However, we want to use a different data type for timestamps for two
reasons:

- there is nothing that says that `unsigned long` should be the same data
  type as `time_t`, and indeed, on 64-bit Windows for example, it is not:
  `unsigned long` is 32-bit but `time_t` is 64-bit.

- even on 32-bit Linux, where `unsigned long` (and thereby `time_t`) is
  32-bit, we *want* to be able to encode timestamps in Git that are
  currently absurdly far in the future, *even if* the system library is
  not able to format those timestamps into date strings.

So let's just switch to the maximal integer type available, which should
be at least 64-bit for all practical purposes these days. It certainly
cannot be worse than `unsigned long`, so...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 594100e7652..f366180f4b9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -319,10 +319,10 @@ extern char *gitdirname(char *);
 #define PRIo32 "o"
 #endif
 
-typedef unsigned long timestamp_t;
-#define PRItime "lu"
-#define parse_timestamp strtoul
-#define TIME_MAX ULONG_MAX
+typedef uintmax_t timestamp_t;
+#define PRItime PRIuMAX
+#define parse_timestamp strtoumax
+#define TIME_MAX UINTMAX_MAX
 
 #ifndef PATH_SEP
 #define PATH_SEP ':'
-- 
2.12.2.windows.2.406.gd14a8f8640f

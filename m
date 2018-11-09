Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBC181F453
	for <e@80x24.org>; Fri,  9 Nov 2018 17:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeKJDWu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 22:22:50 -0500
Received: from mout.web.de ([212.227.15.4]:35267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbeKJDWu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 22:22:50 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTyEL-1fuSyn1nRR-00Qigg; Fri, 09
 Nov 2018 18:41:12 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] remote-curl.c: xcurl_off_t is not portable (on 32 bit platfoms)
Date:   Fri,  9 Nov 2018 18:41:10 +0100
Message-Id: <20181109174110.27630-1-tboegi@web.de>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05
In-Reply-To: <20181025161310.29249-1-tboegi@web.de>
References: <20181025161310.29249-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ivntxAjn5FvCpgJKwKCKtx2I6pw/mZQB/Nq5/pF2INiQx/BiybB
 J/BT3vLveYR7LqjI8l6900DwrPkMSgT2UboSXxaLrILIswik8nYlNMupuXCCz+kK0JgFgBj
 ic2H8v3Wnv3xNs0dN111PJh3XBtwgBxxqHGGXbx25jhG00dMfi3cl+5oHhKZd/EBjXoJdst
 shrmaqTZXTw/aOShq+MmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E5ArmWkB5pA=:EabuZG+J97cZXXinCjGql+
 61x91fWdyuTlw4WEIYZhKrsw9/bnR7ZDvWjeJN9PR7VrpTgM/uG0WPWFdSAzgIBIOyeNHtTpt
 UMDBEHyK0Vuh8vcxydiwYDS2E2oxjFhfuUfUM0PpGUd51O+neos6hSy5aLjtlFRPi/u+s+i/Q
 /9/RfTb6vDymPRa3oN6I/8pIewpiXRmq6on+4ZmbPnK7hoVunEZdmspYqTnJ4y0jYdLcTRldG
 UQFH7MHfx6gBSA8IHQx7dWT+wAzigKPNWefHoAwlc9rVU41kmPM6lAWjNDXixVXWUSHY/5alr
 V0rNs4e+h5UORlzTLA/CF4ESRUVtnxoYqTcq7FmYwKt59MfbhsSh3vRrHKFl3hRnahm7p2Ewl
 z8Jidd7QKa01NZTQ8rX7QvEeKfzq23lttUSQFJze2QepCZ8hem1350eyoC8Y4HV3d8jlQqjbr
 UVMXRwAWcJuy50k/ogiZZjiQh5+/gqzZknmtHwvAfZxj/bTiu4d3QswZyON5KPOuX4NN05eb1
 Fm5q3b6EAF7j+iTS42LyqnGCQx1D/U03iQGIv4mwiq9W0f71m/mFhM7MpWv/zrmau5z0Ahewr
 dEnHKlj8wtlZk8nWV6wLnut5kkc1X6a7XInJ7OSgAcC+oCXjKxyhmn0zxiG4V1/udTf6htgX9
 XUojLtYl333W/V+1Tr4EstQB/mWjfaQJAaXwteBttyby91lBedSh7EiPzVEvlGRElEpxWmWb6
 BYUTtjTPzPEH74/zvvOYY/PNJj6+3U8lrOpl2r87poHMtaNTxiYJM4zHm9tWMqb3V7musZJul
 MPcTQa7bacKSW0j3DMM5b0igEakzBUZubhs+ITsEHYjUija/zW6+LEzrju6GGbKLfy6ouslMb
 xC385eSyBzc33XAdGOXeMGBhcFEOKOfVFdt8yr/Pnq++tKyscwSOe0lLrZ4DOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When  setting
DEVELOPER = 1
DEVOPTS = extra-all

"gcc (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516" errors out with
"comparison is always false due to limited range of data type"
"[-Werror=type-limits]"

It turns out that the function xcurl_off_t() has 2 flavours:
- It gives a warning 32 bit systems, like Linux
- It takes the signed ssize_t as a paramter, but the only caller is using
  a size_t (which is typically unsigned these days)

The original motivation of this function is to make sure that sizes > 2GiB
are handled correctly. The curl documentation says:
"For any given platform/compiler curl_off_t must be typedef'ed to a 64-bit
 wide signed integral data type"
On a 32 bit system "size_t" can be promoted into a 64 bit signed value
without loss of data, and therefore we may see the
"comparison is always false" warning.
On a 64 bit system it may happen, at least in theory, that size_t is > 2^63,
and then the promotion from an unsigned "size_t" into a signed "curl_off_t"
may be a problem.

One solution to suppress a possible compiler warning could be to remove
the function xcurl_off_t().

However, to be on the very safe side, we keep it and improve it:
- The len parameter is changed from ssize_t to size_t
- A temporally variable "size" is used, promoted int uintmax_t and the comopared
  with "maximum_signed_value_of_type(curl_off_t)".
  Thanks to Junio C Hamano for this hint.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---

This is a re-semd, the orignal patch was part of a 2
patch-series.
This patch needed some rework, and here should be
the polished version.

remote-curl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 762a55a75f..1220dffcdc 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -617,10 +617,11 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	return err;
 }
 
-static curl_off_t xcurl_off_t(ssize_t len) {
-	if (len > maximum_signed_value_of_type(curl_off_t))
+static curl_off_t xcurl_off_t(size_t len) {
+	uintmax_t size = len;
+	if (size > maximum_signed_value_of_type(curl_off_t))
 		die("cannot handle pushes this big");
-	return (curl_off_t) len;
+	return (curl_off_t)size;
 }
 
 static int post_rpc(struct rpc_state *rpc)
-- 
2.19.0.271.gfe8321ec05


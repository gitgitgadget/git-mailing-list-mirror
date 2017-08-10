Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3C78208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 20:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbdHJU5A (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 16:57:00 -0400
Received: from mout.web.de ([212.227.15.14]:54216 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752890AbdHJU47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 16:56:59 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lzs0p-1dcBTj1xrv-014xrK; Thu, 10
 Aug 2017 22:56:44 +0200
Subject: [PATCH] strbuf: clear errno before calling getdelim(3)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Yaroslav Halchenko <yoh@onerussian.com>
References: <20170809173928.h2ylvg5tp2p5inem@hopa.kiewit.dartmouth.edu>
 <8e307474-d180-6d98-2c6b-062f2181bd14@web.de>
 <xmqqzib72qvs.fsf@gitster.mtv.corp.google.com>
 <6d7b0d30-48ea-f79f-78cd-088557ea06ac@web.de>
 <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cd49ce13-db87-89c1-77e7-998fdb9442c3@web.de>
Date:   Thu, 10 Aug 2017 22:56:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170810200502.rutab4z3ft7gcpjz@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:oG3Sb4JJr564Gi8XyZWuNSIEurbw+Zo46hC+6AavRGYkzXEkyqQ
 sJ/PSermOaTZcjTOFXPI+lNN4eyacAKbhLVPicTUBTexwIflHdQTD7oEQa+sUErm4JcrB1w
 fQeaDUnDxZzo0Hrmf+qKbr1yGHhGXaUyvW0P7hifrN/TGa4iqXQYllu+sdNsrJdGT65Y86O
 onKiDOQcZIh261zGvIwpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OkwUxt2em2Y=:984zXgEzL26V3WiKlRQcKZ
 ByNv5JD07oO+ORbnnakQwbRFfWYigCepYuOHSX0hJFKEBwoura2k4C8arf53XAXqAGNGSRxtA
 YsnomGn+eHK4CslKdF8G+vMiOM2btYYaXJCiwk5R7KfIrfmbGeEXM13wP2v1+aPSHPCgGl2UX
 4M2LGXbEQHQSRZOAczpygcScaf2Hj0X44FIVvJFeDVhHxEf31wzEr8vHo3mqN4ZFxxNbYwGwB
 /+0gp7FAYvnDJZ4OfQM30xXCqvtwX5ZJauIyoDTxUQTxa2Whn72yP5luim0Wzjy9jq3BcTuYu
 oPQ/WTHXi1jQyVUnbwrjVfTWOHXgqAx52jYHJn3o7aoRFQoveNm2FBvUSj3zXK+0KmGZQYppp
 t0Cq2vTdDo23o6yFSrhGeRZjSFo9SGBc3Yp7LoM7HgnJqGwQmzmi+PBOooRoEK+GfqkYXarPZ
 0SyRcgtQvigm1tb/CGnCWEL5/mBEEBJ3YT+fEwYZ77ewCdG3+hm0ntcJX64Jnk3y205pwTZbn
 hY4gghYAoaw+FEkRLgvUaq7QnHaWKUQ/Cz9NulK1p3k7yZoI/nep0BVSRPWR/DkMGBaBHvu70
 tU78ZBNC1sXRGHDVAetBNO38G0m0T7uR28VCpUxIDY8D1Jp9CoO/GLnYsoIVgfGiV2ZXt2FvD
 mZImihcZpUUnmJBaZt0DAtsNiwDVj889RBtrM1qePVRuu+tzcZMTZ3alio8k9peF6SLLcn+8E
 7LY0HqjFhKxCaTMNGzrpSsgIbjikRG2tPT0GS39f2S6iQx2AQuQOR1QKTcnKx3LHhJiviVVHy
 p+uVmIHq8BbMlqsDJj/C5RpBlU4cCs+qd/7w/oWin72kXuOc5A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

getdelim(3) returns -1 at the end of the file and if it encounters an
error, but sets errno only in the latter case.  Set errno to zero before
calling it to avoid misdiagnosing an out-of-memory condition due to a
left-over value from some other function call.

Reported-by: Yaroslav Halchenko <yoh@onerussian.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Do we need to save and restore the original value of errno?  I doubt it,
but didn't think deeply about it, yet.

 strbuf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/strbuf.c b/strbuf.c
index 89d22e3b09..323c49ceb3 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -476,6 +476,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	/* Translate slopbuf to NULL, as we cannot call realloc on it */
 	if (!sb->alloc)
 		sb->buf = NULL;
+	errno = 0;
 	r = getdelim(&sb->buf, &sb->alloc, term, fp);
 
 	if (r > 0) {
-- 
2.14.0

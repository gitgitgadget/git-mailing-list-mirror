Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DF4B1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeDTWVp (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:21:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:50991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751695AbeDTWVo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:21:44 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Meduu-1elPQK1Rf6-00OG0V; Sat, 21
 Apr 2018 00:21:40 +0200
Date:   Sat, 21 Apr 2018 00:21:24 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 03/11] replace: avoid using die() to indicate a bug
In-Reply-To: <cover.1524262793.git.johannes.schindelin@gmx.de>
Message-ID: <1d045a3b832933e583efe18de9553d7747538da2.1524262793.git.johannes.schindelin@gmx.de>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zp98nEVR1WRj3zMW7LO4v9l4ilKX963YfcRLcrCTP9N/yFO48Kl
 tH5NNmTG22UqKHqxd6IgbbslOp8/GEWuWGyWFDntOo63iaIbIoiSddfP6xYuGvUcuZjPaoH
 5tLSRn6DaWQ/2GjAgYXRbauSvr1DIGzevSqYQCwfklX0A/GQw8oRgJy+rQsSxUWx4D5M7X0
 MxZm6IDHBW86jVZJr8PPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DzFusNKJq/k=:ZSn0pUUSA5dpH78KydK1Fg
 JsRPBZCtHtP3mXRIBG6DgGQcc4JOSWB7GrWkM1T9Ga3S2Uh+of2G4L2sF4Kzg77cxbRLTM5J9
 QhZVLQbw9fItwkvz9CotEXfhAL33SJCTjhB8CKCPGYdcGt6pGY9tzwk6seUq+yjwaiH3xmKXJ
 6Im88i7nfWAbbbaOxckvJIkSH9sVaWw3V6kIO0Vx8kCLrdeUmUnuj7tZg1+uR+guaonFBoXuE
 wqcC8RWmiFNYHCzATFAiWIiKJdo5wT1JXIKQEAlnFNk1W/VNiNwCLfrJG3KLeMpaK7Hm0Lzp0
 HGK8QKdtZZXUWdMpn/tCD4vn9GbuI30fEVJQSUYSZEmNMGfmfW0CRSmFbnlb9fT6i3vowSzL3
 iZBsAR+4AV3A5xy3oc6XY7p7i897SaGhen4PddN37LnBlsLrYvwlyDP6puBqo5AJpWyxquezj
 r0l58ne8ctllzgfIDYuWYI3jRrohZotTK7/zQAGLK+62E7/Usmu6Ufx0tJERDtOHQ1I+QaW/7
 oJBxTXVWKRv0fdtQyk4VVI7shT/l83DtkDRb5GAls9igyDTBMx9fgIr6h8xlrAX1/iWJRoNbp
 Zbw9eOnMAcHgNcrJRBDcPYL5wnZYTy0PluTrsgFdYk31vCcRc3bxG0unahW7UHUArHEpzXiRl
 iu+qSk9TNi3Lf4shlQ11CiSRx81XWc0xRNI9E53Ca6SUvFEVJXP1a6Rv3QcURvYd3jK9MXCQG
 wd5MxNGCr5gJOqaIMzu8aPLEg6fh4X+0GODzDRvNG8YYzUihyk2LSQpV34yqW0WrZsihuWmfu
 2ZI30vPrm6ieMAGIubKkgqsKPTvvJjceuEtoqp36qb9S4/hooA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have the BUG() macro for that purpose.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/replace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 245d3f4164e..e345a5a0f1c 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -501,6 +501,6 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		return list_replace_refs(argv[0], format);
 
 	default:
-		die("BUG: invalid cmdmode %d", (int)cmdmode);
+		BUG("invalid cmdmode %d", (int)cmdmode);
 	}
 }
-- 
2.17.0.windows.1.15.gaa56ade3205



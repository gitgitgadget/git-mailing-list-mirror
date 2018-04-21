Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931BF1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbeDUJrk (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:47:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:34329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbeDUJrj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:47:39 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lg5kl-1ecBRc3LQp-00pZFn; Sat, 21
 Apr 2018 11:47:35 +0200
Date:   Sat, 21 Apr 2018 11:47:19 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 03/11] replace: avoid using die() to indicate a bug
In-Reply-To: <cover.1524303776.git.johannes.schindelin@gmx.de>
Message-ID: <aade5dab3392eba4090d1f285f26dc94fa56aee9.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:v2vPMwD28VrfS1cOpS/M5XNb1AiccL5eOVy0qzugKOW9edPwRhJ
 Myi/Zy/HaVAkRVm5Vv7AD92jILe7fAxot/1F2p08fs1xy3JNEOVfZlGvcj0mgRMTNrO/htW
 aG7cRINdNujrE/6ke5oJ9GPkuO8TAElU863pQfrhDDXsQFeTb/25EYf+Hu3GclJuh1reYS3
 ySZnZ2zB6dH009YR3Y35Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wIoZMSTTDWY=:ThPj2SEehtbkthgoiqwXMa
 7zR57j8PTo7gaT8rPsI9Ofq3hKN/nYIqSqTa23C4OwGcgWpiHiMVIc9B/j/qAOBOjrKDyLX/I
 iQrbOsrw3Qsp2t9uA/pchd/dtwRcCj7gljxGn93wu6YXdWF+YZ7fBcbMWwab2DUmuopWqoMH9
 yGUQlgPBtwVb0oqEFUmwR7D8Mpqin2248xy/macfSTP4hlGKhMX9hfd7cG68biemu5KC93WpZ
 PeaSFUUhpoeMsMtQOt2KCLJO9l1rthSbUHCrzElYstPliBwUI9Im4JxgDYi/w/pgYnRk7u4BT
 8L2hKbizsW7DQ6ycBMBP3R2dIHBps1rdgJNq9+ieFIb+WluhcDSEWkuV5VoISAqvK5AIX/SmS
 RftHCuOVVMOF/8h7KD0qsBVAhOgjmmDdOmvrgNk38aXJyLpPE9X3BRK9ZhncodYlKFLPLA0sg
 0kxblS5eAPlhpYrBUcc+zafUEvEtrILSvN8JstU078JjaTNowqzUJlxx8xUVHtvFjx5b/RCKD
 C6dER9Z6CciHdhxzT6wL8NPoPttyDDvEC6BHXkfwerfBkLA/ZFScER4snLJgBNVovrkQnfmMY
 8d5dDTqkIV6upOwrhSOjfq/pSrVAu3sQaZc5XUvVNFaGKcfMj/AQEkmkvS4osJPjkl12peJlu
 k+jxSXKeDs8OTbvKtLs1xavpAVhtfnbiyoNzOd6fQbDaKqgGKkFP3mO2OaVEN9GNAP+WCoGoY
 56V5qEJY8cqhBdoog5M5VS7DawE/qHzlw+s4veUxmnFvVLIGyefmRmfDUZy6d9apweNRa/yod
 z3k/Ww+kmShyi7TLAVRuv50W8L9Bxu5ECX3yamVfMfWQ/QPSrY=
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



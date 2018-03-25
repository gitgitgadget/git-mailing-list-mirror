Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 173691F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 10:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeCYK5v (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 06:57:51 -0400
Received: from mout.web.de ([212.227.17.12]:45411 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752374AbeCYK5u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 06:57:50 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgOCo-1fBh92189G-00NfHJ; Sun, 25
 Mar 2018 12:57:38 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Yasushi SHOJI <yasushi.shoji@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] bisect: use oid_to_hex() for converting object_id hashes to
 hex strings
Message-ID: <9839073c-84ca-f00e-d0e1-801e521ef29e@web.de>
Date:   Sun, 25 Mar 2018 12:57:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vSsbn+HtbqJ30B6IwiGrFgyD6N0Kb9K3SSPVt73uxStTrmcqmnC
 eruQnAvZ+jhXYyZQj8WaM5V+ZnMGrooiXyqKfLzjUDqM52lU5RPufIBPgBXEAsExqsW/IPA
 fIW+echOYwh9VZs+xU34algfd1y/0JSyZ7H2kUq/4N8puaWlciI2zum5nKjLtjZsLMWz4Kl
 mxoWW4KOlsXmoxB1GFMcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lRFRD+2f6ec=:NTmySNuhkrHW+n2tqyFDvH
 RBAS236NkC/xqFJDPF6uRNoC2H0F1FTmG5/QvGjiH2+YOCZstd/yBhKHQR2oZUqm35LtVlt5V
 iIufRTzTuguA1E2cyeqem1hYRUg9S+AEctvB2DgW5Eh/BCfpsYk3tEfF6esuvO2qh0UBlMVPj
 zao0c+h92Spym3AkbYbHb5D+hUSGLvBOR4SpewaKXYeBCBa02ptg01019gkywyQeF3e1KVl2a
 MvjPCrwYw21kc9CCfXM2zcrTCMqibWx92j3xjsh1JRPTdB30gIJKqiRtlLpjzJ/HnO6XELzJX
 /y1C/xsWkIljdBPQFIvxMKvFFUh/PicUBIndTbD8V2SmyW25h4niJ3djEmZewz8AW1OzPRYn/
 rB4+SSrwZAizhI7fFRy8C+LwPo03Zr5IfgvzGFj2Oj1FwKLm1t8aT0r3vVWh8q02wSEIRYHdX
 q/M3H2LHzcFjCdFu+/m40aeuGK58I4pdE8zqIicztC94VdeGCbRvDs0fOarluRRL76oeZFEXY
 nGc/i9hcJn/VydvQp50qK03uTqPw7Oj6AeCPxcWnqgyubRbTQiSZrDf2N2pIQnAPGrbAxkEPN
 Z2ZSvLWohGgsEYsSo7fZbVIBXmLc6TCVPBWuSa33Zh2Dsf/wB0htODmQgR3sBSwGN8Asbidvo
 MLdeW/HYPT52NP7XCe7ske6ts7ezkwWULIPqZQ6Q9UQ/z6Ba1nNKVMm+BatUeer0NRhEYqh+4
 OztAm5rZ70oj3qOuBKaUksxvGsKfcIcSmKskUCX0xZxBD0Mb2OWZLCKE6NPNCUyKRIpyikfCu
 uHKbbZRpijQGIp4L4RHlD+t9MCYClbIwfUQpj2fq0ebUnqXnJQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch generated with Coccinelle and contrib/coccinelle/object_id.cocci.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
This is a belated follow-up to f0a6068a9f (bisect: debug: convert struct
object to object_id).

 bisect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index f6d05bd66f..319d60edad 100644
--- a/bisect.c
+++ b/bisect.c
@@ -144,10 +144,10 @@ static void show_list(const char *debug, int counted, int nr,
 			fprintf(stderr, "%3d", weight(p));
 		else
 			fprintf(stderr, "---");
-		fprintf(stderr, " %.*s", 8, sha1_to_hex(commit->object.oid.hash));
+		fprintf(stderr, " %.*s", 8, oid_to_hex(&commit->object.oid));
 		for (pp = commit->parents; pp; pp = pp->next)
 			fprintf(stderr, " %.*s", 8,
-				sha1_to_hex(pp->item->object.oid.hash));
+				oid_to_hex(&pp->item->object.oid));
 
 		subject_len = find_commit_subject(buf, &subject_start);
 		if (subject_len)
-- 
2.16.3

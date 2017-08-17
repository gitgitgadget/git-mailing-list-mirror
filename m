Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F411F667
	for <e@80x24.org>; Thu, 17 Aug 2017 06:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751613AbdHQGGm (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 02:06:42 -0400
Received: from mout.web.de ([212.227.15.14]:61901 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbdHQGGl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 02:06:41 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MY1Am-1e4EuH18QC-00Upnd; Thu, 17
 Aug 2017 08:06:33 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, asottile@umich.edu
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/2] convert: Add SAFE_CRLF_KEEP_CRLF
Date:   Thu, 17 Aug 2017 08:06:30 +0200
Message-Id: <20170817060630.28448-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee9
In-Reply-To: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
References: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:LaICsWbzLRDtz6EkcQc377p1AvTmxh8XirtZAUX32JXJgmMS1Gb
 Lofqk4O4bW5PNjTG9Sv6x3FnGCD1qkJ8IDhqltXfD7aIMz31ZnDzekAcTJK6Bh7J40nOrFB
 DYP/nn5wWnU6/yQCkHPdp2Mv9mB2P+RaWef3xn9rX+NbyABRzxm5Tm3+/8ESx91pac6t0rS
 wgOIY23snCBoGUK+z796g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fH7+U3pT858=:NbY+AyJqj72pt3NAHysulP
 U63PzoB3vaUkDOQuHpihz9YDTpOIMUJudrh2zjW43XUa5iNGM9WeKg5QUdggVqrH7oyXaHUsW
 RWIAZtCFHbn4mU6e+sqhI8/2c936m1UI1YH5cWRIrJ7SZ5FL9Y0aM6iI/D4/PEr33vk87cqhG
 gChpVhqWBRNuaHko7rqOyBjGW0X6h0GGRMq4OSSAbr3dJdlxcU6HRmj6Uq9KzQP/nFPmqMPtL
 otIFJh4pOZWPtvXK3v70MR+2tLh9bIe7cQBCF0BN5daTXR18GtoKDHoyCoYCnkGKVrfAtugWl
 HxKnhw05kcTghjkM9fnTCqwSHaGxW3rZfISq8S/TZc0pDm0FfKsaNdaulhVOaGgEmLzAkWnRa
 PVWUrDrV+qiioca44wUq5Ets/NZhXr8XSWFghutkn79SK4uovyc0GZuciA1nzU6VTYLojmNR1
 0wB6QRK+nkZYWSi763nvJVCWX1tv/12KdaX/CoQatLD/HymFG8jvFRlJ3y901ZsyKWE9lqhBK
 PZdevehbyHHCkS6GPA3HczLarEI8o/2FbStbfdK77H+9xuJ38b7eK08sWKD92XJzUnQkKFFkE
 wL1xLMXn/QfSYurKlaGRDTEeUu0D/K7kvM4qBZB/AEqHlZjWEmWVrJhGsDhQZcTBg3SjCOuZY
 MMEXPNowCLn8gFD5N50P9C1VfVM6HFdLsnB2O1ogmLs7oCZUrU3sLRfv0rvWTdasaRxOmQb6R
 4+29b4sfWPHrf28IbBfwjsBcL7yjhv8onJcYy0E6VNOCUPkIZpu8kJdA0Y8cZtKYb2Hwg1wws
 JyTRvF7aoH3rNW1f44IBB6V6wZ2ISUIkCv1RtVj/Z1ZDf3yl6g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When convert_to_git() is called, the caller may want to keep CRLF
to be kept as CRLF (and not converted into LF).

This will be used in the next commit, when apply works with files that have
CRLF and patches are applied onto these files.

Add the new value "SAFE_CRLF_KEEP_CRLF" to safe_crlf.

Prepare convert_to_git() to be able to run the clean filter,
skip the CRLF conversion and run the ident filter.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 convert.c | 10 ++++++----
 convert.h |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/convert.c b/convert.c
index deaf0ba7b3..040123b4fe 100644
--- a/convert.c
+++ b/convert.c
@@ -1104,10 +1104,12 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
-	if (ret && dst) {
-		src = dst->buf;
-		len = dst->len;
+	if (checksafe != SAFE_CRLF_KEEP_CRLF) {
+		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
+		if (ret && dst) {
+			src = dst->buf;
+			len = dst->len;
+		}
 	}
 	return ret | ident_to_git(path, src, len, dst, ca.ident);
 }
diff --git a/convert.h b/convert.h
index cecf59d1aa..cabd5ed6dd 100644
--- a/convert.h
+++ b/convert.h
@@ -10,7 +10,8 @@ enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
 	SAFE_CRLF_WARN = 2,
-	SAFE_CRLF_RENORMALIZE = 3
+	SAFE_CRLF_RENORMALIZE = 3,
+	SAFE_CRLF_KEEP_CRLF = 4
 };
 
 extern enum safe_crlf safe_crlf;
-- 
2.14.1.145.gb3622a4ee9


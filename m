Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2C4B20899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbdHQVnR (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:43:17 -0400
Received: from mout.web.de ([217.72.192.78]:56291 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752969AbdHQVnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:43:16 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCZtW-1dqkIA1aRG-009N68; Thu, 17
 Aug 2017 23:43:08 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, asottile@umich.edu
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/2] convert: Add SAFE_CRLF_KEEP_CRLF
Date:   Thu, 17 Aug 2017 23:43:06 +0200
Message-Id: <20170817214306.10683-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee9
In-Reply-To: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
References: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:WPUenBh61/O+Xqw89jBZOavlG1+zcksKpY2nqwo3HLWfifjI5HM
 gbkwbDdgMXnNT5ZIHFgx6BjUbrPc4GrOjRjcE0HuP9KigV/RZp8l8ZjxdcYlgHHs0JBx89Z
 038rleqStQZ1uA3qhXNqwJwLhvth7I7A4r8AT4IrON/euMUsLbcjYfrnQ3I+SET2ho/x8ar
 mZe2Kkf5U66GxtzCZ+tvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mr9Zp6JjFcc=:Im85TZgK56R4ZIRbLYT7YH
 LRrWBQg7L79arHc9UCdYC8tbfAnpxMX4jwBwbyJ7lgILNwJffRCURP9JnMxV+G4vluSpmw0Ue
 3x6gmWx4tq1PE+DwbqWp9c7h2iyEWCwhW+VyFlpXDJLXSThsrNTT4NhZ6+AyeEfy81XXPh60Y
 adq+LMc7JmKW3UPrnAHFxVTqcclk+3QPgea18ChgfLoFqaWzpthj+qy2TskStODAhhMR8mPtJ
 5C4uFfGKfc0DA9QHkmNrfpnVmi/wH+8UjK9uRow9hWWwCS619MUGZEQ+2WF0BDAFrTvBvODqS
 E0Rm8MT5lyQNLnUQ1R5NiAHsGRxwn600lOSZh8gHAGKmWmB+Pmz0RcANwoAFYnQSJkWkPuQLH
 3ZSwJWT82XjcrBpk+LFtA6gOVcc2IEBtSXhnURnE8b9UhH2MAJyYHxPrNqTJdiPI77xBxzPJq
 53/CvLpb6kpJhnNRM9CfhVA3bpyoMzY+sd/4dyyRzXm+qYR7Y836ZmY9gKimfS4XkKBC19xe8
 Xbnrhrw5GSWkUXn2MF3hGwsQ3xqseNyBIyb9rxlUqnqC4YdkAfYw4WyAgzuKWMg9vr0zfdSJ5
 jfBObFPCuBaAZRbmDVJx4f80Q2oIdZgE4iK0aJ0N4aSn/ArdFzdxQF3gLNs6PH1oRl2lpq7WI
 xQ7hLfnB+EN+7JEHzkz4JLrddktNeRp9AQp15HWX3d92qOTGyvGcdOpDkSw7L4SEKlQgTpxdV
 CcBgSGMqsaHVUsICGvUaXtMA1VBlV62NWuy36SWJ9dFizD1AzHXGdvgvZTOZF1j1NMeKxp9++
 c04busH5Fbo1DsaSYHxRX0ptE1lVnm25t7K87Y+HMJeNu/BJvI=
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


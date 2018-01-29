Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21B551F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754738AbeA2UTR (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:19:17 -0500
Received: from mout.web.de ([212.227.15.4]:65323 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754742AbeA2UTN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:19:13 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MP2Sl-1eikjG0Kz1-006R6P; Mon, 29
 Jan 2018 21:19:05 +0100
From:   tboegi@web.de
To:     lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        --to=larsxschneider@gmail.com
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 3/7] utf8: add function to detect prohibited UTF-16/32 BOM
Date:   Mon, 29 Jan 2018 21:19:03 +0100
Message-Id: <20180129201903.9312-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.2.g64d3e4d0cc.dirty
In-Reply-To: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:VVp2hOvYUl6YbRvdfWkmjm/jPxTPg5lPGPAmNjkzmtwBMQrzkx0
 Z6t7aRHfJQMGkyEIAmQBPwfF64LamHdqQLHdijxTewUlaTrezEq0fhFzTMl1gTHQ3uvg5Qp
 JkazVKhwqQ3dkiko8cLvg5wEZ9IL3s/QMmwIH8LwcJFS+XYud9GW45oHv48bjF+MnZNvSN4
 QBr2Pnb1TD4PKj8O8xY5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6T5+WbonST4=:5HddTYIC0NiofXliaCU0Qg
 wXtIgs0dC13KM3ax4XyfuHZ2RScyWZBBfYNybSltgnwjycF92IMjGuEjouwHqiIJiXQwxNaP6
 354+mHFgItQj+seluufECgKMzdlyudJZK5sdCGQLJ3X3/tmbCfkOiU9OjfTX0Y3Tcjk0Khw1R
 9LAz6EI/gPTaDQD9oSPnFfUcELl7IuXClQfGrXkUFVlVyZHITlxaRKpv+2fEvxdmmmP4cr3cm
 YDfkMpIrr4JKQJmo4hIKJ6PHNko6XVNThot42nhtOdMan8ufzXIJhJHmMsUEg2WzB7IADWQ3y
 ppjmPpm2rZSHbpyIkll10uhX91D3CKny5p/SmRsmrs5B4ccE1mM6dNSjZzVCmSU5glnWKmN2k
 XPbZvDMMbMIs1FK912eY4MXmxT1ofYoM+GxeYGhsgUp0z24+WWI/Mn8kk+XdHY3PajcjQ3tJ3
 xn0SPJxibSJezzXCvurqrVz3gtD7d0pgaYSOh4Luqqi4B3LT8vaTmmS/i234gbF7ieZYYVvRV
 qLuNt/MxuOv2aBCXasuBG6uivWKe2URpvgbsylohh3w2+1cGTaA0F5CLDsyYUIxMJkEL79GU1
 hlnSbZqYHGVFtoGO+9DrLZnYm2MbErq9XzBpzsUMXEsIUaUOYCPHq87gFl2KOqg2KWM6/gSSj
 sX/b4i6Y/I+iIgqUV5R/N7U8N3Lue7+xdrvLizd0g/wl1EvOFzD628A7IyGOdP09osQ/43jwH
 NZmDJNULim93Qd1518fuGZGhKWWpfnwY7/QCxfB+0G9XZ9uSAZFOy6zdxjp2/yAMRuV4+c2ml
 BaBnMy1Uu1Av+LVSDwSw7K616S9z+AI/Mj/VotkJ9AXFKWgM7w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
or UTF-32LE a BOM must not be used [1]. The function returns true if
this is the case.

This function is used in a subsequent commit.

[1] http://unicode.org/faq/utf_bom.html#bom10

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 utf8.c | 24 ++++++++++++++++++++++++
 utf8.h |  9 +++++++++
 2 files changed, 33 insertions(+)

diff --git a/utf8.c b/utf8.c
index 2c27ce013..914881cd1 100644
--- a/utf8.c
+++ b/utf8.c
@@ -538,6 +538,30 @@ char *reencode_string_len(const char *in, int insz,
 }
 #endif
 
+static int has_bom_prefix(const char *data, size_t len,
+			  const char *bom, size_t bom_len)
+{
+	return (len >= bom_len) && !memcmp(data, bom, bom_len);
+}
+
+static const char utf16_be_bom[] = {0xFE, 0xFF};
+static const char utf16_le_bom[] = {0xFF, 0xFE};
+static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
+static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
+
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	  (!strcmp(enc, "UTF-16BE") || !strcmp(enc, "UTF-16LE")) &&
+	  (has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	   has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	  (!strcmp(enc, "UTF-32BE") || !strcmp(enc, "UTF-32LE")) &&
+	  (has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	   has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 6bbcf31a8..4711429af 100644
--- a/utf8.h
+++ b/utf8.h
@@ -70,4 +70,13 @@ typedef enum {
 void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
 		       const char *s);
 
+/*
+ * Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
+ * or UTF-32LE a BOM must not be used [1]. The function returns true if
+ * this is the case.
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#bom10
+ */
+int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.16.0.rc0.2.g64d3e4d0cc.dirty


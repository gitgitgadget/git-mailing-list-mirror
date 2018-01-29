Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39BB31F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932526AbeA2UTX (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:19:23 -0500
Received: from mout.web.de ([212.227.15.4]:53266 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753886AbeA2UTR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:19:17 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MdLsp-1eNtxg3oEl-00IU9A; Mon, 29
 Jan 2018 21:19:08 +0100
From:   tboegi@web.de
To:     lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        --to=larsxschneider@gmail.com
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 4/7] utf8: add function to detect a missing UTF-16/32 BOM
Date:   Mon, 29 Jan 2018 21:19:05 +0100
Message-Id: <20180129201905.9355-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.2.g64d3e4d0cc.dirty
In-Reply-To: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:QMI9UZBa97K9vxLw/A8Mcsm3KNwsjzld6Aygz+yiKX3q9n305og
 jtz5/b4FELdHW9Q5sB0E4qa9xgroODUkcaSoexOZs90GKS0KS8rJhj0LLkp/sXnOQgUQ0fD
 0ITDmz52lD9vK1C40qFvw9GyQigYtit9DVAq8n6JVLDI3Gx4SaFJzAXRGCKQBKwbygda7z4
 plZME845xohUediVuda/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xiBXtwd61zI=:am4GsY7cCBTbOaYBjNQvQW
 CbrIfDfQts7JBO8xuS86TbDZsRaXwmr2IuSEmUuDD+SbgMZIjbLevQh85kYQBvTY1Qsj75TA9
 WcMAgGry9zGQXxvcedotlDkLV21jypkMJzI28yofOTADOTSTXlh5Ydm6AwLz/ODlOkDoZEvZt
 zmXJA9V4r2KyhQKk2R/y3cdzydOzVNBWRVlUARvcZ6TYplMylx1MBpsj/aXiJWqe1QoS3BRFv
 3E8eRD6oD2FSW5L0Mc95/fgIjuBp4v9KUkIMOM3gKYhqcD9AyMbBTFpRtLP54Y7sdIkX3F+ZI
 dLVOaKLIJGiYM2dm8zQyERSr1ErCvvsHtEcM+GYsxBYLmp3qlZBjoe7cnNt7yqJvsQpnEqHuf
 AdwXfZIvWrGyHjhN+Dv41rtalXJroPeOikVUsoBdtUPpZMCDC0aIdkuTRWKl4SXZMmPOUYTY8
 EtLhcZVJ0YHlhYgMthKuSrJkfwm3wq4FK0RsP94ruRbRW4UfBiMHwTBTcRhVW6FXdpVnYPcWU
 qbZ3KlNwXP9cwHbJFrsBaczi1OlY301ehw3BOrlm0rqaNafOa59VF12NvY8vQvG92BRLRtpjm
 7DOBWmqVjGARIX0CO9E//KpI0lx9NfOnF8VrLJq4gvEnV5DKmMBEE+EnIvRTgtWtIId6ddspv
 zjz7MDp2mcYJKF8mSrnVoUSB0Dkji2bM5fmX5M46QAM4TF4iKr/s4DNwx3N05MxREHFFZRLAt
 StCBM9EQE67V2uruUwzZ3foQzEVcbAzR697BbOQjbblMjYK8Y/AD9LVY687OBYkIl7GxVpSWJ
 QK6ku+P78wh6ZBjnlg4/hMPOnK20UN3rus8376c/a3ENfEOKBQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

If the endianness is not defined in the encoding name, then let's
be strict and require a BOM to avoid any encoding confusion. The
has_missing_utf_bom() function returns true if a required BOM is
missing.

The Unicode standard instructs to assume big-endian if there in no BOM
for UTF-16/32 [1][2]. However, the W3C/WHATWG encoding standard used
in HTML5 recommends to assume little-endian to "deal with deployed
content" [3]. Strictly requiring a BOM seems to be the safest option
for content in Git.

This function is used in a subsequent commit.

[1] http://unicode.org/faq/utf_bom.html#gen6
[2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
     Section 3.10, D98, page 132
[3] https://encoding.spec.whatwg.org/#utf-16le

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 utf8.c | 13 +++++++++++++
 utf8.h | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/utf8.c b/utf8.c
index 914881cd1..f033fec1c 100644
--- a/utf8.c
+++ b/utf8.c
@@ -562,6 +562,19 @@ int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 	);
 }
 
+int has_missing_utf_bom(const char *enc, const char *data, size_t len)
+{
+	return (
+	   !strcmp(enc, "UTF-16") &&
+	   !(has_bom_prefix(data, len, utf16_be_bom, sizeof(utf16_be_bom)) ||
+	     has_bom_prefix(data, len, utf16_le_bom, sizeof(utf16_le_bom)))
+	) || (
+	   !strcmp(enc, "UTF-32") &&
+	   !(has_bom_prefix(data, len, utf32_be_bom, sizeof(utf32_be_bom)) ||
+	     has_bom_prefix(data, len, utf32_le_bom, sizeof(utf32_le_bom)))
+	);
+}
+
 /*
  * Returns first character length in bytes for multi-byte `text` according to
  * `encoding`.
diff --git a/utf8.h b/utf8.h
index 4711429af..26b5e9185 100644
--- a/utf8.h
+++ b/utf8.h
@@ -79,4 +79,20 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
  */
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len);
 
+/*
+ * If the endianness is not defined in the encoding name, then we
+ * require a BOM. The function returns true if a required BOM is missing.
+ *
+ * The Unicode standard instructs to assume big-endian if there
+ * in no BOM for UTF-16/32 [1][2]. However, the W3C/WHATWG
+ * encoding standard used in HTML5 recommends to assume
+ * little-endian to "deal with deployed content" [3].
+ *
+ * [1] http://unicode.org/faq/utf_bom.html#gen6
+ * [2] http://www.unicode.org/versions/Unicode10.0.0/ch03.pdf
+ *     Section 3.10, D98, page 132
+ * [3] https://encoding.spec.whatwg.org/#utf-16le
+ */
+int has_missing_utf_bom(const char *enc, const char *data, size_t len);
+
 #endif
-- 
2.16.0.rc0.2.g64d3e4d0cc.dirty


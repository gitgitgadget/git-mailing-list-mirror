Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C168320437
	for <e@80x24.org>; Tue, 31 Oct 2017 13:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbdJaNrM (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 09:47:12 -0400
Received: from mout.web.de ([212.227.17.12]:59927 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbdJaNrL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 09:47:11 -0400
Received: from [192.168.178.36] ([91.20.50.251]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXpdL-1dgWwl2aCF-00Wmve; Tue, 31
 Oct 2017 14:46:52 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Thomas Gummerer <t.gummerer@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/3] notes: move hex_to_bytes() to hex.c and export it
Message-ID: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
Date:   Tue, 31 Oct 2017 14:46:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ScjNSuMWAbKb2g7xDoRKubLFo7X5uQkXmrWqsrpMtT0mAnh4Bdo
 UGNGj8A+hhfCV49rnu/+B9IWeiXCskCg5rN0BRcTicSxmOAO9JUpvyJidAEnstp9ekNYavU
 7Ml6+N/5UzA+x/a4T8UZXHaoGCHYZ7HpfvjsoJEThmJiHJuxqS0PKEhW9Rvy7Lml/e4tWsg
 7T3Qjk2P+fRTfU5+TTOuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jEYxWhWt8VY=:8sjr25E7Ej0Yifg4eTqDHz
 jZb/lOisSDSA96YFHULhzwNAzhO+iWdbhin49q9VMuPEVu7KiYM39QJXQqug8WxsC3PDp0LKL
 zcjeARsWNbkr/dZjtAkB8wYbZqgjCOrFldyV8Mw7HPyEvg1iraPgSZtFjXzsoFE4KDt4RWQfk
 5J053l2bJcu63slDo9hNnZFToJN9YUzwJDCGV6ICQLAHqCo70uM49UBCIrmWm8zb361Y03pyO
 TdnP/7fr0mygFhtYqUEi3utlONh1EP79xmkLYbuulaQVMph1b1wVr+RtKPbkXoe+Fl1kUXZuK
 6bBM7MQ4CWZApiU+aMpbH9LvtUc+ZMc1fa5ik1xbdiVbqxYI6UgwVyMkJ35tut4uLA2S19VX8
 m0KiSWBiJ/HDooxt0l5Rnw/24ksp0oq+7K2RaFuSgsy0oRCnXsvbxreC2+gor6uGbNwqwzqNY
 4+SZE4+RX79NRdFvR++StyYrikCNrUu547Zc9Km7RiUmB4N8CGnKIJXdCgc0bo2sOGphclyNX
 SWL0gNOv6yoDZ66pL7RcCnhZ2ngPKOb59SdfU5v2hsq9cb+HO2UjcMBI6AO4lmfPzLPCit2rz
 usbMf6h9IRn1BKCNJ8N+fdUnkbBpfNcmWHM9nlKrpBUKKYbMrzRqGxFR0xfUnIR4235KJn3aX
 UIGUz/cWmuP3Ew1048WmbPZEdHyoUft0eEWGBa8s1KTzTUOGGcoY/gfBVt1Td6jtqo9uW07Fu
 bFa/xPz1+7bfAgMjR7cdyy4WMDBY7yGfRZfF0PsOhFYbx4wIeoPeNf0mPRjEF8EsNSHCcHWhu
 JRotAKAmXm4/MYvMcfHdJXTOgTfEZhMdjDnP0BhIPRBJKwvTc4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the function for converting pairs of hexadecimal digits to binary
available to other call sites.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 cache.h |  7 +++++++
 hex.c   | 12 ++++++++++++
 notes.c | 17 -----------------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/cache.h b/cache.h
index 6440e2bf21..f06bfbaf32 100644
--- a/cache.h
+++ b/cache.h
@@ -1317,6 +1317,13 @@ extern int set_disambiguate_hint_config(const char *var, const char *value);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern int get_oid_hex(const char *hex, struct object_id *sha1);
 
+/*
+ * Read `len` pairs of hexadecimal digits from `hex` and write the
+ * values to `binary` as `len` bytes. Return 0 on success, or -1 if
+ * the input does not consist of hex digits).
+ */
+extern int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
+
 /*
  * Convert a binary sha1 to its hex equivalent. The `_r` variant is reentrant,
  * and writes the NUL-terminated output to the buffer `out`, which must be at
diff --git a/hex.c b/hex.c
index 28b44118cb..8df2d63728 100644
--- a/hex.c
+++ b/hex.c
@@ -35,6 +35,18 @@ const signed char hexval_table[256] = {
 	 -1, -1, -1, -1, -1, -1, -1, -1,		/* f8-ff */
 };
 
+int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
+{
+	for (; len; len--, hex += 2) {
+		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
+
+		if (val & ~0xff)
+			return -1;
+		*binary++ = val;
+	}
+	return 0;
+}
+
 int get_sha1_hex(const char *hex, unsigned char *sha1)
 {
 	int i;
diff --git a/notes.c b/notes.c
index 5c62862574..04f8c8613c 100644
--- a/notes.c
+++ b/notes.c
@@ -334,23 +334,6 @@ static void note_tree_free(struct int_node *tree)
 	}
 }
 
-/*
- * Read `len` pairs of hexadecimal digits from `hex` and write the
- * values to `binary` as `len` bytes. Return 0 on success, or -1 if
- * the input does not consist of hex digits).
- */
-static int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
-{
-	for (; len; len--, hex += 2) {
-		unsigned int val = (hexval(hex[0]) << 4) | hexval(hex[1]);
-
-		if (val & ~0xff)
-			return -1;
-		*binary++ = val;
-	}
-	return 0;
-}
-
 static int non_note_cmp(const struct non_note *a, const struct non_note *b)
 {
 	return strcmp(a->path, b->path);
-- 
2.15.0

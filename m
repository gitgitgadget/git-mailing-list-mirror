Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D7E81F453
	for <e@80x24.org>; Mon, 22 Oct 2018 05:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJVNx2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 09:53:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41689 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeJVNx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 09:53:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23-v6so18469408pgc.8
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 22:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3U7WBELZ/j8RQiTv3P7AFraPEM5u8LTRUHcwNegCNQ=;
        b=Dg55OM+CpV6+EZL2OvxsBh18JGnPtJaUm2V/qiaS4no0+xok8lIF6ts2jsP0+Nd8Kr
         4SwkaUbkDdcsniz66/RUzVGDLlv/P4EBYffow5nTWp8i/lP20ozkpmbUp33sX/iQWkWW
         veklqMmktq0q4uXbFG2Bpgexv3MAvW0JR+ydkSqedu91JYDxl4b3I0vhgpXi4hEc0j2P
         XRLDIbnqFXkMjEDmyDJByQbIXUVd4Wg5LWndxa1WN0NIzgbjpLKD7S0TzYr5wk+4Qu/B
         XhX5C3b+/pIDHhXSVaYmMLian1DIfVdeahWyUjpR0FpKHdDpDua+drAdTFAwykIxHBSv
         1Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3U7WBELZ/j8RQiTv3P7AFraPEM5u8LTRUHcwNegCNQ=;
        b=myzQNCf4hxIPoZFhimEjfz8YD4xl0L8GKJIGSm8oxnkPZmhdUhJkUuT5q7RH+rfoTe
         rPDtnFPqJoFpEwyPTn1hft3D9guVMjMZX654oZpa+Iw+beik6y/aiTueGhsMqS04r7Z9
         nZx4TVpD5Gl5Nd5ji0pmHSWwOvSnOmL69wk2A1SupGPLmMdT4zV9t0o1M3TJ4H+h/Stv
         ug4EaKgBl2BzvHb+vRQC/xVIQQlapu9rxexVwNM5YExj17fkuhxds1hZJKvjZO/OcfvS
         vp+tDsbbG+EK0pbdh2oxMQA5Uuu7nQWtr8RXf0/zhkBGkYEMtqAzzRmlBbkWeY7V1uSG
         Hmrg==
X-Gm-Message-State: ABuFfojg0KmpJexPcyZWAVFiIxS/RElExpbVThPABqwtyAjve6JxmMyF
        Z39qgwfy6wUUJRwBEMFfHUkXtm4/
X-Google-Smtp-Source: ACcGV62xQy6kBy1FlfNaLmM4llmfVsGZXP65V9uOo/IBRvaCYaOz1JSFs2JFCOCGgCn8Cxw1T5st6g==
X-Received: by 2002:a63:f210:: with SMTP id v16-v6mr40769636pgh.371.1540186588540;
        Sun, 21 Oct 2018 22:36:28 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id n63-v6sm38004733pfn.9.2018.10.21.22.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Oct 2018 22:36:28 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/3] xdiff: use compat's MIN instead
Date:   Sun, 21 Oct 2018 22:36:05 -0700
Message-Id: <20181022053605.81048-4-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181022053605.81048-1-carenas@gmail.com>
References: <20181022053605.81048-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 xdiff/xdiffi.c     | 2 +-
 xdiff/xemit.c      | 6 +++---
 xdiff/xhistogram.c | 6 +++---
 xdiff/xmacros.h    | 4 +---
 xdiff/xprepare.c   | 2 +-
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 1f1f4a3c78..0754dc17ed 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -204,7 +204,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 
 			fbest = fbest1 = -1;
 			for (d = fmax; d >= fmin; d -= 2) {
-				i1 = XDL_MIN(kvdf[d], lim1);
+				i1 = MIN(kvdf[d], lim1);
 				i2 = i1 - d;
 				if (lim2 < i2)
 					i1 = lim2 + d, i2 = lim2;
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 7778dc2b19..43d455b404 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -217,8 +217,8 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 
  post_context_calculation:
 		lctx = xecfg->ctxlen;
-		lctx = XDL_MIN(lctx, xe->xdf1.nrec - (xche->i1 + xche->chg1));
-		lctx = XDL_MIN(lctx, xe->xdf2.nrec - (xche->i2 + xche->chg2));
+		lctx = MIN(lctx, xe->xdf1.nrec - (xche->i1 + xche->chg1));
+		lctx = MIN(lctx, xe->xdf2.nrec - (xche->i2 + xche->chg2));
 
 		e1 = xche->i1 + xche->chg1 + lctx;
 		e2 = xche->i2 + xche->chg2 + lctx;
@@ -242,7 +242,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			 * its new end.
 			 */
 			if (xche->next) {
-				long l = XDL_MIN(xche->next->i1,
+				long l = MIN(xche->next->i1,
 						 xe->xdf1.nrec - 1);
 				if (l - xecfg->ctxlen <= e1 ||
 				    get_func_line(xe, xecfg, NULL, l, e1) < 0) {
diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
index ec85f5992b..562cab6d14 100644
--- a/xdiff/xhistogram.c
+++ b/xdiff/xhistogram.c
@@ -129,7 +129,7 @@ static int scanA(struct histindex *index, int line1, int count1)
 				NEXT_PTR(index, ptr) = rec->ptr;
 				rec->ptr = ptr;
 				/* cap rec->cnt at MAX_CNT */
-				rec->cnt = XDL_MIN(MAX_CNT, rec->cnt + 1);
+				rec->cnt = MIN(MAX_CNT, rec->cnt + 1);
 				LINE_MAP(index, ptr) = rec;
 				goto continue_scan;
 			}
@@ -193,14 +193,14 @@ static int try_lcs(struct histindex *index, struct region *lcs, int b_ptr,
 				as--;
 				bs--;
 				if (1 < rc)
-					rc = XDL_MIN(rc, CNT(index, as));
+					rc = MIN(rc, CNT(index, as));
 			}
 			while (ae < LINE_END(1) && be < LINE_END(2)
 				&& CMP(index, 1, ae + 1, 2, be + 1)) {
 				ae++;
 				be++;
 				if (1 < rc)
-					rc = XDL_MIN(rc, CNT(index, ae));
+					rc = MIN(rc, CNT(index, ae));
 			}
 
 			if (b_next <= be)
diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 2809a28ca9..495b9dfac4 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -23,10 +23,8 @@
 #if !defined(XMACROS_H)
 #define XMACROS_H
 
+#include "../git-compat-util.h"
 
-
-
-#define XDL_MIN(a, b) ((a) < (b) ? (a): (b))
 #define XDL_MAX(a, b) ((a) > (b) ? (a): (b))
 #define XDL_ABS(v) ((v) >= 0 ? (v): -(v))
 #define XDL_ISDIGIT(c) ((c) >= '0' && (c) <= '9')
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index abeb8fb84e..7436064498 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -451,7 +451,7 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
 
 	recs1 = xdf1->recs;
 	recs2 = xdf2->recs;
-	for (i = 0, lim = XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
+	for (i = 0, lim = MIN(xdf1->nrec, xdf2->nrec); i < lim;
 	     i++, recs1++, recs2++)
 		if ((*recs1)->ha != (*recs2)->ha)
 			break;
-- 
2.19.1


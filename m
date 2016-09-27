Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CE1020986
	for <e@80x24.org>; Tue, 27 Sep 2016 19:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934371AbcI0TIf (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 15:08:35 -0400
Received: from mout.web.de ([212.227.17.12]:56831 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752367AbcI0TIe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 15:08:34 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MUnUe-1bRrNI0yZI-00Y9LE; Tue, 27 Sep 2016 21:08:28
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] use strbuf_addstr() instead of strbuf_addf() with "%s",
 part 2
Message-ID: <b7a61c78-3c46-375c-4cc3-7c363e551bc6@web.de>
Date:   Tue, 27 Sep 2016 21:08:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:N8ylEtcO+JuzyngzNl9LBL+BoeV8k0pXh9+nvr8fVqtP9VcyBm+
 RaDxwy2AX0oYl7n5Lpu47zIcfDC4FsuefynLEE8sMYs+yl/pduPQeBFb2/XYFfGDhTy4GjH
 cUwh85RFPUj1JeTgmX/ZEDQoRlcOFo0COvtvQoaKzHUuv3GqxOSYp+CFcucpF8kMKKJNa/K
 8R7iX61G9B6GDzYm1+6IQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pYOtawp16CU=:8PKKt9t0WSGFBZlh5ZX7xJ
 RFRlAXkTJMF8EgxBFzByUOAO1gb2AoL5+2SiGkaDDga9HMqA7hmdgGEPRxF2UY8AuNmWE4dfk
 BYVYbghQw26WjPNOvHtH74ZoSsGRhsG5KVwDrYrnaNKFz3mJSHYCUDIFHr2vfWM8d9E1iJtsr
 l0LOw1/0kqZM2PfeUx9ATWuyRkBUV38DV0YykjmZ4Zg1G4VtD0ylNgg+coFjh30ExKcDsoWaD
 eKhyd7CX2Vse8PXp7W9uwq1GQKqwX6EVgF0rEoVOknY84Mr6Uf/jhkIsSCbZ3gpYuFt6wEMhI
 TL0qP0PzbAUWFBz8rWkDKJIezvQtb5sgAebRb/cr3ndWTHTX6cgS9iUvc4MA+J8/4ZZpaFseD
 XbKfkPS/H1JAsKfD6aCl+4wjus6nju9kmUnQ8XMhtymHhOSHFZbJKHSTmkO3nX1rpeJ0oATd9
 DL6rklzt8JFwjleVOm75SSW1e86XAdA+lFDeoMhrYhFiRZVKGM9h9gH5xUp118tMjFgDeBYL0
 LvfCtzUozPl1OYB8fQinoHl8sfTppq2qCsUSkhYHb8z26rNaTIDyxOuL/yXkU5/p/qDEMIJjp
 aDO71kzVPEwVM6Gn0ZNG11mHj0KyloBd14UqGKJ2DlXmtF4f44CxZzBnyolOMOruqwMfgezbQ
 PKvrUs3ELLkHyWAcBs1cN9Kl4+PJSujj6ohwRK52pPrlN9KLaF7jUVi0lzxRaXY0LzqBwVxLT
 vnQ7MKrB+jtlGWKgoscUhMzy3IK11nfC4m3dEPwyezYQQw3jlcHrlHWIbQIyeWXkvsTrS/ltp
 DC8c8o1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace uses of strbuf_addf() for adding strings with more lightweight
strbuf_addstr() calls.  This is shorter and makes the intent clearer.

bc57b9c0cc5a123365a922fa1831177e3fd607ed already converted three cases,
this patch covers two more.

A semantic patch for Coccinelle is included for easier checking for
new cases that might be introduced in the future.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/submodule--helper.c     | 2 +-
 contrib/coccinelle/strbuf.cocci | 6 ++++++
 submodule.c                     | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e3fdc0a..444ec06 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -753,7 +753,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		if (suc->recursive_prefix)
 			strbuf_addf(&sb, "%s/%s", suc->recursive_prefix, ce->name);
 		else
-			strbuf_addf(&sb, "%s", ce->name);
+			strbuf_addstr(&sb, ce->name);
 		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
 		strbuf_addch(out, '\n');
 		goto cleanup;
diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 7932d48..4b7553f 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -3,3 +3,9 @@ expression E1, E2;
 @@
 - strbuf_addf(E1, E2);
 + strbuf_addstr(E1, E2);
+
+@@
+expression E1, E2;
+@@
+- strbuf_addf(E1, "%s", E2);
++ strbuf_addstr(E1, E2);
diff --git a/submodule.c b/submodule.c
index 0ef2ff4..dcc5ce3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -396,7 +396,7 @@ static void show_submodule_header(FILE *f, const char *path,
 			find_unique_abbrev(one->hash, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
 		strbuf_addch(&sb, '.');
-	strbuf_addf(&sb, "%s", find_unique_abbrev(two->hash, DEFAULT_ABBREV));
+	strbuf_addstr(&sb, find_unique_abbrev(two->hash, DEFAULT_ABBREV));
 	if (message)
 		strbuf_addf(&sb, " %s%s\n", message, reset);
 	else
-- 
2.10.0


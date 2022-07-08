Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD6AC43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 14:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbiGHOU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237921AbiGHOUl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 10:20:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3596E255A1
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 07:20:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f2so25381013wrr.6
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sXsg+U9/HWR7ASkvwNAaVPykH4FYO/GZK97OTlELXeI=;
        b=Trcp3Cn4eSTjeEId/7Ei7kEFddDK4MEeYI6Bb/R6RpssyWV9rWnnC1xQJXAe5UTIfd
         sgDxKmNq2Gp307kLsqygyApbBG7mnf1PFlMCN/Y8tfzpS2miFl7gk0MYykmdliqj33X3
         mtUP6zKHIon600kraYIxr/adVP+9X10ut6EiykzfUm4sKcwmoOUxSfVB8i7Vg1K7h9IZ
         Dt6KF3H7qtfMqF+xuRoTTr34cYC/E8l1eZO8YXLZs5RXT0QSmRRxGsEZbzx2M92iqCiP
         NTQ7CZSNMRTo+Wwuj/Yk3GadX33OpXznDkgciAK923cMk/Xrzo6KLx1QPvBxVA1uNcI0
         Q8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sXsg+U9/HWR7ASkvwNAaVPykH4FYO/GZK97OTlELXeI=;
        b=mFBC9v5YdRbBPs0b1U+rOjjo3sKhSUx1vJVtvAtzD30IRF5RKhiMqyqeyzb7Pf9HO6
         ydQ5ShcRHj9Q0d+EhtQsN1oRkG447xcBKt4jozkxhNHTaBST4W0mtkeWXSc2kPU7LQ1S
         63+HwomhlMKQ/hu5fzAL6t7bsDL93VWnEjhqhv6kzdyGVAP7J7IbhdkXt/iwjTPms1eb
         y5PJILXT8Vm+8ZeVcY/ujMer800vCJPxH0d2FjOF83mvvOmdE086EJBzuZDjM76bj/i3
         WDfVafcClDEgOmPVTf0Z4N5Gol7KWQlZDQuW6WEOp6oXHI9YABcexL70SNlA00cjMTR2
         piRQ==
X-Gm-Message-State: AJIora+U7Im8EQq+0FIeElJ0FBx/2a+y9a5uqMO8bDTcVS6s9w9pyYJU
        0MSEiZysc88363PkJ+NeTB8xsP3I0NE6mw==
X-Google-Smtp-Source: AGRyM1vl5hwFil+cCA44PMD0HM8RiMM4KvAagXVjSnzpEAYJ6sTUIq3X0Cf3k2dFYIQJPyyCCVPXEQ==
X-Received: by 2002:adf:d84b:0:b0:21d:6efd:efa with SMTP id k11-20020adfd84b000000b0021d6efd0efamr3586520wrl.384.1657290038458;
        Fri, 08 Jul 2022 07:20:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm40393924wrr.101.2022.07.08.07.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:20:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/7] xdiff: remove xdl_malloc() wrapper, use malloc(), not xmalloc()
Date:   Fri,  8 Jul 2022 16:20:18 +0200
Message-Id: <patch-6.7-33d93f121a9-20220708T140354Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com> <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 36c83197249 (xdiff: use xmalloc/xrealloc, 2019-04-11) the
reason we have xdl_malloc() in the first place was to make the xdiff
code safer, it was not handling some allocation failures correctly at
the time.

But as noted in that commit doing this was intended as a stopgap, as
various code in xdiff/* did not correctly handle allocation failures,
and would have segfaulted if malloc() returned NULL.

But since then and after preceding commits we can be confident that
malloc() failures are handled correctly. All of these users of
xdl_malloc() are checking their return values, and we're returning
-1 (or similar ) to the top-level in case of failures.

This also has the big advantage of making the compiler and analysis
tools less confused, and potentially avoiding undefined (compiler)
behavior. I.e. we define our own xmalloc() to call die() on failure,
and that function uses the non-standard "noreturn" attribute on our
most common compiler targets.

But xdl_malloc()'s use conflicted with that, confusing both human
readers of this code, and potentially compilers as well.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff/xdiff.h  |  1 -
 xdiff/xdiffi.c |  2 +-
 xdiff/xmerge.c | 10 +++++-----
 xdiff/xutils.c |  2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 832cf9d977e..df048e0099b 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -119,7 +119,6 @@ typedef struct s_bdiffparam {
 } bdiffparam_t;
 
 
-#define xdl_malloc(x) xmalloc(x)
 #define xdl_free(ptr) free(ptr)
 
 void *xdl_mmfile_first(mmfile_t *mmf, long *size);
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 077cc456087..6590811634f 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -368,7 +368,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1, long chg2) {
 	xdchange_t *xch;
 
-	if (!(xch = (xdchange_t *) xdl_malloc(sizeof(xdchange_t))))
+	if (!(xch = (xdchange_t *) malloc(sizeof(xdchange_t))))
 		return NULL;
 
 	xch->next = xscr;
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index ac0cf52f3be..676ad39020d 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -60,7 +60,7 @@ static int xdl_append_merge(xdmerge_t **merge, int mode,
 		m->chg1 = i1 + chg1 - m->i1;
 		m->chg2 = i2 + chg2 - m->i2;
 	} else {
-		m = xdl_malloc(sizeof(xdmerge_t));
+		m = malloc(sizeof(xdmerge_t));
 		if (!m)
 			return -1;
 		m->next = NULL;
@@ -409,7 +409,7 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
 		m->i2 = xscr->i2 + i2;
 		m->chg2 = xscr->chg2;
 		while (xscr->next) {
-			xdmerge_t *m2 = xdl_malloc(sizeof(xdmerge_t));
+			xdmerge_t *m2 = malloc(sizeof(xdmerge_t));
 			if (!m2) {
 				xdl_free_env(&xe);
 				xdl_free_script(x);
@@ -670,7 +670,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 						 ancestor_name,
 						 favor, changes, NULL, style,
 						 marker_size);
-		result->ptr = xdl_malloc(size);
+		result->ptr = malloc(size);
 		if (!result->ptr) {
 			xdl_cleanup_merge(changes);
 			return -1;
@@ -718,14 +718,14 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 	}
 	status = 0;
 	if (!xscr1) {
-		result->ptr = xdl_malloc(mf2->size);
+		result->ptr = malloc(mf2->size);
 		if (!result->ptr)
 			goto out;
 		status = 0;
 		memcpy(result->ptr, mf2->ptr, mf2->size);
 		result->size = mf2->size;
 	} else if (!xscr2) {
-		result->ptr = xdl_malloc(mf1->size);
+		result->ptr = malloc(mf1->size);
 		if (!result->ptr)
 			goto out;
 		status = 0;
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index c0cd5338c4e..865e08f0e93 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -98,7 +98,7 @@ void *xdl_cha_alloc(chastore_t *cha) {
 	void *data;
 
 	if (!(ancur = cha->ancur) || ancur->icurr == cha->nsize) {
-		if (!(ancur = (chanode_t *) xdl_malloc(sizeof(chanode_t) + cha->nsize))) {
+		if (!(ancur = (chanode_t *) malloc(sizeof(chanode_t) + cha->nsize))) {
 
 			return NULL;
 		}
-- 
2.37.0.913.g189dca38629


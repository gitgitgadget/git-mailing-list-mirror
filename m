Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E1FC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376548AbiATPMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376535AbiATPMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:31 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659DDC061749
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r7-20020a1c4407000000b0034e043aaac7so287493wma.5
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TUCZrT0R8cpMEB18cBkDpHwmjdJOKsrx7vpHWxOMd7M=;
        b=fDCQRPmbctiJ9S8YcosDCrYYLBkTbCalMV/n2/UyMLqjim7/HXKd3OktMclD23UBCa
         Jk3gmB8LcrWA09tg1I/4xNu0ZnU+mq/zFG0pPvLHsAskFO0tWNjpcP4T/OSZ4gJO0CGR
         JhFxCCm5E249BAznY/f6CvpQXBLJD7hByc53Hma4QF+yDHvCZAJZR+5apDSjB3ndww05
         j5xjPL/uhbKc9HlWeOwsDEGow4mUo+yHjmmuFA61DotFqxRWhUcuEBuxlPusX0fxeTHA
         732dMov9nKP9GEdQnlSlvJJpNqVzqcotMZ4lMWEWxuxaezmdDttau7ka70PvLwWFQtsN
         hn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TUCZrT0R8cpMEB18cBkDpHwmjdJOKsrx7vpHWxOMd7M=;
        b=wtAv0EErVCwq0AVWb6b9Lq5Swtq4EdhzZBMOZ549Zs/2jsf3KA44hBfKN0z656VXAt
         G2MYwWWh6y1f8YRTWqndn2S3khqP4pfovlJ/Nmc131dQxEHFWXtpV1pYPtMsiByqeCQi
         2iJCazI84OtD4MUv1Q0A3LMjzKaibLJFor2hBF1yuQV6HZWSJmGD+Z/wtG7pRBs1D0eD
         JAXHqdSDoshpHQvoI9mQLfcaMwDcqcw4uGaqhgxrSXNsfu5u/rHOaAUUcU4rnAZeAs5S
         jSQHvhO20NeGOUKSKzqG/+dXyi2hONKiUgLuw+5a3Lf0M1xZKlY46k+b04xdiCQ7URGv
         wPOg==
X-Gm-Message-State: AOAM532+rpWQo20+5XvbMzjWxeuX7e7i1cb9JhqnDlBpENQhCiq6SS97
        XsOJ3p2gWkW7v7qsaABB4gn24f4bldA=
X-Google-Smtp-Source: ABdhPJzF5g7Xe0ddzedCGx7fTrl1Kvf4HO/7iyJTaL1ywjBY4neQxvdn78Mjen0P2CotcBo8gjGfmw==
X-Received: by 2002:a05:600c:2216:: with SMTP id z22mr9543590wml.119.1642691545910;
        Thu, 20 Jan 2022 07:12:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm3271706wrs.109.2022.01.20.07.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:25 -0800 (PST)
Message-Id: <69c4a55488209f96ae605047ecd1709678518fa5.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:12 +0000
Subject: [PATCH v6 13/15] reftable: remove outdated file reftable.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This was renamed to generic.c, but the origin was never removed

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/reftable.c | 115 --------------------------------------------
 1 file changed, 115 deletions(-)
 delete mode 100644 reftable/reftable.c

diff --git a/reftable/reftable.c b/reftable/reftable.c
deleted file mode 100644
index 0e4607a7cd6..00000000000
--- a/reftable/reftable.c
+++ /dev/null
@@ -1,115 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "basics.h"
-#include "record.h"
-#include "generic.h"
-#include "reftable-iterator.h"
-#include "reftable-generic.h"
-
-int reftable_table_seek_ref(struct reftable_table *tab,
-			    struct reftable_iterator *it, const char *name)
-{
-	struct reftable_ref_record ref = {
-		.refname = (char *)name,
-	};
-	struct reftable_record rec = { NULL };
-	reftable_record_from_ref(&rec, &ref);
-	return tab->ops->seek_record(tab->table_arg, it, &rec);
-}
-
-int reftable_table_read_ref(struct reftable_table *tab, const char *name,
-			    struct reftable_ref_record *ref)
-{
-	struct reftable_iterator it = { NULL };
-	int err = reftable_table_seek_ref(tab, &it, name);
-	if (err)
-		goto done;
-
-	err = reftable_iterator_next_ref(&it, ref);
-	if (err)
-		goto done;
-
-	if (strcmp(ref->refname, name) ||
-	    reftable_ref_record_is_deletion(ref)) {
-		reftable_ref_record_release(ref);
-		err = 1;
-		goto done;
-	}
-
-done:
-	reftable_iterator_destroy(&it);
-	return err;
-}
-
-uint64_t reftable_table_max_update_index(struct reftable_table *tab)
-{
-	return tab->ops->max_update_index(tab->table_arg);
-}
-
-uint64_t reftable_table_min_update_index(struct reftable_table *tab)
-{
-	return tab->ops->min_update_index(tab->table_arg);
-}
-
-uint32_t reftable_table_hash_id(struct reftable_table *tab)
-{
-	return tab->ops->hash_id(tab->table_arg);
-}
-
-void reftable_iterator_destroy(struct reftable_iterator *it)
-{
-	if (!it->ops) {
-		return;
-	}
-	it->ops->close(it->iter_arg);
-	it->ops = NULL;
-	FREE_AND_NULL(it->iter_arg);
-}
-
-int reftable_iterator_next_ref(struct reftable_iterator *it,
-			       struct reftable_ref_record *ref)
-{
-	struct reftable_record rec = { NULL };
-	reftable_record_from_ref(&rec, ref);
-	return iterator_next(it, &rec);
-}
-
-int reftable_iterator_next_log(struct reftable_iterator *it,
-			       struct reftable_log_record *log)
-{
-	struct reftable_record rec = { NULL };
-	reftable_record_from_log(&rec, log);
-	return iterator_next(it, &rec);
-}
-
-int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
-{
-	return it->ops->next(it->iter_arg, rec);
-}
-
-static int empty_iterator_next(void *arg, struct reftable_record *rec)
-{
-	return 1;
-}
-
-static void empty_iterator_close(void *arg)
-{
-}
-
-static struct reftable_iterator_vtable empty_vtable = {
-	.next = &empty_iterator_next,
-	.close = &empty_iterator_close,
-};
-
-void iterator_set_empty(struct reftable_iterator *it)
-{
-	assert(!it->ops);
-	it->iter_arg = NULL;
-	it->ops = &empty_vtable;
-}
-- 
gitgitgadget


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0B0C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345021AbhLVS5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344969AbhLVS4r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C559C061401
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q16so6769583wrg.7
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TUCZrT0R8cpMEB18cBkDpHwmjdJOKsrx7vpHWxOMd7M=;
        b=Blt3r/eTMtmCgMStl3tl7W1N5q24zx+kG3tWEnvp17Io8ApoA3kdQYNuO0MLvOkzXL
         c6AWFzbMjF0B7McQg4Vm2DAjj+mZ1iJegB7SP3dpA5SZFPShuWu+w0dTc1ez5vRZn/WL
         BPQZ7bNbXmI1sS9P4H+GKtEXRpB9/R49INxhPzg+VHaEZ4xYUHfiY+Twv9WLumovRd/6
         pOEnm1iZaPpCVSceFxgNmUepMuVA60smlLnYbVdQrz0Kw7Op2rCXKGqpavlzlZLXjthp
         DHMEk8HfoNF48j0jfAcorljl6SdosyIkdBSb+jIfnnxLJv/sj6PJooOT3tDjFtFaamP9
         0C3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TUCZrT0R8cpMEB18cBkDpHwmjdJOKsrx7vpHWxOMd7M=;
        b=mvFLKZCdoeRHxJMzxLJMuRTKgqrKkNrZ+mGh+g0a8dqRfSCx7nsI4mnHIyJL4uoYnM
         EkdDpCA0wn3AK1Q9DxVKKiFPdyIn32F/zBRuyUVfUyblNyHUd6QgiroF23kU1J9SBV8a
         bv71nCy1w75LyWIfmlKtmrxGOjzdglDXNokbbJ3RpHakQ81OsSuwv3fLEzvthnGguNP/
         DOi4V8XK8jYk8O+B2sXoWd5U/x2NL0SznRPliyFB4/0WOf7WdwW5PlRzRoztThLmvAzH
         0xJkY2AZhuML2/b+vhXSOnUUqk+AZvH7y29RXlL698WUzgWfKCVsrk/8HLhjNuw6PDfN
         8BCA==
X-Gm-Message-State: AOAM530sbdp95zJXp92HECZzIAu1FL+bE0u2I4J9OmyZDoCKD3YseaYQ
        XshZEmWNlLK+BbH4v3pdT+JkaGJ05gg=
X-Google-Smtp-Source: ABdhPJwzLlg16djup8gmEBWQwMQLH64luufEwBMJ/1nNQ6+vs6wjXqKQLS2A6M37TWK4esw4t/W/Dg==
X-Received: by 2002:a5d:47c2:: with SMTP id o2mr2948432wrc.637.1640199405660;
        Wed, 22 Dec 2021 10:56:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm3591978wry.18.2021.12.22.10.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:45 -0800 (PST)
Message-Id: <4175089ec432da921d158fec9ccb1902be710af6.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:33 +0000
Subject: [PATCH v5 13/16] reftable: remove outdated file reftable.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
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


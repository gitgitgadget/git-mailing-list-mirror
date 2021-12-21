Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8D1C4332F
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 12:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbhLUMeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 07:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbhLUMeC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 07:34:02 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE2C06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 04:34:02 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id c4so26628383wrd.9
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 04:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S4ICO3WBg6iv08HEcE9a2IGnJ3uGqx0NF6JKU8Ns3dI=;
        b=Py5T8i2X+f0WE+WCSWFAOba9v+cPodLvQAjqCos9moA7nMX5cR6sds2PfYXW7SbZT8
         Re3l06KuSTOfOxRtaF/vWF9BFHV/mfbEBDcSVJJpCk87GasCSjex2fLyyRfTmGAzjbpc
         lWt3Q63Hi1exLIqQX+rX8ee5HeQEWGZ1UJWUlNQoGXB/ndVHEGOC5uKmhWXEwzS9t6a/
         9kDaAzKTk1J8KP772CsKpSePv9KVxT7Ngf2VDRqFwIWhyf4yrDhHRUr4xS1D3O/olywr
         wbb+FfJhqhxX/4322j4UmVxY4RSsNmsa4p94twb5spDLUyQQcucPIot365ZV23w7GPiw
         izXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=S4ICO3WBg6iv08HEcE9a2IGnJ3uGqx0NF6JKU8Ns3dI=;
        b=ik7Se0Im0a9UPbMZkc/lLjma9P16ftMezWncVaas0tCc/JKBtN3e7iN5g/cjj12U3i
         W3s84y1O6XAjRm+akavV6g2XhEcwq3HU08z1vVEiaZY2ikRDdUeOY4VS6hlDjznZJAIh
         amyEjiLtcMyLwe+fCUtrrtER95pM16QBOSSQBoCpe9pys9qWovYObVxqpsGkHktVTWxR
         kFH4rj5Qp3GxhKixrcXRYhIoVN/aIGlI6Noo0TjlShtSxA2bN3TspJ4jGhEc70Y5vi1S
         JCrwiU6nGHeXJkfZlgcfoPjkAi9ZF95SWQX4z+Ql73WbE/vKPqhbdT37DpqA4v7AQB3D
         zR9g==
X-Gm-Message-State: AOAM533sJlOJON+yJtf5IsV1F1mn5zNM3HBNhqlLzsgWJy/4NAiqRSO1
        llb+pttfivd7sgLF3giWZB6ld7/Zje4=
X-Google-Smtp-Source: ABdhPJxYxiftUrWtmscM+RG+Ey1PeFyTDG0oGVvnq6kPCuJ+bBQX5xzoYC1/pwGLTBhd/R5nOeWKAg==
X-Received: by 2002:adf:816b:: with SMTP id 98mr2535647wrm.201.1640090040697;
        Tue, 21 Dec 2021 04:34:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17sm17774776wrw.11.2021.12.21.04.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 04:34:00 -0800 (PST)
Message-Id: <75e5392032dbdbdedf8a2b76a7098e4dc1133d82.1640090038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
References: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 12:33:58 +0000
Subject: [PATCH 2/2] refs: set the repo in debug_ref_store.base
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is for consistency with the files backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/debug.c b/refs/debug.c
index cf6ad36fbb0..136cfd7c700 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -26,6 +26,7 @@ struct ref_store *maybe_debug_wrap_ref_store(const char *gitdir, struct ref_stor
 	be_copy->name = store->be->name;
 	trace_printf_key(&trace_refs, "ref_store for %s\n", gitdir);
 	res->refs = store;
+	res->base.repo = store->repo;
 	base_ref_store_init((struct ref_store *)res, be_copy);
 	return (struct ref_store *)res;
 }
-- 
gitgitgadget

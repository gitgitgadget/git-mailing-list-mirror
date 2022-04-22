Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AB0C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiDVWjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiDVWiD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D821F9E05
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so6065153wms.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=esVaJv7IQ90g9VYUweTDAQx3mnacLOZ6RiVFfDmFvWpfcC7EwgipwqWAoT8nbB/cbh
         NaPN+JmchQmRmDDBM+3i3I3rz5mStoulB7VUZgO/MzQ1b8eW/Hsl42lCyKlmnY2CCCI8
         yIVDMqWvhkwrpk3okA9ezi/AcBtbPyewjG4xd4Qy6qXQkzSsmibGDo9SymXFKlXBdfXs
         WyFecNpFj9E4kBNXv4NVNm/102MEXzSgEhXy06vIR9dA3kdgvq/Ct23BZzRDe4tmff7y
         5xxFOjf+TnmKkYQPmKxufACxhxNgTCaJse+HO7xj+5/DN/E7//QxVpq56tJyVdUjqGSR
         qSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=1xqJklMAAR+hwcmi/YNKvY4NmpAP90QPEp2qL4WANAEVwPe4QNESKCjh59sd0AiweM
         G/nq5Zkts4mluzq20NUZzh0oft77jXI/W0o+0N6yLTxMcAcq/zNClxm3iMjMehynHRek
         wx+AVAFQcDioaYDpkpkdpRwP+TxhXa3Bx9PQCIGEvsBgkLMqK3tC0sca4OY0vjJwOryD
         wUEPw6AtCdFvWANefNLL+W+d9zxVB/IWV8d+QKJ/Kspe8G8foyeWBzoI+3zNH6yUjhol
         M5NsnuzrmrHxyGPdD2jgX0IKqJqbUwrPE7Tv+Mk9kKgQ1V0CvJfwHImk2FaW5nU+za7j
         5XQw==
X-Gm-Message-State: AOAM532JyZlpa1qL40NH/UFY0lT+Cc/dT0iS6igk/5Y3ppAe3X5jd+bV
        DsldRJorRdc9iNXQoTTcwyusExq0bHc=
X-Google-Smtp-Source: ABdhPJyVoBGXBMgyc3FqVXXhlpHRF+IuL2uY9m2ZBlUSUWPImleSLk11dk6VQgduXvAeBS0kHxHhdg==
X-Received: by 2002:a7b:c382:0:b0:388:2e76:49ed with SMTP id s2-20020a7bc382000000b003882e7649edmr5830026wmj.195.1650663007762;
        Fri, 22 Apr 2022 14:30:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4-20020a7bc8c4000000b0038ebbe10c5esm5205188wml.25.2022.04.22.14.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:07 -0700 (PDT)
Message-Id: <d4a4263d379d2d0f3b61d57541161d8706bb96a7.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:37 +0000
Subject: [PATCH v6 11/28] unpack-trees: initialize fsmonitor_has_run_once in
 o->result
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Initialize `o->result.fsmonitor_has_run_once` based upon value
in `o->src_index->fsmonitor_has_run_once` to prevent a second
fsmonitor query during the tree traversal and possibly getting
a skewed view of the working directory.

The checkout code has already talked to the fsmonitor and the
traversal is updating the index as it traverses, so there is
no need to query the fsmonitor.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unpack-trees.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 360844bda3a..888cff81f9c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1772,6 +1772,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	o->result.fsmonitor_last_update =
 		xstrdup_or_null(o->src_index->fsmonitor_last_update);
+	o->result.fsmonitor_has_run_once = o->src_index->fsmonitor_has_run_once;
 
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
-- 
gitgitgadget


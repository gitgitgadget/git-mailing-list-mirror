Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA3AC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbhLHVxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbhLHVxa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:53:30 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AFCC061B38
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 13:49:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a18so6460026wrn.6
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 13:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MXMomjRC/fb24dxRgX+qEsh4KebnnV6VgDOcUfwXPBo=;
        b=CgxF01eesAt2N12zppZULnuPPcWo0qaBj3g90nNOoAgHd1j1SiDE4KTDWSr9ftEMG9
         gH5gyl2a7vpcNuCQZ/csDzFwUylCLLfqUZ0Qqe5cfuXdn9e4pDVKvbPeEXjWpQxkLZgD
         Z5HXCT4OM7tLuQ6WheXgWQvXzZ1WZHeQsXMb1TQtfm+mmdJeih41HxX8WGOEte3TVG6F
         r1BSnLs3wrVCGFTrg/H78YH8O88eZ8AXpVxqZbKyCjPnnLoUv+LfYWcWfH2BpVG2okam
         JfIxAsL+oY3kY8+2N8lBSnOzjdUsQmUbJYDO9rv9Ui61vwiwHTqX8wwdqaal9OFubDA6
         6EwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MXMomjRC/fb24dxRgX+qEsh4KebnnV6VgDOcUfwXPBo=;
        b=39w8cGMDaUyZaXzuvsstTc7KYMxpDZldWgW6BGndTAOSLSOgpuipAvb8EJnA7aMyhe
         7C5saFzu2mz17T3TDBI7dz3K9q2L7oGcF88bg0y2z8uI6KP0XBKshDnVNMeIv/I8zHWG
         HnKxqK1fNzxACQw3WaFCnsJnRxLBdzWDChfzpwduyntlUPdpcPINRgSlIv1b9AjbCpPG
         4oKlb2fs6DhwAMt3QNbq4AydpRVONq1nQPj1yQQRztu8fL+4eYF7FkDZAxvNd4/qXef4
         lu3SlRLKM0fPgXes4Qce3o/iNGzhRyAKpAYIUASjALVd1mR2Uz5A4Q+Kx1AsaliPafAq
         Zm3A==
X-Gm-Message-State: AOAM531JqR/IqaI4FijWqWMjV8Mn6SgEE88VRo6fmr+8FjUmEtawRtzW
        t+YTRo0wkcl2qmgfgag0bWaarKliFW8=
X-Google-Smtp-Source: ABdhPJxCsKITNxKqchbjTBw7D2y/RDSpGmsM3ocE3ZmM94SmqWMZvdrwfEkZFGRP6y/jWziBJppL4A==
X-Received: by 2002:a5d:4ed1:: with SMTP id s17mr1631787wrv.310.1639000194253;
        Wed, 08 Dec 2021 13:49:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d15sm5287158wri.50.2021.12.08.13.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:49:53 -0800 (PST)
Message-Id: <713f1d09f6837989e57026cffcaffea755d6a3f7.1639000187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 21:49:43 +0000
Subject: [PATCH v2 08/11] reftable: order unittests by complexity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is a more pratical ordering when working on refactorings of the reftable
code.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-reftable.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 26b03d7b789..f08d66df949 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -3,15 +3,16 @@
 
 int cmd__reftable(int argc, const char **argv)
 {
+	// test from simple to complex.
 	basics_test_main(argc, argv);
+	record_test_main(argc, argv);
 	block_test_main(argc, argv);
-	merged_test_main(argc, argv);
+	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
-	record_test_main(argc, argv);
-	refname_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
+	merged_test_main(argc, argv);
 	stack_test_main(argc, argv);
-	tree_test_main(argc, argv);
+	refname_test_main(argc, argv);
 	return 0;
 }
 
-- 
gitgitgadget


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B2420248
	for <e@80x24.org>; Mon, 18 Mar 2019 14:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfCROaA (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 10:30:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46743 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCRO37 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 10:29:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id n17so13675238edt.13
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KH+cTd6rYhkN0dBitluzaCq365jHawIQLOXSGRdst2A=;
        b=hbTwI+W29MUzMh/N8UyMORiex5d9bG0gbAc5xGMQkzWqBmN1B5/SOj4uEMNgCPpJ55
         4LYNaiXx+0kKURhVMbwLu2hZG1sZ5nMrznq/nVNkluavc0SDDrjnDilGP1JuJnz/xgYn
         W32/lidWQYexIJdQFNNGmYlcgwPCpiu4dma/KqKkSO0al6+/CI/Q9rIKV7bYPd3/GBq5
         KnwMqSB5Fu+7K5tOdbUBsh+v4QG4eR0fAQMZWGRnqusQyT4bDi5ezk2pZq5FIXuHaCxn
         l22/Ps5znhCYbGCmrqEVdovnNcbj0VtqMCLy/TGKu+jU50wlwfhFPYSAOuNdREEW11j4
         mwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KH+cTd6rYhkN0dBitluzaCq365jHawIQLOXSGRdst2A=;
        b=oIYrSGiqOYp+XonFvwsFR/Ko41iOGc2aht4IapFWezeJ+IMu2R9CKxgnsOjAyrXOT/
         yF4a/7SmLc5ehIFJFKFbGialme/5/8TLafoNYpnrgACd3t1YeGBgAraKggg9fOOuUTq9
         hWGxynWsF7snmQE0M80NI5avF1TRdy7NYjJj4qy+frCl180E/y1N8hnazrYHHONIcGst
         A5GYG9sCTLtnl7J68Elkel4SNyjjMGOCBVaj4FWDmBnZ4bKJf9S5/MjgGhSwuOQXvC+K
         AABgmJKWjKmsLvgrajXKJtVEpY20m9FbcUR3a12ULYWoVG48/kNuQjcGvfC/dTNxaKw2
         NvSw==
X-Gm-Message-State: APjAAAXq1hiFQaVHbysuUD4eNxzaO/q6T/30uxuv7hzxLz8pOXdPqKzM
        ysGQi9DkTtkvmM5STZiJMCbUXbKc
X-Google-Smtp-Source: APXvYqzB6/PTlD6reUA/LIW268Cu/hk1KDW42JYwotWGYYgRbo21RCaxyW48/fSIWaM8mlP+3/zFjw==
X-Received: by 2002:a17:906:2594:: with SMTP id m20mr10888947ejb.91.1552919397476;
        Mon, 18 Mar 2019 07:29:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2sm3460835eds.45.2019.03.18.07.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 07:29:57 -0700 (PDT)
Date:   Mon, 18 Mar 2019 07:29:57 -0700 (PDT)
X-Google-Original-Date: Mon, 18 Mar 2019 14:29:52 GMT
Message-Id: <d1a730df94a02f4424fa1b9e543981aea4999d77.1552919394.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.166.git.gitgitgadget@gmail.com>
References: <pull.166.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] midx: verify: add midx packfiles to the packed_git list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Fix "git multi-pack-index verify" to handle repos with thousands
of packfiles.

Midx verify adds the individual "packed_git" structures to the
multi_pack_index.packs array, but it does not add them to the
"repository.objects.packed_git" list.  During the verification
code, each packfile is opened and scanned.  And "pack_open_fds"
is incremented.  If "pack_open_fds" equals the "pack_max_fds"
open_packed_git_1() calls close_one_pack() to LRU-style close
an already open packfile.  But because the packfiles were never
added to the "packed_git" list, close_one_pack() does nothing.
If there are very many packfiles, Git runs out of file descriptors
and fails.

Note that this was observed on Windows when build with GCC and
in a repository with more than (2048-25) packfiles.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 midx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/midx.c b/midx.c
index 8a505fd423..d2c39b6d37 100644
--- a/midx.c
+++ b/midx.c
@@ -971,6 +971,9 @@ int verify_midx_file(const char *object_dir)
 	for (i = 0; i < m->num_packs; i++) {
 		if (prepare_midx_pack(m, i))
 			midx_report("failed to load pack in position %d", i);
+
+		if (m->packs[i])
+			install_packed_git(the_repository, m->packs[i]);
 	}
 
 	for (i = 0; i < 255; i++) {
-- 
gitgitgadget


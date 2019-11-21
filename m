Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED74C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2FF206CB
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCHbm3e1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKUWUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:33 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:42829 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKUWUc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:32 -0500
Received: by mail-wr1-f48.google.com with SMTP id a15so6322879wrf.9
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I29Vp7df1EIlBApM6eCI7K/dFZdRBtrCCgS97gMiTcM=;
        b=tCHbm3e1SZgOmkBtH6KsXX45XOsA4juNlhqgFDvX+zDGHW4g8rxUlSvCu9ixs5uPip
         I1M9kEdKoz4AKlTeoZhJ8oJkoVwsQhhCSKSvcjteptR5M9E2FI3cDbz1uQTnNX0FGyut
         IVwn4pc+ZEhdYl99R+3Lwh3H163aVzMgv4j0C6pL9mzBcSTe/A2RKgR4N2z7JB3TvyCi
         kT4LR999jYCrQh77muidnFlfL6gjPLeRRP3gZBCCd6oin1mwrIHssfGEvvS4gcU28eJj
         CDNL/94iFwRaSiM/7N/HCCTPEdmknZRdR4lDTvJ7yWYxik/YN8SvQMjv3ulMllJnRsSG
         PDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I29Vp7df1EIlBApM6eCI7K/dFZdRBtrCCgS97gMiTcM=;
        b=fHALspgQMOKNW9zBw01sHAYXCcOfMye5kpsUsFd4LN6uE71PliA0JZKKq6/TOAsRKY
         /DFmUkGkm1CRU1KbcOn+70KKg3yPIPpEH10C6EK75XqW2JNWCZSkY3hITJRYzKaCp8OP
         drahMLpXLAaCAIJMESXYme34G4je/35DIO2IyRRevndEbfg8ac/xKdzUMfawV2vOcje8
         n+60WaFKUyBjUt7MZ4S9W1m6iFr7PWGiv2bB07Osk0BK88x1aNpgk5HDiz+pdU6J8fG/
         1I3JWbVXXzlW2I3vCdfg/dPokdGSfSiW3DfVyroW0HrAsdbIIsXeI+shR52pawUuMc4m
         bwFg==
X-Gm-Message-State: APjAAAVXEAetY06CNagep0Qjixgq7jDUPdEa/3RUST33eA2b6d+wgzQa
        CEnI/Y9YVARYZ+ASMoBr8isJNfYp
X-Google-Smtp-Source: APXvYqzYnPqn7aMJfRxP3Mo/PHotGcQ5Dr880Piu1hjKN8ViDigFCkgs7iFbE65jJ5NwyKcYiYaGtg==
X-Received: by 2002:adf:e2c1:: with SMTP id d1mr3632858wrj.130.1574374830732;
        Thu, 21 Nov 2019 14:20:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18sm4976187wrp.14.2019.11.21.14.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:20:30 -0800 (PST)
Message-Id: <81c587651e31d157c37c813650788bd5b88a9433.1574374826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.git.1574374826.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:20:20 +0000
Subject: [PATCH 05/11] fsmonitor: disable fsmonitor with worktrees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t2400-worktree-add.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index e819ba741e..d4d3cbae0f 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1,5 +1,7 @@
 #!/bin/sh
 
+GIT_TEST_FSMONITOR=""
+
 test_description='test git worktree add'
 
 . ./test-lib.sh
-- 
gitgitgadget


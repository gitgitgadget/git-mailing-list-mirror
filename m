Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BDA1F42D
	for <e@80x24.org>; Tue, 29 May 2018 21:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966888AbeE2VUK (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 17:20:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44226 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966952AbeE2VUC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 17:20:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id y15-v6so27416439wrg.11
        for <git@vger.kernel.org>; Tue, 29 May 2018 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kY1lTl3XyGhn3yAJr9t4RIC8GHjBmX9s0byK40roCJE=;
        b=BbgB+aroOdFLx0l2Qgq5ihDlUgn334CuKS+2NQDRFnAnJgKYTZqHANlx7N+y1ryZpq
         FwjqYHsq5ahlAOeI5NphBZFWYWhAiZ368FzetsNs5iYu67OEy5251Wg0GIVe4mO5RIOG
         Xqv+8UQOSmfcAF0rw97WYua7GJzHW6Qyn55sSATbbBdNJPYPpoE37LwP+ivWCLC9jtXf
         xjbmCL/RJMwgr/NBnvby48Gp8t+19dp4o5eXv0eZZvG28UbkjfgLy8ozF7HsZWR2lCYL
         k3L49YQR6QNxqzPxo4vhDD/CCPjiZIm+HvQwSx3wVbdSwUtrnp9pC1svyCuDIUE4AGtd
         zK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kY1lTl3XyGhn3yAJr9t4RIC8GHjBmX9s0byK40roCJE=;
        b=ZdyDMLhSawf7xB2BR5BmXofzGFSYvVMKS6nU9Rww+2zUGTri7wvwhXSlrm/tPIz+rR
         AjFdbZUFzYQnqJhVPETwiRuEXvhT9r/NSccGnAGI4kOkyPevp8JaqftHmt//rrBSRKfQ
         RfENgXtz9c5Oge7S9rzRRmuR9DOy36m2Aa4eC6NWm0Qir0K7e9fm1+ZJisc9C1D68F4N
         YPG7rEjNdxNYsnFGrL07nlOS9XR3eKsXH3kxoT8XsRIvkxAbgrf1hAmfke7mh98KELH8
         OrG8UVotyJ9c6kmjfM2ZmhU/hZ19igtdY3Bd3Gj1iQ1PV8Th38t3pUgVJP/F1Qh+IV2j
         9y9g==
X-Gm-Message-State: ALKqPwdzwu5Ayml8HuxfsHjcd8/tk0MbwlAp8yFRbjlw6s95skvqFQt8
        UIEKl+jC+cMPMPZRKRHJx4rvDnWM
X-Google-Smtp-Source: ADUXVKJ7gwHBeT23srEYucoCENPHio4dfDpBXi7qke2HE3/sU1uwcOW8/02BOIm1l1pupF1H7hTbBA==
X-Received: by 2002:adf:a690:: with SMTP id t16-v6mr42743wrc.1.1527628800798;
        Tue, 29 May 2018 14:20:00 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id u68-v6sm15665714wmu.40.2018.05.29.14.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 May 2018 14:20:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] fsckObjects tests: show how v2.17.1 can exploit downstream
Date:   Tue, 29 May 2018 21:19:50 +0000
Message-Id: <20180529211950.26896-1-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Something that's known but not explicitly discussed in the v2.17.1
release notes, or tested for, is that v2.17.1 will still happily pass
on evil .gitmodules objects by default to vulnerable downstream
clients.

This could happen e.g. if an in-house git hosting site is mirroring a
remote repository that doesn't have transfer.fsckObjects turned on.
Someone can remotely push evil data to that remote hosting site
knowing that it's mirrored downstream, and the in-house mirror without
transfer.fsckObjects will happily pass those evil objects along, even
though it's been updated to v2.17.1.

It's worth testing for this explicitly. So let's amend the tests added
in 73c3f0f704 ("index-pack: check .gitmodules files with --strict",
2018-05-04) to show how this can result in a v2.17.1 client passing
along the evil objects.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I guess this test is technically a bit redundant, but I think it's
worth adding anyway since we're short in general on the subtle
semantics of how *.fsckObjects acts in various situations, and so
anyone reading the tests realizes that even a patched v2.17.1 can
still be fooled to collude with evil in its default configuration.

 t/t7415-submodule-names.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index a770d92a55..f35f98e956 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -93,6 +93,15 @@ test_expect_success 'transfer.fsckObjects detects evil superproject (index)' '
 	test_must_fail git push dst.git HEAD
 '
 
+test_expect_success 'transfer.fsckObjects needs to be on to protect downstream' '
+	git init --bare intermediary.git &&
+	git -C intermediary.git config transfer.fsckObjects false &&
+	git -C intermediary.git fetch ../ master:master &&
+	git init --bare downstream.git &&
+	git -C downstream.git fetch ../intermediary.git &&
+	test_must_fail git -C downstream.git fsck
+'
+
 # Normally our packs contain commits followed by trees followed by blobs. This
 # reverses the order, which requires backtracking to find the context of a
 # blob. We'll start with a fresh gitmodules-only tree to make it simpler.
-- 
2.17.0.290.gded63e768a


Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66894C35671
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 08:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C9D206E0
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 08:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHDTrrtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgBWItO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 03:49:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39216 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWItO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 03:49:14 -0500
Received: by mail-lf1-f67.google.com with SMTP id n30so3821271lfh.6
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 00:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NDDxx6JlIHZCdVkik0Z/TvdawbtTrizcjVQM1tdECb0=;
        b=AHDTrrtDfMQYZ2h+M2Vzgu7i2ULPCVk1sh0xKGCpzYrHRtksx1UyIF2vAhkvKtjBnO
         oQBr/unspyl/UtRS9MgqgRel2UCX2OTF2+xspD6OIeVOcag+VDt9892VZe+ibBz/kIWJ
         YtEU2Q7P3RqnKBJvJnjiGxRptr6KkM5fuFEpw45Ba2JDOxHrdCmVwHWszf26a6dQHjvT
         9M9bgQWrtxDe5ta2Traj/n+cZLSjYIj0U1ECzISMCL8e3Si28/81Bp8Leltnuzdcd/H+
         KXQ2E4TEHXxbQNgraL58Lr7pB4g4cpZ+EAPZ9WWuTecRCFIind6bDpwkvs51oCSN69/T
         X67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NDDxx6JlIHZCdVkik0Z/TvdawbtTrizcjVQM1tdECb0=;
        b=gacrXjNxg7y8LPfHOIZZbr0XytUU2myVRIMmwRIQl7wkVPixuUNxS6vSRZKvMQe7Uf
         AjQynhw5CgIN9cW1K3HYA/ByRMorIMuLp/CsPvcQlGcaUnaYOqyT+TC9NDipz7HNawGb
         +WCqi1VZn2q5MscapODlf1X6K+PY1AsXUsEnosaFpdeydYJbcySZZOEZD1gHxgzgzR6m
         4McERlByGKkxktLofP40hgC0RvgQAEf31omdBc6E2kE5fTp/bSmKi5FEqZORhGW88zos
         GnIOwtSqwYUiUeCC5A3Is6MPYMrONfni4db1D2L6T4q6H1wyvP1UukYcVucaN7O7sLym
         kgBQ==
X-Gm-Message-State: APjAAAXnB9DjTrXfe7p3s/SQgYzUTcSYF+3f5UzDkrZDTSASdq1zhEIz
        SL/WAiS/rohFbRDzwOYeKX2JP7Jt
X-Google-Smtp-Source: APXvYqzACy/cCBj6w34MI8tkSOpRaZjOxtH7HLscRHVJ7hJJg11A2//nw9+EP+4CHP4goWrG6SiJKw==
X-Received: by 2002:a19:c1cd:: with SMTP id r196mr9875963lff.22.1582447751117;
        Sun, 23 Feb 2020 00:49:11 -0800 (PST)
Received: from localhost.localdomain (c83-248-175-94.bredband.comhem.se. [83.248.175.94])
        by smtp.gmail.com with ESMTPSA id t29sm4108692lfg.84.2020.02.23.00.49.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 00:49:10 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] t4117: check for files using `test_path_is_file`
Date:   Sun, 23 Feb 2020 09:48:34 +0100
Message-Id: <dde0f85e5e3dd99a61b83df1b6eb572be8a3ff51.1582447606.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We `cat` files, but don't inspect or grab the contents in any way. These
`cat` calls look like remnants from a debug session, so it's tempting to
get rid of them. But they do actually verify that the files exist, which
might not necessarily be the case for some failure modes of `git apply
--reject`. Let's not lose that.

Convert the `cat` calls to use `test_path_is_file` instead. This is of
course still a minor change since we no longer verify that the files can
be opened for reading, but that is not something we usually worry about.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t4117-apply-reject.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4117-apply-reject.sh b/t/t4117-apply-reject.sh
index f7de6f077a..0ee93fe845 100755
--- a/t/t4117-apply-reject.sh
+++ b/t/t4117-apply-reject.sh
@@ -74,7 +74,7 @@ test_expect_success 'apply with --reject should fail but update the file' '
 	test_must_fail git apply --reject patch.1 &&
 	test_cmp expected file1 &&
 
-	cat file1.rej &&
+	test_path_is_file file1.rej &&
 	test_path_is_missing file2.rej
 '
 
@@ -87,7 +87,7 @@ test_expect_success 'apply with --reject should fail but update the file' '
 	test_path_is_missing file1 &&
 	test_cmp expected file2 &&
 
-	cat file2.rej &&
+	test_path_is_file file2.rej &&
 	test_path_is_missing file1.rej
 
 '
@@ -101,7 +101,7 @@ test_expect_success 'the same test with --verbose' '
 	test_path_is_missing file1 &&
 	test_cmp expected file2 &&
 
-	cat file2.rej &&
+	test_path_is_file file2.rej &&
 	test_path_is_missing file1.rej
 
 '
-- 
2.25.0


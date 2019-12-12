Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7EEC2D0CA
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165582173E
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIR9Wduv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfLLTqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:46:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39402 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730284AbfLLTqe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 14:46:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id d5so3924702wmb.4
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 11:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eXjmQ9O2OMja+arytkEZ+AvLrtHsbtCs2F/MgNagWUU=;
        b=DIR9WduvA6sRd0tJRhRnG6c9YLoBQTYS4++w48GmTGGyOKZwPgPObZUtPIh/1yKLPB
         blB6d0buoTgf6kfaFtUuDXAmoWosYUW1s8o74qjobzp6mN45hZ24/YTesJONbZSVM6Pm
         M7rGBsztU0sdbjI0D8wtCkugYY45Q3GSoKj2+5JxaoGlxN9JuoNl7DeW21sgA92eJJIZ
         m7SveOh8HR3ljjXryFffqbjFCgrtdAqxnmes+6N2l7zlb0e/yIafLYVx6KAkZ80cw19a
         5MZ/UxBTVcB5v/M5pWoAwDCWHy9tsk0xgpOJ4KrXw2Y/kVS5+pm9ZKkrr6m4gQlATZps
         IGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eXjmQ9O2OMja+arytkEZ+AvLrtHsbtCs2F/MgNagWUU=;
        b=KvIG7Vz1YapAXOmUXuhwBH6e7Vuml1uNhPqTdEI0E2ZiSNiC3LewvzFIrdmvqK2JnW
         29io45P7cnxJasEZpPrY0HuMvxsHcYn2Z5M9pvJ8SWg2ZAT5OAq7PpbQjAcWVc0aB2ji
         ONHO2BkMyQeKOrttf7r29193w0HIGVVPOdIcWiXVeC4bxtDBuFaaron+PQVs3g//9Gvp
         pEYW8jFi1y/db9P8XOM7bcHJ6yvc+Bdl75F5VXLHCCrHHzlG5rtNnIvAilgP/F13YHGc
         MxCjT9T409v1DVy2dfoyt5WvNsguv6mQpKT//mOrt7OFw67xYu8hX8U9hRI0Uwuap31F
         Bp8w==
X-Gm-Message-State: APjAAAUGFYy4UjZdeNFnyr+aUbJUbdRkAxw1xmUcs3xzOscwKA0UTv3Q
        suv5DHEJjtOndygjc4fa7/MuelGF
X-Google-Smtp-Source: APXvYqy6C8ieUmBIn09J9Gv63xM/l2+gSAltLvtOZH8vXdCrl8ShiJyOt2CXE775N7t2rMNtZ31YZA==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr8339637wmc.2.1576179991973;
        Thu, 12 Dec 2019 11:46:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm7091107wrw.97.2019.12.12.11.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 11:46:31 -0800 (PST)
Message-Id: <00307c395157d798501a8776521779206f888563.1576179987.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
References: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
        <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 19:46:27 +0000
Subject: [PATCH v3 4/4] git-p4: failure because of RCS keywords should show
 help
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

When applying a commit fails because of RCS keywords, Git
will fail the P4 submit. It would help the user if Git suggested that
the user set git-p4.attemptRCSCleanup to true.

Change the applyCommit() method that when applying a commit fails
becasue of the P4 RCS Keywords, the user should consider setting
git-p4.attemptRCSCleanup to true.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 97fad8d3f0..b659b8d4bf 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1962,6 +1962,14 @@ def applyCommit(self, id):
                         for f in editedFiles:
                             p4_revert(f)
                         raise
+            else:
+                # They do not have attemptRCSCleanup set, this might be the fail point
+                # Check to see if the file has RCS keywords and suggest setting the property.
+                for file in editedFiles | filesToDelete:
+                    if p4_keywords_regexp_for_file(file) is not None:
+                        print("At least one file in this commit has RCS Keywords that may be causing problems. ")
+                        print("Consider:\ngit config git-p4.attemptRCSCleanup true")
+                        break
 
             if fixed_rcs_keywords:
                 print("Retrying the patch with RCS keywords cleaned up")
-- 
gitgitgadget

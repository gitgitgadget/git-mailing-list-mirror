Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A6DC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB312077B
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5O30TBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfLLTqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:46:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37143 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbfLLTqd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 14:46:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so4076934wru.4
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 11:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uBfeL82PX5Gz5hrKXUwkUzSu0jSSt07YXIXsO82un/4=;
        b=W5O30TBBsbX/fWuZBpUIzVVwEd4jNN4Hrblv4v1yXMnnvnivdb2wNSFaUuHI4pRn/I
         9o61U4Z7tQIofp0v5R1mY+B86gddVTxu0efe/c5AL7B4sYYZgu2SXCvv76cWfQYa1HOW
         rf4eRi/NqfF5yIey7y/sJ3TZIutsPL7z8cjs1EWjJM41RVt6cqXKQLY1uAORUKkleyc9
         nKwBOkQLw4DGaOd/yjNBZiNPd8iofYrtnbdvJLayGrRJiGfi5UI5Tsr0UzT5NyzxqQbD
         CLs5pcJnZV7t7UvTRMYh9703405OO55idVY5bN01H4VIKu/e4KdALb/kpvf5GNCzwAAM
         /eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uBfeL82PX5Gz5hrKXUwkUzSu0jSSt07YXIXsO82un/4=;
        b=m0cQKM2rO8Qt9MZ+TiH1RufWW6KOQdk0fNKu42Wk+Mvw4Axpl9nPyAhl4Ee1ARGigY
         4rWK5SxXt6pc3s/z9AL5M7vpjV/7jMaIkc9ytg9vK9vl9enQyVRtGzT1GgBqSfxpXwOr
         NCkMLFEJVMv1P0g3ujW+6jpHIxhrHEsOFwoHepplmRVrFrsgWFlqgtBI59Oameuq1gyB
         QnciPbyt2dQ9lJhM2RKn4EIsIg9stCdkkrqPSYGooXPHHxg1c2Z2oP+ZhvUcnRHSEC3V
         /wZ6unlQdysWaJiBEVeKz0sCNIDGOFouMl0ifSJWjfzAYhdAFUDQX/nqf7VIxwPzpzrR
         PFsA==
X-Gm-Message-State: APjAAAWT2lauU/BSmb8ESLM8bZ1ZUJ0MYIY8VtL9JNwhbRDpt+HoV/MV
        R8l7Sm47QGIuzQV1ueM/T96H5mw8
X-Google-Smtp-Source: APXvYqwDJBUOsJ0QGdVPpwpsUSSp7G3j4PcG79viEXrVeyD/DHQUiyergVmtkVFit+A3hbV7EWu6lQ==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr8345372wru.122.1576179991267;
        Thu, 12 Dec 2019 11:46:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a20sm7579915wmd.19.2019.12.12.11.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 11:46:30 -0800 (PST)
Message-Id: <c466e79148028364873189eb6fe4a1db97fb100f.1576179987.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
References: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
        <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 19:46:26 +0000
Subject: [PATCH v3 3/4] git-p4: wrap patchRCSKeywords test to revert changes
 on failure
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

The patchRCSKeywords function has the potentional of throwing
an exception and this would leave files checked out in P4 and partially
modified.

Add a try-catch block around the patchRCSKeywords call and revert
the edited files in P4 before leaving the method.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 45c0175a68..97fad8d3f0 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1953,8 +1953,15 @@ def applyCommit(self, id):
                     # disable the read-only bit on windows.
                     if self.isWindows and file not in editedFiles:
                         os.chmod(file, stat.S_IWRITE)
-                    self.patchRCSKeywords(file, kwfiles[file])
-                    fixed_rcs_keywords = True
+                    
+                    try:
+                        self.patchRCSKeywords(file, kwfiles[file])
+                        fixed_rcs_keywords = True
+                    except:
+                        # We are throwing an exception, undo all open edits
+                        for f in editedFiles:
+                            p4_revert(f)
+                        raise
 
             if fixed_rcs_keywords:
                 print("Retrying the patch with RCS keywords cleaned up")
-- 
gitgitgadget


Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E4C2D0C3
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 14:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D82320684
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 14:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b813nMul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfLPOCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:02:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43789 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfLPOC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 09:02:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so7374708wre.10
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PLkOpxRjopd1grtaiqebV+fxUypmpyol1dinFMMeObI=;
        b=b813nMuljbGP5wkUT+3DIgJ0NY1nrNYsszQ+smwhw9t7GLj9pqGjeLzuPkKqtegzv+
         zEx788G/MgaXbwKiRhVA+rMSLOclQICrVHtZJgmQNIz6WNaOput0LgoPEZXn+8tAqYQS
         d/5vTWvkmWG27PE3McIU3CjQUITngdL0eHQcmwMdKPB2jlr7KOTdY62l+e82RneX7r5t
         veSNIaP0lV5vlZSkBQwt+4Tg13jlCCuRT/ct4yyli/u6JX6t+Qn1corYX/jhAcHMt+3U
         mwikmzAqtwVbdIgti0LGhx/bK2q5VApboOy3sF068oWBuyTWq8eS8fuIxpOejwT/GlQx
         3gTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PLkOpxRjopd1grtaiqebV+fxUypmpyol1dinFMMeObI=;
        b=Oq0nrUtzZQ2H2pQNxp7IQsFLzEqzV0Tv0UBLPMIKYi9e3T0ukVxmTG6lCFiJD/R5Ou
         byqn8dsueMliQhxvO8JDd+1MVd8yGDSqI74onSgdQr0uup3e3m9fSY2FgMWwpMhSxFYU
         t5w6ZIWjEwVfHB/FQcA1mImY0y/PwOlfViWuKja6nSBkZ2WC8v3mFWeKFWagcen+TvI9
         tWt3PohvmwxDR0K8iElm121SnYTWikVVM4vMoilttnEwBM684cUDBWnzSzOCCrl4z83n
         a57NIn/3P+m7cUyRS7h0r0A2V/CjkkIoNC32jDEM77EaZmU20BPdIGqeyPGkcX2ur+q0
         WAUg==
X-Gm-Message-State: APjAAAXjmtbeZcGDypkGGN5o6xWlmtTKxDXX972uq37XUurVJ27VWlMQ
        ja4JaMi7MjK5GsvOerWkv4pdbmj1
X-Google-Smtp-Source: APXvYqx6aV/6sD8afHgs7Ewux52IVCFjsTByi6E9CBVD9IREq8y5+4xAHNxikyqmlz0jJUTRnroyTQ==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr30402592wrt.366.1576504946062;
        Mon, 16 Dec 2019 06:02:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8sm21662908wrp.69.2019.12.16.06.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 06:02:25 -0800 (PST)
Message-Id: <81a09a122836703a3cbc3239a66c6e5c84ea2c74.1576504942.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
References: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
        <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 14:02:21 +0000
Subject: [PATCH v5 3/4] git-p4: wrap patchRCSKeywords test to revert changes
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
index 9165ada2fd..03969052c8 100755
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


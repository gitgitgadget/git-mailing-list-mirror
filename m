Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A963DC50727
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D586E24704
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaKcfkOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfLMN6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:58:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39149 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfLMN6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 08:58:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id d5so6647312wmb.4
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 05:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PLkOpxRjopd1grtaiqebV+fxUypmpyol1dinFMMeObI=;
        b=JaKcfkOIughAfXmecV2x/DKSYOliZtEJnwwlxaAQxCn2h0B+zTt7tfjAtByzyyQ8o5
         DpRmWH4uAFU8f1zTcOaI3PRJytQ3UCtw5hQWcvuGVsI4RMmGl7oXGfyQCfDAAGY3U0/9
         nB2VX2MtPX+wo+LqXs24/OpqPfFB/cRST+sZnp30E7VbjkuM3SVJHI7TK/gpPn+Ax0EP
         NZlYyZfnOre6WGcf59UDTBegNOPMm8GLDgAYFPUOqaNKQoPxwx7J26CCmkcyDiZqzhdw
         I85l1y38KkpRw2Heo2bgObNI7slFHMnvfH8gRK1od0wnjiONikMAgzbcDTNtqdvNb373
         V5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PLkOpxRjopd1grtaiqebV+fxUypmpyol1dinFMMeObI=;
        b=dEt7GQ3P+9cRmvdrZvLX+g1oIB6s0XUAOTuPILmkMsUFApig5D+H9zyeQ95oz4C57G
         TVL+yTfRZTpw+p/EPVnJbttcUwA5nKc974rMXdBTcnGQchzEbhP3Fh7P6bfdH4g6uTqV
         gGmbwnsABkNIoxpgaNFYaCca0tynemic7UqcGe9no8Fnqe9zH5g+Yif1IyuOlWmd18eT
         ieP1yAfUY+Mezz6IpbkrK2b6xXPjqT33GVTmvNiLwWRa1e+MG04hMVQxTfpDcJltcxw4
         N87TFUJ+LW9YiGxIi+eXuNlO41ktg/qI6hZxuTDrmfPcJXCUL6NIKx0dA5SZ+kIsuiEZ
         7egQ==
X-Gm-Message-State: APjAAAV3KMcjPFwpFUwmUq0roCSYwPZPBG91GXKtoejfV7RWyx/wRC+O
        bkoPzVh2NLXPh6ChG09Ke/qXpxJN
X-Google-Smtp-Source: APXvYqxb7JDozeu2aMSneBjwq3QosRrwl96wlvuqvzDD2gFOkndtooxXpOQMIZZnu9BSRRIpCh/ciQ==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr13383134wmg.170.1576245485099;
        Fri, 13 Dec 2019 05:58:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11sm10027240wrp.24.2019.12.13.05.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 05:58:04 -0800 (PST)
Message-Id: <20f63986935cd4ca850d0ecdbb5af5fa0658167b.1576245481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
References: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
        <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 13:58:00 +0000
Subject: [PATCH v4 3/4] git-p4: wrap patchRCSKeywords test to revert changes
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


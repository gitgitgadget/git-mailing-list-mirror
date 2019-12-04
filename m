Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EC6C43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 13:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B674A2077B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 13:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2S32aUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfLDNaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:30:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34448 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfLDNaN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 08:30:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id f4so4858245wmj.1
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 05:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r3EHS2UxPzIX3jxH3tBBW+1Vwe0WRR5HBdgi1rn46N8=;
        b=R2S32aUt/fxBFdVoUDvOpBkwTF53VTP61MRV1BT41SEfTJJuU9Kr5QB4/+ST0m/821
         UXbYidudYs5aIrXNz2uZeo3JugHZytH2pRIyF0jbJL3YW5H6/yucA0DBLFtckpuLCogf
         /2EFr2Ya3NCuUs0xoinpQhEMsPWZ5kTkvNn6CW7LqfeA+OEYh/zlDk9jypXVToRywMiz
         +delldJ6p0OJ4Why+2IJQQgyokNV3WzDHCEuAAwJEFDsrs47VdxiHj/XHry0QjPMULRO
         ZY1ukjVQp6oIfkWONENEq1x4vlCEBcCi2n2p9ordYc8hgXNRd4GOTKjo+8FACOQYTUQR
         u37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r3EHS2UxPzIX3jxH3tBBW+1Vwe0WRR5HBdgi1rn46N8=;
        b=L/q2NhmY9umb/LikJQxRHoYtLPXKxYfx7GXr3Kexutna+WrXUT1HERkCgDfr2dU36j
         suimfirG6yXrn5cbd0QXa3iN7/rL4zPcAY/BCHOC576OWApxOAQMwgB2h3ulmDiRC/6F
         KJDJ8LF4aSheQVoK+Ze50D3sATTMPf+RcDLxebs9YDrCMdHA8+Z0jzduSrsRDand+zwG
         bo7XLF36qKg0dwE0FocmY6Wa0afg4s7Ud3Xndf+XNp6arpQSTKps2v8bq0AeWHs1XN5D
         Y3uKDH2cwbrouRNGGdhx+Gpn5gbdub3I4BErKpxKAU+lRo19dkSuursOL/KvLdqFHzvd
         ZyJQ==
X-Gm-Message-State: APjAAAXnTgQQcYP9tLwXzN5K8YpaoNe4uRTFVVIriCWXjrX1Ecvx+94u
        qS8v86fNdc/Hdks2qd0jviQi65wG
X-Google-Smtp-Source: APXvYqztORWbXnI9Pq/peCVNiqbGqZSaVGPhIrf3/mFpLln82jxHqhTsFbp2pWlHaE1cDf8kZVkprQ==
X-Received: by 2002:a05:600c:290e:: with SMTP id i14mr39367013wmd.126.1575466211287;
        Wed, 04 Dec 2019 05:30:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm8032921wrr.75.2019.12.04.05.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 05:30:10 -0800 (PST)
Message-Id: <73d0dfc9dd7e6e800297b5084de84b727e28b900.1575466209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.483.git.1575466209.gitgitgadget@gmail.com>
References: <pull.483.git.1575466209.gitgitgadget@gmail.com>
From:   "panzercheg via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 13:30:09 +0000
Subject: [PATCH 1/1] git-p4: use lfs.storage instead of local .git/lfs Use
 lfs.storage if it defined in git.config. If lfs.storage not define - used
 local .git/lfs. Original code uses local .git/lfs in sync/clone operations,
 but if you have external lfs storage better to use it.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        panzercheg <panzercheg@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: panzercheg <panzercheg@gmail.com>

Signed-off-by: r.burenkov <panzercheg@gmail.com>
---
 git-p4.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..2bd0497c31 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1257,9 +1257,13 @@ def generatePointer(self, contentFile):
             pointerFile = re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)
 
         oid = re.search(r'^oid \w+:(\w+)', pointerFile, re.MULTILINE).group(1)
+        # if someone use external lfs.storage ( not in local repo git )
+        lfs_path = os.path.join(os.getcwd(), '.git', 'lfs')
+        if gitConfig('lfs.storage'):
+            lfs_path = gitConfig('lfs.storage')
         localLargeFile = os.path.join(
-            os.getcwd(),
-            '.git', 'lfs', 'objects', oid[:2], oid[2:4],
+            lfs_path,
+            'objects', oid[:2], oid[2:4],
             oid,
         )
         # LFS Spec states that pointer files should not have the executable bit set.
-- 
gitgitgadget

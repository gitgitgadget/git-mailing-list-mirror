Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04889C04E30
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF7C207FD
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 14:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/7fr5nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLIO2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:28:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46614 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLIO2q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 09:28:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so16331986wrl.13
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 06:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3sFU7MtcM1KdJV72KCQjmet37yl/mAC/mT4LGqrkZDI=;
        b=b/7fr5nqHlaN2HvWxVgd2Ev+O7hwUgAFDRCUgZhXPIsHB1DCZMJMgYjcGMXQyn7pra
         WTv0fFvH+jCFtm5ta6Mbn/BWyb068pPlU2WxbjmgUDIZ1db5Qi0eTZ3KpYh4wvkFyMQx
         scHVAHc5tbShvvjrf803+HlSfmjZwI0biKum2FVslcC8lRsTw6tyrnUeIaYP70lu8T/T
         kBlu2Q0WowJxQ7xX9n4MTygpeeiLPbbOTLKajNOLU8o7H6C7okdcn/IZJgpsSNWoPALE
         44Aw35tv4WsHD9H8uehLncXBOKUwGh4HIWJs8vDLAseYlWkCYbJUPLU/n6sb3Kutl8OL
         GEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3sFU7MtcM1KdJV72KCQjmet37yl/mAC/mT4LGqrkZDI=;
        b=oJhlyLlGgCo9NR2DeNm0r4KyQdfAtdrN5xgXiJbRNXVK6pDcUh3OD791sBPijKZWWc
         ddgKZYevqObV/54iiFDY1uyDUIFnhgBirmArjaGiWbNWPYxalGAzoQXag8G1LwNyz2u8
         JIA7u8gPrQMhMxFiocZUYv00jGrsgeCSHDQEPcivTyINHw5X4yyHmaSrOYVU7ne1he5s
         KRlBib0X73pkIBcRB4T0yitoRtRr+NZYyu6hmr7NqIPqZ+CjK9B8Z+kBQcJPWg3vNuvn
         G27Exli2UeI93NaRwUKa23X42a0yKpXm4+O+6/n+pDpyJNRjGOue/f821Aj6s6lHaII5
         hLWg==
X-Gm-Message-State: APjAAAWdH6RT3mzmTWHbRdH4kqTsaofHwBL3+jE1GS07yAim9PtZaPzc
        W22flAaDk0cHBKvYqAZnh6wp/Ojy
X-Google-Smtp-Source: APXvYqx/7qEHnmleW/IUVIZ4C8JEOmJ8oKQ5xPKjvDaLTgLfwzybI1eXAZs0PcGdSo9MSeuE71LTFA==
X-Received: by 2002:a05:6000:160d:: with SMTP id u13mr2609513wrb.22.1575901723842;
        Mon, 09 Dec 2019 06:28:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g74sm13584325wme.5.2019.12.09.06.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 06:28:43 -0800 (PST)
Message-Id: <e65375c528bdcdcc928dce8159edfccddcf77070.1575901722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.483.v2.git.1575901722.gitgitgadget@gmail.com>
References: <pull.483.git.1575466209.gitgitgadget@gmail.com>
        <pull.483.v2.git.1575901722.gitgitgadget@gmail.com>
From:   "panzercheg via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Dec 2019 14:28:42 +0000
Subject: [PATCH v2 1/1] "git lfs" allows users to specify the custom storage
 location by configuration variable lfs.storage, but when "git p4" interacts
 with GitLFS pointers, it always used the hardcoded default that is the
 .git/lfs/ directory, without paying attention to the configuration.
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

Use the value configured in lfs.storage, if exists, as all the
"git" operations do, for consistency.

Signed-off-by: r.burenkov <panzercheg@gmail.com>
---
 git-p4.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..0b3a07cb31 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1257,9 +1257,15 @@ def generatePointer(self, contentFile):
             pointerFile = re.sub(r'Git LFS pointer for.*\n\n', '', pointerFile)
 
         oid = re.search(r'^oid \w+:(\w+)', pointerFile, re.MULTILINE).group(1)
+        # if someone use external lfs.storage ( not in local repo git )
+        lfs_path = gitConfig('lfs.storage')
+        if not lfs_path:
+            lfs_path = 'lfs'
+        if not os.path.isabs(lfs_path):
+            lfs_path = os.path.join(os.getcwd(), '.git', lfs_path)
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

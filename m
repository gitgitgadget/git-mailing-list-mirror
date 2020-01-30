Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A438C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4902063A
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUz7wzhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgA3W6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:58:31 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55066 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgA3W6a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 17:58:30 -0500
Received: by mail-pf1-f201.google.com with SMTP id v14so2729787pfm.21
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YL+s1uBT/tGKtTuLK4XTiEME1o1pjfD/mVvItrtHb6s=;
        b=dUz7wzhzsfnTSsMdaaST7AeiUPC8OlUK2asUPeRSPAZqFGG10FtNcUNDhYuyh2JmdC
         W4yrVbNro2NAZYlT+QdhkRt+qiAJiU97msh0pyiRYHvM2DsCxPDzSmu0xl4K2RRRXC4h
         QatNzaVDMaUsyJP0tf/ISsvNkYwEuuddWNgIWa7JBGGyyM3s+VCgWJEkx+IQmyhfEtEs
         OUBQGRvcCMrECy9c27pppp0CFdzRtvlY0ZG+wo30QnwZki5D0IViTmp0LilgbPVnymK6
         MtS6E2wCcdPKcWJHjh1NKqkCuhUo3BsiQGd8blyMkQK5zDIHG7RMSIYiVWaInd2dPPuy
         GxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YL+s1uBT/tGKtTuLK4XTiEME1o1pjfD/mVvItrtHb6s=;
        b=MbpE/nY4YDKNqaY5xDBwlALrJ2EpL8ahvz0Q2Jpao+FBkDSbif/6lgkuiFPmZwSI+p
         1h+N815wGK7kXeb+2Qao2+KUkV+eQ71wYnMwJrokpwE3t187i2Wu01qEpahbAqust51P
         EiQNEcj0oKkyCnyFX066IpkDjwthlDifWCwTQXPc7Ljb0zFSjs9ZsbZBiYhmyeJzX1Zp
         oafwlDO35uJUZ90ZtzyhtG/ciIkoSEAIkl96lW8v7W4IcYRCbeM+LrHhblXPEcH9/gF3
         u/EEEDnlbHyKdYp7ax9ZI7aVwO2H4pdlqxsi1cRRyfvErKQcEGmf+lJwNN8Qhscp2b7G
         oiMA==
X-Gm-Message-State: APjAAAXIFRexxJkclfKXn/bBFAcms6rHkpRseAcwTz0D7QUyCy8DCaKN
        sp71wYxcbGClEFhCRH8r2h9HZD++ict8rYwuq75kgae8XV/AuPti2/45IH/WQpbxFJjNAAT2Xj1
        vr+drILdat701/oiNrnSkAH0sm4P/oBe75G5rM2UDcG75YKAbGc72/OywMXD74OrsOambeYbRWA
        ==
X-Google-Smtp-Source: APXvYqyo46fjiQ2VlA5ac+kAuBX1LM4xwM8fMxyrgDUNpMJDyy2lYwJgg2s8oWhkSZqyDu4ICgs5BqeXSntuL7EpIWo=
X-Received: by 2002:a63:de03:: with SMTP id f3mr7225005pgg.141.1580425109898;
 Thu, 30 Jan 2020 14:58:29 -0800 (PST)
Date:   Thu, 30 Jan 2020 14:58:18 -0800
Message-Id: <20200130225818.193825-1-masayasuzuki@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] doc: describe Git bundle format
From:   Masaya Suzuki <masayasuzuki@google.com>
To:     git@vger.kernel.org
Cc:     Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bundle format was not documented. Describe the format with ABNF and
explain the meaning of each part.

Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
---
 Documentation/technical/bundle-format.txt | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/technical/bundle-format.txt

diff --git a/Documentation/technical/bundle-format.txt b/Documentation/technical/bundle-format.txt
new file mode 100644
index 0000000000..dbb80225b5
--- /dev/null
+++ b/Documentation/technical/bundle-format.txt
@@ -0,0 +1,40 @@
+= Git bundle v2 format
+
+The Git bundle format is a format that represents both refs and Git objects.
+
+== Format
+
+We will use ABNF notation to define the Git bundle format. See
+protocol-common.txt for the details.
+
+----
+bundle    = signature references pack
+signature = "# v2 git bundle" LF
+
+references   = *(prerequisite / ref) LF
+prerequisite = "-" obj-id SP comment LF
+comment      = *CHAR
+ref          = obj-id SP refname LF
+
+pack         = ... ; packfile
+----
+
+== Semantics
+
+A Git bundle consists of three parts.
+
+*   Prerequisites: Optional list of objects that are not included in the bundle
+    file. A bundle can reference these prerequisite objects (or it can reference
+    the objects reachable from the prerequisite objects). The bundle itself
+    might not contain those objects.
+*   References: Mapping of ref names to objects.
+*   Git objects: Commit, tree, blob, and tags. These are included in the pack
+    format.
+
+If a bundle contains prerequisites, it means the bundle has a thin pack and the
+bundle alone is not enough for resolving all objects. When you read such
+bundles, you should have those missing objects beforehand.
+
+In the bundle format, there can be a comment following a prerequisite obj-id.
+This is a comment and it has no specific meaning. When you write a bundle, you
+can put any string here. When you read a bundle, you can ignore this part.
-- 
2.25.0.341.g760bfbb309-goog


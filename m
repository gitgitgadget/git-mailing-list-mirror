Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 248201F404
	for <e@80x24.org>; Sun,  4 Feb 2018 22:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBDWNP (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 17:13:15 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:47046 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeBDWNL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 17:13:11 -0500
Received: by mail-wr0-f193.google.com with SMTP id 35so901312wrb.13
        for <git@vger.kernel.org>; Sun, 04 Feb 2018 14:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UvS0Jb9ydDl/TESLg8k/1ONClFEgtOxwgexhhoQdJOc=;
        b=AtZtQ7UM60tWMFC4HsXoojyZUJkX3lIsLW9Q4NmScLNG7+ekZpa5xzJUbbyVMtLusM
         KNx79IqwkCLrXR5utPoKCIeI/EABAKpEiKZ0OWWqGPGc+kyIZgIu638RJRsMRAgx7osr
         d9RbqKzgCFkUv09d46ZWsJbAqjDLoHFCVqLnWh2u39CgO2XBFXBklDXRnFg+hxNWAw76
         jO2p4l+2HK5g9erhZgRceBe+jNn50GUIUQcreconxuWaCizAxJI7SYjcmx2R7dRoxTkD
         e8XsouXx9OaTmHyGlbCVQHAyCo2eU4fXT60QQLG4Pastmwv1nYsRN5OWUUcSMXNg4Iy5
         vrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UvS0Jb9ydDl/TESLg8k/1ONClFEgtOxwgexhhoQdJOc=;
        b=mWY70dNKjDqc7c2A7cWpbq4aEbST9VeHGDgziN6InhCQsSl/VPW7qCmQr2dCn9BNfY
         4a07stfya0JYZLU0fb/CxhUiDQZCRHlWO+T0waLOWJutFtdGPJNUy3uE0HXftkMak0HL
         98y9b76UwrAPbpMVrDU5QeS/NLqqMU8sctDAHkghBEnUZV+jMi/FAOjCv8XieU6f8Nu5
         +lhLdHJzBPysF1CC/A9v5gDWHMa1VuRql35j+1bwV+Y/0JdFCcaErL1T748Ad5qTlWO+
         L1ofDdGRSPR2I18tYetK4a5Ai9zeq7wOHR7AR3HgNhp5Y8SgH7h0Q0XWrwJ3Mpwkcfa/
         TFMQ==
X-Gm-Message-State: AKwxytce0aoj0WSLahkZPtpDxivN/gao9/S9FlVctmDQukSOok3Ro4x+
        BgpOQsDH4tXX3MpOMUzkupy7wo1r
X-Google-Smtp-Source: AH8x224YohIbUiKojCGaE+vYCyhC5IYVjlgQyAucujBM7triJGEGMHc2kAxCJO2mSJhgi6ez/3Bnzw==
X-Received: by 10.223.195.67 with SMTP id e3mr30482621wrg.42.1517782389709;
        Sun, 04 Feb 2018 14:13:09 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id e67sm15198596wmf.7.2018.02.04.14.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Feb 2018 14:13:08 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/3] worktree: be clearer when "add" dwim-ery kicks in
Date:   Sun,  4 Feb 2018 22:13:04 +0000
Message-Id: <20180204221305.28300-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.101.gde0f0111ea
In-Reply-To: <20180204221305.28300-1-t.gummerer@gmail.com>
References: <20180121120208.12760-1-t.gummerer@gmail.com>
 <20180204221305.28300-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently there is no indication in the "git worktree add" output that
a new branch was created.  This would be especially useful information
in the case where the dwim of "git worktree add <path>" kicks in, as the
user didn't explicitly ask for a new branch, but we create one from
them.

Print some additional output showing that a branch was created and the
branch name to help the user.

This will also be useful in the next commit, which introduces a new kind
of dwim-ery of checking out the branch if it exists instead of refusing
to create a new worktree in that case, and where it's nice to tell the
user which kind of dwim-ery kicked in.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d1549e441d..74a853c2a3 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -320,6 +320,9 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
+	if (opts->new_branch)
+		fprintf(stderr, _(", creating new branch '%s'"), opts->new_branch);
+
 	fprintf(stderr, _(", setting HEAD to %s"),
 		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
 
-- 
2.16.1.101.gde0f0111ea


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E16FC43381
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC3064E04
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 18:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhA2SYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhA2SXf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 13:23:35 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF13C061756
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:22:50 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d13so5706747plg.0
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 10:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ViXmFBzQ+/qpchAFb5bLM28xzO1lcwQ8ijh1Mo/eRpI=;
        b=Te4iUqLoK/IpGBiL91inJGzy04sQosRsVHwffiwKVSWpMeZr8sQMvP0teHmBUXj2wH
         kT3wjse2JRhtrSFm0e4XZZV+7iHvSDshT+XXyBdox37jERfGLZVsVNiwI1lTscDRocY6
         J9h9rFMER8SEzZDVJoPqFrWQPQmoWBHQrcWlSDLpiqQV+fHsZJRu5Oon7QbrQqAYiLo7
         JEUQ7x2s9KkGFF7gKHIXMW8tDDahdTK5bTaX3AddaPQ8jHG+4//68X148gPzMeywnObv
         XMAoV0LjG/pD8zppJnNPAdN5Iz/GGFL4AuvQe1mbi3P4rX1O3ro3YxRTo0UwPPLzey4t
         UX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ViXmFBzQ+/qpchAFb5bLM28xzO1lcwQ8ijh1Mo/eRpI=;
        b=N1tI1+VjhnGM1Zk/xoH8hZoL2g1XQSolmQbj0/LMxuT+QjNX7zaKVKkIrETPpyomKj
         7Ex3GKsyOPnBrqQCxTaItdIupb7tB3n0B/x9Yb/5ddcEpydJIFXeJ+G8z7Ggbf0IwWMh
         9nvDWTtcJQGOkN+9BKCfvI+k58V3xv7AoqqExmY/5l8QDbSeZm1uYf2mMClBLftigMUa
         d1EpuJiwH6cZ9xeTmbQh4byVA7zeFBMg8SpxXWTzF3ywOxbY2TQjdODnFAb5BV5F7ssQ
         2H2xdIIEzfYt4oW18ZSZFkLV8JMojlemCz7Rv+9j6dip/8urf2l7do1KwvTLFK2xivHH
         stbA==
X-Gm-Message-State: AOAM531d8gu8Zn9vuru4MvILOKY+VLUsFXpbR5MsB6nK8zArtuUVC21X
        xql5VusQ9RlLLwGS/TmkXYvz8/Yu+f8=
X-Google-Smtp-Source: ABdhPJyz+AoySB1kxAi3rDswnkZzzIhibUkJFsWlamZO4TgxFTuuu5PGvZgkeSt/bLKQLvUm2hrjuQ==
X-Received: by 2002:a17:902:9f8b:b029:e0:a90:b62 with SMTP id g11-20020a1709029f8bb02900e00a900b62mr5467086plq.70.1611944570067;
        Fri, 29 Jan 2021 10:22:50 -0800 (PST)
Received: from localhost.localdomain ([2402:8100:396a:4597:fd76:2af1:5584:160e])
        by smtp.googlemail.com with ESMTPSA id x141sm9497834pfc.128.2021.01.29.10.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 10:22:49 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, phillip.wood123@gmail.com,
        Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH v4 9/9] doc/git-rebase: add documentation for fixup [-C|-c] options
Date:   Fri, 29 Jan 2021 23:50:50 +0530
Message-Id: <20210129182050.26143-10-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210129182050.26143-1-charvi077@gmail.com>
References: <20210124170405.30583-1-charvi077@gmail.com>
 <20210129182050.26143-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Marc Branchaud <marcnarc@xiplink.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 Documentation/git-rebase.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a0487b5cc5..a6903419c4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -887,9 +887,17 @@ If you want to fold two or more commits into one, replace the command
 "pick" for the second and subsequent commits with "squash" or "fixup".
 If the commits had different authors, the folded commit will be
 attributed to the author of the first commit.  The suggested commit
-message for the folded commit is the concatenation of the commit
-messages of the first commit and of those with the "squash" command,
-but omits the commit messages of commits with the "fixup" command.
+message for the folded commit is the concatenation of the first
+commit's message with those identified by "squash" commands, omitting the
+messages of commits identified by "fixup" commands, unless "fixup -c"
+is used.  In that case the suggested commit message is only the message
+of the "fixup -c" commit, and an editor is opened allowing you to edit
+the message.  The contents (patch) of the "fixup -c" commit are still
+incorporated into the folded commit. If there is more than one "fixup -c"
+commit, the message from the last last one is used.  You can also use
+"fixup -C" to get the same behavior as "fixup -c" except without opening
+an editor.
+
 
 'git rebase' will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
-- 
2.29.0.rc1


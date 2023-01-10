Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F7EC54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 13:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbjAJNP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbjAJNP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 08:15:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA413FA1F
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:15:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ay40so8761153wmb.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5aPED1uDz8pjLLfA3pRQirKJaCrHhp0HaOqnh1rWgA=;
        b=IvmDOR6tMgSw872uHS+fUxi5FM9k94tXzUKRXKANvKHplR08NhQEhwRrSQTWvH5rJa
         y+acnHskz4YzZB663KtdRT8Sc6LMwB1WEMOvnyP80RnvHcaaIRBiOdzQ8wBMeHd0adEi
         kP0AiTa6MAK07nOTcmQHwA3mC6QWn4FbThI6l4ZzxChLrxEBTaLAKWifI6mtueba662h
         LjbLotdURcxho4dlUpkUJ3cYZi79zPJ8WSn2w7TFQ3QS2u3BHnTyJJyet4phXj8cT2fR
         KziZr88eYqvyoS6c7/GCV8HyZpSjPH/tLc7z6NVzoaIvwK4Bue6yVa54iZ9zE4Mp1rc7
         gWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5aPED1uDz8pjLLfA3pRQirKJaCrHhp0HaOqnh1rWgA=;
        b=R3oNYa5+aDW+EsuwE2AW/4SVkrVexlbBoteyUf18iD9POjWk9TvVwx46kn7uxaS1KA
         AGDHCVTGoibhvbk8ShnP1e3PnGhtVl9yNeFkUy5QoniLkLMTP4WuSmUWgOTUPSCHWVgx
         A2twZ5rfg5Ab+Nkoj865JHCHSUL+mnBF9RpIWpkHTbR+FmnVlc8xsTc+ZZ3Q7SvmEXeA
         PUaKao5x5KzQN3qhqeMZRe2UmItPKpXcm4T3unm3Zxr6jQHqsoAw/mAhaDJHqqMDoFcZ
         NVzlJfDx/dtfpQ9Y5EUenoQIqWQ1y58U0qdVqLdrBArlmh2O9IAI5cAi6XutqDVqWtKv
         AEKg==
X-Gm-Message-State: AFqh2kqkK4KTMrVpputbHh7UirAEFUGw05Ty2aYxdb/gUSuA2gu9BLxN
        JDxXAUtfQfznVMi18ugR64Y9ku3mwd8=
X-Google-Smtp-Source: AMrXdXu4TfDbUIkJBBB+e6JaqDMcNOIz5Ev0LAjZ5U23fa/uytazPlVdjHg5xVpihSP8GvSskCpxFw==
X-Received: by 2002:a05:600c:3c8a:b0:3d9:cc40:a8dc with SMTP id bg10-20020a05600c3c8a00b003d9cc40a8dcmr16785763wmb.27.1673356525622;
        Tue, 10 Jan 2023 05:15:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s23-20020a1cf217000000b003d1e3b1624dsm19414350wmc.2.2023.01.10.05.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:15:25 -0800 (PST)
Message-Id: <e488ad3ce1d2e227f5440fc04d0f6aeb6347a82a.1673356522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
        <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Jan 2023 13:15:19 +0000
Subject: [PATCH v2 3/5] git-merge.txt: mention 'ORIG_HEAD' in the Description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The fact that 'git merge' writes 'ORIG_HEAD' before performing the merge
is missing from the documentation of the command.

Mention it in the 'Description' section.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-merge.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 2d6a1391c89..0aeff572a59 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -37,7 +37,8 @@ Then "`git merge topic`" will replay the changes made on the
 `topic` branch since it diverged from `master` (i.e., `E`) until
 its current commit (`C`) on top of `master`, and record the result
 in a new commit along with the names of the two parent commits and
-a log message from the user describing the changes.
+a log message from the user describing the changes. Before the operation,
+`ORIG_HEAD` is set to the tip of the current branch (`C`).
 
 ------------
 	  A---B---C topic
-- 
gitgitgadget


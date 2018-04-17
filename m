Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07FCA1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeDQSTo (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:19:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42965 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeDQSTn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:19:43 -0400
Received: by mail-pl0-f65.google.com with SMTP id t20-v6so12442836ply.9
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 11:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ObSXVoXvP7e8sehTNiuoy3pUO19P3oJOTkhiraXQXGU=;
        b=HhLEVRulbw5NyN52qklp/OKFjlRr1zdpCXiFNnoA2xjtiHIoppbq3DQhJkU0zPHFk+
         3en7FffewKwwVQCfQmSuX68M7YYOKKyKTpWwdBO23C7FpSr2V+p94AzC0SFNrclRpTJR
         ok/Ff3AJPYgqQd743Lp6DqL/2dj315sZIfsonmqFTPcxRlJAqoT62ujD9esI2l7KCZBy
         Ro8p6prDPSVgdF3+W3sMJS7fL2C8YT0F1GTQAH/tEDx2ThVuUHqb8qEp9RarIdChOK2g
         Yftegx3Vv0gEOs72miyeCC1xHJmniIXekg1RWg/f96sov2FEQBPPHvH1yzhaYaKsrTka
         /vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ObSXVoXvP7e8sehTNiuoy3pUO19P3oJOTkhiraXQXGU=;
        b=qVrBHo50U5C3UgKwXIXbgHVVuekVZay12WnkePw2E/eIDJhJ0zVS7OgyEq16dWVd7Q
         LqPVZE/NBJYzzvxwefTG6RnYzYcWEOh33mMiJFPSFhXkIsb2J+3gCiSvqWC5lNEKD8zK
         XmI0l+Tmgxzbap2AuHsqW0oZlSit44bnXQ5KyWKV6RmK8BL2+0macSdbic8EsCb5z5kn
         vp1cM1MJJIyhyfFQAyzV+fc5ljjIe7iDMiHkzQo6aEo+r6FFhEdCQollbeSiB9RbZin3
         jxNm9TpU2l5dKQH+8o03pn0o1/fA8nqTAE06qjZcRKPsp0cBDMOHu64uLwPQmu7oaN9b
         R1dg==
X-Gm-Message-State: ALQs6tCv0kQEHyrb4mwvLGYzJaF7WvYUTLiWTQZ/m2pSG0YAPVqFprwz
        P6gJsVKvX47J30jg0PUpQrUXbA==
X-Google-Smtp-Source: AIpwx4/0uct/Lx8McD7T8DZOJ0MU8PGy/6Nzx6xZGrugpe/Nk4mB3sHk+3nTX88kB87GqYqDfcsSwQ==
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3-v6mr3051258plt.142.1523989182342;
        Tue, 17 Apr 2018 11:19:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j125sm40611974pfg.188.2018.04.17.11.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 11:19:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sbeller@google.com
Subject: [PATCH] worktree: accept -f as short for --force for removal
Date:   Tue, 17 Apr 2018 11:19:39 -0700
Message-Id: <20180417181939.247898-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <CAPig+cSHmxtsz2NNAFvbqXRFKE87ZVyUYpRigjgXE5p8LcR09A@mail.gmail.com>
References: <CAPig+cSHmxtsz2NNAFvbqXRFKE87ZVyUYpRigjgXE5p8LcR09A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The force flag is very common in many commands and is commonly
abbreviated with '-f', so add that to worktree removal, too by using
OPT__FORCE instead of a self cooked OPT_BOOL for force.
While at it, add the PARSE_OPT_NOCOMPLETE flag to the force command line
option as forcing a removal may lose files.

The short form of "-f" is already documented in the man page,
so we do not have to adjust the docs.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

> Should this be using OPT__FORCE, rather than OPT_BOOL, to be
> consistent with worktree.c:add()?

yes it should.

> Also, can you amend the commit message to mention that "git worktree
> remove -f" was already documented, and that it was only the
> implementation which was lacking? Thanks.

done.
I tried to clear up the docs, but after reading them a couple times,
it looks good as-is.

 Documentation/git-worktree.txt | 2 +-
 builtin/worktree.c             | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index e7eb24ab85..99b713c849 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
 'git worktree prune' [-n] [-v] [--expire <expire>]
-'git worktree remove' [--force] <worktree>
+'git worktree remove' [-f] <worktree>
 'git worktree unlock' <worktree>
 
 DESCRIPTION
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 40a438ed6c..30647b30c5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -783,8 +783,9 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
 {
 	int force = 0;
 	struct option options[] = {
-		OPT_BOOL(0, "force", &force,
-			 N_("force removing even if the worktree is dirty")),
+		OPT__FORCE(&force,
+			 N_("force removing even if the worktree is dirty"),
+			 PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
 	struct worktree **worktrees, *wt;
-- 
2.17.0.255.g8bfb7c0704


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D561F462
	for <e@80x24.org>; Tue, 11 Jun 2019 07:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403992AbfFKHeT (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 03:34:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36044 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403920AbfFKHeT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 03:34:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id d21so4722774plr.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lt3rHLEvx7RITjW1oSc323BVHMrwBrvnwYJ9C9Hy+1Q=;
        b=llZk/5otTqFc4dfcqhbltrXjZbJDfCIj+IBzKAJdUdP8rPqaudA8omZn0VMTZ9br1M
         HgbiWv9iMpFwgdG0G3Ad0EuICxQs1KDCio8DiCKw09EF+vqe7HYwU9WjS7fBNqSWWFdL
         baSu0TONxqsoSwXhuwJ92VtrMCj+2+nIX3ok33okQzlnFMPXcWAMC3kylblfBUeBZaNV
         ZlDZnZFs/vYnyPIdlTIMWKTCHm7k/3eTVNKx8OtBwraE4Ass7QzHH2YNajKGrwqHwF0Q
         I/UDpysJQg1s867jdy1XtUji5AehpmsJ9FiIS5+VZhFD2X2ujhRhYtdzLhR9c6FDfGL5
         qRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lt3rHLEvx7RITjW1oSc323BVHMrwBrvnwYJ9C9Hy+1Q=;
        b=L5q/w6mDb8wMLmMRGjiuwuxaC1OWrdcESVr1votY0hAG9tPIfB7YVTVY+N2gTlSl1i
         zAFE/gwBkdzLj4iJLv4FymXYp3vdZ9/C0bVFhcEhLk+jr8zHlo8/f1kYRWmYy1FCYhGC
         Ua1A2sIvbpyqIzS22qqRzd9jw0NxsqHXQq4TCxrhqBs1rtoXwrRbNpgiqmk6pizMkJoS
         mEJ+13VZadfSgrUG67RN2/WqrwYLUuFU1eSS+81tJsrx4Uyv8ILGepAuSmPqohYFfaXQ
         uyjrmWVmdRLp8IK9orQ1iLLBFwtE5R8jbpJ5sD6tz96g8dPv6+IYVLIjjm2S4/XuE51M
         HZBA==
X-Gm-Message-State: APjAAAU0So/+v6U9Eh0+hnURuUZXGW9wvk9rDm/KPuUgcl1TCiu7Lpa6
        pL9zFJGlWfP1Qd0AGQT0AiKi303t7hY=
X-Google-Smtp-Source: APXvYqywOpc5pgsmzxNVjarlPi0FMuwBSVJq2au2/awVg5OBRIUBFRj8b7m15EZG9TDa6RpJIKc9OQ==
X-Received: by 2002:a17:902:e306:: with SMTP id cg6mr44496836plb.341.1560238458424;
        Tue, 11 Jun 2019 00:34:18 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:310c:9b37:39e2:17f3:788e:3d39])
        by smtp.gmail.com with ESMTPSA id m16sm7166022pfd.127.2019.06.11.00.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 00:34:17 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v2 1/3] sequencer: add advice for revert
Date:   Tue, 11 Jun 2019 13:01:50 +0530
Message-Id: <20190611073152.12214-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611073152.12214-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190611073152.12214-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case of merge conflicts, while performing a revert, we are
currently advised to use `git cherry-pick --<sequencer-options>`
of which --continue is incompatible for continuing the revert.
Introduce a separate advice message for `git revert`. Also change
the signature of `create_seq_dir` to handle which advice to display
selectively.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
what has changed:
    Following Phillip's advice, I've changed the signature of `create_seq_dir`
    to selectively handle which advice to display.

 sequencer.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..ffb0257f0f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2650,15 +2650,30 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	return 0;
 }
 
-static int create_seq_dir(void)
+static int create_seq_dir(struct repository *r)
 {
-	if (file_exists(git_path_seq_dir())) {
-		error(_("a cherry-pick or revert is already in progress"));
-		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
-		return -1;
-	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
+	enum replay_action action;
+
+	if (!sequencer_get_last_command(r, &action)) {
+		switch (action) {
+		case REPLAY_REVERT:
+		case REPLAY_PICK:
+			error(_("a %s is already in progress"),
+				 action == REPLAY_REVERT ?
+				 "revert" : "cherry-pick");
+			advise(_("try \"git %s (--continue | "
+				 "--quit | --abort)\""),
+				 action == REPLAY_REVERT ?
+				 "revert" : "cherry-pick");
+			return -1;
+		default:
+			BUG(_("the control must not reach here"));
+		}
+	}
+	if (mkdir(git_path_seq_dir(), 0777) < 0)
 		return error_errno(_("could not create sequencer directory '%s'"),
 				   git_path_seq_dir());
+
 	return 0;
 }
 
@@ -4237,7 +4252,7 @@ int sequencer_pick_revisions(struct repository *r,
 	 */
 
 	if (walk_revs_populate_todo(&todo_list, opts) ||
-			create_seq_dir() < 0)
+			create_seq_dir(r) < 0)
 		return -1;
 	if (get_oid("HEAD", &oid) && (opts->action == REPLAY_REVERT))
 		return error(_("can't revert as initial commit"));
-- 
2.21.0


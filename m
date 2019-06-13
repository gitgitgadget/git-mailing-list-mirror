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
	by dcvr.yhbt.net (Postfix) with ESMTP id B4CFB1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbfFMQuV (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:50:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37904 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfFMEHe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 00:07:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so7527618plb.5
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 21:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O3aYefNN6DzxowTl9BdbuF0WRguaHs82SKUBeedkOHU=;
        b=T+hhqQecVlLLORf5yNKX09bnYp/sZuXnM54QMdPnj4l14pC1FMC0p/NWCT5CycAjs6
         u8PSaU1nWlL81Fwn6JHdG7yi+L/FlK7uFmAO23TU0VMtiV1XfzkHQwACTY59Sz47c9z7
         31IAssF/p3n1o9bu26erUENrKeHZhdaIE31/ktXCiD0acWfkX2GYWDMVhXMGQlRBUvDK
         XtYgiouigA2tWhBP6+Pq93WOyNuAspntszAqeWIs4lpXsOl7LOQlEYbEgEvfyDuw7/cF
         R13nGxslHsQGjXn3tw9vnsJ1jEvab3LmI6/L93mudu0Oq0vbgDpbC5l4BNwQFgyS5VgG
         8aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O3aYefNN6DzxowTl9BdbuF0WRguaHs82SKUBeedkOHU=;
        b=iHhb96P6PlhBo/AhWrV43++qZGj/vPbq+uNYbsiMRR4P7X8uR6d6ep/5UvyrwVz0cB
         c1iIi7vvOS5mTu1eusvn/m2oNAmfWVWRzl5MWaJaWSQfIkxY7KZL9gevlEB45eR7GpI9
         4vaCyk5z10+EU0JR/6Dyc5ZQM5f4mZTpX4QpU0Gg/x3MuCrEBcjMwKPJf7j7/OkuApv2
         RPf8FKRKB4pSxAOtvdxAmTZx8G72EoMkqHHoU/VX/3dMX9L+rRiOAF7FInOwCBYeCjGC
         Bd0fHwNpt83saU2nwHGZOEI/caeSUyDeEqnTA2AapXpZba/KCDaQR3T/Lw7XhGzweaeZ
         5lpg==
X-Gm-Message-State: APjAAAVW/ySGDart5hqOlXOpGVI7F6CVlXVT95kBmxWSDtZkgq38Yr1J
        xc6692ijAx9esdeSZUy0iRY=
X-Google-Smtp-Source: APXvYqxAqudq9r/PJj0nl6KSUuFVmGEBmqtq0M+1FC8/ymHh7RS2NBpb5ZXxneSeZilEQb9EhYjahA==
X-Received: by 2002:a17:902:a412:: with SMTP id p18mr17215886plq.105.1560398853448;
        Wed, 12 Jun 2019 21:07:33 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3105:2894:35ed:6485:6224:95ac])
        by smtp.gmail.com with ESMTPSA id k197sm1073288pgc.22.2019.06.12.21.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 21:07:32 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v3 1/3] sequencer: add advice for revert
Date:   Thu, 13 Jun 2019 09:35:02 +0530
Message-Id: <20190613040504.32317-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190613040504.32317-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190613040504.32317-1-rohit.ashiwal265@gmail.com>
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
changes:
    - Following Junio's advice[1], I've changed how we're handling error and
      advice fundamentally.

[1]: https://public-inbox.org/git/20190608191958.4593-1-rohit.ashiwal265@gmail.com/T/#mf8eefb068b7246c7c2a02cc8f7120a1a903a1eba

 sequencer.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..918cb5d761 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2650,15 +2650,37 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	return 0;
 }
 
-static int create_seq_dir(void)
+static int create_seq_dir(struct repository *r)
 {
-	if (file_exists(git_path_seq_dir())) {
-		error(_("a cherry-pick or revert is already in progress"));
-		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
+	enum replay_action action;
+	const char *in_progress_advice;
+	const char *in_progress_error = NULL;
+
+	if (!sequencer_get_last_command(r, &action)) {
+		switch (action) {
+		case REPLAY_REVERT:
+			in_progress_error = _("revert is already in progress");
+			in_progress_advice =
+			_("try \"git revert (--continue | --abort | --quit)\"");
+			break;
+		case REPLAY_PICK:
+			in_progress_error = _("cherry-pick is already in progress");
+			in_progress_advice =
+			_("try \"git cherry-pick (--continue | --abort | --quit)\"");
+			break;
+		default:
+			BUG(_("the control must not reach here"));
+		}
+	}
+	if (in_progress_error) {
+		error("%s", in_progress_error);
+		advise("%s", in_progress_advice);
 		return -1;
-	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
+	}
+	if (mkdir(git_path_seq_dir(), 0777) < 0)
 		return error_errno(_("could not create sequencer directory '%s'"),
 				   git_path_seq_dir());
+
 	return 0;
 }
 
@@ -4237,7 +4259,7 @@ int sequencer_pick_revisions(struct repository *r,
 	 */
 
 	if (walk_revs_populate_todo(&todo_list, opts) ||
-			create_seq_dir() < 0)
+			create_seq_dir(r) < 0)
 		return -1;
 	if (get_oid("HEAD", &oid) && (opts->action == REPLAY_REVERT))
 		return error(_("can't revert as initial commit"));
-- 
2.21.0


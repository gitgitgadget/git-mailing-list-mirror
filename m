Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9288B1F461
	for <e@80x24.org>; Sun, 23 Jun 2019 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFWUGH (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 16:06:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35352 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFWUGH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 16:06:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so5930813pgl.2
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 13:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8YQUHvJD4DvbM6l96Vp9ZUv5oAEHyEStYs69WrbSj/Q=;
        b=mwKIrAQeQZHhCjTqY6kA6OW8ywBxMQswshw05sDtvwJhjWC4qYF5nvW+jZ1G/c6Sfq
         Ki1KkZy05WNy+dhKUMO8TaGU1cXV6zXVZGCbiU6NKb5x4FtwSnrtTDKBIDNw+XzmRmhw
         SR3mmX9vlXn/1ZABkasvHuap8B+HnF/HabRTkxGhjLoIPdwHKUjqEcb9BdUYnVwfmdVI
         KEhZl3+Zgo7mYh+rbDU71KXFIF3Pcf3mbTUUZPkkwRzpa63bcC49UeBm801n2D4hy6XL
         XpzFSbk77kOEs3IuptHKF4zLogb14vlE92p7GWcXoghBRGJGp0KQEFEraE0BLl/Yn+kQ
         wpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8YQUHvJD4DvbM6l96Vp9ZUv5oAEHyEStYs69WrbSj/Q=;
        b=LPeRw0Km8g04Ya30BplTQGZzy/vjdC14N9i3UpQKYOHX3DYEGRKRUK0Nh/5xs1Zv78
         PVXiI499Enxsz9h1gYqsA3ONmluEC4MYadlLTK5+mkEN4IcGcbgnIA9TZ/6iiojmZfvC
         QYhhnVB4RByXDEEVvMOuSVrZRb+uPnd/dcdzMhjXJXzXtGGuWj9VMVZ7xNlfn9FW1zZJ
         twZ8wmEle3xuQm5hnINeg9Mo+GBaeO2xK8xSh/DMx2vOL2kN8QuJsXGn6zX1ELt0vdPx
         7zI58RIeN1ST8XRSv0O6RcdgDOod5JtP7d0AQ9FbUFnQyb3G38NvHCfp1oCq068TMotR
         gtPw==
X-Gm-Message-State: APjAAAX5JGScf0TtHGaa6+m0o1k0jsfU1SPv76ka1+21+a2YmJSsQvIS
        w0fVqRLGkagZbZvFdy3VA+ZgbgW1DfA=
X-Google-Smtp-Source: APXvYqxoDT9ciEbEQlLwOA8MadjXAXPj07u9hMPY5KwPLPeBRZIk2KwpFHmO5caPfgDHiGZ63tDW7g==
X-Received: by 2002:a17:90a:bc0c:: with SMTP id w12mr19348604pjr.111.1561320366826;
        Sun, 23 Jun 2019 13:06:06 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.213])
        by smtp.gmail.com with ESMTPSA id 27sm8621882pgt.6.2019.06.23.13.06.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 13:06:06 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com,
        martin.agren@gmail.com
Subject: [GSoC][PATCH v7 2/6] sequencer: add advice for revert
Date:   Mon, 24 Jun 2019 01:33:34 +0530
Message-Id: <20190623200338.17144-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190623200338.17144-1-rohit.ashiwal265@gmail.com>
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
 sequencer.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..0ef2622a69 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2650,15 +2650,38 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 	return 0;
 }
 
-static int create_seq_dir(void)
+static int create_seq_dir(struct repository *r)
 {
-	if (file_exists(git_path_seq_dir())) {
-		error(_("a cherry-pick or revert is already in progress"));
-		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
+	enum replay_action action;
+	const char *in_progress_error = NULL;
+	const char *in_progress_advice = NULL;
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
+			BUG("unexpected action in create_seq_dir");
+		}
+	}
+	if (in_progress_error) {
+		error("%s", in_progress_error);
+		if (advice_sequencer_in_use)
+			advise("%s", in_progress_advice);
 		return -1;
-	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
+	}
+	if (mkdir(git_path_seq_dir(), 0777) < 0)
 		return error_errno(_("could not create sequencer directory '%s'"),
 				   git_path_seq_dir());
+
 	return 0;
 }
 
@@ -4237,7 +4260,7 @@ int sequencer_pick_revisions(struct repository *r,
 	 */
 
 	if (walk_revs_populate_todo(&todo_list, opts) ||
-			create_seq_dir() < 0)
+			create_seq_dir(r) < 0)
 		return -1;
 	if (get_oid("HEAD", &oid) && (opts->action == REPLAY_REVERT))
 		return error(_("can't revert as initial commit"));
-- 
2.21.0


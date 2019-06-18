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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3923E1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 17:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfFRRJP (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 13:09:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37434 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRRJO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 13:09:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so8029243pfa.4
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fv2/e3T5aX9EN1/FCoKHc+hGcL1Rz+Nul1DYvV3s688=;
        b=nXht/UENBhBvp1IvGE/OMGhzjVdzt4qHwknBp1x2REOGb5YrzZCsiQtuKX1p4z78CR
         aPPs1He3kRvLhAHDmWaUDYcN8ubePv7ueOt9VUNrj+DN105rtThXLYdiNmnhZdHt3W+L
         F2lRXbecKJsd/gLofD8aCn9mziZP4xdgZaBqjtO71d6UanY+IuhMvJq99ulNYe10Twcj
         kmrjj9mctz3kzl2RaG1MvKWeyke7kAUHq023k1HmpoNJwGTc642785kaZHp0kz58k3mO
         gEo4QKbX3SA8bpTEVr9tTyfEK8LOeMp5jznFezPC2QJofOn8ejyDiF6S2BsmAyQGQ1Z2
         t0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fv2/e3T5aX9EN1/FCoKHc+hGcL1Rz+Nul1DYvV3s688=;
        b=G4FEoXWjCxJC99q3t1Mrt6WSUNkaqaWTIJD4RfXdTc7jjeSy64hmuw9/mrMwSJrdLJ
         aHlsLTkRFiI79xEzmnLmgrAxbWP5yZ2EEfWH1cO1qKuKE5ltw9BZs+qvZBkPsBWWqbNz
         gtnqB+zOS2EF2/13svvmFOcBHzhaD/nJ8+CF829Mkd4fhUtkTSStlAIofLw4WffeuOtv
         Xg1DT2jcD+XAItzKIgTRrgSY4TPNMW/7fIoPpaLPr88dWavImDnPW/usAOMUFSNu2USo
         dxArtpHn2iSWVzCTN8Z2Qan7dvWEEFfg8WEA39mrnmAC5VKipj9cOSOS9kE4ewTp7cbu
         2iRQ==
X-Gm-Message-State: APjAAAWSn9uISffguJBTKATva1e0Djn5XtICofsApnATzejIzx0xSXKU
        tLw5XHQkNNhjR75SksTN8Bw=
X-Google-Smtp-Source: APXvYqwMgVDsKn/TQgCBFxNy3FFhBdbO4H7Bcbx1Lkq4028RO2x+0QMEq5zsHI7qBISuA1BIkXGvGQ==
X-Received: by 2002:a17:90a:26a1:: with SMTP id m30mr6363208pje.59.1560877754069;
        Tue, 18 Jun 2019 10:09:14 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id d6sm14251093pgf.55.2019.06.18.10.09.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 10:09:13 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v5 1/5] sequencer: add advice for revert
Date:   Tue, 18 Jun 2019 22:36:46 +0530
Message-Id: <20190618170650.22721-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
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
 sequencer.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..c644368b54 100644
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


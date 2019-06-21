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
	by dcvr.yhbt.net (Postfix) with ESMTP id 890FE1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 09:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFUJU0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 05:20:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43506 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 05:20:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so3063939pgv.10
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fv2/e3T5aX9EN1/FCoKHc+hGcL1Rz+Nul1DYvV3s688=;
        b=ptlnxlnna5P7Ef37RFMGieOVkMvm/0bHy9BqMjLjzgiu11KNvscKFkL2rftWV963hx
         ucmabo2pb13V2s15KM7H8Y16k8n3ySF4bA1C6AgRjmqlJtEmd85Q4KSPDqS+ONKiNem6
         VCypuK1V945GXO6qjH8+o+Y/JtI2etTtD9rxv7ir6Tw1rxBXhRdhEWbG+cxG5EGfu+Qw
         BFeGElXgx1xdzFVxM+g+tbp1AO7thtp1y5YNiHmrw6IUnesoGua+OPLhjJ7x4Q7EyWEM
         r4BV+DaIVM6DSLdTYEcQt4VEHefAXDFpUcBXqJFwaUQDOqbvwX/xwRpVAGwy0QMesg6W
         P3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fv2/e3T5aX9EN1/FCoKHc+hGcL1Rz+Nul1DYvV3s688=;
        b=KoLwwnZNvv1ICyQProQ/a1awV+21lTwn8LQeyL1mbxq46vjAsgGoHw9DNcDY3PCdct
         Kn0BXxF2fsgKOwUTX9Fu/wdhFt2tvZToLKMpxljH54xXbCKice5ESDtY8N9ildB8uVHl
         PrIjRsU+LN2YhGPHjx/EsxL/MQ+0BeMB43L6TC13AAA94nQHTJuH/1OE4ALRm1Jaaeys
         xi36ZSpjGIo4M3O3IKRuyMeeQhiEABazpYDRQAupK9IV0AlWN93jumh3v2l+B7Kv5xug
         FUvGPGTse8cKED/2quFMO5qjY2o7/HcsTFa6g2HBrfD4V00lIqaoBSb5nJyyLaLzoqaV
         QDIQ==
X-Gm-Message-State: APjAAAX9gVc0cFOvuVIR7sqN0S8tNVWbF8GUU7Pp9dAvQ5okCZ+/u6CR
        YX6undw63A8PcYX9140fD418E7rB/MC1Nw==
X-Google-Smtp-Source: APXvYqygajOCsXNBOtWADuXzKD1EA6Yc+muZGSqGFG0GNcY4sYx/BFYicSuOiSn5U31/LmmD/4ldDA==
X-Received: by 2002:a65:5347:: with SMTP id w7mr17232397pgr.375.1561108825631;
        Fri, 21 Jun 2019 02:20:25 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.216])
        by smtp.gmail.com with ESMTPSA id i133sm4380220pfe.75.2019.06.21.02.20.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:20:24 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [GSoC][PATCH v6 1/5] sequencer: add advice for revert
Date:   Fri, 21 Jun 2019 14:47:56 +0530
Message-Id: <20190621091800.17686-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621091800.17686-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190621091800.17686-1-rohit.ashiwal265@gmail.com>
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


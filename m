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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AEE41F462
	for <e@80x24.org>; Sun, 16 Jun 2019 08:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfFPIXg (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 04:23:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46380 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfFPIXf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 04:23:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so2804695pls.13
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 01:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DTkwOxGH2Q7/D1UjALjxmCJPB6FE7W1q/xt1a0q6B3Y=;
        b=fANCADrG39OjTmy8dxx8MKj2iz20GHtb67Y99p3GI5uCxJOoPubFMYHcSxM7O6Pr4j
         T18S1MIskjr93DN9a2LggbEy4m/bYAaWJdOUgq/nTVGaZyCiM6QaMBd+isfz91Rk9ACS
         IVDLR1jOCCecjOHbCXWr6lyvM8dML0JdQe2Rs2v2w8sb1T8rUOVH1VBaWfNqYiOJOj0J
         DeWE4gdtSSknqDEa2BBul/InSFBNyJ7+Xg2xBve//5vO9cbfbuetzdBo7VQl3Tm9h759
         nwhOTAhfHRamgi7kWkP2+oARMfDDVoGqunyyqrHBRXc/x/iss0AAriQO2jGQ8edqdTbM
         89dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DTkwOxGH2Q7/D1UjALjxmCJPB6FE7W1q/xt1a0q6B3Y=;
        b=NdAZYhozKV7/AXMz+in3Z8+LslrUe7Qewi48i6m12WBSVvmOBOsmk/OI2GQAOt2Ctf
         XueeCsObtD1hvn7HviakPTLlclsS8lFFMGFKvc+MfDjel/VhkRmgJgusFPMZmqboTiMf
         9P9H0iUXIrTFmG2IJt8HoWeOTm/Kmwees5ORiatoVqp9nM+kqRTWnq0zJbuf1tDWjylJ
         /2Z9ovuPXghLSJ9H73X7ELQ+kflIYyUGJG4TzyfJ0pgDnbmq7kWUxXMK76/31KjYe9y7
         vWLnY9Ifbd0fcm/3/I1g37FXbOVKVISnbESaw2xTC+QXtkgWsdUOziK2XELQmylVVz2I
         OHrg==
X-Gm-Message-State: APjAAAXIsdQj99wLmyz6/1C8RZtFsQB5XSsjD/e+WRRNDEHTJ2wJKesc
        W4zmEBIwL3PPpaBuaJuDadL/C1GGNJJ0UA==
X-Google-Smtp-Source: APXvYqxkHzSjFENYo+qLf4HyRHK4BMuuQd6jkVLamkvjM8GP38Vy3nrPKtYKaFb/Cefav/8atGrymw==
X-Received: by 2002:a17:902:728a:: with SMTP id d10mr99940479pll.90.1560673415090;
        Sun, 16 Jun 2019 01:23:35 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:3105:6dd7:b496:8be7:332f:b415])
        by smtp.gmail.com with ESMTPSA id x128sm1471972pfd.17.2019.06.16.01.23.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:23:34 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v4 1/4] sequencer: add advice for revert
Date:   Sun, 16 Jun 2019 13:50:37 +0530
Message-Id: <20190616082040.9440-2-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190616082040.9440-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190616082040.9440-1-rohit.ashiwal265@gmail.com>
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
    - change BUG()'s message under create_seq_dir

 sequencer.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f88a97fb10..d80e1c3fbb 100644
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
+			BUG(_("unexpected action in create_seq_dir"));
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


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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C8891F462
	for <e@80x24.org>; Tue, 18 Jun 2019 17:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbfFRRJM (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 13:09:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43545 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRRJL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 13:09:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so5964211plb.10
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2Ky/1CgtLDOw2VPGE9hpw0S8P5FHVPuhx3LSK0/Eo8=;
        b=BeiioaojGNuBjECvfxzQyRCF/wOIFsbvFIzqqA+GfxemOLMdtsJKVzWvvdN82dQv55
         wz18VLCYw21DT8tBL8EP/1DJohMEH1LzuTLamBml5b9y3ZLXToJV39izCvvIJ+NsO0nX
         Y929YEtCwawwF12YgdzWWM+jf84HhEMkWEC8AcOGpddYoCLs/GKCSsK1zocZKoFIZOt1
         DM+mB8zHIc0D7qws0h4EMe/gfyFV69m5o1k97JNhat0DVmJYFCfUT7eFI2wUQn3JPLcM
         M00qhM+gwV0OTxACx04u24EgzZig0wSi3X6W/OSmYmofZu3RHaFaOALtiemSfCsOxc80
         DemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2Ky/1CgtLDOw2VPGE9hpw0S8P5FHVPuhx3LSK0/Eo8=;
        b=UzScgQaD+ErOUSbE2AQRSRKUGINDEqLOqdZOyiHCJaaBpBpAuHvQ5fXgRbB+yGuiIJ
         81hU7IcaIHSNrgc644xAevqId6bZzoW7XphhKZS72SkFAPbxwDHaUs9uVP1vMy2viz2a
         0wV4lMvZqyipJOcrpdXLZyLdnJJv9Ud/IbFYHEL/R8Tu0gtE/Ffgmb7MdTdntIM6vUP6
         6R6wsnPRA67hTWJH1/rwUMp0o1FVsqv1K8O/4YXeZtH8urZ66ZOWj9876NOHl0E3K/He
         ROMIdn1YWVJpq4IEV4iHnMzHXEk94sPZX8okpPcBl+Bwm6+4iRxgkGN7RUaMWU6jhQQP
         Zi5w==
X-Gm-Message-State: APjAAAX/tmEHROSxFHqzVq19MZCfI9E/zfx3/YvWEUuZ6WIHH5h1Ybk9
        Y0zju0JqdejyUu8+xci+MUw=
X-Google-Smtp-Source: APXvYqxtKLFn2TJbzZN0qc0TsxtyzRj/tf5DKVlXV/+spz4AMFOS030wGGamMlFHrnu5kjNWkwDUqQ==
X-Received: by 2002:a17:902:9898:: with SMTP id s24mr16045867plp.226.1560877750484;
        Tue, 18 Jun 2019 10:09:10 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id d6sm14251093pgf.55.2019.06.18.10.09.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 10:09:09 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v5 0/5] Teach cherry-pick/revert to skip commits
Date:   Tue, 18 Jun 2019 22:36:45 +0530
Message-Id: <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another round of my patch, hopefully I have addressed all the changes.
  - I have introduced a separate commit which changes `reset_merge` to use
    `argv_array` instead of a manual `char *argv`. This will avoid specifying
    array size and index and make code easier to read and extend
  - Removed _() from BUG() messages
  - Rearrange comments under `sequencer_skip`. I have not changed switch-case to
    if-else since the former looked better to me

Thanks

Rohit Ashiwal (5):
  sequencer: add advice for revert
  sequencer: rename reset_for_rollback to reset_merge
  sequencer: use argv_array in reset_merge
  cherry-pick/revert: add --skip option
  cherry-pick/revert: advise using --skip

 Documentation/git-cherry-pick.txt |   4 +-
 Documentation/git-revert.txt      |   4 +-
 Documentation/sequencer.txt       |   4 +
 builtin/commit.c                  |  13 +--
 builtin/revert.c                  |   5 ++
 sequencer.c                       | 131 ++++++++++++++++++++++++++----
 sequencer.h                       |   1 +
 t/t3510-cherry-pick-sequence.sh   | 122 ++++++++++++++++++++++++++++
 8 files changed, 258 insertions(+), 26 deletions(-)

Range-diff:
1:  59fa13c4d8 ! 1:  67c212090d sequencer: add advice for revert
    @@ -41,7 +41,7 @@
     +			_("try \"git cherry-pick (--continue | --abort | --quit)\"");
     +			break;
     +		default:
    -+			BUG(_("unexpected action in create_seq_dir"));
    ++			BUG("unexpected action in create_seq_dir");
     +		}
     +	}
     +	if (in_progress_error) {
2:  dea4582591 = 2:  300d6f64f0 sequencer: rename reset_for_rollback to reset_merge
-:  ---------- > 3:  edc35f6a4c sequencer: use argv_array in reset_merge
3:  29686d828f ! 4:  825486c22d cherry-pick/revert: add --skip option
    @@ -11,9 +11,8 @@
         skipping commits easier for the user and to make the commands more
         consistent.
     
    -    In the next commit, we will change the advice messages and some tests
    -    hence finishing the process of teaching revert and cherry-pick
    -    "how to skip commits".
    +    In the next commit, we will change the advice messages hence finishing
    +    the process of teaching revert and cherry-pick "how to skip commits".
     
         Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
     
    @@ -96,31 +95,6 @@
      --- a/sequencer.c
      +++ b/sequencer.c
     @@
    - 
    - static int reset_merge(const struct object_id *oid)
    - {
    --	const char *argv[4];	/* reset --merge <arg> + NULL */
    -+	int ret;
    -+	struct argv_array argv = ARGV_ARRAY_INIT;
    - 
    --	argv[0] = "reset";
    --	argv[1] = "--merge";
    --	argv[2] = oid_to_hex(oid);
    --	argv[3] = NULL;
    --	return run_command_v_opt(argv, RUN_GIT_CMD);
    -+	argv_array_pushl(&argv, "reset", "--merge", NULL);
    -+
    -+	if (!is_null_oid(oid))
    -+		argv_array_push(&argv, oid_to_hex(oid));
    -+
    -+	ret = run_command_v_opt(argv.argv, RUN_GIT_CMD);
    -+	argv_array_clear(&argv);
    -+
    -+	return ret;
    - }
    - 
    - static int rollback_single_pick(struct repository *r)
    -@@
      	return reset_merge(&head_oid);
      }
      
    @@ -146,48 +120,40 @@
     +	sequencer_get_last_command(r, &action);
     +
     +	/*
    -+	 * opts->action tells us which subcommand requested to skip
    -+	 * the commit.
    ++	 * Check whether the subcommand requested to skip the commit is actually
    ++	 * in progress and that it's safe to skip the commit.
    ++	 *
    ++	 * opts->action tells us which subcommand requested to skip the commit.
    ++	 * If the corresponding .git/<ACTION>_HEAD exists, we know that the
    ++	 * action is in progress and we can skip the commit.
    ++	 *
    ++	 * Otherwise we check that the last instruction was related to the
    ++	 * particular subcommand we're trying to execute and barf if that's not
    ++	 * the case.
    ++	 *
    ++	 * Finally we check that the rollback is "safe", i.e., has the HEAD
    ++	 * moved? In this case, it doesn't make sense to "reset the merge" and
    ++	 * "skip the commit" as the user already handled this by committing. But
    ++	 * we'd not want to barf here, instead give advice on how to proceed. We
    ++	 * only need to check that when .git/<ACTION>_HEAD doesn't exist because
    ++	 * it gets removed when the user commits, so if it still exists we're
    ++	 * sure the user can't have committed before.
     +	 */
     +	switch (opts->action) {
     +	case REPLAY_REVERT:
    -+		/*
    -+		 * If .git/REVERT_HEAD exists then we are sure that we are in
    -+		 * the middle of a revert and we allow to skip the commit.
    -+		 */
     +		if (!file_exists(git_path_revert_head(r))) {
    -+			/*
    -+			 * Check if the last instruction executed was related to
    -+			 * revert. If so, we are sure that a revert is in progress.
    -+			 *
    -+			 * NB: single commit revert is also counted in this
    -+			 * definition of "progress" (and was dealt with in the
    -+			 * previous check).
    -+			 */
    -+			if (action == REPLAY_REVERT) {
    -+				/*
    -+				 * Check if the user has moved the HEAD, i.e.,
    -+				 * already committed. In this case, we would like
    -+				 * to advise instead of skipping.
    -+				 */
    -+				if (!rollback_is_safe())
    -+					goto give_advice;
    -+				else
    -+					/* skip commit :) */
    -+					break;
    -+			}
    -+			return error(_("no revert in progress"));
    ++			if (action != REPLAY_REVERT)
    ++				return error(_("no revert in progress"));
    ++			if (!rollback_is_safe())
    ++				goto give_advice;
     +		}
     +		break;
     +	case REPLAY_PICK:
     +		if (!file_exists(git_path_cherry_pick_head(r))) {
    -+			if (action == REPLAY_PICK) {
    -+				if (!rollback_is_safe())
    -+					goto give_advice;
    -+				else
    -+					break;
    -+			}
    -+			return error(_("no cherry-pick in progress"));
    ++			if (action != REPLAY_PICK)
    ++				return error(_("no cherry-pick in progress"));
    ++			if (!rollback_is_safe())
    ++				goto give_advice;
     +		}
     +		break;
     +	default:
4:  941e73b654 ! 5:  63dbc11ab1 cherry-pick/revert: advise using --skip
    @@ -62,7 +62,7 @@
     +			_("try \"git cherry-pick (--continue | %s--abort | --quit)\"");
      			break;
      		default:
    - 			BUG(_("unexpected action in create_seq_dir"));
    + 			BUG("unexpected action in create_seq_dir");
     @@
      	}
      	if (in_progress_error) {
-- 
2.21.0


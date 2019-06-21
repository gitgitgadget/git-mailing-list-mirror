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
	by dcvr.yhbt.net (Postfix) with ESMTP id A33301F461
	for <e@80x24.org>; Fri, 21 Jun 2019 09:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfFUJUW (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 05:20:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38922 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJUW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 05:20:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so3281359pfe.6
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oeAOh8zzxgj4fUDQPvr732sYeNDx3sa8FykYVI6kYfQ=;
        b=qoZYuzFf91DzFWup1CEDwTUxJwR8BUggBWg0Q5LTc4nZxd5iBv+lFMbDP9qsY/IrdI
         Ru+5Q2ossiFeQBP6Crz0LS7eJjG3jBPCk6g+1RRtrKyEEMM790qWNDmBCcCBoZD6E6C5
         xW9NED/OHaeQl52wB9MuxLvjSHGyuvGGBY6z9oI5Sq2O6CEMckOs744rpZjeuihpNJDb
         SoYhvBVZFVyOS8GTG41jP6ooGd0u67bDRqoabBWa4lLw9g4n/2xUXllm/od3NFuDuat7
         fMFHRYD1T9GGzpfxs4lE94tofix1rI9myaWmP3mBIMIWZim7fnriZ7+SsxX3NzyY6XMF
         AcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oeAOh8zzxgj4fUDQPvr732sYeNDx3sa8FykYVI6kYfQ=;
        b=gwTffvF7JN/I9kdQ9OCHg75KeFUO8fSs4HQLt/KIZj3zGLnlJndlwdymt7z4TxRbLC
         7AIR/+iGZSo+i2L2EdIMEYORoB3nOv7cIvxuILPkjL/2Py0uQcYDRrHuK1XS6xDEP0lj
         fmT6csGWuTUjwMdCANOroEendhnTK/OIxY7SVRg0JQE5yHPPHYKrFzfMqOX4F8KxUN52
         UML7o9D7J8ll6hCh1MbhdmKVZXT04wJbOTIw3M4PwgEOIx3riKHCW4SRt2ogULc5szcj
         e/05AiPc4ETSZBDm6EToyvbSefzvYQSfXtF/4yVXxT3BlmX6ZCGNk+UcxeoMso+oHiNN
         xp1Q==
X-Gm-Message-State: APjAAAVJnaQx3UmcWEfl+fiMjIRDPopBI//umHmlshp8nvHAmE69SeHy
        aN0cjNHEOXdOWt8N/JY8tl0=
X-Google-Smtp-Source: APXvYqzD4dHxvPbjTMI+a0Kkgr50yQaEAZAr/eGw01rKR/sJM0NHK2rGcTVW3WhEgJbqO3r1bChT9A==
X-Received: by 2002:a17:90a:26ef:: with SMTP id m102mr5242046pje.50.1561108821389;
        Fri, 21 Jun 2019 02:20:21 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.216])
        by smtp.gmail.com with ESMTPSA id i133sm4380220pfe.75.2019.06.21.02.20.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:20:20 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [GSoC][PATCH v6 0/5] Teach cherry-pick/revert to skip commits
Date:   Fri, 21 Jun 2019 14:47:55 +0530
Message-Id: <20190621091800.17686-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've covered the advice message behind `advice_resolve_conflict` variable and
changed the order of error and advice to match that of 1/5. I believe that we
don't have any advice variable appropriate for advice in 1/5.

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
 sequencer.c                       | 135 ++++++++++++++++++++++++++----
 sequencer.h                       |   1 +
 t/t3510-cherry-pick-sequence.sh   | 122 +++++++++++++++++++++++++++
 8 files changed, 262 insertions(+), 26 deletions(-)

Range-diff:
1:  825486c22d ! 1:  2b16d7ea4d cherry-pick/revert: add --skip option
    @@ -168,10 +168,14 @@
     +	return sequencer_continue(r, opts);
     +
     +give_advice:
    -+	advise(_("have you committed already?\n"
    -+		 "try \"git %s --continue\""),
    -+		 action == REPLAY_REVERT ? "revert" : "cherry-pick");
    -+	return error(_("there is nothing to skip"));
    ++	error(_("there is nothing to skip"));
    ++
    ++	if (advice_resolve_conflict) {
    ++		advise(_("have you committed already?\n"
    ++			 "try \"git %s --continue\""),
    ++			 action == REPLAY_REVERT ? "revert" : "cherry-pick");
    ++	}
    ++	return -1;
     +}
     +
      static int save_todo(struct todo_list *todo_list, struct replay_opts *opts)
    @@ -263,9 +267,9 @@
     +test_expect_success 'check advice when we move HEAD by committing' '
     +	pristine_detach initial &&
     +	cat >expect <<-EOF &&
    ++	error: there is nothing to skip
     +	hint: have you committed already?
     +	hint: try "git cherry-pick --continue"
    -+	error: there is nothing to skip
     +	fatal: cherry-pick failed
     +	EOF
     +	test_must_fail git cherry-pick base..yetanotherpick &&
2:  63dbc11ab1 = 2:  8f278b5139 cherry-pick/revert: advise using --skip
-- 
2.21.0


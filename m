Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6841F461
	for <e@80x24.org>; Tue,  2 Jul 2019 09:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfGBJOP (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 05:14:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44941 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBJOO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 05:14:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id t7so38910plr.11
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7SDeH0jMZcYqMChLf3oiocAGxq6SPDWr/Y2Sfojd+M=;
        b=My54CW5Rcu2kaemEQu5WZzPoueAXd/+eGxhQmme/n0nBKAm4BA8BHxkXd/30eok/gD
         Cs45NzGEqJi4uYdHkTumyn90wgWONITjYPh883Sz5CUTX8tf2UBBqkNxNw+h311cunrB
         aqpMt5UxQAywx5ZcSFzRzWGfKNp9X2jfsvmBeYI3PobFRW9j0KuFXS2BmwAF6KHHS1xr
         t/Ec/UEJ6viNlhlGOq5WfjV60OODpwr5sy2nD7PuTcMncjd+izEj/TsrPq2EMIc5N62A
         DgZN5LXAZ39NWvMc31ci4QCqhITDTsDq/W7xAMLquf9V3R1dcVxrL/7La5UG7d+kS/G8
         CHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7SDeH0jMZcYqMChLf3oiocAGxq6SPDWr/Y2Sfojd+M=;
        b=SKtHrv4cAXNvHHV6gjnoFJ6qVsKuVINwzbUWmW842GTTT/rymvgdOzywsyGHDZnD8J
         HBwdNx54YvH/IvGH1Bh13omrEOuCx54z1f1jW4n18+TrtPlbtyBIWnU/8I3Md1inw8P+
         MWLc16mZzr69cInpc5YkM6AHjkTYOfs91vmTt0/LiLTlSb3lS1gsdg2/kWOt68mROfr9
         8kHwXlSWKTWI7bfQF2qu3xb6tZz3Vq4TezoGTAOvlK87Kwj4YtQ4uDVDnOP2b0qVuOIL
         jDpBPzRgPHHykKfBj9bP+UxKBH7DEoDcUsuoZvzmSZ4JUxr5nH/tYY4wn/WN13ynb2pV
         iuGg==
X-Gm-Message-State: APjAAAV0/O/RFqnj3Drx9SS9/D1ckNPH+hke7Wa0W1zv3FyrTd9QkRQu
        9J/6dv60783YdaBGUmVerSQ=
X-Google-Smtp-Source: APXvYqzadmq8lMGkQsK0XK2voiE/6AgwEZw4kzlBj3SMR67Kap2uq0lc3C2rk+nfAwc6bTSkO76bTQ==
X-Received: by 2002:a17:902:9a49:: with SMTP id x9mr22752268plv.282.1562058853536;
        Tue, 02 Jul 2019 02:14:13 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.218])
        by smtp.gmail.com with ESMTPSA id q198sm20499178pfq.155.2019.07.02.02.14.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 02:14:12 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com
Subject: [GSoC][PATCH v8 0/5] Teach cherry-pick/revert to skip commits
Date:   Tue,  2 Jul 2019 14:41:24 +0530
Message-Id: <20190702091129.7531-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Another revision of my patch which takes care of all the nits.

Rohit Ashiwal (5):
  sequencer: add advice for revert
  sequencer: rename reset_for_rollback to reset_merge
  sequencer: use argv_array in reset_merge
  cherry-pick/revert: add --skip option
  cherry-pick/revert: advise using --skip

 Documentation/config/advice.txt   |   2 +
 Documentation/git-cherry-pick.txt |   4 +-
 Documentation/git-revert.txt      |   4 +-
 Documentation/sequencer.txt       |   4 +
 advice.c                          |   2 +
 advice.h                          |   1 +
 builtin/commit.c                  |  13 +--
 builtin/revert.c                  |   5 ++
 sequencer.c                       | 134 ++++++++++++++++++++++++++----
 sequencer.h                       |   1 +
 t/t3510-cherry-pick-sequence.sh   | 122 +++++++++++++++++++++++++++
 11 files changed, 266 insertions(+), 26 deletions(-)

Range-diff:
1:  207042a895 < -:  ---------- advice: add sequencerInUse config variable
2:  d7c603d47f ! 1:  91d3949b69 sequencer: add advice for revert
    @@ -3,14 +3,58 @@
         sequencer: add advice for revert
     
         In the case of merge conflicts, while performing a revert, we are
    -    currently advised to use `git cherry-pick --<sequencer-options>`
    -    of which --continue is incompatible for continuing the revert.
    +    currently advised to use `git cherry-pick --<sequencer-options>`.
         Introduce a separate advice message for `git revert`. Also change
         the signature of `create_seq_dir` to handle which advice to display
         selectively.
     
         Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
     
    + diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
    + --- a/Documentation/config/advice.txt
    + +++ b/Documentation/config/advice.txt
    +@@
    + 	resolveConflict::
    + 		Advice shown by various commands when conflicts
    + 		prevent the operation from being performed.
    ++	sequencerInUse::
    ++		Advice shown when a sequencer command is already in progress.
    + 	implicitIdentity::
    + 		Advice on how to set your identity configuration when
    + 		your information is guessed from the system username and
    +
    + diff --git a/advice.c b/advice.c
    + --- a/advice.c
    + +++ b/advice.c
    +@@
    + int advice_commit_before_merge = 1;
    + int advice_reset_quiet_warning = 1;
    + int advice_resolve_conflict = 1;
    ++int advice_sequencer_in_use = 1;
    + int advice_implicit_identity = 1;
    + int advice_detached_head = 1;
    + int advice_set_upstream_failure = 1;
    +@@
    + 	{ "commitBeforeMerge", &advice_commit_before_merge },
    + 	{ "resetQuiet", &advice_reset_quiet_warning },
    + 	{ "resolveConflict", &advice_resolve_conflict },
    ++	{ "sequencerInUse", &advice_sequencer_in_use },
    + 	{ "implicitIdentity", &advice_implicit_identity },
    + 	{ "detachedHead", &advice_detached_head },
    + 	{ "setupStreamFailure", &advice_set_upstream_failure },
    +
    + diff --git a/advice.h b/advice.h
    + --- a/advice.h
    + +++ b/advice.h
    +@@
    + extern int advice_commit_before_merge;
    + extern int advice_reset_quiet_warning;
    + extern int advice_resolve_conflict;
    ++extern int advice_sequencer_in_use;
    + extern int advice_implicit_identity;
    + extern int advice_detached_head;
    + extern int advice_set_upstream_failure;
    +
      diff --git a/sequencer.c b/sequencer.c
      --- a/sequencer.c
      +++ b/sequencer.c
3:  b70299c572 ! 2:  189ef90318 sequencer: rename reset_for_rollback to reset_merge
    @@ -6,7 +6,7 @@
         achieve this, we could really make use of existing functions.
         reset_for_rollback is one such function, but the name does not
         intuitively suggest to use it to reset a merge, which it was born to
    -    perform see 539047c ("revert: introduce --abort to cancel a failed
    +    perform, see 539047c ("revert: introduce --abort to cancel a failed
         cherry-pick", 2011-11-23). Change the name to reset_merge to make
         it more intuitive.
     
4:  569122c861 = 3:  2b237e3174 sequencer: use argv_array in reset_merge
5:  4580f0e5af = 4:  5d64faf501 cherry-pick/revert: add --skip option
6:  f6f21b055b = 5:  807a344eb1 cherry-pick/revert: advise using --skip
-- 
2.21.0


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB71C001B0
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 04:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjGFEBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 00:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGFEBm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 00:01:42 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE3A1988
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 21:01:40 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-579dfae6855so3590247b3.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 21:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688616099; x=1691208099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0K9idYQkn5tckvAt7nbVN2AgKO4RhaIlDI+zgEsghI=;
        b=jUukKgSkhCRR88RTXpvisGHHmTCf7TM0it9gYD/iz/Z7nBCtvKXkjv6vIAOdkKoY08
         14n/X4Vy5LiEnhLvjsaZVESojLf58S6M5lPenKfRY+8SKx64guKPiPFHDNSgNsmSY5Zf
         DrX4/LiQfqkuj2s19naRCWF3D0cB064FiehjtnFg70IpLHqNyeV2rsFeASPv0gxSm4JP
         TlpXZ/wXeMm9lhitKbG+QAnCoikXSaVXbGqpQBaCnidig1pSR0k39vHf0lL+OlDco8J6
         AjKprjW+VRZv+u5NU2NdgEEvicvAonE12jRezAv2BdJGtiXW1fp7WGW0ieoX6KUiwFV4
         A7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688616099; x=1691208099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0K9idYQkn5tckvAt7nbVN2AgKO4RhaIlDI+zgEsghI=;
        b=OGg2yDKYNrQDvicwg0ifmHp8WMdimgiXtrhzWDrhcRDoqAmBCA/1D1LlO8OHmSUTPM
         EmtsRzzr+bnbRjO7xEUHq9YLK+7TV3fMgqxdbNP1oAoQoU1NIFp9kJKtl88TkCT6Jah3
         GAoM/CrIhvilCbwLqqApkuBVdR+IplqB5o1wxD5CAR8rwi29zXYD6DZdVUpiq4Se8prX
         eQVMV7SDChBtRTfonD2ETBNy2OsO1nuLoUYboKQinDz7a/4iyCmYb/PWUwSmIgPO187r
         E8LGpNPiE8FW5p+jistmMoDgAvmXHXCpgUCQWlTMvsrq9jDDw2Nrm2pF+SPVbvu+FGV/
         JmMA==
X-Gm-Message-State: ABy/qLYoABhaBVdXitSV9sToqPBczv7x3F4zYWKdGWUiUdICCNRMix6b
        EvmTHuT2qLAATdYst6x2XdTWi+sO+aUyMA==
X-Google-Smtp-Source: APBJJlHBN7rFUJ4ynj4XF1SHzIK4Oo0r15+m9QHDRHJ9gAWO59dYiLyiWppJ9CPfywV5C5vELpBuKg==
X-Received: by 2002:a81:c20f:0:b0:55d:edf3:9e0a with SMTP id z15-20020a81c20f000000b0055dedf39e0amr868034ywc.27.1688616098808;
        Wed, 05 Jul 2023 21:01:38 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id j24-20020a63cf18000000b00548d361c137sm303913pgg.61.2023.07.05.21.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 21:01:38 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3 0/2] advise about force-pushing as an alternative to reconciliation
Date:   Wed,  5 Jul 2023 22:01:01 -0600
Message-ID: <20230706040111.81110-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704194756.166111-1-alexhenrie24@gmail.com>
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many times now, I have seen novices do the following:

1. Start work on their own personal topic branch
2. Push the branch to origin
3. Rebase the branch onto origin/master
4. Try to push again, but Git says they need to pull
5. Pull and make a mess trying to reconcile the older topic branch with
   the rebased topic branch

Help avoid this mistake by giving advice that mentions force-pushing,
rather than assuming that the user always wants to do reconciliation.

Changes from v2:
- Switch back to recommending plain --force in these cases
- Use Junio's proposed wording in remote.c

Alex Henrie (2):
  remote: advise about force-pushing as an alternative to reconciliation
  push: advise about force-pushing as an alternative to reconciliation

 builtin/push.c | 27 +++++++++++++++------------
 remote.c       |  5 ++++-
 2 files changed, 19 insertions(+), 13 deletions(-)

Range-diff against v2:
1:  d0cb607225 < -:  ---------- remote: advise about force-pushing as an alternative to reconciliation
-:  ---------- > 1:  9cbf5f138e remote: advise about force-pushing as an alternative to reconciliation
2:  3295f0bb2b ! 2:  727e1f7636 push: advise about force-pushing as an alternative to reconciliation
    @@ builtin/push.c: static void setup_default_push_refspecs(int *flags, struct remot
     -	   "its remote counterpart. Integrate the remote changes (e.g.\n"
     -	   "'git pull ...') before pushing again.\n"
     +	   "its remote counterpart. Use 'git pull' to integrate the remote changes\n"
    -+	   "before pushing again, or use 'git push --force-with-lease' to delete the\n"
    -+	   "remote changes and replace them with your own.\n"
    ++	   "before pushing again, or use 'git push --force' to delete the remote\n"
    ++	   "changes and replace them with your own.\n"
      	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
      
      static const char message_advice_checkout_pull_push[] =
    @@ builtin/push.c: static void setup_default_push_refspecs(int *flags, struct remot
     -	   "counterpart. Check out this branch and integrate the remote changes\n"
     -	   "(e.g. 'git pull ...') before pushing again.\n"
     +	   "counterpart. Check out this branch and use 'git pull' to integrate the\n"
    -+	   "remote changes before pushing again, or use\n"
    -+	   "'git push --force-with-lease' to delete the remote changes and replace\n"
    -+	   "them with your own.\n"
    ++	   "remote changes before pushing again, or use 'git push --force' to delete\n"
    ++	   "the remote changes and replace them with your own.\n"
      	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
      
      static const char message_advice_ref_fetch_first[] =
    @@ builtin/push.c: static void setup_default_push_refspecs(int *flags, struct remot
     +	N_("Updates were rejected because the remote contains work that you do not\n"
     +	   "have locally. This is usually caused by another repository pushing to\n"
     +	   "the same ref. Use 'git pull' to integrate the remote changes before\n"
    -+	   "pushing again, or use 'git push --force-with-lease' to delete the\n"
    -+	   "remote changes and replace them with your own.\n"
    ++	   "pushing again, or use 'git push --force' to delete the remote changes\n"
    ++	   "and replace them with your own.\n"
      	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
      
      static const char message_advice_ref_already_exists[] =
    @@ builtin/push.c: static const char message_advice_ref_needs_force[] =
     -	   "before forcing an update.\n");
     +	N_("Updates were rejected because the tip of the remote-tracking branch has\n"
     +	   "been updated since the last checkout. Use 'git pull' to integrate the\n"
    -+	   "remote changes before pushing again, or use\n"
    -+	   "'git push --force-with-lease' to delete the remote changes and replace\n"
    -+	   "them with your own.\n");
    ++	   "remote changes before pushing again, or use 'git push --force' to delete\n"
    ++	   "the remote changes and replace them with your own.\n");
      
      static void advise_pull_before_push(void)
      {
-- 
2.41.0


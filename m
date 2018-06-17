Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1071F403
	for <e@80x24.org>; Sun, 17 Jun 2018 05:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754226AbeFQF7U (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 01:59:20 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39016 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754131AbeFQF7L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 01:59:11 -0400
Received: by mail-ot0-f195.google.com with SMTP id l15-v6so15223040oth.6
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 22:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u93GcJLCzOFnVR6hGtMGeGwCtn++Zxz+MHbvV1ANSqs=;
        b=iPtwm211K4YHblj3DQEkMxVKcLnfsm1c90Wlh2zThVlh2GjU5cj5ZwAGNzM3a1ZWWL
         TZioV2FrGR5A3A0O4MG+AHTCRHYMglo29y89QP67+Pw52WAuEV7siFHkxHgy8fWZq1sM
         fSbcYxb8JVqNO2FQlX9XrHRDJetZ0PBOKSPQtScF5BHMz08TP9YfCTS1IvVBplqxc4Vd
         NYbvp9wRdcFk0G7BNZ9lZr3swEBBrYwGXf8ZT9IzzIhoJE7FxZ3tqUiVhKGn6sd3/T/L
         PsxXlGkkOs4+a4puqOtvsF8W/6E6/+bk97bjWja9mgIo7xy7fJdAgphFLCYoArq/Ctmq
         5NMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u93GcJLCzOFnVR6hGtMGeGwCtn++Zxz+MHbvV1ANSqs=;
        b=NZ0GHlVNdxFKSOyH93NOcRcKcZNjMg4ZeqwflNh7tmBwHNQJJh+4WbxRaiPdRSwy6F
         u+e+u2moQESq+j1eajeY2+ieckLfBaBZHbFpL/pDA6jPKOCzMClTPXDfRnDqclXclbeS
         Jn7tp+KyS/NeNV69/OhTmGBXuF7uOaGweIYI9Dw/s8Hh3uFPg8hAWBb4LWYRFuX2pda4
         guBwNuN7ghFxsmSqpQPNdAkiV9zkF9hhvaKIbwslGpKwo8D3qcQCImrNDP6wbv6CKMji
         zPZCSFdEhngfGtwTpkbLLrkPMW8PctSaPlRER/t4SCT2VwP1IZ6zlN91g07SXBR7qi6l
         F/Ug==
X-Gm-Message-State: APt69E2oCLWRCZLT5Eg2DvUp+NNUoc1BiXLWEzipOTINhQHYTa9TNDjV
        chkDZhypDzCio2BN8QDlxboS6A==
X-Google-Smtp-Source: ADUXVKIaB0KKck984XOyK95vuow0KOcieV1EIsjFih9S+ijVM/0A6md7Tfq1qB1JjXqy5+cGE2KBQQ==
X-Received: by 2002:a9d:3d76:: with SMTP id a109-v6mr5192391otc.294.1529215150504;
        Sat, 16 Jun 2018 22:59:10 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id h12-v6sm5366091oti.4.2018.06.16.22.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 22:59:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 6/7] git-rebase.txt: address confusion between --no-ff vs --force-rebase
Date:   Sat, 16 Jun 2018 22:58:55 -0700
Message-Id: <20180617055856.22838-7-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.7.gab8805c40a
In-Reply-To: <20180617055856.22838-1-newren@gmail.com>
References: <20180607050654.19663-1-newren@gmail.com>
 <20180617055856.22838-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rebase was taught the --force-rebase option in commit b2f82e05de ("Teach
rebase to rebase even if upstream is up to date", 2009-02-13).  This flag
worked for the am and merge backends, but wasn't a valid option for the
interactive backend.

rebase was taught the --no-ff option for interactive rebases in commit
b499549401cb ("Teach rebase the --no-ff option.", 2010-03-24), to do the
exact same thing as --force-rebase does for non-interactive rebases.  This
commit explicitly documented the fact that --force-rebase was incompatible
with --interactive, though it made --no-ff a synonym for --force-rebase
for non-interactive rebases.  The choice of a new option was based on the
fact that "force rebase" didn't sound like an appropriate term for the
interactive machinery.

In commit 6bb4e485cff8 ("rebase: align variable names", 2011-02-06), the
separate parsing of command line options in the different rebase scripts
was removed, and whether on accident or because the author noticed that
these options did the same thing, the options became synonyms and both
were accepted by all three rebase types.

In commit 2d26d533a012 ("Documentation/git-rebase.txt: -f forces a rebase
that would otherwise be a no-op", 2014-08-12), which reworded the
description of the --force-rebase option, the (no-longer correct) sentence
stating that --force-rebase was incompatible with --interactive was
finally removed.

Finally, as explained at
https://public-inbox.org/git/98279912-0f52-969d-44a6-22242039387f@xiplink.com

    In the original discussion around this option [1], at one point I
    proposed teaching rebase--interactive to respect --force-rebase
    instead of adding a new option [2].  Ultimately --no-ff was chosen as
    the better user interface design [3], because an interactive rebase
    can't be "forced" to run.

We have accepted both --no-ff and --force-rebase as full synonyms for all
three rebase types for over seven years.  Documenting them differently
and in ways that suggest they might not be quite synonyms simply leads to
confusion.  Adjust the documentation to match reality.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0dbfab06d0..7a2ed9efdc 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -337,16 +337,18 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
--f::
+--no-ff::
 --force-rebase::
-	Force a rebase even if the current branch is up to date and
-	the command without `--force` would return without doing anything.
+-f::
+	Individually replay all rebased commits instead of fast-forwarding
+	over the unchanged ones.  This ensures that the entire history of
+	the rebased branch is composed of new commits.
 +
-You may find this (or --no-ff with an interactive rebase) helpful after
-reverting a topic branch merge, as this option recreates the topic branch with
-fresh commits so it can be remerged successfully without needing to "revert
-the reversion" (see the
-link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
+You may find this helpful after reverting a topic branch merge, as this option
+recreates the topic branch with fresh commits so it can be remerged
+successfully without needing to "revert the reversion" (see the
+link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for
+details).
 
 --fork-point::
 --no-fork-point::
@@ -498,18 +500,6 @@ See also INCOMPATIBLE OPTIONS below.
 	with care: the final stash application after a successful
 	rebase might result in non-trivial conflicts.
 
---no-ff::
-	With --interactive, cherry-pick all rebased commits instead of
-	fast-forwarding over the unchanged ones.  This ensures that the
-	entire history of the rebased branch is composed of new commits.
-+
-Without --interactive, this is a synonym for --force-rebase.
-+
-You may find this helpful after reverting a topic branch merge, as this option
-recreates the topic branch with fresh commits so it can be remerged
-successfully without needing to "revert the reversion" (see the
-link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
-
 INCOMPATIBLE OPTIONS
 --------------------
 
@@ -558,11 +548,6 @@ Other incompatible flag pairs:
 BEHAVIORAL INCONSISTENCIES
 --------------------------
 
-  * --no-ff vs. --force-rebase
-
-    These options are actually identical, though their description
-    leads people to believe they might not be.
-
  * empty commits:
 
     am-based rebase will drop any "empty" commits, whether the
-- 
2.18.0.rc2.1.g5453d3f70b.dirty


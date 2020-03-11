Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id 52E6B7D910
	for <lwn-git@archive.lwn.net>; Wed, 11 Mar 2020 15:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgCKPa1 (ORCPT <rfc822;lwn-git@archive.lwn.net>);
        Wed, 11 Mar 2020 11:30:27 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36148 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgCKPa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 11:30:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id a13so3391355edh.3
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eQtzAgEukDz7vtxEeVarqR1sW9st2xd2idk7n92ERKs=;
        b=G3yrhGYtu4YJSNJuuJw+amMtej4Mof8Si3bQU8yNTvSLDCSpB4sueX8xRYeXbe32sw
         /TrTcBvWeoLOspuh4DhVrMaCiK23yeioWFzdaR+4w9neas0RXy2y0vvusra5uQ8diGMX
         DCM409ftwXezRaqXkDo6iSAOnrLZzVJQzXnaYxWwyIcE++pkqwMfEh0XeYeS/wFExSz7
         ocr9b3fJv307pkLNdFkn721bZlyGcONFZP5aqlzDhnxAhO1m+pIFksLmF127NC19q5vm
         Tdo+vmd1/HFrNM2EPWdlvg3q+SWH9DAB5GJNMIAxSbB1h4UfVM2jPpoBpKmrWWVelkJ8
         D2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eQtzAgEukDz7vtxEeVarqR1sW9st2xd2idk7n92ERKs=;
        b=GZ4Bg/FEKK3xiYjpSxhzesOO1oB4+vgXJcNSVlVAz6EwYRS0VnKO774yp1gauSIose
         ujkfNZiCzbf3b/REf2nRHqKl03/ch5SQgzDTpsTC/eO0Sy1ejIwRq8NZRKUHXr6ZR/Rp
         6RLoFqs2FEvkj/VNGwq4W3USwgRFX6+EDPOiVRjaeJJe4rBtwdx9EI7YkMUEzfTHlkl1
         w4p86JhQuyM7kupr5du889W4xfVBqS9UIstTxF51t5jvWbvG5mTGGGTfV3Dhhq9/fEfu
         +DaazEink8rYiW4v8V4OK9OO7b2myq9iWhJjej+2SWvhqHkVG0Z8sr53PiaBQ9DEBAI3
         S+Iw==
X-Gm-Message-State: ANhLgQ3hw9TmIHOm5vPYnJGSnCRaLDR4iSVTqx8SoBUXFj53Nm9G/kk1
        r1bXcpOtHyi4lUxoqmzgpRPt7194
X-Google-Smtp-Source: ADFU+vvZjsM8vDcpIin4nUF+ORq3kWgMuiO5CE0EnTGWU6ifTCTIZD8wuZg9M3ig4xVXrd2o2fRwlA==
X-Received: by 2002:a17:906:5217:: with SMTP id g23mr2812822ejm.209.1583940624943;
        Wed, 11 Mar 2020 08:30:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id rl28sm438607ejb.28.2020.03.11.08.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 08:30:24 -0700 (PDT)
Message-Id: <pull.722.v2.git.git.1583940623.gitgitgadget@gmail.com>
In-Reply-To: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Mar 2020 15:30:21 +0000
Subject: [PATCH v2 0/2] Fix 2.26.0 rebase regression and documentation shortcoming
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/git/pull.722.v2.git.git.1583940623.gitgitgadget@gmail.com/>
List-Archive: <http://archive.lwn.net:8080/git/>
List-Post: <mailto:git@vger.kernel.org>

This two commit series addresses two points raised by Peff about rebase
backend issues. The first is a two-line fix to a regression in 2.26.0 (when
"the eighth batch for 2.26.0" added the dropping of commits which become
empty, if the last commit in the series was the one that became empty the
rebase would complete without cleaning out state files), and the other is
just a documentation update about a backend difference that we were
previously unaware of.

Changes since v1:

 * Clean out any MERGE_MSG file in addition to CHERRY_PICK_HEAD, and add a
   test

Elijah Newren (2):
  sequencer: clear state upon dropping a become-empty commit
  git-rebase.txt: highlight backend differences with commit rewording

 Documentation/git-rebase.txt | 10 ++++++++++
 sequencer.c                  |  2 ++
 t/t3424-rebase-empty.sh      |  8 ++++++++
 3 files changed, 20 insertions(+)


base-commit: b4374e96c84ed9394fed363973eb540da308ed4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-722%2Fnewren%2Frebase-fixups-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-722/newren/rebase-fixups-v2
Pull-Request: https://github.com/git/git/pull/722

Range-diff vs v1:

 1:  132f769adb0 ! 1:  84b89d78435 sequencer: clear CHERRY_PICK_HEAD upon dropping a become-empty commit
     @@ -1,6 +1,6 @@
      Author: Elijah Newren <newren@gmail.com>
      
     -    sequencer: clear CHERRY_PICK_HEAD upon dropping a become-empty commit
     +    sequencer: clear state upon dropping a become-empty commit
      
          In commit e98c4269c8 ("rebase (interactive-backend): fix handling of
          commits that become empty", 2020-02-15), the merge backend was changed
     @@ -9,10 +9,10 @@
          upstream).  This new code path did not need to go through the process of
          creating a commit, since we were dropping the commit instead.
          Unfortunately, this also means we bypassed the clearing of the
     -    CHERRY_PICK_HEAD file, which if there were no further commits to
     -    cherry-pick would mean that the rebase would end but assume there was
     -    still an operation in progress.  Ensure that we clear CHERRY_PICK_HEAD
     -    when we decide to drop the commit.
     +    CHERRY_PICK_HEAD and MERGE_MSG files, which if there were no further
     +    commits to cherry-pick would mean that the rebase would end but assume
     +    there was still an operation in progress.  Ensure that we clear such
     +    state files when we decide to drop the commit.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ -24,6 +24,24 @@
       	} else if (allow == 2) {
       		drop_commit = 1;
      +		unlink(git_path_cherry_pick_head(r));
     ++		unlink(git_path_merge_msg(r));
       		fprintf(stderr,
       			_("dropping %s %s -- patch contents already upstream\n"),
       			oid_to_hex(&commit->object.oid), msg.subject);
     +
     + diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
     + --- a/t/t3424-rebase-empty.sh
     + +++ b/t/t3424-rebase-empty.sh
     +@@
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'rebase --merge does not leave state laying around' '
     ++	git checkout -B testing localmods~2 &&
     ++	git rebase --merge upstream &&
     ++
     ++	test_path_is_missing .git/CHERRY_PICK_HEAD &&
     ++	test_path_is_missing .git/MERGE_MSG
     ++'
     ++
     + test_done
 2:  12932b847ef = 2:  6d51cff41d9 git-rebase.txt: highlight backend differences with commit rewording

-- 
gitgitgadget

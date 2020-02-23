Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12BAC35671
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 18:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4CF206E2
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 18:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeRIwjkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgBWS5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 13:57:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44307 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWS5O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 13:57:14 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so9274348eds.11
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 10:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6QCWh6QoR9VWFGXFs3OcK6o+ZIa1xd5rieFm9p8Xh+0=;
        b=AeRIwjkc3ifrfl3DknSrt3BAhb3Jczge7m0KeKK7/ffsyoy8OzbquYBmuqtwWO/9uu
         VDiHSPW1Jf8Byprs1dcd2/3+L7RB3WubrggqlykF/4hEr2wgb5uL7Tyk34AT+M+QvBXp
         vzmQcg8niIWQ6EUTH0Z6TkilOqZd8itMg+6DRr0QBnn5mtf6JcsGQRVBkrMbudWpKR0L
         72qWMqxWMNsnpuCSRmt5AnyImsfLuoDQ02l8m1hAtThz0YAk/ifyN8Bg66kKxUqLCrxN
         0zkmvwEWhJiLd9lZH3jMpTH8sXbV+QfrrHIfNI7J/7z7PNp+4v57EgwGfsThj/vgNWeN
         J4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6QCWh6QoR9VWFGXFs3OcK6o+ZIa1xd5rieFm9p8Xh+0=;
        b=G/FjdUgFBCpxIgVxk4jHfOl69gLQH0KF8jMXMnmlVT64K1QC3WhI+9diYxXexqBsWH
         0bA+vdMZ1pqUDW5VeJ1im32YmEqfkkWMO2vjmbfajg2nC/OlK6QLMz0r1aL1xMmZMoQk
         1FkTYaqjQG2peiD+/JJDaBE9JmgWnk+l0w7A5yVxNa3GuurPDCnqAMQpEOkDmpcMDN8J
         34gaegWVrtLfsT1wyPT8PfHHdfiCY3N173nCOHcaDkpnF1PU7VJ2UfHaq9LO6CImHLEC
         XXWeunoWARm4lNbJru4jnecf8LBZkKhSWOP6EzlCA5+BZgvkJmpjzKhg1WkxzCIWny8s
         gP9A==
X-Gm-Message-State: APjAAAVpKQkmV7e167AGspDzwVZeNSbg/AGFJratzsPUjyY+P3LMbBzI
        0Rdp1VUR7uPeRDxEXjzDy6BRSw6N
X-Google-Smtp-Source: APXvYqzCfhJcSAeH3R2JvyhD23Pa7WuB0O7YYb8v/k5FXJjB5lgwtEXZj8dTyOKrjrobZcHVmcHJwg==
X-Received: by 2002:a17:906:814a:: with SMTP id z10mr42096294ejw.62.1582484232364;
        Sun, 23 Feb 2020 10:57:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm666590ejx.11.2020.02.23.10.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 10:57:11 -0800 (PST)
Message-Id: <pull.535.v3.git.1582484231.gitgitgadget@gmail.com>
In-Reply-To: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
References: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 23 Feb 2020 18:57:07 +0000
Subject: [PATCH v3 0/3] [GSoC] receive.denyCurrentBranch: respect all worktrees
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The receive.denyCurrentBranch config option controls what happens if you
push to a branch that is checkout into a non-bare repository. By default, it
rejects it. It can be disabled via ignore or warn. Another yet trickier
option is updateInstead.

When receive.denyCurrentBranch is set to updateInstead, a push that tries to
update the branch that is currently checked out is accepted only when the
index and the working tree exactly matches the currently checked out commit,
in which case the index and the working tree are updated to match the pushed
commit. Otherwise, the push is refused.

However, this setting was forgotten when the git worktree command was
introduced: only the main worktree's current branch is respected. [ fixes:
#331 ]

Incidently, this change also fixes another bug i.e. 
receive.denyCurrentBranch = true was ignored when pushing into a non-bare
repository using ref namespaces.

Thanks, @dscho for helping me out.

Regards, Hariom

Hariom Verma (3):
  get_main_worktree(): allow it to be called in the Git directory
  t5509: use a bare repository for test push target
  receive.denyCurrentBranch: respect all worktrees

 builtin/receive-pack.c           | 37 +++++++++++++++++---------------
 t/t5509-fetch-push-namespaces.sh | 13 ++++++++++-
 t/t5516-fetch-push.sh            | 11 ++++++++++
 worktree.c                       |  1 +
 4 files changed, 44 insertions(+), 18 deletions(-)


base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-535%2Fharry-hov%2Fdeny-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-535/harry-hov/deny-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/535

Range-diff vs v2:

 1:  8718facbc95 = 1:  8718facbc95 get_main_worktree(): allow it to be called in the Git directory
 2:  5c749e044a3 ! 2:  ae749310f06 t5509: initialized `pushee` as bare repository
     @@ -1,6 +1,6 @@
      Author: Hariom Verma <hariom18599@gmail.com>
      
     -    t5509: initialized `pushee` as bare repository
     +    t5509: use a bare repository for test push target
      
          `receive.denyCurrentBranch` currently has a bug where it allows pushing
          into non-bare repository using namespaces as long as it does not have any
 3:  b3e573d44a9 < -:  ----------- bug: denyCurrentBranch and unborn branch with ref namespace
 4:  61e5f75a6f9 ! 3:  d21a590d6c2 receive.denyCurrentBranch: respect all worktrees
     @@ -134,11 +134,18 @@
       	test_cmp expect actual
       '
       
     --test_expect_failure 'denyCurrentBranch and unborn branch with ref namespace' '
      +test_expect_success 'denyCurrentBranch and unborn branch with ref namespace' '
     - 	cd original &&
     - 	git init unborn &&
     - 	git remote add unborn-namespaced "ext::git --namespace=namespace %s unborn" &&
     ++	(
     ++		cd original &&
     ++		git init unborn &&
     ++		git remote add unborn-namespaced "ext::git --namespace=namespace %s unborn" &&
     ++		test_must_fail git push unborn-namespaced HEAD:master &&
     ++		git -C unborn config receive.denyCurrentBranch updateInstead &&
     ++		git push unborn-namespaced HEAD:master
     ++	)
     ++'
     ++
     + test_done
      
       diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
       --- a/t/t5516-fetch-push.sh

-- 
gitgitgadget

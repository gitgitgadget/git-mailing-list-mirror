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
	by dcvr.yhbt.net (Postfix) with ESMTP id 138541F463
	for <e@80x24.org>; Thu, 26 Sep 2019 07:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfIZHmc (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 03:42:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46705 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbfIZHmc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 03:42:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id t8so908327lfc.13
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lpB196YBbbyP86n+qeSaI6ssRb4e8bkzqeJ9vIMDVz0=;
        b=Q+JzNr73KdzuY3FB6IlCTpx++Ki63QdJCOLcp4iyxGlNHn2JkVy2zb64D23w6OBp0O
         OWWzGmn/Zi6hI5UuCEez8/Pm9INpRaaRsrPSxWKWUfqKEBNdxcS/tKC0jbEuHK0yBKZz
         LOlHTru5CHs3Oouyeos9x1LBcU7f8H5Og2MHUZcSbYg0PdK8NrGp9e7tzRIFHvabwHLO
         7k8yn+LYowSBP62T3vP+1wGcsLd7jaUZN1ROjwPezH/yfvzKqO2hj+3NgQ4bEVTgwOqw
         wtDD3TgYFGwVC/yZIdgr/wbc33fvy/ArWZIhOPYcbh7NVmHUWY3bp4sF4oaxHxbGjTRV
         qFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lpB196YBbbyP86n+qeSaI6ssRb4e8bkzqeJ9vIMDVz0=;
        b=X6zDS85i+OmOEyLAOItOUY0Z/eD3rdmAagaBmTos/3TppE5ahXeX/Bw4jIKS0nGXkI
         CIYuBtBYZbmQfiNeMxjJzqbU6D3C4EP8jW8+onLpwJie7DlXvDF5qqY9U6G547AooQiq
         MpWkKo++deVvbw1WGS4ziJItP2bQ48IFeoCQGDFgipAyLNWpXych0CqXrdFnlO7rJIbV
         /QuLKFYAuL7/VvwFkyEs4/2CKVO/eS6oIKxURYq7087ceJZ7vRIy/l1UHimgp1ubeurr
         vBdn4tTHh6aAjZ0K+okIqUgOP57VXHc993YBy/nLQ7v3LV4+Xz741RCzMc6ut/vCxkk/
         Ck9g==
X-Gm-Message-State: APjAAAW17N3sPN0494W8vXT0BTIOduWz+dte7MeAnWHDNy3R3VZaiOd3
        hCILto15C52jKCCsSXyoPLGsuLWn
X-Google-Smtp-Source: APXvYqziEqYWQDCjrVUYQMygPdpEr3mAWAqHW6iWgpNblY9DWQHw03NlOCtkAm2Rw2H2/DuFJpR5oA==
X-Received: by 2002:a19:c695:: with SMTP id w143mr1202762lff.162.1569483750247;
        Thu, 26 Sep 2019 00:42:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z72sm320784ljb.98.2019.09.26.00.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 00:42:29 -0700 (PDT)
Date:   Thu, 26 Sep 2019 00:42:29 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 07:42:25 GMT
Message-Id: <pull.355.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Fix git stash with skip-worktree entries
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My colleague Dan Thompson reported a bug in a sparse checkout, where git
stash (after resolving merge conflicts and then making up their mind to
stash the changes instead of committing them) would "lose" files (and files
that were not even in the sparse checkout's cone!).

I first considered changing the behavior of git diff-index to simply ignore
skip-worktree entries. But after re-reading the documentation of the
skip-worktree bit, I became convinced that this would be incorrect a fix
because the command really does what it advertises to do.

Then, I briefly considered introducing a flag that would change the behavior
thusly, but ended up deciding against it.

The actual problem, after all, is the git update-index call and that it
heeds the --remove (but not the --add) option for skip-worktree entries.
"Heeds", I should say, because the idea of the skip-worktree bit really is
documented to imply that the worktree files should be considered identical
to their staged versions.

So arguably, it could be considered a bug that git update-index --remove 
even bothers to touch skip-worktree entries. But this behavior has been in
place for over 10 years, so I opted to introduce a new mode that does what 
git stash needs in order to fix the bug.

Johannes Schindelin (2):
  update-index: optionally leave skip-worktree entries alone
  stash: handle staged changes in skip-worktree files correctly

 Documentation/git-update-index.txt |  6 ++++++
 builtin/stash.c                    |  5 +++--
 builtin/update-index.c             |  6 +++++-
 git-legacy-stash.sh                |  3 ++-
 t/t3903-stash.sh                   | 11 +++++++++++
 5 files changed, 27 insertions(+), 4 deletions(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-355%2Fdscho%2Ffix-stash-with-skip-worktree-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-355/dscho/fix-stash-with-skip-worktree-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/355
-- 
gitgitgadget

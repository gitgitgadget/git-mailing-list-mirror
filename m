Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1639C3405E
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794DB24673
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdPYteWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBSREK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:04:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34845 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgBSREK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 12:04:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so1489363wmb.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 09:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G711hVn6Zeme2NkNtCVHXBGy0zEPbLiXaRJH3e+s7+0=;
        b=BdPYteWDzm3cQIpQ9Y9Fz7VfoXK9RCs/chJ7O1D90qzgOK70NjYa67ZaicRHE436bm
         P7cPVKNLfFpxH5TiHBFkblMpIM+d26+d9EyakKesS9cQ6wAsgKfsyZ7Y6KhSpanWuWbS
         RJ1vW69E56KV0EnvxqVaIUi+2gun7O/7W9Yronh7v6hcd8AtjeT3Hq8tp/hEMDzQQkv9
         6JtCFe8EYtcbhRnGjAAOrHAEjQhXrWKCIZR1hCOqL6YqxPQFzqD60t/9yGJdfOu+o+uN
         IAzFJJlb23kyvSi3V5de6oJ+sunZ36IvXR8DawX3fckQPdqNnuOPLD0s4JoSgQ05Qh3w
         Rv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G711hVn6Zeme2NkNtCVHXBGy0zEPbLiXaRJH3e+s7+0=;
        b=lbEgYpCKH4058j+YEjQyPgUtV8eBP2JoMmH9aDIIfDb1UtxTlpNv5ErNU872FJ0HbM
         MaWuqOSScyb6VkTcWVfbR/cFPcSMN3RZyWQnfzAAUBWq7fsfKUc2mBJ6E9NiBUlrHAJ6
         RN3b6+e2QVZrzqI1+cWVk9hbcgnwBvQAyGGy15VbZKXUd15rpgAlbYY2bejPK8MchAqn
         jdvvgSDudF65qeHBf20w6NzUgX5j0bLqf8/BBISUef4S8K0LvTJx4EIJj4rMOFCmXwer
         dd+A8fbtsqWHS2I4elJMjHMibjwr+/YI90TzOmgtY2J6wEYcQBqkD+wrdErrfxOEYHnB
         oM8Q==
X-Gm-Message-State: APjAAAVuQqy+38L1iZYyEf0MV0i4VUE3587a88uY3q7n5zaqd3Xzt6LU
        okM1uPh08sbIYXwMj+CpNmHSgUVs
X-Google-Smtp-Source: APXvYqzBlX1uACH+yvFAQMqdxvJ7LrLLRsofLN5rvspyMv5O2i9VV51++ipAY3rHNduPdBNZrESK4g==
X-Received: by 2002:a7b:c8d3:: with SMTP id f19mr10878917wml.26.1582131848957;
        Wed, 19 Feb 2020 09:04:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2sm427285wrq.31.2020.02.19.09.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 09:04:08 -0800 (PST)
Message-Id: <pull.712.v4.git.git.1582131847.gitgitgadget@gmail.com>
In-Reply-To: <pull.712.v3.git.git.1582064105813.gitgitgadget@gmail.com>
References: <pull.712.v3.git.git.1582064105813.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Feb 2020 17:04:05 +0000
Subject: [PATCH v4 0/2] t3433: new rebase testcase documenting a stat-dirty-like failure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3:

 * add another patch which fixes the bug. Thanks to Phillip for doing some
   digging to find the bug wasn't in rebase but in git_merge_trees().

Elijah Newren (2):
  t3433: new rebase testcase documenting a stat-dirty-like failure
  merge-recursive: fix the refresh logic in update_file_flags

 merge-recursive.c                    |  7 ++--
 t/t3433-rebase-across-mode-change.sh | 48 ++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100755 t/t3433-rebase-across-mode-change.sh


base-commit: e68e29171cc2d6968902e0654b5687fbe1ccb903
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-712%2Fnewren%2Fdocument-rebase-failure-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-712/newren/document-rebase-failure-v4
Pull-Request: https://github.com/git/git/pull/712

Range-diff vs v3:

 1:  270591cd3be = 1:  270591cd3be t3433: new rebase testcase documenting a stat-dirty-like failure
 -:  ----------- > 2:  ba297fd67bb merge-recursive: fix the refresh logic in update_file_flags

-- 
gitgitgadget

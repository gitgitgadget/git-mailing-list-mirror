Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33CC51F404
	for <e@80x24.org>; Sat, 10 Mar 2018 15:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbeCJPyx (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 10:54:53 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36532 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeCJPyv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 10:54:51 -0500
Received: by mail-pl0-f67.google.com with SMTP id 61-v6so6906222plf.3
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 07:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ipb1VrvDMv+OA81BGzJjUSohJokZBmcY8WhWTKW2kKw=;
        b=qW9mElHmBpJH/r0yaFbKA6y4Mf+7tZgMokZui4ZEr0al+NW/UrtjyAX5MatE4/CLsj
         tuPUx7hbywJ+NfMaAUfH3YtqpNZow8C3fmzzVdOQzx/JCP+NbW/Aa4aiCA6v93KFX8FM
         /kZz7eUuv/cQE0ZOHCcDXI2wmA84ENFsj0Fn7jKuRaoA6z9akYonbl5LaI7mwcjg9tbg
         M1axiXtx0484ik3xij3bG9KOgGFIX9ZAyJ1g4cUeTOY4TX9IeRHW6wOaf2q37Wdi4UsH
         e8ODrIDponP8HhW/T9uMY52GZakFbgZa0fsy8/jiXmzB85c8i6PVbG2/qqajwDDvk8Wy
         69fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ipb1VrvDMv+OA81BGzJjUSohJokZBmcY8WhWTKW2kKw=;
        b=P98vdD5IwvIGvD45O5qZLxF6BcDopj/duiNdNhxZABL+uVXhzH3wzy6C+GgCgIz5E/
         eRQ/qwDH4xy3h15Hxn52eygLl/kEpqhNt8h29c7Pg15IQ3KIatTNAXuCf0A4UyodLrxO
         fvzn4WTqIvtrdJ8wpWk5YLXvIlqLdIBr+y1mfnHAlIyBgFvjsAoB4KLHz6pDClHDSdz+
         AYAw9irTm/9svjuV4ZnSwwFXwJ03H61/MrDE61+fdBuorma5x5HkWEpr9qrmCjMLdEPH
         7ZZJFeC1VM2b5ALCWm/aBULH3tbXgNmWt9Ew/yKUP4AtOGUqodoU/XjRCSYreDxUCSKJ
         tIYQ==
X-Gm-Message-State: AElRT7HB3TrIAJZSHdm+rja2q7fOhdD0Nuzwz6XWapXB1IhKxLH2i3PX
        q/hGelGHTetP1EUjAHFy2ocl8ayl
X-Google-Smtp-Source: AG47ELs8BQRVS+1oT6k/acAuhpJTWtkj4bblSnWF4bFMSMepX5+y5yxe7iqYZ7rCmmQ/We9NiY9NMA==
X-Received: by 2002:a17:902:710e:: with SMTP id a14-v6mr2365947pll.291.1520697291077;
        Sat, 10 Mar 2018 07:54:51 -0800 (PST)
Received: from localhost.localdomain ([117.209.148.118])
        by smtp.gmail.com with ESMTPSA id j25sm7795956pgn.92.2018.03.10.07.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Mar 2018 07:54:50 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 0/3] give more useful error messages while renaming branch (reboot)
Date:   Sat, 10 Mar 2018 21:24:13 +0530
Message-Id: <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f13
In-Reply-To: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been a long time since the v3 of the patch. So, it's worth restating
the reason behind this patch.

From v1 of this patch,

     In builtin/branch, the error messages weren't handled directly by the branch
     renaming function and was left to the other function. Though this avoids
     redundancy this gave unclear error messages in some cases. So, make
     builtin/branch give more useful error messages.

Changes since v3:

 - Handled more error related to old branch name.

 - Incorporated changes suggested in v3 which include using ';' as a sentence
   connector instead 'and'.

 - Error messages use the interpreted branch names (without the (refs/heads/ part).

The unrelated cleanup patches which were in the previous versions have
since been submitted as a separate series and have been merged into
the codebase.

The first two patches are related to the topic of this patch. The 3rd one
is a little typo fix that I noticed on the way.

This patch was based off 'master' and has been rebased to incorporate
the new changes to 'master'. So, it generally should apply cleanly on
'master'. Let me know if it doesn't.

The sample input/output cases for this patch are as follows,

	$ git branch
	* master
	  foo
	  bar

Before patch,

	# Case 1: Trying to rename non-existent branch
	$ git branch -m hypothet no_such_branch
	error: refname refs/heads/hypothet not found
	fatal: Branch rename failed

	# Case 2: Trying to rename non-existent branch to an existing one
	$ git branch -m hypothet master
	fatal: A branch named 'master' already exists.

	# Case 3: Trying to force update current branch
	$ git branch -M foo master
	fatal: Cannot force update the current branch.

	# Case 4: Trying to force rename an in-existent branch with an invalid name
	$ git branch -M hypothet ?123
	fatal: '?123' is not a valid branch name.

After patch,

	# Case 1: Trying to rename non-existent branch
	$ git branch -m hypothet no_such_branch
	fatal: branch 'hypothet' doesn't exist

	# Case 2: Trying to rename non-existent branch to an existing one
	$ git branch -m hypothet master
	fatal: branch 'hypothet' doesn't exist; branch 'master' already exists

	# Case 3: Trying to force update current branch
	$ git branch -M foo master
	fatal: cannot force update the current branch

	# Case 4: Trying to force rename an in-existent branch with an invalid name
	$ git branch -M hypothet ?123
	fatal: branch 'hypothet' doesn't exist; new branch name '?123' is invalid


Note: Thanks to the strbuf API that made it possible to easily
construct the composite error message strings!

Kaartic Sivaraam (3):
  branch: introduce dont_fail parameter for branchname validation
  builtin/branch: give more useful error messages when renaming
  t/t3200: fix a typo in a test description

 branch.c           |  59 +++++++++++++-----------
 branch.h           |  61 ++++++++++++++++++++-----
 builtin/branch.c   | 111 ++++++++++++++++++++++++++++++++++++++-------
 builtin/checkout.c |   5 +-
 t/t3200-branch.sh  |   2 +-
 5 files changed, 181 insertions(+), 57 deletions(-)

-- 
2.16.1.291.g4437f3f13


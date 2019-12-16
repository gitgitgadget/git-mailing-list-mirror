Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACEBC2D0C3
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EE820725
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piCUA7Ms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfLPPs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:48:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45760 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbfLPPsR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:48:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so3662195wrj.12
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G7opqmJudGICA/Y3BZzKEcINzC9/yKeSSKBMoBEqXVI=;
        b=piCUA7MstIBAYdyRROZewewNd+XDaNjnqHgQNwkm1CjZJ2W3IzOlmWps8tkqiVdeBX
         fXPDznDUZ30HZRxQ2MTLRNqCtg6wWgK+sCBP2+M4Jz+yJoW0fAXCiKqgD07myZ2Euo3z
         srGCS2cylnmSeWwiyUy+C4pllJuKc6+9nsPlxlsERJNij/9opotZMSCuX/qde5/CkPW0
         fMfvxiFuv7QenvcMmJ8LpXgPDXV8WxJyZgugzTaBYlUkxv7v7EWZVdVSzk/84wtZivYY
         lryhVE+zmSXz6jR+/AYwSFROlJVl0n76nh4Ry0jovNEZUf0cZjFLqZEqB0UECTI1a9AS
         vBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G7opqmJudGICA/Y3BZzKEcINzC9/yKeSSKBMoBEqXVI=;
        b=qMehPuIF6crcAppRfrRNgp118cSWyecljItTDvvvKWL90Y6/W1pxWZPxENoAkM6PIX
         WvnTDUzOhqlSsEk70oJhtBXzXPqKcv4uuu+bETYdmYlBK3madQlex2maW20V8Jv0lolt
         +YUSBB84ktkWtBUVEjUF5yIhNnGJEUDcYLnwjIf12ImOmwwRMNJwOOJhiDKOj5GreYa7
         d+aDg/RFSzn0WmiFEYG42BXgeCCNyetQU8BCWwVhUmQN9w8JLQglcfgliOYaFiZsg4Xe
         Gt9kuKo/RnZ5lUIJtU62ZZiC6QjhkZfAYxzf2TmD5e+WeIoE3grYcxCNnR6+VW9uVj14
         mR7g==
X-Gm-Message-State: APjAAAUQG1RDyvWB25IhpDuzbbS8MjDp2gC+V/b+QOghypD1Peb7Ap1b
        BO8N4mJw3bov9PJLwCHAWVR5hCWK
X-Google-Smtp-Source: APXvYqy3HTPUaWUsBkRossifwa/Za+gMqyY/DR5nLuPlZl4t7FZNLG/rMOVv4EY44p9Hc0CvglDjOQ==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr25329738wrh.49.1576511294860;
        Mon, 16 Dec 2019 07:48:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v62sm16732193wmg.3.2019.12.16.07.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:48:14 -0800 (PST)
Message-Id: <c88cbf453adfa9184e1fcb8fdcbac7d9a1443283.1576511287.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
        <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 15:47:58 +0000
Subject: [PATCH v2 10/18] doc: restore: synchronize <pathspec> description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

`git add` shows an example of good writing, follow it.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-restore.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 1ab2e40ea9..d7bf016bba 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -8,8 +8,8 @@ git-restore - Restore working tree files
 SYNOPSIS
 --------
 [verse]
-'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] <pathspec>...
-'git restore' (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [<pathspec>...]
+'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] [--] <pathspec>...
+'git restore' (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -113,6 +113,14 @@ in linkgit:git-checkout[1] for details.
 	appear in the `--source` tree are removed, to make them match
 	`<tree>` exactly. The default is no-overlay mode.
 
+\--::
+	Do not interpret any more arguments as options.
+
+<pathspec>...::
+	Limits the paths affected by the operation.
++
+For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
+
 EXAMPLES
 --------
 
-- 
gitgitgadget


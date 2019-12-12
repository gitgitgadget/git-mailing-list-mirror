Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0D2C00454
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A029522527
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0Bzv21p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfLLOgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:36:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50266 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbfLLOge (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:36:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so2632544wmb.0
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G7opqmJudGICA/Y3BZzKEcINzC9/yKeSSKBMoBEqXVI=;
        b=Y0Bzv21py2Vo77YHQGxi0TY3Ibc3s/yGf2/ZZ9bmSQJtx9L0U1Hl2kXAzR/Potpd7f
         kpGCmIk6ZGRXz6QT4Vgm1Za6ufiZnfdIiqflCl/Kj1MS5Sjz/0SQDZax2CEISqW3y67R
         qCRtQDFsu6LUr11IuIskk6vKZ1klpZSv5133OE+8uLAe/qQEMMdAdTQ/4U/PRzZgGzEn
         QgqzvaRosGIsiCAHVrnfBQVLc8WEUlAYiiU6Tx/0gY2hyyw1zP+KpQYTFrAVYlfJNhhp
         LAwSKQ6Zk7Fi1DbehfZeZuv2eBR2czOa/IcQud7nrnMvfvZqGuOxh+lsGxk6qVdcXUnt
         c6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G7opqmJudGICA/Y3BZzKEcINzC9/yKeSSKBMoBEqXVI=;
        b=WZ9IhDbcq6PxIty78gWz+6CYvjgHHJfvH9ahly7/978UW8fWZ9hBWU/ja8Ckza1NgM
         W4poVQs+ia/xzpIwqYVP9ZpytLRafFU3vH4HRxSlFu4apY5aHUEwd3AqmpT9a+FGkAqH
         ChCbJaTgpRN/jMKjaAdapL6Mcmsq2q2RqvEnLrdUH3CByW2KAG5kvsXo+iQDEfH12b2C
         2OCb5QiIk/m5MA6A3Xq7oXKgrowx843qJaA3cjpNjHrWa4D4q+EFTHQiqj3P6GiMVCYB
         yz5YouknWhy3II8WSqKhUUsj1rkRNLNCBBG8oXx0bUhM/u8XhvNDyZnsrJH8bZUq/siT
         8zmQ==
X-Gm-Message-State: APjAAAVme21Hk0AfDrtccgle/buz/lg8m+q2sQXVUO/KHzgPd5bRdpn8
        HFoxsugLtbxDbUe6ftCld/5SoEya
X-Google-Smtp-Source: APXvYqz/M3j5+qbOtsc2+AoaaVxWpXc0Hc/NjNM8S4Q6ibtrYrU2fl3zuAiZ8CafqWKlxelurpNAcg==
X-Received: by 2002:a1c:a745:: with SMTP id q66mr3144479wme.167.1576161392141;
        Thu, 12 Dec 2019 06:36:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17sm6249895wro.77.2019.12.12.06.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:36:31 -0800 (PST)
Message-Id: <d2f277bb58c6462f1c7f856b5ef2b3ac9894b830.1576161385.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.git.1576161385.gitgitgadget@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 14:36:17 +0000
Subject: [PATCH 08/16] doc: restore: synchronize <pathspec> description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano" 
        <gitster@pobox.com>, Emily Shaffer <emilyshaffer@google.com>,
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


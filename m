Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0549EC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDACD20716
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WME5F0LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfLSSCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:14 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33306 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfLSSCK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:10 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so5784629edq.0
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G7opqmJudGICA/Y3BZzKEcINzC9/yKeSSKBMoBEqXVI=;
        b=WME5F0LISPWmbJgyrQsHtOYy6CEzRT6KHEZWrg/89sp2ptbKPl8xdW9CXmbuQiU5yS
         9zZilTX3g24qX2mwTw+TEAvmgHmiLOReaVQlWhTyRM2lsMQmvkOuaEAiCdos159+EyUt
         Qj+05w6Ts9UvUFW9UsG6pl9NwutzAvgIQds5nZrQm60xrrICC0MtH+q5cqyFzfwJSd0v
         Yq33L0jui2x2ntAQ3XGB3A/35gRhYA10ipn4XfWydV6TKu1j+47GLtIiScC+ROxkF46K
         mUQ33/J6U9FtkoxyIs1GehJDedOQ8doqUI20iE8q1fyGbgCWIMaVGYdWd/5EOok1HfbH
         i84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G7opqmJudGICA/Y3BZzKEcINzC9/yKeSSKBMoBEqXVI=;
        b=DbVG6+ijj4b9fLcxDvOv6pklIWy4pZ0o/pdCd8SOx6tW9FmJhoD3i2TNqrgbDaBFl7
         KKnP6wUUngTswge8u2iRn2FayA6UgDlOHiS5oq0YQDUdf7tMkV7tSp3+hA+//8nPsDaZ
         XKw5jtbOaDvDYtj+BljbMQE6b6RHUbMywoSPKuGTiW/Zih7ZZoEb2DGWnOWmNz3YB15P
         UBS110nlA3cRwE7KR9DIneZGsaYu/tbjCMOCwhFr9iIDblp8b2Nvv0k8rH+caY3oYX65
         xwgvqgn6t7z5mCZlxGq8Tdx4Ip4TjaQanGxktcrZGsplcwldgqB7PsXQ8fv/o8svGRDo
         w4PQ==
X-Gm-Message-State: APjAAAXuO+nlWbNdyQ3yYUhp96Ieac59JUExqxPOJXWJtGSqcGcqKOFk
        eq8KmfEmRRH9gYbjpVSe+0dk5+Xl
X-Google-Smtp-Source: APXvYqxtWKpHI3V3EKb+coQf0v7GT8FBpgzZoRjjgednILa7qE8SmLhhY3ypy8OVMHhCZ+orFrN7oQ==
X-Received: by 2002:a05:6402:1437:: with SMTP id c23mr10848794edx.48.1576778527925;
        Thu, 19 Dec 2019 10:02:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e20sm637615ejq.62.2019.12.19.10.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:02:07 -0800 (PST)
Message-Id: <137b697327aaf09384c660e4671bd55635c147c1.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:47 +0000
Subject: [PATCH v3 10/18] doc: restore: synchronize <pathspec> description
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


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2582AC433EF
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 06:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiFSGuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiFSGuh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 02:50:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9371CB1CC
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w17so10582251wrg.7
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AAEHqAyh6Hw2t1Qs24FsOj3XLBmYcT9ZZul30+M6APM=;
        b=AF6KLnzaoGy+T2r9T86eFcqDu25kjVZiu1E13o73tuoaNn0LpkuKzhoZ/nXecZEQIX
         vwZE3yPAstKfnKQhBALwKvWXDf38o9BvRnkhQH2gp2VzdRsP770tVsWlwqKlGLDBRnrf
         6L+mz+a34oZ7xw7CTjyOiKgvJiy4JC+TBkdW++fPwOkqVOIDWQ1tgfHlSpy8gscfCpvO
         6thojNPwm14Kowb/5LpAKnAaYEzwM9EZ+2KsKkBiCf72LY+Oetgk3uzlP2KltTf88Rvd
         Jis1ri3RjPUXMzoKpPiYE3vB+ifAGQ3XfsxHB11WYH4Vu2wWc9m25u6eWREFKo3apnxU
         6yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AAEHqAyh6Hw2t1Qs24FsOj3XLBmYcT9ZZul30+M6APM=;
        b=gS48kZQ5ljoqPP0N0fmEEuA5Qp6bcRqxHJ92rxljApNpZzSGP/wuwDv8Ay7bJV4FVA
         c+kgE0RlTCg+LuO4Cwf+K1PwHOTN+/UKBVNdeaYIqoAfXp9Im+TrqRcMiYlzYMZxqvJP
         XKb8f6ka2jMYwWnN8LyVAfDHjbh4EdDLB9VAwUdLQV8ciu+l1SvTSfvLNDFBdYJ58L8P
         uNqmokU7OvfHQC0WKttO3pPLJar3+8w4JusQK4v75RHf8Nj1bNMCHnG0IjoUB+AypRM3
         DWWIBKHV4cgl5Nm6Ow0GXtTQRA2xlgjgmmzhZu0FdAzDv5ZzEB/SDqOhudhNx9ggqZk5
         Tu9A==
X-Gm-Message-State: AJIora8c7uIb4aM5qQPSCLcp4qBX5pWNiRYGWyp2nE+972oqY3or8blX
        3V689l93NrTBu6fPsbSiqjFe8seJeg/z5g==
X-Google-Smtp-Source: AGRyM1veeDmRlOgfBDdiWnNbPXFkynLFwoNQyaPhXWhzWeJhul4SkXDKdQ21cDkJxek2z+4WGU8aoQ==
X-Received: by 2002:a05:6000:156c:b0:218:5691:e72b with SMTP id 12-20020a056000156c00b002185691e72bmr16658172wrz.95.1655621433848;
        Sat, 18 Jun 2022 23:50:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18-20020a5d6852000000b0021552eebde6sm9259374wrw.32.2022.06.18.23.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 23:50:32 -0700 (PDT)
Message-Id: <4a8b7c9e06df36444b94b929b2558f40e3f72e81.1655621424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Jun 2022 06:50:22 +0000
Subject: [PATCH v2 4/6] merge: make restore_state() restore staged state too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge can be invoked with uncommitted changes, including staged changes.
merge is responsible for restoring this state if some of the merge
strategies make changes.  However, it was not restoring staged changes
due to the lack of the "--index" option to "git stash apply".  Add the
option to fix this shortcoming.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 8ce4336dd3f..2dc56fab70b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -383,14 +383,14 @@ static void reset_hard(const struct object_id *oid, int verbose)
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	const char *args[] = { "stash", "apply", NULL, NULL };
+	const char *args[] = { "stash", "apply", "--index", NULL, NULL };
 
 	if (is_null_oid(stash))
 		return;
 
 	reset_hard(head, 1);
 
-	args[2] = oid_to_hex(stash);
+	args[3] = oid_to_hex(stash);
 
 	/*
 	 * It is OK to ignore error here, for example when there was
-- 
gitgitgadget


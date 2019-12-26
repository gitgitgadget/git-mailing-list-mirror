Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88220C2D0DB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D23206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 17:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9+YsRTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfLZRnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 12:43:42 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38409 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfLZRnl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 12:43:41 -0500
Received: by mail-ed1-f67.google.com with SMTP id i16so23238766edr.5
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 09:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G/KE3Za+IaIPsFjK4t1B7JMKrINOsvrV0OcJcdOdrYQ=;
        b=t9+YsRTYuzxU/6AC3dyEXWX4ggINbHG80V3f+i9+ZDp+FzUbo8JI0vfnVFwlzxHgxv
         SeY8G18a/CY4jkFyrpZv63EbN0K46QkDAmNbjG8BDRQXzST379FPk9QPoXNzkFAu/HX8
         A7c7kbx0LbuiaACTKERlu/AanyBKVrvxBwhGORaRSn1ublS4k36X8aggZX5fvo0egDDy
         p+s3D8EjgnZ1oozySk2X2DQDcH0q2X5R0GZ0NxgPWVECP8bhTVH5sm/o2Py5Ecw333a8
         6pBnTPXOPSrE0lVobua/XnqM2FSvKIccMIC1mbp8J7lj7vrOu8HTBUrzfBFibbHr3exy
         ZquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G/KE3Za+IaIPsFjK4t1B7JMKrINOsvrV0OcJcdOdrYQ=;
        b=LXsGZNhxtKXY7LoiHrWR0g5UK7gmV2O3RSVHHlCnUGnqvZAJozJT9bcFRzasjw8r1w
         KefONiQG1/mm/wXWSvU/oMKxiGP9tod+lsyY1LGyuEHlAqBFmtaslhN0HM2AVnL6W8Im
         ptl2oKSadMRKHTT7e9VkhVkE5WyXVEHZJosSE1d3JU8d9J5Jf8h8MRvvlqywImMt121t
         zJRFXaAPrkrGD5Oi1cGTSryc/JlD5ug6Uo0rsIdRSvkCMoFOinfrT5twBJm9E+heAmip
         N6cNOCo6vI2dCECpUontIjUQCUS1iHbk0hfN889BhIMGn7v9agNnhkqULhO94UnYxSOU
         54LQ==
X-Gm-Message-State: APjAAAVtGsSCLaX/81p+IDQkBcgN8Ei81zCb6rSxz/pfwVMIzv5NyPuv
        etP+1YMioREYITOOtueT2H74YRyG
X-Google-Smtp-Source: APXvYqzzUbBfrSlMw3ylJ6PgczGt6YGKWwU0IAdv9SV6NLQF+gip52gDPprRG9htiL42bOqP/cftkQ==
X-Received: by 2002:a17:906:ae92:: with SMTP id md18mr38370817ejb.33.1577382219611;
        Thu, 26 Dec 2019 09:43:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm3669996ejp.50.2019.12.26.09.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 09:43:39 -0800 (PST)
Message-Id: <c7d489794caa8f76e8d3cc4ec95b76279333dff1.1577382217.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.494.v2.git.1577382217.gitgitgadget@gmail.com>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com>
        <pull.494.v2.git.1577382217.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 17:43:37 +0000
Subject: [PATCH v2 2/2] doc: log, gitk: line-log arguments must exist in
 starting revision
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The line number, regex or offset parameters <start> and <end> in
`git log -L <start>,<end>:<file>`, or the function name regex in
`git log -L :<funcname>:<file>` must exist in the starting
revision, or else the command exits with a fatal error.

This is not obvious in the documentation, so add a note to that
effect.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-log.txt | 3 ++-
 Documentation/gitk.txt    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 6574c0d91f..bed09bb09e 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -76,7 +76,8 @@ produced by `--stat`, etc.
 	(or the function name regex <funcname>) within the <file>.  You may
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
-	give zero or one positive revision arguments.
+	give zero or one positive revision arguments, and
+	<start> and <end> (or <funcname>) must exist in the starting revision.
 	You can specify this option more than once. Implies `--patch`.
 	Patch output can be suppressed using `--no-patch`, but other diff formats
 	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index c487af5b74..c653ebb6a8 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -105,7 +105,8 @@ linkgit:git-rev-list[1] for a complete list.
 	(or the function name regex <funcname>) within the <file>.  You may
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
-	give zero or one positive revision arguments.
+	give zero or one positive revision arguments, and
+	<start> and <end> (or <funcname>) must exist in the starting revision.
 	You can specify this option more than once. Implies `--patch`.
 	Patch output can be suppressed using `--no-patch`, but other diff formats
 	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
-- 
gitgitgadget

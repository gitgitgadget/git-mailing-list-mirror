Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80F9C2D0C5
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF43C2072D
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 05:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it7zCsX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfLQFHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 00:07:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39509 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfLQFHs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 00:07:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id b72so1570138wme.4
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 21:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F9hgaco+yib1FqfnW5m+wq+10pkwFD5ip6ycklVwaSQ=;
        b=it7zCsX6jl/d0eb3IPNsJN4cKaTfbIutX1XFnoryI6qJkKCWwDgq16dzlCocjzhrfG
         meuiEvrCNjh1e+73EU/bO5mu/Anj07EPLY6fJ92wYmhun7iULD1qOPwzW3+eaj1ZwdjM
         PTIpjSjikwb7TuPTxLC33EA1kiAf4Xv7mmTy2o7h1+I92y4ish+Fo3IxuHL7csrMHBUH
         umQXSEyKsIPTFLKyYRqDjgeuNCVJEe327ehWFN3nAzry2Nky4Em5XR9OiG4Nk9inKcLN
         510hTMyH1U4rcpKb5JjB402sPoLJe2+IoeyP0uqHNA0RLvciYf+FEnB5/w50t/7o/PeQ
         8t4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F9hgaco+yib1FqfnW5m+wq+10pkwFD5ip6ycklVwaSQ=;
        b=K/XaQwNi67OTsTInok4UgU/14yV13Cd/6PIsSs8cR7bpYXuF9MP6+nkeemg0jgz6BO
         kcFddsr9C2a8K0GuyO49Aq+mSPtRxaQ+gA5nB2oce8sJ2vnw6H8D3Wrgxb/5AJ+W9s6R
         gF8zV73Hkp296AbDTmUP92C/9pXjr5M0CggovO4H3/A5agzv2YecKZmyRpZC2yIIQ7ci
         qjo6vwGluFQu78D+lQa/DmtpSXBmle9zB++esONzenN5pNQt/uHOd63GrhLkLYZWCzJO
         JLgijLIClatFgdhotLldK7FBFZ1/ZJ/58fKzepWUPK1NRqGA3szVlPRMXkJWC/R9eo+o
         04dg==
X-Gm-Message-State: APjAAAWKnfriWcl+G3V0aUKCRR1aULdORHQl6BK0k5NeLV4UvB4EP8q3
        tm2hWskvSHYcHFJ5CuPkesZxEble
X-Google-Smtp-Source: APXvYqzbkfUewLBAXywBksAz96J9Zw2CbYf0txhneVaYRo6ENurT59tHK5O0pGdEyoX3tEuvVC6GsQ==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr2999986wmd.23.1576559265704;
        Mon, 16 Dec 2019 21:07:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm24042730wrt.37.2019.12.16.21.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 21:07:45 -0800 (PST)
Message-Id: <0ed04a8629a64d15062e13c1f1739b01436a897b.1576559263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.494.git.1576559263.gitgitgadget@gmail.com>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 05:07:42 +0000
Subject: [PATCH 1/2] Documentation/git-log: document accepted line-log diff
 formats
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Thomas Rast <tr@thomasrast.ch>, Junio C Hamano" <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Currently the line-log functionality (git log -L) only supports
displaying patch output (`-p`, its default behavior) and suppressing it
(`-s`). A check was added in the code to that effect in 5314efaea (line-log:
detect unsupported formats, 2019-03-10) but the documentation was not
updated.

Explicitly mention that `-L` implies `-p`, that patch output can be
suppressed using `-s`, and that all other diff formats are not allowed.

Additionnally, mention that the ':<funcname>' form implies `--function-context`.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-log.txt | 6 +++++-
 Documentation/gitk.txt    | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b406bc4c48..1c52bf184d 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -77,7 +77,11 @@ produced by `--stat`, etc.
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
 	give zero or one positive revision arguments.
-	You can specify this option more than once.
+	You can specify this option more than once. Implies `--patch`.
+	If ``:<funcname>'' is given, implies `--function-context`.
+	Patch output can be suppressed using `-s`, but other diff formats
+	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
+	`--name-only`, `--name-status`, `--check`) are not currently implemented.
 +
 include::line-range-format.txt[]
 
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 1eabb0aaf3..91993b9d4c 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -106,7 +106,11 @@ linkgit:git-rev-list[1] for a complete list.
 	not give any pathspec limiters.  This is currently limited to
 	a walk starting from a single revision, i.e., you may only
 	give zero or one positive revision arguments.
-	You can specify this option more than once.
+	You can specify this option more than once. Implies `--patch`.
+	If ``:<funcname>'' is given, implies `--function-context`.
+	Patch output can be suppressed using `-s`, but other diff formats
+	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
+	`--name-only`, `--name-status`, `--check`) are not currently implemented.
 +
 *Note:* gitk (unlike linkgit:git-log[1]) currently only understands
 this option if you specify it "glued together" with its argument.  Do
-- 
gitgitgadget


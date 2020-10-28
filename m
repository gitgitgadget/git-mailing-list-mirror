Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F5BC4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9CF2076A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr9TXXpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgJ1Vda (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:33:30 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:36578 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgJ1VdL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:11 -0400
Received: by mail-wm1-f41.google.com with SMTP id e2so651334wme.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=p88YtccjQTKr5b0SZ3vpbltcnM/DGEuc3pmsjwT30wE=;
        b=Mr9TXXpNJOuHv7kT0scr7l3Llak7KVOOk3N9KCepPlsPEn0jnW506oz3O4n9en5NzX
         jdWZSKaO0x3pEDO3VwJn0Iyjq/4NTKRa9RcojfgDBaOpOZ9TTBUGF0a0LtmhJkkiofe0
         kn+e9WVsM6EkK+mrrVnKLgfGV7KfGUe+f724p/V8l5+7qqu8uzgQtNYsyq1gGO2GU8ZB
         94S5fE9uwHOkCewzinZvaX+cl0oqkO7AqaWCcrxNccvWbdtgTbi2vGUIS2ZpMZwcjWqH
         v0++1FCTFPi4pnHcG8EyxIh5d0nPbRYxtjlcRkgCKOnAO9ZVs9LI3m9ouwxdpXTpsted
         4q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=p88YtccjQTKr5b0SZ3vpbltcnM/DGEuc3pmsjwT30wE=;
        b=Hao/PfuA0++D9v6pHTwFlBK+gpQP8pG5ghg5XSSmh0bdHBLYfkoqRGk3MTl8NYEfA8
         o/FpaiChjSamVtHqlA6taWkd23HuYGgDVTf/eD/WC0t6pLKj32nRPY9QcaWf7bCr8wcp
         90v75FE/6s4jQR6Dag5u8vGwUhHz0Uk4BFaAJJn0q810sAQGrReyRfv4NOO6wojWczLc
         6haDsepVzmGzoynAoR9R0r5MoEuv1JiMBpDP7xqKTWn6Bv0m5RsZMtdjAu1q/0e22ZvL
         eGcNodCKkjCYTtQCATFhhlN7Ai0yn9w5YgaFz6nyD9rNLfGcbqRM1aJoqS/4NYlP2PFL
         ai/g==
X-Gm-Message-State: AOAM533hV5Ha0anOjSmVVe2ghmnHqiJNhyx+NVJbsO82DiA5nQ8dnMBB
        C5L+uJaTB2ntmY2vv2wvix6chUW4YT0=
X-Google-Smtp-Source: ABdhPJzhrVSqhPKDP9SfsYWisilcE1FTDWGLAazl6kPBS+9vsUDVv2/wgIfMjksFp/xXJt8R8Eg5nQ==
X-Received: by 2002:a05:600c:4114:: with SMTP id j20mr4871921wmi.62.1603889273066;
        Wed, 28 Oct 2020 05:47:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm6831430wrs.92.2020.10.28.05.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:47:52 -0700 (PDT)
Message-Id: <96f6f95abcbd79d432073cb294ba12b71300580f.1603889270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.git.1603889270.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Oct 2020 12:47:45 +0000
Subject: [PATCH 1/6] doc: log, gitk: move '-L' description to
 'line-range-options.txt'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The description of the '-L' option for `git log` and `gitk` is the
same, but is repeated in both 'git-log.txt' and 'gitk.txt'.

Remove the duplication by creating a new file, 'line-range-options.txt',
and include it in both files.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-log.txt            | 16 ++--------------
 Documentation/gitk.txt               | 21 ++-------------------
 Documentation/line-range-options.txt | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/line-range-options.txt

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 2b8ac5ff88..631dfff77c 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -77,20 +77,8 @@ produced by `--stat`, etc.
 	Intended to speed up tools that read log messages from `git log`
 	output by allowing them to allocate space in advance.
 
--L <start>,<end>:<file>::
--L :<funcname>:<file>::
-	Trace the evolution of the line range given by "<start>,<end>"
-	(or the function name regex <funcname>) within the <file>.  You may
-	not give any pathspec limiters.  This is currently limited to
-	a walk starting from a single revision, i.e., you may only
-	give zero or one positive revision arguments, and
-	<start> and <end> (or <funcname>) must exist in the starting revision.
-	You can specify this option more than once. Implies `--patch`.
-	Patch output can be suppressed using `--no-patch`, but other diff formats
-	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
-	`--name-only`, `--name-status`, `--check`) are not currently implemented.
-+
-include::line-range-format.txt[]
+:git-log: 1
+include::line-range-options.txt[]
 
 <revision range>::
 	Show only commits in the specified revision range.  When no
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index c653ebb6a8..761b764c18 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -98,25 +98,8 @@ linkgit:git-rev-list[1] for a complete list.
 	(See "History simplification" in linkgit:git-log[1] for a more
 	detailed explanation.)
 
--L<start>,<end>:<file>::
--L:<funcname>:<file>::
-
-	Trace the evolution of the line range given by "<start>,<end>"
-	(or the function name regex <funcname>) within the <file>.  You may
-	not give any pathspec limiters.  This is currently limited to
-	a walk starting from a single revision, i.e., you may only
-	give zero or one positive revision arguments, and
-	<start> and <end> (or <funcname>) must exist in the starting revision.
-	You can specify this option more than once. Implies `--patch`.
-	Patch output can be suppressed using `--no-patch`, but other diff formats
-	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
-	`--name-only`, `--name-status`, `--check`) are not currently implemented.
-+
-*Note:* gitk (unlike linkgit:git-log[1]) currently only understands
-this option if you specify it "glued together" with its argument.  Do
-*not* put a space after `-L`.
-+
-include::line-range-format.txt[]
+:gitk: 1
+include::line-range-options.txt[]
 
 <revision range>::
 
diff --git a/Documentation/line-range-options.txt b/Documentation/line-range-options.txt
new file mode 100644
index 0000000000..9e3d98d44f
--- /dev/null
+++ b/Documentation/line-range-options.txt
@@ -0,0 +1,27 @@
+ifdef::git-log[]
+-L <start>,<end>:<file>::
+-L :<funcname>:<file>::
+endif::git-log[]
+ifdef::gitk[]
+-L<start>,<end>:<file>::
+-L:<funcname>:<file>::
+endif::gitk[]
+
+	Trace the evolution of the line range given by "<start>,<end>"
+	(or the function name regex <funcname>) within the <file>.  You may
+	not give any pathspec limiters.  This is currently limited to
+	a walk starting from a single revision, i.e., you may only
+	give zero or one positive revision arguments, and
+	<start> and <end> (or <funcname>) must exist in the starting revision.
+	You can specify this option more than once. Implies `--patch`.
+	Patch output can be suppressed using `--no-patch`, but other diff formats
+	(namely `--raw`, `--numstat`, `--shortstat`, `--dirstat`, `--summary`,
+	`--name-only`, `--name-status`, `--check`) are not currently implemented.
++
+ifdef::gitk[]
+*Note:* gitk (unlike linkgit:git-log[1]) currently only understands
+this option if you specify it "glued together" with its argument.  Do
+*not* put a space after `-L`.
+endif::gitk[]
++
+include::line-range-format.txt[]
-- 
gitgitgadget


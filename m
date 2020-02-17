Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708F7C34021
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FCE208C4
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 17:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diEVOK7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgBQRZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:25:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35057 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgBQRZa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 12:25:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so140832wmb.0
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 09:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZCj6PyPqxyqohXcbE3lkS8gbTFoahatVVh0/cL9Wszk=;
        b=diEVOK7PJyItyYwY3mitU2u+ItECV/4WlVewLbrWdo9tBXKjljsc6bIzmK3qBIASnf
         T5qckHPhnSdl7RTPV+gKAOqOeJH1Y7Rv5O4zhFgFAG2Rq1TkxrKH7Wb7FRv3cIuSFJkK
         cf8mfST8RlVpgD0I3NHjyPuKGOl6WFsRpLVcJorBhtH2oO8pSOGBbgFvQnWbCv4khmJJ
         QG1jpCrgoDzMgixGvLU4DNumYy6i2IwkYb3ZiYGhYUOlA+Yj5XklToJaQbyxhMi8Nn4D
         6gPnPAz0JbsT/WjmWgHTwfJcq5mwloGiLaj8PQEytfisoSBqj9HYmFeJTWwG3YNBs5k8
         SaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZCj6PyPqxyqohXcbE3lkS8gbTFoahatVVh0/cL9Wszk=;
        b=NDGA9rZeHEIcK//zK4ArzQqlqmmU7MZ5Jypr1uneRSEBgNmhES3829NErL+72yaXHH
         gFZiizHqGfP94q41NyrSGEwWXq/kbmffmqEr9clAmUDl/IX+M/NeMRgbwIkmI7yKrpqE
         KGPloXBhrqwtaPzCnzD0KIcIAQgNl4FhS/ipE27XxjLlFsWyfppK756xerDNeqIr+kCg
         rLwFb10r0rXQ9BAGk2i/wgzEAE/K50vbqr6Ah0VS/+OddLfiR+l6yuWr3BXXrgTrjaOa
         1ILUpPPDkg46jLh++KTJ7GkAvHKgqk58IfncybCZS2tJG33wGoammWytt3UdczElfCAq
         vmIg==
X-Gm-Message-State: APjAAAXhUbmFuIcqk3ncvtpNNFFtPJHFAUpWVsTnbWsHECq2/lclc1WL
        LeurRa0lye9YDGPBFQXulkcJzsC0
X-Google-Smtp-Source: APXvYqwidrR6kdfNMbp8Ta5WsoYfPmzMHu8/tJgZfUQdOLCtAX7auQWfm7DJnAPjw7zDUDsIAp+l+A==
X-Received: by 2002:a1c:dc08:: with SMTP id t8mr55312wmg.139.1581960328110;
        Mon, 17 Feb 2020 09:25:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t131sm165766wmb.13.2020.02.17.09.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:25:27 -0800 (PST)
Message-Id: <7353b06e30e6c3d14df0f598489fa55e8c991f26.1581960322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
References: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
        <pull.530.v3.git.1581960322.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Feb 2020 17:25:20 +0000
Subject: [PATCH v3 6/8] doc: stash: synchronize <pathspec> description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This patch continues the effort that is already applied to
`git commit`, `git reset`, `git checkout` etc.

1) Added reference to 'linkgit:gitglossary[7]'.
2) Fixed mentions of incorrectly plural "pathspecs".

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-stash.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 6dc0a5b0eef..52e64985bda 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -56,13 +56,13 @@ push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
 For quickly making a snapshot, you can omit "push".  In this mode,
 non-option arguments are not allowed to prevent a misspelled
 subcommand from making an unwanted stash entry.  The two exceptions to this
-are `stash -p` which acts as alias for `stash push -p` and pathspecs,
+are `stash -p` which acts as alias for `stash push -p` and pathspec elements,
 which are allowed after a double hyphen `--` for disambiguation.
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
 	This option is deprecated in favour of 'git stash push'.  It
-	differs from "stash push" in that it cannot take pathspecs.
+	differs from "stash push" in that it cannot take pathspec.
 	Instead, all non-option arguments are concatenated to form the stash
 	message.
 
@@ -213,6 +213,8 @@ The new stash entry records the modified states only for the files
 that match the pathspec.  The index entries and working tree files
 are then rolled back to the state in HEAD only for these files,
 too, leaving files that do not match the pathspec intact.
++
+For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 <stash>::
 	This option is only valid for `apply`, `branch`, `drop`, `pop`,
-- 
gitgitgadget


Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BC5C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A3620684
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHd9hnTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfLCOCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40519 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfLCOCb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so3577950wmi.5
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=37S1UXMADHTUnnmVEO9FnwfxmeS1XCFMqK/czkp+DU0=;
        b=iHd9hnTfUuBN0bO3DtW7Pe1BFETMpYJobFTfWMxV5SQxMrlRfMywWL+cv5hXRC2XZC
         YVqsRRxu5U9xFdPqL5+wCquNn7jSXW64wkhlYZVCJ7pPHg2XLCMrvI62k/WB6AOM2/gc
         ppEZvkL7qlHa/SshFZAIcrlR/ou7/myBu+ZPa9S7S/iOtkX30sTvBnid1kzxEe1DjClT
         Zu2BwWBCbpXI0/xCtJmARGFWudbgERb+OVxnlsr3x9GpqdP1mHJGlpRYohSne9iQ+oQW
         cyqT50LLTq8RfjOmn5+gvOE3Or5SpRd+n5cCJQxawv4lLrRrOjozEqQNrE0DI/fof8wW
         ZItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=37S1UXMADHTUnnmVEO9FnwfxmeS1XCFMqK/czkp+DU0=;
        b=UKpjohfMHFMPJ0V4rJQAwAsXjL/BBdFLU6ybCgWB7Noh+ACSgqSdACHiDT3xtpLb2N
         VL849AAb0ozKy+oeoGV7GI1YJ4ua6hmlECenlfGf64xThc4GYXxpXqWrg/I87b1JelWq
         GGif6hcqvq4s82DRyV54H1LYAj63hbhYnCeOpHAtYH1YlK48uxwbsukhF+Ey2eCg2WaY
         67/5hq7USCL0dDYrlOODZ9cUEXmwNM+HMLB505qAQPdV7qJEtRvwNTQd9MpzqAT+cuDJ
         87t1/CPf9IFU7zekz6JuFNmm4t40UQrF8sUH8Vlh+xynUD7AyTiEOMJUvcybC1HRVdjB
         JU0g==
X-Gm-Message-State: APjAAAU03T3tx94pl7vcDDzQ0lAbhkHyhy1r/39jKeIhE3k0XKunXMgx
        0Z1ZMQHL7UAysEM02wRUHeus1IJR
X-Google-Smtp-Source: APXvYqxc0farsbNIaNWQNJF6OMomEulCS2yONoiT9OcdnfBCFUbfU/ZX3BJc3WdiLPam7VXc4Pm10w==
X-Received: by 2002:a1c:7e91:: with SMTP id z139mr34402466wmc.15.1575381749087;
        Tue, 03 Dec 2019 06:02:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17sm3104773wme.45.2019.12.03.06.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:28 -0800 (PST)
Message-Id: <fd166755aa137b03f738601826c42ac64ae89771.1575381738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:16 +0000
Subject: [PATCH v4 11/13] doc: checkout: synchronize <pathspec> description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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
 Documentation/git-checkout.txt | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index d47046e050..93124f3ad9 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -12,13 +12,13 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] --detach [<branch>]
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
-'git checkout' (-p|--patch) [<tree-ish>] [--] [<paths>...]
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
+'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
 Updates files in the working tree to match the version in the index
-or the specified tree.  If no paths are given, 'git checkout' will
+or the specified tree.  If no pathspec was given, 'git checkout' will
 also update `HEAD` to set the specified branch as the current
 branch.
 
@@ -78,13 +78,13 @@ be used to detach `HEAD` at the tip of the branch (`git checkout
 +
 Omitting `<branch>` detaches `HEAD` at the tip of the current branch.
 
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...::
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...::
 
-	Overwrite paths in the working tree by replacing with the
-	contents in the index or in the `<tree-ish>` (most often a
-	commit).  When a `<tree-ish>` is given, the paths that
-	match the `<pathspec>` are updated both in the index and in
-	the working tree.
+	Overwrite the contents of the files that match the pathspec.
+	When the `<tree-ish>` (most often a commit) is not given, 
+	overwrite working tree with the contents in the index.
+	When the `<tree-ish>` is given, overwrite both the index and
+	the working tree with the contents at the `<tree-ish>`.
 +
 The index may contain unmerged entries because of a previous failed merge.
 By default, if you try to check out such an entry from the index, the
@@ -336,7 +336,13 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 	Tree to checkout from (when paths are given). If not specified,
 	the index will be used.
 
+\--::
+	Do not interpret any more arguments as options.
 
+<pathspec>...::
+	Limits the paths affected by the operation.
++
+For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 DETACHED HEAD
 -------------
-- 
gitgitgadget


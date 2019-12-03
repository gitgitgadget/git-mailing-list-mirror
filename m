Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B28CC432C3
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F5320684
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 14:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQpHYdFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfLCOC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:02:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55688 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfLCOC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 09:02:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so1985887wmj.5
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 06:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jFwdsXIw10GWaJMKJTmYGPbaQki7xSpz/S6SI98raT0=;
        b=oQpHYdFL5NH02eugSJRB/fz5U3roaogSWrke0BmiJWH8L4RALMX4pzgD6m81RlWM94
         dlcmd3UMjpqBsJ7kSY5IHQ1QRrkriXQhw0g5Uom0SPZNQ7TQXLj1nsa4R1eR5O6UPzpj
         xVzxaKkSoynOW4gDiFKk6kBfVdVFcn+cdffoGcOxcw6VXrXO6LuWA5m0OmTgP3GkPRUp
         k5+dKHqJ6nVbiG1wsyfFl9cc0J0AwJQ1hvkwGQdEGqoUjIh/LsX9BQ/eNLk2jIrjd66N
         J7I9ece+lodEtjteoE6IDoXI0vGg0ZxRiq4+KwGYE/2+CFVoZzycPf0wcBCCWbrYnpgh
         /1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jFwdsXIw10GWaJMKJTmYGPbaQki7xSpz/S6SI98raT0=;
        b=MbFD4Yzog601oFIleHZRorm2zgXWDyW/ZkvLovShyy5hZwYanloapr/TVSy3DB2sYS
         bWjh2bEt+TECROYqcua/PhG/ff9gu3Runa0Sr/RUOXgl9j4edck6/zOBiQu055fe57Dl
         28iT29gI1l42+0imA87oRs2sHm53M8YiFOIODXjiZ5dT632u8XIdyanYcqpbcxOwlZQV
         c8W2wPVyn5zbP46CRTUJOA/gK+meaypjYxAiEog0PguDncx4+taj0YI+p+LHDH/yxQBc
         XhaDvqoQqBfPBEpMCREPiNObtfZhMcAE/oU5g+R8rmnrr7vZsT/LMLHo5tiCkNjoxggw
         UoyA==
X-Gm-Message-State: APjAAAW9bLX4KtstEIbkg0nM79QB43ezTcmDAMi/Co3YJm9yRPDMdSEq
        dpfyPTmZNHvuR/9vS6BXVJJDveaD
X-Google-Smtp-Source: APXvYqxm/RoY4nwtjR2Mdr5ii+R0YXgYvugrffW/+IrjmMRxeL1JUd3XayIiFf8IPIWD2vg1sltJzA==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr8845360wmc.174.1575381744506;
        Tue, 03 Dec 2019 06:02:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l3sm3748296wrt.29.2019.12.03.06.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2019 06:02:24 -0800 (PST)
Message-Id: <0e1ac7e8a70ae0d508b71bf91a0e0b8f666cbe34.1575381738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
References: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
        <pull.445.v4.git.1575381738.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Dec 2019 14:02:10 +0000
Subject: [PATCH v4 05/13] doc: commit: synchronize <pathspec> description
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
This also better disambiguates <file>... header.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-commit.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index afa7b75a23..a0c44978ee 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
-	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
+	   [-i | -o] [-S[<keyid>]] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -345,12 +345,13 @@ changes to tracked files.
 \--::
 	Do not interpret any more arguments as options.
 
-<file>...::
-	When files are given on the command line, the command
-	commits the contents of the named files, without
-	recording the changes already staged.  The contents of
-	these files are also staged for the next commit on top
-	of what have been staged before.
+<pathspec>...::
+	When pathspec is given on the command line, commit the contents of
+	the files that match the pathspec without recording the changes
+	already added to the index. The contents of these files are also
+	staged for the next commit on top of what have been staged before.
++
+For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 :git-commit: 1
 include::date-formats.txt[]
-- 
gitgitgadget


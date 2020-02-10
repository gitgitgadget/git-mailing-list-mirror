Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF8DC352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D0D20873
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e16RvYrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgBJOqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:46:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53512 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgBJOp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:45:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id s10so596995wmh.3
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 06:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/kFR0CkkIM/KJFwokDzLVFAMP+q6ohyhg+0YZEhQkJM=;
        b=e16RvYrcY49XMyqLsp7pfzVY+HjgpQPmtiDKqpGzUXlwDW/O51UGF+D6MjN60/XMj6
         GD7BXEamRKTmuD4e6dXju0gR2Nderqoo5z5Qc/HzOur1VCnrHRxOUy8ye1P1b2SXbOPP
         VAbY14VxF7hN0S325eB658UkjJzhWiqPszQD01Nt2aKClmhZkILTgVLiocrRHXzYKrk1
         hx32jf9TIcohYAdlCOFv5mPd5kOd/NTeu4DuMsJq8FmD5j8Kv3Kx9hbXjmx/Uwv3wcn8
         hmTdkvT3VLOWYzpkiXMCeOVz73y35195uuK3LS+BdxzP7euK3KIg4QcKlMc3F3svuL1W
         aCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/kFR0CkkIM/KJFwokDzLVFAMP+q6ohyhg+0YZEhQkJM=;
        b=S7FbdajQsvqCksoJTRqAouR0UQx29cnDfhKO14CLDCQmSNde4fKV2mqOxb6ZgE9ogN
         zmAF/DlOO2FNnVuOy+4tH+3+ml2OqiUl3iNNDJkrKjN2UnATqGS6vNblwzy9LZ5CxgBC
         X7Fq9d3QqF2U2Nxd4Ag8MysLsCs95EXgAqZ2XAEv46ZHoRcmB7aZm9zNnzXrMMaAgvpI
         ZmSTTcCZ/hlG6SCPY1XmCQ/JPP9EHdbg62UQlD6W1t1D/miBPnXiEoyxjssEHOmuS653
         NnLFHw5i6ppls16Fl9cMrk4Lq+7aUDgIVeFXu3AgDDFW95RvHH4EaNwhPcb/siARWoCz
         MLFA==
X-Gm-Message-State: APjAAAXZTDmZ4wfih8xw26gtkDWiYLKr8dwbmMN4k3xqijTRVMWQMmqS
        ojZ5X6Jbn+eS/FdDKwFWr036GLYx
X-Google-Smtp-Source: APXvYqyHcclJa8HmX+jqIFp4WCb7JRjFdPH0AhP6dcnpFYeacnd49y0djFvHFwL1PiBSjn75RwF2PQ==
X-Received: by 2002:a05:600c:2406:: with SMTP id 6mr15855163wmp.30.1581345954327;
        Mon, 10 Feb 2020 06:45:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm794365wra.83.2020.02.10.06.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:45:53 -0800 (PST)
Message-Id: <04e2fd5865fa9bc36027e318977f0b217d4154ef.1581345948.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <pull.530.v2.git.1581345948.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 14:45:45 +0000
Subject: [PATCH v2 6/8] doc: stash: synchronize <pathspec> description
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
index 6dc0a5b0ee..52e64985bd 100644
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


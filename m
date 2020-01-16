Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5BFC33CB6
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035D120728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk4WAG4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgAPQJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:09:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41582 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgAPQJf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 11:09:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so19727995wrw.8
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 08:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hp7X8A21RPBggR87QrLxVtnn4L5GlpLQtz3kUeB9qho=;
        b=Fk4WAG4CLWVAQ/XgkldmaxiceFwMmFWYT7jZaQ7BPSV1rRALS6PTMcet5rPd8c4RvS
         0tbN1Vs02/OcNhruxL53g3lMPd0w11WXboN+LLvD5EYl1qUVQeWyio89673WrJTr2zRe
         3v6NK9yUE0P0ITwPJWCORWgUNnqlsR5Qqzu19IdYIDxD6c+HcFBz3d+E0f1Xe0QjgsRw
         2de+Q6zD3H1JHvqGqYY1R6oIbH28fZWdgOWWGya+xRxrgkPcpBe3pAo9b0wNAcuPOO5n
         qFbY2V2bRPrAahgT85cuBNQGjhngeYfMIVSfpzCum0h7FgTUdMxYV78Lc+iVvCtsdnak
         S6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hp7X8A21RPBggR87QrLxVtnn4L5GlpLQtz3kUeB9qho=;
        b=esvSPJSvcgaiA/QPpYgtkxPZS6fKJ+b1fL/QiPUAwkkH+EJX3ECit/yM/+jVbG/V4u
         K6HH46Uix2MfDIol/t/hFvhRXMSDfYEeDb14kzWGVRa2MCxCcX875UrOX+JJtDpxe0an
         hcFYIcWlryAFU9z1lkms7nFJpHU2Zh6lBcUfJJLG63vfB4t3wMMK7sWAdVQkUV9/PRCm
         QWwpzARdogNnG7wzpVOIkuE4aX1qe7bP8Dci13FVdZjRxC74Nvk2eRfvqsrFXNObzJ1U
         G8PmQtWDdorspL7yqU1+siwKqzmNAgrE3dwt8oMrVkCVYFGkGYqDRUW+xEXYQ3TNYQCL
         yfsg==
X-Gm-Message-State: APjAAAVeh6Hq8F3PWf/bvLRjfD5WMVxwpSXKHajc6Qw6pqfT5fL1A5Tb
        Vmg3/A+VgEeHadtBmS9Mchl39KMx
X-Google-Smtp-Source: APXvYqzJFZKfOKAFlh2ekocSk5f+y9reYPl9/JbiP/16zKbxBMQSlnQOz13LRmQf92bdcwFTHvDtUw==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr4008559wra.36.1579190973497;
        Thu, 16 Jan 2020 08:09:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x7sm28987934wrq.41.2020.01.16.08.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:09:33 -0800 (PST)
Message-Id: <5e17a0c470ec576d9dc4c24acecbad5ac2ddd9ed.1579190965.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.530.git.1579190965.gitgitgadget@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 16:09:23 +0000
Subject: [PATCH 6/8] doc: stash: synchronize <pathspec> description
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
index f5fa62dc7c..576ad757d9 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -53,13 +53,13 @@ push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
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
 
@@ -197,6 +197,8 @@ The `--patch` option implies `--keep-index`.  You can use
 	that match the pathspec.  The index entries and working tree files
 	are then rolled back to the state in HEAD only for these files,
 	too, leaving files that do not match the pathspec intact.
++
+For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 <stash>::
 	A reference of the form `stash@{<revision>}`. When no `<stash>` is
-- 
gitgitgadget


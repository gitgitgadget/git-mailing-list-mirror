Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B19C46467
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 19:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjAGTjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 14:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjAGTj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 14:39:26 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A2340C23
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 11:39:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bk16so4223562wrb.11
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 11:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAVusEa+WYJlT2QZl2wcB4dBsaoK1D6Qy5w34U/QM8s=;
        b=cMCZoZO8+hOcr8WOhAkSuBmtyFcKQofGDP3Ul4xGF4BUOQI1USZR5iWbWpljqOkI+J
         knWMb/7P/jB9zynWA4mTDMWeYXPXOG70e+6kct3bM3OmR8CFlexcBU2UBJs0RGajGTGh
         D5lGdlHwtn80bm80QDLPJRCfmlCgRVZTR3ahYri0q501ezuvFJKSwltw5B5rZQlO/HeI
         BMblKJq2B8EdhL0sagCOOXp84XVKmRs2BwZRxTezMB3ssUjFdzGgCTSKcMtno2Uo0Ms8
         F/jpFWXy5f87S4+DnVvcKxfSCi7V7YzRK0y6gwtlwdVJPAEHfYr5o/LAdOqlnyPwoUwr
         MWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAVusEa+WYJlT2QZl2wcB4dBsaoK1D6Qy5w34U/QM8s=;
        b=Y1eZ4CUji4oDIm2c0udH1g9IMn2cp+0Sa/kzBKyMinvkVzJCFKjSqj9YrilBOQKLQr
         7KPPvTUKn92mzh1HWI160yKtegdRpLtmyd6+9qU5FZ/P5uYEQrR6lhA+CZyKG4Pv2lcB
         M4/zC8oup/FWT+ENu/AOpuGH7oX6apHc+vkg8En8FYQdLeochot2iPWtirUJDgBrZEd1
         GvmnHucFCgTdouIoBWDBxwevDKWCmaZCXEfBpTBLN/5HbyyZd5Zbq+zeMzp7tVBnH9HK
         VGDWlypFGixy62NjSdWOwuvwrXydW7hKIjsxNS0Mt3kJB8gZB8LSvu2Z1AXQA6yCUUI9
         /Gxg==
X-Gm-Message-State: AFqh2kqrfe/OkeXPAiGCA5H1fX+qdJPnzg4NGk8wHwpL75ZbwGxY8zk4
        IJbqQDhuTkTzitxaEKxd9nlaT+LJDXU=
X-Google-Smtp-Source: AMrXdXtCu/nOKeufdoXrx9l3ZnP/H7qCY6cGh7GNQOB9w+SY8lbY5A1ILVESPkWGiduIiqPJXxqe4A==
X-Received: by 2002:adf:f290:0:b0:242:144:90c4 with SMTP id k16-20020adff290000000b00242014490c4mr37856868wro.28.1673120363970;
        Sat, 07 Jan 2023 11:39:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020adff406000000b00298d87b6309sm4515749wro.78.2023.01.07.11.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:39:23 -0800 (PST)
Message-Id: <9ef427a9a2adfb6a47d13103f00a64df96725560.1673120359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Jan 2023 19:39:19 +0000
Subject: [PATCH 5/5] git-rebase.txt: add a note about 'ORIG_HEAD' being
 overwritten
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

'ORIG_HEAD' is written at the start of the rebase, but is not guaranteed
to still point to the original branch tip at the end of the rebase.

Indeed, using other commands that write 'ORIG_HEAD' during the rebase,
like splitting a commit using 'git reset HEAD^', will lead to 'ORIG_HEAD'
being overwritten.

Add a note about that in the 'Description' section, and mention the more
robust alternative of using the branch's reflog.

Reported-by: Erik Cervin Edin <erik@cervined.in>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-rebase.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f9675bd24e6..d811c1cf443 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -38,6 +38,13 @@ The current branch is reset to `<upstream>` or `<newbase>` if the
 `git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
 to point at the tip of the branch before the reset.
 
+[NOTE]
+`ORIG_HEAD` is not guaranteed to still point to the previous branch tip
+at the end of the rebase if other commands that write that pseudo-ref
+(e.g. `git reset`) are used during the rebase. The previous branch tip,
+however, is accessible using the reflog of the current branch
+(i.e. `@{1}`, see linkgit:gitrevisions[7]).
+
 The commits that were previously saved into the temporary area are
 then reapplied to the current branch, one by one, in order. Note that
 any commits in `HEAD` which introduce the same textual changes as a commit
-- 
gitgitgadget

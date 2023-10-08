Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54166E95A8E
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbjJHGqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344470AbjJHGqP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:46:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864AB10E
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405505b07dfso26776845e9.0
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747545; x=1697352345; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isLUqwjjybfvuaNs5jR/Xb9GjHUI2ekdiMC/WC5lrh0=;
        b=eOc7ADWVzGxD7XW/0IwNnWJV0LfQxMHBKZjjhL04YFDoA0kxli5h+cKqcjgcQsePvu
         ABBpBl380Yj09h3bjCHQTf83QnDIxnKwRMmXSp+CMtwGoHO5BacaluE5xiivVTbSsV0r
         A6HzGhgf7RNKihB3JMNbP8z0rMX/FqE0G5e0tgUssJmfZNP4saxctwYwIcXEoytIKpz8
         2AlpL3XdEAYq+Vjvd7kkCiJr4BCtSldBDG0a/ipnYMDtGyoxGZuCedRUuvgfRSnrOQhA
         EpZvQSguVbonSD0uFb1hAtSrsbnfqAGVkJMQMovdPbcaYlnwiLXCsk36cyaXK0r2MOEf
         Zeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747545; x=1697352345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isLUqwjjybfvuaNs5jR/Xb9GjHUI2ekdiMC/WC5lrh0=;
        b=cTBS+/6WGt7BUQLJkcMePN5kBc98U47SpZ45f6Oqtnc1/3VwPrwFgDcO7rZlYB3sPE
         j0T2syoxr9IM+79gyoQ4wSDago0VtJggSDMbdrDv/mmTJ1usEsGjYoBLJAzL0QbZbdyA
         aP4s8F4d4BtBLL7jx4475nyq7ldBF7CW6w6RVZ57ywejIwOQ4LQHqqhIMgoBh7Oy/WmV
         M/FIQC+AmRhmp8Fl9ADNA4vhF8RHmiIs9lkaNSK2Ou1EIda/L5MUPneErS6OAW8txHk8
         JA/Ljfe+a4qT59DBbJj3PP35WT+8nNvsOe4VlTSbeDXxqFre0+MYFl6VVfpAS0L9oLLz
         b6IQ==
X-Gm-Message-State: AOJu0Yzq+pvMeR4X3okd6XORiSgyU069WTXxlGOW9uvDUlbLkK4sFc/E
        5fDhvMhfKAmIYyZtP9ppAukCPeFJmfY=
X-Google-Smtp-Source: AGHT+IH+Fb9HeTxr56CYWEQSu+mhCX8uCXoJznhA9JGcNnRH3IYxTmO8XmOEYRORbDpuqzn6ImxfDw==
X-Received: by 2002:a05:6000:1c6:b0:320:67:1887 with SMTP id t6-20020a05600001c600b0032000671887mr7354819wrx.28.1696747545591;
        Sat, 07 Oct 2023 23:45:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13-20020a5d68cd000000b0031ae8d86af4sm5998362wrw.103.2023.10.07.23.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:45 -0700 (PDT)
Message-ID: <9a1cf78194e7db1081e103f8d70c37c2d3c9cf85.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:25 +0000
Subject: [PATCH 23/25] documentation: add missing fullstops
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-check-ref-format.txt | 2 +-
 Documentation/git-diff-tree.txt        | 2 +-
 Documentation/git-help.txt             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index 1d6e08e0119..2aacfd18088 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -48,7 +48,7 @@ Git imposes the following rules on how references are named:
 
 . They cannot begin or end with a slash `/` or contain multiple
   consecutive slashes (see the `--normalize` option below for an
-  exception to this rule)
+  exception to this rule).
 
 . They cannot end with a dot `.`.
 
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 22380d5c829..143318c411a 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -34,7 +34,7 @@ include::diff-options.txt[]
 	matching one of the provided pathspecs.
 
 -r::
-	Recurse into sub-trees
+	Recurse into sub-trees.
 
 -t::
 	Show tree entry itself as well as subtrees.  Implies -r.
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 7532625a138..f0bedc1f964 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -42,7 +42,7 @@ former is internally converted into the latter.
 
 To display the linkgit:git[1] man page, use `git help git`.
 
-This page can be displayed with 'git help help' or `git help --help`
+This page can be displayed with 'git help help' or `git help --help`.
 
 OPTIONS
 -------
-- 
gitgitgadget


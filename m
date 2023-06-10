Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17165C7EE43
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjFJUWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjFJUVn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FF53A80
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso21146725e9.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428496; x=1689020496;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vt8z2AJxzEwQlYNmo0GCQyhARur9AC9HnVyQAJFP+Ho=;
        b=Bu48TST1oPrjJPdfotXsCRzaMeVi4qVAQNhyjRyOc+RxOjsGD1urSDxHzEy683vd/J
         nvUVm+9S9HoYoVgngPVxoyBiOPPSZPrJXjjSNH/ihubFaH/vNe6tyXQV2sZzS6sp13HI
         wJyx0muqFqd0x+J6sDEzK0BYj3vlU/6fd2U7ptFvvo4VKduf2aHV1a4YIvfYWG8ECyil
         qhDq7uo2YzBPzhL1tNqtYev79s07ayhi/eWHuyC7+2zPSX9p8w3e2IAEBr8FkA9YOd/v
         VwQlSOby1SIC+tJDEXH7wTn1bbZyfrpFcE0jb/IsrLovSy7d/K/WF2R29wehlTDP0AuP
         ONgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428496; x=1689020496;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vt8z2AJxzEwQlYNmo0GCQyhARur9AC9HnVyQAJFP+Ho=;
        b=cMjC1QANTD7n0rAcM9GeR0O7qCcegkMI36+q6zJYFDyclz8zpJ+8gPZzxsAvYMyP2J
         oGrz4i4iquFsA6O9qHaR7pkLu6LD4HLRooV/fwPQ4nYF/2izSa7qhWzo9BNlWLg9tFAw
         EnRfzX3F0BNom0pj12SZ5jq7pb9MzcMci/7Fv/SaZTkltqIoe6fQz1NSkUrX7uCA51kN
         VBlHkgVZ2bA7rgyBBwVsoPsfQBQ8RSb6hOAVztXcQMeHPFXO2xWiu23lrl3Z+WbJtduf
         4HgrWJjZ2XWaDyo/H7gsghf+SD1Ah/79TOr/JaQg704LuMkNA5wQ+roDTLRFh3UZY2Sn
         LY4g==
X-Gm-Message-State: AC+VfDxxEqOASsm314XXBkOTbVTlA3WQx2gqN3U26dP1dqHPOGqf0lwk
        o1CiradDM6+zpXn2KvZ6yzIpJTydNdQ=
X-Google-Smtp-Source: ACHHUZ4R8H5BBoGG6Owm0y3Qp6dspG/VqFjIgGUJxh7jfxXMYCriFYjdl8DUkXi0WWJBd0lsTR3n0A==
X-Received: by 2002:a05:600c:2189:b0:3f7:81e9:2f02 with SMTP id e9-20020a05600c218900b003f781e92f02mr3180963wme.4.1686428496432;
        Sat, 10 Jun 2023 13:21:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y23-20020a1c4b17000000b003f736735424sm6491515wma.43.2023.06.10.13.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:36 -0700 (PDT)
Message-Id: <d3242e1f949815e6c2c036146da2f5faff92d94f.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:14 +0000
Subject: [PATCH 15/25] completion: complete --no-relative
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Add --no-relative to __git_diff_common_options in the completion script,
and move --relative from __git_diff_difftool_options to
__git_diff_common_options since it applies to more than just diff and
difftool.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 13d6730f33d..f4e773cb997 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1741,6 +1741,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
 			--find-copies --find-object --find-renames
+			--no-relative --relative
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
@@ -1762,7 +1763,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 
 # Options for diff/difftool
 __git_diff_difftool_options="--cached --staged --pickaxe-all --pickaxe-regex
-			--base --ours --theirs --no-index --relative --merge-base
+			--base --ours --theirs --no-index --merge-base
 			--ita-invisible-in-index --ita-visible-in-index
 			$__git_diff_common_options"
 
-- 
gitgitgadget


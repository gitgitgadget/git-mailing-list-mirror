Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945C2C77B75
	for <git@archiver.kernel.org>; Mon, 22 May 2023 19:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjEVT3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 May 2023 15:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjEVT3O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2023 15:29:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AFDE9
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:29:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f509ec3196so26718785e9.1
        for <git@vger.kernel.org>; Mon, 22 May 2023 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684783746; x=1687375746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI/bwwWHE7EmTgiA+iHmWMTWSAt0ih39DRjqY+kKGaE=;
        b=kE0p+b1Q5IFej5QzGt1QB2A+VE0LxYA+GZkyaMYq6i5FfLk3Uiq4ZKwCCQfBtoa5As
         +dUlevh71ghLea0DTCdt4cinRK6ih1s2RNc2buz0ITTTi9d6KkS2RA7iTHYcBMgmhMFk
         6Nvy+x21XFiQaCwnnqmIYqCc0NxhDPRyM45a5pJ7uE0NffOn3EOAu/cb5ubjwfWOPiWG
         iZ0GE3jR5Qw8yykK/CfCTewvX/i0K3cCpqOCZRdffkbjnMwMyE6wYI9FXlK3axYBwxWb
         OYhuSWGXcqovfWzjAaCqhDgAcn/3D5oFYzN8G1oQMjE6Zl+maVgAtmT+kazGZbsd3P+k
         wxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684783746; x=1687375746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI/bwwWHE7EmTgiA+iHmWMTWSAt0ih39DRjqY+kKGaE=;
        b=gGnxF7/aeusS0pXPmAI917ELIK0qH9Xi6Nllrg4nZzq9w3vEy1TBg6kiZU0KOdP+sC
         CFdeJAgGVMJCM5ni363FtbfeEuQclTC5M1hOlNTZsNjqULyH+GJYDrvqRTB+4aZidnlg
         VkLEt4AHE1TMht1wiRBZpQsbWuWL4uAreosO1RIa0PPCGuPq/SnAgiBH2M7aKrzt91cD
         oLswMrwbR4MpwgGLXLN7XSuWzeyLn1VJX7ZhE2LgcM7Adx5bBlqw5ZJgfzziRVyxmgB5
         eAxmlWbQwBZl4bHddWCu6wd1f/eex+08eQ+KjKd6YR8kgqHSH4yTQIrpI/oCMBmuRIkw
         rI0w==
X-Gm-Message-State: AC+VfDw+nYbxtW5pH7C0AcdkFIRWUmFEi2gqjSy/luSNnZ18rAXWVMzX
        V/7IAWYg22Mn0TZvID/VTZZzxjU6JdU=
X-Google-Smtp-Source: ACHHUZ4ms0VNZ3MRizdUoPcJwacW5aPyThqScmJtizQ/XSGCA/I/Of8KkdTUTwHb5GvyRi6E8o2pKQ==
X-Received: by 2002:adf:dc8b:0:b0:303:daff:f1a3 with SMTP id r11-20020adfdc8b000000b00303dafff1a3mr9833570wrj.1.1684783746112;
        Mon, 22 May 2023 12:29:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9-20020a7bc389000000b003f60514bdd7sm3660418wmj.4.2023.05.22.12.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:29:05 -0700 (PDT)
Message-Id: <f1d99453f54fa08c5eb38340d50cb984fc4eb7a0.1684783741.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
        <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 May 2023 19:28:59 +0000
Subject: [PATCH v2 4/6] git-merge.txt: modernize word choice in "True merge"
 section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The "True merge" section of the 'git merge' documentation mentions that
in case of conflicts, the conflicted working tree files contain "the
result of the "merge" program". This probably refers to RCS's 'merge'
program, which is mentioned further down under "How conflicts are
presented".

Since it is not clear at that point of the document which program is
referred to, and since most modern readers probably do not relate to RCS
anyway, let's just write "the merge operation" instead.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-merge.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 0aeff572a59..23aefe28851 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -194,7 +194,7 @@ happens:
    versions: stage 1 stores the version from the common ancestor,
    stage 2 from `HEAD`, and stage 3 from `MERGE_HEAD` (you
    can inspect the stages with `git ls-files -u`).  The working
-   tree files contain the result of the "merge" program; i.e. 3-way
+   tree files contain the result of the merge operation; i.e. 3-way
    merge results with familiar conflict markers `<<<` `===` `>>>`.
 5. No other changes are made.  In particular, the local
    modifications you had before you started merge will stay the
-- 
gitgitgadget


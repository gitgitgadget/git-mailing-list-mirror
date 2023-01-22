Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982EFC61DA0
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 06:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjAVGMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 01:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjAVGMu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 01:12:50 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94944FF0C
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r9so8118423wrw.4
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo1OaFfMKCy9YnGPXFMgi8mGCm66FoS1sHfeN+xzdBU=;
        b=jSMUgqUqsjeQr9PZwcNNA/NnUdbLACAUakD2AAsu81W3AGNwOH1eGYZvEUQzHVyz5V
         kNEJK2bOD8h6dFCIGAGvQA0bdPW+DB0U9avew23SmT2ZtIY/aW4I6a/u4u7PUu5VPRPv
         SDYmQ4mmJUKUPO8HsW7nyzrlpNuQ8qdwR/6BX72wuqQ/Y5TXObCeN55mTEz0mbyjiuRs
         IRQMmgDAihBV5voPfUcfhGxTw55Q40NlWo/9xnb2AF97mlrpEryehvIGGDMIbGCOv2h5
         WBbroY5RQqM7E7meMamCMHNcyHV4nKCIhLs6aHDMGNFa5poY4PHKyV2soJUsxrFykyTV
         5Dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xo1OaFfMKCy9YnGPXFMgi8mGCm66FoS1sHfeN+xzdBU=;
        b=C/7NwNz++Sh6Hu8e9BBaxP/mvXIPaPUG4zhZXObw0iBRVnJ9fwwCfXWQD893TqwJG5
         z8q8oak1WnyR7/Y34fhb9TeVvSggbgHRezOMO39cNxFxg0lfyVMx9QBGSsFUJNTWP9Lo
         LRgE5vh/z2eXGk+XgqtDtws/OUhRUvWdac1aPyVN3v0Tfo7KDnxXfKvs2a17i0gpiR4+
         ra+QlgnoOzux2pOAmHjEXC037Xs/vncQpyD2p7ropwOthsxKbPnppPOeNTXIiCRqvswH
         j4wkhQlUUqpePYPVcUwiucAsKf1eq2+uvGmFAkVtx7N2J5t1zhZPUckB6iOmTVSOAeTo
         qO1g==
X-Gm-Message-State: AFqh2krOvkYojD9BCi6SHsj3OENKyLWh1sF6iTKNK+wWIGLwwhSl8y7L
        zhUV5Jk/NNTcZQBDKmPSIDuhcrdbbIs=
X-Google-Smtp-Source: AMrXdXuJnunDPG4P34wGpRNwT528KThWG0ZF3VSh3XWplAOg9tQIGC50nRzNRIZX7YUzF/qqcDJjBQ==
X-Received: by 2002:a5d:6b42:0:b0:2bc:bffe:831a with SMTP id x2-20020a5d6b42000000b002bcbffe831amr12198662wrw.49.1674367965819;
        Sat, 21 Jan 2023 22:12:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d4487000000b002425be3c9e2sm1866676wrq.60.2023.01.21.22.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 22:12:45 -0800 (PST)
Message-Id: <b702f15ed7c2c48dc0f502ed0d7d6491c2056408.1674367961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
        <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Jan 2023 06:12:35 +0000
Subject: [PATCH v4 4/9] rebase: fix docs about incompatibilities with --root
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In commit 5dacd4abdd ("git-rebase.txt: document incompatible options",
2018-06-25), I added notes about incompatibilities between options for
the apply and merge backends.  Unfortunately, I inverted the condition
when --root was incompatible with the apply backend.  Fix the
documentation, and add a testcase that verifies the documentation
matches the code.

While at it, the documentation for --root also tried to cover some of
the backend differences between the apply and merge backends in relation
to reapplying cherry picks.  The information:
  * assumed that the apply backend was the default (it isn't anymore)
  * was written before --reapply-cherry-picks became an option
  * was written before the detailed information on backend differences
All of these factors make the sentence under --root about reapplying
cherry picks contradict information that is now available elsewhere in
the manual, and the other references are correct.  So just strike this
sentence.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt           | 7 ++-----
 t/t3422-rebase-incompatible-options.sh | 4 ++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 7d01d1412d1..846aeed1b69 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -574,10 +574,7 @@ See also INCOMPATIBLE OPTIONS below.
 --root::
 	Rebase all commits reachable from `<branch>`, instead of
 	limiting them with an `<upstream>`.  This allows you to rebase
-	the root commit(s) on a branch.  When used with `--onto`, it
-	will skip changes already contained in `<newbase>` (instead of
-	`<upstream>`) whereas without `--onto` it will operate on every
-	change.
+	the root commit(s) on a branch.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -656,7 +653,7 @@ are incompatible with the following options:
  * --reapply-cherry-picks
  * --edit-todo
  * --update-refs
- * --root when used in combination with --onto
+ * --root when used without --onto
 
 In addition, the following pairs of options are incompatible:
 
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 9b9e78479f6..f86274990b0 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -65,6 +65,10 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --update-refs A
 	"
 
+	test_expect_success "$opt incompatible with --root without --onto" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --root A
+	"
 }
 
 # Check options which imply --apply
-- 
gitgitgadget


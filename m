Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED07C433EF
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 21:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9614060EB4
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 21:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhKNVst (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 16:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhKNVsY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 16:48:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CE7C061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 13:45:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so10895431wme.4
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 13:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=NOharhHRVXAK2A3MW6GyBNp1MOJ9puiNUW8m4NHpA50=;
        b=GubxJ3Lgi/YWdoyf4FxsxsU/vRLZr5FVagr1gB0bFjG/e8Qy8rEMf8kKHQAQrLWjX6
         MzZs0hvPlpI52R3Nf2txb+gIOVr5S6EMTPCCqy2vMPkQyCMBoPAwXXFQFn1xDH1GSmKx
         l4GudZfp4fu+QtorFQbtkbnKEECuDHtEdzi+l5Ov2u90e3GiGWeNJbEFaxPWfS2h+/M7
         YOXFmppHAJ3Uyc3E+n1p6u/QJ2DQ3xEtq2aKvwBa64ms3CO/Y0T7KGcb9XHh6b0xHR1J
         1DZDO7iP4CJRsM9xifM9pjPjdfsQ9kMr3CAeMp31M5gNchILKryBjeTty3gzXtvIS6/a
         VmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=NOharhHRVXAK2A3MW6GyBNp1MOJ9puiNUW8m4NHpA50=;
        b=wqg84BmwqbmvOXnjUNT4S2RsexwnFIFPz3wJlRHfERvj/MXMKcjgZRrAepzTcMFAMb
         ZBsrIIYx1vT55wwPDAcKh64nFDmhGs9LBPdUfOguMIJoUS/+hUnS6eLzQWoqgpbh9A+u
         H8SUXADhjLotcd31EootJovUwebq1Hg8OEGfXjtrLrMkWpZIhAcUDEUlnlQiwZlEXA5Y
         QBWU0q/bxeGzr2G4+bfS9Wul8Ay6yBvqRvxn78WqUGBfElB1xYs+wpSDXdWfH6LLtiwI
         w/vLJdeIlTYzjZqai/Nu60U+UsDzUZRpPPHV2Jr7GUx+AqcIpnIVnuq1KOwfqOmHkpfj
         PEDw==
X-Gm-Message-State: AOAM5319EXAkyx411A4CEMA2vtvSGl+rp3mnST1wrgLynsBQ1CaH43qb
        Lt/YghkIspdER7cuCV/E5vf3gUcRKtk=
X-Google-Smtp-Source: ABdhPJw7RvnDPXmiFJy/eO7FP53ReVtHLEbW8iVu1pxTnmW9itwd2SW64rUpb292AAWMzQUQXiAJZQ==
X-Received: by 2002:a05:600c:4f02:: with SMTP id l2mr37054133wmq.26.1636926323443;
        Sun, 14 Nov 2021 13:45:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7sm15288712wry.86.2021.11.14.13.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 13:45:23 -0800 (PST)
Message-Id: <pull.1139.v2.git.git.1636926322423.gitgitgadget@gmail.com>
In-Reply-To: <pull.1139.git.git.1636902454370.gitgitgadget@gmail.com>
References: <pull.1139.git.git.1636902454370.gitgitgadget@gmail.com>
From:   "Thomas Koutcher via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Nov 2021 21:45:22 +0000
Subject: [PATCH v2] subtree: force merge commit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Thomas Koutcher <thomas.koutcher@online.fr>,
        Thomas Koutcher <thomas.koutcher@online.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Koutcher <thomas.koutcher@online.fr>

When `merge.ff` is set to `only` in .gitconfig, `git subtree pull` will
fail with error `fatal: Not possible to fast-forward, aborting.`, but
the command does want to make merges in these places. Add `--no-ff`
argument to `git merge` to enforce this behaviour.

Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Thomas Koutcher <thomas.koutcher@online.fr>
---
    subtree: ignore merge.ff setting
    
    When merge.ff is set to only in .gitconfig, git subtree pull will fail
    with error fatal: Not possible to fast-forward, aborting.. This fix
    ignores the merge.ff setting when using git merge within subtree.
    
    Signed-off-by: Thomas Koutcher thomas.koutcher@online.fr

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1139%2Fkoutcher%2Fsubtree-merge-ff-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1139/koutcher/subtree-merge-ff-fix-v2
Pull-Request: https://github.com/git/git/pull/1139

Range-diff vs v1:

 1:  b03749fda76 ! 1:  765fea3e26c subtree: ignore merge.ff setting
     @@ Metadata
      Author: Thomas Koutcher <thomas.koutcher@online.fr>
      
       ## Commit message ##
     -    subtree: ignore merge.ff setting
     +    subtree: force merge commit
      
          When `merge.ff` is set to `only` in .gitconfig, `git subtree pull` will
     -    fail with error `fatal: Not possible to fast-forward, aborting.`. This
     -    fix ignores the `merge.ff` setting when using `git merge` within subtree.
     +    fail with error `fatal: Not possible to fast-forward, aborting.`, but
     +    the command does want to make merges in these places. Add `--no-ff`
     +    argument to `git merge` to enforce this behaviour.
      
     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     +    Reviewed-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Thomas Koutcher <thomas.koutcher@online.fr>
      
       ## contrib/subtree/git-subtree.sh ##
     @@ contrib/subtree/git-subtree.sh: cmd_merge () {
       	if test -n "$arg_addmerge_message"
       	then
      -		git merge -Xsubtree="$arg_prefix" \
     -+		git -c merge.ff= merge -Xsubtree="$arg_prefix" \
     ++		git merge --no-ff -Xsubtree="$arg_prefix" \
       			--message="$arg_addmerge_message" "$rev"
       	else
      -		git merge -Xsubtree="$arg_prefix" $rev
     -+		git -c merge.ff= merge -Xsubtree="$arg_prefix" $rev
     ++		git merge --no-ff -Xsubtree="$arg_prefix" $rev
       	fi
       }
       


 contrib/subtree/git-subtree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7f767b5c38f..cb51aee4cbf 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -976,10 +976,10 @@ cmd_merge () {
 
 	if test -n "$arg_addmerge_message"
 	then
-		git merge -Xsubtree="$arg_prefix" \
+		git merge --no-ff -Xsubtree="$arg_prefix" \
 			--message="$arg_addmerge_message" "$rev"
 	else
-		git merge -Xsubtree="$arg_prefix" $rev
+		git merge --no-ff -Xsubtree="$arg_prefix" $rev
 	fi
 }
 

base-commit: 5fbd2fc5997dfa4d4593a862fe729b1e7a89bcf8
-- 
gitgitgadget

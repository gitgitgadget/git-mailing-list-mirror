Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E33C433F5
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 15:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68EE61075
	for <git@archiver.kernel.org>; Sun, 14 Nov 2021 15:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhKNPKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 10:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKNPKc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 10:10:32 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4104C061746
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 07:07:37 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id n29so25281894wra.11
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=hLwb4DeycfxX84lk2u0GPNdJJWlkFZvFNh689/hvFEQ=;
        b=ihoiLJRaqAn+z34zqRUa6jL9+dTc7aaPgWTMm7BoQLFhn4WmtC7mgIJSPVjexNMMTo
         fKwMX+F9gix8G4CRUDtgsr61LnSZ7/2OeBgkMGLzuvoURRS8SJTIXFXGdDl9u6J+MZ4h
         jXV+YC3YjWtVKPoVmeySX10yxHBa8BwiK5H0/Eeve8AHj/GC2Ocbg8m0SQ4wv0VNLPR2
         Y3/dJefROOQtVv7ppqwNS78Se9MGwpTq646XFKyKH4q07mp/ID+v6lLWhNTJc/xR+iUl
         N4URh/KnjKl/ZI7TB32owKGI49aRuTGQ1oa47DKhqEJi7kAHdxlOM/nF7/RacUSfUCxM
         n1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hLwb4DeycfxX84lk2u0GPNdJJWlkFZvFNh689/hvFEQ=;
        b=jqOIxdm9Nl+2OzO99tIACJMr1fpVgflm5SblUm0TuI4kvvwqYt6mBimrpbBy0EgbGC
         0yJ/Ydr9m3iB2SWjdjA2g1jcpwzAU8gws9h8q0VLLl+1QRMKUFQrQTEMCeweiFrcA4o5
         ROat22xXxZZ4ru9fWSW9Ovn9Iwm12J9oQ7h/Pi4TWxapQvgJmTlB4gcNcIEaquV4i5Ld
         gIcaHIWX9JR0vNkEeJzMR9SsDIHVwKf8o4yD9qcTucdsWPFCtc3zC+zLw+S911hZUglT
         y88cohFOAqYzfJ6b8vQArJigPIdpsILRdhbu0flaSdN9J4xSECpNhJkXzJKnVZT4PYct
         lY4g==
X-Gm-Message-State: AOAM531AfgGCkcRDqgQwRlS0S0lKLqbnj37VODW7oDJfBj6C3TnmEPyr
        IlhDo0xaJp643DW15UuKFTPVoMEQR/U=
X-Google-Smtp-Source: ABdhPJxVYSRLk/K5dg24SzCnD4uXotUc/xlNW8LbdrlJj8K8KoknpqBdniFLOCbdx/0Rwec3sBTVZQ==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr39055551wri.8.1636902456098;
        Sun, 14 Nov 2021 07:07:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm12609942wmq.6.2021.11.14.07.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 07:07:35 -0800 (PST)
Message-Id: <pull.1139.git.git.1636902454370.gitgitgadget@gmail.com>
From:   "Thomas Koutcher via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Nov 2021 15:07:34 +0000
Subject: [PATCH] subtree: ignore merge.ff setting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Koutcher <thomas.koutcher@online.fr>,
        Thomas Koutcher <thomas.koutcher@online.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Koutcher <thomas.koutcher@online.fr>

When `merge.ff` is set to `only` in .gitconfig, `git subtree pull` will
fail with error `fatal: Not possible to fast-forward, aborting.`. This
fix ignores the `merge.ff` setting when using `git merge` within subtree.

Signed-off-by: Thomas Koutcher <thomas.koutcher@online.fr>
---
    subtree: ignore merge.ff setting
    
    When merge.ff is set to only in .gitconfig, git subtree pull will fail
    with error fatal: Not possible to fast-forward, aborting.. This fix
    ignores the merge.ff setting when using git merge within subtree.
    
    Signed-off-by: Thomas Koutcher thomas.koutcher@online.fr

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1139%2Fkoutcher%2Fsubtree-merge-ff-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1139/koutcher/subtree-merge-ff-fix-v1
Pull-Request: https://github.com/git/git/pull/1139

 contrib/subtree/git-subtree.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7f767b5c38f..de918d9fb05 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -976,10 +976,10 @@ cmd_merge () {
 
 	if test -n "$arg_addmerge_message"
 	then
-		git merge -Xsubtree="$arg_prefix" \
+		git -c merge.ff= merge -Xsubtree="$arg_prefix" \
 			--message="$arg_addmerge_message" "$rev"
 	else
-		git merge -Xsubtree="$arg_prefix" $rev
+		git -c merge.ff= merge -Xsubtree="$arg_prefix" $rev
 	fi
 }
 

base-commit: 5fbd2fc5997dfa4d4593a862fe729b1e7a89bcf8
-- 
gitgitgadget

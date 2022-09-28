Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056BFC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 05:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiI1F62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 01:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiI1F61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 01:58:27 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D6D113B69
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 22:58:26 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r5so4730108ilm.10
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=D0FCrenS4kXN028F0zGcP5yMicQqF0si6frnzmTwvfs=;
        b=juf9uVmMsqB9f4RyXJ5rgr35xMc6CYUVlpw+2Vl4ZPDh2vNByVJh9icNMdXlXnt5lJ
         r4BpoZ0IN3gWx4afcVymBUxmMfNW8z/3wgWyf3niM6LRXaocRwbIX4VMNfK7ucNSlppc
         iMRt7TUxwLR/O2gDeGpmiAjcKN6TbJNqGpeb0x7FibKnUq7GBIkDDZ8ILjSqKNhBQeRM
         9hVSYQ2ifXJSpoz5Hy75WGt0WdrR4l1jcErUfYM3xAwZsRvfaPYvBpUmYUTCNEkjSAze
         IPPnwoDW9jxMbIkZvF/Aqi949JuvBN2nOS+T922QadkxbHVjRc99v379C1oDp1MVIehe
         9C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=D0FCrenS4kXN028F0zGcP5yMicQqF0si6frnzmTwvfs=;
        b=5kmlj9h/SZqmaDFxSPMJalJgswtCr1tLj6NjQEvd7sNE4MKUMtxk3gsRV63CqEJwKK
         OxsQln65TIHPyCMAzKHwiyujFuedEWtJDxlWHj/7TQ6B1IgR8fIFtzXtOttelzxYvVTM
         9CzcOjKqMa7ll0Daze9yP1Pcs+6EoHT8IYjUuuzcQXnl3DsKMswUpUbhG60m9mgwPacK
         k/1IzrdJFNokEHi2UQleR32BokhoFbEig5GK7Zud6SDCiexD6tjh4WcVU6AXtVy1oQCr
         /HDICMN4V6mQ74cs3aSowg3xx9uIbHXXeiPXbUrehMNtmRGz6rNa+PM6BadQlBx0ygXK
         TlMg==
X-Gm-Message-State: ACrzQf3c8k+4NohmUmPsqKUOkP52PYi75jN3iLD7ZzdnWhTZM6X4fc3q
        d/yW+mO6i8OkK/f5/ivsxwVbbmHO624=
X-Google-Smtp-Source: AMsMyM4thTFUqX+hMaAQQ7JXVfQi0DPAA1KYv9cOuJ1qT2BwV/g2Ej5MKLvyZZ0ZTu+vI4WUKBCHDA==
X-Received: by 2002:a05:6e02:15c4:b0:2e1:986c:91a1 with SMTP id q4-20020a056e0215c400b002e1986c91a1mr14653711ilu.22.1664344705725;
        Tue, 27 Sep 2022 22:58:25 -0700 (PDT)
Received: from xavier.localdomain (75-169-20-7.slkc.qwest.net. [75.169.20.7])
        by smtp.gmail.com with ESMTPSA id b72-20020a0295ce000000b00349c8fe9109sm1400551jai.174.2022.09.27.22.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 22:58:24 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] push: improve grammar of branch.autoSetupMerge advice
Date:   Tue, 27 Sep 2022 23:58:11 -0600
Message-Id: <20220928055811.777227-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"upstream branches" is plural but "name" and "local branch" are
singular. Make them all singular. And because we're talking about a
hypothetical branch that doesn't exist yet, use the future tense.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/push.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index df0d68e599..f0329c62a2 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -169,8 +169,8 @@ static NORETURN void die_push_simple(struct branch *branch,
 	if (git_branch_track != BRANCH_TRACK_SIMPLE)
 		advice_automergesimple_maybe = _("\n"
 				 "To avoid automatically configuring "
-				 "upstream branches when their name\n"
-				 "doesn't match the local branch, see option "
+				 "an upstream branch when its name\n"
+				 "won't match the local branch, see option "
 				 "'simple' of branch.autoSetupMerge\n"
 				 "in 'git help config'.\n");
 	die(_("The upstream branch of your current branch does not match\n"
-- 
2.37.3


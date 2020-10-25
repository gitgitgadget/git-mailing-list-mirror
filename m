Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2307C2D0A3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F6D20882
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhgeFGNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766903AbgJYDOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766894AbgJYDO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:28 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C5C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:28 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f97so5112851otb.7
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=22T4sezOB3BBGn6leesAspm6GOVpoasFpsJBodRhGOM=;
        b=GhgeFGNYa12GmkRBeWXXcXXwr8hcDLDesygu5hLOkRn+rO9iWQd6fvk0SFy+gEyBpQ
         86PYUf/L6sOZ2WV9XYBPSeP0TD1amJN+ZGF7562wCIP68/ZldVFd4CmbAemSe8llKTVZ
         E87Ah6CAHyDkwr80J1kqrgGvdA/Wtv/Qg5uSDkeWQg/Yg+7GTQBvw16Zb/GDM5lkMZXa
         ptv0hWZCEZ3dAJTmF1eB4c6GPRsX0OrUxS9JTGBIO8rr0LXub0Av5vSwU7Xh7SW/enhs
         HSFIw1qHEiSUaqq88nHfRFqHdLso8oKLmAYmcBMK3CjqGxfpgC0RlAVmIP/AqCMTP0vc
         YP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=22T4sezOB3BBGn6leesAspm6GOVpoasFpsJBodRhGOM=;
        b=eMPOYbQOMKkFNjg4j3VELgEeF+Mi1Lwkc3p0qJm1r8Rw7+tOSfA7gEzAjmjUSZNmRY
         nF3ILsztDnjeW4yXleaAWTQjwV6rt2lVbT9TkXahbbWPO9BIiz3KQG/rDv/KOvZhx+Tf
         82WnrBLGLecVfZUDjTK12tjz8qMxRrfrJvnwBbVZr6SFr4eY60vKwGCkyvftYPqRSRUd
         J8XJV/wSbbEeOf9hKyt3ngij2R3aQhZZ4dfwCctgWEzJpM/icDXI7wVBMSGr5fiECMBL
         sRK5nlRwmN5tiVOCwkvSluVobJWQHbmBqbK26SVTCHadWrdhcF5v7prKu6gFdhz0jKaG
         z1rA==
X-Gm-Message-State: AOAM532L9/mm1FbU1bjpWyO6SsIccFmZKCYNUx1GmNjsEHwzrazKX7Mw
        goZEgWL+lLoYcIJ+UD0q1q3zGAqKMVO05Q==
X-Google-Smtp-Source: ABdhPJzg4yBqyF11RRGQW8bI4JQ1K+pCgQKPTsI3j5U8iLkPaE5P5WphYdICB9orxcFfd84lC0EaZw==
X-Received: by 2002:a9d:7419:: with SMTP id n25mr8145004otk.183.1603595668072;
        Sat, 24 Oct 2020 20:14:28 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id f2sm1676509ots.64.2020.10.24.20.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:27 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 28/29] completion: bash: remove old compat wrappers
Date:   Sat, 24 Oct 2020 22:13:42 -0500
Message-Id: <20201025031343.346913-29-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been eight years, more than enough time to move on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ac1835cb30..26538efb80 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3481,18 +3481,6 @@ __git_complete ()
 		|| complete -o default -o nospace -F $wrapper $1
 }
 
-# wrapper for backwards compatibility
-_git ()
-{
-	__git_wrap__git_main
-}
-
-# wrapper for backwards compatibility
-_gitk ()
-{
-	__git_wrap__gitk_main
-}
-
 __git_complete git __git_main
 __git_complete gitk __gitk_main
 
-- 
2.29.0


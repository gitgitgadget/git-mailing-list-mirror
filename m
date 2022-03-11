Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30406C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 00:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiCLAQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 19:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiCLAQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 19:16:09 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD911EBA9B
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:23:19 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id w7so17457818lfd.6
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oaK0qAdl2PFgiQVfAFiByJpTMx/6+l7fU2gN08F/xkg=;
        b=hFkvdSKjNJHBF6/QXY4yDUNvOvyk+ApHlYcIHA6m0gsyAx4XMSFZ+9oHURDgRwpff+
         hWue8NNjHBOQCJJHnnt0NubfLPX7XSUxkV5d72eDenz1PsoUbuKFFTBxsAVB/7LPPJmM
         d5RLHqiR4y5Lawvfdx/m+YQ0v/fTNrAkvHnE1CzITJzTPA0NOtZdLY0t231K6rRJQVTh
         kFEHVOG8FZu/7iaU4JdyNm5pd2IyUYsnunnCcu5UdHJPYfXhlws1sMC20rMVSKL8LgpY
         30AHX6GhokLxeq4HT/HJsrkZX3lX5RXJUCNhysXqn1bJLZtK6aFjbxf6nAlqa4zzEVjd
         Ms6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oaK0qAdl2PFgiQVfAFiByJpTMx/6+l7fU2gN08F/xkg=;
        b=dtu2bXiZhY3hI7SOUSBbQ07n8EFpJC9hYA9Jb90v/7052bhCjiULFNLHFML6GTIsBD
         2erImxCkxxbjOtztmfNBJfsPHrm4NrmOvw1JIX5m42RoXgaQmCi1KDZzc+EYsIX3FfCz
         1fXDRCe2HsrYuMkO5jLTa2RsVb4r81LQ71Ab+ThShtkFUSJz+NHUAhk1xoi+PTP3sGDf
         F6bEySBSIA+rzl0gsYFp1bJRQlCD0YHlNNJj3NJGpVt/YxAr2LhmQDtTnV4YAbFfGEX8
         g0qfWh0fDO0K5B/fa0K0CpKEIylfeCK8koNyEDIgztyx7USXgPU2xWbE0AVXa9VQ70HD
         /bhA==
X-Gm-Message-State: AOAM530OXEjZh6eI/0vHnZt8mEU05HLnHEvW0cSuMGwesx61ntfrpdvm
        tHWeqRu8wGkOIf3wQ84CZoxUDsaWwI0=
X-Google-Smtp-Source: ABdhPJz9mHP8mByyDTgX3ygg7fTlLu/eKzqBRUQNd3+l9lqg9/wWX/Mb32DxRvltZCpug1Zb6tqbHQ==
X-Received: by 2002:a05:6000:23a:b0:1f0:2359:9cd5 with SMTP id l26-20020a056000023a00b001f023599cd5mr8428434wrz.335.1647033317404;
        Fri, 11 Mar 2022 13:15:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4-20020a056000154400b00203812ca383sm7026773wry.78.2022.03.11.13.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:16 -0800 (PST)
Message-Id: <432f9ff9d92ff55216555864cb3571c94a2c6db9.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:15:03 +0000
Subject: [PATCH 16/16] fsmonitor-settings: simplify initialization of settings
 data
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

fixup! fsmonitor: config settings are repository-specific

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor-settings.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 3b54e7a51f6..757d230d538 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -22,11 +22,10 @@ static void lookup_fsmonitor_settings(struct repository *r)
 		return;
 
 	CALLOC_ARRAY(s, 1);
+	s->mode = FSMONITOR_MODE_DISABLED;
 
 	r->settings.fsmonitor = s;
 
-	fsm_settings__set_disabled(r);
-
 	/*
 	 * Overload the existing "core.fsmonitor" config setting (which
 	 * has historically been either unset or a hook pathname) to
-- 
gitgitgadget

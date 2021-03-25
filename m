Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272C7C433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 10:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E5961A30
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 10:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhCYKXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 06:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhCYKXO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 06:23:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F293DC06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 03:23:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo845692wmq.4
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 03:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZLwmjo+MEb4TlxRrLvftaJK69UBQ4FLMfpIWfxvC9oE=;
        b=m6JiC07aSyHktiycApOyv41fNAZKAChKvsibJaMDpx869wpv747cS6VnzHwgPhD41G
         KXxhcnV3OCNMjquZ4WKTXF7g58OzxJyS3ryJL2YY0vHDj8urxW+0AVaUpjldxJemXBoQ
         9Pi/l8ZWfuAJxXloAYJmjVdznqT28KOUpjudly6oYhAXmms8BC3g2rwmunBgQl+tijZe
         cbKqrl5B0ax8EmVH3c2O9tDk55/pHzQPxu9UnyBN+pMUXyGyaM35EWFnCxHrdnPonPu0
         zQLjFLhFLf5deE8rXQJVhYDl/yOYo3vZn61AqELVFnZ6T4XTmDyL3CiM+rG/bLpjlZ+t
         CA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZLwmjo+MEb4TlxRrLvftaJK69UBQ4FLMfpIWfxvC9oE=;
        b=uP8wLbyQdR+rXFO2SZV9lKflzzFSRkO1yiSkJqlc02C1HRUJr3r+UN4hbjEe+hZdFq
         +mUefQb+RavT7ez27pcxzFvWF+2vYgtIc8JJ7cTesi6YnB3YOlfBLt7pW66d20apn6nj
         8cwJIYHQs64KLOsneJs0w7yyC9ZBPfAtemONpUQsdDN3LFy0vLWsHtItTmtHBtPraC2z
         2ElqvfszVH3S6PByLacTjr53GDtWa5/1H3UVMUiPp/hK1f36j/0HDfz0Q9tpH+12Gsfd
         o0CjKpRP/2NXHnHC3OGGDwSFrSD2b6eTUpjE7plwRaJOTfyA9Sq/3BN5VzTvEghwDG+r
         KAkw==
X-Gm-Message-State: AOAM533CJs8Hnv6QUHjoDbCekjH8aD8ABo9UhNog8csdoddo0GmCwFw+
        djAc6pBGLo9M7ZiNVgpNVOYCWKArPjhX3v6x
X-Google-Smtp-Source: ABdhPJxs44UOvazo0tiizc63YUVRTLBC2Euax8HGaxushDDYssTJqIUuUpvY0o+Uu693ii4HyWqOcg==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr7204812wmi.27.1616667792255;
        Thu, 25 Mar 2021 03:23:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id k13sm7633376wri.27.2021.03.25.03.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 03:23:11 -0700 (PDT)
From:   =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= 
        <stdedos@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= 
        <stdedos@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [PATCH v1 0/1] pathspec: warn for a no-glob entry that contains `**`
Date:   Thu, 25 Mar 2021 12:22:27 +0200
Message-Id: <20210325102228.14901-1-stdedos@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <xmqqft1iquka.fsf@gitster.g>
References: <xmqqft1iquka.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>

This is my first contribution to the git project.

It is the first of the second takes that came from the
https://lore.kernel.org/git/xmqqft1iquka.fsf@gitster.g/ e-mail
(hopefully I linked it correctly using the git-magic commands).

For the review, I pulled in the latest _meaningful_ contributer,
as well as one big contributer to the file.

hopefully, all is in order and correctly done.

Please be gentle with "protocol violations". :-D

Stavros Ntentos (1):
  pathspec: warn for a no-glob entry that contains `**`

 pathspec.c                 | 13 +++++++++++++
 pathspec.h                 |  1 +
 t/t6130-pathspec-noglob.sh | 13 +++++++++++++
 3 files changed, 27 insertions(+)

--
2.31.0


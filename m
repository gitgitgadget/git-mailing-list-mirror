Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C53C001B0
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 01:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjGHBGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 21:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjGHBGF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 21:06:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10E2210C
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 18:06:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso27348255e9.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 18:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688778362; x=1691370362;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUOGi/S8harMIkeMlwlGX4B7j1x/qNSxJP2y5l0vrds=;
        b=aMZr9x93C3p6wv0+doSPjtXoQYqWXAKfkIi8O5G0HuBLw5zSaU/o7xQPPV/7zCbGVS
         Qpf/1QxY3RvG/dU1P8mKx/P7d333oOz/xggnMAPKVBXD+djKLchJ7kanGA3uuYwseGgC
         dpcuolVQn98prwJgh1BlJf9hHqw5CSPrxJcp2LOENg+qyfYv7FE6pPygM0CnGAzdqeEk
         qHD4wR7n1N+83RlpNENALJPNnXmyfxvz4duEVfLzXD1dCRYVqMYq4ta6oqnpQhjMFTW1
         j0tK3DwKw0V+UMjMeSvgAtMEp0+BA2zn5KRMOGGQBXL1FWjC1eKYsO1pgqkO3cWP8f0i
         gXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688778362; x=1691370362;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUOGi/S8harMIkeMlwlGX4B7j1x/qNSxJP2y5l0vrds=;
        b=apTtgGzayFpKILZxqQGdrsgpJse89LcVxV8rS185rsh/lw6Xl1mMvdzoMMGAw4VyUK
         FS3tqTHDYtXFMLddV7zxzsNTJmsf5LVeO1bK7SpZAJ3zdhAncixJ1P+b3iHPdC9SJsET
         6fT3gslDf7rU47XMhg0JyH8ZUbTH2c2c8N+JKeDDLGLMNNexAwKQ5UjpZcMJMHSqLFvF
         S+4/Y3//GzOD8fYsjbaF8zXeQXQHu6JjG0LUMRObYJu4ZM9RFPhE6uuKFSMkf4tmJ4DS
         0vtERmQwdgKUZwy+WSbuYuNYBjP7n4QoRtu2oOz+PpAYxuAFHAgZkmvISe+QwyRXA3yA
         MgQQ==
X-Gm-Message-State: ABy/qLalAbl8pOA4FUdV7/fBYMqfPYBMAFZlARnCZ12wnQgeJoh7aVmu
        h244NL9nMVlvaKC320FLcRw/ovDTp5A=
X-Google-Smtp-Source: APBJJlGupvVykwWqaX17R4XAFuU+jBKqSxo5H7npHXJ17CoQ/97zOqIncU2lcG0sDtmnt+3nLzbWcQ==
X-Received: by 2002:a7b:c3d0:0:b0:3fc:1a6:7764 with SMTP id t16-20020a7bc3d0000000b003fc01a67764mr1471721wmj.16.1688778362068;
        Fri, 07 Jul 2023 18:06:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc354000000b003fbb8c7c799sm3784648wmj.30.2023.07.07.18.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 18:06:01 -0700 (PDT)
Message-Id: <cb4a61eba8da376fd1874c12360ec67c81af1bd6.1688778359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Jul 2023 01:05:55 +0000
Subject: [PATCH 1/5] SubmittingPatches: reword awkward phrasing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b218e273570..b89678cedc3 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -3,8 +3,8 @@ Submitting Patches
 
 == Guidelines
 
-Here are some guidelines for people who want to contribute their code to this
-software. There is also a link:MyFirstContribution.html[step-by-step tutorial]
+Here are some guidelines for contributing back to this
+project. There is also a link:MyFirstContribution.html[step-by-step tutorial]
 available which covers many of these same guidelines.
 
 [[base-branch]]
-- 
gitgitgadget


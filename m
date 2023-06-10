Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB00AC7EE43
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjFJUWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjFJUVv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7514A3AB3
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f7f4819256so22113915e9.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428503; x=1689020503;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBjVsTfHC97mrXrTf7OOMY/gBC1f5uYUeDEimD9hNGU=;
        b=SRh+X1+6AgG6aDvDlTjDhkiiGR9OxxL3UNQqKzaqlLaUu7aw0DwGOutWQVlXM9CY1/
         xC+i+v9JE5yxyhUqoWctWtC0GjnJmngjFD54ZyIuvl7Mjg1v1xj05ZnhGo7qCbYU+fPn
         o3o0oDg7f9b9x6qN9wSQ4sw3Buz54vltXRYp93XhAiaJNeOfwFlSBBBrnKMwBQt60dlq
         FydmpOIk4MI3zCOt63cAQLHO1RCcnif6bRnWcdFVuPvg8tsQBy3i6q8A0Qfjb1kzjlv8
         2tthoQ3seK2Y3vhUF88PEv/Bv31Y2s9BBvyXPJU384QSOVKxuLmqG8YoRyJ511pELuOZ
         Ac2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428503; x=1689020503;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBjVsTfHC97mrXrTf7OOMY/gBC1f5uYUeDEimD9hNGU=;
        b=RTOn5PN0Fvje8A455ReY8+Q/T4q98gcp8aFE2qFJgrBqtBUIG9SX/ky3ewq2s6ruV2
         R6fZabTE/T1luWiVHimdocIJkeYyf3pCpO8knqQXebBDJi/nrdTgKVJtPid8P3m7hTJ4
         r5khNPlUs/B4eSDfUGy2x+ftzNOryIkGm+Y/S0Erf/YuWDj5sB1BV8eHCtI7LMHZOFuc
         1Q77LGA/PeJ4VBQWqkmMDfYGyEsPYo97DLIxwQn2S16SKdsNqMN75BbUK6ZpN+9N/aMB
         0XSZLnRud6kjM2v3E1f7+v8xxcfuJpG9qxzYn7obgQmA1YeDg/8TwcOCgKuasgMTf9bu
         7JPg==
X-Gm-Message-State: AC+VfDyuBQRnopNc4b8WujmXJOCQ4bIbXjb7eHtDSm2D2APYi2Fjsuif
        DeBa6pFfSVk1vCPYBEOeKOyzkEXFmk4=
X-Google-Smtp-Source: ACHHUZ5h5xu22FN/ORC/C3nS7Hhxy1PRsa67E3Raob9jDC+8wh3+13rG/raQNcdSCXIi+jpg0488QA==
X-Received: by 2002:a05:600c:290:b0:3f7:3991:e128 with SMTP id 16-20020a05600c029000b003f73991e128mr3471282wmk.2.1686428502710;
        Sat, 10 Jun 2023 13:21:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020adfe350000000b0030e5b1fffc3sm7921811wrj.9.2023.06.10.13.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:42 -0700 (PDT)
Message-Id: <d66068db0a4ab531fdd26b9b22a79d9bb1b5fc4c.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:23 +0000
Subject: [PATCH 24/25] completion: complete --remerge-diff
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

--remerge-diff only makes sense for 'git log' and 'git show', so add it
to __git_log_show_options which is referenced in the completion for
these two commands.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7b7f3f838e0..38b6bac9154 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2042,7 +2042,7 @@ __git_log_shortlog_options="
 "
 # Options accepted by log and show
 __git_log_show_options="
-	--diff-merges --diff-merges= --no-diff-merges
+	--diff-merges --diff-merges= --no-diff-merges --remerge-diff
 "
 
 __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"
-- 
gitgitgadget


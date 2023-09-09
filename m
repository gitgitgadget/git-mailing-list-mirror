Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE69CEE3EC0
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 16:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjIIQZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 12:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjIIPuC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 11:50:02 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5C913D
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 08:49:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31aeedbb264so3142667f8f.0
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694274594; x=1694879394; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I8cslM4JaRejsBQioRVUZ1Pk8aEfSBH808nthvCk7Ts=;
        b=XWwy/G6KIIhHGwoUJb1A5po3OSOS/Am1s7rhlXMZbH8hEbv2lk57fDkaaRiCSPYZ9/
         SghUoUDedTS/461XTAM2uLvtA0GagzuEFMpuox5nfmbrCgP8LkuN8327EtV/wLnxVKXz
         MVYjEBSQ93yB3JLPdZ/47cGy//mfXF4YE0CpJn27Lgn5BvrT17jOPj+NPf5l06CGshwb
         G5dLbPoScBea8QmOUHk+HhOsNGqt661Drri3gLd+d8y3GQ/Hk2h8wzN7n00aHRwbVWeT
         KPdX3wB04dh1Xh79zh1ZDEAhBes1vormCPaITVG/lH27TfmFQxBGpSgiKd5tUW61D/Ea
         Li3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694274594; x=1694879394;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8cslM4JaRejsBQioRVUZ1Pk8aEfSBH808nthvCk7Ts=;
        b=XgzDOYiy99L5+ltcp2c0bySsk0mEPdrY0HoZg2b8BY7E2L3OK/exvdiFcSmOUKHAPZ
         +AY7ZI74U8olCUsWXbTN7V3kx8f6UPRXbn4aeRWbTMM+RujIqdhH+/Pj9LdJ7EtpefEG
         e2JRC65Yv0Z2HJW2cIw2sGJXz8EuFt/557la7K4NAPWqXmayRLNbwU6NXcpE0l+dugAs
         TQ66I1fRWNdYOmD8nalYI1/gTMrFBjywJPPqkgcaQYtCtb5hwnSisRLgP5TRl74ehMSJ
         ivRpVMdltt8R0SGsQoMkRY4Bv3Y70b78dzYeetNEbMy0RR1s7y/5IgrYfBWt3mM0vkhe
         E9IA==
X-Gm-Message-State: AOJu0YwVvyC8AsWsMBy23rxgGhXzHg0AarUUoqQjIXYhSmAX4NyIoiSH
        UdKkNTkOF5yiIJC6XIhJWocjYsoapw4=
X-Google-Smtp-Source: AGHT+IETS5ii+Y3wHNJcQCoDOOXOm01kwP73ymWfe5T9Z01EKjse2MyTotvFZOEffIN5WGNhljrbhw==
X-Received: by 2002:a5d:674a:0:b0:314:748:d59d with SMTP id l10-20020a5d674a000000b003140748d59dmr4566090wrw.27.1694274593936;
        Sat, 09 Sep 2023 08:49:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q8-20020adfea08000000b0031f2dea4810sm5098729wrm.61.2023.09.09.08.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 08:49:53 -0700 (PDT)
Message-ID: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Sep 2023 15:49:52 +0000
Subject: [PATCH] completion: improve doc for complex aliases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Steffen Prohaska <prohaska@zib.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The completion code can be told to use a particular completion for
aliases that shell out by using ': git <cmd> ;' as the first command of
the alias. This only works if <cmd> and the semicolon are separated by a
space. The examples have that space but it's not clear if it's just for
style or if it's mandatory.

Explicitely mention it.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    completion: improve doc for complex aliases
    
    The completion code can be told to use a particular completion for
    aliases that shell out by using ': git ;' as the first command of the
    alias. This only works if and the semicolon are separated by a space.
    The examples have that space but it's not clear if it's just for style
    or if it's mandatory.
    
    Explicitely mention it.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1585%2Fphil-blain%2Fcompletion-shell-aliases-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1585/phil-blain/completion-shell-aliases-doc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1585

 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index dc95c34cc85..659df570496 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -28,6 +28,7 @@
 # completion style.  For example '!f() { : git commit ; ... }; f' will
 # tell the completion to use commit completion.  This also works with aliases
 # of form "!sh -c '...'".  For example, "!sh -c ': git commit ; ... '".
+# Be sure to add a space between the command name and the ';'.
 #
 # If you have a command that is not part of git, but you would still
 # like completion, you can use __git_complete:

base-commit: 23c56f7bd5f1667f8b793d796bf30e39545920f6
-- 
gitgitgadget

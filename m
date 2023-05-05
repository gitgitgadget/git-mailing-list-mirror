Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA5C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 10:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjEEKck (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 06:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEEKci (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 06:32:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100CC16094
        for <git@vger.kernel.org>; Fri,  5 May 2023 03:32:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-306f9df5269so1066060f8f.3
        for <git@vger.kernel.org>; Fri, 05 May 2023 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683282755; x=1685874755;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0eQRcfAgqujrTbX8IPOoTKfZFmRW5+Iy9NNP/M5RFeE=;
        b=KHchXqDo/gmIbglH0obiFFFphkWvXZZQ21Xyej1j89jMStXNC+5sAE95TfM/F7/N38
         FaLVOh3Kacqbp0QHV2a7WiBR/EnxuPmCHF0y3Ci5zTmlQCfcb0GZ0uZnSV2t0bZeSj3j
         1iFBGFWWj34lf2IFxjiqbZ9aiXTMJ84lZSwCCgrOZ8Vpw8KZVMr+Ao8S7uBygLpSl9vb
         K6SI7xPBB9/IWwalXzLjYJLS43kf9Pd2thfh90A40TBE0v65SMdkUbhJlDwPZi9lAkre
         Ttqmen2PpnogFCu3kz7XiRHBMc+Npmjnl5RhEGC1b7E9hhWnpuyQo4IP433Tb98Crk6Z
         D6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683282755; x=1685874755;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0eQRcfAgqujrTbX8IPOoTKfZFmRW5+Iy9NNP/M5RFeE=;
        b=HH7YaU3O2H0IBAFCSnhl8ryvyu1NifMP3CGOESIVNn0cdQEKgPAF2va6nBfH+ODWwv
         nisViNMy+n2Vp+3ZLykdcHl7zh0T4tJMgx9jJSXRUDnSIZgMDbKdS+7IiN/+d4lH1FZH
         V1BN/6Va5tXoUWU0MStqM/v99D/8lp58wj0bkFq0mOrOi3pVdqHMAHJ7TzsB0QCPHmzY
         tFc0Yu/zPx93e5XQlEe+OP1qEK8+J4zoHMDgXh42DWZdBe/k96kWnV4P8vLDEaJe80Hv
         Dz8vX7q8un4O79uskOg71Ex7qhVf29koIvnzDwqs3hpEQYtbiOPNtH5E2mjyj5ByFpXY
         rZLw==
X-Gm-Message-State: AC+VfDy3Ffn+uQMM8tND27+Boo7oQy9MF0+tY/1jkvoE7tdmdvYyfyhB
        HEno+gqMuXXeMfhaqv31Wy7AffKfpww=
X-Google-Smtp-Source: ACHHUZ5I49e5h7mz4n4VetNR87qWENMAO3CwIA0+AEEwfQ7d5CDFvCRygP3ZGt/lGYXzggou/J/tfw==
X-Received: by 2002:adf:f706:0:b0:306:2a46:4b11 with SMTP id r6-20020adff706000000b003062a464b11mr1011704wrp.43.1683282755135;
        Fri, 05 May 2023 03:32:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d460e000000b003047ae72b14sm1963607wrq.82.2023.05.05.03.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 03:32:34 -0700 (PDT)
Message-Id: <pull.1504.git.git.1683282753768.gitgitgadget@gmail.com>
From:   "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 May 2023 10:32:33 +0000
Subject: [PATCH] doc: restore: remove note on --patch w/ pathspecs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Adam Johnson <me@adamj.eu>, Adam Johnson <me@adamj.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Adam Johnson <me@adamj.eu>

This note was added with the command in 46e91b663b (checkout: split part of
it to new command 'restore', 2019-04-25), but it is now inaccurate. The
underlying builtin `add -i` implementation, made default in 0527ccb1b5 (add
-i: default to the built-in implementation, 2021-11-30), supports pathspecs,
so `git restore -p <pathspec>...` has worked for all users since then. I
bisected to verify this was the commit that added support.

Signed-off-by: Adam Johnson <me@adamj.eu>
---
    doc: restore: remove note on --patch w/ pathspecs
    
    This note was added with the command in 46e91b663b, but it is now
    inaccurate. The underlying builtin add -i implementation, made default
    in 0527ccb1b5, does support pathspecs, so git restore -p <pathspec>...
    has worked for all users since then. I bisected to verify this.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1504%2Fadamchainz%2Faj%2Fgit-restore-patch-docs-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1504/adamchainz/aj/git-restore-patch-docs-fix-v1
Pull-Request: https://github.com/git/git/pull/1504

 Documentation/git-restore.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 5964810caa4..d31a06a673e 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -51,9 +51,6 @@ leave out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 	restore source and the restore location. See the ``Interactive
 	Mode'' section of linkgit:git-add[1] to learn how to operate
 	the `--patch` mode.
-+
-Note that `--patch` can accept no pathspec and will prompt to restore
-all modified paths.
 
 -W::
 --worktree::

base-commit: f285f68a132109c234d93490671c00218066ace9
-- 
gitgitgadget

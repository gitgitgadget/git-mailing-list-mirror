Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69BAC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 19:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353693AbiBCTIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiBCTIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 14:08:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B34C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 11:08:09 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f80-20020a1c1f53000000b0035399b8bedcso7574914wmf.0
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=ENGtoRjoWZMSy/FovuTm6TI7CmmglboBUlDXA8WZ/Io=;
        b=MF5RZ0iXTIKu9R+oqhSgMwTfDMf0CVtVVCkiipt6y0cmgz88xK7fWLzsCtcDD6SG1U
         f3IyRi7K1AOwGE67dVWGL8iEfe5vyPcTaeC/4/Wr+xIPKu9KQ3IR4d4w6kPZfgk1JEsX
         wFEUODKlfo+vAc5t3/e9gRbysVIRTJJquLlxs2PCRd0hG+oHU4rnealXfqFxwi4cpfJl
         bHhk6P4JpQ7D0Kb5Vb6uhAnyul8Ez1JpwBWfQX6TXzNimSULwBTd6zDMcz7Gw9uErpL6
         L+KTi6gQx8OtE4b0bSik0MWzG8T95ZimigOsmA9Fc2Q4MAU+cfenIPK0EEkqenOatHtN
         4/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ENGtoRjoWZMSy/FovuTm6TI7CmmglboBUlDXA8WZ/Io=;
        b=4qKZER8Htly1KRwNUx8mC13+seLJ0EVWdQGaz3OMC7z320haO+iwcFclRl9w3D+lnx
         BWPybm357QBb0YoLJkNno000cW0WD1+uoFWGY/tLOxXSaIh80S+X7JOsZv1Qwk+C1i8N
         LGpo+92BmDtzVcR3ssFbhjx1IYEQLFopw4asJI5s8rSy2S1A5FvHDaNDqqc7+JcDetaO
         ep4Fs4iwoz2wtEKZjaCsl3Zb6GabawNBiQl/GO/ZZYY6HP1e8RttFE+I11fTtyZV1zA5
         pa5BwF4JCW5HLkqsLbIcBgaVh3cogk/FyVB0WxRFF51vO6xwrqqYfmStjTq5oEfQ1i+/
         DEMQ==
X-Gm-Message-State: AOAM531kvAkxRa3HHxUohk8eB4AXWXDNUajWtKceLt1BIoAMQ4vOM3d8
        kuUibOQR/eIP45NEyW08FRRv+5z28CM=
X-Google-Smtp-Source: ABdhPJytW3u22OYk1mhLVRc5QiyOxMoTTat8jdO0H/PaxCXRO4i5knG/qfjlIgiv1UtVB4ChX62JpQ==
X-Received: by 2002:a05:600c:3b25:: with SMTP id m37mr11416601wms.40.1643915287371;
        Thu, 03 Feb 2022 11:08:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a24sm7701897wmm.31.2022.02.03.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 11:08:06 -0800 (PST)
Message-Id: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Feb 2022 19:08:04 +0000
Subject: [PATCH 0/2] Add cat-file --batch-command flag
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The feature proposal of adding a command interface to cat-file was first
discussed in [A]. In [B], Taylor expressed the need for a fuller proposal
before moving forward with a new flag. An RFC was created [C] and the idea
was discussed more thoroughly, and overall it seemed like it was headed in
the right direction.

This patch series consolidates the feedback from these different threads.

The latest change since [C] was replacing the flush command with a series of
commands to allow a read "session", so we can queue up a bunch of objects
and then get either their info or contents, then end by flushing. This is to
address Phillip's concern about deadlocks if we allow the caller to call
flush whenever they want.

This patch series has two parts:

 1. preparation patch to rename a variable
 2. logic to handle --batch-command flag, and adding different commands

A. https://lore.kernel.org/git/xmqqk0hitnkc.fsf@gitster.g/ B.
https://lore.kernel.org/git/YehomwNiIs0l83W7@nand.local/ C.
https://lore.kernel.org/git/e75ba9ea-fdda-6e9f-4dd6-24190117d93b@gmail.com/

John Cai (2):
  cat-file.c: rename cmdmode to mode
  catfile.c: add --batch-command mode

 Documentation/git-cat-file.txt |  27 +++++
 builtin/cat-file.c             | 203 +++++++++++++++++++++++++++++----
 t/t1006-cat-file.sh            |  46 +++++++-
 3 files changed, 251 insertions(+), 25 deletions(-)


base-commit: 5d01301f2b865aa8dba1654d3f447ce9d21db0b5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1212%2Fjohn-cai%2Fjc-cat-file-batch-command-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1212/john-cai/jc-cat-file-batch-command-v1
Pull-Request: https://github.com/git/git/pull/1212
-- 
gitgitgadget

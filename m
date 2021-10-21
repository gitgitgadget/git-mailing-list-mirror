Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C43C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552EB611CE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhJUP77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUP76 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 11:59:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26053C061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o24so195916wms.0
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1y1zUVzwfoFKvEqDBZXGx7Ml6FvAHUW2mHgjU2uUIJY=;
        b=RBhtfwSBerviIDewcy/DUY5fhQ+6CmBc8+gACvaJKsBVk5QcjQ2eFXLY3urnJFawG3
         81XxaJfc3mc7eiNnQdCdm52r4Tu+wuBmL9pexmy8psoV4QvCsLVh+cH74in8Xzj/Qy7f
         vJVI6lSfBtxj2pP0STpYOvCAVogN60ZK2hdJjvAucChK0fd7VVZgDUxAID76Uws5RYNu
         qGpse+PwZFfbmKVc+EF2n4+vV8dUukx82bLJM/mdLGDSa1FjfP5NMcKQBdj//n/DRs/6
         LP6bUqGY1i+MyeIcUoJFdPpGNeStILXHHZ7Z1SJOz69J1jG9e/M+zyjWkJ9CXvQCFbfy
         B3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1y1zUVzwfoFKvEqDBZXGx7Ml6FvAHUW2mHgjU2uUIJY=;
        b=RdOUSY/7aQtPl+tO1GvX96zRPSGMp+b6r90s3A9+sYSdkXAYfq1B6gYk4YxtFQ81tj
         8//3qN6nYFqmMbZt/Dfj0c4OObc3ssW8NDXjJ6LXrOBs71E60JsTpBDy+04aSD1bEqIe
         ppliyqy/2mPQyAOYBkYEYqoKS3CTMVnhnmTKM09TMLp9JsoUym1Zo+wRA10w+hajHlJx
         /xwZpMtyC/PlScbL9IDLZf5OAYhHQaerikedZc87pFT+a5loYIicz/VUefvbdv+sXm42
         uupYmrznK2pqvBqjXSGJLni3BzG0n1oc4v65mEOWvviS8LuycjxU2fHQyNrAkVXTft0C
         z+wg==
X-Gm-Message-State: AOAM5329FXd9B4FaH+o9UuN39JJNMPSxH19Z1/UTlp62EGDTjZ2xEEXB
        a1Is8zuKTVl4uxHBxvl+8kyMnIciUJYihw==
X-Google-Smtp-Source: ABdhPJycXbngQsXPpAQSFmvHdDXhjx/CibnGeS810LZx2tPZIOjZGuC66XvvFx2UX/N0t4eRDOghoQ==
X-Received: by 2002:a1c:4b05:: with SMTP id y5mr7650354wma.106.1634831860242;
        Thu, 21 Oct 2021 08:57:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm7082259wmp.1.2021.10.21.08.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:57:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/6] leaks: miscellaneous small leak fixes
Date:   Thu, 21 Oct 2021 17:57:31 +0200
Message-Id: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few small miscellaneous memory leak fixes. I'm currently waiting on
the other in-flight leak fixes I've got to mark more tests as passing
under SANITIZE=leak, these fixes don't make any tests pass by
themselves, but in combination with later fixes I've got planned will
make some tests scripts pass completely.

Ævar Arnfjörð Bjarmason (6):
  grep: prefer "struct grep_opt" over its "void *"
  grep: use object_array_clear() in cmd_grep()
  clone: fix a memory leak of the "git_dir" variable
  submodule--helper: fix small memory leaks
  reflog: free() ref given to us by dwim_log()
  repack: stop leaking a "struct child_process"

 builtin/clone.c             | 4 +++-
 builtin/grep.c              | 5 +++--
 builtin/reflog.c            | 1 +
 builtin/repack.c            | 4 +++-
 builtin/submodule--helper.c | 2 ++
 5 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.33.1.1494.g88b39a443e1


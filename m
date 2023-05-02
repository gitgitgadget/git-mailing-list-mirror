Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE70C77B75
	for <git@archiver.kernel.org>; Tue,  2 May 2023 21:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjEBVPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 17:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEBVPI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 17:15:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0941E1BD3
        for <git@vger.kernel.org>; Tue,  2 May 2023 14:15:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-559c416b024so47346887b3.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 14:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683062102; x=1685654102;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B6aUr7zmBmjKHe6dKDr2cjwOUKCVF/pL+viAG7E7O7M=;
        b=mkWY9TN1MKETsG4KHmOXuEMnh6vWJNnpb2q2K0hAlMavRvaCR+wWMJXAMQXq7OBtF5
         j8Z6iL+p+t6CbjcVUj8s5Qu7yER26fvoMzYErr0wfhpsvLbvTXfOM/wp2VbHFnz556zF
         oCB/2EM/gQGmJRDMtUL5nP20Hy3QfXivu5lTdk59Y5IheeyHYOXi+UMgx/Z4M3DQntfR
         LPTu5lA36zF3kTPt8Jre2A60qk7u2TXjFgFI3zXkjRXtfuwcSEKjwiidyyjWFkSEgoxY
         HNl+gBASx/MYUlooZbjsvkcggGcAduadnXEhJcOcIv6ZCuTXib0j4GzIPda8wG5mMoNk
         o1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062102; x=1685654102;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6aUr7zmBmjKHe6dKDr2cjwOUKCVF/pL+viAG7E7O7M=;
        b=S3m9iuZp51tyHrUMYmbJ4ktnf+TFCWOQM+7eGW85j2I0xJjTn6rKRCSDr5fY9tHJWN
         xJEx7TfocC8ecWwneXg4hYfRW1KfdbEH2oaerhW2VJ58vAmJ7ABFHnKKPm4qKoxAnk3G
         dZf+Yvnf2d26RgTzI8Hn4zFPAGfj092VmXVzwspPP2W7wTAa9uFFyUqUHrLaOa69BSEF
         PS8BhIfsnyOfUF53PK6xoOfjkxAmX1dJCDVToW0E0heaskTvldDlXLCJBqCW0KFhqvRd
         5WoXYq/KofZB4gz8p4XV2b9c0S9w6PLLHi6rIFI0jIQW/GgoUHbJAhmSRzdSfJABodYl
         r1iw==
X-Gm-Message-State: AC+VfDy+3LEcAbpFuMCMjFIL/NVoLpCn7nEZJNLI6ACOsK6icFPqY6z4
        8WCrw70ija3RGgvt+ilkgdH6/vp5ezPBg6NE9EJDeChgwUCOZOWx8h5fgvhpss2VZvLpraRAW0f
        WTxAwG83eXFhKB6y2tCG4VLlasTBKv8qDXXg6IGcDAv+2eDyAyqkwyf5S5XIUNDIlIw==
X-Google-Smtp-Source: ACHHUZ6ijADGBiiR5N7JqY1BS3ecLMVFZFMRSv8JVbtzjJE0z/ZOeBlGtxNtEXApDlqZKQv2v8PGfp1EbnvLRBo=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:ae0b:0:b0:55a:5a86:7b70 with SMTP id
 m11-20020a81ae0b000000b0055a5a867b70mr4431158ywh.4.1683062102167; Tue, 02 May
 2023 14:15:02 -0700 (PDT)
Date:   Tue,  2 May 2023 21:14:48 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502211454.1673000-1-calvinwan@google.com>
Subject: [PATCH 0/6] strbuf cleanups
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Strbuf is a basic structure that should function as a low-level library
due to how generic it is. Over time certain functions inside of
strbuf.[ch] have been added with dependencies to higher level objects
and functions. This series cleans up some of those higher level
dependencies by moving the offending functions to the files they
interact with. With the goal of eventually being able to stand up strbuf
as a libary, this series also removes the use of environment variables
from strbuf.

Calvin Wan (6):
  abspath: move related functions to abspath
  credential-store: move related functions to credential-store file
  object-name: move related functions to object-name
  path: move related function to path
  strbuf: clarify dependency
  strbuf: remove environment variables

 abspath.c                  |  36 +++++++++++++
 abspath.h                  |  21 ++++++++
 add-patch.c                |  12 +++--
 builtin/am.c               |   2 +-
 builtin/branch.c           |   4 +-
 builtin/commit.c           |   2 +-
 builtin/credential-store.c |  19 +++++++
 builtin/merge.c            |  10 ++--
 builtin/notes.c            |  16 +++---
 builtin/rebase.c           |   2 +-
 builtin/stripspace.c       |   6 ++-
 builtin/tag.c              |   9 ++--
 fmt-merge-msg.c            |   9 ++--
 gpg-interface.c            |   5 +-
 hook.c                     |   1 +
 object-name.c              |  15 ++++++
 object-name.h              |   9 ++++
 path.c                     |  20 +++++++
 path.h                     |   5 ++
 pretty.c                   |   1 +
 rebase-interactive.c       |  15 +++---
 sequencer.c                |  24 +++++----
 strbuf.c                   | 106 +++----------------------------------
 strbuf.h                   |  44 ++-------------
 tempfile.c                 |   1 +
 wt-status.c                |   6 +--
 26 files changed, 213 insertions(+), 187 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog


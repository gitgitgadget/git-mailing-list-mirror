Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF6BC432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FFE2082F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6TjaYi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfKZBbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:31:05 -0500
Received: from mail-yb1-f202.google.com ([209.85.219.202]:51565 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBbF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:31:05 -0500
Received: by mail-yb1-f202.google.com with SMTP id u39so11803240ybi.18
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DBgcYwW2msCLc6bt0wyyUNiC2LVW2wqqCDasF/778oE=;
        b=f6TjaYi2CTrQXkx4m9NySvbRWyIGS3TFRmPtX3EjTDfWCaw/T0VQojc9ynPehaPlNH
         FUSxcGMKOTqke0wshbG+FMaXWhUBj+09pzBmEySg3XIQnou/+GslUnydtSPuCvJgVr0V
         kQCG2uexrr2hPRIYr61fDCfp71dHgQOswjFZFBnGvSgm2PlN9SJUGKOyD8eMyrXx4vHs
         l3mB8aSNYgd8PHLn0ebEv7tu+tkpLyczknPZ+//ww6RL/WE50JKTCXqZ+vNhKjlWg1Ee
         xeI2DgQCFrBk2Dyw12mnZLVVgXZjAwmIkjAYICh/78SitFnWSB1ZfxHi/9Gwa79H1stR
         iTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DBgcYwW2msCLc6bt0wyyUNiC2LVW2wqqCDasF/778oE=;
        b=twmh4X/YPt/GGq2qIMYxLDEupzXTfF7GeVIFMtFZj8awsWGiSOArRqDMSOfR4vG1ID
         kh/nP78dnKt6T8FtAZ340E28a+I5lF1mnLeXjsgFSC0J/yKFLKw4PYPfFR1gfGzPCVgy
         zLxVZcTsdII6KL/M2FP10MpMNpnuxwFHLEVJ8/2laqOIAw6vRmt2Oi71juI+4gR1FlZh
         fmbfjXGdZcQOkLrDx3G7ctKhib61RcYtBXmZTq5CA1jkb9TzzkTkRZR9VxRJQxiOut0r
         uYssISNHGKFJd+DnKdosQAErNbLBQgR82LIPayhB+8bx3i3EQTe4RWpuBDvEKpGaK+GL
         4awg==
X-Gm-Message-State: APjAAAXPCbaDUZtMtYJ55wb3BP69bvYSwiX9otVR99EpfIyn1KpLTctG
        7ofE/ruGLzPbtaVIB++ICUkD8TJJbLlhuAdr3+r4mpQ2d6Wi6mVHSxoIB2ajZIgQC379m5PCq4o
        7Iaabov1bdsyDqkTvm5BUyXVj1XwsCwwq286Dx8T20W8FQoS0csJF/xOAJZX016pBlFfOWC0rvY
        8f
X-Google-Smtp-Source: APXvYqytO/EoItaUv+5ykOgYN9ectu1mSesQzyu1jXV1eGznKFBXbQ5Rac5cY+k98NALhOSxYN6/W4pbUM1TLaVK5NPR
X-Received: by 2002:a25:8587:: with SMTP id x7mr26712072ybk.55.1574731864408;
 Mon, 25 Nov 2019 17:31:04 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:30:58 -0800
Message-Id: <cover.1574731649.git.jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH 0/2] Advice upon clone --recurse-submodules --reference
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set came about because of a situation in $DAY_JOB described
in the commit message of patch 2. I found the existing documentation and
error messages unclear, so I have improved them.

Jonathan Tan (2):
  Doc: explain submodule.alternateErrorStrategy
  submodule--helper: advise on fatal alternate error

 Documentation/config/advice.txt    |  3 +++
 Documentation/config/submodule.txt |  4 +++-
 advice.c                           |  2 ++
 advice.h                           |  1 +
 builtin/submodule--helper.c        | 10 ++++++++++
 5 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.24.0.432.g9d3f5f5b63-goog


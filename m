Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04218C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 14:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA33520715
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 14:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyAkq0My"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKVOlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:41:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40536 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKVOlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 09:41:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id y5so7859748wmi.5
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 06:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FcSEEBsJPGWx5oL5TsWimFEQZHkx0yqzL54wvxfqq0o=;
        b=HyAkq0Myf1bhUvqk8ZBupbg5dxev3feWrIgKAn+xNZmfO54g683VL1iSmaTJoPsa2o
         8r3PXphr+hRPiybpYb5joB25txlFO5y/JlpO1NzWGNYQtBF82ClhBy1Q0sWtQ4kRiI7a
         F3srXzeNJEMZ6FuLPgiEKgND/VgwkTHs64DOkhWmxuSnaKQvAaQJSByPgfAAi4DAIurS
         FZVIK+gLT0UQa1/kT5FxwzNRT/hkicLy3Lfy32CgBM+h81OgvdLPniAOaU0OvlpfjFwJ
         hueHWpIkMUvTAHYZJtCww+KOzdsq9Z92keOp03KUSRum5JRFe0CttfYz7JkuF4AFbfHH
         A4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FcSEEBsJPGWx5oL5TsWimFEQZHkx0yqzL54wvxfqq0o=;
        b=hTFgs9O+e5IM5hiPV0lbHiniaLGfT/35pphsl0Zp0bB+dSwU0MUkI+EnhjodzKYGml
         PqoR6odeCRRJqLtVb23keTbwYvPi7vNcllEEdMWIZeYi/NT0tOG9HtJ7O/j0c6x/oXkS
         kmUF+/r5BwlMpxoLvz3WH/NuCOiDrNnCBzHAMxp37HdX/udH1KVjw3KrNNbAW+iv/D3l
         itqWam3Ww9GUSVHdaVHfoVuM2visMZgnSLjyT2dRjeaZwyFvpmTyBLw9MnIj0i+Du5ZN
         mmvjmrICrIuDFf8Mmet9K2QjX4a7AMnW1dSiLk2HMoacEpDqmNd4MxTZV9t2nG2rtI1K
         vhUQ==
X-Gm-Message-State: APjAAAX0AV3jEO5ecZaBqgkkD+5JKXujmf3vjImWh0QEpRw4AgShhgjk
        LQIoesArsEsRmRFGmkoOfHK1JrmL
X-Google-Smtp-Source: APXvYqyD3rPiwue58BvYlO5OMkoXtzjfmdDfeMTwUFB/s37GQ4jskTHT2G7AlneJFeBnOz8kV0xHbQ==
X-Received: by 2002:a7b:c207:: with SMTP id x7mr12111415wmi.40.1574433666896;
        Fri, 22 Nov 2019 06:41:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm8093476wrj.80.2019.11.22.06.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 06:41:06 -0800 (PST)
Message-Id: <pull.670.git.git.1574433665.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 14:41:01 +0000
Subject: [PATCH 0/4] On Windows, limit which file handles are inherited by spawned child
 processes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is yet another of those patch series that matured in Git for Windows
for over a year before being "upstreamed".

The problem to be solved: files cannot be deleted on Windows when even one
process has an open file handle to it. So when a process opens a temporary
file, then spawns a child process that inherits that file handle by mistake,
and then the parent process tries to delete the temporary file while the
child process is still running, the deletion will fail. (This description is
slightly simplified, see the commit message "spawned processes need to
inherit only standard handles" for more detail.)

Technically, we might want to squash "restrict file handle inheritance only
on Windows 7 and later" into "spawned processes need to inherit only
standard handles", but while preparing this patch series, I found the story
easier to follow with them still being separate.

The real reason why I submit this now is that I needed some ready-to-submit
patch series as an excuse to test GitGitGadget on https://github.com/git/git
.

Johannes Schindelin (4):
  mingw: demonstrate that all file handles are inherited by child
    processes
  mingw: work around incorrect standard handles
  mingw: spawned processes need to inherit only standard handles
  mingw: restrict file handle inheritance only on Windows 7 and later

 Documentation/config/core.txt |   6 ++
 compat/mingw.c                | 140 +++++++++++++++++++++++++++++++---
 compat/winansi.c              |  12 ++-
 t/helper/test-run-command.c   |  44 +++++++++++
 t/t0061-run-command.sh        |   4 +
 5 files changed, 194 insertions(+), 12 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-670%2Fdscho%2Finherit-only-stdhandles-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-670/dscho/inherit-only-stdhandles-v1
Pull-Request: https://github.com/git/git/pull/670
-- 
gitgitgadget

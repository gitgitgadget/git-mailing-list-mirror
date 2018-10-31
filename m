Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B61711F453
	for <e@80x24.org>; Wed, 31 Oct 2018 21:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbeKAGLX (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 02:11:23 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37675 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKAGLX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 02:11:23 -0400
Received: by mail-pg1-f180.google.com with SMTP id c10-v6so7965590pgq.4
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BS00OTgRKvYLhim6hQ/WbwnEI+O/gwDoquvxQOKtJXw=;
        b=H/kymZruWKhiLlERvA4boscwMuK/bRolpCI9Q97adaKQWaH/A7kn3jll87s+nomweE
         NL5Q5/wxQFDJP3mL2kVB5h+ZcxHS4kbpX4DBY0F00SFaPfitjH5EtkVKypRanK48zvr4
         HFJU9f93Evh9QrqANNJe7yo4zfm5pXdS978nef9FPugKSiRvyqarhw7Q/mXCf9SVeD0s
         dAETE1YYBxUInpSYWR2Ur96gaHaykYIH/+UCDLyGulvqC9Vx+i7IT/8bK6uAuk7ipSXW
         sPFVZkr/aQNyGHjYJqzRcGKP9/PjtysTMz0v75+s6K65ZJ+DUimLy/tUrTseXUcmfvuJ
         fMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BS00OTgRKvYLhim6hQ/WbwnEI+O/gwDoquvxQOKtJXw=;
        b=Vz3LXxc/D+Znf75VvmMjVI2e22d/wFL1Qpk1iK0pBPJqMjJc9m8RBLQhxKFUFcD8oD
         JVGMbxfQ4lc0JKmtQmZMkPd9bzNHSWWw3GmCmUVao6iA/kHX9kq66OL4BvTF3WDwzN/J
         RLLAcQtoUuaN6nun3Fs9b32aafTHMxzi10yJaFCOwIxDrFSrKEC2Q2X98UnI3CywUl/j
         VbOoxwPFoB61ojresJ4K5HzxYk0xyeUjDeQMrNRcNHg9jZO4x5AaYvEnF2x1Fu3E/5B4
         TRLxPR3f+GsyXvyANlIjK3CChL4QMD3luzO4sEQMtOojJUM2vN4EX2EhD/faPHmo8n5p
         O6Uw==
X-Gm-Message-State: AGRZ1gJXWYkmb7yKpb/p9YBFlgBcqPOF2QxUmtxYKZw6FKud/UubHGqJ
        K9pdDCEDzhEiwLi1PMd7q6q35MqB
X-Google-Smtp-Source: AJdET5d8+JkDkovdbi43XOwcLZhpN4BGVUmJyII/9CmNiu8a19MnLysV+vbcfV0l9bFdzaX+0W+S+g==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr4484824pgk.406.1541020296159;
        Wed, 31 Oct 2018 14:11:36 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id l16-v6sm41291771pfb.75.2018.10.31.14.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 14:11:35 -0700 (PDT)
Date:   Wed, 31 Oct 2018 14:11:35 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Oct 2018 21:11:32 GMT
Message-Id: <pull.64.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Make compat/poll safer on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is yet another piece from the Git for Windows cake. It avoids a
wrap-around in the poll emulation on Windows that occurs every 49 days.

Steve Hoelzer (1):
  poll: use GetTickCount64() to avoid wrap-around issues

 compat/poll/poll.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)


base-commit: 4ede3d42dfb57f9a41ac96a1f216c62eb7566cc2
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-64%2Fdscho%2Fmingw-safer-compat-poll-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-64/dscho/mingw-safer-compat-poll-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/64
-- 
gitgitgadget

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F0C04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjHJQfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHJQfE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:35:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914A49C
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:35:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31783d02093so1032355f8f.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691685301; x=1692290101;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H6j8qWk8NdXv3xxE+a4bIqrKUF56yLPXTsKZrKYVBSE=;
        b=qH8Ej6nPBEjUVGK+CeqdLjD69Sp5KZhB6hqV1XHlbN/Xci9pl1ZZtwoX8PG7PQl7Cy
         aylWCL3AkU0Fh3RGILLN7lYhbkANAja/+VHRlhPKiwyI9qEHka1FAGOiJ4g91AjjBXan
         22x5nQ2z735Nbv0lcCQm9YUHdOrlCvUYexSzEb8fTvN08lLl77QF2Nw5MnBDtx5I38mZ
         t8hBe6aznwO/egz4u8vO/Up6WjjTsibFa8GoVs+fRcs5ubR91zVQiRq+X+fMygbON+xd
         7RIRQ/GKCw9+bnc3JoTF6S8Uyd+a9P3s3Yb2cA6Cz9J2CjTsHLwDBfTQgah/4+pA7AJt
         zEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685301; x=1692290101;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6j8qWk8NdXv3xxE+a4bIqrKUF56yLPXTsKZrKYVBSE=;
        b=dY1ySBDsnUW8F62b8zHjWuntIectg0Tp3TUfuAzsM5ssPdS9UV9HQT3yXD/ZZ+WoGm
         Zx7kvne+4jssn3V8MnofqBQv/cMdZmvQRRF15jb0QWD3ArnS4fQtaMFHoA4KsEXtve8c
         RhpwiFDXyodoCZh0lmYBOXzM9uZl6o5V6LK2UrRfmyD/InchYw04tc2sRDBC1fgYASqr
         Y3HeLLCM9bU3g+r3bkMm02/vS35Vdo3elPgB6b+YcHRWXZ908o2f0hU2In1PpTpqDZFl
         89ki/P2dLwAVjYihE1VF/dkS8Y5NVx9yDmtrckbbh9sjuOwYVTSbrOkRWzy/ZqWLO+UG
         7frQ==
X-Gm-Message-State: AOJu0YzC9vI5fXanDEYuDRxlLyMJNJhrHIWVLFZSRYe51UrA9KBmjg5L
        jg9Smb0vjI70MftICQT2++sE6bdZANM=
X-Google-Smtp-Source: AGHT+IGCsm1mnv1M4Ofs8S7kot0zP0G1Cl9MT0qqEYDb2aGJQVfaJ6T74uBqEiS8I4DpRiYAdrpgNg==
X-Received: by 2002:a5d:4f8b:0:b0:318:8b5:4159 with SMTP id d11-20020a5d4f8b000000b0031808b54159mr2164043wru.24.1691685301463;
        Thu, 10 Aug 2023 09:35:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b003141f96ed36sm2707189wri.0.2023.08.10.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:35:01 -0700 (PDT)
Message-ID: <pull.1562.git.git.1691685300.gitgitgadget@gmail.com>
From:   "Mark Ruvald Pedersen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 16:34:58 +0000
Subject: [PATCH 0/2] sequencer: truncate lockfile and ref to NAME_MAX
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Mark Ruvald Pedersen <mped@oticon.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some commits may have unusually long subject lines, which can cause git
error out. Currently the sequencer and lockfile assumes these to be less
than NAME_MAX which is the maximum length of a filename (on Linux).

When reproduced one is met by the error message:

$ git rebase --continue
error: cannot lock ref 'refs/rewritten/SANITIZED-SUBJECT': Unable to create '.git/refs/rewritten/SANITIZED-SUBJECT.lock': File name too long


 * where SANITIZED-SUBJECT is very long

Affected repos can only be salvaged through filter-branch etc.

Johannes Schindelin (1):
  rebase: allow overriding the maximal length of the generated labels

Mark Ruvald Pedersen (1):
  sequencer: truncate labels to accommodate loose refs

 Documentation/config/rebase.txt |  6 +++++
 git-compat-util.h               |  4 +++
 sequencer.c                     | 47 ++++++++++++++++++++++++++++-----
 t/t3430-rebase-merges.sh        | 11 ++++++++
 4 files changed, 62 insertions(+), 6 deletions(-)


base-commit: a82fb66fed250e16d3010c75404503bea3f0ab61
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1562%2Fmped-oticon%2Fmped_bugfix_lockfile_maxname-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1562/mped-oticon/mped_bugfix_lockfile_maxname-v1
Pull-Request: https://github.com/git/git/pull/1562
-- 
gitgitgadget

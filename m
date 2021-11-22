Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A512C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 14:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbhKVOYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 09:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbhKVOYE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 09:24:04 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4E8C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 06:20:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so33016146wrr.8
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 06:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=X5NP56fzXDBBb8iBJGC7Bz7EYYGuLgyJL7L0WS0shFs=;
        b=B8Ym/S8MkJXqtwP8XyzBZX2IdzGYqABxNe0nYTguw5ShpzUHD530lGa+hmLj1i5XWP
         ZIcswB9xgoPQE3iDLjDDxNr/NeJYQmk2tP04pZx9VWqZKi4JZhJiUTzOtjkE+pKPyFo3
         sJcAFzr/W3SvGjmuo4IGJMwIR0fMOgKRnq+KndB+b71LsBgETKFFiAXw3117RPnkhwMa
         /fjJwX7b559m/cf1gpL9dz170PUANKzq/54xdJp2A5ZWSDTtzO+bSfIeDrHFkCG+ZmdI
         m4OW8CUSBvaPVYbHBy5mtGN8lViPwMdj2u9/vISJceKgJYE+v0PSOAUQ8YBxpfCGt8ja
         DKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=X5NP56fzXDBBb8iBJGC7Bz7EYYGuLgyJL7L0WS0shFs=;
        b=eL2+YWlXHA8MevKA0+ZWoCorhkE7Gs/QIOEykmJwKrZ6OQN905mHcWoNpU1lJwUD3H
         B3SxXVMmbLp0icmPse6Ow8CpxT+T7Q3kd7Kn0850jUBoe9zaZGM1uCjn7WUqAMwBOMqV
         mIYpo6wNo4FXv1QXiiH6hTj8x9UPvCEafuqQmzA2biUa6z0uGkXtJavMih4ej8NKlNs2
         bW2fkC76ldw3EH/N9xMH/pQSav3tTsRuAtudbQsXRdhdwUcocNMc9MS6p2UwLVba3Jbn
         yb0u8n82jk5haQPm1h1vSuhSuwEalPy60TKwc/V7KHYhVWObPMhgvV6GXe57oIzPVytd
         LKYw==
X-Gm-Message-State: AOAM532y4L9qu6wKkbFWF8522KhQ+igcJKB5Ndz9VKH2fbTM1McO5ozr
        Tm6OTelUptRUvP2+Xi8IW701F/fQUKw=
X-Google-Smtp-Source: ABdhPJzE1kncEr3BFfmZqm08zNAiNUqeURIo7iWfkZVXPnJBv/h9oMaPFEmv5snfa9ZEwn79w2nMmg==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr37685088wrt.327.1637590856032;
        Mon, 22 Nov 2021 06:20:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z11sm8987729wrt.58.2021.11.22.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:20:55 -0800 (PST)
Message-Id: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 14:20:51 +0000
Subject: [PATCH 0/4] Inspect reflog data programmatically in more tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This helps for reftable support, and will help if we want to reconsider
under which conditions reflogs get created/updated.

Han-Wen Nienhuys (4):
  show-branch: show reflog message
  refs: trim newline from reflog message
  test-ref-store: tweaks to for-each-reflog-ent format
  t1400: use test-helper ref-store to inspect reflog contents

 builtin/show-branch.c          |  7 ++-----
 reflog-walk.c                  |  6 ++----
 refs/files-backend.c           | 30 +++++++++++++++---------------
 t/helper/test-ref-store.c      |  5 ++---
 t/t1400-update-ref.sh          | 18 +++++++++++-------
 t/t1405-main-ref-store.sh      |  4 ++--
 t/t1406-submodule-ref-store.sh |  4 ++--
 t/t3202-show-branch.sh         | 15 +++++++++++++++
 8 files changed, 51 insertions(+), 38 deletions(-)


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1145%2Fhanwen%2Freflog-prelims-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1145/hanwen/reflog-prelims-v1
Pull-Request: https://github.com/git/git/pull/1145
-- 
gitgitgadget

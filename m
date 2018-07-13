Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DEC21F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 20:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbeGMUeZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 16:34:25 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38551 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbeGMUeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 16:34:25 -0400
Received: by mail-pf0-f196.google.com with SMTP id v15-v6so3219697pff.5
        for <git@vger.kernel.org>; Fri, 13 Jul 2018 13:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=whoWvevxUv/DFMxJQlHmT4vEKynQaBRdwSojf9DsUJ0=;
        b=jEk0ofoHSdNoAzfvAgGtffUoJaIdNxIYtLmf9vCNTXxyqoWvAW7bvmn8svk/BK9YB+
         rPtfQLJ9gcsw+EO/VdQHV0lLl0wS3DlQ7UiJDD/0vyP83oVAgZMbLlZd98b43YTNJ5hE
         22eiHC93i8k+EwLiNWoHjmuH5kCvkW3RUjqIg64Vg7wg9pqH6vai1v4MOqdR7ktWE/+a
         RjykhjVJQs5AK3agDTk72xct0V3qhLExT2+TOse+8gFdRhT+LnZ63T+TPt7Z1K0AzJhF
         MqLCcr6yCKtPo7YVWd5rHYia/Xxwg7rq8Ua6Y2v2iLJRh+WCXYt01+i0kBSpWGgofRUD
         v/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=whoWvevxUv/DFMxJQlHmT4vEKynQaBRdwSojf9DsUJ0=;
        b=Ipw7EV9gO2khQkzOieTirtnmynelov72onrMhVitiJ+lo+ecMWspcndDp5Tu6mx9mo
         VFH4dk8q0a/5LEltQmz5FS7I3qAoy6sfkPlFyP1uCMK8t0r9qNKVkGe5u3ncuxQMYbMO
         C4Cz5PdI4Db7MRoHV2whfxOaQ2hvLq8Mrxi80sTAp4l6fYAzVUB3SC4WQDCjregenj+U
         HI5lF133qLQrnAnICQHGa+UzfQ8FeLrDoyf8DbqEi6ERnEU2qgFXCmJwJleg+zHnr9JY
         hhRDn53Zw0f1t40TgsZoNCK2/qrdaJOM8k/zenrD8HsXPhsLGekZhzqGjlbrKx+gTvd2
         lvcA==
X-Gm-Message-State: AOUpUlGL9UZKjqvlZeAOjWI/FAnMpnyCDqc/oaaeLgwe5IGFbRz0F6qp
        xjMxW9xOnyYmYwbYGp3ToHx18w==
X-Google-Smtp-Source: AAOMgpffzhCBUOd1SQuUD2K2zS39huxSIw4LDosxR395qgmAQ8mh9aUZQrP0hbC8nsqOLJBGLbM91Q==
X-Received: by 2002:a62:e00a:: with SMTP id f10-v6mr8613030pfh.208.1531513095485;
        Fri, 13 Jul 2018 13:18:15 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id t14-v6sm4730694pgu.0.2018.07.13.13.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 13:18:14 -0700 (PDT)
Message-Id: <pull.9.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jul 2018 20:18:12 +0000
Subject: [PATCH 0/2] repack -ad: fix after `fetch --prune` in a shallow repository
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

Under certain circumstances, commits that were reachable can be made unreachable, e.g. via `git fetch --prune`. These commits might have been packed already, in which case `git repack -adlf` will just drop them without giving them the usual grace period before an eventual `git prune` (via `git gc`) prunes them.

This is a problem when the `shallow` file still lists them, which is the reason why `git prune` edits that file. And with the proposed changes, `git repack -ad` will now do the same.

Reported by Alejandro Pauly.

Johannes Schindelin (2):
  repack: point out a bug handling stale shallow info
  repack -ad: prune the list of shallow commits

 builtin/repack.c         |  4 ++++
 t/t5537-fetch-shallow.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)


base-commit: e3331758f12da22f4103eec7efe1b5304a9be5e9
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-9%2Fdscho%2Fshallow-and-fetch-prune-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-9/dscho/shallow-and-fetch-prune-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/9
-- 
gitgitgadget

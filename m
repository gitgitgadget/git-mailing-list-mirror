Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0D5C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32750206D8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 18:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yg0AK9jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLTSyA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:54:00 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38133 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfLTSx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 13:53:59 -0500
Received: by mail-wr1-f45.google.com with SMTP id y17so10420262wrh.5
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 10:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=0jKUboGhg2uc+suhWE0vGybB80utqNs42Ewu5WOXYVs=;
        b=Yg0AK9jnLDEl6PpE0pYtSkZe/0W+yKlQ9iKEvbN5mFEizdUNC7mfqHwE+kwiEagSfe
         oT3zkoSXU56LA9pTM4b1X1eZ5HwvOlTa8flUhc1rG6xOD982YX1NGLWRNtNdXwmQ0WEe
         xz1O6Tv70zfhodJrPvuPuuDdhoAmAoGXCFVEx6n1qqF46u8gC4Sl+1xcdeUIDk+xXuYg
         2bF5kgC19CJnfKHD8fNaDnxZI4H1nK9HLNBhCl+gJ9dWQ5l0IPN+ijusHwgOTYGyre3M
         f0DAqdyzMsuGmfOYPy3SCQYfZsTS108kNduJfeGTJyA2BZHu8BJol4hkMs2sgzsldbv3
         hfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0jKUboGhg2uc+suhWE0vGybB80utqNs42Ewu5WOXYVs=;
        b=VYZlbyEHp4OWEiifKrORg8DVNLUPz4B66+pNSXdv+u5VGZhouHm9Q4WZEvpiXj0R6K
         f4MNqzTY/+HWe1eNtnH/8zixxehGGWev7UCdqHjtsvqL7uldiRYnwd0KmHVkS+HZjSvR
         UvTp35YWQA2se69iMJyntNQWQNS6CO742iadG0qmtgdjXioVaDV9TbnRt1h5/4g88JoZ
         8sdBVnqxEyyhuq/toFl1yWYc1+Mw5Lu1umFGbrdL6rYPrr41Bm21pgwfJb2ZH6byv4jO
         7g5MBldQy9WZKPndwMx0crp8F077Y96xTZcYQ9YSrUNWgnfuhNlO0gqifa5HqN96B1Zi
         qILw==
X-Gm-Message-State: APjAAAUqWEI0hbXls8fr2yBYHBUVRNqGGQkiPPgkvb15haAZvs6br0w5
        kh7MR48SKfg/OFZKp6mUJm84a6nx
X-Google-Smtp-Source: APXvYqzcyctXfWdv1bRH+1DVsqBw3mp34tEy5yaxCNsZxl0xE1fj5yw4PKH65v8g3LG0IRVyG2l0WQ==
X-Received: by 2002:adf:e58d:: with SMTP id l13mr16071933wrm.135.1576868037328;
        Fri, 20 Dec 2019 10:53:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6sm10857554wrq.92.2019.12.20.10.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 10:53:56 -0800 (PST)
Message-Id: <pull.680.git.git.1576868036.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 18:53:54 +0000
Subject: [PATCH 0/2] Rebase am fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a pair of small bugs with am/rebase.

Elijah Newren (2):
  am: pay attention to user-defined context size
  rebase: fix saving of --signoff state for am-based rebases

 builtin/am.c     | 2 +-
 builtin/rebase.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 12029dc57db23baef008e77db1909367599210ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-680%2Fnewren%2Frebase-am-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-680/newren/rebase-am-fixes-v1
Pull-Request: https://github.com/git/git/pull/680
-- 
gitgitgadget

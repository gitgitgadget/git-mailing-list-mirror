Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E1B20248
	for <e@80x24.org>; Fri,  1 Mar 2019 17:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbfCARui (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 12:50:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44445 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCARui (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 12:50:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id w2so26775782wrt.11
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 09:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5hXX6htEg7dIsP8qv3a6XKfIzyhwTdpaCfv/KHOHGF8=;
        b=VSPwqMmn5Y1J+4pA32t8Fx6wOjXj8UegPDLVsTW2eBW1LNmF4AXaytlYkXQRbDjqR6
         JGkPzBjd4JdmUvOa2cFuqWgfdmXjHHynMK+t5oAsPhM51F1XHmmBRO1wdCdozVBk+FoW
         10e18hvgckk4ccc/5LEsUcz7ojn7t3WDXh+etzL14ME0HKe6u9B+7PzhAVvW702LpeXk
         QZSuT3wYoWaS9/UNNexyiO2D6BYytDqeujYF8QtMYPG5+2Z+6M59rDptvaUUjKvGKIw0
         v5g9Rg427tmozJak4JGCVC1kOmmXH5iNfv3JR80HuhOM5KhTvCbdp3NMKjLW3RMnXsAn
         KB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5hXX6htEg7dIsP8qv3a6XKfIzyhwTdpaCfv/KHOHGF8=;
        b=klBSzH19zy91ZzMQMzBXC+ont2woxcxn57Ap6M7tCRE0J9fCf8c+EMgqbyjMQITQUC
         78g4i700jXERjoMez8Fdt6k4Kk/vck3GBB0umifhSZdoP1O2wiTs2+rsgkCEdt96+pfp
         78LBDOUCkp1FbM8ZJJaRbj7rgQpyta64nlVtxv/4fCNsIWXKdiK35KR/1JCAfSumH2/z
         fBuoVZvKaLvSCqA8d77U3rOyF5uYqFFpIfy6MWx4hMXiCBvU5HazdXmv9g4rWmGZVn4I
         rpAshILUU0pW1s7jSy6FfmzpiJh/yEIBapiNchtMVKex4XLDmCifbA1/V8yvJp/LyFkt
         F7LA==
X-Gm-Message-State: APjAAAU1ICN3Ccwr0s0aD/x10VLtkcENC0+Vz/NxJ40+KvnMTSF2+9WQ
        1R03OXuzecRIumWt3bcEqUFCc0IF
X-Google-Smtp-Source: APXvYqzrQLGx9qhTWblw5hoogBgL6CCNSTioUabj2USNeNJSgBywQM3PJXhfRMbeZ7EWyi5g/zux3A==
X-Received: by 2002:a5d:53cd:: with SMTP id a13mr4387551wrw.146.1551462636360;
        Fri, 01 Mar 2019 09:50:36 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-112-206.w86-199.abo.wanadoo.fr. [86.199.35.206])
        by smtp.googlemail.com with ESMTPSA id o8sm11672247wma.1.2019.03.01.09.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 09:50:35 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH 0/4] name-rev: improve memory usage
Date:   Fri,  1 Mar 2019 18:50:20 +0100
Message-Id: <20190301175024.17337-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rafasc reported on IRC that on a repository with a lot of branches,
tags, remotes, and commits, name-rev --stdin could use a massive amount
of memory (more than 2GB of RAM) to complete.

This patch series tries to improve name-rev’s memory usage.

There is some improvement that could be done, such as reference counting
the names attributed to commits.  Tell me if it could be worth to pursue
this way, or if name-rev’s internals would need a more thorough rewrite.

This is based on master (8104ec994e, "Git 2.21").

The tip of this series is tagged as "fix-name-rev-leak-rfc-v1" in
https://github.com/agrn/git.

Alban Gruin (4):
  name-rev: improve name_rev() memory usage
  commit-list: add a function to check if a commit is in a list
  name-rev: check if a commit should be named before naming it
  name-rev: avoid naming from a ref if it’s not a descendant of any
    commit

 builtin/name-rev.c | 124 +++++++++++++++++++++++++++++++++++----------
 commit.c           |  12 +++++
 commit.h           |   1 +
 3 files changed, 111 insertions(+), 26 deletions(-)

-- 
2.20.1


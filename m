Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CCEC33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029062070E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 10:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLA+cQ4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgAGKbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 05:31:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36889 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGKbA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 05:31:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so40712270wru.4
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 02:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=gC9sgNi2ygqaLlYQi4a1Ugi1ClyI51kR24/Ff6W5mxc=;
        b=jLA+cQ4b60o6h5yWrKV8BbFU365UEPe3/D5cPBt5pJ6o1BdEs62PmGnjRvQwcLzxVK
         7F8VO3A0amoiUPTmi5VW7h/M7ZWh23qtbLipkX8mcJYhs1nM5OrC73vLI/IP3PW3cpZc
         z34a0a6+738BXTEaZe/M4eykun/0ihYzIYPctFuq8J6z8o1WqdbHWydRXW1f+0DQXTj7
         M8ZteEggvgj1DGK6AGmZIkVMl/pbsK0rGPp0OPVUgIE4upZPwuIA3439m4bhE+lZc5BF
         xYzaD6kFoCWlIewoV2faz/aGBBd1L0y95rkuSUwnIrlQJeuLOxzykoI3ZCStqI/G8nMs
         y3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=gC9sgNi2ygqaLlYQi4a1Ugi1ClyI51kR24/Ff6W5mxc=;
        b=DSAGOWlc9Bc3v8PHivrsyDQCCwNnwK2/l7eLfvS+kYaCUGjl0Rf9Q0u0+OpPZfQD5m
         D2Em9LRx1A+m4zr48ZUS/rC8lFTBVN7KIFyUER5baHJS+7jtaDx+Rf8v+Puo8DbDRToB
         x3Dqlv2Pgd5Hzt9kqV3sEUn/wdXwmmXsjprWd4SGXTSw0aH0Zdnh9WLbhSGJt0d28pCT
         A6YZltf/Kt2NaHlBBI31yxaTd8VzyTjP6jrvi/RP60ZS1hzbYB81SHlkgr1XHq/MuV9R
         jQpjzM2tsye9hRrbtSKq8gZjmaHcmEYcHzTG0XBD4w9T7GuntlSfrVmCwgQwW4dNEkvV
         DKWg==
X-Gm-Message-State: APjAAAX1Pqf85k5fRFw4+TtX6JQWcID0E2WEDObZlvCIG3dtnZCDPME6
        A4ZKPKCG+p3mK3bycyC6kqQU33eP
X-Google-Smtp-Source: APXvYqxa6nkZSC3iz5BlUE8wdumgOWwTjZnfUVGv1hONiLjI7kc4aGROhBanJE7UrU3TOJFiKxJeEQ==
X-Received: by 2002:adf:806e:: with SMTP id 101mr6427671wrk.300.1578393058876;
        Tue, 07 Jan 2020 02:30:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm75991025wrs.94.2020.01.07.02.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 02:30:58 -0800 (PST)
Message-Id: <pull.514.git.1578393057.gitgitgadget@gmail.com>
From:   "Sergey Rudyshin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 10:30:56 +0000
Subject: [PATCH 0/1] Preserve topological ordering after merges
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Sergey Rudyshin <540555@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This modifies the algoritm of topopological ordering. The problem with the
current algoritm is that it displays the graph below as following

* E
|\
| * D
| |\
| |/
|/|
* | C
| * B
|/
* A

commit B is placed between A and C, which is wrong because E stays that D
and B comes after C

the only correct solution here is

* E
|\
| * D
| |\
| |/
|/|
| * B
* | C
|/
* A

while it seems that it contradicts to D staiting that C shoud be between D
and B The new algorithm solves this issue

Here is an example: walk to to the root via "first" parents go E -> C -> A
print A because it has no parents step back to C print C because it has no
other parents then step back to E go D -> B -> A do not print A becase A is
already printed step back to B print B so on

This change makes option "--topo-order" obsolete, because for a single
commit there is only one way to order parents. "--date-order" and
"--author-date-order" are preserved and make sence only for the case when
multiple commits are given to be able to sort those commits.

Sergey Rudyshin (1):
  Preserve topological ordering after merges This modifies the algorithm
    of topopological ordering. The problem with the current algoritm is
    that it displays the graph below as follows

 Documentation/git-rev-list.txt             |   4 +-
 Documentation/rev-list-options.txt         |  41 +++---
 commit.c                                   | 149 ++++++++++++++-------
 commit.h                                   |   4 +-
 t/t4202-log.sh                             |  15 +--
 t/t4215-log-skewed-merges.sh               |  44 +++---
 t/t6003-rev-list-topo-order.sh             |  54 ++++----
 t/t6012-rev-list-simplify.sh               |   8 +-
 t/t6016-rev-list-graph-simplify-history.sh |  41 +++---
 t/t6600-test-reach.sh                      |   6 +-
 10 files changed, 214 insertions(+), 152 deletions(-)


base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-514%2FSergeyRudyshin%2Ftopo_order_fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-514/SergeyRudyshin/topo_order_fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/514
-- 
gitgitgadget

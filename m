Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 366871FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934578AbdCXSlO (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:41:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34046 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbdCXSlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:41:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id u132so2304652wmg.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ntVpQBgpY6anaNRpMRBJ1SdeoSEMyPY7NZR/b0DHVc=;
        b=vUd1mR8tfJtkDiSKlOJThlZCKtmyRMtfNRi1p9WOxPRwR969zLmxs5v7aSrPKveX2I
         VB3sIc3RWLtI1RqHLm7hE5Zmcgu/bgObmcyKsbdxbbrnv9CRtuqqbz2iH9qprlFWw0f4
         dYvKfszj4YC6ryXbYRvrVAeAzhmXYhek73bI66a07o3jHU4xKlsbh3v8envf26J1NC7r
         oAepfB/UGdCyx33CkZYWSvNWokwvvEs7LiTjJUQkoj5x5KI7ZQ8cWBo0RHUnX0Q2GyWQ
         M9jKWSyBH6fsMUPBITci1ejY/RA7rZ2XevPXEHssJiRYRxQdZQtDWNnuztDlBmDmcDOh
         d9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ntVpQBgpY6anaNRpMRBJ1SdeoSEMyPY7NZR/b0DHVc=;
        b=mHt8HiGhi31R04H5cTAKSGz8V8WCqrB8GmsFaLcG+hi8Asm4mAjslfUrtZG/gaj33v
         I4fFQ3aKKDWqW7kvOczqwQczHYUDc1cPhkyM6BzRT0kiXzsYZHh6g12ekx3tKHkFE0cN
         yQt3rjSpH/ljOe1bFw1jyv34yVFHyGaXjCbVRv5QQqUN6r/iIQb20M96rqnK5pvQjWEg
         hWSkNHYmVUbpLiUlvA2Lr9jOkflOX97Cn1JKAzZkqn0DqwFzy69oKeDSC+GzfhR4DfPN
         pP92Z9IblYdoBBWYqeHVvKdUKP2yn/E3YG4/QwGejIhRsS8MjWROywD5APnZtHNmrNN8
         Yxfw==
X-Gm-Message-State: AFeK/H1ABkFkidEbeiRn4cgBkLQ2C8Ap/PSMEx7G8eWB2FrpFkltxWzhFvI24o2cO9PTYQ==
X-Received: by 10.28.156.69 with SMTP id f66mr4312540wme.56.1490380870482;
        Fri, 24 Mar 2017 11:41:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/16] Various changes to the "tag" command & related
Date:   Fri, 24 Mar 2017 18:40:43 +0000
Message-Id: <20170324184059.5374-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hopefully the final version. This is exactly like v3 except for a
couple of minor changes (and rebased on the latest upstream master):


Ævar Arnfjörð Bjarmason (16):
  tag doc: move the description of --[no-]merged earlier
  tag doc: split up the --[no-]merged documentation
  tag doc: reword --[no-]merged to talk about commits, not tips
  ref-filter: make combining --merged & --no-merged an error
  ref-filter: add test for --contains on a non-commit
  tag: remove a TODO item from the test suite
  tag tests: fix a typo in a test description
  for-each-ref: partly change <object> to <commit> in help
  tag: add more incompatibles mode tests

Clarified in the commit message what code in builtin/tag.c we're
trying to test here.

  parse-options: add OPT_NONEG to the "contains" option
  tag: change misleading --list <pattern> documentation

Use the same phrasing as Junio's "branch doc: update description for
`--list`" does when describing "git tag --list".

  tag: implicitly supply --list given another list-like option
  tag: change --point-at to default to HEAD
  ref-filter: add --no-contains option to tag/branch/for-each-ref
  ref-filter: reflow recently changed branch/tag/for-each-ref docs
  tag: add tests for --with and --without

 Documentation/git-branch.txt           |  33 +++--
 Documentation/git-for-each-ref.txt     |  12 +-
 Documentation/git-tag.txt              |  59 +++++---
 builtin/branch.c                       |   5 +-
 builtin/for-each-ref.c                 |   5 +-
 builtin/tag.c                          |  27 ++--
 contrib/completion/git-completion.bash |   4 +-
 parse-options.h                        |   6 +-
 ref-filter.c                           |  30 +++-
 ref-filter.h                           |   1 +
 t/t3200-branch.sh                      |   4 +
 t/t3201-branch-contains.sh             |  61 +++++++-
 t/t6302-for-each-ref-filter.sh         |  20 +++
 t/t7004-tag.sh                         | 245 +++++++++++++++++++++++++++++++--
 14 files changed, 440 insertions(+), 72 deletions(-)

-- 
2.11.0


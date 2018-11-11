Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4D71F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 06:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeKKQK6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:10:58 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32974 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeKKQK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:10:58 -0500
Received: by mail-oi1-f193.google.com with SMTP id x204-v6so4778612oia.0
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 22:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CB/FgThkxMOI97oI0rMzDz94LSsBZkmcjD9EenNwZI0=;
        b=VYZ5mLD9imGtZDEKgG+E9EYeRdnY+oR8ob6W9kMz9iCTxZl1HUzszBhhwPf1aCuX/N
         oSv9xeXxSyi8rgBHpQBCgnRIPmWTRu+JM2PwSYafNMDt4qhrnpO/ujNBbEzwSSw2KiOO
         BulYiU+U24eQAHfrmflz85neolMVlIeW1zJ/F0XAUwk+gkPGWZVQmPmSxRqXGLcQbHxx
         CMff7XntjmMf1PfB8xzc/x0SNzqsqqr3UcpIeFT6kfkOQ6J6F6nANxlRm9rpsZIFqwAE
         DSvID9m55Lcbbo1ev6HZnn84f67+8uKf9LRNhMCBKvZTxUPCXbWWXpu8LlJ6zipdv3wv
         8ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CB/FgThkxMOI97oI0rMzDz94LSsBZkmcjD9EenNwZI0=;
        b=kpbQCXXNstwq7zvtdKQqizM5Hs7SOZHR4XpdN3aFD7jIu3CLJgxbpPnUI9vGETy7pz
         AhTZAimM5rBCAoDB36z2t3q4j4ZFm4LPh6E7xgmLMynwgcpr3NyRZtnkKqOmGoyDOblv
         cgv9eI2byc5p25NRN+3I+k9bQ40G2N3pTSDE0fps7QY98zG/LvlZrffYgFvskS2tYM5T
         Ji67MUcJGQ0REs8qCNzFOpsQmir15sVjhAwA+hokVA6uHYsO802fYcPoYdL6lwyUsDjm
         hxjsi9525DcXo22gIInj5ZYY2p1BT0QfSD3/4zC2Rr6W2AMNyYGcM3xRzNA2038bgbzM
         HkbQ==
X-Gm-Message-State: AGRZ1gKl9Mf9KpHo0HTJkcfbkexUrFyKJ99nQULSacxIzSsBZ7qB9sut
        APDrh6Zj/hlS+c+NsVhOgE0KM9wJ
X-Google-Smtp-Source: AJdET5cDzhOEZMZJvxUgER2n47u2AEgKVRB4y2HjxLfGDgRV9SQ6QtOHVqVtTbzngESL2OyNk3Cosw==
X-Received: by 2002:aca:72cd:: with SMTP id p196-v6mr7910081oic.252.1541917398705;
        Sat, 10 Nov 2018 22:23:18 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id f34sm1286855otb.25.2018.11.10.22.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Nov 2018 22:23:18 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     larsxschneider@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, me@ttaylorr.com, jrnieder@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 00/10] fast export and import fixes and features
Date:   Sat, 10 Nov 2018 22:23:02 -0800
Message-Id: <20181111062312.16342-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.866.g82735bcbde
In-Reply-To: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series of ten patches representing two doc corrections, one
pedantic fix, three real bug fixes, one micro code refactor, and three
new features.  Each of these ten changes is relatively small in size.
These changes predominantly affect fast-export, but there's a couple
small changes for fast-import as well.

I could potentially split these patches up, but I'd just end up
chaining them sequentially since otherwise there'd be lots of
conflicts; having 10 different single patch series with lots of
dependencies sounded like a bigger pain to me, but let me know if you
would prefer I split them up and how you suggest doing so.

These patches were driven by the needs of git-repo-filter[1], but most
if not all of them should be independently useful.

Elijah Newren (10):
  git-fast-import.txt: fix documentation for --quiet option
  git-fast-export.txt: clarify misleading documentation about rev-list
    args
  fast-export: use value from correct enum
  fast-export: avoid dying when filtering by paths and old tags exist
  fast-export: move commit rewriting logic into a function for reuse
  fast-export: when using paths, avoid corrupt stream with non-existent
    mark
  fast-export: ensure we export requested refs
  fast-export: add --reference-excluded-parents option
  fast-export: add a --show-original-ids option to show original names
  fast-export: add --always-show-modify-after-rename

 Documentation/git-fast-export.txt |  33 ++++++-
 Documentation/git-fast-import.txt |   7 +-
 builtin/fast-export.c             | 156 +++++++++++++++++++++++-------
 fast-import.c                     |  17 ++++
 t/t9350-fast-export.sh            | 124 +++++++++++++++++++++++-
 5 files changed, 293 insertions(+), 44 deletions(-)

[1] https://github.com/newren/git-repo-filter if you're really
curious, but ***** IT HAS SEVERAL SHARP EDGES *****.  It isn't really
ready for review/testing/usage/announcing/etc; in fact, it's not quite
WIP/RFC ready.  (Further, it's not clear if it should somehow become
part of core git, should go into contrib, or just remain separate
indefinitely.)  Anyway, please do not attempt to use it for anything
real yet.  I'll send out an email when I think it's closer to ready.

-- 
2.19.1.866.g82735bcbde

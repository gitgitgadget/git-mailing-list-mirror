Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3883E2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756962AbdCUNIP (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:08:15 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35207 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756607AbdCUNIO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:08:14 -0400
Received: by mail-wm0-f49.google.com with SMTP id u132so11687199wmg.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 06:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vrUO8HLLYFoKYbNPa0A8gMKXIo8SG/amYQKGFQPPjmU=;
        b=FGjWHjNVlzjljKExIaZz/fjV/fXMrCC3Sb/vd6GxrXTEuLkKk7rOGyEW6Wqxk0pmjm
         c72O1YnVkRy2CiYGzBHQd+GLlw/7iWFr+T5Fft8hSNFV5efwsbJzXiYXMzUNqgOO9LOL
         X809vv943Z/vqtJ8NqfqWE0RmooNrBxoqjCSTfInqZteNbF64pFx55mkzCueubwivDei
         knhqliLo8NKigP10LAqKIkKACXiuju9OMbie8lA/cEtcHhRKKkCihKfkl4sxM64V7PTd
         scVxYepaPtO02ZypV0KGDfO7tSfDRYn46zZZfKcFeD1nVYukwd8VYi1qdVWgD+K78cBa
         iz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vrUO8HLLYFoKYbNPa0A8gMKXIo8SG/amYQKGFQPPjmU=;
        b=b7ViBQRePG0RNMlovI3oHY6iR7XPCQaVINfmC7bF1k6DcjoJd3ZOwCS7G7hCXventG
         +7jpn9oyOJSwF8X0VI/eiiYtDPFDgpLEWo2tkh46vVRO3w+JdHLktG3H9wmtwmXUgdly
         SaQyPIE8ObiaJnIsKd8+ThczR4VoqBqPLznnbhFq7nN3+Wy4aUUnSHOqxox0ypcs88l/
         VeAkwopjB1F1KM3pxZWhRrDIZavqoFbMor6IAHRKFiPAsnzwdQDynP4RPUlzGUbLgRLR
         2w/MCjeBSQWXy+E+FMd0ndiz501o79nBfB9NTx6W4ZXbewxxlF+N47XZD+a21ZlLXoIp
         Hx4A==
X-Gm-Message-State: AFeK/H2kTMtS7K6OmnmLwKhwV3mkVpskxY3ir0rlsaWLEoBxiajFNwDa2Z8J00WpyZEyfA==
X-Received: by 10.28.84.18 with SMTP id i18mr2847655wmb.12.1490101153477;
        Tue, 21 Mar 2017 05:59:13 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.05.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 05:59:12 -0700 (PDT)
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
Subject: [PATCH v2 00/16] Various changes to the "tag" command & related
Date:   Tue, 21 Mar 2017 12:58:45 +0000
Message-Id: <20170321125901.10652-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is now 2x the size of v1. The reason is that the
discussion for v1 brought up lots of related side-points that I fixed
while I was at it. Most if this *could* be split off, but since a lot
of it's modifying the same bits of code doing that would result in
merge conflict galore, so I think it's easier to bundle it up.

Comments on individual patches below:

Ævar Arnfjörð Bjarmason (16):
  tag doc: move the description of --[no-]merged earlier
  tag doc: split up the --[no-]merged documentation
  tag doc: reword --[no-]merged to talk about commits, not tips

NEW: Document that --merged & --no-merged operate on commits, not
objects. Split up the docs to document each option indepenently for
ease of subsequent changes.

  ref-filter: make combining --merged & --no-merged an error

NEW: Currently "--merged HEAD --no-merged HEAD" is just silently
equivalent to "--no-merged HEAD". Make the former an "incompatible
options" error.

  ref-filter: add test for --contains on a non-commit

NEW: Jeff suggested we should test for this. Make it so.

  tag: remove a TODO item from the test suite

No changes.

  tag tests: fix a typo in a test description

NEW: Fix a tag test typo.

  for-each-ref: partly change <object> to <commit> in help

NEW: Clarify the for-each-ref --help output.

  tag: add more incompatibles mode tests

CHANGED: I dropped the "tag: Refactor the options handling code to be
less bizarro" patch, but these are the tests that came along with it.

  tag: change misleading --list <pattern> documentation

No changes.

  tag: implicitly supply --list given another list-like option

Changed: Typo fixes in commit message, `argc == 0 && !cmdmode` logic
changes, code reflow, better error messages etc.

  tag: change --point-at to default to HEAD

Changed: Fixed up an ">expect" at the start of the test.

  ref-filter: add --no-contains option to tag/branch/for-each-ref

Changed: Typos/grammar in commit message, get rid of needless "else",
tests for tree/tag blobs.

  ref-filter: reflow recently changed branch/tag/for-each-ref docs

NEW: Split off reflowing of documentation paragraphs from the above
for ease of reading.

  tag: implicitly supply --list given the -n option

Re-arranged: I still want this included, but the consensus on the list
wasn't as strong, so it's moved later in the series so it can be
dropped without conflicts.

  tag: add tests for --with and --without

No changes.

 Documentation/git-branch.txt           |  33 +++--
 Documentation/git-for-each-ref.txt     |  12 +-
 Documentation/git-tag.txt              |  60 ++++++---
 builtin/branch.c                       |   5 +-
 builtin/for-each-ref.c                 |   5 +-
 builtin/tag.c                          |  27 ++--
 contrib/completion/git-completion.bash |   4 +-
 parse-options.h                        |   4 +-
 ref-filter.c                           |  30 ++++-
 ref-filter.h                           |   1 +
 t/t3200-branch.sh                      |   4 +
 t/t3201-branch-contains.sh             |  61 ++++++++-
 t/t6302-for-each-ref-filter.sh         |  20 +++
 t/t7004-tag.sh                         | 237 +++++++++++++++++++++++++++++++--
 14 files changed, 432 insertions(+), 71 deletions(-)

-- 
2.11.0


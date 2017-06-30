Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36322202AB
	for <e@80x24.org>; Fri, 30 Jun 2017 20:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbdF3Uld (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:41:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34506 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbdF3Ulc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:41:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id p204so9860396wmg.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lX1MKvh9s0vT+C+LybshXW4ip7bjnPhX1y/wREnIws0=;
        b=Dixd6SyvVwicOPhe6G1fWblrWL5E52DduToLFyffc+pIfg0+jZNaRz5VZnpnHd1JjO
         UWD3wMpA63DtiqD9rGhdH0z7y+NW1yAsN0d1nWod6SLxAaHwTIz80gsIeFUwl+rMAMKq
         x5pj4Q5+6fMdLL/62QSzp1aldaCRCbJYTupoGyECfkN80HRInjzCdvLRSrTi81sHQtuL
         oanKwVTn0bDICypt8osQ8dey6lryXjloBfd1FxMRzaJ1NKkOHctZUqSry97HfIDeLTYh
         NCYICltQDbyuwY+xhgShTsWvEbpWiY+lwJTiZBDcWZit/J1tpHURUE/xq2wkrwWOSEu/
         RXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lX1MKvh9s0vT+C+LybshXW4ip7bjnPhX1y/wREnIws0=;
        b=Gcw6DP6AFn8Lu6vJsx0irEC4gt7wDrlYxRzC4gUbuXqGFiYb42SKM1Tr7VHl858IJX
         XKdxAenwQ32/3HDbG/2j5DXNd8HM2Rq4ax+JgvGFBBuZ32hja0ss3XCEDyXTrdkJACx8
         tk2ZybZR5KR1JpPIRRUM7VseNvFNF9L3g6NrZFE9tLwYVM/7ln34U3uOExIIgihQq2m2
         FuQklz/s5bnXssgMcSUaAex4rMDWp4Gk2QhqY1Y6jO/oanu4iB1MKJLD+JZxucPDDChs
         r/yXi2zvuPfvBeHceQKN2NcKMAgR8JJ1KPMvhqipo/0wVIUjd23sHn6s93z3JXu8ED7J
         SOSw==
X-Gm-Message-State: AKS2vOzLy4U7C7OPB+/xTE+jqRPrUXOgrHZjraT8Ved2liH28n/l8lLd
        yOMY4XLomtnvdP64
X-Received: by 10.28.157.9 with SMTP id g9mr7204661wme.76.1498855290563;
        Fri, 30 Jun 2017 13:41:30 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4C89.dip0.t-ipconnect.de. [93.219.76.137])
        by smtp.gmail.com with ESMTPSA id v144sm10648239wmv.27.2017.06.30.13.41.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:41:30 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v9 0/7] convert: add "status=delayed" to filter process protocol
Date:   Fri, 30 Jun 2017 22:41:21 +0200
Message-Id: <20170630204128.48708-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

here is the 9th iteration of my "status delayed" topic. I think that
might be the final one :-)

Patch 1 to 3 are minor t0021 test adjustments. Patch 4 to 6 are convert
refactorings to prepare the new feature. Patch 7 is the new feature.

### Changes since v7:
* extracted capabilities negotiation refactoring into dedicated patch 6
  --> no code changes and therefore no inter-diff

Thanks,
Lars


RFC: http://public-inbox.org/git/D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com/
v1: http://public-inbox.org/git/20170108191736.47359-1-larsxschneider@gmail.com/
v2: http://public-inbox.org/git/20170226184816.30010-1-larsxschneider@gmail.com/
v3: http://public-inbox.org/git/20170409191107.20547-1-larsxschneider@gmail.com/
v4: http://public-inbox.org/git/20170522135001.54506-1-larsxschneider@gmail.com/
v5: http://public-inbox.org/git/20170601082203.50397-1-larsxschneider@gmail.com/
v6: http://public-inbox.org/git/20170625182125.6741-1-larsxschneider@gmail.com/
v7: http://public-inbox.org/git/20170627121027.99209-1-larsxschneider@gmail.com/
v8: http://public-inbox.org/git/20170628212952.60781-1-larsxschneider@gmail.com/

Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/c391b48aa2
Checkout: git fetch https://github.com/larsxschneider/git filter-process/delay-v9 && git checkout c391b48aa2


### Patches

Lars Schneider (7):
  t0021: keep filter log files on comparison
  t0021: make debug log file name configurable
  t0021: write "OUT <size>" only on success
  convert: put the flags field before the flag itself for consistent
    style
  convert: move multiple file filter error handling to separate function
  convert: refactor capabilities negotiation
  convert: add "status=delayed" to filter process protocol

 Documentation/gitattributes.txt |  69 ++++++++++++-
 builtin/checkout.c              |   3 +
 cache.h                         |   3 +
 convert.c                       | 202 +++++++++++++++++++++++++++----------
 convert.h                       |  26 +++++
 entry.c                         | 132 ++++++++++++++++++++++++-
 t/t0021-conversion.sh           | 178 +++++++++++++++++++++++++++------
 t/t0021/rot13-filter.pl         | 214 +++++++++++++++++++++++++++-------------
 unpack-trees.c                  |   2 +
 9 files changed, 668 insertions(+), 161 deletions(-)


base-commit: 0339965c70d68fd3831c9a5306443c869de3f6a8
--
2.13.2


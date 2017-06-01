Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A936120D13
	for <e@80x24.org>; Thu,  1 Jun 2017 08:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdFAIWI (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 04:22:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35262 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdFAIWG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 04:22:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id g15so9275868wmc.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EOIkpaAN+ZNxs2JD2YGp/xhDvvN/r2Md+b1VZhwCho4=;
        b=U2LrbgeS0mDo+Z4PtUHJywY5CExcB1SW8Tcrgj7IeybY+eUk56wlL/7F3q7n2QANha
         ZBs18fxUxeNMDibyNMykhA/gDK1DDVnFAXcNA23AWrW0l3/fcXNKu0c3P+IkTACOQfjA
         65m7qWILJmWmTT4E7N3+xonusbMIibcEoslhezYtG1w+YzR5Y0zt7af+6gA4+cFj8Uz1
         1qpK8gFmkQrPjqnuJacFMwae0313KwQXlakYbFAAvTWrftzB9ZhVQ67zFt+7MNr+dHDe
         JlUE7x3/S0J2jHpRZfeb3+7/BKqavkw63lBx7eQ747TMXpM/dORvzPtBshYwHNzQgXs0
         nTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EOIkpaAN+ZNxs2JD2YGp/xhDvvN/r2Md+b1VZhwCho4=;
        b=KhbAN7dtVBMsdncQf9C92EIJUU0GMnzzzO/n14iapkwWd70NdRedcR/zfbWo1L3DCD
         qwfl6EmdAIH0/88M8JTzrBUPjtanfvXsFKJmNX/XWhadk7S2EhWhVwcW29/ymH1ORv54
         AmYTouAL1cp3khE0DqGPrG+yTDPDkZ8kLFYZV/rhMbgEiNQhH/vleDwyKDfSkzsrC7y9
         eHAbiVl+EQCK9i8SQ81dC1S1PnMS7iHMYpSpfvwgM0A7X2lezBDvZCEKPH5ualxWhCL/
         q/qD87zvIwy+snTkp6504Mtf12Ia7YL8dzlrSs2Ymmloc4J/hS1bJbTdgfvAs0XgIcEP
         eMJg==
X-Gm-Message-State: AODbwcBqoan4ug4XxcV+FR7u7RLePfQC2v5urJnV88mP4ophyOH2fx8D
        3EEE1oeTDgPLIule
X-Received: by 10.28.74.1 with SMTP id x1mr8312732wma.95.1496305325215;
        Thu, 01 Jun 2017 01:22:05 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB4864.dip0.t-ipconnect.de. [93.219.72.100])
        by smtp.gmail.com with ESMTPSA id 140sm15351595wmu.23.2017.06.01.01.22.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 01:22:04 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v5 0/5] convert: add "status=delayed" to filter process protocol
Date:   Thu,  1 Jun 2017 10:21:58 +0200
Message-Id: <20170601082203.50397-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

here is the 5th iteration of my "status delayed" topic. Patch 1 to 3 are
minor t0021 test adjustments and haven't been changed since v3. Patch 4
is a minor "extract method" refactoring in convert. Patch 5 is the new
feature.

Changes since v4:

* rebased the topic on top of master to resolve conflicts and be able to
  share code with on Ben Peart's bp/sub-process-convert-filter topic
  http://public-inbox.org/git/xmqq1srgm9kq.fsf@gitster.mtv.corp.google.com/

* removed invalid errno check
  http://public-inbox.org/git/64b1fda4-9f79-1bd8-ad6d-43196b808d61@web.de/

* minor documentation improvement
  http://public-inbox.org/git/E2C871B0-DCDF-40C5-A559-C396F3C8AA66@gmail.com/

If you review this series then please read the "Delay" section in
"Documentation/gitattributes.txt" first for an overview of the delay mechanism.
The changes in "t/t0021/rot13-filter.pl" are easier to review if you ignore
whitespace changes.

I also noticed that the diff around the "static int apply_multi_file_filter"
looks really weird as my new function "int async_query_available_blobs" is
right behind it with similar lines.

Thanks,
Lars


RFC: http://public-inbox.org/git/D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com/
v1: http://public-inbox.org/git/20170108191736.47359-1-larsxschneider@gmail.com/
v2: http://public-inbox.org/git/20170226184816.30010-1-larsxschneider@gmail.com/
v3: http://public-inbox.org/git/20170409191107.20547-1-larsxschneider@gmail.com/
v4: http://public-inbox.org/git/20170522135001.54506-1-larsxschneider@gmail.com/



Base Ref: master
Web-Diff: https://github.com/larsxschneider/git/commit/23001c0fe2
Checkout: git fetch https://github.com/larsxschneider/git filter-process/delay-v5 && git checkout 23001c0fe2

Lars Schneider (5):
  t0021: keep filter log files on comparison
  t0021: make debug log file name configurable
  t0021: write "OUT" only on success
  convert: move multiple file filter error handling to separate function
  convert: add "status=delayed" to filter process protocol

 Documentation/gitattributes.txt |  65 ++++++++++++-
 builtin/checkout.c              |   3 +
 cache.h                         |   6 +-
 convert.c                       | 162 ++++++++++++++++++++++++--------
 convert.h                       |  21 +++++
 entry.c                         | 110 +++++++++++++++++++++-
 t/t0021-conversion.sh           | 136 ++++++++++++++++++++-------
 t/t0021/rot13-filter.pl         | 199 ++++++++++++++++++++++++++--------------
 unpack-trees.c                  |   2 +
 9 files changed, 559 insertions(+), 145 deletions(-)


base-commit: 0339965c70d68fd3831c9a5306443c869de3f6a8
--
2.13.0


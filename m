Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C02D1F424
	for <e@80x24.org>; Sun,  8 Apr 2018 09:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeDHJfc (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 05:35:32 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34978 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeDHJfb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 05:35:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id 80so5328876wrb.2
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 02:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FyF4qL7WFCqY5sTgLt82xYuIBVAhQcBM0g7q3G2FPFw=;
        b=mD4ewq1gC1OZFt/ULphAUDWtYcqfj9jM+KQHXJMf/hne0+J+DtgNfScay24/gD8h0F
         6NNQxixf7tqBkrr6JYdSAhHbib+pnJO1oQGKBcu6a/s4aQDEpFfbG4DOULjXdlxwLqn6
         ZgmrxM56aNMT63CKJlCTm749xQSAgWo3H0iH7tAVRf/QV1mQuJ4LuNdNh/V+aOblp9AF
         tRSq4fkUVrwdGWp631yWYMKrgbJ5QJEi1cwF5eLSwAnsojDD4y2174quPAuc7ZYEvYAf
         X/XzJgGxnmHy/tqW8ACmHGXohRNET/Nbm45YGHYWO/hSbT4HjHHOighG5rsxatv3S7e+
         xI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FyF4qL7WFCqY5sTgLt82xYuIBVAhQcBM0g7q3G2FPFw=;
        b=SCdbWLlyFxtAdK2kT32wv2QCAmh1HxP1GkW8DF9K2pEkuqM67Q9FWjx950PRfXezDV
         Pw2l0P69fkFYkhPgvijviB6/iybzw5pfqNl4z0yFksEHDAGlKjuJtftPh+AkL+RNx59j
         5N12BEoTndsCk7KowHehqedco266rhYfP5hciRL5S/GXa0iz/9F+YCgYiS5lebcjZNhd
         fApqYNg05ylbkBkmUkejDYjjtnROl2izGuiauCTF3ngDcuipBhrfIKlb0raQSD4h2zyi
         e5uQh3GLOTb8HpVIxbpzlOvbL4EbXh663vcob3+0H+E8rWMRAdo/6OH/Ncc4kkLOM71t
         klNw==
X-Gm-Message-State: AElRT7FgEk1RvT73UC1F6anZQFKTdSSed0oGH+DKICMzufakOOUfva4E
        BQjhG7tnbNNMXAUl1la4z9Q1pJT+
X-Google-Smtp-Source: AIpwx49fokccMc4HRRS4oOujdDUr3qREtHAu4tM5ryugSHgoafB1DTqPPXR557wPhPgesJofJNaqxw==
X-Received: by 10.223.154.182 with SMTP id a51mr25997036wrc.176.1523180129597;
        Sun, 08 Apr 2018 02:35:29 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v75sm13910014wrc.90.2018.04.08.02.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Apr 2018 02:35:28 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v1 0/2] t/perf: bisect performance regressions
Date:   Sun,  8 Apr 2018 11:35:11 +0200
Message-Id: <20180408093513.17769-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc1.36.g098d832c9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small patch series on top of cc/perf-aggregate-sort, which
is next, to add scripts that make it much easier to bisect performance
regressions.

For example if you ran perf test using the perf.conf config file that
contains a "with libpcre", then using:

$ ./aggregate.perl --subsection "with libpcre" --sort-by=regression v2.15.1 v2.16.2 v2.17.0 

you can get a line in the output like:

+8.2% p5302-pack-index.6 14.33(44.50+0.77) 15.50(43.83+0.94) v2.16.2 v2.17.0

and you can now use this output line to bisect where the regression
comes from using:

echo "+8.2% p5302-pack-index.6 14.33(44.50+0.77) 15.50(43.83+0.94) v2.16.2 v2.17.0" | ./bisect_regression --config perf.conf --subsection "with libpcre"

Caveats:

You must make sure that the times are consistent between runs and that
there is a significant time difference between the "good" runs and the
"bad" runs.

For example the following is not easily bisectable:

+100.0% p0000-perf-lib-sanity.2 0.01(0.01+0.01) 0.02(0.02+0.00) v2.15.1 v2.16.2

as the rtime went from 0.01 s to 0.02 s and we only have 0.01 s precision.

Christian Couder (2):
  perf/run: add --subsection option
  t/perf: add scripts to bisect performance regressions

 t/perf/bisect_regression | 73 ++++++++++++++++++++++++++++++++++++++++
 t/perf/bisect_run_script | 47 ++++++++++++++++++++++++++
 t/perf/run               | 56 ++++++++++++++++++++++++------
 3 files changed, 166 insertions(+), 10 deletions(-)
 create mode 100755 t/perf/bisect_regression
 create mode 100755 t/perf/bisect_run_script

-- 
2.17.0.rc1.36.g098d832c9.dirty


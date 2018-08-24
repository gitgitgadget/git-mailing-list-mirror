Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E151F404
	for <e@80x24.org>; Fri, 24 Aug 2018 15:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeHXSzf (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 14:55:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37134 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHXSzf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 14:55:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so2015195wmc.2
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfrRIDu/cGm1Cls5iVddYMasAwFB/Z8paTrNy3R+LAw=;
        b=EGtNS1UsCvMVlluEUQAsuCZwIoO5kAKAxa+fjlPt9OiZCMrEnxzh5dqCoy8SRogw1a
         iGL8s6SKLsCHCBBXRZaEi3/q7Ia/xHlxmPD/p7YSfQ7Palo48A2lkz2+aO80s7kSyO4I
         K4nf6/x4ivBQDVy9/7Efo2yz+McmGdTZJaZYuU98JJIHhos/KSb0/PMeIEaBaH/YXh18
         Hy/ClvjaCEkCdRsT72KsU6g1ObbhI5fx8gkitAfvjePy1E7SLCwL1lVWQ6MZBYUfoPJ6
         y6p/csbAhOmUfb0uRjtMPs42VUj2DUXocKhfjOVj+EIPdgXl+KwfMiG8d66DJSoWpN0c
         312g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfrRIDu/cGm1Cls5iVddYMasAwFB/Z8paTrNy3R+LAw=;
        b=GGhZ3x7KzqE85+Jo22B2cG9lyuFyi6X/Bh9YyqPO7g1HeQiXgzYZ0tOtjuNcqXMp+M
         QIr6l20GZn5ZrBkdGESeBXGx8tWf/vM/6PM3FfzbgXBoj9aPm7eO6Eo+rQKLm1F+V08I
         B7z81U5LbrXyLMp7OMtP3e5nBHXdqpOzQb/EBYDPtKFm43ETt1x0wVSncs8W2Cp4N0pM
         8FqfONS4KK/QAjusBt1Mg80rwk0vTv7jrG5hXTrEc7ikM95uxyuqmPPULjSbTcmS/V6x
         0RXKPa2GjA7SJFkxSOommXIg3zABqQflKG8DIQgcy6ZZ/TvDDRVqqitJ0iQ7vQ/w72GJ
         O5xw==
X-Gm-Message-State: APzg51BgQa0Vxc9axp7yjvJLcFDXl613hEzMcu7jCK2+GJFaXadjFv3Q
        7W8XhyssLhY3GzoQHvIr/DMZFuHRgA0=
X-Google-Smtp-Source: ANB0VdZ82+d8ILhqwXBCtP0OgtmNdGamQ4EnbfbLkYGkJpNuE3QEukRYj8P6siW4qtvrDDDA4zVdng==
X-Received: by 2002:a1c:1c95:: with SMTP id c143-v6mr1620449wmc.147.1535124027504;
        Fri, 24 Aug 2018 08:20:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id z16-v6sm6689485wrq.78.2018.08.24.08.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 08:20:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/6] OpenBSD & AIX etc. portability fixes
Date:   Fri, 24 Aug 2018 15:20:10 +0000
Message-Id: <20180824152016.20286-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23 2018, Eric Sunshine wrote:

> On Thu, Aug 23, 2018 at 4:36 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> As noted in [1] there's still a remaining recently introduced
>> portability issue also introduced in 878f988350 ("t/test-lib: teach
>> --chain-lint to detect broken &&-chains in subshells", 2018-07-11), so
>> under AIX the tests must be run with GIT_TEST_CHAIN_LINT=0.
>>
>> I don't know how to solve the other issue, and this gets us some of
>> the way to GIT_TEST_CHAIN_LINT=1 working again on AIX.
>
> Does unindenting the comment, as I suggested in [1], fix the remaining
> problem for you?
>
> [1]: https://public-inbox.org/git/CAPig+cTTbU5HFMKgNyrxTp3+kcK46-Fn=4ZH6zDt1oQChAc3KA@mail.gmail.com/

I didn't notice Eric's E-mail before I sent my v3, so going back and
testing this revealed two things:

 1) Yes, his suggestion works
 2) AIX sed will complain about one thing at a time, so we had a lot
    more of these "labels too long" problems once I got past fixing
    that issue.

So here's a version, which as noted in 4/6 makes GIT_TEST_CHAIN_LINT=1
fully work on AIX again.

As an aside, the reason I have access to AIX is because I requested
access to the GCC compile farm as suggested by someone on-list here
the other day: https://cfarm.tetaneutral.net/

They accepted my account request on the basis that I was going to hack
on git & perl on those boxes, so if anyone else here is interested in
testing stuff for portability...

Ævar Arnfjörð Bjarmason (6):
  tests: fix and add lint for non-portable head -c N
  tests: fix and add lint for non-portable seq
  tests: fix comment syntax in chainlint.sed for AIX sed
  tests: use shorter here-docs in chainlint.sed for AIX sed
  tests: fix version-specific portability issue in Perl JSON
  tests: fix and add lint for non-portable grep --file

 t/chainlint.sed                      | 59 ++++++++++++++--------------
 t/check-non-portable-shell.pl        |  3 ++
 t/t0019/parse_json.perl              |  3 ++
 t/t5310-pack-bitmaps.sh              |  2 +-
 t/t5318-commit-graph.sh              |  2 +-
 t/t5552-skipping-fetch-negotiator.sh | 12 +++---
 t/t5703-upload-pack-ref-in-want.sh   |  4 +-
 t/test-lib.sh                        |  4 +-
 8 files changed, 47 insertions(+), 42 deletions(-)

-- 
2.18.0.865.gffc8e1a3cd6


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F41A81F597
	for <e@80x24.org>; Fri, 27 Jul 2018 03:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbeG0FI7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 01:08:59 -0400
Received: from p3plsmtpa12-02.prod.phx3.secureserver.net ([68.178.252.231]:60337
        "EHLO p3plsmtpa12-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbeG0FI6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 27 Jul 2018 01:08:58 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id itkTfU4KgK5J2itkXflkuJ; Thu, 26 Jul 2018 20:49:08 -0700
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Max Kirillov <max@max630.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v9 0/3] http-backend: respect CONTENT_LENGTH as specified by rfc3875
Date:   Fri, 27 Jul 2018 06:48:56 +0300
Message-Id: <20180727034859.15769-1-max@max630.net>
X-Mailer: git-send-email 2.17.0.1185.g782057d875
in-reply-to: <20180610150521.9714-1-max@max630.net>
X-CMAE-Envelope: MS4wfPGkj4hac/O2tF7VZNS3nXGm61Kam37BqOFqwfsvTQTv/nOFw7IvILcvN/cG81z65bFXwZHalX2/gGGdkUnEPh1yjbCPu0Ctu6C73DHVadewa9SdjrR0
 rbcgZQRpzfFii5e79yLwZddplIWlJu8RYCBplGBCwd3OPzuAr9DWvZpbHMDWkRtQ05jznawuOF5dA0jzF90dInsAQYyq9MTBPT6Uw+gY2rCpr/YSSaZDJg6Z
 eE6VOozZrN9fg7HcdR4DovqOejbjFpz5DAHSbWJrvVR8FCNjL04Y1yV9EFB7i1f+UBF6PQROnkuYTyT8NhxxWuuvL9d7dAUwb5WNbmYNx08T8OP7Gpp2PnGx
 egqTLOFhH9ArtE1eNX0rIz2FRZJGcTQj3mrGB261KsAN96TcIHkiQJQHFUrY2013mtOne4lGra1nQ1q1xMZpwThAQnCqpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* fix the gzip usage as suggested in https://public-inbox.org/git/xmqqk1quvegh.fsf@gitster-ct.c.googlers.com/
* better explanation of why status check is needed
* redirect only the helper call, not the whole shell function, also move more into the shell function

Max Kirillov (3):
  http-backend: cleanup writing to child process
  http-backend: respect CONTENT_LENGTH as specified by rfc3875
  http-backend: respect CONTENT_LENGTH for receive-pack

 config.c                               |   2 +-
 config.h                               |   1 +
 help.c                                 |   1 +
 http-backend.c                         | 100 +++++++++++++---
 t/t5562-http-backend-content-length.sh | 155 +++++++++++++++++++++++++
 t/t5562/invoke-with-content-length.pl  |  37 ++++++
 6 files changed, 281 insertions(+), 15 deletions(-)
 create mode 100755 t/t5562-http-backend-content-length.sh
 create mode 100755 t/t5562/invoke-with-content-length.pl

-- 
2.17.0.1185.g782057d875


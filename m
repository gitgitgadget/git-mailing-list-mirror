Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26ABB20D13
	for <e@80x24.org>; Fri,  2 Jun 2017 19:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdFBTKR (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 15:10:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34985 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdFBTKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 15:10:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id g15so20364646wmc.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 12:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p6quQ3Sv6tZ3T8e3cTo2/RXtR8clIRNjqf5Q8CX21sk=;
        b=UBHTryP4AmNQR+82Hs8tgou6Qtkb02Avj9Gghu0MtZCuGlCsHvwAhg0PU5l7KSp9HG
         iGT1hDuhmy81jonV0vcdAvFf0e/HQm6kpe36t3E7pKcl/I8ZfGTQtxwiSKdhW918KVAQ
         N0UIjwDGUuDXgyIieJB02reUQ4z0QTz8YE5UnWfpcm/881Hx/yIe0g0f6qi06ziCxc35
         WP76yPxqKgDp2vWIhWYlhTODt5a/0/yGBFn7qQNSqYSgWEsYWew1rlxkkJepATTSustr
         jPnMWBbAqbKvUkMXOyMgAZMI+SLkh4V9dlNWDW+znX7cotAKCghZUNAl+jjalC8elReJ
         OuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p6quQ3Sv6tZ3T8e3cTo2/RXtR8clIRNjqf5Q8CX21sk=;
        b=KAFGd7zsjNDtqV9SZO4J052n1csXxpfJoed1JXKmIpuDFdvF0ijAyI2rN2Sqx+9pJM
         hWKToI2mSGpWc0b4pTOw1mRdk8DDP8B2WDd7BUl4cnAsb2MfGhkBzDe7kCtIaH/O4aiB
         wqNNyZIkW8MzoA7UyQTowsNhOHpg7sP6P2VY4odl7xUQhgEqrIRHnu9l2WB/CyJvpCIe
         VYxkaKqGVPOLFjxkC1IFa6XHfjlwbbcBfEUOw9EP/f5tGNC/x4kmonBuBlDcAvFYnELw
         fdBoRPwh3cbBokh1EPEG+/cnhlDsx+5nnJDzzu04w8wptJublpStKzbdRUxbdlmykDj4
         VMOA==
X-Gm-Message-State: AODbwcBf+19F17zNIC+IcujHjaaH+mVAgyVX/QFvFexW+IuATjtAyLwi
        Y49EVg6kinKoEg==
X-Received: by 10.80.158.131 with SMTP id a3mr7046519edf.169.1496430615326;
        Fri, 02 Jun 2017 12:10:15 -0700 (PDT)
Received: from localhost.localdomain (x4db0e5ea.dyn.telefonica.de. [77.176.229.234])
        by smtp.gmail.com with ESMTPSA id j50sm8552465eda.44.2017.06.02.12.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 12:10:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/3] Use skip_prefix() in handle_revision_{,pseudo_}opt()
Date:   Fri,  2 Jun 2017 21:10:07 +0200
Message-Id: <20170602191010.16834-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While at it, the first one fixes a minor bug, which allowed e.g. 'git
log --no-min-parents-foobarbaz' to succeed.

The other two are fairly straightforward starts_with() ->
skip_prefix() conversions.

SZEDER Gábor (3):
  revision.c: stricter parsing of '--no-{min,max}-parents'
  revision.c: use skip_prefix() in handle_revision_opt()
  revision.c: use skip_prefix() in handle_revision_pseudo_opt()

 revision.c | 76 ++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

-- 
2.13.0.420.g54001f015


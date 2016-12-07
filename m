Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4546320259
	for <e@80x24.org>; Wed,  7 Dec 2016 16:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbcLGQKP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 11:10:15 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36373 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbcLGQKO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 11:10:14 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so28706726wma.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 08:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mEtD6dplC3nhqslUY3WE07eUjKpQlgAGqbCEH2Bx/4=;
        b=YbFnEgmTtD/utPl9syi5N1o2Ovt2xQqEmehEosyi8E/tbDl7IzCg8Ye24bgADW29Ny
         eLXNKcS6hDDWo0cyZnnOZolRpGEpn2BL08LmGdVePGwFueWJoLRhvjPK2m6B6Pq1ZEmq
         giu1YfjrZcetUsL6Iy1fQk+xaXdpq07SPz/XxnrKMPx0QgTw2URaaUVEZ0/IOorEeAK0
         cKyxK4YWOTaBIQmlbLpld6tZ2eB+idUMQwYM/bBCcWP4EnJaWJmqR0YSBYpaFCRtyAd3
         RQ8GkxO0VPn3hGX6eRvPwNbFmT9+Aq6qK2Bw2LTS00rvAjPssE5QLg81kq2ie3V7+XbV
         A3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mEtD6dplC3nhqslUY3WE07eUjKpQlgAGqbCEH2Bx/4=;
        b=PbdWYMt8C/44PaKAYZrUyEHgr/PJkJWhux7g5M1+YNFD5Axi8lNk4WN3Lmb85kVQT8
         uc8jD6kbgQoWAPX9D+HTgyzEKn3tr+G9tUoTyR0x50OlC7IJr1eUIu5GX9DW/tDOKBmS
         5bw78E/YL72L00RgCdqjIej2hE1coxM2g5jjOweAA9MtHLfMdkG8npR+oR7H2lAZIxKZ
         +LcpYTh/ENmzKqIYm7eBfKBBQJLfIHq09cZJVe3vhBMNjebJ29WrOmiL9GkP8eMGCCzw
         ef5/sZ+YINXWWq6QClA+EXJvwIR9ouNHajtwJCy1FBS6hSLiBYYlDMx3P2fR66BQFF8S
         uGUQ==
X-Gm-Message-State: AKaTC034yxrJdqmL4BA33lwjPAz1GQCvHOnEFSTH2yfuO9ic+AOBqk7NkqwvAdc24MyrkQ==
X-Received: by 10.28.137.193 with SMTP id l184mr3211026wmd.88.1481127013571;
        Wed, 07 Dec 2016 08:10:13 -0800 (PST)
Received: from localhost.localdomain (x590e0b3d.dyn.telefonica.de. [89.14.11.61])
        by smtp.gmail.com with ESMTPSA id 6sm32140379wjt.5.2016.12.07.08.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 08:10:13 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] A bit of ref-filter atom parsing cleanups
Date:   Wed,  7 Dec 2016 17:09:21 +0100
Message-Id: <20161207160923.7028-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.78.g5a2d011
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The diffstat of the second patch doesn't show any benefits, but only
because the first patch removed a callsite that would have benefited from
it.

It merges cleanly with Karthik's "port branch.c to use ref-filter's
printing options" series.

SZEDER Gábor (2):
  ref-filter, tag: eliminate duplicated sorting option parsing
  ref-filter: add function to parse atoms from a nul-terminated string

 builtin/tag.c | 24 ------------------------
 ref-filter.c  | 24 +++++++++++++-----------
 ref-filter.h  |  6 ++++++
 3 files changed, 19 insertions(+), 35 deletions(-)

-- 
2.11.0.78.g5a2d011


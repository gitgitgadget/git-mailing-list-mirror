Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB901F462
	for <e@80x24.org>; Fri, 14 Jun 2019 10:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfFNKBH (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 06:01:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36311 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfFNKBH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 06:01:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so1690708wmm.1
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 03:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6mYPEFtq74yMoYOQUwMhY50Nt2rzYW0REDAc2OI3+pA=;
        b=aQoUlGk+cwA+BMPHmbssBr8eZMtKeanUIdVKfhSWTrhpS8OfblxTnBLkhRj45MdkSD
         ezGfGPTptK2wYDhpqMgJiEHUH/hx5Alil7AtjkwuHsPVhkvAbNjo65v/5srfNex0xPuW
         5QX3EoasasTismJcViX8MzhstiD97eJsyr0KxpK1MAFaamrgbCZa7luiFTFoWPDqCQcC
         EUxEa8r0BdlMPo7dg//ioNpmVIiKtJZSEcWsRcMJpp3v9ExV7eFivbxy/trmOs3kkj/v
         PuX1lBqA/kgi9rC6m+Gle4R4slzFesqtKXL/UQN6ogRmG1jZE2UfGG0zWjUnImauRmUP
         yKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6mYPEFtq74yMoYOQUwMhY50Nt2rzYW0REDAc2OI3+pA=;
        b=aIu1oy/x3bEb4cjU7s1eGumXIriry4oxQd7EwBeEbEhdlH15pvFzuT1oxrV5GtAtkg
         aGcdbx6KinpzHPGAZY6+xwvCaeaKNHS2J/8RYkLr/QQcgM6JWl/YGY+fzcZLEXSf+i32
         yIp/FMN713NPQ2+jxx/9ywlqA2ubj/GFFsScptaARfpleq8j2WBNuENrXcSwF5y3tnvh
         xNGzpyEv2n6w8Zpucmd9huXuGPtnGKXal1uT+Hs4BSjeV/7K6FlOUK1u/uC4CtT9htls
         6ySGIN5gWAjb9BCKjko+Oavfo3Vqn9lAIxmbpdk6wuwET9cXSBFHH/MCzw2voAW8PwZo
         5/xw==
X-Gm-Message-State: APjAAAX6ThsLiTSDPld0J1VP7EMACMePRvOJXixfZijDLLZ3E5b2KZ6c
        GRAHSPIyyCGXj49c+CjyBl8pt1DE
X-Google-Smtp-Source: APXvYqyxQUtc/N/mGR5ZxXrVY/z9+EsJWS6aK4W+6Sf96XbwbP86mfBpwIaB/dPNrUdMmy6wNxkA3g==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr6844249wmc.22.1560506463602;
        Fri, 14 Jun 2019 03:01:03 -0700 (PDT)
Received: from localhost.localdomain (x4db35d93.dyn.telefonica.de. [77.179.93.147])
        by smtp.gmail.com with ESMTPSA id d3sm1986988wrs.8.2019.06.14.03.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 03:01:02 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC/PATCH v1 0/4] compat/obstack: update from upstream
Date:   Fri, 14 Jun 2019 12:00:55 +0200
Message-Id: <20190614100059.13540-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.589.g5bd7971b91
In-Reply-To: <20190614095308.GG31952@szeder.dev>
References: <20190614095308.GG31952@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update 'compat/obstack.{c,h}' from upstream, because they already use
'size_t' instead of 'long' in places that might eventually end up as
an argument to malloc(), which might solve build errors with GCC 8 on
Windows.

The first patch just imports from upstream and doesn't modify anything
at all, and, consequently, it can't be compiled because of a screenful
or two of errors.  This is bad for future bisects, of course.

OTOH, adding all the necessary build fixes right away makes review
harder...

I'm not sure how to deal with this situation, so here is a series with
the fixes in separate patches for review, for now.  If there's an
agreement that this is the direction to take, then I'll squash in the
fixes in the first patch and touch up the resulting commit message.


Ramsay, could you please run sparse on top of these patch series to
make sure that I caught and converted all "0 instead of NULL" usages
in the last patch?  Thanks.


And here is an all-green build of these patches on Travis CI:

  https://travis-ci.org/szeder/git/builds/545645247

(and one bonus patch on top to deal with some Homebrew nonsense)

SZEDER Gábor (4):
  compat/obstack: update from upstream
  SQUASH??? compat/obstack: fix portability issues
  SQUASH??? compat/obstack: fix build errors with Clang
  compat/obstack: fix some sparse warnings

 compat/obstack.c | 356 ++++++++------------
 compat/obstack.h | 832 ++++++++++++++++++++++++-----------------------
 2 files changed, 572 insertions(+), 616 deletions(-)

-- 
2.22.0.589.g5bd7971b91


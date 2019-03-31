Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D3A20248
	for <e@80x24.org>; Sun, 31 Mar 2019 13:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbfCaNrU (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 09:47:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54764 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfCaNrU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 09:47:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id c1so6231289wml.4
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 06:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Whf53RYajtH1ixHWDQGsRDiopMalC1KjGDtZF302jE=;
        b=JJlHA1X4ktOuiBb5AherJDmrFwv0cAihyymaFn0o55oq9+/RqQxu1Xt//tJQaCaF47
         kUEj6XD8TzdnRfsziJ0ym77iQqopIYrlsCXQ+cqVMBvq8Qbf1PZNCTe+RhD3YbuQ+SWn
         v5iZKiqLH9b4MPfnXjpSirkW9uR5XjX0QSkGlXehySA+QEgMLOtvXTCdnsEaUx47448l
         KRtS+fCueUcRAp4tk9QAUz7x0FtPVPuuiCFNdKAzohJha5FBwZuusH3YI7+r2NwG8bSl
         8U7zjC5Ze+zWT5BwSHEU0UgxDcZZOD0fqQMvy3/IUe/4HfqSNCZhRLuHLHO8aPRYSlxU
         dE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Whf53RYajtH1ixHWDQGsRDiopMalC1KjGDtZF302jE=;
        b=pYFbVqjXjbMMH8DlAPOfdnXd59a18ciosMkn+CJsvlH0quZvK6k+HL2huWlz5HDjIj
         EvLApdvcrIuIwm1XeJqxSYi1E9t4+/NLRn42qPdiNLU2VIIbuRGPAmpxhJVH9C0Rzn5s
         +k7X3X9X4frkixalrqf1nIGVEmnvlufCBmaJhhj2FDVyNeOnwELzySpFxAh/jGY7gXkS
         luUgcDlK2FaG/jK0lZylps9D/KGDcA0bIdMqEouj0wbd0aUVnqMmYmulGiEJEYKpPPwL
         8Wo/bZJAja4ksPfGOUajNOQc4WEsa9epG/O2dFAY4QU5FTijioZZEBOCwEqkSAhPjVzm
         z7OQ==
X-Gm-Message-State: APjAAAXpR+qveRw/IPj8FUU3eeLt+q90BSZ2B+ERmE8iNdo1vCm3+3kC
        pKe4BvujQJ/QkRHtyPppCT4sJR4U
X-Google-Smtp-Source: APXvYqza/drigZHiAcEXG+sGGtG2QGwrhwYRQPokscUvKdwe3YR35KGgH6aw/6U9ch+klwnpHVsl9w==
X-Received: by 2002:a1c:e70b:: with SMTP id e11mr9002331wmh.17.1554040037798;
        Sun, 31 Mar 2019 06:47:17 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10ce:4d96:49c5:28f4:744c:fa99])
        by smtp.gmail.com with ESMTPSA id o10sm10290490wru.54.2019.03.31.06.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 06:47:17 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/4] fix `git replace --graft` tag related issues
Date:   Sun, 31 Mar 2019 15:46:55 +0200
Message-Id: <20190331134659.28808-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.69.g2d86a08d09
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is version 2 of a small patch series to fix tag related issues in
`git replace --graft` that Andreas Schwab reported in:

https://public-inbox.org/git/mvmd0mcsjkf.fsf@suse.de/

The first version of this patch series was:

https://public-inbox.org/git/20190328171722.9753-1-chriscool@tuxfamily.org/

Changes compared to the previous version are the following:

  - patch 4/4 has been added to fix issues when a tag is passed first

  - in patch 2/4 the error message is redirected to a file instead of
    /dev/null as suggested by Ævar after a comment by Eric

  - title of patch 3/4 has been extended with "as parent" to make it
    different from title of patch 4/4

I saw that t6050 has existing 4-space-instead-of-tabs issues, but it
can perhaps be dealt with if some bigger changes are made to this test
script.

Thanks Taylor for the review, and Eric and Ævar for the
comments/suggestions!

Christian Couder (4):
  t6050: use test_line_count instead of wc -l
  t6050: redirect expected error output to a file
  replace: fix --graft when passing a tag as parent
  replace: fix --graft when passing a tag first

 builtin/replace.c  | 20 +++++++++++++-------
 t/t6050-replace.sh | 31 ++++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.21.0.69.g2d86a08d09


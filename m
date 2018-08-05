Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438B41F597
	for <e@80x24.org>; Sun,  5 Aug 2018 02:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbeHEEXt (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 00:23:49 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:32895 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeHEEXt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 00:23:49 -0400
Received: by mail-pf1-f182.google.com with SMTP id d4-v6so5166825pfn.0
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 19:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gVXOS5xujxv/pjLwmpET+8P7fHkgIb0IaJB9DAkWepY=;
        b=oZwUUCLtAidlgzxycyX/EVYc+0IbQyTCdRsRRY1GzVUxFEzUJpHA12ihqUJhtlMG3+
         Ca8rXq/1sAIjklnyTQz75D0NUDe+P1keKgVy/Jynv69vu+JdaFccbd6wYtmGhUp4iqqC
         NIsdJnseYyLVWcTQ2AleNwTHlBti13wKqT+9glpy431o0mPrbbMUd+OQFu89sv8o65ft
         n6hfvd5uJgdQpcM0uYARlobfVK+heYGvpJ8otG2ReNU4VJW+IwQMq/4uoeMCjMaNl4bj
         d5jZo1nMbOE+BU9bvFrBUGnax1fLonKbpJi5DX5nyQ0DOggTZ2aI8hrQrao0Aky09pAX
         VAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gVXOS5xujxv/pjLwmpET+8P7fHkgIb0IaJB9DAkWepY=;
        b=NeFmvD3UweQ7X5zLaHg+24IFeUGla0l1xGCHU+q/gqethRkoWEMCGXRETjBTvOyl92
         8HWwXlycwXQcmRnA5QBZ7+B+5hpn+wYUebyw2pQLJqT7rr6jVLgA7CqyhgY8Sw38VfzG
         DLeqPgpcsfShuQHBabJNn3JkZu5tw+Azx0I6SCrVofO0zvKGtNoWu7moKbQ9xB+GgL0T
         PNqp0hXGE0Mic1NeS6MALNJH2pg4IZcWTp8ELX9xwXR9NbTFRp8S0Yhcl9E1f768ORhD
         F1QzzY6UFafwJuFgS5qp361XxS80sdeehEs7p488HjMtpC0NaBPtpfCMjAuelE2RtLBs
         AuMg==
X-Gm-Message-State: AOUpUlEgZYCdgaoCbNd5C8vkuCW6blUNVa/ahNvjGV1Ijkhgpcq6OhDp
        HOyqKeGZGQ+m13fL8zBBxkbQbQzH
X-Google-Smtp-Source: AAOMgpfkgtCP4th5MiX+oQ8HDxBxvNRYK7IFsfbnOBq8dVhof7+0y9CyQRC7ugg9g19QOK+5GFkiFw==
X-Received: by 2002:a63:4106:: with SMTP id o6-v6mr9599971pga.453.1533435659963;
        Sat, 04 Aug 2018 19:20:59 -0700 (PDT)
Received: from wchargin-t440s.attlocal.net (99-4-123-58.lightspeed.sntcca.sbcglobal.net. [99.4.123.58])
        by smtp.gmail.com with ESMTPSA id m15-v6sm19238289pfj.171.2018.08.04.19.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Aug 2018 19:20:59 -0700 (PDT)
From:   William Chargin <wchargin@gmail.com>
To:     git@vger.kernel.org
Cc:     William Chargin <wchargin@gmail.com>
Subject: [PATCH 0/1] t/test-lib: make `test_dir_is_empty` more robust
Date:   Sat,  4 Aug 2018 19:20:01 -0700
Message-Id: <20180805022002.28907-1-wchargin@gmail.com>
X-Mailer: git-send-email 2.18.0.548.g79b975644
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the `test_dir_is_empty` function appears correct in most normal
use cases, it can fail when filenames contain newlines. I originally
wrote this patch for the standalone Sharness library, but that library
advises that such patches be sent to the Git mailing list first.

William Chargin (1):
  t/test-lib: make `test_dir_is_empty` more robust

 t/t0000-basic.sh        | 29 +++++++++++++++++++++++++++++
 t/test-lib-functions.sh |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.18.0.548.g79b975644


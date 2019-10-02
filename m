Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F25A1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 18:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfJBSFP (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 14:05:15 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43497 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfJBSFP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 14:05:15 -0400
Received: by mail-wr1-f49.google.com with SMTP id q17so41662wrx.10
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 11:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=3ToYIsyLg1sXcNlD9L4IHbxtq1tQE81sEMNOMzkp3F4=;
        b=DKw6T5eMY9FM98Y1IhGkG/TkoE44l2TdJUv0EbzOihgMrY6Cz1hXVF8jJKJfd7kQVf
         KbUnCJgZqv17ul93TXUhp/jn4g66mXeGrskFhIiZpRtxTsMFE9j1RnFlTt464MfyvRpG
         vnHbRIG53+JW+5nP7MoMa1XzAGSlI4AXwcJFcL5NALkbmIShAXwI3ej4ffny5SQMIalI
         0qUjWaUBblZJAvgZ+zqESEBCbpfN1y7PjjJZOHz233XoCdUSJt49FAxH6FcAgtz2u+/l
         BgV2D/zuUD3KofG69ZptWu1n5QbmVnNSDxiwBlaT1XagcaVgo0aRgA6gg763hZ7u2COa
         e+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3ToYIsyLg1sXcNlD9L4IHbxtq1tQE81sEMNOMzkp3F4=;
        b=bNCeu5YohPBwjBiN27JZI/eSISduvcdZp1VxSKRVf0cu1edaH/4VkhNwda5BM3NC+P
         V/Cb/IwP8oJCfG3ikKjuB/YBAYt7xblv8a/EtAZX2Ax8d+Rmr4mpjpUmn1/h8j+U6Jq9
         yOH4lhuYresTzqp8l/2SxoPQ0n7sMBZCSyyMLDDceqC52wFFceebbthzFPOsNQOq0+sS
         k1E4/+eizDw1SrZCX8mMOaocqfBHbriFkJ/Tq0swfweMeaI0ih5Vm+dboKWqPX4aWi6l
         Bl/RwaOgHLY1HhIRP1+JTTKb6wl5oeJjSRBrqhfTwq9o5K24cUiyDX5GkaS8IZuW+lmg
         k7AQ==
X-Gm-Message-State: APjAAAXJEEidqcfO4Bum7NrzgmGSDr8C7WPTdlUJR5BvpN+kSXEiG8dn
        awvAQlsMww+c22mv0XKF542/m99J
X-Google-Smtp-Source: APXvYqzFE0cDt2vHGuwaC0dHYIoH3L1z9xKv5Ld8cQbF7n5XVJnq3+0w3UvsEamVvQk/oPYjO/q5bA==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr3650130wrs.191.1570039513134;
        Wed, 02 Oct 2019 11:05:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t203sm9758489wmf.42.2019.10.02.11.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 11:05:12 -0700 (PDT)
Date:   Wed, 02 Oct 2019 11:05:12 -0700 (PDT)
X-Google-Original-Date: Wed, 02 Oct 2019 18:05:10 GMT
Message-Id: <pull.373.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Avoid segmentation fault in git range-diff when diff.noprefix=true
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This PR was inspired by this bug report: 
https://public-inbox.org/git/20191002141615.GB17916@kitsune.suse.cz/T/#me576615d7a151cf2ed46186c482fbd88f9959914

Johannes Schindelin (1):
  range-diff: internally force `diff.noprefix=false`

 range-diff.c          | 3 ++-
 t/t3206-range-diff.sh | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)


base-commit: bc12974a897308fd3254cf0cc90319078fe45eea
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-373%2Fdscho%2Frange-diff-requires-diff-prefix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-373/dscho/range-diff-requires-diff-prefix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/373
-- 
gitgitgadget

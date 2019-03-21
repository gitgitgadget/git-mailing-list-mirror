Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9279620248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfCUN5f (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:57:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37594 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfCUN5f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:57:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id v21so5085777edq.4
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=IVDgFyT7+l17dVAPJwotAC7pd/ukwjpmcW4Z/q0T2F0=;
        b=fGBmhnVGkOwi5+YEzVfEgczd0WDUwISXS9PSEq/aaRxIgW4rwln763PLbmFe9jk/1d
         O6FlFjE8x87BRMrUQGy/RzPAZao7a1oP5GI2HTFJD77nP0C8MqShQO1/HBRh/ZiEmFm/
         j1SCxAfVyz236996Cr03488lK4BrZv7/BlQuxwZ+CdrZEtnCcTN/zx+MTUyFAMWe1lOQ
         Q0gIPTFCkhv+niOv5UKd0K2wjQHfaBWDZfCkFCXkIOeWZgeeZX62r5pr90yjmg7oXHkk
         WZhscKSuphSdlRPvEIzetUVeXqHSVBWECdol+YEA5WceYSCcJddSjtHi8Q1BJ16JBJJ3
         K2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=IVDgFyT7+l17dVAPJwotAC7pd/ukwjpmcW4Z/q0T2F0=;
        b=iVVihlTspeuOHe76GiBn7pXmV1f+n+IucFRY10Z8raTeansobWEhdHhX1AlOgnR4cF
         kY3OwikN4Wf4rMoREeAO7SxiA61OoDL/gItMp4S7dz2fRJzipIrHpGRVouWR7GSbDNRv
         wcICX2gJLs1k04CfEenLqTufVA6NIwjbVI4UK9kaC2LiKwkKi9q+57JgMiPocD98BBIf
         nqKcxEuqiSja1qPz5PDet2yERGuSAIsrrFbMid8UIgj96z1PIWF1pmuobS6wbdvSG0Eo
         2hGNiPrBdziMaB1KxwhH9DPb2P7PgiYbgaTTZhB2EvfArZoLfdAQ3ZlNYLnkpiSjkfag
         AveA==
X-Gm-Message-State: APjAAAWDGErXZVLsqwQOgcnn8yGWnhu2X01kbDF27kd4FVqLxAgeRq7W
        6XBZLb6tg17K19QRC31/KOk1Zap+
X-Google-Smtp-Source: APXvYqw+UDOuRqtVZIeu6TdOQRaaiaMWLs1LK9cAmCVVTSzOSQ7QHYlHf8Lh1LNQK56J4g3pW/cLIg==
X-Received: by 2002:a50:b36d:: with SMTP id r42mr2671684edd.199.1553176653190;
        Thu, 21 Mar 2019 06:57:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm744999edq.38.2019.03.21.06.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:57:32 -0700 (PDT)
Date:   Thu, 21 Mar 2019 06:57:32 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Mar 2019 13:57:29 GMT
Message-Id: <pull.165.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.165.git.gitgitgadget@gmail.com>
References: <pull.165.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/2] Fix fsmonitor after discard_index()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was reported by Ævar Arnfjörð Bjarmason
[https://public-inbox.org/git/nycvar.QRO.7.76.6.1903142058130.41@tvgsbejvaqbjf.bet/T/#mb8718fe52e4721dacd3b143a09187ff9090ef4e3] 
that there were problems with the fsmonitor feature in conjunction with the
newly built-in git stash/git rebase.

The culprit really is that the fsmonitor flag that says whether it was
queried already was not re-set after discard_index() was called by mistake.

This fixes that, and apparently also other long-standing fsmonitor issues.

(Note that there is still a flakiness around t7519
[https://github.com/git-for-windows/git/pull/2127#pullrequestreview-215010574] 
where it tries to make sure that the fsmonitor hook can prevent unnecessary
lstat() calls, but that seems to be unrelated to this here bug.)

Changes since v1:

 * Removed unnecessary test_when_finished "test_config ..." line, pointed
   out by Hannes Sixt.

Johannes Schindelin (2):
  fsmonitor: demonstrate that it is not refreshed after discard_index()
  fsmonitor: force a refresh after the index was discarded

 cache.h                     |  3 ++-
 fsmonitor.c                 |  5 ++---
 read-cache.c                |  1 +
 t/helper/test-read-cache.c  | 24 +++++++++++++++++++++++-
 t/t7519-status-fsmonitor.sh |  8 ++++++++
 5 files changed, 36 insertions(+), 5 deletions(-)


base-commit: 041f5ea1cf987a4068ef5f39ba0a09be85952064
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-165%2Fdscho%2Ffix-fsmonitor-after-discard-index-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-165/dscho/fix-fsmonitor-after-discard-index-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/165

Range-diff vs v1:

 1:  f451752656 ! 1:  51a7edf22a fsmonitor: demonstrate that it is not refreshed after discard_index()
     @@ -79,8 +79,6 @@
       '
       
      +test_expect_failure 'discard_index() also discards fsmonitor info' '
     -+	test_when_finished \
     -+		"git config core.monitor .git/hooks/fsmonitor-test" &&
      +	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
      +	test_might_fail git update-index --refresh &&
      +	test-tool read-cache --print-and-refresh=tracked 2 >actual &&
 2:  1d62623776 ! 2:  79fdd0d586 fsmonitor: force a refresh after the index was discarded
     @@ -70,6 +70,6 @@
       
      -test_expect_failure 'discard_index() also discards fsmonitor info' '
      +test_expect_success 'discard_index() also discards fsmonitor info' '
     - 	test_when_finished \
     - 		"git config core.monitor .git/hooks/fsmonitor-test" &&
       	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
     + 	test_might_fail git update-index --refresh &&
     + 	test-tool read-cache --print-and-refresh=tracked 2 >actual &&

-- 
gitgitgadget

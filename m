Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369F420248
	for <e@80x24.org>; Sat, 16 Mar 2019 09:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfCPJtI (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 05:49:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41209 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfCPJtI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 05:49:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id a25so2381303edc.8
        for <git@vger.kernel.org>; Sat, 16 Mar 2019 02:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:to:cc;
        bh=ATttJndknWbKUWctOZ/VDGxDtbBPTfYiP8q0VCYEJRY=;
        b=Zj+eXipunW+Pcvsdt2hpsffFfPG4tDc3wOSgER2DW2nvq5t+OMudqTdHUKPUbA3qHM
         +UBawHEwId6UEkHnVlbLWmmXK5a2Mfh1g8y1mgCXMPJDCuBCgUGTvBJbiH2M4pBGSxKV
         twb1ziolc+1erY9NI8N88ZMwr1KHfM+Ou2jjcLJasU9haKLQzP9Db6T00CcFs0Q8OSMy
         19HNbm0Z1mEzUUHidMYu+BVpEEVaqv3dKdR1HO9igkTvITAQoCfhABocWix57Q58s36+
         pIW1fDYGDoFkL7Sl3Lm7xg8X/ggf7ZE1Fdkx75rtZ95tLNhHGJ8g+HKqAdaZ2W8Bew/Z
         xmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=ATttJndknWbKUWctOZ/VDGxDtbBPTfYiP8q0VCYEJRY=;
        b=G5D+IxwR6MA8CQFX7mHYMy9vp8OVVmb9GLsqTb3GEzVvbfoEYZWnTBp2C3Ag89BXbJ
         v1eFlWz+lVeGEgr0X0Q7REwMNA/Ee9S4vqS4nvr+XHeJ0be8Z+t+gIpLGjd59YlDXa/D
         7iJzTHmRsPP/B8BJBgj0AIpUF+Fba0HncMeOHut/pt1zc9EdgI6YY9tXTdgAhOlPaCsE
         wtMq7kD9FTk5Brgjnogq/H/2yU2uitsKDN+YgJO7M0jc5Kajoscl2xLlbjws8DvSGQxK
         DF9vChDf6VKlACbRjoUftx/4ggh+4nCubjpqQDg1JPky5VSM6w9w2/BrPUCXtTRaUAbE
         weNQ==
X-Gm-Message-State: APjAAAWun9KG/EV8p7UQTbpobapYcFiWrWe8fooM0rcJIz8B/xdVWb+f
        lIV1spzrjg8JHRfTnWpwWVzI7AUl
X-Google-Smtp-Source: APXvYqxsrGx+oTUqwbYqJsdFfaZ5jNBlDT+NvZFl4CP7whMt/BVRGHLpNWQd7U02NgQXJgtTpQqpPg==
X-Received: by 2002:a17:906:b7c2:: with SMTP id fy2mr4987849ejb.9.1552729746396;
        Sat, 16 Mar 2019 02:49:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm1400151edr.47.2019.03.16.02.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 02:49:05 -0700 (PDT)
Date:   Sat, 16 Mar 2019 02:49:05 -0700 (PDT)
X-Google-Original-Date: Sat, 16 Mar 2019 09:49:03 GMT
Message-Id: <pull.165.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] Fix fsmonitor after discard_index()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
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

Johannes Schindelin (2):
  fsmonitor: demonstrate that it is not refreshed after discard_index()
  fsmonitor: force a refresh after the index was discarded

 cache.h                     |  3 ++-
 fsmonitor.c                 |  5 ++---
 read-cache.c                |  1 +
 t/helper/test-read-cache.c  | 24 +++++++++++++++++++++++-
 t/t7519-status-fsmonitor.sh | 10 ++++++++++
 5 files changed, 38 insertions(+), 5 deletions(-)


base-commit: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-165%2Fdscho%2Ffix-fsmonitor-after-discard-index-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-165/dscho/fix-fsmonitor-after-discard-index-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/165
-- 
gitgitgadget

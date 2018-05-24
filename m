Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C061F51C
	for <e@80x24.org>; Thu, 24 May 2018 07:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeEXHEs (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 03:04:48 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35762 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbeEXHEr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 03:04:47 -0400
Received: by mail-oi0-f68.google.com with SMTP id a6-v6so529613oia.2
        for <git@vger.kernel.org>; Thu, 24 May 2018 00:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rjDLiFhRIpeAbFGTplGnCAiBdbOtouPS+VqR+cIFs5o=;
        b=jMZyy51CHnkXpou+aXI96A+R+i8rNJfvSVwrluGeKHZ9CcE5fRoEvDRtaYfZXn4eG8
         KnOrajp1YsGzN1MLokuyvBHr9OkYncnyKPwqsiT1pSLaKuuNFFIZMePuNNM6Xccj/Y0s
         OyTgZ4Db8IjQ6oSDFQOZN//GvOZcCw1xbjnPHY+XFof2k6ALwJclIu3q66hzHSXeXbVO
         41JKJIrka76y317SnJ8+JmV0RaT8fz+Qyb37RE/0rL9QOp3OxiSWPJ1tR0+z8o6gPKbu
         ciOcPvS34mosTZYgbr6Q09JQx4z3e7eD08X4OUiwS94TlVIwJHZ1Fo70pksYHuTDuEVv
         VAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rjDLiFhRIpeAbFGTplGnCAiBdbOtouPS+VqR+cIFs5o=;
        b=V8AKoCfovaoTdhSn9AZn4xCv7kSGa1tiG0Jy7ryji2PXXBNq7MFiPAfkoQsUqffkT7
         vQFiq1bZfFKnSZb2eckhI0VKGPB3UsSe6+LHPzcQbyg199et2OF6UfjvfcDeb/0uVPSZ
         +a/8j6KnZZMhuTqGnNWyWUEnzM5MqhFDqPKLRDWPdcmDWIS7UEgiSOuqOR6fvhnzdsBy
         RSJTuNZp2EgJoebCeXp4ftXCiOk087R1ualUL2QX2tSRjvVol6dvbLvdH5IOx3KE53se
         RC3rkVS0xTUl8y6Z0U9ZqJIhZFPQfHkxHXTSM/OZJdUmrnlJIp96HVEj9uLWRNytOnLK
         PpMw==
X-Gm-Message-State: ALKqPwcoJEyI6yGhrUg/rSWUauBH6kaCxxN4fNCp6BhmTrQmsWto2b5S
        /kHmP7Kzeigx6R8/CvKjboCRdw==
X-Google-Smtp-Source: AB8JxZrpmWBcmNqyalFHxUARokJD6w79cKppCDsa/X4cmjhkACeKSH0FP672oZ7Zg1tRwQYEclqHJQ==
X-Received: by 2002:aca:e848:: with SMTP id f69-v6mr3441492oih.192.1527145486645;
        Thu, 24 May 2018 00:04:46 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id q75-v6sm12076244ota.69.2018.05.24.00.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 00:04:45 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/5] Modernize some testcases for merge-recursive corner cases
Date:   Thu, 24 May 2018 00:04:34 -0700
Message-Id: <20180524070439.6367-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.1.gda85003413
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have about a dozen more testcases I want to add to the testsuite, in
order to document additional situations that merge-recursive handles
suboptimally.  To avoid sending an excessively long series, I am splitting
this up.  This series just aims to modernize a pair of testfiles in which
several of the new tests would most naturally belong.  This modernization
serves two purposes: (1) it makes the existing tests easier to understand,
and (2) it simplifies adding more tests to these test files.

Elijah Newren (5):
  t6036, t6042: use test_create_repo to keep tests independent
  t6036, t6042: use test_line_count instead of wc -l
  t6036, t6042: prefer test_path_is_file, test_path_is_missing
  t6036, t6042: prefer test_cmp to sequences of test
  t6036: prefer test_when_finished to manual cleanup in following test

 t/t6036-recursive-corner-cases.sh    | 991 +++++++++++++++------------
 t/t6042-merge-rename-corner-cases.sh | 968 ++++++++++++++------------
 2 files changed, 1098 insertions(+), 861 deletions(-)

-- 
2.17.0.1.gda85003413


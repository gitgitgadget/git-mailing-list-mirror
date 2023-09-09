Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7105EE14C3
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 23:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjIIXDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 19:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbjIIXDM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 19:03:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870641AA
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 16:03:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2937494f8f.0
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694300587; x=1694905387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6De4r55GiAQBRNromTuu3SheOK3pkxmGvzgEH/FWBTo=;
        b=Vz0cEdxqfwns75IjZXt+jLzWLOF5kgZ6YfeZqfOX2nZiHEf+C2MbufNy3gQTeaAadL
         C/7nv4BWLsUEbpQ0pb6guXNGsLS+VJDxSpqZegBL7eKw9fB2lhamdb3MdCmRdSVrgInd
         53S4sxadns1hhpfsh+bje9oFrM51sQzkmtnF1rMpSks8JDKbrzqTamInM4Ik6JtHd7zH
         95uSnUXU1kzzMsvRyD/hnux16uB71X5tKHIs2xvj4trxSjp+ezbyyb5x7tefEA0yOHx/
         6v/j82xQdu9gYO6py2J0drmzkQBrUtljfP5WhXvWIVG9xzdpF9RofZhHj8PckrbtlFM0
         HMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694300587; x=1694905387;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6De4r55GiAQBRNromTuu3SheOK3pkxmGvzgEH/FWBTo=;
        b=RCPnBelQMfFxOyD+35qR24fGlvkAZmioNSC6ZOOWT3m9IeE++uDWV0/IZj7GFdMJ4a
         Nty9Jo+wlmxGQKBsjE7+PDB5501hfB0Sd1vDVx+1J6GlXr58duVV+qW4HK7iBlnAYb2o
         4XNQVlwYShJuTBoeVmeVWUTvc6JqybZVx4nEby8DJKiZRTe7qekYZtvLVde13fNH94Q7
         FQ1qmRt6jIhecG1DK6YYlGTPznU2Dbr0YJtS+I8hSiY2VD/KpSlhLIpNq2msdTpqreul
         bSqbMIJm5Es6g/YJ5/H3h+ZxCZDvzUUMKA85bLBb4h37brcRG/LIXG4h5RDLMnjnzGes
         suuQ==
X-Gm-Message-State: AOJu0Yye9iGUVAsSjC448mssu/ZLnCY3v27XhNSEoE18byOSkSFWXtR6
        wCwbpN7nq79QS/tPwwUsi9w=
X-Google-Smtp-Source: AGHT+IFtR+TNwdGghYeictR3BNr2ssmwmg3Jed2FhhCGBrNSWIEtDO1PEUMDmuif9I90WXCJouPDcg==
X-Received: by 2002:a5d:69c3:0:b0:319:74b5:b67d with SMTP id s3-20020a5d69c3000000b0031974b5b67dmr4799261wrw.66.1694300586815;
        Sat, 09 Sep 2023 16:03:06 -0700 (PDT)
Received: from [192.168.2.52] (16.red-88-14-199.dynamicip.rima-tde.net. [88.14.199.16])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d60cf000000b00317a04131c5sm5868890wrt.57.2023.09.09.16.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 16:03:06 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH 0/2] fix GIT_TEST_SANITIZE_LEAK_LOG=true
Message-ID: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
Date:   Sun, 10 Sep 2023 01:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While using "make test" I noticed that invert_exit_code used by
GIT_TEST_SANITIZE_LEAK_LOG=true produces unexpected results.

   $ git checkout v2.40.1 
   $ make test SANITIZE=leak T=t3200-branch.sh # fails
   $ make test SANITIZE=leak GIT_TEST_SANITIZE_LEAK_LOG=true T=t3200-branch.sh # succeeds


Rubén Justo (2):
  test-lib: prevent misuses of --invert-exit-code
  test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG

 t/test-lib.sh | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.40.1


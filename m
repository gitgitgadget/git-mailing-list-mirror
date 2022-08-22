Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38D2C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 15:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiHVPYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 11:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiHVPYA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 11:24:00 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C22541D39
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:19:14 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w197so12570414oie.5
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=/F53e0Tk6ZlVMbvWHDZnNXflVh2/mPkZXhk+oNdBgPk=;
        b=Dy0e6E4V4XVcuCKFeiThxQxgcYFm06LRLoyc9xETl398B7dMIRU1TnwyDhYJJAERrS
         +11lTVlNaalcYfvEciOTFMAgc04STC8N5NQo4PSuOL1F4NEgLO1hYVlEtuz/4f8SEUID
         NPghKMwpirxTg6fHuasvciQcw87m7WQTiiXPs9v1Ob4ny163O3gotnwqJnUTdp0CGzGh
         Lsut/fCAEbz+By4zNRulUzkOO5MGlfK2vngomH6em11bSzosj8i6qi4RzOL3VHQxNZAO
         oEThZlMXNVP5T3eB90FsOILC0N8jby6vx5pnV3pnZc2koUQ98lz8YrwR5G4ZAu7p7cqR
         dLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=/F53e0Tk6ZlVMbvWHDZnNXflVh2/mPkZXhk+oNdBgPk=;
        b=ot4B5XvRiQSJoSf/iqooDEnGZCg3TRTnfqoSEUujb7SkHHe10kcrjuAEJlVMccCTf3
         aBu4xsNzCSHN/5ewZ4C13iqu0B49L9s1oha3Jm7VFVksihwuc3qF/PRU/lE9SFcMQCSJ
         czHm0QlD22d1C76pNQDa0CIiu8Iz5vdTKqUqUi5CjP5mwMMnQK6UA+m5+tcDAH4cxLh8
         LhIKRzSqsmmqyAFjxgJT48CWVmUEGRTvn/OfBv4eIsusk1jofrhoLJNIYYUkKLJvMVSx
         fli6eekWpjb+3hwNLB1xIfSAFMRukv/cNExDi+CoHmULNYjNjTDzyObWWJAC0MDjxXON
         FTew==
X-Gm-Message-State: ACgBeo2zPcoy/c3D5tr9ATZe2W3tZLE8glUt81C9Wrl4FZ7XmeKTif6V
        6KY8SsDx4JQraNtNntvtVNfbLAcidUtlca5+yiJzum9Pv3HX+Tyus6huWEtWpXflAq9cjYxT/Ij
        +QccUhddx2ybhUrE6PbpviEGwL1rkHi+2AZLJZ8q2W3PLbe6pVb2LcPcoMjJgJLrX14t/iQ==
X-Google-Smtp-Source: AA6agR57H6XlaBMlnOXJ693+kAbhVZ++41fR0nDGqfpL7Xz3tDwam58wlE8ssfFAxQxv7TuEY2tiwQ==
X-Received: by 2002:a05:6808:211d:b0:344:dbf1:be8f with SMTP id r29-20020a056808211d00b00344dbf1be8fmr11682612oiw.169.1661181552837;
        Mon, 22 Aug 2022 08:19:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5550:8912:9500:397a? ([2600:1700:e72:80a0:5550:8912:9500:397a])
        by smtp.gmail.com with ESMTPSA id n16-20020a056870035000b0011c8c2c9020sm2993319oaf.33.2022.08.22.08.19.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 08:19:12 -0700 (PDT)
Message-ID: <eb8779bc-fc41-f601-05f2-024e6bf3f316@github.com>
Date:   Mon, 22 Aug 2022 11:19:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Derrick Stolee <derrickstolee@github.com>
Subject: [Question] How to fix 'static-analysis' build on Ubuntu 20.04
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While preparing my latest series, I noticed that the GitHub Actions CI
builds were cancelling the 'static-analysis' job because of a brownout of
Ubuntu 18.04. We are recommended to upgrade to 20.04.

However, we explicitly chose 18.04 in d051ed77ee6
(.github/workflows/main.yml: run static-analysis on bionic, 2021-02-08)
because coccinelle was not available in 20.04. It still isn't available
since I tried the basic update and it failed [1]

[1] https://github.com/gitgitgadget/git/runs/7955077955?check_suite_focus=true#step:3:98

Does anyone have an idea of how to install coccinelle on this newer
version? Should we try compiling it from source for this job? Should we
consider moving off of coccinelle and onto a different tool?

Thanks,
-Stolee

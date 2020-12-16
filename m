Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D513BC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AACC12335A
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 14:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgLPORJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLPORJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 09:17:09 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4FCC061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:16:29 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id q6so4947354ooo.8
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 06:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ddhP47pPe3w2PclJdPrh2jkyoLz31B1wG/q1KcjrFug=;
        b=PQR4/IOoSJFT7NvFV+qlxIqbJ69ZhCHxln77hWhAIK+/lzedgyvfVhDXo5Qey1cMfO
         yMqcg72Kb+EHS30Jx3dQvnXFW1rrIDnZ4OL0XPXH5+vtDkziY1w5yKaFIIa9/kpwWt5B
         VUfGTwD35OsM6yoDHZFFrykxcbMtrWMo3CmU8qNXbS2huqh4SDCKsE7KC4iJSv5/YMqQ
         3XZe01ie2XIYXwQBm0lXjcUz6/x1bmMGCFUPyWHMZZiohVEqOAZ5ZQmTECpA3AinCYcd
         X3p+V7GyJN1K45zaJAdoLV2XPWX3N/pK+IzPbtyisSqf3JttjrnJyR6UQ3i+PeBwCMBL
         A+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ddhP47pPe3w2PclJdPrh2jkyoLz31B1wG/q1KcjrFug=;
        b=jdtcL4iDPoRi/ENJWxDEBVvsdCA1hrj7gnKwkBQBP0sOzhZd9BNbBGPVulbGEdnMiJ
         f5JHI1FGD0ZdUZMFTpQHaiS3heD/W3szMOBxzPHOqfFzALKPa4JOKji+6n98gqqeeCy6
         EpS8GrM3TwJoEQl86t4sxvoKCnINL92p+CJIO9naAMiv0YOJ7T7Y7y+6Y2XJ30VXJfPT
         21AJ6RFjDrd+7su7VJscVCoF4YIHkqAQtv1qATY1pSHJJU4YrZpfg5xB4cKGv1vbr23f
         Xi0H1jVkjsxTtF4ayDfxhARVPGrsIeJfyXMNSMuxzV/jfh8OyRA+W1rg6EHFyF8VQXVY
         Sq6A==
X-Gm-Message-State: AOAM533621F0353h80EKNyZuB6wTySRBSevR5ty4RmPBVah+cLHLKgtZ
        HDjjTjjc/KJTt7x9yBG2Bmq3YnV3Aeh95X3FyRBE6rKMSFBmoQ==
X-Google-Smtp-Source: ABdhPJwusUVmAGDNKzwad0Cj9FNE7Q88xv0J6CXT5udO5kHkHa7C86CLYyhspljt1PxhAGDF01t/Y4rgYAg6L6gCoDI=
X-Received: by 2002:a4a:6c45:: with SMTP id u5mr9867862oof.61.1608128188716;
 Wed, 16 Dec 2020 06:16:28 -0800 (PST)
MIME-Version: 1.0
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 16 Dec 2020 19:46:17 +0530
Message-ID: <CAPSFM5dYovETwQEoeyRiUjotsV7XL=0qSOR01sCWiqpeP23fjg@mail.gmail.com>
Subject: [Outreachy] Project blog -2
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone !

This is the second blog post regarding updates on  the project and my learnings.
https://charvi-077.github.io/week2-progress/

Please let me know if you have any feedback or suggestions.

Thanks and Regards,
Charvi.

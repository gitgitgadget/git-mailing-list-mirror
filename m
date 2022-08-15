Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CD5C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 07:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbiHOHFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 03:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiHOHFE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 03:05:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3511C90F
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 00:05:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so6064975pjl.0
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 00:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=WPFmyejHBYIcQ2pVXbb1JcGX3q7HdWIWvbIUjGKBzbc=;
        b=isU3keFAlHZBPqv59iz6V9YwvHeKdFfH0q5SNHlCyplslXUYIGrE1TZeDegIRhNkbn
         YJJjUfpjE60lATNE677qkITdXBYrhg4xLRqrC21Ip3oboHdPg3O4iKXnThEnrj2fQPcg
         vJ/Z1FC6NlbTIkkthtXcNduG5ZnoqqXZ8QLK9uJFHQSxjwNNURRA9fMn//iD3BsXOXnR
         a0lgAl/IWA5hzrUVeAknzCh0+RzgTzW7HYLAL9xSxZ4/V/BAB1UEyZzAPyxv7jDDLCPy
         3T8ILTcR2tStkQDIcnQOfkELF7xCJArVsQ7MX83pb/djzx44uplKl4e3wMCSXSwK9RN2
         3VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=WPFmyejHBYIcQ2pVXbb1JcGX3q7HdWIWvbIUjGKBzbc=;
        b=MUCiLWnO/NapbeRRKITA5BOVVP9/ssznBAw8ilYOYi2z1/irrD/SEUTgaMRIfR3bTP
         vc557HKo9ccQIPe5l+IFAkNHCMSFuBc4gukwKtrMYmZ1bo3Ww1Cpoq/TZm9lbYJ939ns
         Tq49PZbR8O/a1rBTGfVWpc+r3M8nkQZaHtl/uwZ8RS4zQMpfK/H04LZwYevIpLYtqNCr
         Kr4MbtB7W55QACZIyAaMb3xzDgZgMkgaXeFKxVjWCXQusnxULfF5lpvMq7NIOt/g0aeH
         xtF/Wyy3wxB6xTgWHX/SsLVK6YRRz1DE8GvYLGJoVjmAfAIHUmyURnABAvEigBVKwCJ7
         aXPA==
X-Gm-Message-State: ACgBeo1KVx9u80huvYKl/WSq12olgtQF76JDs9T7R24j1EnSl41xL8gj
        ItNs0nyIRiYmDY1sKx7tLSOX0F0Jcq0=
X-Google-Smtp-Source: AA6agR53tHLfHeGTTt0fzKJdkMeZWk3pIhqDh32P7+mTOotdf4GXnNzRO8T9gpLnVKJ7r7lGGyD4oA==
X-Received: by 2002:a17:90a:e7c2:b0:1f5:85ab:938c with SMTP id kb2-20020a17090ae7c200b001f585ab938cmr27265574pjb.133.1660547102766;
        Mon, 15 Aug 2022 00:05:02 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:6e1f:625:2cf7:b814:95c1:a907])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b0016d8d277c02sm4161474plh.25.2022.08.15.00.04.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Aug 2022 00:05:02 -0700 (PDT)
From:   Abhra303 <chakrabortyabhradeep79@gmail.com>
To:     Git <git@vger.kernel.org>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: Fixing midx bitmap related racy test failure (under sha-256)
Date:   Mon, 15 Aug 2022 12:34:46 +0530
Message-Id: <20220815070446.4990-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Hello developers,

I have been writing a patch series[1] to integrate a lookup table extension
to .bitmap file. I reformatted the test code so that I can run the same
tests for the lookup table extension. But this is causing a failure in a midx
bitmap related test case[2]. It is not related to my code because this
can be produced with out my changes.

If you see the test file[3] (with my changes) and also observe the test
results[4], you'll notice that the said test case is always failing on the 
second `test_midx_bitmap_cases` call under sha-256 only. This is racy in nature.
I.e. it might pass after executing the test 2 or 3 times.

I have been trying to solve the issue for one or two week but as I am not
very clear about the internal working of multi-pack-index or repacking, I
am still not able to solve the issue. Besides, my semester exam is starting
from 18 Aug. So I have to give a significant amount of time to studies.

So, it will be very helpful if anyone help me to find out the solution.
You can know more from this thread[5].

Thanks :)

[1] https://lore.kernel.org/git/pull.1266.git.1655728395.gitgitgadget@gmail.com/
[2] https://github.com/Abhra303/git/blob/b460516b306e6885cd1c0af1c3379fb953952de2/t/lib-bitmap.sh#L195
[3] https://github.com/Abhra303/git/blob/bitmap-commit-table/t/t5326-multi-pack-bitmaps.sh
[4] https://github.com/Abhra303/git/runs/7827604510?check_suite_focus=true
[5] https://lore.kernel.org/git/p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr/#t

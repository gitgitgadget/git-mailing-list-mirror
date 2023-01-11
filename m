Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F42AC5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 23:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbjAKXcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 18:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjAKXct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 18:32:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0545834D4D
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 15:32:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w1so16539601wrt.8
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 15:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHcYesznQ1+NgIqJeedEs689owyBw/V6pBwf5+qeZTw=;
        b=pRR4wiIFEsTpMPCDxoh+PvlWLGsxIDSFDouEYWGZfv7z7LV1H4SyTs/RZ25sLs4plv
         +40wLXVwV5sGve/+ye0vC6SFNC3+hGEwAhHRxQV8gj5/uKnD+JmQZoUxWHt4NfPk3fyr
         Ua4u/09B+NsORQcNKXqz6rY0UFWo8NdufIr0eNlXsewEMGZrDhdJESAR0ntuy5KNvQL/
         oNqY8CuBgY7qREMUnckz+4UrCPeTPEHakLcd5/euyT5LpNIEm0+bqlHeSRcvudOmYka4
         FkFwuLFYZ0JHqVC7iYj/egueAHwIpzQybxkUFRkkLMtCXCo+kWemgCzcbeX3CmYUxhMQ
         8CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHcYesznQ1+NgIqJeedEs689owyBw/V6pBwf5+qeZTw=;
        b=dD9rgNudC0svl9wDg1mPu6Eeceem1bXSWFyXtQyo21E1BxMNkD1W4n1sIWKyny02be
         NKrCGrNeYqFDfS/tCAQDiQr0IimzcDsw7kp3p72vrOpF0nUXWk5e7A5fIM+ggFTONbhV
         dIsAnYPljfeCFx8OgrLKPqI1Gxh642sudB4JLUbLWBG7TkO8NuSEg1GDthEAQW3TBJNc
         guj7YDMtJ/BrIg5WfSnT1UhXIrspO/0sFqHekli1sWekzokFDJRCAeswly6rDCIwwMBh
         9aCiLTT8JwByf8VXWAfB3ZwxNwp/yUt6EWt1VxjIOLI7uvLKL9iZRfdILb/ludLH/rrv
         5yRw==
X-Gm-Message-State: AFqh2krRVkzBiP9VDEUoeVoOIdHrWuiT2/ZQqWaIuTF1h8hybcyYif5W
        wzHooQPnVOTIu1/2Gksf1j1EZsrsPJsZf7xg5/A=
X-Google-Smtp-Source: AMrXdXtTPj/7wyQuyI6NAUfAkrSroHbeYHmh4bGUvP6GGUfOIN4KMAqUn+RchGTPQGolM/bnN0KOXw==
X-Received: by 2002:adf:e303:0:b0:242:1926:783c with SMTP id b3-20020adfe303000000b002421926783cmr46592169wrj.58.1673479965213;
        Wed, 11 Jan 2023 15:32:45 -0800 (PST)
Received: from titov.fritz.box ([212.102.57.19])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm7679308wrw.29.2023.01.11.15.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 15:32:44 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Tim Schumacher <timschumi@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH v1 0/3] fixes for commented out code in tests (was "Re: [PATCH] *: fix typos which duplicate a word")
Date:   Thu, 12 Jan 2023 00:32:39 +0100
Message-Id: <20230111233242.16870-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: CAPig+cTgUPWxMox_nSka52dML6_GHUUoY4HCtcq7+7J0oEyeNw@mail.gmail.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ I apologize for some people getting this twice -- I messed up when
  invoking `git send-email` ]

On 2023-01-06T19:25, Eric Sunshine wrote:
> Not related to your patch at all, but I notice in this test that the
> call to test_when_finished() is commented out:
> 
>     # test_when_finished "stop_daemon_delete_repo test_insensitive" &&
> 
> which makes me wonder if it was commented out while the test was being
> debugged but then forgotten, and that the script is now potentially
> leaking a running daemon if something in the test fails after the
> daemon was started, or if the daemon does not shut down on its own as
> it's supposed to do. [cc:+Jeff Hostetler]

Here's a patch series that fixes some of the commented out test code.

I skipped changing the following:

1. a minute-long test_expect_failure is commented out in t0014-alias.sh .
   Technically, this could be uncommented and marked with `EXPENSIVE`
   prerequisite, but it doesn't seem worth it for a `test_expect_failure`.
   [ cc Tim Schumacher, who added this test in fef5f7fc43 (t0014: introduce an
   alias testing suite, 2018-09-16) ]

2. In t6426-merge-skip-unneeded-updates.sh, second part of the test '2c: Modify
   b & add c VS rename b->c' is commented out with an explicit "# FIXME:
   rename/add conflicts are horribly broken right now;" above the commented out
   part.
   [ cc Elijah Newren, author of c04ba51739 (t6046: testcases checking whether
   updates can be skipped in a merge, 2018-04-19) ]

3. I've experimented a bit with commented out test in file
   t9200-git-cvsexportcommit.sh.  Tests in this file rely on state from previous
   tests, which complicates more thorough investigation.  Unfortunately,  I
   didn't have bandwidth to investigate this further.
   [ cc Robin Rosenberg, who added it in fe142b3a45 (Rework cvsexportcommit to
   handle binary files for all cases., 2006-11-12) and commented out in
   e86ad71fe5 (Make cvsexportcommit work with filenames with spaces and
   non-ascii characters., 2006-12-11) ]

I found these places in tests with:

    git grep -P '^\s*[#]\s*test_' -- 't/t[0-9]*'

The rest of the results of this grep are documentation comments.

Andrei Rybak (3):
  t6003: uncomment test '--max-age=c3, --topo-order'
  t6422: drop commented out code
  t7527: uncomment test_when_finished step in a test

 t/t6003-rev-list-topo-order.sh       | 23 ++++++++++-------------
 t/t6422-merge-rename-corner-cases.sh |  2 --
 t/t7527-builtin-fsmonitor.sh         |  2 +-
 3 files changed, 11 insertions(+), 16 deletions(-)

-- 
2.39.0


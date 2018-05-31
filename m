Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222681F51C
	for <e@80x24.org>; Thu, 31 May 2018 11:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754455AbeEaLDT (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 07:03:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55587 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754441AbeEaLDR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 07:03:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id a8-v6so53219452wmg.5
        for <git@vger.kernel.org>; Thu, 31 May 2018 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsZOo3dE5FAh2VyEW1cecSShmCxufrFbbXAKLVHvfsQ=;
        b=FAKsrXlsCCrpLklVQ37EOvWROiR18r4GnSQ7/BBOxbKmX6y743fpqdowqrMCq37JIR
         cnjRJM1FaXT0EXV6fMdGOHljETMVVGuKmxeJGL/HRjOYtXXQ49ljsrWKekoQugxH0tMH
         XCtrPwG/npaYTf3qZch2w5xldy7Y5nv2txskK8C614lxyHpBn/cwpmFXG+2e8YYLr6aW
         0F5lr9qwG5imaEIZc43WIyreu2Fg7yghbRzeqioXfUetXY3ESevVIEvgkwzI0Fk/OoVf
         HAPPjhwuEzb7tVZHOCz45zh2fT/ET1kSQxDjddgg7TINLT330GIHRw9U6DJjVDyrSKOq
         LN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lsZOo3dE5FAh2VyEW1cecSShmCxufrFbbXAKLVHvfsQ=;
        b=thaj1Ys9KHy2Jz6VYfNs77lYw+lCxfVzGB8la7IscWRU93iEqZsf4e5fc1aIbY6Icl
         pFJQdh5wZjEnBrfpkDHgtk0hpJH5A9yTlCf+Dgyvj9gJDkeIFo/QYX9r5qNoyFCVFs15
         hR8T7IPnuqp6bau9no+aTk1AymmK40xFBMBPEZYyVqT4XOaym9JscPMp8CCEIWMIrADD
         kQocIjGMpEg6bDi3BwUjDNEqfVE7p/Gi7G0z8Acyb9hdjFpw7S3ERs2LzEwTL77dv6J0
         CNvl19xdH+m9se75mXxngNx8mS6zSCP3JaYkSdIz3m7XUicay5PCGtAM4Dx0yx+4tVL/
         D87Q==
X-Gm-Message-State: ALKqPwf3DMUg9t1Y0mBg7rgxQ4VjVV3zymIBwJTrXbbhG17tDSM2rpt2
        q57yTk4/yogEKSbFq/0DUFbwaMfa
X-Google-Smtp-Source: ADUXVKKMlytR8PsFPIwPVEZnkW2c1pGwNuLy2gsYsxvmaNIpz1PecTEkZctIEREogHlsp1WN+2qR+g==
X-Received: by 2002:aa7:d819:: with SMTP id v25-v6mr7686512edq.61.1527764596652;
        Thu, 31 May 2018 04:03:16 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-184-117.w86-199.abo.wanadoo.fr. [86.199.39.117])
        by smtp.googlemail.com with ESMTPSA id f2-v6sm5887419edq.28.2018.05.31.04.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 04:03:15 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 0/2] rebase -i: rewrite append_todo_help() in C
Date:   Thu, 31 May 2018 13:01:28 +0200
Message-Id: <20180531110130.18839-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series rewrites append_todo_help() from shell to C. This is part
of the effort to rewrite interactive rebase in C.

The first commit rewrites append_todo_help() in C (the C version
covers a bit more than the old shell version), adds some parameters to
rebase--helper, etc.

The second one strips newlines from append_todo_help() messages, which
require to update the translations. This change was advised to me by
Stefan Beller, but Johannes Schindelin voiced concerns. I don’t really
have a strong opinion about it, so feel free to give yours.

Alban Gruin (2):
  rebase--interactive: rewrite append_todo_help() in C
  sequencer: remove newlines from append_todo_help() messages

 builtin/rebase--helper.c   | 10 ++++++--
 git-rebase--interactive.sh | 52 ++-----------------------------------
 sequencer.c                | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  1 +
 4 files changed, 75 insertions(+), 52 deletions(-)

-- 
2.16.4


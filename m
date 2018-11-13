Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA22F1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 12:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732894AbeKMWgX (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 17:36:23 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:44971 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732736AbeKMWgX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 17:36:23 -0500
Received: by mail-pg1-f170.google.com with SMTP id w3-v6so5623998pgs.11
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 04:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=9O8+MCZ6278eyPZsQccKDqP7+WO1pyKMHIaduXkJigM=;
        b=KMNpPXD/eGNr83vvaL1k9/1Mu1W5QjIepQfKjjJ/GaBSEZhy+S/Cs4KcdgvpUA0Tfx
         tMkeiCcKep42bTrKiynCs2tyEp38DGrqpcUjFz7PXWOIGeaGXg0FsEWLMC/YFVTpOaea
         n2XNlply6Q8FfCFH/MKg0upxmyrdLI49J1KobszzwnM8uFbG7BqJkLUGSr8PrdQnO4Hu
         F/tNgHWPGjNMBTzydtW46k/9wYSZmXvDKjeZGgLkjTYZuI/7rjWrxR3ivIF4CEE4nQfg
         UZcZ+BVPohGXhd/fYL+EKoauySc4uP8TPzpeC3SFSVpJWRNH8ldqf0UkN/GG//AoraYt
         5J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9O8+MCZ6278eyPZsQccKDqP7+WO1pyKMHIaduXkJigM=;
        b=q1NirhaMFDyGSHR394op0f5ecsITT64d3PzmW5LSgk1XG1WkyydLTVoK9bHK2eykVE
         qnD8+/2aGgPHeM1zNXLn+bQYgkXn3clyfo4xWZA0K6BTZhCbpShfaqs8ZLrrNmduYKYc
         D6WsJctp7vDVqg7nNzcbNqIPzOFpDeNdqt4pvDEuB64WE+EPJp4nDgvTbLpM9tqSzQ+o
         MIKed8lS/pu78QRN6KXN8HSXzEyD9VFb05ITXEDFGykjGBbv4iTT1YeRoGrvopYRu2re
         kgsX3xfc5t/KThLe6aZ5n0ZY541OSmIRYH1VygnnhTh8AT2/+ACo4Teri39UjGVkaRnq
         SQpA==
X-Gm-Message-State: AGRZ1gKsajC60yp4xtMHM4ah4VUlhhb3H9eFMoKmnL8YSNwxm1WThP9/
        NPxMdmvHTz2LKYa+5nKiW/QnwbF6
X-Google-Smtp-Source: AJdET5fCyk5tmHRttaGhTsHoOXNKAsI9i+ndhAGyGKGIRNrzlYfZVL6YVbFIrgorRjgyEmCzEorgvQ==
X-Received: by 2002:a62:2c16:: with SMTP id s22-v6mr4947318pfs.6.1542112705665;
        Tue, 13 Nov 2018 04:38:25 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id o86-v6sm24223182pfk.8.2018.11.13.04.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 04:38:24 -0800 (PST)
Date:   Tue, 13 Nov 2018 04:38:24 -0800 (PST)
X-Google-Original-Date: Tue, 13 Nov 2018 12:38:21 GMT
Message-Id: <pull.76.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] rebase: understand -C again, refactor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood reported a problem where the built-in rebase did not understand
options like -C1, i.e. it did not expect the option argument.

While investigating how to address this best, I stumbled upon 
OPT_PASSTHRU_ARGV (which I was so far happily unaware of).

Instead of just fixing the -C<n> bug, I decided to simply convert all of the
options intended for git am (or, eventually, for git apply). This happens to
fix that bug, and does so much more: it simplifies the entire logic (and
removes more lines than it adds).

Johannes Schindelin (1):
  rebase: really just passthru the `git am` options

 builtin/rebase.c | 98 +++++++++++++++++-------------------------------
 1 file changed, 35 insertions(+), 63 deletions(-)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-76%2Fdscho%2Frebase-Cn-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-76/dscho/rebase-Cn-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/76
-- 
gitgitgadget

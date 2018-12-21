Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76D91F405
	for <e@80x24.org>; Fri, 21 Dec 2018 11:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbeLULcW (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 06:32:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45316 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730504AbeLULcV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 06:32:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so4370070edb.12
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 03:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=YZS7yWn6YxKAV6wmNhvq3lWn/wbupak7DeS4Stt3eSw=;
        b=vKyiQKNJJuEs/rccosHPJQQx8lnhuj5uNptEp1SJoSp7auLUc2eq2ippEODmMGk7qF
         bq5Z+j78FWs+c7hpBroNQA7J3SXRpkoJUUFZzcqBswTeZVcUUwmekyMtb7Ac12/ygI9U
         rYt7dxrhgtL6z1laeUZuqmr0e5JBkaZKa1xRNMRPyqRmngTKhIhfXyuitAgvVA6PVO7b
         M/6Z8F2LIIu1RBEPz6xV5/hLHrsfTOsNgZQs8LQNG332SPh6bWfyQJMfNEBJ3Rp1ePoH
         3ebZo+xZllLb3lEhZZR1RkZOAez6krJmEziBOd3US2V+GTRUpV+OXqfBPBgsUyHaTJDp
         BFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YZS7yWn6YxKAV6wmNhvq3lWn/wbupak7DeS4Stt3eSw=;
        b=FgwIRhI53LbHziPPtQTEhz/v56oGPM7S1VB98PYye7VYmnDSSW/qChLvEDNxGDtckT
         7DZHewiifK8r8jJeTnMVnMAqqXDPMk3TGI2Gr5PTpc31VBfPCd/sA8J7czLsOtJz4BVl
         GTPUTHX1g3xJbBYofFg2y25M5KxiHgfi8K+FjBqEE90ZytCzQ0WlJR9s8beBeVazDQ64
         /ec2JNY0Q9aoqtymIC8KzfY8iFMQJN1pBshdMIFdAR2qrf24fWMy9B20tcrLk5CSccCX
         AmjeRKxUzuS2FqA0Ulmtay7pKZz3q9IkDUrTonhnKW12dnd+Bg2xU/siyIoVhHda1w7D
         ioTg==
X-Gm-Message-State: AA+aEWZbkzbstkQa8B+U6uHBwEcQS0yJS5lIvIsI8J7/UYc8siLkIeRu
        PRfAxghKBmiMWUaCJ7rybeeeKpYZAcZD3hvj
X-Google-Smtp-Source: AFSGD/VGJXv7c4jNwb7IJ15oJ7GznZ/6vVlIuVCLg8p1UUbzt19ywvpwjPwni9zT4KJvkb4ECKp9Dg==
X-Received: by 2002:a50:ad55:: with SMTP id z21mr2098728edc.74.1545391940125;
        Fri, 21 Dec 2018 03:32:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j23sm6633826edr.89.2018.12.21.03.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 03:32:19 -0800 (PST)
Date:   Fri, 21 Dec 2018 03:32:19 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 11:32:18 GMT
Message-Id: <pull.104.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Make abspath() aware of case-insensitive filesystems
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is completely legitimate these days to call git add with absolute paths.
Of course, on a case-insensitive file system, users rightfully expect the
argument to be handled case-insensitively, too. This patch makes it so.

Git for Windows carried this patch for over one and a half years already, I
think it is time to get it into git.git.

Johannes Schindelin (1):
  abspath_part_inside_repo: respect core.fileMode

 setup.c        | 6 +++---
 t/t3700-add.sh | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)


base-commit: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-104%2Fdscho%2Fcase-insensitive-abspath-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-104/dscho/case-insensitive-abspath-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/104
-- 
gitgitgadget

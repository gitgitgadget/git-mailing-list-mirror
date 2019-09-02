Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B154C1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 14:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfIBOBn (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 10:01:43 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45924 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfIBOBn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 10:01:43 -0400
Received: by mail-wr1-f53.google.com with SMTP id q12so14108798wrj.12
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=awGAYGwDW7JB9AcIC7XaB9DGXFlMoA6yK05sEbuLZhM=;
        b=WJ+TRgJv/jFCgh1CsbD0ofbHFGEirRZpzO32ihm+hXH88+0wR2yoXTx6Ia2PIsr7BB
         6lpLEVQJdr5Ps7OTKZ6n9mfwfmoI89kNuis9RC/dGyljcqyoiQ16Aj6s0m0K1yKW6AvJ
         Wepz1EOVtKSP2IAAS6zOeBvadYN/vu8MRfjfJgW4OWFS+JLNmnMshbSoORFxlKpuGy+p
         LsD3ONjSKsxcq3NmDKOvGCdWZc73rTFaBtnZwkB0DyYUo1CxzlGLw+hnIDreQ/q0SzdC
         9e68yd85A4DsJbKidf1swYtRsop2Dyb28pj8Udg0dR+EZw2Nb4X15CjDG5eiBGjbzfoR
         IEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=awGAYGwDW7JB9AcIC7XaB9DGXFlMoA6yK05sEbuLZhM=;
        b=IrX4mig4EuYp375W7vcADJ6lPYoOhXBcQPKfkOa279/S61dDggKoffF+Q2DKq0dQ1b
         sp245eQf95nhyeVoftdkj76GRGGsocQLmzuZ7dIx1ZVFRcjSTAc3EEnTTBekBVV//j4B
         JQWQiKXoOByO7QfDHKe5Fuoh+wyF2eqzWZjRFtwhIXpte2lSzyPzt3eFF74uSP3cwahe
         xauuQFlwM61G/qBMwkoEdOs4clUNvfxtQec5p2mjyHJCazWFuvOQ54ABBic+4g1+1jG1
         ZpTZRBt6Hb+uwILhRuio1LOomjA1D9o+qcvXwCYKsXucDqJ4rMiQL4HkS5wIpp4jqL9O
         wOsQ==
X-Gm-Message-State: APjAAAV3FKOFBpbdgw9x6BSgJcD6xTYmWEwz1OEKNoeh9LmjiOxOBtnE
        Zc6b2yeztH3SNBOMjPtNBYT8GhpX
X-Google-Smtp-Source: APXvYqzXMobX2OB6P3YpMywMTdJafRaFZB10tFchuAO0Ln0FIpVzaktRpKBckmQ3zb3tfmOFP62Vgg==
X-Received: by 2002:adf:9b9d:: with SMTP id d29mr17474055wrc.132.1567432901265;
        Mon, 02 Sep 2019 07:01:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1sm52684350wrg.80.2019.09.02.07.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 07:01:40 -0700 (PDT)
Date:   Mon, 02 Sep 2019 07:01:40 -0700 (PDT)
X-Google-Original-Date: Mon, 02 Sep 2019 14:01:38 GMT
Message-Id: <pull.327.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Make git rebase -r's label generation more resilient
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Those labels must be valid ref names, and therefore valid file names.

This just came in via Git for Windows.

Matt R (1):
  rebase -r: let `label` generate safer labels

 sequencer.c              | 12 +++++++++++-
 t/t3430-rebase-merges.sh |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-327%2Fdscho%2Ffix-rebase-r-labels-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-327/dscho/fix-rebase-r-labels-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/327
-- 
gitgitgadget

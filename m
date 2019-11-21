Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4771AC432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 14:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A4E206B6
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 14:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDgs7sZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfKUOGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:06:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46827 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfKUOGY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 09:06:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so1142710wrl.13
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 06:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=T4bh6WP66iiIAWSYCK9sPcVUCcdaO9VJ6Iz83U1nB+g=;
        b=cDgs7sZXKFpHbur0OViZr0PyknqiuASufCQ4sady5iUajDS6MUDkkdSDf2r/hI01wO
         F4Bs1OWEp+jU2TZSRQ5jXp2WatQfxj593XSj8zdbz5acr/xYglnU110J227A+JZUqqld
         PU6DuqfWoAGARPMRFARhGaAl6Yaop7Sn/LhMuBEFQgzLXxshRmW9P+jYQkHoImbfq1M5
         qWCWdbyqXOik/OA+kf+WzsXYHzAmA00e8PpIFxAKp3bo5oJXrxJf3y+B7k/m+jFo4IQa
         j5LP4Kg1peGOhBmGloPWIAFmEWcTwcj9DpItJK9MEybDi9a/cHWXbhRSj3YWmZDfvJvT
         8BMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T4bh6WP66iiIAWSYCK9sPcVUCcdaO9VJ6Iz83U1nB+g=;
        b=shd34G8P5LceNNtdM0hKjLUnz9xDCb5zblKt4Q6AUi3LRLGOOeYPDmWIKN83wJevoR
         xdp5NjC8zmOuC+Cl2qdDOK01lLfvSLyQaruA7iTPXYSUn4gpWg+JuJmQ7775kc2uAGOg
         1+273eGGxFSB67LIHRXGRxPUMZWE7B58YtG1hwULj/6TPCuEyLbkcwAzkBGe+DZB+EQ/
         2mLsnWqh1NfRIdGVsWqtbrZ1JQt1AD41/cXKf1p12mRhigZh6B8RcqK5pwqheSXr9aR4
         exCZfJ9fn0i66Cagsc3AoYueFj931Nw6Mzc972Owz6SuK5Z2AUou7aAmWO/KEYLYbJza
         82ag==
X-Gm-Message-State: APjAAAWoALJvDm2E3cB68lvAJddbKKnTH933RhZZtYnxnvdwPrbtMSQw
        wEX3t0kQcpiEGeo9iMaAg6FwijiT
X-Google-Smtp-Source: APXvYqzpkuORKBMluKmotYg+gAa2Eyb7SI61TtdCdBkL9rcKo+U4knRIrlPXY8y7y7AtHirk/rVW2Q==
X-Received: by 2002:adf:f010:: with SMTP id j16mr11230694wro.206.1574345182324;
        Thu, 21 Nov 2019 06:06:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f188sm2929557wmf.3.2019.11.21.06.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 06:06:21 -0800 (PST)
Message-Id: <pull.467.git.1574345181.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 14:06:20 +0000
Subject: [PATCH 0/1] sequencer: fix empty commit check when amending
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

I noticed this while adding some tests for a re-roll of
js/advise-rebase-skip

This patch is based on pw/post-commit-from-sequencer

Phillip Wood (1):
  sequencer: fix empty commit check when amending

 sequencer.c            | 24 +++++++++++++++++++-----
 t/t3403-rebase-skip.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 5 deletions(-)


base-commit: 4627bc777e9ade5e3a85d6b8e8630fc4b6e2f8f6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-467%2Fphillipwood%2Fwip%2Frebase-fix-empty-commit-check-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-467/phillipwood/wip/rebase-fix-empty-commit-check-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/467
-- 
gitgitgadget
